Return-Path: <netdev+bounces-137955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0183F9AB3DC
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6400284FCF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA95E1A3049;
	Tue, 22 Oct 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYyQuc1+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2DD13B588;
	Tue, 22 Oct 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614322; cv=none; b=Gt7yrRQeBOSR4UqufdagYhfjktfwrz3nfttgTd2lD//ueEvwTSgRY8RfuX1YQZrj8EeBkT8yf7gXBjYAjHcr/uDiLuDSphSa47klPZcmwYECu8nkkgcQDMWj7yzpOMG6+B478laJ/UEUOqHyoj245iwH1DzNczxKt0Ldai7YDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614322; c=relaxed/simple;
	bh=2sKMahTIOfrWlwJhACtzQNllUdo4h7AEkI5JLVzh3Fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pJFQfp/WveLjXcZEc9j51pCumcm8jTELa/z1mNySA48h1P1b7oLsRdWnyPXjdGJtd54hGIqMNA0KXEe7+pLyJursx23HLhk/Q+QpeCzwpDtUIkh4PASviY2xp+OJaIwmRxA1WGAmnJiYGUsRFjZXOb4P7NHCauBN+n40dg8LgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYyQuc1+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cbb1cf324so51703095ad.0;
        Tue, 22 Oct 2024 09:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729614321; x=1730219121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU8o7jgtiIkbRazmxk5E7y3TXU85oWjPMpDaC4ZPE5Q=;
        b=hYyQuc1+LH85hrpf6lh9T4/VfxK2E6CdgZLtv8Ef5CGYzcEnkYR8RCvzBaaMT3k9d6
         mdQR6LWE+NNKUByV0oMK0zOIOtJWcNjk/D110F/ea6Z+brOyegDx1iKkE1YdqZogj3rp
         BrhqlVk0YLObaza/UhnvSEkhzc86vadVMJip8kvMQFYpvriIUgVPOZ0S0Yr+9K2RYHb3
         9WFbaQSw9zFbbfSrcSw1FrJ9SGTs+D6uoqrQluGMW1vPCvg98i5C8XwOWyhZXBB85ZR8
         adeSrZakWCiEjQxxbHZkoCU4fVum46e0wXvHB/N01UJZz9qppYaAJITkXMWPNCNJ4Lq8
         jQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614321; x=1730219121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GU8o7jgtiIkbRazmxk5E7y3TXU85oWjPMpDaC4ZPE5Q=;
        b=R5HYU7lfmKftHBWa4hs8VoCV4l+mDXXSc8KBRC5qg7qxn78Wis0lPsB+m8BcPG7vdZ
         ZNLPXpmtSC0lvcqkFNhJgjh3JfIU8V67k8fkUep/JWqD/RAFw1C1K09NhHurJWB0GD6S
         7CSnl/4B0tGNWAccA9UlfStOFtElrryGaUWavYwJy1WcLcYHaQhjj0BTwmGk7CPwYaJJ
         kpmRFwRHXICMAdXLMBmwk7yy/gIcRd28YyZj3WrYjmBZ60nQiLgTuW9IbgWcN4hMnKq+
         RXZTEhUYOzDh0Ki3o/ewRTf5PR1djPIzadiWrH1fSo+cF7c2EVGftVB/T2QzhFt16SAr
         X0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/FTstGOrtIaV7wmQd09roG3NZtesSywK6/nZfdL7Mxl77n8Ew8od1ZehHfDtQ5DwxKdbi2wDadfU=@vger.kernel.org, AJvYcCVY4sOMKczP5QeufLwx0JECoQJIvvlmCPRLuza4gphxU4RJtc9ZVGhI6Kl2FbMAjbbuV2IUmA2F@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqWCtW1g5EL0nARiMToFR2AoHwi7Drx08Yd9SHPY0LfhpAI2H
	mWNeII7hWS0vFB6qBHGJ0ZwOqkXzT6sHxrMFA/O64vTFwUtG2Ek8
X-Google-Smtp-Source: AGHT+IHBrs3zxXQCLo/DEGNMasPfq1NTj2LoHBQnCpwRjhc5pMZyjOv5+CeeWy8xz1bUyV+myiD5Fg==
X-Received: by 2002:a17:902:ce85:b0:20c:d072:c899 with SMTP id d9443c01a7336-20e5a7790e6mr195514345ad.24.1729614320971;
        Tue, 22 Oct 2024 09:25:20 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee6602sm44755205ad.1.2024.10.22.09.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:25:17 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v4 7/8] net: netmem: add netmem_is_pfmemalloc() helper function
Date: Tue, 22 Oct 2024 16:23:58 +0000
Message-Id: <20241022162359.2713094-8-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022162359.2713094-1-ap420073@gmail.com>
References: <20241022162359.2713094-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netmem_is_pfmemalloc() is a netmem version of page_is_pfmemalloc().

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Suggested-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v4:
 - Patch added.

 include/net/netmem.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 8a6e20be4b9d..49ae2bf05362 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -171,4 +171,12 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 	return __netmem_clear_lsb(netmem)->dma_addr;
 }
 
+static inline bool netmem_is_pfmemalloc(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return false;
+
+	return page_is_pfmemalloc(netmem_to_page(netmem));
+}
+
 #endif /* _NET_NETMEM_H */
-- 
2.34.1


