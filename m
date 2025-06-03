Return-Path: <netdev+bounces-194834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B79ACCE5E
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89C8188754F
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962901474B8;
	Tue,  3 Jun 2025 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdWCfhf5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194B19ABC3;
	Tue,  3 Jun 2025 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983748; cv=none; b=kSTEFaOFohXcAKjQbLvvYXhPRXCCKfn5HgOt9x1TYsiZVwYV06liUJ1nNmGbTe1q7kBwE970UsubO7DtvjM4kV0LciTtCaIlyKy0tHL87NLWamni3RwbBX78mQxVHdymnD9H8Zeb8EujmIOd+7gqqilYbKn+RkkiZCKk/bEC2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983748; c=relaxed/simple;
	bh=uamU+kMXc6rwhWtx3UJUQaoWboHSUmWfDCk9ETTsXRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nKK3sPTzBykj7F7BPoFXX+5aGVof491YioGDx6VwN7zEQQzEzGFVYp+FCzcrdgVXEPUS5Gh0C1bHofjmH2hmL+aUwoWutcrR8DpsubYgB9TJfsQBnRpulm6bu1MmpacDGWyAUIISzueplex3HjzZCLNi6HQs4D5I0Dos5u9k0tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdWCfhf5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4fdc27c4aso2163915f8f.3;
        Tue, 03 Jun 2025 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983744; x=1749588544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7W3ZF4Xa0Bh8TC5ljpqLlRfaqMimqDP2/UGKib5BDo=;
        b=gdWCfhf5J+hdCrO9LswXIUL3QmEuBsRIj3u1Jd1DlQhul3uRhJT9/IGPXtQQj6ZLvz
         xVy1YJ6OTwPCvd50zJl5MhOC+ZDvHW6VSmTL725daGj19GHm9rwZunQNPQWke/CUU6KJ
         aJGO4Dt7txEalgK1WSpSPE5FXi8GGVt/3LxoCizuVCEKAO7kGzLR72+hjHF1PIt6p5vk
         l1qlSNLdj+7ha1W4gfKuASGOt2PX+3AZ3fZn0ILuDnUSpGXb14mEOIVXnVHVUs/4411J
         Ll0bJONjS4gVX0uoDcE/sqywl9iys/T0oeOiMyQtE1RhbDAarg0LAgSfCWuPL2GsGskc
         f6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983744; x=1749588544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7W3ZF4Xa0Bh8TC5ljpqLlRfaqMimqDP2/UGKib5BDo=;
        b=u7ek3Q1g006tcaz7ywmZJgR8AU8j8xZbmzoWGF7FRmTeLrWTAJ/KFl2Cc7lFBnlS6y
         VjNvHz+DoE10XODZtJA9u1oefDK40dijib3f6KoTxCzWX/pw59OCBIsDkVsPEr8/CgIa
         Iu5/Ewq6e0+XPRHebQZMY/oP8n79E+8+PHiQZ4zVJW8HTGO6kVCTZ7GdBks1JnBk5v8j
         Rix3vpYefCRp06U+RqHB/pHt+wvs2YEni+bhExsDLuUUoPPmfRXp0+4+1IH208lFhKye
         FWbXFXPs3/lnjW5uylNX0pZBv9gg0kRGBTFJLc6r0tgjDHtI12fsGmQn0wQnEFlWoaOW
         vJXw==
X-Forwarded-Encrypted: i=1; AJvYcCWIxBrDHTvOe1/4pwWRdNkkd+GYDK4IUuxTKANTT84XTVeF+K0KcsN27E3a0ZDkMhz0AiKlKmmd@vger.kernel.org, AJvYcCXdP23bgnuS+C63KpgKGMIJMnrwaA1d2WA9BzTi9AX6IhbNf9RiXEfEii28U/Artt8gwTod15ksMYpBTV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMXH1XY+0rmENN7oJp/tdeAHGm8MqG/xA1aK9fqBdTeZ3M+jQZ
	yF4yrZlaND9A9KoZDOxa/BE7bb+dkJQb6EMJF6yt8Qaxwx23TSAcZhYC
X-Gm-Gg: ASbGncv989Gy2d0xXebl3RtlE1e5KcWddeaMJ+SYM4+jgpyf+UEC2rZd+UHc/4kMot7
	4ig1akZX+FzYWvVw06NJjgyVKcSw8ajbiDrDrdpzJD/gYye8qB0wxtM+QRvqN53BCP3n2rkJMCD
	OhM2/Cy+bir6s4w9Zgsca3n+mTr7ZeV08j1hTrpfEXP0hHTio5ALJCQLYfKKIGvYBSy3jdxVGNP
	fZ2nqckv5FEObQu3MKn+12rg+ydOG9/eNsUjIdeGAM16VTSfx8j6oTN6a19admtMbPQcTyffjWf
	2J4rvTDYbJNGCwGC3kXjRzW47OH5raMmV5DNA5RzGKo6KdaYqu3TE/IAuZRnO/WVDB4ncwIMTJr
	pSZA2Xsy9uvI+7yA9CIDulghVYNz6K3DbQ8qrgIpH8IGso4xQshm2
X-Google-Smtp-Source: AGHT+IFxODhTA4FjCqfl65GUPD+pt5gWwWMPs4JCLRSuz21Se5qOusbYl27aSwKwb4mAgm5Gk8NfNA==
X-Received: by 2002:a05:6000:1887:b0:3a4:c6bc:995b with SMTP id ffacd0b85a97d-3a51d961c14mr156915f8f.35.1748983743831;
        Tue, 03 Jun 2025 13:49:03 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1500-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1500::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e58c348asm26258225e9.3.2025.06.03.13.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:49:03 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH net-next v2 00/10] net: dsa: b53: fix BCM5325 support
Date: Tue,  3 Jun 2025 22:48:48 +0200
Message-Id: <20250603204858.72402-1-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These patches get the BCM5325 switch working with b53.

I'm not really sure that everything here is correct since I don't work for
Broadcom and all this is based on the public datasheet available for the
BCM5325 and my own experiments with a Huawei HG556a (BCM6358).

 v2: introduce changes requested by Jonas, Florian and Vladimir:
  - Add b53_arl_to_entry_25 function.
  - Add b53_arl_from_entry_25 function.
  - Add b53_arl_read_25 function, fixing usage of ARLTBL_VALID_25 and
    ARLTBL_VID_MASK_25.
  - Change b53_set_forwarding function flow.
  - Disallow BR_LEARNING on b53_br_flags_pre() for BCM5325.
  - Drop rate control registers.
  - Move B53_PD_MODE_CTRL_25 to b53_setup_port().

Florian Fainelli (1):
  net: dsa: b53: add support for FDB operations on 5325/5365

Álvaro Fernández Rojas (9):
  net: dsa: b53: prevent FAST_AGE access on BCM5325
  net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
  net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325
  net: dsa: b53: prevent DIS_LEARNING access on BCM5325
  net: dsa: b53: prevent BRCM_HDR access on BCM5325
  net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325
  net: dsa: b53: fix unicast/multicast flooding on BCM5325
  net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
  net: dsa: b53: ensure BCM5325 PHYs are enabled

 drivers/net/dsa/b53/b53_common.c | 255 ++++++++++++++++++++++++-------
 drivers/net/dsa/b53/b53_priv.h   |  29 ++++
 drivers/net/dsa/b53/b53_regs.h   |  24 ++-
 3 files changed, 250 insertions(+), 58 deletions(-)

-- 
2.39.5


