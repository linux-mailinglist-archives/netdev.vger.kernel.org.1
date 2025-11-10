Return-Path: <netdev+bounces-237354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E9DC49712
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 22:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9B3188A6D6
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 21:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3296523A9B3;
	Mon, 10 Nov 2025 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMnLplU4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56B2D29AC
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 21:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811119; cv=none; b=ALb5mNhTUlpZ0B/9cgnAuuWDqQAe51PYYdpm98LbsFVCfIXKhKnFIeLBcpM8JxZ3slurpQNS7zlugdrYUPkFdjPBJENPmL6PpI+ou+5DkM44loTD7axxmm7ZIcWKs+Sd8qioaR4fy21zGOPoHm2B5PVndWNqrxzc1pqXnWWwqoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811119; c=relaxed/simple;
	bh=dHwTe00j1MV9dgQgcUWIMhhJ7OdyBnhAZ0pGNCeydWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGFiFekXvBTmtWHEtHZVJd5He23e8J3mqRMtyy5wmEy6GFBtte4b9E0qsL5Hyuq6xaC2CHL0Kk35KorrNweJptPWb2Q1cZhOc6tKHIfAmxHj9/bk1mMfE8GqYp+azPzQZKJeNLMFhr4n31n21b+HYaBgjHeO+j+uc6H8KrlEWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMnLplU4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso542673466b.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 13:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762811116; x=1763415916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiFNjiZ4X2EvOoUrngxyK7bRgO5ZFSxeJZ13R5Tmu5A=;
        b=bMnLplU4DiovrGil+UN3G4mfT22q2bHV3WKMkW2E2O9t1/PZYbKeLrRYODyv0Rme60
         9wAe4zAt3UrKRekIvIR2NcWu7MvIkibn5+g5U9V1Glv0sGSj7/FZvtb1B5xWrdNEgwlm
         Un7n2xkMVWNO/f2aRi++DEPNWbUJQSPptoE6scpWoemNw84UwgjPKhE7BwqGkGzleTVF
         YWSqas7/TOcMbKVpJffrXmAb+76Mf6MOnf3cJ/S6oD7XEeBaA4sWVx/9ij0tzExyYY3+
         2l0vQe0FPNY8/vTmpLx8E7ZGGhSIWpaC3RtuasnRTFGGd7b5bGYz6ManD/OeWxgWeLAc
         jdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811116; x=1763415916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiFNjiZ4X2EvOoUrngxyK7bRgO5ZFSxeJZ13R5Tmu5A=;
        b=OKgqQmj6r+7uWq51ZKRyexh7sdxBFMgIpr1vrUU3PPAExW+C5ZtTM4WgBy71r9Zntp
         B2T2KgwajP8xz+cNpQbB8ly5JxB4jrCqe/+n+Zwg0ybZOK8+UvhA+VNJ079txX92G8lE
         sVWhTI/dPRfEF96xayMxGoK5fINIxzVGEbCWAi9TxmMLNSPFb8ZMku/sGLyFi31ubegL
         LIz/+CHq3qVofmq0qudW7exp5VFp9eKcD3VZQzyY7NiJG+yu9GE8C4upzV6tRm3B12RC
         5NKwIGtpd8HFbi1t+7v80GEcxG2AIBHnQV9LppSWOxex80aByf3zQ937QuC435goGDMJ
         Oj6g==
X-Forwarded-Encrypted: i=1; AJvYcCWcadCXXkFSF1/AUnYHAQsFEFZ3E9RLUL+5hl2BKOKweXD+MlJsHz+j4MNhiqIar7nTOeWCQfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19f0ZfULSmei7V0TnZmLzzEfKQAhnHIWkenQTTp1Jsg6SO0ia
	r4ESjF/LAQi127F2GxILYK0V/N8jz3A0YGnsQYSYOw4nsQmMGQ10LIbV
X-Gm-Gg: ASbGncuL3jvM+Nt0X/dzvQurV7BlKWvzalOJMRoj8aheGd89OWbqbMNwt4lEmlAnwoz
	mhLeCVZHskryKcHmGdfM52saVYslEQNuukX0tJXAuaGZZUjGvXphSipMYLol5rZAQ+gXteIo8Lt
	GZSgvND84revQWvhzqkusQZsby3l2alelOajdxurYI3z6SQLTd1tQrtPwrG33DiycZIbXSybyMe
	T9wkv9rBPU7Pg2QRmIFskMsuiTwGBz2SSWqchc0Zy7viPZ/jtxoXQXYI/GtPG88fnzKWZt6gRZL
	5FCpshdH7HVk5Dq4X4YeUr3Z16f3sRo4/YGsDqipNz7lw5aIRNqpN2SBqSXQVMspTZZeKnZHUv7
	l4R91nr6J1rLqcVdw6XlIdm0Z/4p92xF3lEOMIG5Nbprs5AwmkoaJ59CfrK9ngaISQ/uRVguoIg
	N3DfnSRFFZtQywm7ZgICn+wcSjxkKnT/c9lTXwOv+2J0yFqyW1NhHvOaen
X-Google-Smtp-Source: AGHT+IGg2UVCwGUPO2ALg7EHaUKW+Wi+Pkw0XTmmfXGNkVW/r/qLutpXRxnKp37lcMUpt8E4SQus8A==
X-Received: by 2002:a17:907:8688:b0:b6d:3a00:983a with SMTP id a640c23a62f3a-b72e041024cmr973604866b.38.1762811115633;
        Mon, 10 Nov 2025 13:45:15 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d1b4916dsm1075671766b.15.2025.11.10.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:45:14 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 0/3] net: dsa: deny unsupported 8021q uppers on bridge ports
Date: Mon, 10 Nov 2025 22:44:40 +0100
Message-ID: <20251110214443.342103-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/networking/switchdev.rst is quite strict on how VLAN
uppers on bridged ports should work:

- with VLAN filtering turned off, the bridge will process all ingress traffic
  for the port, except for the traffic tagged with a VLAN ID destined for a
  VLAN upper. (...)

- with VLAN filtering turned on, these VLAN devices can be created as long as
  the bridge does not have an existing VLAN entry with the same VID on any
  bridge port. (...)

Presumably with VLAN filtering on, the bridge should also not process
(i.e. forward) traffic destined for a VLAN upper.

But currently, there is no way to tell dsa drivers that a VLAN on a
bridged port is for a VLAN upper and should not be processed by the
bridge.

Both adding a VLAN to a bridge port and adding a VLAN upper to a bridged
port will call dsa_switch_ops::port_vlan_add(), with no way for the
driver to know which is which. But even so, most devices likely would
not support configuring forwarding per VLAN.

So in order to prevent the configuration of configurations with
unintended forwarding between ports:

* deny configuring more than one VLAN upper on bridged ports per VLAN on
  VLAN filtering bridges
* deny configuring any VLAN uppers on bridged ports on VLAN non
  filtering bridges
* And consequently, disallow disabling filtering as long as there are
  any VLAN uppers configured on bridged ports

An alternative solution suggested by switchdev.rst would be to treat
these ports as standalone, and do the filtering/forwarding in software.

But likely DSA supported switches are used on low power devices, where
the performance impact from this would be large.

While going through the code, I also found one corner case where it was
possible to add bridge VLANs shared with VLAN uppers, while adding
VLAN uppers shared with bridge VLANs was properly denied. This is the
first patch as this seems to be like the least controversial.

Sent as a RFC for now due to the potential impact, though a preliminary
test didn't should any failures with bridge_vlan_{un,}aware.sh and
local_termination.sh selftests on BCM63268.

A potential selftest for bridge_vlan_{un,}aware.sh I could think of

- bridge p3, p4
- add VLAN uppers on p1 - p4 with a unique VLAN
  if refused, treat as allowed failure
- check if p4 sees traffic from p1

If p1 and p4 are isolated (so implicitly p2 and p3), its fine, and if
the configuration is rejected is also fine, but forwarding is not.

Jonas Gorski (3):
  net: dsa: deny bridge VLAN with existing 8021q upper on any port
  net: dsa: deny multiple 8021q uppers on bridged ports for the same
    VLAN
  net: dsa: deny 8021q uppers on vlan unaware bridged ports

 net/dsa/port.c | 23 +++------------
 net/dsa/user.c | 80 ++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 71 insertions(+), 32 deletions(-)

-- 
2.43.0


