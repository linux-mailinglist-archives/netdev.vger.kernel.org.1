Return-Path: <netdev+bounces-250333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F16D29027
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34782302F2DB
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA7F32ABD0;
	Thu, 15 Jan 2026 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2cFGx0h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mDkICLm+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2306F327BEC
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515977; cv=none; b=EAJuI8mbukroIBxB9GJ++Ifx3Id9lDvEyBPT90nbuotxzu8GtHYEA4NBv9zP700LiKkM+j9cUjZ/EIzNcetAPEDeTo9O72PBGMMsifQq5SBg0unx3gPUfyTnMcVXYLR69ar3n2UQTYfp1E0uIH2pxxIIhDT3wpRUT9WOGnH0maI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515977; c=relaxed/simple;
	bh=Q14qSA1z17qFF/v4c4OX6hWN4WDiGp5zmpmkYAZVEok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/dCa5Z1vmoBp2qk1KhZXwTmTmF4PuPnFqK1pe/RfV2pTyVuzoGQt4vHtfrsr6tz0B4n14u4Ob8yFg8Btl7r/WutIbiukNV1IjvQJzGONu7I0oYy0UsGiWt6Tn2A9uEqjzgLdT3e3D+UV/ZSwmQnbcKnAFqE3G3ArC1shUYjAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2cFGx0h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mDkICLm+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768515975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEJmHLN4IQ5OPcE6eMrctqmpA76tEXCUFjNIvHnP+HE=;
	b=N2cFGx0hF8zddPD9NNzFljWXrLKYEGswkWqblr7WfPSJp3rH1/SZhGwrIQf4s6QG7IcggI
	7ogY0f5yxDpDdiyOU709/NvaMdIVIBMpBQX+BAyl6/4BH7qohntyDDr16R8VmfF98rL2gE
	fa//6xW1/0UIGYHsR8n23Zl9DzMS4E8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-iawVsuekMw6WnSNnP9KkoA-1; Thu, 15 Jan 2026 17:26:14 -0500
X-MC-Unique: iawVsuekMw6WnSNnP9KkoA-1
X-Mimecast-MFC-AGG-ID: iawVsuekMw6WnSNnP9KkoA_1768515973
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee9a53e8fso8340565e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768515972; x=1769120772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEJmHLN4IQ5OPcE6eMrctqmpA76tEXCUFjNIvHnP+HE=;
        b=mDkICLm+Ya9AwrGu/SoZ0mU6rcyATTZ4C789tX77QCqtH+TqJYytuY6fcSkrjhayRs
         oVNBo2EGy0/KC4Xhh80LXwyQ20uLm99uZ95G14iAiGxkVPemQx0xQopW2MAsIm0HX7Og
         dJM4r6jr+0TEqowSpVwI6Q2BJHRfU/KA1k6TQDjLz91n4kZg0wgq5lqM0Xt9W8ZJkjiu
         /6kaq6ZY+s0G4ucBCJn818k/AHaxJQZgJlOpV8IZCNROaCKCu4aAvisOER1yDBceMXy9
         Ew4L1DD4JdzyvJtQnvyeekmR2Bdwo6UNJHFDIH2u+ccIBaTTF3ZOyEN49Cr3EltJflIp
         brrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515972; x=1769120772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gEJmHLN4IQ5OPcE6eMrctqmpA76tEXCUFjNIvHnP+HE=;
        b=LTToWnqUak2kU/YrJVagQqWVfHiBzF5ZqkVQT922N1gJ+GXTwmlfVTGqyaQUVEETcf
         W1aToTsbIhoTLI36Ut5BWtZKGEKB4Ui2YbBuNQDGB+zf+yWVz0DSUjvD3BPqDguH2IbQ
         84umrFvaNAlAmK+jNBZUWYd4c2li62YgUH8SwJoAbn0/jDm9t2QZEm8QHxOUxSTMc+ad
         jGtwunwZQhhfySJX+ZLYmQIzqQwx/ZkfDO3P334UNrpYCxi3aG3SHG4XwLxd5TYNN8qH
         2YKMui1HsFAbyrS8aPi/Z7coOZ+dnDMOAf7yDvYd9U8eJzBigayixKS25KBuocY/ptHg
         rkhQ==
X-Gm-Message-State: AOJu0YyU7FXeOp2Hp5W4vJwfnMReXdwy265ZyZE9QN4CGUM+Kokqb1nL
	sCwYN5WjLcOL3Ii+KeIw8ZocV5piLdNuFXy7+nJ/laswsOIhy78ji2ICENahgZ7EBqjqi+4ga1s
	2XBvCBTxKAsYe3PW2v6ROMaBbA3rWUr/o+y3VPUIPBm/w1I8hf7P8Ows70B6QUKJi2m+wkJRv8I
	Rs3NwaNo2FXYnnVKPxqV1/nGYp5L3L53LYwg7QSos17A==
X-Gm-Gg: AY/fxX4XmO0/4H0ZwPLdhR7Xt+GaQNDh+Dw7HL75zvrZOnnLVIjvsuELHMsLeGRV9o7
	hGBXuxKkWBIGkAWWg+8jnVJuOOiOhQACEZBezp7/R7l5wLNRK66+SE7qrlkfvILqtFRGWCX0OOo
	Ks6jnkG3BwsRdhIyogzYkUybVrOu1/Ptrj94H+FPWdS7DWdaOw5RD1+Ne+LyhNxAc5PMufiC5vB
	/Rj9NxZzsLFN1TTBc23M/fUx/+/wSM9y3QWdD08Ryla3JyA9meC6P5D71qSt7JI1/qOnvQT8wxM
	BCfcj6gP4r/ARIUmO+l0a4BY6CJDY0wc3o4M9TX3hQsjyUS2TyW0gKBYeaxBhR6bUqNpYXWarcD
	haW1RoNb4IQGP6dupEk8NMZphQ7AYRzeCWDLDahry6UF9sA==
X-Received: by 2002:a05:600c:870c:b0:47d:25ac:3a94 with SMTP id 5b1f17b1804b1-4801eb092demr7153825e9.17.1768515971683;
        Thu, 15 Jan 2026 14:26:11 -0800 (PST)
X-Received: by 2002:a05:600c:870c:b0:47d:25ac:3a94 with SMTP id 5b1f17b1804b1-4801eb092demr7153635e9.17.1768515971298;
        Thu, 15 Jan 2026 14:26:11 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992681esm1422769f8f.11.2026.01.15.14.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:26:08 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next 4/8] cadence: macb: use the current queue number for stats
Date: Thu, 15 Jan 2026 23:25:27 +0100
Message-ID: <20260115222531.313002-5-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115222531.313002-1-pvalerio@redhat.com>
References: <20260115222531.313002-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gem_get_ethtool_stats calculates the size of the statistics
data to copy always considering maximum number of queues.

The patch makes sure the statistics are copied only for the
active queues as returned in the string set count op.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 464bb7b2c04d..89f0c4dc3884 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3249,7 +3249,7 @@ static void gem_get_ethtool_stats(struct net_device *dev,
 	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	memcpy(data, &bp->ethtool_stats, sizeof(u64)
-			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
+			* (GEM_STATS_LEN + QUEUE_STATS_LEN * bp->num_queues));
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-- 
2.52.0


