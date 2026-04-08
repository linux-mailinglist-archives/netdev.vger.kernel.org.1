Return-Path: <netdev+bounces-276689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLQjAFym1ml9GwgAu9opvQ
	(envelope-from <netdev+bounces-276689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:02:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DDC3C23FB
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7565B30326CD
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 19:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042563D9DDA;
	Wed,  8 Apr 2026 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="QP1FNRlV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB193D9DC4
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674940; cv=none; b=isj3EdZ9wqDZPty4eUVXUacMj+wi47pdaMfwOKEDxlZShncAXXX5kNctRwPk/yjgxk9N4FfaG3zJko1CMPwqMRwQUA5BrbGduk7Y7joGW9rH18V8HAcGc19ZwvQ2lFSyziuC3X6nDLCEpRSTzSgi0xk2ABImVUzkO0a6qlLfMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674940; c=relaxed/simple;
	bh=Q8CLizCtSS3EwVHHwKK95pTLXoQ9BOwSHh/f/AisZrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yj01ftsUsHK78i9iCEMlwEskZ08mXohntqOoE4nFDgMeGnJZvHnvY4IwkmSbgqzrrWEhR4wLoxWAs7SP352euJ/yDoMN9EYA/anN8um2djko4eV8NIaOf+SaXSL1BP5iH6q9Q9Eb38S/44ubmHbJ5mib+NT49PaXswyEWgot5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=QP1FNRlV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf5d14d6eso32852f8f.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1775674938; x=1776279738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5kVGMWj80+QphQVczp12xoX+BKVAGC3CV86I0J4IZU=;
        b=QP1FNRlVD/XPolTB3oeCfAbnlM309b688zk8k1pLmJab/N4aY+1zGxqGHwXl2m+g4Q
         RNXkH0aCl4EUmCGuErWlCX+SurmQGfgbTf2obqMdvcSXmg/e3OFvDSd+zrl/L8zoQer3
         umKB/TNr+0Qcii2Iah2CR5MVR/KJ2nHTig44m5k7zaeJg1zEp6tLUwIAc5WUQS/xFL8L
         g1lqHrIUQRAN9oR6TOJ2Jxd91ETyiHy8zAO2u4M14AZa4VvWpWL004Bsno/sbxhL2rR8
         F4pJO9BR7/xqrPaFfh7NVHuV1TK/Zk6rfWt/t2mcN0Snu8tGeP7B/WK5MSUChIKcD5vn
         xlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674938; x=1776279738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5kVGMWj80+QphQVczp12xoX+BKVAGC3CV86I0J4IZU=;
        b=fOGJWkwe7zYzIS9Qr9k8TxfvC8l7zw5mSKtHofbc1kVjPzDCAOkGTAh/G2LPIq9NSA
         MmVTMryOJd0ZyhalxY9DzR/aq1m8s4UlMw+W5RX7RXKCyDu99v7sR/rr1qrv95GygGjR
         ld3tCNx6//6ppCYwPSHhfAv3wcqon7PtJJLhMOJxdQR+cedo8CDTkoMn392r9E3Fb/XL
         cMnFz8zzao3lzllQRqFzBSIhgN24/oJBkBB+GfjGLmZGORCggJwFv2/48vNqsqQMwktj
         8LJgK9jYOattqTNB5rz+92EztXppxSTzHdXQxmNP8RBq68TOrr1DM69KhV6fWPw9ZFJ0
         Qh2A==
X-Forwarded-Encrypted: i=1; AJvYcCVSObMVgnerG79KlKh3AS/+UdhsGBhYj2G6sKsPMUUWBqvRVlrK/i5G6nQTWjZ7QJNAq2kET5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFK2Rxam7wVC/HPIwa/QzW7MfPdJOMsZE8Tc4JvtncW2IF5q83
	PlUoYpGQYon66b1Nx5LURT8DseTzBY5aNxFLewcHwdy1Uo4F9j/YuYLl9442Sos7DFQ=
X-Gm-Gg: AeBDietsbFVxW9pTL+C773n2c6v4qN8Y8mxUygUp1xXneBb4bb3yH81F50y5XA62BOI
	dB/CH5QaX143P5C8K1qQFRG3Z8/aFwco5XOEzlWIK53tKRsU2ERNaFOEnkCNKvZ/hi1nqfgzKiM
	MaQKHvtCusfw2PsZ31zja8b9K+CDIrnIArtDqmJW7m+dqp++XqZsJGNx9HUrpl9uYG3uVBprqRg
	U7FdpW6pedpP8VSVX0e0gCjveff3ErjbGZEhwe/G1vt3zzM/a0qC7bsYzPdFEyVMoIIaS0vCFUZ
	7tf0ZAs1RhbKQy1ghVjfg83Bdjb7se37k4ZFfZR+9I59iG0D6mAO0SmFnfk/+/UEIQpizOAo/EF
	juJ1huFijMKHjHhQCTSjd9frgsMqOr3Wi/NsCirBEHur5kf2CgUuv5t3JZ6/Yn6S9e/QEtRegUN
	alfbVHnJ62B1femkBlCefrt0bSbg==
X-Received: by 2002:a05:6000:400a:b0:43d:4c:229f with SMTP id ffacd0b85a97d-43d292e27admr32977247f8f.44.1775674937668;
        Wed, 08 Apr 2026 12:02:17 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:ec8::179:1f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f1a99sm64678239f8f.32.2026.04.08.12.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 12:02:17 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH net] ice: Fix missing 1's complement negation in GCS raw checksum
Date: Wed,  8 Apr 2026 20:02:14 +0100
Message-ID: <20260408190214.1287708-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-276689-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[readmodwrite.com];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[readmodwrite.com:mid,cloudflare.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95DDC3C23FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Matt Fleming <mfleming@cloudflare.com>

Commit 905d1a220e8d ("ice: Add E830 checksum offload support") added
Generic Checksum (GCS) support for E830 NICs but omitted the 1's
complement negation (~) when converting the hardware raw_csum to
skb->csum for CHECKSUM_COMPLETE.

Without the negation, every CHECKSUM_COMPLETE packet fails the
fast-path validation in nf_ip_checksum() and falls through to software
checksumming via __skb_checksum_complete(), which triggers the
rate-limited "hw csum failure" warning. Packets are still accepted
(the software recheck passes) but hardware checksum offload is
effectively disabled and the warning floods dmesg on systems running
nf_conntrack on VLAN sub-interfaces.

Multiple other drivers (idpf, ehea, iwlwifi, cassini, sunhme, enetc)
also apply ~ for CHECKSUM_COMPLETE. The ice driver was the only in-tree
user of csum_unfold() for CHECKSUM_COMPLETE that omitted it.

Fixes: 905d1a220e8d ("ice: Add E830 checksum offload support")
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d..c177579e0114 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -92,7 +92,7 @@ static void ice_rx_gcs(struct sk_buff *skb,
 	desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
 	skb->ip_summed = CHECKSUM_COMPLETE;
 	csum = (__force u16)desc->raw_csum;
-	skb->csum = csum_unfold((__force __sum16)swab16(csum));
+	skb->csum = csum_unfold((__force __sum16)~swab16(csum));
 }
 
 /**
-- 
2.43.0


