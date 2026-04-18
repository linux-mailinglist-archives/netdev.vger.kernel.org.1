Return-Path: <netdev+bounces-279466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PsBJUEP42kuBwEAu9opvQ
	(envelope-from <netdev+bounces-279466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:57:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6976641FF9C
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBEF0300B473
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200852EBB9E;
	Sat, 18 Apr 2026 04:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGVGQEx4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA4219301
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 04:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776488241; cv=none; b=RBm1eLTrOFOwuqYt+X8iHK4gsRWU8uF5DvALtnOMPQT1mOswdJffjik2UE0kLWXEeQun4IkgmD3Jwg5CoV0BwqtuAo8hJvV40olC/dSPvn6RTJ7WYGkJnImo6aGqTLsjjFTWGUKb4OxRavyv26iDbe7uxMFwtJbbiB5/4SOMzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776488241; c=relaxed/simple;
	bh=dScuvfHSx2J0xfD/1KNmlZxr1BZbYBHGYWf1vTYdj10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XtpMz7Epv4S/FkcnHIthzUHd84aArYTSS1D8wDafpjRorfdpAbL9tQCsWMnrY4X5VlWwgS5f8z6eTS9r17dYjb6UMudj6lEK38PUdGpzQeXLRe01OU2V07cT1vYFGbvLFFMk/Pam2lb/O1lHIHBRrkhKyBr86IRt88ln3Pcx1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGVGQEx4; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35fb166b0c6so1276146a91.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776488239; x=1777093039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwiOwC2HPJ2+KxMqshI4D9/LD5MVKo0WgUCuW5jJwyY=;
        b=LGVGQEx4gVZZvaDwnhujW+jHILDV0EzApvg72okn5LBQUAvy9X0P9c/fwmV+bGEf5M
         z0ioM/eOVzZG4WXbGxxjDP5GlQs9R6l6j0lwREQxKAsamChw5kofGzddZjJ02rMOi0EW
         hu1xtIcczQ6jIrbAhga6FU47O/VYsaVqVAGc9k8xRl1XRQd1u1WY9IkK7AoHmKodIjxn
         b4+3UJ5/tk+EXdkvFRYuYWvyicfqgB1jTBcvAp2jVqeTuYCqj31fZfSdzKD6V/hTIQ8D
         T8LxG1SwDCKMEhaAPOusMeMnkNbhfCqUlkb9oBuVWdJF3ghwm8gXkQw7745NsO8P+InN
         hc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776488239; x=1777093039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DwiOwC2HPJ2+KxMqshI4D9/LD5MVKo0WgUCuW5jJwyY=;
        b=KR9hb3Yd/Mt/ug/FA48I6mdqoW/H5yzS9usUmuHCmAvLcE2EqwAdycrI22P+y6lU7S
         pwlQ9IZVDnp80qWnR6iCUB9YYtoTtTUY2zXmRseY4rG7/dMTfjt+JI9Kaqx+WSG3TTEG
         PKH6hM9RAcWXnixS16q9bQjqMToasWUbI6CLxnF9MAxQHj2nsZtemHnBCzyPYh9ONcWS
         aBVgFhDdMKPL1IgDBcqnhFPbOG+tzzU9ZeLgchspMrNNsrwyO6tvlkqMyAVvN9p6JNzl
         4TdZi5269DWNCJBESlPVA0QfjRiWaOkOH4qEnfdBtCPCy3Lwqiif2H3ZGnYQxfO7cABL
         qvew==
X-Forwarded-Encrypted: i=1; AFNElJ9v0CrGKR96sdOgaNcrnXF3FOCj38o9V9bLND4G+Sr0rpPyfPK2ZTe9wS/tu8xkRkI844dDegw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGbV6Zt59DnVoVrKX8NAptWpcBeJz9xUtE3eWbKIzNaJsCGngC
	6XlbInSI8zLc65HYZuzb72aw8OoVqSQcr8GFDd0w7JI2m342mwDhTZDO
X-Gm-Gg: AeBDiesv4cMIS6/2tGslRmwtk8ieCDEgd5pduuyFDZ9r5VsW5Y161bVHr4WuP6qjViA
	OoCKyeUyM+HpeCandynJ26VkHsSw9758ZRTXZVnHT1cVCc3wDE/vvTEhR6IAfWAdijMmvGdn1f3
	6jJvK9g+Yl5KJjicTPsXdGuv+HHTxSCQP/dyBW1675YXSrM+d8oZbsG5jIk2xVs3jjt/tJ/s6Zj
	H9Ktf/CawJB7KXRroSZnr/eRmVySbDfNtrL3RdZMxRZGCiC4ZtDNXD3RRptsuVZV3vONjM8/eJG
	rmCWdOMpbgkNLOb+OnuR+HVfWIVJEINQYqUj2Gw85ZhBqWfKwHee868HgR8IpLQKbSlJOisLRl2
	UNbox9BvDJ+6f+E4G+PBw9z1K24UABLr1WvF+pSxozUz9NQwpbInQpbvieGwxvpKhHT3/lLTFjM
	aSejoFFAsWagggJR5uUxMmu0Sa++V3P2d1KeimL2nZrXqKIYVVjAYYXpWuCYTZlVLlA/YpQTKsj
	br9RUCEqeV6MSvmz6wd
X-Received: by 2002:a17:90b:2e4e:b0:35e:579a:7e9a with SMTP id 98e67ed59e1d1-36140204c56mr4522874a91.7.1776488239269;
        Fri, 17 Apr 2026 21:57:19 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1924:8520:35f1:286f:2ada:eed0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm3502377a91.10.2026.04.17.21.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:57:18 -0700 (PDT)
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
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net 2/4] xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
Date: Sat, 18 Apr 2026 12:56:42 +0800
Message-Id: <20260418045644.28612-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260418045644.28612-1-kerneljasonxing@gmail.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279466-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 6976641FF9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means xs->skb is NULL) and
   hit the limit MAX_SKB_FRAGS.
2. xsk_build_skb_zerocopy() returns -EOVERFLOW.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'. This
   is why bug can be triggered.
4. there is no chance to free this skb anymore.

Note that if in this case the xs->skb is not NULL, xsk_build_skb() will
call xsk_drop_skb(xs->skb) to do the right thing.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 8fcde34aec7b..5d3dbb118730 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -778,8 +778,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	addr = buffer - pool->addrs;
 
 	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
-		if (unlikely(i >= MAX_SKB_FRAGS))
+		if (unlikely(i >= MAX_SKB_FRAGS)) {
+			if (!xs->skb)
+				kfree_skb(skb);
 			return ERR_PTR(-EOVERFLOW);
+		}
 
 		page = pool->umem->pgs[addr >> PAGE_SHIFT];
 		get_page(page);
-- 
2.41.3


