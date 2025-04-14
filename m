Return-Path: <netdev+bounces-182205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3AFA881BB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A29188EBA0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8C117741;
	Mon, 14 Apr 2025 13:24:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1D23D2BC;
	Mon, 14 Apr 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637076; cv=none; b=FM5pe+u5UpFPo9bzoHNUwlGLCUc5F7xBMGkfhNQ71qBHMg1ZcmujmC0fLaxXM2n7KAPtGnV1XL+KMCC7djc9j8FIdGvKkkbo1uli9BgBosgvIGFCu+/vvF3xX6sb6erdubb3f2a8pRu2RCHhg/bR3miZidWhF/TukhniBE3yh7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637076; c=relaxed/simple;
	bh=uP6edEq7t633Nn/6CTGhpfDqtsCprN7gaqMik/FbLAM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tls90WvIKE1GFnMUpmqqgB3R3Z64qMbAUiUA9/A2pijSY4yUlHMCwU7b3nYcPSPHdTWP1mTNi0HuKOjaM41YWq+RpOw0ND6j+OriP38JAU5wodgp/+JYQ7DSsiYEkIup+EW8PdVmI12L3Hs72Nng9sh4n0Jw1zReRmUq+aRTWII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso7987998a12.2;
        Mon, 14 Apr 2025 06:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744637073; x=1745241873;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAxtJefrjwh5IULoa1zF489O5jbehHY+6Lx6oX0IOlo=;
        b=W2pD/ewv9coAR4PHQpbRWb5RdD6K0/w93cS0+Rl/vrM3lr6HLkSKCfIWUcG3MBoHpm
         +OeVQT5frqxgjUDr8COOjMWyXu2WZZuzMEkSmLNwBHDC63YXFZWUOAelPApZsUAgk7+R
         uBQdKUc/A6pe7x1vYuzV6eAfFLvB7t4QdJqR4hKT86XnzPklNTa6a6/nop6P30Pk52qk
         X6Z2dC0tQ0QGOGZJDObsMTU0tGn1QNgg8XYjW1QxRg/0n/jJ7+Uafk4+wcUystYTvc9u
         9U9x0yPvgWRPUek3iTkFoehABS6Nl8pghIgzt9b5vrgrTxqHH67owtiu9wMB6b1ZuEnp
         BwMg==
X-Forwarded-Encrypted: i=1; AJvYcCWlgZwjgWa7J5HohNoxu6ryv2ue6dMhWNFROQ4PG+yitViczMk7ZYPbL54JLSN/I6d0rNWxo0a0SHAef5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNWMDbjbVf6/h5kuJCFscG4KTLuq6ON4bMNjZBLhk3jUPhgFfC
	GyPJorzVAPJswVFCRhNaPlMEx8TrTawLJLS6jQr8nMN2C1kA3ORp
X-Gm-Gg: ASbGnctK4Xqhi/NyhSTWnKpTHXiTMWp9io1o8O+jLLA3WhBU2byd3wPQldGYn3hy1la
	a6hGtnTVP+T5iviqF98oUVsZcInOXDsGXwPbB7lMWmHkpmWaqrgsvsrPKXsYtwYQhB7ecGTmKJw
	TXK/uhVF+KynskF/KTDwMXJX6SXexPctoCRQBJFQEe3gEK6onL6LNCRKB/Qwv5qvQ8magmEW3ii
	GeqymqheCMEgi4zp1FLS6k5xw73W3uMwK/WLTxICc1eFuYrrsRhS96ZnafW2Yaml9VpN5TVx+Jf
	iQ/il1i13DQsBFClEi61synGO3fgy/LI
X-Google-Smtp-Source: AGHT+IGca2oW0Wv3ciaboHXoM9P471sCFeqEbO7M5x6+WVhS89iTsosJPKIF//IYhQqrVUXazI69NA==
X-Received: by 2002:a17:907:7d8b:b0:ac7:2f8b:6844 with SMTP id a640c23a62f3a-acad349a0aamr916033266b.23.1744637072508;
        Mon, 14 Apr 2025 06:24:32 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccc3a3sm907370966b.139.2025.04.14.06.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:24:31 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 00/10] net: Introduce nlmsg_payload helper
Date: Mon, 14 Apr 2025 06:24:06 -0700
Message-Id: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHYM/WcC/13NQQqDMBBG4auEf21KEk0prnqP4iJmpjrQxpKIW
 CR3L7js+sH3DhTOwgW9OpB5kyJLQq9coxDnkCbWQugVnHHedNbq9HqXSTuiW2zNGFof0Sh8Mj9
 lP50HEq868b5iaBRmKeuSv+dgs2f/szarjSaijs3Vx9H6O/EoIV2WPGGotf4A5nkumaUAAAA=
X-Change-ID: 20250411-nlmsg-2dd8c30ba35c
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076; i=leitao@debian.org;
 h=from:subject:message-id; bh=uP6edEq7t633Nn/6CTGhpfDqtsCprN7gaqMik/FbLAM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/QyOJzlnlvKeT1y5rPAUfW5jI5HIFSlcAqv1O
 kxuE38BpO2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/0MjgAKCRA1o5Of/Hh3
 bewrD/oDHcgqNkNEe2RemYyIjCuGP6ATFc0eM3LUB/hJyQEbn1MVdBIGOky+4lR+tbQ+4kernxi
 NCsJSvQuUGMMmTptUuN7TWD1E8uWnIkpNHM82FZ7U3GTJXpnGCNYu2I2iATJYU9AxoLIqac8Wg7
 FieopxyNmdlwkgV3zoHTtBfp6X3P2n6XCix6p77j755bETk19BucCZE09UeoSbJ8ME4nSOO5IHR
 YJmG+Xo0XLuo4R7ieXqeiPS0bMZWwzzVAqkRqe8P9f9mj8OdV7p/NsN1HxlIvHaS4Yrmb4rojPs
 1yP8wXvTpb5IoxlDOdCCL7lorgP9sCPhilAZPuUj5DVzxwzJ/0eaCEEjWjG3ZGOhlR2BoUT9HCX
 Pzrt+oJshM/XueFg/iBBWoEfnSsrqT84DpADxL9FF9Lr2FmioHXZEQ05rnW/kKRicnckHvRpmoj
 CRIx8T27J+A5cL62dTJ9UIOzLTdAx/j1ddEdVqDYEZ6dvv13sWZwYMqnuraPPQuzcqF9fwQxBmv
 la+qpW0YbciwCOvrLndmFlFcWT+BzryYIHEGeEKG1HrD9w58CShUS5JH15VgfFzJ8ui3AZB+W1l
 U+wssIeY9i/vUsh892YjBQ8F/9IAwCeBuufUvi25dGozaaGtB40Kqzq24eO2kTif6MUFUf2oRmq
 3F02lIJobNnhoLA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

In the current codebase, there are multiple instances where the
structure size is checked before assigning it to a Netlink message. This
check is crucial for ensuring that the structure is correctly mapped
onto the Netlink message, providing a layer of security.

To streamline this process, Jakub Kicinski suggested creating a helper
function, `nlmsg_payload`, which verifies if the structure fits within
the message. If it does, the function returns the data; otherwise, it
returns NULL. This approach simplifies the code and reduces redundancy.

This patchset introduces the `nlmsg_payload` helper and updates several
parts of the code to use it. Further updates will follow in subsequent
patchsets.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Add the "Return" kdoc entry for nlmsg_payload() (Jakub)
- Use the same function in some other places (Kuniyuki Iwashima)
- Link to v1: https://lore.kernel.org/r/20250411-nlmsg-v1-0-ddd4e065cb15@debian.org

---
Breno Leitao (10):
      netlink: Introduce nlmsg_payload helper
      neighbour: Use nlmsg_payload in neightbl_valid_dump_info
      neighbour: Use nlmsg_payload in neigh_valid_get_req
      rtnetlink: Use nlmsg_payload in valid_fdb_dump_strict
      mpls: Use nlmsg_payload in mpls_valid_fib_dump_req
      ipv6: Use nlmsg_payload in inet6_valid_dump_ifaddr_req
      ipv6: Use nlmsg_payload in inet6_rtm_valid_getaddr_req
      mpls: Use nlmsg_payload in mpls_valid_getroute_req
      net: fib_rules: Use nlmsg_payload in fib_valid_dumprule_req
      net: fib_rules: Use nlmsg_payload in fib_{new,del}rule()

 include/net/netlink.h | 16 ++++++++++++++++
 net/core/fib_rules.c  | 14 ++++++++------
 net/core/neighbour.c  |  8 ++++----
 net/core/rtnetlink.c  |  4 ++--
 net/ipv6/addrconf.c   |  8 ++++----
 net/mpls/af_mpls.c    |  8 ++++----
 6 files changed, 38 insertions(+), 20 deletions(-)
---
base-commit: 6a325aed130bb68790e765f923e76ec5669d2da7
change-id: 20250411-nlmsg-2dd8c30ba35c

Best regards,
-- 
Breno Leitao <leitao@debian.org>


