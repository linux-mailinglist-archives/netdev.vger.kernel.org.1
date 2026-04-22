Return-Path: <netdev+bounces-280305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLfsGjRD6GmZHwIAu9opvQ
	(envelope-from <netdev+bounces-280305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:40:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA739441D89
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B5E6307A36A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2403A5E69;
	Wed, 22 Apr 2026 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSnd1dRp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFAB3A4508
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829056; cv=none; b=do49aI0TQjGXfFhW0zoOZMdSRE03uT7rEY9nKtAWSI5qxe4q1mLbqBYfYBpIPq8a+Al9Rbrp3Ysq4cvXvy58RfPanRU0hO3RdHHzw2jZuHuLzflf7OGx/gCJfal3aTmOdIV0D+kVlnfxLSee4Mu97R+w60jtY34Nm6/rZzcU9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829056; c=relaxed/simple;
	bh=zre60K07SneaVEDnlumeqWETssPMwhdZUrCSxPquNPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XfMWE0YRQD7iCstP4xBB/MU6TKob1Ukwyor9X1KnPwKIwjAXMGVGkz9k7efi03YXr5IsGfbIFXOpePlgRuU/rtVLo5ShEBkyUNVqJLLoWl+vB6o/SRxrULYcGgLy7WHikd0fphZDn17/j5OrbxKm2GsEbaj2rt9z1tegmLb+iI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSnd1dRp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82748257f5fso3181715b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829055; x=1777433855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1Miu0qXqAhnqzY+X70yibbH5j2Y+ZT2djf8HDzTjHI=;
        b=BSnd1dRpq0jT98gWfP71yw6v716PXltpko85Nf6e2chbC4k3CckVzi8ScYrkOv4QGu
         OYRYFoRFsBooTlz01zGHIiT31gyCn8L8dPjYHwKNGIwUCe9isiy2ULouj3fOzTF/QHxD
         yeEJ/SQqrEHJ8iGKL707zhsDlClBTmvFe3LF1E84B3N9m18HP0hXzzD387SOvrCq9wC/
         z3YSi/Tni+49WBxVXLVDfsxa1ploKP1Sqwr9xFFaeif0/v4nSZGCcElkYTBkKvlHOyyj
         9UIbcCpOEpYOShyTksooGOh+nYu+LpLaYQnNHfzAO0NvgTa3ysJSfCeP7s//okp417Kj
         Nixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829055; x=1777433855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1Miu0qXqAhnqzY+X70yibbH5j2Y+ZT2djf8HDzTjHI=;
        b=K1o/NMu+ZPeaJEBbtm42BOx1UqkK5aW4BYV8mecY7l7qNRr1/DNksEC8aG9NX7Nuwo
         4G4ctCQm/uaK6iplKk3tTYyfhjvwbaBGNo57V9qP90BAN+pBUtSLdqYUagRghJr3G1nt
         81dpHjM7ADls3PKus4niCKG+GiYTKxRoSfK0e/kxzEwOuLlWpZDQSmUpEQwpCN0t6pkU
         +AZftwzC372Pdz4rhl1TPA4MECKErtxfZSvL+CXO1z//Ro9grxdqcxOg7LKLC67uLN5u
         qnqlnLerTvdbAY0TE1iMbGaFihL5wwr9fX36m3BktrkrxeVatJ6IjIWu2QwjHWBxP+2i
         DWtw==
X-Forwarded-Encrypted: i=1; AFNElJ+tfa+TMcm+yAXcfSBcH+5BxgSKUEcs5UacsA8iQNTE6hN3innkvwEWK10kffiEbvhZ726m9dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGJwKltv0C1yfVYZh4jAeEad17E29BDQdRYm/N6avKAyYfqGh
	YiSpGyP9PrvbWuD2TZWmQUdAWMRL1l6KYmDEg0/+0zziACSAde6YRnzt
X-Gm-Gg: AeBDiesZRC4gIJPBe4gI9mCryRhGjvlrgAT4GoV2zViBvymffgC0H2pxFjIsUReKBDe
	BwGoLiNNtrZWfNFmOnvfkYD7i9vP60J5YqAjJEfQyPzIUv8KFRQu04ZVqP82weGx2rCUD0HPWPG
	IwpaFmd1S8k/HIC4Nwe47rQTJATp2SoZO89kQs6QZA/22CRb06QKrGJW9klDc0Pwvvj6QewuCgo
	SrMu47k9TIM5ckX5Bnag/6hZ/uK45jXOQzTH/X97F37PwGEiTL9H0K/26IkbARSH3JHeWCWTdL4
	HE33bQ6vAcSg6PbVx0XT1JwuSRIBsE2bVcCsMj69wZtwxFbcndhXGA0BqMwjnP8H6hH8wLo/JKZ
	vm1RI6V2rY6SPTR9sVJGPfoB++GqtLgkhZ2PNG9EEvCZjAmc84TcCuSSLw+sJjZQFsUjU0BvdSC
	i0JvaoUg8G7OoH+V1MhjW19vTj+4PRo6sh8XpgsAXolpxZ2WDjWubn+HOoVO7m9shCl/JRCwC5Z
	xvh97ks
X-Received: by 2002:a05:6a00:2d88:b0:829:6f7d:3086 with SMTP id d2e1a72fcca58-82f8b3aff42mr18281441b3a.11.1776829054634;
        Tue, 21 Apr 2026 20:37:34 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:34 -0700 (PDT)
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
Subject: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit architectures
Date: Wed, 22 Apr 2026 11:36:50 +0800
Message-Id: <20260422033650.68457-9-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280305-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DA739441D89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
uintptr_t cast:

    skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);

On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
mode the chunk offset is encoded in bits 48-63 of the descriptor
address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
lost entirely. The completion queue then returns a truncated address to
userspace, making buffer recycling impossible.

Since we hear no one is using AF_XDP on 32-bit arch, we decided to
strictly stop supporting it at compile time.

Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
index 71af2febe72a..819aa5795f50 100644
--- a/net/xdp/Kconfig
+++ b/net/xdp/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config XDP_SOCKETS
 	bool "XDP sockets"
-	depends on BPF_SYSCALL
+	depends on BPF_SYSCALL && 64BIT
 	default n
 	help
 	  XDP sockets allows a channel between XDP programs and
-- 
2.41.3


