Return-Path: <netdev+bounces-280301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDf1GY9C6GnHHwIAu9opvQ
	(envelope-from <netdev+bounces-280301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:37:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F160441D11
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 174E5302FC09
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C63A5420;
	Wed, 22 Apr 2026 03:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBKVPhoc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2693A451E
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 03:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829038; cv=none; b=OKgEq9K+uZVqQkoVjzssbCk4TUCSRWYvRhj4LF8Eh76kZpfianYieZXDGcHFfi6TT3xTXQYhMzCUb/B3+TNylYSDDLzXZyjkmYXNusF4d9S3wusuV3OS3oII+ACPiR5MSpvjDx+Q4jvVad3FyVTfzXmSNQEvCzwU5zX3hSthUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829038; c=relaxed/simple;
	bh=iptCJ/bHKRj1fMFQE+A5aKdO5Z99CRwurcu7O1XGAlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jBazccuwkGvo2oyW50WSZkLCP7fOYsfSiFq/B/OXiwo8Rqa5iXCOaUV1H4zDCVQ0e0gEsuEBxv8owFnCAnttpCN7u5hyKpCoyuT3WTIteiKfh4rYRyjFpAIBk40Sp+7ss+oAWOjwdA9PBoNoLIykZ9OCNnfFQEm5vf+Nh1au3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBKVPhoc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso1509183b3a.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829037; x=1777433837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5FNK2dMAt1AUCbwembDz3q9hbJSbopjTGmkhaK/v7M=;
        b=aBKVPhocvp/3B/zZFwdh3D7S11kDoao5ILRc/A+cbTjyFo45Rb7YlkB+oj4PLxiLPj
         9Ra6uVx5KI7mrExvJTvv5f+90Dmj90ZSUqSEpfiZBEVxKfN2drL16dx20OfPEXE6Yu3I
         WuRNZfYkcecQpYKIUR1caTG+9fE+bpMz8auLFEFkQOZRdm3uudWcHfYyU5CosDgIc91+
         Y53WUbYRJPjpf+WtKTEUapqyxzTuoU6hHtIn4mxPMozuj4fVr96rWIkPeSAn2qeIyfYh
         W4YH28uVrHv9ClmeHv+GMGOJ70BmQt741ANwBXBHE6nJX7D/BpcEeIxw2+RfuyIRbcAY
         dhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829037; x=1777433837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l5FNK2dMAt1AUCbwembDz3q9hbJSbopjTGmkhaK/v7M=;
        b=Tcaqg4s+nbeMf0uWwlvqJM3YyWp1lTvzqWmqmNvtSE2BN4NVWr6IfN1uCMpDnsUO1T
         gGLblWOcLRDivbgjK5B3jMJo/PEilJvppYR4CuvDOvPAZiUvxjjVrBPQWxYrRtP1pzaZ
         a7CFSI8CNgnmHuaSoSjVJSYjmVeQXUUzwoALd6BRT/QS6ucOwqlAxnMKz0XFn5CjGVkH
         CQYdJ9LVXrhQHsenKHVLBRRuaFaj0OP7kOVZcSANoXM2RCEk7B0EBSV4Oy6FECxlnuck
         3QQPlRHSfVRzqCnlGN3UhOFv/3Rukuj/Kzh/VFMfiFf35NlD4RXUl4bvQw6E69ImUFVi
         kxLg==
X-Forwarded-Encrypted: i=1; AFNElJ9cRl9vHztQIRqGvCPURq2KWPYTWPRAQrh2MHRzq5U6GSa3quwfRXvb7reVfTQtXGcrj6+cufk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Yygpd88ck8Zdhp4y3kMheljGW4mHI9gMJ17VvB4C6bEezEeI
	24AcKP8CHroqHeV5KumrK75wBdWkqvyomUTNhQEvkp8EI2FgOHdtanbu
X-Gm-Gg: AeBDietx6AJmLoQaO4D/jVas0IlSoYi/aQStRMIii7gCi7UXik3ymPZQkmmqTKhertK
	CFeoNdc7hdLokbxdpvjvmbi4z00cDmp/On0KxIKM+1yJ8/CrQ1Wpnbih3aDAmwuCyfzDeN4iqK2
	DBlMRJbzRoHSmKWSBGBfq8mbwxphXwUt9A6W03FjHa8XX0u1xPsDxmA2yKdFyYEGuYm1P3PT2I2
	dJGS3JZEgGmvNZdPpx1E9ox9hsh+zE1ziUDvKkk1UsvwEi2cqeniqd676mAlitK/rJwVQCthsQ1
	mwh2LDN8n4RO1uqTaP5qEEKjSSiiQla95oX5FiYEfOIFMNw2bQhcDIfIULxKcpFaONP1hDUCkG5
	70QFdlyXCl6YAFHWBbzxcKHx2D4UQzY7DCHy7Zcd9PsKmLcjVXUYoMzI2vkxWi2v6gutS05X2PD
	HHbVytNZDlgwQgjHs4C54gSNd+7nD2MBSSK7nEbJeviHYodWqcgj0tYavXnwTv2tg2pAUBnE8jC
	u+aR66EyOeI7MPszZg=
X-Received: by 2002:a05:6a00:2311:b0:82c:dd31:b83d with SMTP id d2e1a72fcca58-82f8c936e47mr22442349b3a.38.1776829036722;
        Tue, 21 Apr 2026 20:37:16 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:16 -0700 (PDT)
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
Subject: [PATCH net v3 4/8] xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
Date: Wed, 22 Apr 2026 11:36:46 +0800
Message-Id: <20260422033650.68457-5-kerneljasonxing@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-280301-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0F160441D11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Once xsk_skb_init_misc() has been called on an skb, its destructor is
set to xsk_destruct_skb(), which submits the descriptor address(es) to
the completion queue and advances the CQ producer. If such an skb is
subsequently freed via kfree_skb() along an error path - before the
skb has ever been handed to the driver - the destructor still runs and
submits a bogus, half-initialized address to the CQ.

Postpone the init phase when we believe the allocation of first frag is
successfully completed. Before this init, skb can be safely freed by
kfree_skb().

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/
Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffer traffic")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index d23d1b14b8b4..88ec6d2cbbcf 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -739,8 +739,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
-
-		xsk_skb_init_misc(skb, xs, desc->addr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err))
@@ -834,7 +832,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs, desc->addr);
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
@@ -884,6 +881,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		}
 	}
 
+	if (!xs->skb)
+		xsk_skb_init_misc(skb, xs, desc->addr);
 	xsk_inc_num_desc(skb);
 
 	return skb;
-- 
2.41.3


