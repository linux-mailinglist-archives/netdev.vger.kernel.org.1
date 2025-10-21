Return-Path: <netdev+bounces-231154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F337BF5BAE
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F182E1890852
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AA032038D;
	Tue, 21 Oct 2025 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBoS2JS5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF602ED84C
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041789; cv=none; b=Cm5rORsu2GKmCjqOa4cA5HlpVI6ouxdQxJWRWa9OFkYX7BSo6qvm93UaFzqR1xRYkj49bnyZDgIgwHKA5uYIu1gRAevrAMF8853Eaoe6dPhldG5bmLzFB1wmrbIdd2/gXFgtHYkGqTbA/7aGGLjVpNaRyRgM1OKsb0Ngr0OA/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041789; c=relaxed/simple;
	bh=K8Bt1F4duKaYZD6FM5I3/3n7I5nh0OjMrdkO6KPZNLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=St1xhu4tC7tCcMsD287qyMnih4KrkDUuW4B+H6V3TJub+5r25+/uhHm6HaXaNR7AcCSu0rccJdKjLvhB/tLcMWmr6UMO78ua8D5m7U23jKidrPICl5hGpY7r5aJ48pLI5uP7Rl1rIBe300b4dzTnYimlPZauBqg4/Avb32/9U9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBoS2JS5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761041786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJYhMYYkH+gP1AV8KxmcpA9zINZajsuC9HdWMXBqSjE=;
	b=VBoS2JS5SuqhMXXfOpkEdciHIfiQDmXXYEHikyq4vT6T1dBgyUm8tnASku7egtuCMRGD5T
	KPJSwckLvtOguHA7idMKNPYw1qbjVxPcFkBI6z8KORnABeoe93rqH4jBLYSfEbcNE5DZYZ
	RzulxnnuQGepq23NiVoajb3ZPMFEplQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-yPB-aFkMMqKaBPNNjx_gkQ-1; Tue, 21 Oct 2025 06:16:25 -0400
X-MC-Unique: yPB-aFkMMqKaBPNNjx_gkQ-1
X-Mimecast-MFC-AGG-ID: yPB-aFkMMqKaBPNNjx_gkQ_1761041784
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471168953bdso38965095e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041781; x=1761646581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJYhMYYkH+gP1AV8KxmcpA9zINZajsuC9HdWMXBqSjE=;
        b=tAOne1HlzaF2PMgOeIq/tpAzexRVdj5XPBB8XbJ5CahNW3V15aLcUS9u8qXTxn9vVr
         BX7ySR3dZVkVZkH9qVhf8xanCbpZC50wgGIUS0TcZioqkLNFyMgO5Rhhxqhb1Aaf6SUf
         cxPI1rVidopgcrNXyw/6nYfH+rlWHDrQWhv2XlcuM4+kmehKw8622Q8ANrS2yc5RrYWj
         qYvqQ4si0BWP1NV03tcroi5QxuaeUxicXs9GCOAjPy4cGySKOnFcdAhii5RLP92Q/zoC
         snUa6rkgaAj+Gi60isRvc9tsmeCnFfW4RNLzuEBbl6+JcmHPGYBeYcZ3bVzPsKtCxaaD
         l4kA==
X-Forwarded-Encrypted: i=1; AJvYcCUUMPuqyK691su+NQFzlgkzfovg6mqMh5Mrs35rcMdatQ+fWckoLIqXFS9p1R99lvZxmNl+enY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWI7CRsQqNF3H2bdoqMX6pcg0OFIZpIcFgRRh4tDivl0NDwTeN
	q1V24moxesuJ1+Yz/QRYve6/7QKcwxMecg4YIJa8RlX4rsKroFI3MW/TVk+4ycB7R+TkZ/j6U5m
	tkP/JegONF+XDiNNnjxqQPa4hhddBMQK2//mExM2ehHJWR+7dCktn7I+NgA==
X-Gm-Gg: ASbGncvdbWtvj0SSx6kL+ErDGDoU9lxxrrQpr2jb7dYbJGtTQsqhrlluYXb3zkx/B9e
	sf1rDDcI6LJAQSrvh7In6uXHSWHmI8puQu2EN5nzCIq9H1KPUaLIsxreOzS/BakgBta/n2+gr8W
	WyjpIQNvnk7cy5intO4iMOH3QCFi1MvIbtI2+1/iQfTYbmAl2gaIYwyHvsxrcBkNHF03iUTxBz7
	vk8hczYeV7nD3fZv6TEQLxoXP4tRL6PCos2E1I6J/D89cl75OL4izh1Iq0hLfdzIBqrQuqJNBGO
	oQfptLoIPVMctcIrSwXxZzvHk2Ho4zY7U25AMTYTEZ6/2LqOChp/Cbq2QK0SzOvTs30eWXn6MnW
	FiLx7IySZ5WzpDRxDX3wQZcdFrM64bBBvzVgDBzZXMmnShbm1ag8=
X-Received: by 2002:a05:600c:a088:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-47117315d8emr128167585e9.16.1761041780844;
        Tue, 21 Oct 2025 03:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi58yEM3Ci3GlIQ7LRsfZT8Jz32v9v6BKO98V35kuEXc5OOA/pGgs/FK9jj1Yuy4hgaCi++g==
X-Received: by 2002:a05:600c:a088:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-47117315d8emr128167295e9.16.1761041780382;
        Tue, 21 Oct 2025 03:16:20 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c82c9sm272580385e9.14.2025.10.21.03.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:16:19 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:16:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
Message-ID: <u6mwe4gtor7cgqece6ctyabmlxcaxn7t2yk7k3xivifwxreu65@z5tjmfkoami7>
References: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ixrysslziegqmao6"
Content-Disposition: inline
In-Reply-To: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>


--ixrysslziegqmao6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Oct 20, 2025 at 05:02:56PM -0700, syzbot wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
>git tree:       upstream
>console output: https://syzkaller.appspot.com/x/log.txt?x=130983cd980000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
>dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
>compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f0f52f980000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ea9734580000

#syz test


--ixrysslziegqmao6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-TODO.patch"

From c32c21ea301aadc56160a57ddcd99f836a49f028 Mon Sep 17 00:00:00 2001
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Oct 2025 12:12:24 +0200
Subject: [PATCH] TODO

From: Stefano Garzarella <sgarzare@redhat.com>

---
 net/vmw_vsock/af_vsock.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4c2db6cca557..5434fe6a1d6b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -565,6 +565,11 @@ static u32 vsock_registered_transport_cid(const struct vsock_transport **transpo
 	return cid;
 }
 
+/* vsock_find_cid() must be called outside lock_sock/release_sock
+ * section to avoid a potential lock inversion deadlock with
+ * vsock_assign_transport() where `vsock_register_mutex` is taken when
+ * `sk_lock-AF_VSOCK` is already held.
+ */
 bool vsock_find_cid(unsigned int cid)
 {
 	if (cid == vsock_registered_transport_cid(&transport_g2h))
@@ -735,23 +740,14 @@ static int __vsock_bind_dgram(struct vsock_sock *vsk,
 	return vsk->transport->dgram_bind(vsk, addr);
 }
 
+/* The caller must ensure the socket is not already bound and provide a valid
+ * `addr` to bind (VMADDR_CID_ANY, or a CID assgined to a transport).
+ */
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
 	int retval;
 
-	/* First ensure this socket isn't already bound. */
-	if (vsock_addr_bound(&vsk->local_addr))
-		return -EINVAL;
-
-	/* Now bind to the provided address or select appropriate values if
-	 * none are provided (VMADDR_CID_ANY and VMADDR_PORT_ANY).  Note that
-	 * like AF_INET prevents binding to a non-local IP address (in most
-	 * cases), we only allow binding to a local CID.
-	 */
-	if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
-		return -EADDRNOTAVAIL;
-
 	switch (sk->sk_socket->type) {
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
@@ -991,15 +987,33 @@ vsock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 {
 	int err;
 	struct sock *sk;
+	struct vsock_sock *vsk;
 	struct sockaddr_vm *vm_addr;
 
 	sk = sock->sk;
+	vsk = vsock_sk(sk);
 
 	if (vsock_addr_cast(addr, addr_len, &vm_addr) != 0)
 		return -EINVAL;
 
+	/* Like AF_INET prevents binding to a non-local IP address (in most
+	 * cases), we only allow binding to a local CID.
+	 */
+	if (vm_addr->svm_cid != VMADDR_CID_ANY &&
+	    !vsock_find_cid(vm_addr->svm_cid))
+		return -EADDRNOTAVAIL;
+
 	lock_sock(sk);
+
+	/* Ensure this socket isn't already bound. */
+	if (vsock_addr_bound(&vsk->local_addr)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = __vsock_bind(sk, vm_addr);
+
+out:
 	release_sock(sk);
 
 	return err;
-- 
2.51.0


--ixrysslziegqmao6--


