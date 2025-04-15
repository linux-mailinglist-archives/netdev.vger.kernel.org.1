Return-Path: <netdev+bounces-182972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0229A8A7EC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993E43BAF00
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F54124C084;
	Tue, 15 Apr 2025 19:29:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4F2253EA;
	Tue, 15 Apr 2025 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745351; cv=none; b=F0KdJsWwBEZBN9zgJcOtSzsLpzDejbl+LJjQ+DOI0nxId2a2zjSxeA1QUmeCvvGkm7kukDAlt+KS1uvIqIVzNeP+vX68thw2dckPug2hldcn8p5HTPm2SqyNGXAOp7lQmx9QRFjTF2yDQW3K/6gOnrYvXYP3i/ZusmsWxzJezv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745351; c=relaxed/simple;
	bh=qYFgW9cO2j3r4Y4bjSag9OXsXvtHGnkNjfdzE+X2aog=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rcM+fcaqstqnCwFFVOwRGm+qz8o+WAbeGs69uQa28glTwLO8zXHS26gKUTXJBjVzm5wYbb8CIQ8lRWt/QAlHMJWNO+O1rV2PTjaKSdct7fbRkHk1/RUG8HLph1sd7pUQK/W7g0IC+XPnEejAIHB39Bp5OKmM7Q7aIBH+HzEM29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2963dc379so990179366b.2;
        Tue, 15 Apr 2025 12:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745348; x=1745350148;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BULPY+oq8sxA3RyWgkFUWi/i+GDRhDViuJbnfK7N9TE=;
        b=G3amvGkLPKyTbqD9Fq1sA5ggrn73aXz8G9WB8W/gyCd7W5ypelq4plK/H8zzwC1eed
         u2suLZjYiI7C6TDbazvU3rYnzq6FrIACtN5ZT4kDdn8GLWxO9G/8+5PlUQ//pDC0LXiA
         8ggwyfQx91dXNa8Yq4+FsrqlMoWRkka+PC4IB5pHq29uWVCsBdvqd+8NYPeqJ+New0r0
         2vffgnUlsQjS5yjKewKMcW//kWf2CiYDjfAkF3G1MC34prZJTTy6kd8q4BvTQgD1FaEH
         XQG/bSuYpzrj3R7GRGmh6Dcs6NmNaL4lgqzXPz2a/Bb3bMhGdwO0UYrAPBEZnsWezpXr
         qRmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu3DegexEGB4KzFjbC/BinvPmaRua/4yWuJHnxY53WzplCv60sRs+LQt0mdR7gieDtcecvJ1xtjLM3Qb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAoNzt1/FgKu4GKIRZe4mFhD5ZRsp1RPUbW416ylltkowa2Rh0
	b2wmUAoG96pUPjbvAN4RGNd/ZG1Gn3gk8RoZjPTkmL3WO9QbOjw0
X-Gm-Gg: ASbGnctYLxhIE7MEbaurki0SessSVf6IS+ougCvNZuX1zRzLMiJUK1+IbaWFBHX/lI1
	mk4IcmnmcB3gqVWaFJcC10gQtle5lQFxowULbZubLjD/TP4WxbgfXPJA3s2vEvoc+YIHTX1zrHl
	poai/DoMrvR9qy1gs5GNrQIgVo2RiviGTiUlpxFAcwsWqDstmW9zZ5MWHvz6urNq6A2r4REccIg
	tiueGw6niTNdCavbY9WGzlUzOsz5we7s0JpUbyZmlO3RoXzvXtKU29hXKWqJYOYT/m+DlywJp0w
	24U37UorpbX5ZUC1S1IeuVBmtbQT3FM=
X-Google-Smtp-Source: AGHT+IEppBwCsuEiop6IdyueTkb8qH67BkId9QBu7Ox9LcxrrnNUAiLJJQ2/2dD/xyvNQv2Il8SNmg==
X-Received: by 2002:a17:906:7953:b0:ac7:e80a:c709 with SMTP id a640c23a62f3a-acb381bb5d2mr25016966b.6.1744745347532;
        Tue, 15 Apr 2025 12:29:07 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccacecsm1133512466b.127.2025.04.15.12.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:29:07 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/8] Adopting nlmsg_payload() in IPv4/IPv6
Date: Tue, 15 Apr 2025 12:28:51 -0700
Message-Id: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHOz/mcC/x3MYQpAQBAG0KtM329bu5tN9iqSxGCKoV1Jyd2Vd
 4D3IHMSzoj0IPElWXZFJFcQhqXXmY2MiARvfbClC0bXLc/d5Y235dCHkauqdigIR+JJ7r9qoHw
 a5ftE+74f5ZoAR2QAAAA=
X-Change-ID: 20250415-nlmsg_v2-204ca5de7791
To: kuniyu@amazon.com, "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=leitao@debian.org;
 h=from:subject:message-id; bh=qYFgW9cO2j3r4Y4bjSag9OXsXvtHGnkNjfdzE+X2aog=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/rOBHzuDIiTXCRiOob2OzsfIn5BQO/bqZ2qwt
 Ncdsdm9UkCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/6zgQAKCRA1o5Of/Hh3
 bSeoD/9AdESyBqoiW2jTUS8EttolRJJ1WH1IaVivGQLi37O1RUJA8tjNPBJKgjB4yJQdHmu3nzM
 KbhvpD6oxTRxowG8JFzJnKYCD8pYgkf+7v3AhO604oF4jmgdVA7DxE9hpYmRXPbNAm/wI9wOqdz
 m8raKSlFjFI7HdJb1f2PiF7/FEptT7SsUhyh/ankLB9RcnR4tXaYjps0R3SzdeD4qRJX8LApWz+
 q2/gF2jNkWPlvwx5+lrtgzq09mLtvxmpUJ9TbkphjQMTX76xsHad5rKK1gBCLMUxTRo+pCVTB9m
 eXyffBLFiYeFFnXuT17tPNXhufqZ4IkW12ht4Oh31QtPCeoIwGunv8b5V5EyhwiM+2i5CpDHKoi
 dSVrQFtc00Jchbqoc7s03oRK0+P8CGmTG8zgTi24vZZPzdjul3rVhFMbb+JWv9GngvD8GWv0IWN
 dP/ei3wfl0watVf+tpmXKsdBim47kQnTd+xvZn54Zp4PbwXL+lFrNB4w7k1MLBtgwyNfMJftn+u
 iMblCY7h2bAMV6IOxB1pkIU8XQs6y79kMrUaYvTrU5JEgy/BNjAWs6O8qBIVSmmubuCQ9EPBJd6
 mwg5+EieLn9nqPFV8ftrKtrZp2y+u8mJ6x7m6q2oCPx//VDcIxLYwM3XT9vtkZ2EWosUUsJuv+2
 XmE+js/MMEFwSOw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The commit 95d06e92a4019 ("netlink: Introduce nlmsg_payload helper")
introduced the nlmsg_payload() helper function.

This patchset aims to replace manual implementations with the
nlmsg_payload() helper in IPv4 and IPv6 files, one file per patch.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (8):
      ipv6: Use nlmsg_payload in addrlabel file
      ipv6: Use nlmsg_payload in addrconf file
      ipv6: Use nlmsg_payload in route file
      ipv4: Use nlmsg_payload in devinet file
      ipv4: Use nlmsg_payload in fib_frontend file
      ipv4: Use nlmsg_payload in route file
      ipv4: Use nlmsg_payload in ipmr file
      vxlan: Use nlmsg_payload in vxlan_vnifilter_dump

 drivers/net/vxlan/vxlan_vnifilter.c | 5 ++---
 net/ipv4/devinet.c                  | 4 ++--
 net/ipv4/fib_frontend.c             | 4 ++--
 net/ipv4/ipmr.c                     | 8 ++++----
 net/ipv4/route.c                    | 4 ++--
 net/ipv6/addrconf.c                 | 4 ++--
 net/ipv6/addrlabel.c                | 8 ++++----
 net/ipv6/route.c                    | 4 ++--
 8 files changed, 20 insertions(+), 21 deletions(-)
---
base-commit: 96f8bf85d11acdd3ebc9a91f41cb18eac6f8e26d
change-id: 20250415-nlmsg_v2-204ca5de7791

Best regards,
-- 
Breno Leitao <leitao@debian.org>


