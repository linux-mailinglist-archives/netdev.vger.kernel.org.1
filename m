Return-Path: <netdev+bounces-301314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k/0AMTNROmrj5wcAu9opvQ
	(envelope-from <netdev+bounces-301314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:26:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 242106B5C97
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:26:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=crWhXH2R;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301314-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301314-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B91DF30D622D
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B82357D0D;
	Tue, 23 Jun 2026 09:23:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39484039
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:23:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206587; cv=none; b=ogVLSuIOvsBPVWais3P+lLGGVM//IJpOMTyVTecNrwr9qAqawPb3on8/vi3kwh6UwShtrxiSqW7ei15jCfi2YuDxb2T3Z2Mp/FDdjlc3OJG9vozUm7negk5dt+mV82PP1VelxRoAVM0rGDuMBD3uFGaXFXSqlFrn3BXRd2TVHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206587; c=relaxed/simple;
	bh=4bgEaANvji3jJ7qZYimaDwx6R2XMVaUEcZ4OIRUJrG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daCVGAPHPSwmUI7qSuCXctIzMI8OTUxthb3uhjxwDvgIkgaNBss5AL6PSAqwyh0fkctn/4YOA1aSRFv+NcPEUIhrKdkqhABiobS1hy+4mIHW0gnBkp5R4LP8u63FAgPetdt0T65gtkaUrQHbWStNGgOFjD1DK7WqQXmL+HEnuoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crWhXH2R; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c6ec0af575so34478485ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 02:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782206585; x=1782811385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1/D/P8ssHne6yOityq2kiH3D2GawAY06a2KfeDH7Yq0=;
        b=crWhXH2R0D8ISi90lusqpbbQiqFaOLVtNANYWB+uO8fAHulQPweIkHYOMp6I0zmym4
         62TVa8smjyHGpq50rJEQRtfSnNNE8xEmQ3gMHrMN5Q7jLn2CI9cQh31751N5zhDAVOdS
         tdzU6PMl5IqjZLeSE93Ls/slLH0NzhqOIZj9zJ7hfEIQOOSaSX6AW1X5aUU7tlLcq3M5
         KBN+SOLpj79tHjAwfZnHyDQbpIHlsp0jEnOCUL/8d9++NuhMe8auBdpmM7UPt0K3zYtK
         3gJVz+b0xGHX3lWal/2l01UnTZKjsbGSRuOwFnMtV5HXpsXWkPTecwdWMQgw57/qITY7
         SjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782206585; x=1782811385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/D/P8ssHne6yOityq2kiH3D2GawAY06a2KfeDH7Yq0=;
        b=fiFTBZ0hGY7ygbyTvGu20NWoZSmSjxHsqnlesXHvhoM034fE09IZY9OLm5XuhjOVTl
         eJgXzuXMzOsNYm99rL0rWqItuwyXZqSN9OdQ6aNRkCDLtIckbxUV9u93j1NNxK284pYb
         O7q6nWqxtJfodouuuLc7GcBcOnUAhyWOMRs2d9POF0YEeCv0tTLa16OPAwUJCeBpdY7S
         pvo/cBHrU8ndc3CbOBcCpEEOmoTzdbZ8ZcKEsc8FOR5YupPBDT1IcNUJFfzkgzTy+oSa
         10r+S9KXZyZYWkjPUYzp2pcFnn7DeN+ZB8Xgfuk5bfk2bVSYFcnNVmK1HO4En1ppi8YD
         IHyA==
X-Gm-Message-State: AOJu0YynLN4/RQarvD3IkXttMJbsNxvl1Bp1CKA3cxhe16R+bW0B/jFM
	ERwisA85N3XxQr5N6icpn+xFuh4KrWR8OoU+9kpdx1aDp6RgzzRfx5AeQBPqo7Ia
X-Gm-Gg: AfdE7clEEMxuS3+qRofQCFSk254aIZfXB+Ax5YyZ4Rz/kAeg+Z78cCsA/DH6BUNOhWr
	DDjDDD+6vFobA9kE6bz/XEIpHWCfcV2fgj0BTm2EqDFdy/yoV5q+OYXJ3RJmDR6Q/hIXPH3pPPy
	X/GsLmaOWqgawuzM19qMvhOQ6QtfeMuYGoyU4XZO8UdgMMRjp1mkLlZ1U2agYA0FUBbnZr9xCCO
	U3X+oe2dvmQcHp37an7yb/tzGOagJ/0Um9JqaFyp8XcITCVLjN727fHA0ux60HsTXfUfZ+//tkr
	FRSojxdoiFubIY0p7MKEIMewOAbxBrHNgRE+sh8FDrvuEsDLef14XTdr3zohlacSCp6FDPNULLz
	i/Y7J9yfaJGr3RqfbOkjOW+jJHbjuNOHba4XHVbg4altK1J/welF/IzHEQH1c2bb6t1BfUXAEmn
	xsQD6uAQq3Wf7bTgOR3Zctmw87TIcM6WbRxHWYt82uWxz7zpDlBw/+1g5HNxyd
X-Received: by 2002:a17:902:e5c7:b0:2c6:ab5b:7579 with SMTP id d9443c01a7336-2c718f5e216mr182253225ad.27.1782206585332;
        Tue, 23 Jun 2026 02:23:05 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f86aesm101514545ad.49.2026.06.23.02.23.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jun 2026 02:23:04 -0700 (PDT)
From: Chen YanJun <635381823cyj@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	moomichen@tencent.com
Subject: [PATCH] xfrm: iptfs: propagate SKBFL_SHARED_FRAG in iptfs_skb_add_frags()
Date: Tue, 23 Jun 2026 17:22:58 +0800
Message-ID: <20260623092258.70507-1-635381823cyj@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:moomichen@tencent.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301314-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[635381823cyj@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[635381823cyj@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,tencent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 242106B5C97

From: Chen YanJun <moomichen@tencent.com>

When iptfs_skb_add_frags() copies frag references from the source
frag walk into a new SKB, it increments the page reference count via
__skb_frag_ref() but does not propagate SKBFL_SHARED_FRAG to the
destination SKB's skb_shinfo->flags.

If the source SKB carries shared frags (e.g. from a page-pool backed
receive path), the new inner SKB will appear to ESP as having privately
owned frags.  A subsequent esp_input() call for a nested transport-mode
SA then takes the no-COW fast path and decrypts in place, writing over
pages that are still referenced by the outer IPTFS SKB.  This causes
kernel-visible memory corruption and can trigger a panic.

All other frag-transfer helpers in the kernel (skb_try_coalesce,
skb_gro_receive, __pskb_copy_fclone, skb_shift, skb_segment) correctly
propagate SKBFL_SHARED_FRAG; align iptfs_skb_add_frags() with this
convention.

Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
Signed-off-by: Chen YanJun <moomichen@tencent.com>
---
 net/xfrm/xfrm_iptfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index ad810d1f97c0..0e0dcf47a470 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -496,6 +496,10 @@ static int iptfs_skb_add_frags(struct sk_buff *skb,
 		walk->past += frag->len;	/* careful, use src bv_len */
 		walk->fragi++;
 	}
+
+	if (skb_shinfo(skb)->nr_frags)
+		skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
+
 	return len;
 }
 
-- 
2.47.0


