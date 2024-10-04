Return-Path: <netdev+bounces-131914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160D98FF03
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA621C22031
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A87413D2A9;
	Fri,  4 Oct 2024 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHQ1QOFf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAC179BB;
	Fri,  4 Oct 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031644; cv=none; b=JT5CwJYMUJvcBBTBNFb/A0vywoCY3/b8oAGqZk9dYfqJnfyFg3R8N6Zjy7HDazJxkQIGs9Bg2kZ3EkuoYgbm+knmK3E3YG1qrABNHfENAT/XvLApcSH5EhWMo2HkeNBqZUXHQ5DGtu3nS+uEhHxPqpsh3JrbB/TLnEq2cJe9XFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031644; c=relaxed/simple;
	bh=S/mtysJ+SnAvkGVSn7jpeG6A4WkS4GStEEJvAXH7Us4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qzzxOcEYCraa6VX3nqjjWAg5hNDT5Dhj1gWh/kI87iPDNT8IfpGunrZt5UGbNJeQWMtQszl15A5JCEFnLjR+dBjn67ct20J+qYEe+kcg2tXzvn7AOD3udHxWjvfrjBkvXOe8XVoIRjIjjnC9fmb7DnUQeX26jcjvFhRiYhHI3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHQ1QOFf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2facf48157dso20769891fa.2;
        Fri, 04 Oct 2024 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728031641; x=1728636441; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/gMAqx3YAfBdraUdRz64TKXx5/XCsIKjgPgTol4xoE=;
        b=RHQ1QOFfcktGq7rA0tVL36qFeaLeie0pZjqMcxI3nychLGpiXlXOt3jxqCh7A4QGB6
         5Onzpef7XCmD6tQGyp3GoqY4fC15y41v2bUhu8idN2jWfSkfSc52eHXeYnzXMVv0X4rS
         /lcupZsykqoIvxhbmS2nGYKT7ewX5Rd2v8IBAfvozbmlO70HMIWZsI5XOUp3L9mJFrO1
         2DXZrSTfa/xdJKnOuZ+/6+8hUZ5U5bP91nVdTa0vGQwqKidn8BfPDr0te3YYAdiHr4Pl
         MUEew9yEfGBeAiscxzoEkW3aMvbN7LpDOE9bmInK2LNiE7WRrA++y+LD9154sktfz230
         UjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728031641; x=1728636441;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/gMAqx3YAfBdraUdRz64TKXx5/XCsIKjgPgTol4xoE=;
        b=GAYOT2MQfNgUmivT9lxIDAUlp0JPn8xwCuWmnSVN9ed+V2zNZl6xsjSaJ/t9t4BIh5
         UEibLx9xb0mei7qXqiz6N4aDItBSEPqPT5bbNd0bzaxqEnaA7RvN5oqGfGipea0cU44p
         liulseYcX9GuXGd/m13ioNpanS1duZh6YDk8lzHyegISQGUXSi8fF8xvPTvrSX3zrzcH
         gmr/TA0RDg9W+xD5eP6Hf7Oicpoc+0ZqtE5OpGlMVGJJxUBBvBwJ6JUjRe57VqDwJ+3+
         D72+primxnOgSg5DgrdnH+RcAEj1jdl8yWlI8E3NM7jErjLNlfH4lGjd0FCT9oyrGrAF
         nVmg==
X-Forwarded-Encrypted: i=1; AJvYcCU3AXRTuMjqf81PRoFyDG51/zRj2I9eJxwRV+/gom0BMQuiebqTvVdVymrXiY7SGGEn0t2mAtCkPYRb0XM=@vger.kernel.org, AJvYcCX7U4OBe9vgJY0Ok+insJ3UjTluEzrHKHinzHpEX5W74iOKKEkl7AUjSuMh41FFxRMvGXZHTT/j@vger.kernel.org
X-Gm-Message-State: AOJu0YzEN+u/dF5X59i56CoJh1lKziMkftqLVhk5DyTKuMOQuW6q+lFV
	r1bYMMg7XSg1KUd3zHLA6EG0eSARdofdvhjcjMQvwi04Jd/e+6x6
X-Google-Smtp-Source: AGHT+IEQ78jEiDdrT9fKfs+ZsduDzr4bWmCtUq8cpX+7tpOQHuNmFPY2rU9EorfvSH0VGm2CgI6iLQ==
X-Received: by 2002:a2e:241a:0:b0:2fa:dd6a:924a with SMTP id 38308e7fff4ca-2faf3c1c9dbmr7996591fa.24.1728031639524;
        Fri, 04 Oct 2024 01:47:19 -0700 (PDT)
Received: from localhost (dslb-002-200-173-220.002.200.pools.vodafone-ip.de. [2.200.173.220])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca3fce32sm1606973a12.57.2024.10.04.01.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:47:19 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
Subject: [PATCH 0/5] net: dsa: b53: assorted jumbo frame fixes
Date: Fri, 04 Oct 2024 10:47:16 +0200
Message-Id: <20241004-b53_jumbo_fixes-v1-0-ce1e54aa7b3c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSr/2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwNj3SRT4/is0tyk/Pi0zIrUYl1L07Q0M0uDJMMUy1QloK6ColSwBFB
 TdGxtLQD6frDUYQAAAA==
X-Change-ID: 20241003-b53_jumbo_fixes-95ff690b1d9e
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Murali Krishna Policharla <murali.policharla@broadcom.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

While investigating the capabilities of BCM63XX's integrated switch and
its DMA engine, I noticed a few issues in b53's jumbo frame code.

Mostly a confusion of MTU vs frame length, but also a few missing cases
for 100M switches.

Tested on BCM63XX and BCM53115 with intel 1G and realtek 1G NICs,
which support MTUs of 9000 or slightly above, but significantly less
than the 9716/9720 supported by BCM53115, so I couldn't verify the
actual maximum frame length.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Jonas Gorski (5):
      net: dsa: b53: fix jumbo frame mtu check
      net: dsa: b53: fix max MTU for 1g switches
      net: dsa: b53: fix max MTU for BCM5325/BCM5365
      net: dsa: b53: allow lower MTUs on BCM5325/5365
      net: dsa: b53: fix jumbo frames on 10/100 ports

 drivers/net/dsa/b53/b53_common.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)
---
base-commit: 8beee4d8dee76b67c75dc91fd8185d91e845c160
change-id: 20241003-b53_jumbo_fixes-95ff690b1d9e

Best regards,
-- 
Jonas Gorski <jonas.gorski@gmail.com>


