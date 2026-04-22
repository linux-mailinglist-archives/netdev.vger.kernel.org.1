Return-Path: <netdev+bounces-280303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGWTHaJC6GmZHwIAu9opvQ
	(envelope-from <netdev+bounces-280303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:38:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A29C441D2D
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 886413031DA6
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C3C3A451E;
	Wed, 22 Apr 2026 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io6UOnYz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A33A4F23
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829048; cv=none; b=k4lxkqt4wZYuq3S5dPmm4hnZOeq9l7X7d59fHbkv6YyWJVIG5CfuIfdoIc3xofxjNLpjRRf/8e/USWndV15YTzz1OCNCezvnplE1rDYdw3XAbuNkPP3LEHHaq+ExJhCBoRI2QfDTQeUqRQPDNErwEVpGSqX3WqgyjYk5/m27Fjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829048; c=relaxed/simple;
	bh=54dyOuVdK9FasYgsc8yIn1HhPOeS6TZ03uMxU/XoJ2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lKNejwOtmDkxGgkh3nEv1sN5gtAaoDYh1458Dk8E9BT2NeHO5CkDRzmjPjUsBi7Z4m7kh4QiYqY4Cg31lar/eez15rFDbXnHz9WAyWXum8/kxZR03wezvBZn5LZLYcNqvKklpJtgkkGqr4gmRAmrWa87hMROot1s+NqgzTJf/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io6UOnYz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso3525993b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829046; x=1777433846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIbE2CkCL1kyhvQMnbjhjvSPF9qqQJuz1iFO3ISmZBA=;
        b=io6UOnYzqkm4hhKS9U6C3OZ0jNcaZn6I9ewGyyhd26PkC7be/LAbvytMDr00popdgn
         aYeyFeTmlLuSmZ1MpNmcRgWYPFxw5tqzc4+xfpDZ4FcYu2XwxBCobqDvU13dj/HHUQbD
         erO+Ii0Rfe1pOZNQgPZVaDjyLxA908Cy6G6x2Lu7S1Xok2Txk9monldtI8ql9x6NH5YU
         aO2nh4oWTMZtDLPZkORFSZfsTJF7tHTLnvG+CMabcMdwoYtoth0PKM3Jrp6gvWMAKFAp
         cvUO9q6VbUSVPa2QvCSaBGpO6KhUr80cXA4V/kdG6elhiWqQqf8E3WHT8onSGPbSx6bt
         F0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829046; x=1777433846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WIbE2CkCL1kyhvQMnbjhjvSPF9qqQJuz1iFO3ISmZBA=;
        b=nbRtgU70opj2asAUBd6egr1IFoQbOCoYBv14NpZPNs4mrDK4sV6lVjWa9QGCeFF1R4
         jourG3SeB8U/Xjb6QSSw5/VpNVryghSV95WBDGx3gOjpocuuIyYerss2yJ5weHqLKDIK
         JPh05i7mDY8H47FBq9BxnFdGfGxWtqFL7WLBzDG8+Bo34+eAYvyCaQSKo7K3CLfzi8pH
         OWp1XLh9vxHKu5C8wghF07EK6LeBeSQUYmv+C3pH5V0vCnA7Yy5cViF+f/ZHWqpThf0H
         0Z+Ab0wwI/xNmnWf0rU1e2F/33VWWQ0SXe+TG1qgqNwSIZ1KhP9Sv25VrSw45e0KLRkd
         3XYg==
X-Forwarded-Encrypted: i=1; AFNElJ8yE21iOGYTQP7kwAmAFdwunRfbU1VvvOqERtTRj78MHqAFrWLl1uk5jD1IFMZR31Dze4DX2Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKpXzLi48wszGhcfG6oJ/0w3ZTmEtIgbGg7ydi+IumTCS+qdV
	7uv1X3UilizE5nfDOAA1y6u2LDXWhPOuTMY0CV6E2NDpYLr2XaSEi0KV
X-Gm-Gg: AeBDiesZ67i00JEeDbllVagyOSEuWg3ZYaaLrcg2OxT9M98xC/fKmlDrVYb1kuGXzqc
	HVOHKKXZdwQLwI4LLL0rv9Wr+UTRzK6Qllplk5PtPgA7zK+C/gF5yzMYzQRQCWBOXB35CotxSwU
	L0zs0oaCZ9ekuCZo/6z6tzy+ZCXvbml3YVNYxEFnCDlFp4H+gwg6ty4hR2pFlm73GVXjTaLhojJ
	oBc2g4zdN75YHy8cMHByEguIsBbzZQlQW4//XRnJrJk1cVaQlgk7oMp/gwL9KXGGM53QL4SqpCm
	h7LM2zISPxnVPkZATelPOcqXs2OMP9kwLuh8SEutnLFt64xkCXMuPGIJm+kEIMtigvVq/85c3LW
	b0DKiW5ZkhbVhoXS5ua+kT84OgIR7wfRtZuvCm7xyGdm7Y7qJp7pJx4xngJ9tfomUrFlR9opk1V
	QNkKZ060r0JfggQfSE5KrsIIyo62qTkH6Sb5DJ0+rVK58AlqdorCNeFTMO8+xSUQYNE29CB2yOd
	E8YjoAJ
X-Received: by 2002:aa7:88d3:0:b0:82c:eafa:8863 with SMTP id d2e1a72fcca58-82f8c9501a8mr20628593b3a.49.1776829045684;
        Tue, 21 Apr 2026 20:37:25 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:25 -0700 (PDT)
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
Subject: [PATCH net v3 6/8] xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
Date: Wed, 22 Apr 2026 11:36:48 +0800
Message-Id: <20260422033650.68457-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260422033650.68457-1-kerneljasonxing@gmail.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280303-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1A29C441D2D
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
index c49b58199d2f..5e6326e076ab 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -776,8 +776,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
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


