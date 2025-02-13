Return-Path: <netdev+bounces-166022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E1AA33F58
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C0947A2A00
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DBF221566;
	Thu, 13 Feb 2025 12:42:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137C5221541;
	Thu, 13 Feb 2025 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450578; cv=none; b=fuG/PJfSb7FgFUhTNZ8UrEiH/gRhoDv//TDs/ZnO0DB1cHnylcZyrOPh3D4HGJj9hRvFVNlHkFj0VWABBox6vnG0Fm0UvWZu12e2e0EaPP/7SPhBy9hRn5sIDfu6MVbFKyhUYw4co2kvQQb2f5w9FFMODwqfKIOcIChdRIgPw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450578; c=relaxed/simple;
	bh=5nfG5tUKDdRVZPtqKEh7WSS8/lacPy6VbllvjiwvSRQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c6y3I/dJgbWmHVKwilrB4dtjV17UTeRsCxV6YCvpwBHOYgNqxmnfOcaW1PHrdUrPbgBd/CCwMrK+pMBqTri2KDB9BZkvny8fjGhWRc8ghrOpg4vnRvxO+w5SIknSySXqT7KfJJiWbQiFbNiXFyntchVhmUgnd3jEy1Fn758HsGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso1076506a12.2;
        Thu, 13 Feb 2025 04:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450575; x=1740055375;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GMmkLuL/V4kseKjdmtm/VGsp39ORCaWEvGR5hbaRH4=;
        b=BngFP6YdCoGLjgEaEQGgsqavdd+i2flUQmKKchHYviZw/g/uXBtByqmW/B1duJgYS1
         qvbkJ6ZWBr+9o18vDLtwq2065RQ7A4XwRONBw42nMz8UvfCFn8WANss3h0tfhmkyz9S5
         0NiCRSDFsXrFZpMXbZH4WXdZ4bFrWpyiF7ZvI848Wo2BjjdCYU3I8HiZQ0h7/UqjkmpE
         pOBbFLFs6GhSQohZwVJEvKYajBFMESwPXxowC+fCOuPheUm/LeymLZDXYszbwZQY7RMt
         VLrry1JFVuHXXDJNAT/VSwBjeiYlWv3yUE3ngIdylOR03Q9jVAA+SPWJLqOUUn8XIOEy
         IA3w==
X-Forwarded-Encrypted: i=1; AJvYcCW2fkJuwhFf1fnhieB27nykNOCYZhcHOoJyJg6fpONTGlxhgvVYWatJFj3/WmWaHfPEOPZ9UyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmWzi99J2N2/phwv6X3dUQM1rfNuJJbA5DrjU03wyjSeuONuxV
	QoZKGh9nb9H+HgI/tJpDOnDBPj9P3V2IEXtLRGNqwiJI5OeoZOc9
X-Gm-Gg: ASbGnctG5NgPD2jkkEy05gKKScb/x5z7zTOwTxXEZJ6MmxHc3lDrF/EyG2+uUB1J453
	WOZs+RKuubNxFgSo4ognc457YIGLwUVsz+wI1R/8T3eEyoGr2Ik6y89MRNImeJ4bm4mAxf3RxAG
	p+PqCdgF7gFc8KyF8NPulNrtrjowztpFvqmCJDorgmo2Np6kDd9aqjTIZdJx1qP6UM0OHVg0zu3
	1o8ARdkJhw23YJep74DiUnE2uauBxL4rGc/xFolCCmCYqG8T6HZQW2Mt7QoonubHUx3h2aZHqOY
	HO1gpA==
X-Google-Smtp-Source: AGHT+IF5Zordi6LTdV7cuo+hosGJiCrqw1j4H66eYJcF3InIl7h8JsByUgKPucE1W3fUjP31fi6bwQ==
X-Received: by 2002:a05:6402:13c9:b0:5dc:796f:fc86 with SMTP id 4fb4d7f45d1cf-5dec9d4a4ccmr6754672a12.16.1739450575149;
        Thu, 13 Feb 2025 04:42:55 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5b3f8557sm36064766b.21.2025.02.13.04.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 04:42:54 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v4 0/2] net: core: improvements to device lookup by
 hardware address.
Date: Thu, 13 Feb 2025 04:42:36 -0800
Message-Id: <20250213-arm_fix_selftest-v4-0-26714529a6cf@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL3orWcC/4XOTWrDMBCG4auIWXuKNJYs2aveo5Sgn3EiaO0gG
 ZMSfPcSr1ya0vXwPe/coXLJXGEQdyi85prnCQahGwHx4qczY04wCCBJRpK06Mvnacy3U+WPceG
 6IDP1KcS29bKDRsC18JhvO/kGEy/w3gi45LrM5WvPrGo//S2uChXK1DEHqanv+TVxyH56mcv5U
 fhnqZ01yiUak4rH5eOPlQ5tJZ8IhBKDdzqYEI2L7pfQHgV6IrQo0ZLpuxisZa1/CNu2fQO04Gt
 3dAEAAA==
X-Change-ID: 20250207-arm_fix_selftest-ee29dbc33a06
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, Breno Leitao <leitao@debian.org>, 
 kuniyu@amazon.co.jp, ushankar@purestorage.com, kuniyu@amazon.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829; i=leitao@debian.org;
 h=from:subject:message-id; bh=5nfG5tUKDdRVZPtqKEh7WSS8/lacPy6VbllvjiwvSRQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnrejN2Q9iKbGwkQhjrt0jll9UpquRhU1JB1SKG
 B3yufxTElqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ63ozQAKCRA1o5Of/Hh3
 bTRUEACUZ6y6xB8FTQBm08G3t7+VjUy5nAd7u6q3QNQsZHj5girpvSPBIn0BpkposveXpcx27Tj
 nmmeJ/in6Zb3wIl1O5g3swQHxHjPwRamFyJapo8rIY9Ks7kF7G2XSV1dtVpERG8VwM1LpDlQaUA
 go1RfkOPJzTDuAESL0x4hMAJYjgN4AO9xOTKDpX4KEkHChIioryWP+W8cxSpxGKQFZYztbX56BP
 Qh7el00HjEqPd2GiffWSUQCUT3XQ9gbk8XmFcq4UDQKDB2eni6vtN4eooPZSgfRJxq+++yNkwJw
 ltYqcVJx7FQeySihbRDJisD1+xgiqlu/KIm93+8tknknpkD9H+CYFj4CB2dY191OgHYfGSQh1iW
 CMuLrlxqAT5rCA6KL2Q5OjAak0kIvrme1OiqTrvyRPvqIFOwGiSRQy4Qr2Aa7yJAgDlNTUkyl/r
 MPWqjisxCSz9rX3YLSzGRzpUbYMYONBNVjEKamOxPUfBWAYnZBgYxwZIl56hYMmqAT7tWxMJfiQ
 xv+zqZhIZKk3Sd14xrmlVxE/byF7kvOpW6VTlogGWYI5915lgI3561ylLuIQPvYrKEBZJ2OF15m
 yzrqmjwCVA0YthGbfCxstk/m5ieE179itsCqtXt2ckQaQgQ+U6WY9XR8beEoR5W/XhuSal+lKD3
 ZtRy7dJHDSa0Z9A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The first patch adds a new dev_getbyhwaddr() helper function for
finding devices by hardware address when the rtnl lock is held. This
prevents PROVE_LOCKING warnings that occurred when rtnl lock was held
but the RCU read lock wasn't. The common address comparison logic is
extracted into dev_comp_addr() to avoid code duplication.

The second coverts arp_req_set_public() to the new helper.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v4:
- Split the patchset in two, and now targeting `net` instead of
  `net-next` (Kuniyuki Iwashima)
- Identended the kernel-doc in the new way. The other functions will
  come in a separate patchset. (Kuniyuki Iwashima)
- Link to v3: https://lore.kernel.org/r/20250212-arm_fix_selftest-v3-0-72596cb77e44@debian.org

Changes in v3:
- Fixed the cover letter (Kuniyuki Iwashima)
- Added a third patch converting arp_req_set_public() to the new helper
  (Kuniyuki Iwashima)
- Link to v2:
  https://lore.kernel.org/r/20250210-arm_fix_selftest-v2-0-ba84b5bc58c8@debian.org

Changes in v2:
- Fixed the documentation (Jakub)
- Renamed the function from dev_getbyhwaddr_rtnl() to dev_getbyhwaddr()
  (Jakub)
- Exported the function in the header (Jakub)
- Link to v1: https://lore.kernel.org/r/20250207-arm_fix_selftest-v1-1-487518d2fd1c@debian.org

---
Breno Leitao (2):
      net: Add non-RCU dev_getbyhwaddr() helper
      arp: switch to dev_getbyhwaddr() in arp_req_set_public()

 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 37 ++++++++++++++++++++++++++++++++++---
 net/ipv4/arp.c            |  2 +-
 3 files changed, 37 insertions(+), 4 deletions(-)
---
base-commit: 0469b410c888414c3505d8d2b5814eb372404638
change-id: 20250207-arm_fix_selftest-ee29dbc33a06

Best regards,
-- 
Breno Leitao <leitao@debian.org>


