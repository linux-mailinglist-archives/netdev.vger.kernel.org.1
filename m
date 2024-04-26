Return-Path: <netdev+bounces-91774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 789768B3DAC
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 19:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA49AB23C1D
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F915B0FB;
	Fri, 26 Apr 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dfqvuQcE"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E6148842
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151713; cv=none; b=Kd+4QKy32MrPRhBopvFbvSp8pRRSlVbZ27yIsDqtdhN733xJygx4Yaj6mHL81T8J/iijcnYUwwcog4gPhtXvoeQo7sOuUvknSPXkTwkIyz8Dh60p5A+0kjKkohbuPrhkL3T+nM6HWugT9ipoRzO/rceg2w/tLzPcRk7TZ+ie34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151713; c=relaxed/simple;
	bh=cUVKhYIO27DoSHceS0qy0+2FUb0ZjxWvs7XQYIcpFS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ant4IQhta/3xqZGZeQJijxazk2Ty8uOQ6OKVdML/9gk4LrwHLRYAthevrRa4tEJXV7KyvAG4Oojr/WBTlPelmdKnU7rmiXRiR9ap3WqL+yehh83jwNNs8p/mNZi7ySuPqudsff3aB5O5gxjbmZ6CRXes7XTeIwYsVqHfkurwTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dfqvuQcE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=m4G8nHzQIXCHO1y8p4LPoi+zqr2MAifzLs+fYjo9zpE=; b=dfqvuQcEnWC+1Ka5P7W34aMx1I
	SgfipMEBewsRWdhlWJ/Uu0YeHnwY+gt+obbQXckdtKxh2ex8+UyUgCNS1nnIei7KNFwZeUmZQ96nt
	f51+pwdKwN1wk9UQd6Z95sty6wW+xr7Yq4VtFpuwXaiBCfSF2L7VGHU6pSJHudcgMUuLvuTog34nG
	tL9WE/U0odLpIThOIY+7lJ7kUUNKj8s+UlSPd1StTMgcxe/BVtFSpXrfYid8dFb1439HQ+NABernk
	0ly6VPW2uQJfhO0MC/3oIqOfWLivf1GyfyFfczD76D1xS9HeR8zFm90tyOz7gw09J0RGDVCBppp7K
	jSlJ2h5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0PAB-00000005ezT-1Zdf;
	Fri, 26 Apr 2024 17:15:07 +0000
Date: Fri, 26 Apr 2024 18:15:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org, netdev@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Arjun Roy <arjunroy@google.com>
Subject: [RFC] Make find_tcp_vma() more efficient
Message-ID: <ZivhG0yrbpFqORDw@casper.infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Liam asked me if we could do away with the "bool *mmap_locked"
parameter, and the problem is that some architctures don't support
CONFIG_PER_VMA_LOCK yet.  But we can abstract it ... something like this
maybe?

(not particularly proposing this for inclusion; just wrote it and want
to get it out of my tree so I can get back to other projects.  If anyone
wants it, they can test it and submit it for inclusion and stick my
S-o-B on it)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..570763351508 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -779,11 +779,22 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
 struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 					  unsigned long address);
 
+static inline void lock_vma_under_mmap_lock(struct vm_area_struct *vma)
+{
+	down_read(&vma->vm_lock->lock);
+	mmap_read_unlock(vma->vm_mm);
+}
+
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline bool vma_start_read(struct vm_area_struct *vma)
 		{ return false; }
-static inline void vma_end_read(struct vm_area_struct *vma) {}
+static inline void vma_end_read(struct vm_area_struct *vma)
+{
+	mmap_read_unlock(vma->vm_mm);
+}
+
+static inline void lock_vma_under_mmap_lock(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 		{ mmap_assert_write_locked(vma->vm_mm); }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f23b97777ea5..e763916e5185 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2051,27 +2051,25 @@ static void tcp_zc_finalize_rx_tstamp(struct sock *sk,
 }
 
 static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
-					   unsigned long address,
-					   bool *mmap_locked)
+					   unsigned long address)
 {
 	struct vm_area_struct *vma = lock_vma_under_rcu(mm, address);
 
-	if (vma) {
-		if (vma->vm_ops != &tcp_vm_ops) {
-			vma_end_read(vma);
+	if (!vma) {
+		mmap_read_lock(mm);
+		vma = vma_lookup(mm, address);
+		if (vma) {
+			lock_vma_under_mmap_lock(vma);
+		} else {
+			mmap_read_unlock(mm);
 			return NULL;
 		}
-		*mmap_locked = false;
-		return vma;
 	}
-
-	mmap_read_lock(mm);
-	vma = vma_lookup(mm, address);
-	if (!vma || vma->vm_ops != &tcp_vm_ops) {
-		mmap_read_unlock(mm);
+	if (vma->vm_ops != &tcp_vm_ops) {
+		vma_end_read(vma);
 		return NULL;
 	}
-	*mmap_locked = true;
+
 	return vma;
 }
 
@@ -2092,7 +2090,6 @@ static int tcp_zerocopy_receive(struct sock *sk,
 	u32 seq = tp->copied_seq;
 	u32 total_bytes_to_map;
 	int inq = tcp_inq(sk);
-	bool mmap_locked;
 	int ret;
 
 	zc->copybuf_len = 0;
@@ -2117,7 +2114,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
 		return 0;
 	}
 
-	vma = find_tcp_vma(current->mm, address, &mmap_locked);
+	vma = find_tcp_vma(current->mm, address);
 	if (!vma)
 		return -EINVAL;
 
@@ -2194,10 +2191,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
 						   zc, total_bytes_to_map);
 	}
 out:
-	if (mmap_locked)
-		mmap_read_unlock(current->mm);
-	else
-		vma_end_read(vma);
+	vma_end_read(vma);
 	/* Try to copy straggler data. */
 	if (!ret)
 		copylen = tcp_zc_handle_leftover(zc, sk, skb, &seq, copybuf_len, tss);

