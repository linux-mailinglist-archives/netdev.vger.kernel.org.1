Return-Path: <netdev+bounces-306865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JYzCIlBcUmohOwMAu9opvQ
	(envelope-from <netdev+bounces-306865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:08:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0094741E2A
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:07:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RdER+N6g;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306865-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306865-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43E7330429BC
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1430E0EE;
	Sat, 11 Jul 2026 15:06:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472FA2C11EE
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 15:06:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782394; cv=none; b=QaG/TuMS+khETy/zKj+oIOpGNjpiqjbzjaop+Ui9yIgui0F/bUnp4XIa5oigrlm775v5nmRgHWJmvq6r+NDjfsL2/HaT9nRzlyr/t8BXnuuv3T7xh4+VNSfFl1aMYZLpvjftv4e5YP6Y4d1P3Ktc7olEmfWllYXXQ8zcGCPJkLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782394; c=relaxed/simple;
	bh=xfd1Qij55WSKgMYmH/iULiROavfzelZy0Gq6Ktbvt4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7LD5972j379NNLn/iLrzepqMi+nl73pKT2IxfsfiZKZ79CeT8fshS5vKuM8uZ+shiBPsRG+njdhZPiQATTvIwpjQ8DlkjcfnP9HmaAUulzrQY/7EF8wcxS0AJkFd1psjEAgR+Ogw24uNA2riQ6AdBwnyPTzg4N7Z6IQbOKtuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdER+N6g; arc=none smtp.client-ip=209.85.222.178
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e4fd65b2bso91603585a.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782392; x=1784387192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XSPQ4s327xjju3OZzaMxfnUi+7xam88AtuluAZAKUPI=;
        b=RdER+N6ghm5RpSKKvj+gqtJxRBfPmMkBL8fMv4K6APpV1kKcCcxbKfb5/4cKDFpTtg
         FwCU4a/ts9PUK1uxOiASMqHWAPZBj7oCY5/VG2TDLeMgcFI0F3pmM6OehTWfJxlWvWmA
         ah3CqWm3AK/jmu2R6lJVPtlaj0PmN8hka8eK+DXUa/pVcf1fygS69HwuV4pENMFmziC/
         xROgyWzftvniM5Q86qCuKbjsmDvx6lx9HgEXP8eicWeLYRGBw3muIhXTNrn1ja2P5Q29
         q7vDzGqm5U8rmfAtaCRZJOwQdyAKP+Mx1n2TTczKw2aLxJHKKOem+CC31ZLhAyYd/enM
         slUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782392; x=1784387192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XSPQ4s327xjju3OZzaMxfnUi+7xam88AtuluAZAKUPI=;
        b=V+3xoe3VSjePU6ByJIYC/gsg1o/WPgF+KOCBmfrrWKJqt7plpGp0m/iM2HAlZeKwxg
         8QYEvDErcVLRHgtGBaJuHX7N3qHUNEdeOwVuAmf0iRK6mkoJxpSvxbwt3PNChcl7oBrv
         rCBOKYZEyaHU+JvGOb+OAX9/3COKe6oYMlBlZRhOMpjX6z8qGZF57JE8wId/AS7dzNUA
         gyWxk1ni0ulPGrMeMWmwUl1Ig+w7xkGp6nKYOfdfBiKDFFG5TuZ4E8CaU5MXWfg+fAlV
         t/4N1s0UcSGj57F2JUj0qlGOSwDk7Gk7dd+3hkwHavyWmm2sj5U/6Rmx4m1AYLpwShER
         Vtcw==
X-Forwarded-Encrypted: i=1; AHgh+RoUaHItDoCsapK+xG8V0aa+6Q1m+V1zj1i3Hheye7OVYmRuEHUSZjTxu8K9bLJqhBoJZdd5EmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIk+SEjteROtXyl165JW5ynGr+8dNDBlWRsW42+6B60UNIIVxB
	+3KrFspfwi6bb1H3UvsCsGsPfKdNNcaUAk75n+oq0gAbOfpuuGwULgHF
X-Gm-Gg: AfdE7cmRVcw7DEOfdK7uUcRnV9Sk+flzqcPeu7JOXJAjP+c9MRFlgXw2gB6L0/o0qpf
	NbHYx5Im+2D4E2xqigixz/CEeKn1Nsfmx1+A53jPtj2GV462Jx0HMbfyHpb1mh2iTWIZbJu455h
	k6D3m4NIfS5hFbxrbV/caWYKycDl/qvz0123W1XhOmW6/MrNEvBu/5oKA8LiawR01oZNOe8IGVt
	NFNx3GHXj8IZKrCgLAEYEV1siqxifoMp/E7spC1tXM/+4+R8vNfKh+KyY/UX+hhlwUt8Kb/CLLB
	5dPJRq2MqADAHoXZxUHceik5zRrf18z9CX5szIkze4ab/l95Eyf38mEha5iLtjlnxJ4yX3G23SO
	5PP2hZ1wZel7MZ7amzP6G0j44dZio03QAnPLEfTA29jgTMaqYZmSdM7OqW5b+6tl8Sz5ATpmNG3
	WJ8FAt8xBx7Enoi9eOCMUozUv97d3zPj0XeU1Yb9mkDOcYxbJ4kqbNsbFU632TdVtL9bz45etus
	hUGLT0b5g==
X-Received: by 2002:a05:620a:28c9:b0:92e:8e36:32a7 with SMTP id af79cd13be357-92ef2c7289amr321690985a.68.1783782392025;
        Sat, 11 Jul 2026 08:06:32 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b88a38sm465793285a.12.2026.07.11.08.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:06:31 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] net: mana: cap HWC init max message size to HW_CHANNEL_MAX_REQUEST_SIZE
Date: Sat, 11 Jul 2026 11:06:28 -0400
Message-ID: <20260711150628.2914205-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-306865-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0094741E2A

mana_hwc_init_event_handler() in hw_channel.c stores device-advertised
HWC_INIT_DATA_MAX_REQUEST and HWC_INIT_DATA_MAX_RESPONSE values
without bounds checking. mana_hwc_alloc_dma_buf() later computes the
DMA buffer size as MANA_PAGE_ALIGN(q_depth * max_msg_size) in 32-bit
arithmetic. A malicious device returning a large max_msg_size causes
the product to wrap, allocating a small buffer while laying out
q_depth request slots at the unwrapped stride, placing slots outside
the allocation.

Impact: a compromised hypervisor device model or malicious MANA PCI
device can cause out-of-bounds DMA buffer writes during HWC channel
initialization. A reproducer is available on request.

Clamp both values to HW_CHANNEL_MAX_REQUEST_SIZE (4096), consistent
with the cap already applied at the channel-create callsite.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 48a9acea4ab6c..a0916b50cffce 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -152,10 +152,14 @@ static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
 			break;
 
 		case HWC_INIT_DATA_MAX_REQUEST:
+			if (val == 0 || val > HW_CHANNEL_MAX_REQUEST_SIZE)
+				val = HW_CHANNEL_MAX_REQUEST_SIZE;
 			hwc->hwc_init_max_req_msg_size = val;
 			break;
 
 		case HWC_INIT_DATA_MAX_RESPONSE:
+			if (val == 0 || val > HW_CHANNEL_MAX_REQUEST_SIZE)
+				val = HW_CHANNEL_MAX_REQUEST_SIZE;
 			hwc->hwc_init_max_resp_msg_size = val;
 			break;
 
-- 
2.53.0


