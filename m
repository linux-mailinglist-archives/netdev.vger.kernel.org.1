Return-Path: <netdev+bounces-279689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ+FBP7j5WkupAEAu9opvQ
	(envelope-from <netdev+bounces-279689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:29:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8360A428235
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B5AB300957E
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70687388364;
	Mon, 20 Apr 2026 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llCMoSkS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DB8388E58
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673732; cv=none; b=MycGEmayJvUB7jByxpMaavdo2vPyui54q4gPeAjwFliC2uEgYpdzywqO3PKJv2S7y8A48QkD5UtyoOCXhIZOdULZ599DHmyza+0gO65zPAhVuti5bvxZTd+PG8WMG1JN0SZJtQ2yDBATds99aToKRaK6E+yKyzu7iRYEGY727/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673732; c=relaxed/simple;
	bh=hJPzdZOuMsoyrJKQrdHDjL0cVhaVCo6hPwt7Cfu3dJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxR4io1YW/mI6wFopTESdLq9LSblbOVKiosot+QillsMcdWyN2NExk8oa+FV6QU3Nv8qoXir2TH0H85B0T2DPK9yPejDOrZRlCsGiremZQRqLU8r0bkv5oH4/Y452b/yhCmgmGr52sifTdEXi4pfbS6OUkF631wLvsSssG5gSd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llCMoSkS; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso92752a12.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673730; x=1777278530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkG8E1zHoS9yZo95EX95fxtMt7Mzto22+gCUnK2C29A=;
        b=llCMoSkSuBZ3ckhkYakv/padf1dBph3eLQD7Lr9u0lBGzpVk3YFOytkPJjr658AReC
         +NV03XdoWkmMvJ04mnXUQckVdYaNpBkz18L8l+b/0KUm12xn6pMlCMY6YD5cbGXkMzs3
         At+NQQvGva+SjG67IEfVkH6WWcddC0gy0KqZuR3L1P8MsFKootdDqDUW6YzCtayMtMJ5
         RwswlGbAsb2bU3LkehsPFuesC6H8TiUkGNYgPt9X7d5skjtbIvSVqBFJ+eZ+Len7SlSm
         B/ifbCZkbg943O9k28rPw9TSJzq4V1ayKE064KcUtYPUaE9TnujSstU9eNncGG+ROQ+s
         NirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673730; x=1777278530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkG8E1zHoS9yZo95EX95fxtMt7Mzto22+gCUnK2C29A=;
        b=QVz7rtBUTfT83Zx0jkEPZ60SnRyxBhKj+f9BC56NDul8GIZaja8cJx04weJQ+Uhpc+
         bBEwMgkUiEBWbFrjd0svsgJG4S4FM94sPsiirM+KUucs28BYYjGnOuif5Exp6rs3cVQJ
         OGDru2HshSQC6cfF5LU20pODD3Gbq08xJDiBG+UNOuAaf5XAralEgR5LXd4RsJB+0rXa
         Xsg3NkwLA7Mud0zVsZVN5KTh1NLtk1WzBbfqswvDOndXlIoTUXGtvufQWTkt6HX+773z
         dzELW3iQT6O7xhBGPMkwE+UFxKseMDtOSx5+AVakDlTAuKRum0DDzNfKOJ2OjwWhpE0B
         yH3w==
X-Forwarded-Encrypted: i=1; AFNElJ+WwohXLKmzECvGLdLBfmTm9uSeh6W5xcg7yxEWZtozog5OyLp993DH+Y58PdZoUQHAfJj7kmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSOiFqwkvKarNgaNyDMJN9XB58+DAg/RSZ8vodAR8eE6y04B7t
	MkRmVfAPFI18Upu0O0HlTp6HuV/9+bXDxMmuwIHXwhT+dwtGozKkM6id
X-Gm-Gg: AeBDieu9G1J7SO1jtNWUeQZOhwGgyJ2z6KokcDFclBy+8aPPtjnoMRdM0fo2aln9R9f
	LClP1xo2UtChuwReEPFjMzqgC62BfEo9i62ZBnzWufuDHVeWmG6S3Mb8NX61wGFbw4cKsE2SPfI
	gmRd4AiqLaAIlYm3U4VPm6nqi8NnMV0NvtEwGqB4e0ART9Zsj3lHUeVWU1uiY7ijYeFgKoiB/cU
	54EFeTUj/jsXSR2qSYyRRPHFWl4fsOfJltn0f6EOX7rqp86fGSGqMp4+W98MYhMe6ZGQt7KTZ5v
	r6ZOdNZxcjAIW0zNxkm/oqkJn5K3xhNERMFZwrSs1GRPfBIjlOnMT9jIVpZ5r/zg2+zQ4BQwHAX
	esDJXnC7OLNM10U2AosH+6iHx58hdmHSRaPcpDdvbUbzdFOufcsbn8c7cQtUP3pIWFjnL8ADkdk
	2d01QATDTaziExsrcNUHLziB41Gm5dgmeeM/u9MSHK7TigtwHPX4Y1T6MkGbkR1vuzvXvhwm0od
	bMGoIRuCq9I0gAb+Xc=
X-Received: by 2002:a05:6300:218a:b0:39f:94cb:1bc with SMTP id adf61e73a8af0-3a08d687dbamr13637730637.1.1776673729610;
        Mon, 20 Apr 2026 01:28:49 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:48 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 7/8] xsk: fix xsk_addrs slab leak on multi-buffer error path
Date: Mon, 20 Apr 2026 16:28:04 +0800
Message-Id: <20260420082805.14844-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279689-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.974];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8360A428235
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

When xsk_build_skb() / xsk_build_skb_zerocopy() sees the first
continuation descriptor, it promotes destructor_arg from an inlined
address to a freshly allocated xsk_addrs (num_descs = 1). The counter
is bumped to >= 2 only at the very end of a successful build (by calling
xsk_inc_num_desc()).

If the build fails in between (e.g. alloc_page() returns NULL with
-EAGAIN, or the MAX_SKB_FRAGS overflow hits), we jump to free_err, skip
calling xsk_inc_num_desc() to increment num_descs and leave the half-built
skb attached to xs->skb for the app to retry. The skb now has
1) destructor_arg = a real xsk_addrs pointer,
2) num_descs = 1

If the app never retries and just close()s the socket, xsk_release()
calls xsk_drop_skb() -> xsk_consume_skb(), which decides whether to
free xsk_addrs by testing num_descs > 1:

    if (unlikely(num_descs > 1))
        kmem_cache_free(xsk_tx_generic_cache, destructor_arg);

Because num_descs is exactly 1 the branch is skipped and the
xsk_addrs object is leaked to the xsk_tx_generic_cache slab.

Fix it by directly testing if destructor_arg is still addr. Or else it
is modified and used to store the newly allocated memory from
xsk_tx_generic_cache regardless of increment of num_desc, which we
need to handle.

Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9236ec32b54a..6b17974ca825 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -605,7 +605,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 	spin_lock_irqsave(&pool->cq_prod_lock, flags);
 	idx = xskq_get_prod(pool->cq);
 
-	if (unlikely(num_descs > 1)) {
+	if (unlikely(!xsk_skb_destructor_is_addr(skb))) {
 		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
 
 		for (i = 0; i < num_descs; i++) {
@@ -660,7 +660,7 @@ static void xsk_consume_skb(struct sk_buff *skb)
 	u32 num_descs = xsk_get_num_desc(skb);
 	struct xsk_addrs *xsk_addr;
 
-	if (unlikely(num_descs > 1)) {
+	if (unlikely(!xsk_skb_destructor_is_addr(skb))) {
 		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
 		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
 	}
-- 
2.41.3


