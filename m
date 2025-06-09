Return-Path: <netdev+bounces-195863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB219AD286C
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A11616D703
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C7D193062;
	Mon,  9 Jun 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWLCtCgo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F27FD;
	Mon,  9 Jun 2025 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749503305; cv=none; b=Utkr/iAfHhic/h1162aD91VBWOaZ+kRbNTwJ1gX8Er8N5LF5jjJSWP2Wc1ukrJj1dnMgqxO84THs68UNivu67wri370guzsw4PutpQmLq+A4JQL8rtKx1YNXNFMbRbsvaxuLsgaSr/hg5I5BdEp2ah5GLdVYOzGJ9mh+4CVKroc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749503305; c=relaxed/simple;
	bh=zuDTL7cB69EL+PgchjhF1SUAyQ94xhf+ydp3hPzb0kE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rNDG1tu6W1wSVJ9ZFjnDvVx61P7mB02Ig6gJ+xcVAOmnq9BFRAHRv6o0LkgyE10NQ0ugNoap723YkHX0u3AViU/AeQzygmES7uQI+kfdgRVO7QVdl9XM7MkgvONZb2N00W5SMjEsn9LULijztOrFOw5+UQcp2q9H4TPNR1zGAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWLCtCgo; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ade30256175so602144066b.1;
        Mon, 09 Jun 2025 14:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749503302; x=1750108102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K/+E654N6VLDLEVmc+jj3F2mGdbgofFxddmyLbhAauw=;
        b=YWLCtCgozOEGwd2SO5xUw6jlJIdYncbd/ThwylTe7xEcpDeS4JUXJIemNHZw32cjFB
         WYIPHeWGRukAieewujubFql/DzwMTKK834bniJij2Vksq22KB3Z8PF4F8gz18DXsMfNS
         qjwolZFTagEFmfdP4ZVHcB3rfIMCvapS0+aRzYp76ohqdvhSAKZZY5UDMVLao/crzP+N
         +eopL8a7oVAilP3G+mB0fK0yEYENMKESLDaPPstzG1OyDYjZGyeqDZHXH2+30rsxKf3I
         T9qXn8EjBhqtwz/IANhPJN+sutZm0x4nOGQgWACbR7fR/PcovQMmeAEgy/EAu/rhn+IL
         DgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749503302; x=1750108102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/+E654N6VLDLEVmc+jj3F2mGdbgofFxddmyLbhAauw=;
        b=ssOM1M/gZEWjCV2Exhabi9tps0IjsPnjBEEggng71ga+huTg3EMsyXq4KMtml0uZDY
         t+VI+gCH4n77HyotIAAi/GQ6seeqBBdiaZSsfxe/To0gMccjqtWZy6ErHlPZsWVQsuGG
         jns81ypMivsc36ArNUnEO2XAdO9fhPR3KhkjHcvsjLP5IWUHWNPpaGqmC0qGHMdSExMZ
         /D18P8r/gM8TGN8tybjeUd0viKiE0dBNAOK8DpWOVjm4UaRQNfrQRbHsioJESWYfJEr8
         PtIN5YmjAjB+hxNC5MiO9b1YgkRtjSa+wv3xeU99h8dbpDlSDrtrKLpN837ZRtPeyeIe
         CzWA==
X-Forwarded-Encrypted: i=1; AJvYcCXVsdRT8Jjkx47mDjZV7Xf1it/MaRt6z06vrNivc7q0456VjcU00hdrPkJX2BpUg7sQHVGeFC5/@vger.kernel.org, AJvYcCXxmi4wYcC/MQexaBS+rCQoIOZtny/uWDZspL4OjHRJxDVeTAnT+oVscBS/o8rW1JtP57NvgF5Htd5dUoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ9CeDZ51BOw/+5AK3DHMZuqhklrxvxVR/cXsw2mYycyEIol7K
	41Vtrw8lbvNXERfWsFKLVzJ4ZK5SwXyPgVcIokavnwspuLhEsHQHO5qnNSNci2pJ
X-Gm-Gg: ASbGncstcF8bn2Tv6eyBVo32o99OeGNFg74bNgwUY74UVnsx83w1o5AkL/3e70z8v1C
	vXyXwFLZ+Cd4pmG/glsGhqjEzfMtRFhLUx96LABSr/v6th7oCvbNTZ4+WZNZUUclCjcZpompeLi
	pjanx0jvLTS2IKiWqwaHAXWE5UaCuOX0HD3GPyrHNl2ba5vj91df8sbEPUXm0V46QNE2lSkn50i
	TIIuJsNk/1xBah1J9481Vd+GEfkgJAmvkkcrrf0JwOi+F8kz3eGKO3w/zQ57XYaua1LwhnFqrUm
	XH9G7YkAnLmoTuhbBqHBLWyLZXt8MW7t9BSuerZ0UeMnsD+jnXCNoQNs3m5ZkRwLFIZHAp57
X-Google-Smtp-Source: AGHT+IHww2Hb3N2NjaqINV7+U/1Ul6vltTjx2k8COiF/gro5XFioDzd+0yMzKwRSito0syJsOt/tOQ==
X-Received: by 2002:a17:906:ee8e:b0:ad5:7732:6759 with SMTP id a640c23a62f3a-ade1aa471bcmr1379707466b.53.1749503301975;
        Mon, 09 Jun 2025 14:08:21 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c57fsm609733366b.100.2025.06.09.14.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 14:08:21 -0700 (PDT)
From: Zak Kemble <zakkemble@gmail.com>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zak Kemble <zakkemble@gmail.com>
Subject: [PATCH v1 0/2] net: bcmgenet: add support for GRO software interrupt coalescing
Date: Mon,  9 Jun 2025 22:08:07 +0100
Message-Id: <20250609210809.1006-1-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reposting as requested here https://lore.kernel.org/all/20250531224853.1339-1-zakkemble@gmail.com

Hey, these patches enable support for software IRQ coalescing and GRO
aggregation and applies conservative defaults which can help improve
system and network performance by reducing the number of hardware
interrupts and improving GRO aggregation ratio.

Zak Kemble (2):
  net: bcmgenet: use napi_complete_done return value
  net: bcmgenet: enable GRO software interrupt coalescing by default

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.39.5


