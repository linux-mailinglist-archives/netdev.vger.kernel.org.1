Return-Path: <netdev+bounces-109832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BE092A0BC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EC7280C54
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D187D06B;
	Mon,  8 Jul 2024 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0A/rhwY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F56A8BE;
	Mon,  8 Jul 2024 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437145; cv=none; b=ITwgO09QPj9sHb1G/undbeQ9THVmQtdKMZYtJ00o3xeOsFxKIvIFwL+vEUmsoSa9GIjPcKUdR2g1hSnwfkQb/0KQlIwviEvU20WaHlU+L5Vz/8nZJy0LV27QZ5QBsKfySZn5esya2MHAgzYDw3JLzc8SNIgMlO9EsGL5xOsmJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437145; c=relaxed/simple;
	bh=0f1Sd0xlLETToab2y8m23PpzHmcQrPssvMbkM9Milrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aIL7w4vXSJIVzz7HwueO7r2BO+YJvtbGp8KUJEJ0d/JGGFx+FrcZQ7j08z8w3S1y3OkCLpAbjTDiyRk0EuuJUKGO8axEQmFYp1rCOLSxNDZd0I2ORstefESqTuUwncVHrMHlW/MPTLCg1jnsP8FoFM3h7xR/3mAnIANR6YHO2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0A/rhwY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266bb98b4aso4959495e9.3;
        Mon, 08 Jul 2024 04:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720437143; x=1721041943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNNJgGxWJNSl/HLsgGJCSjLj73ET7Z02bXAQ28fIY8A=;
        b=a0A/rhwYvTjLVEHPIjdSZH/43i3lNuLqY/IU/ED1lSTieMkjS8oDOVgAGP//BtU29N
         eQ56nPlmVrpR23ixblqK1ypEO7E+X1lxuuEQNpX6F66p9Yq42hG9IKwuBEQY95Yns+nS
         vQWQ/m/0sU2lC/FxBw7LLfHzEpZgdnANFUzM2qUv8urV/IxVWsqJA+cqNvADXQHvrbg8
         nIaH2pY1USodJfRN55+kcfKQ0lA9qRvpKWXMnhvCvw2804FGbe725CmlavwACK1i8Q4d
         zMdVKMmz8CmbG9MDiheK0lFZ+loM2aRMdWNIbRQPVIJn9y0d1X5VG8tBUuUJU0um8eTa
         S0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720437143; x=1721041943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNNJgGxWJNSl/HLsgGJCSjLj73ET7Z02bXAQ28fIY8A=;
        b=WATqKoW3U2GRsTONDkW8ppaNReLWwVZGzqIfsx1qeLZ3EBAGWGEj9saRSfJ8SGNG+e
         o7n2Ua5SvHHJHPXi/nbAkZpM8XCzYYMk0tvuL3FX5MJTwjsaQ4w+VaeoCKn4yG3ECwoG
         WCBG7h7xYRmWUXn2S09rAflZeD03IL320eIPRiEOXdSP0dINhMKOC6AZ3RdyufLWY1W6
         0+cwsR4O8dQdUU13/YiJ/8HEZam8ldx4LnDboabApVWkXp4WUJFbix95kzMCvb27TqZk
         IA7K0/ItvayLuEEMmzCaf9vZpPg+RjQv+FoTOc000UoRES8ylQpi4AtP1/AAf1ZHB3qa
         lGbw==
X-Forwarded-Encrypted: i=1; AJvYcCUQHT9L5zyace2D0/MwzkwE3xoSLE/U4XiTa5+sdwHNNDY3dB+9pw58+V4NMqC/H+cP73zuIQ3d6mPQ/kP48k1U7xtKr+DVpyK4T7x9HVZYCAoaXfA4cncl2aMYLPhn5/iTx5r9
X-Gm-Message-State: AOJu0Yz9eDQ1kVPFVuaDWbpqOH/UnHQvMh+EsweRa+27y/4pjQ9WhCjL
	+DVDsaN87k3P5e9DlTWm6Yl9oMEhpP16GbEtLSiIK5dQ9PIU5LzA
X-Google-Smtp-Source: AGHT+IHnY7C+pIOsC7Cy6UJeiaelYn+rAxkl16NCLElto9UH7PwbyDtLVs/gB1pbEUExhNjdD7lFAg==
X-Received: by 2002:a05:600c:33a2:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-4265b442f08mr73427185e9.10.1720437142477;
        Mon, 08 Jul 2024 04:12:22 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679927d7aesm11416485f8f.30.2024.07.08.04.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:12:22 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	petrm@nvidia.com,
	gnault@redhat.com,
	jbenc@redhat.com,
	b.galvani@gmail.com,
	martin.lau@kernel.org,
	daniel@iogearbox.net,
	aahila@google.com,
	liuhangbin@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v2 0/2] net: add local address bind support to vxlan and geneve
Date: Mon,  8 Jul 2024 13:11:01 +0200
Message-Id: <20240708111103.9742-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds local address bind support to both vxlan
and geneve sockets.

v1 -> v2:
  - Change runtime checking of CONFIG_IPV6 to compile time in geneve
  - Change {geneve,vxlan}_find_sock to check listening address
  - Fix incorrect usage of IFLA_VXLAN_LOCAL6 in geneve
  - Use NLA_POLICY_EXACT_LEN instead of changing strict_start_type in geneve

Richard Gobert (2):
  net: vxlan: enable local address bind for vxlan sockets
  net: geneve: enable local address bind for geneve sockets

 drivers/net/geneve.c               | 78 ++++++++++++++++++++++++++----
 drivers/net/vxlan/vxlan_core.c     | 52 ++++++++++++++------
 include/net/geneve.h               |  6 +++
 include/uapi/linux/if_link.h       |  2 +
 tools/include/uapi/linux/if_link.h |  2 +
 5 files changed, 116 insertions(+), 24 deletions(-)

-- 
2.36.1


