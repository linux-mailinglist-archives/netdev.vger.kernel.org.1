Return-Path: <netdev+bounces-194518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 501B3AC9D4C
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 00:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE6C189B54E
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5861DF73C;
	Sat, 31 May 2025 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhOM1Auc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC23383A5;
	Sat, 31 May 2025 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748731824; cv=none; b=tPzFTsD0BwpEz8Foe7tiKtVcu4ik6L94eYIfMJMroPHkuZhMDvozxoSH5cvUns/bess7skKYPaxtbetS6p790GWsMGZ92LWNmW6ut7p3pcEO0ql6toOtOo/WZ09mNTkbsK4DUra4ZKwJS8p1zLLjblkhzLHU7KvxDh1lfsHUI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748731824; c=relaxed/simple;
	bh=CDljdLyI8zl+8uZfAuUq8JMf+Jw6g97rHrHAVSBnzeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=odKpcNFoDyZcmF3SMPTSjuS2LfOlustdBzvhaVWF6iE+4vtdY+Db7QmBnOMAHvSQIhBGq/Gzb+Nc+Dd+3HmiimrlBSSqPCuEq7zmvwA8Gj4hKeqS4c5SvqqDwk5s0eC5uRPe6tj5HKFTwj/BKRAgu7e3vPOsjVtatIxDgdyMAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhOM1Auc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad891bb0957so567443166b.3;
        Sat, 31 May 2025 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748731820; x=1749336620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7G/6C3jgtD7GdYgkAdPqTbX9kf1O46KWdMnMdCZgM2Y=;
        b=hhOM1AucV+4vheHF3PCX/hTefLjVvGUHm/7DB6wBrJ5MzqrfDvAo92TeGjpVtkF0ql
         l3HDo8cpcrRR9lNLkCfV/C7ov4cXUOv6WzsZ6Wy3bgqLmcJxZOb6vniiw669clF9VFar
         ejd+fVaTY/qrP2Lm+lqaP5yckEXjIn9CYb7dlUUoQqWOah7A3yXkjWHenvVwnOP3/WJG
         NeAzpRcIDxtM6Cm3OTMASb5LR6SkcTQlPSNG9bKi40b2FkcJRiyu3QZoEVOnzX9eHZwu
         V6JQ14X4OBX1VakLhA2HjqnZmrbnYuj+fAQVzWI/QBP72bfP5VKZUtisPBZxJaIzsBJw
         wfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748731820; x=1749336620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7G/6C3jgtD7GdYgkAdPqTbX9kf1O46KWdMnMdCZgM2Y=;
        b=SdwreRBXt2aJH4ZgDtqra/UsVzobiSA/lnufIQDpL3T7dmZuZ9lgS54+BiyOhoFj8b
         ZKkybqPQee2uuahKcdpyo6YvJLvsio603BKItYecqgjvt2x6SADOQsXzredReYKpp52I
         EobZ8mUhzsA1+zEgfvml5ca8GnSxhBuOdtvhwNAU7o0HKnDhcRdFT555PEDZoI1VQfWC
         uDbksKFypKdfpVIFkj6xR5i8ERtwpEpEIApIFVjzrXxkeJ7DzrGqsfXdja/62hyzrV4L
         nbp/snyiU9l4VEfonskSa7qEHVVk/fs6iSFuQs80j2cINRi9Y9rtqYjq4K9/SHTk9Szb
         dI7w==
X-Forwarded-Encrypted: i=1; AJvYcCW2hlFthakMvL5OH8e+laGk0L18U6qJcQRbtWxrosUfKaeBtSU7248E4fyu9jItEB0PnkObrBrATKpNLts=@vger.kernel.org, AJvYcCXfEvugX0s+NRT72gSP64sJ5YIZOsfRfM773V3suTciefCXzGQXNnEHagynf+4e1BEF0VHCmeJG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3z+ZG/JhThc+LeSVgVgeMrt79qENhXy5Dm7uliI55kVSl4tql
	VwHgq/g49mAOUjDX0BTMAasIoWxstILt0xDnYFpaocQgJs4cceh/epU4
X-Gm-Gg: ASbGncuZlxGvB/he96/OEiwHWNHKEv+jFmyiRajTSNOurzvVKwC0HhvyJTjXSEBr6V7
	zTFaQf+eyQ5g9iwVmsobAPdB7NxtOigmN+uAYkfGIbAldiP3tYhokU+IYNiCWf2r9zNkLDp1Wq8
	as29Rizyy2KU3zwbzBP5uS+5qOUr8dJnBIyFVTebKfUPMc8a2MgV4TOnpwYAM8xeyk2+Hjvkgy3
	HmhqWtQd1sNAYCiQoL4hJ6NkAPza41M1j7GHpQiHYls6/mzUsN8dkV5WWrjY1k2r+4BK3GNSuES
	nzfJGHxLuETpb902pjLc3jjhhZJdP6g7w5UUll4dv0njUP15hSVI2Z5VaqgQV9u+dLPDt25l1Hq
	vDZUpwYo=
X-Google-Smtp-Source: AGHT+IGCCzztJ6RHksc/IC2sk3PgFwdX//BlNQdfw986PcEhon6Zh3/6SfH9ygn47oYXUSUuBuSKww==
X-Received: by 2002:a17:907:7241:b0:ad8:9878:b898 with SMTP id a640c23a62f3a-adb322b3333mr649109266b.9.1748731820162;
        Sat, 31 May 2025 15:50:20 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7ff054sm562918666b.14.2025.05.31.15.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 15:50:19 -0700 (PDT)
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
Date: Sat, 31 May 2025 23:48:51 +0100
Message-Id: <20250531224853.1339-1-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


