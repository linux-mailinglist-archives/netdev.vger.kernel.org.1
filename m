Return-Path: <netdev+bounces-51588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67E87FB4C2
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F822814E7
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D44519BA7;
	Tue, 28 Nov 2023 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPN7G0yZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C2AA
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:08 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cd8ce7bf7fso1882267b3a.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701161407; x=1701766207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d6jxsJU6hCFNidlpzv7Q9HkCZpEhz6RIrVX8MfVKe0k=;
        b=QPN7G0yZZjuxxOa7veTG86yG+Df1caz8A7VfJURODmfDnsrOWR4tAJRDKKxvBkYOMU
         V+HJQv2CKX2XqptGn06mNzUl9RQIOXPGsOozu9KaYiHPrdRIsaqpauvyPhua16PAqLdk
         +Gs/yhwsSnILlle5fkbPIFs/LGRzLe8Yoj6AiCz+LiGSbg2mhM+Yncp29IOJofpd8xhI
         rvU1gw64gTrae9AU3nLBfvtiPy1iTYeUetQxQdGS2TS0M3f3L0X4MFS0+opk0W7uO/+K
         kCm77M3GiqS9EAKuCpukbqNbCzbJZ2yrLb4dBKBCUqLhGlrLRuZf3y4qsUbQtxjrGow+
         w/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161407; x=1701766207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6jxsJU6hCFNidlpzv7Q9HkCZpEhz6RIrVX8MfVKe0k=;
        b=LMz8IyrBZT4KeognrqJEynh3X33KFKQpkG2BBBNaA2gqA3phfBbBPrlslLTXZdBaiV
         4kSU6VqfgmjCbIcE2yfoGxYQFABdewcIqqORTBtsrj9W8NOeHmN2F/s3W03jKud93vdZ
         n7pJr/7kNehUW5zjOVaBWDlie7RJx/QwpaGtZOy29jooxOnsuriB0ZkLz+IwerXm4RUS
         +r59zsAl+tivd1pjsAIxqPt0LU1itRTKKvVEt9HuSfWOt2kJ9BFtBDHxPyATUGF/rN/y
         o4fLN+tB5XoaFR/YtT1mGcSqVsQ7A52Gxq6nemZiOesuOb21yyFjEmOdOm+OTSv9q36V
         5zaQ==
X-Gm-Message-State: AOJu0YylTCAF6H3l2dJKLB2EfGNH5GyOoeXO7JvCjP/rFZDe9sbdZAIB
	7Fgz86RVNu81lK2fLxVIQbgLyU9hlEf/Kbty
X-Google-Smtp-Source: AGHT+IGxxf7YRrBQc+q2yUdhqqhzOJKN9vhdydp+WhLmjQuiGwXYgM+jgA4Ch4fB6zbZ7q2TWfZyjg==
X-Received: by 2002:a05:6a00:2da7:b0:6be:4789:97ba with SMTP id fb39-20020a056a002da700b006be478997bamr14187841pfb.3.1701161406720;
        Tue, 28 Nov 2023 00:50:06 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cbae51f335sm8766513pfn.144.2023.11.28.00.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:50:05 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Marc Muehlfeld <mmuehlfe@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 00/10] Doc: update bridge doc
Date: Tue, 28 Nov 2023 16:49:33 +0800
Message-ID: <20231128084943.637091-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current bridge kernel doc is too old. It only pointed to the
linuxfoundation wiki page which lacks of the new features.

Here let's start the new bridge document and put all the bridge info
so new developers and users could catch up the last bridge status soon.

v2 -> v3:
- Split the bridge doc update and adding kAPI/uAPI field to 2 part (Nikolay Aleksandrov)
- Update bridge and bridge enum descriptions (Nikolay Aleksandrov)
- Add user space stp help for STP doc (Vladimir Oltean)

v1 -> v2:
- Update bridge and bridge port enum descriptions (Vladimir Oltean)

RFCv3 -> v1:
- Fix up various typos, grammar and technical issues (Nikolay Aleksandrov)

RFCv2 -> RFCv3:
- Update netfilter part (Florian Westphal)
- Break the one large patch in to multiparts for easy reviewing. Please tell
  me if I break it too much.. (Nikolay Aleksandrov)
- Update the description of each enum and doc (Nikolay Aleksandrov)
- Add more descriptions for STP/Multicast/VLAN.

RFCv1 -> RFCv2:
- Drop the python tool that generate iproute man page from kernel doc

Hangbin Liu (10):
  docs: bridge: update doc format to rst
  net: bridge: add document for IFLA_BR enum
  net: bridge: add document for IFLA_BRPORT enum
  docs: bridge: Add kAPI/uAPI fields
  docs: bridge: add STP doc
  docs: bridge: add VLAN doc
  docs: bridge: add multicast doc
  docs: bridge: add switchdev doc
  docs: bridge: add netfilter doc
  docs: bridge: add other features

 Documentation/networking/bridge.rst | 317 ++++++++++++++++-
 include/uapi/linux/if_link.h        | 521 ++++++++++++++++++++++++++++
 net/bridge/br_private.h             |   2 +
 3 files changed, 830 insertions(+), 10 deletions(-)

-- 
2.41.0


