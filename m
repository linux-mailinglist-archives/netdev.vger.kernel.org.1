Return-Path: <netdev+bounces-59952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4FD81CDA6
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 18:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98022866B7
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D17D28E17;
	Fri, 22 Dec 2023 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q3k0cDpD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB928DCB
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e3295978aso2668143e87.1
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 09:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703266597; x=1703871397; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GRRqwNTeln7AqmPD355mpYiA2677w+gW66bx5JAwu9g=;
        b=Q3k0cDpD5imkukXPlK1B//iCBzV1CK3RpKzngHC92p8gAyEHHkaapqiOpseBZS2Y6W
         dd5DMd7c2+b5NvR3wvBGzP1B/NZm6UHONAGnPF1JpOjoXcGqP+v6N154LJdL91HWo9BT
         s5uEWksyI/jjhJSqa9YD3rjzAvtgiQhuHpeTe+gL3fb4aYYlrg5lS92negT9ApImIphR
         vb1zOlgixxJnRl0rPS8HKdWLwNejccKQXParAMVUTPrlhgpbFH/qWQAAunYSZhgi6who
         F4cTlie3cZ5BBKJNICz05610En/asN4X8qCV+ZlTnewGF8cHy0g3AKazfLruMi7l0RDG
         wPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266597; x=1703871397;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRRqwNTeln7AqmPD355mpYiA2677w+gW66bx5JAwu9g=;
        b=DCS5GHao6TxjdRd6gzBa6P0bfAQhqBnIT6zJPlxspWSQKdNF1/U050rDzEcyKeafde
         ISvub9YTn4lw2F70370uxXiLlbUXI+QlbcZzh+N3cWjO9k8NxZshVcOtxByc/vmGBf78
         jO00jEBoi+gj62gt/jbTb0hQE1vwTqkw6v5aQ0SkBK/neGeCSuLvM/VQwZqzx+gmCUb9
         JE7t8TISXLk1Y8bsT9ey6+9gaz8TC/+AuVHE4QMj4oGb2Zwq//tuJHeMlGsCS5T/v/QY
         rnuCWBHfLJJfgEgGbU0kbE2bOvoDp0Nl25KYXIWkSEUeYMg9HFEw6Jnzo8ZNwYSDU1hP
         uARA==
X-Gm-Message-State: AOJu0YzUKWCYNQdrcWM45FHzbwsN55UV8C20ZHYB1eQeh0Q45A6EVaqm
	SlfnteJS7/YR9Jsa8AMK2Ex16g0U+A+xvA==
X-Google-Smtp-Source: AGHT+IEtx8yLnVnzvo7D4FZIQdIfRojh7dZCireBKzc0PoMsNmMiQgrmN/XKJjtXhT6xr+X9Rii+eQ==
X-Received: by 2002:ac2:47f7:0:b0:50e:1b2b:f2dd with SMTP id b23-20020ac247f7000000b0050e1b2bf2ddmr832523lfp.53.1703266596758;
        Fri, 22 Dec 2023 09:36:36 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h14-20020a056512220e00b0050e709c8deasm43036lfu.226.2023.12.22.09.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:36:36 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net v4 0/3] Fix a regression in the Gemini ethernet
 controller.
Date: Fri, 22 Dec 2023 18:36:34 +0100
Message-Id: <20231222-new-gemini-ethernet-regression-v4-0-a36e71b0f32b@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLJhWUC/4XNuw7CMAwF0F9BmQlq7BAIE/+BGPpwW0uQIqcqo
 Kr/TigLiKHj9ePcUUUSpqgOq1EJDRy5CynY9UqVbR4a0lylrCADNJChDnTXDV05sKa+JQnUa6F
 GKL5fNZZuBxX5sq68SshNqObHXHBS6Vad07Dl2HfynEsHM68+vtku+YPRmfaYIW6tLQjweOGQS
 7fppJntAb49t+hB8pwtwXlrsKrzPw+/PDCLHiYv966wuLNFTfsfb5qmF10YLhxyAQAA
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Household Cang <canghousehold@aol.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.12.4

These fixes were developed on top of the earlier fixes.

Finding the right solution is hard because the Gemini checksumming
engine is completely undocumented in the datasheets.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v4:
- Properly drop all MTU/TSO muckery in the TX function, the
  whole approach is bogus.
- Make the raw etherype retrieveal return __be16, it is the
  callers job to deal with endianness (as per the pattern
  from if_vlan.h)
- Use __vlan_get_protocol() instead of vlan_get_protocol()
- Only actively bypass the TSS if the frame is over a certain
  size.
- Drop comment that no longer applies.
- Link to v3: https://lore.kernel.org/r/20231221-new-gemini-ethernet-regression-v3-0-a96b4374bfe8@linaro.org

Changes in v3:
- Fix a whitespace bug in the first patch.
- Add generic accessors to obtain the raw ethertype of an
  ethernet frame. VLAN already have the right accessors.
- Link to v2: https://lore.kernel.org/r/20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org

Changes in v2:
- Drop the TSO and length checks altogether, this was never
  working properly.
- Plan to make a proper TSO implementation in the next kernel
  cycle.
- Link to v1: https://lore.kernel.org/r/20231215-new-gemini-ethernet-regression-v1-0-93033544be23@linaro.org

---
Linus Walleij (3):
      net: ethernet: cortina: Drop software checksum and TSO
      if_ether: Add an accessor to read the raw ethertype
      net: ethernet: cortina: Bypass checksumming engine of alien ethertypes

 drivers/net/ethernet/cortina/gemini.c | 62 +++++++++++++++--------------------
 include/linux/if_ether.h              | 16 +++++++++
 2 files changed, 42 insertions(+), 36 deletions(-)
---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231203-new-gemini-ethernet-regression-3c672de9cfd9

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


