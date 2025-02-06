Return-Path: <netdev+bounces-163646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC7EA2B259
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6E73A2AB4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8281A5B95;
	Thu,  6 Feb 2025 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRXnAIJJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237C019B5B1
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870529; cv=none; b=kNRaCLbP49DHeBd20d5SNp5azk75h+/41YCLCtXkqrKH2kQxEeig8SM5mNMCX5nMsuKxMn4mXcI1WSv1DecwL05K96CrivTx7czUcjQOTqH7n4JK7ZHxbFvl3SwoLsoNr74ZVdCPICbduvwTObkMe2YFiNqjXIqsoItooirDp2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870529; c=relaxed/simple;
	bh=mGjlY21MpgMeay233kuypbNu/bGU0/DHGkLIiWfe6kE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=psZV9Oq9yrcb0Mvj9xcxTQaCFLOZuHN7wpqaokRblTzM8K+JuBHbwpDOwRSgEXHZeqPBeW1fnQpcHiH9PRc+/QtB5570tYL8Km0UqolzuRxV95wx/s6+XfkkYUAvjM9EFYiOaLIhe0+kv+ttWFYXu97ZNcLdSZ6RZEHD2RG6KAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRXnAIJJ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4678afeb133so22681001cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 11:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738870527; x=1739475327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BT8fZCVtQfje+0WDrfeRJOu+Z2KiecVQ7c8R+eYJdv8=;
        b=bRXnAIJJhJxqC5UNoHdXnZbFEFWqjyGptsh9K/2DCcsY12TA5vj5dOIym2AuhFUoOR
         dq5aL2jGpQW3Gz+MC5p91NT3/prXMF+RGKXdS/wCDrn/2npaUi3s/K6ZU4HRRML9unR4
         9hTC9LhI7hkcUvjaQrL7ye3iOE2y/m/jQWEl0XGmWN9pVJbCvOz1h8EoN+ykrMdTrM2h
         KRJMQyS/RsCzDl4XwdcUxSxAYj3u1/VVcDQTZGPGCECLpVRwQ2kjpYYXbnsuIDPv9lxE
         rThoXk2IEPi3xs68IDStuu08F9tauF87rGmMHLkCF906+JWI8CBg1PBtGJ+jIXsURmU8
         Tx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738870527; x=1739475327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BT8fZCVtQfje+0WDrfeRJOu+Z2KiecVQ7c8R+eYJdv8=;
        b=M8yjITC4tnN0OIRonwBICmmbWcPFl1w43aabyhM+so02A1t19dphiyXANaiKwlwcVr
         YUfm2MI0WedIypV6WDFF7asL+j7b0dWJUTJl6csUGZoZegVVl7Gh3ZRsH93aKtFcKOnj
         YRShxaH6OXKo4cwPR3nIC+oNd7NoE/Jd+/4WPFIQY0jv3xP+ELw4UhjgRrBUgrFf+1u0
         3VqlAQH+wdmPBq9qbwLsskxgbvM5sRGYrDk841w7jyZrV/Pv1LxqhxfSk8mn7YvG3yxz
         kdL+rLnBXFXrIZjJmkxlEpCHonUzSj20heDujuJcCFVYwBen7AevviL684C9GrKTERBI
         Bz7Q==
X-Gm-Message-State: AOJu0Ywvbt99yMmsdB32Si8PegyF72VlDyeqMWI4K93pvWS5jgTjkS1T
	GBtH2FlzYHDBI/rjXAZvC2z6JymOqQDQuepw6q599yhtchCyhmWDdLwqRw==
X-Gm-Gg: ASbGncsnUQlV+jztG5iHjP8hhuGXLp5P8Dpx5mZFfMNy27xP+DkmvCP2wZRwa/zbqU2
	Wx0uuMdc0lPswrwIZ0OZiRR6EqrS9EfUoyTNX9aQJ66yi1fcckCwCvRKvJBrR3plm/WqTe+iZGG
	Meidm0tVdq8y0l1GP0nH+3dPHLnWkeGcOOl9MQYLKNNlo88rG5ViacMagTy4+mwuDnevppAamuo
	XniaaRwQP5942CtDPHFExfBCCX4H0858f16Xh1pqh9r8OfrnpExN9Q2J7IVnUqqHOG2CCZGtI/u
	RFfANV5YOFEIRvm/cqccHH72tzcku6MxZlZ4fjU1PX5SpdjSz33M36OT4kDEGzhSR6dKypqch0G
	BbWl/5d0j7g==
X-Google-Smtp-Source: AGHT+IGLOI0zhQNporpMj4lHuJFe3ifLJZmno11LmX9NqfhMHp9aG9HS/4YEXTOh2oKTaCJQXY+6UQ==
X-Received: by 2002:a05:622a:1a9a:b0:46c:7737:c509 with SMTP id d75a77b69052e-471687c04bfmr2875191cf.4.1738870526936;
        Thu, 06 Feb 2025 11:35:26 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492accc2sm8349301cf.30.2025.02.06.11.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 11:35:26 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 0/7] net: deduplicate cookie logic
Date: Thu,  6 Feb 2025 14:34:47 -0500
Message-ID: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Reuse standard sk, ip and ipv6 cookie init handlers where possible.

Avoid repeated open coding of the same logic.
Harmonize feature sets across protocols.
Make IPv4 and IPv6 logic more alike.
Simplify adding future new fields with a single init point.

Willem de Bruijn (7):
  tcp: only initialize sockcm tsflags field
  net: initialize mark in sockcm_init
  ipv4: initialize inet socket cookies with sockcm_init
  ipv4: remove get_rttos
  icmp: reflect tos through ip cookie rather than updating inet_sk
  ipv6: replace ipcm6_init calls with ipcm6_init_sk
  ipv6: initialize inet socket cookies with sockcm_init

 include/net/ip.h       | 16 +++++-----------
 include/net/ipv6.h     | 11 ++---------
 include/net/sock.h     |  1 +
 net/can/raw.c          |  2 +-
 net/ipv4/icmp.c        |  4 ++--
 net/ipv4/ip_sockglue.c |  4 ++--
 net/ipv4/ping.c        |  1 -
 net/ipv4/raw.c         |  1 -
 net/ipv4/tcp.c         |  2 +-
 net/ipv4/udp.c         |  1 -
 net/ipv6/ping.c        |  3 ---
 net/ipv6/raw.c         | 15 +++------------
 net/ipv6/udp.c         | 10 +---------
 net/l2tp/l2tp_ip6.c    |  8 +-------
 net/packet/af_packet.c |  9 ++++-----
 15 files changed, 23 insertions(+), 65 deletions(-)

-- 
2.48.1.502.g6dc24dfdaf-goog


