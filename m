Return-Path: <netdev+bounces-212195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E5BB1EABE
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 883517A882B
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C822820B7;
	Fri,  8 Aug 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bioy5tLK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCE1280CFB;
	Fri,  8 Aug 2025 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664816; cv=none; b=Ywg1kKg3Fo40Ce9BPcTb2Ao+A/P1qXsLRZNP+kaVuHuUXENm90++YKp0ViDoiSYYCk/A5+wuuVF8fAD5CNflTscQZ31+cCGMvogBiNJqAj62FsCn5494F55qrKW/WbmzFIZRhNHsT3g77OLSFfcj3zUKqSqzyQfHJOw6wHNzIB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664816; c=relaxed/simple;
	bh=HrrAxyj61SLnsN3GJ6LjWToWuINFN/Kn5UpaU740itM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDkZT7zuUyFlhnnodPq6TQTLFyNsfn62Oemdk5SjdD/XpIRXIXE0nQ3GSncKzqmkFD9LzdmsTPePk82HEReo9arvbPsZQkPavo1dPXjhRH2UXfezEKkvZL4X/J+njeQE5mVzppQm2DxI0JtL3cR2oFTIWH/lQbpWJ5x7hPuAj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bioy5tLK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45994a72356so17481565e9.0;
        Fri, 08 Aug 2025 07:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664813; x=1755269613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBAG0Fay451JgNwYj7hM+/kGoelDE4FVCawIWFGrRP8=;
        b=Bioy5tLK0G+/ooEjmnwi7W1RylWvm6Li1FC9I2Mag8RcAyleAQ1e1dm2etL77/Bx6X
         Cnf0M63Dt5ipOtKcUDyvNvJiQvsKCMibrz3jYxhzXQkFZ4HpD1he3YZvRIffz05XrlRi
         SZDA01JDNyJZBW0c8Pc9Nix88iHKVPpLNQPJXABpunrR4NHx9UsiLcHgsLAhocLkUiPF
         OZAhq3s37OysiC3t7nMqcgT7BfDFy4RzMjdsTjyRHqm73vkq+HhWOK6Pem167vXO++2X
         vp7TOMhMbffYOxNJeF/XortxyAietivcvODaSMtDkkry0RqpfeGHkw8uykL5YoJmT6JA
         VImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664813; x=1755269613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBAG0Fay451JgNwYj7hM+/kGoelDE4FVCawIWFGrRP8=;
        b=lMfpG8xO0d9GOfPRcTlFiyMkVUxKCirsfWWoFyztrCXqbSHnn6H3nzr0fNca/ByCNn
         NaCsQrrEzp2tTEVypHoJ/ubBngakp+q4k41UZ05RaW+NYDsiAf/tiCz6rQ0oJaSKK94j
         JieOrvpqhuZGHtgm7G8QZ7mEtkn/H1EoQkrJ/U18PKwhKRu4I0I4c5EEaS69bRpjalWJ
         cSiji6DMcZCilyyqzIz2gtM0oQjMqolYHXwsG/TKfwtLM7pZg5ZmzwCOxpIYQFCqd1K6
         6WXwS7u9IdGAKfEUwkj/gr5m3xkEALHks4Sk9Z2GQZsSGf9URzcM/2/W+tsI4WRj2Yrg
         jMyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTqetzokDus/Tcbshq1uVCh8bjXMzxniNXRr8HnVRPThlMxv7sK+dLvJC/Kp7omAL2XnbIMLwu@vger.kernel.org, AJvYcCXYeAPqFHVcOZVquhcHI5H8NaugvaMDJ30pTqdQyE1aTsiBjaBW4tDeINe1Z83GE0ZqGfmP009UruPjRoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBM5JOOiwjyLP4sWTXtpaZaCl6AI/JcekiT0wbB7xEXKTd5eN
	s4U6M2KWi/AwgjveiguuE3w7FcW7bdrdMZQOcTAH+j8UJOYdb9HbhXKc
X-Gm-Gg: ASbGncuzGT/S2JMRBHj9MqhJ/EIwcwmzGZtzJdrG6a5nJB7tTEaoogCCFPR5jY9OVJ8
	H012mUDXWfgSJ3c7ZYhw/JS4/bgRP5jplKhh8LkrzdaA7W3d5uikXPP+Wefz8gssdHSRAaAlpia
	RMg4v1p5piM5PBG0hJ7QsuWN5biygsLB3Sq9f6rjTnQyu8c7mLtrLvV9GLSSBcQ7VU0ip+sRoAS
	+RSQqAlUCJ/HsdoFW54x6/ymvEMcfQdHICti5Qm1hLZDyciQ1fmQnK9K5YSdMZEDkLlb979aHUX
	XzM2GYFT4EWAf295UvMEXTNObCEC3RvjqLat4ifwJ/clfeM6xQyppyozpqCyM9FsnNtQe7BAnxF
	StJFOuQ==
X-Google-Smtp-Source: AGHT+IGIE/V2TFfwpLX9Kp68vXYpHcqhncYC0VGIT255SexcmlI4pvh7uyxY+NaPTEunv/QmvlvIjA==
X-Received: by 2002:a05:600c:a111:b0:459:db88:c4ca with SMTP id 5b1f17b1804b1-459ede6c0aamr65385875e9.3.1754664813325;
        Fri, 08 Aug 2025 07:53:33 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:32 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 02/24] docs: ethtool: document that rx_buf_len must control payload lengths
Date: Fri,  8 Aug 2025 15:54:25 +0100
Message-ID: <327e21d7afe67bbdf39d01b17aeab76a7d60fad1.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Document the semantics of the rx_buf_len ethtool ring param.
Clarify its meaning in case of HDS, where driver may have
two separate buffer pools.

The various zero-copy TCP Rx schemes we have suffer from memory
management overhead. Specifically applications aren't too impressed
with the number of 4kB buffers they have to juggle. Zero-copy
TCP makes most sense with larger memory transfers so using
16kB or 32kB buffers (with the help of HW-GRO) feels more
natural.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 Documentation/networking/ethtool-netlink.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index ab20c644af24..cae372f719d1 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -966,7 +966,6 @@ Kernel checks that requested ring sizes do not exceed limits reported by
 driver. Driver may impose additional constraints and may not support all
 attributes.
 
-
 ``ETHTOOL_A_RINGS_CQE_SIZE`` specifies the completion queue event size.
 Completion queue events (CQE) are the events posted by NIC to indicate the
 completion status of a packet when the packet is sent (like send success or
@@ -980,6 +979,11 @@ completion queue size can be adjusted in the driver if CQE size is modified.
 header / data split feature. If a received packet size is larger than this
 threshold value, header and data will be split.
 
+``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffers driver
+uses to receive packets. If the device uses different buffer pools for
+headers and payload (due to HDS, HW-GRO etc.) this setting must
+control the size of the payload buffers.
+
 CHANNELS_GET
 ============
 
-- 
2.49.0


