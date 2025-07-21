Return-Path: <netdev+bounces-208602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB0B0C4AB
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B884C542965
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016942D8386;
	Mon, 21 Jul 2025 13:02:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5C2D12F5;
	Mon, 21 Jul 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102933; cv=none; b=p2UcXsxF3JV7VpT2DCOwUSeb7j+XN5CU6KUdczAPmSteOEAuQWcIcwXISEEpYF0TVgSwtGWkPZxMivrvgdVhJ/WtdlQHCNr3XjMK9AFGu/ASb5Tm4TiVDphXcJKLHeq9julqmB2+fd7KrcP/ek9fFuweEp3PPWbhlado3EmLv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102933; c=relaxed/simple;
	bh=Y9enP814Qb31znV+lCZCd5IIWy4hLlu6UJiWQkgrdl4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lZ/Mb5jKZIdc9Qqbx9TLnOzQddPDcMcBAkOOqkeYLFy3F5H1IT0bjbZK95GnAPydmqrxAK2HSV5YDEPwHFHrNoR0qVjtvhBXKJbPZ4FQCznY2Sejw0jpP01iR3gUxyU8i/OXsdTGIqDi354G8NUbzMZbtNLz0KHJ5IiVVHMuGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6129ff08877so6731391a12.1;
        Mon, 21 Jul 2025 06:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102930; x=1753707730;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4yGg2NehvRvYmpEbgOTA7EYH0BhrprzDpGT6+ko3Fg=;
        b=oQ8Oq7wxsxeQqUzqSIyo2uGpKp7Bs8+n5omeqHHS0izO3k8weV65q4t5hkOo9WFbHK
         CW1Z/yUB1aT1hFQrECN98SXrPaqZZV4iEI3kNHyoPQ+RtF+P7RjhFEfqfxUGXdfzJ+9U
         Z+BIio0lb5vUsDYwq1XrU5VWGGXojDrR5+cIMu9wswq2wXwOShvYy//Q52pD4WIBborn
         980b6dvQM8R52Uw0mvph/u+4N82CV4QR8M58L4Qj3MdJHVHL1oDCd3P2KrrtD7iqFTBt
         cEKiOe0XMvy+8d+d9UNuC5MH7O79mbMXRI4LZRbbMIpAN36qcv3TuP7hKQFBDwT5getn
         Wk2g==
X-Forwarded-Encrypted: i=1; AJvYcCUvwO6sLwpXq/GK+gYUiCbktVt3iNuw/2WPD0pdxHb9+CD9FSawqKgd9Lu1+7AUeHlCKUKO5CXFjtf2swk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqN2JA64AmBI2PsbTedNiPH8IsSXhYhlX/qRNTIb0dwczRWsIl
	WkwVXiJeamt68bCQpSJUFuqyoWwFZ80uLWzgVHRoxuONUrlkH5KVLYAeNTtZnA==
X-Gm-Gg: ASbGncudCeLoj4y3HW3zj49ZxjhnbICI0WQ3d6sK5ehAA9xwvARtsRwK8B95q8z2e1d
	1FscbMaTx10ma+PKNscPaXe+/GeJqIHmJiZEXZ4pdxbETrZeZwdAq7IrkayJG6/6xqolqaepu8V
	mEBFtF7JwXKIo+frLg2ThnelSz+FVuAJ82ktq3M6JeekaxmzuOPqoXYXt9fuQ8tpgDTF/UE57X0
	UTgoeDTU3emAi62DR7s4dKSYkfsmdH6w2p2rxt3JWsjMuNr0iLFAVJWRqMfWMPCNv4X+gZcmDpq
	WMuoJEIZVIBKG/GQAzvPeXhSlyTDxZ5QoPRNrzRe73TJXeu0KRHJg/q8DI+LVYuk0v0OTO32Y50
	Ynzm5u31NHN/IFA==
X-Google-Smtp-Source: AGHT+IGo/FNnSIE/RK8lrpc+1Z3W/Fx7ENsJ5lqEoaPEmjedozYXbM0g9QXI2opbky2cp4D2JkK3Vg==
X-Received: by 2002:a17:907:3cd6:b0:ae3:f3c4:c0b1 with SMTP id a640c23a62f3a-aec4ddff89bmr1639542166b.7.1753102928286;
        Mon, 21 Jul 2025 06:02:08 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf733fsm677598866b.159.2025.07.21.06.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:02:07 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/5] netconsole: reuse netpoll_parse_ip_addr in
 configfs helpers
Date: Mon, 21 Jul 2025 06:02:00 -0700
Message-Id: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEk6fmgC/3XNQQrDIBBA0avIrGOJttaQVe9RQlEzJgNlLCohJ
 eTuBfddf3j/gIKZsMAoDsi4UaHEMArdCQir4wUlzTAK0L02vVWDZKwhcUlvfGWMMqhotbmF6I2
 CTsAnY6S9gU9grJJxrzB1AlYqNeVvO22q9X/opmQvhztGba7eOuseM3pyfEl5gek8zx9jTH+wt
 wAAAA==
X-Change-ID: 20250718-netconsole_ref-c1f7254cfb51
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806; i=leitao@debian.org;
 h=from:subject:message-id; bh=Y9enP814Qb31znV+lCZCd5IIWy4hLlu6UJiWQkgrdl4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBofjpOLuv9TK73ynYpqDuvPVFVF2PTdnFUB38xK
 Jh84mkNxNuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaH46TgAKCRA1o5Of/Hh3
 bR1ZD/4vJ251BXV7Q1K+pXWr4J8t19TmprIbKsw4ly5XYi833IGnC/FsG8raWxmKZKgR8dosXY2
 AETzkTVDu4dgiGuMYvEMRrXCbX9uCU1/sc/oM9TKYUWg6of87qW0V52JLqZx3EadqeFWJNKbvxi
 YKZgmPKUNbTqYpooYZHhnZ2srv6O8kbJV2R3ta9ZJJuD/zOhYQhUJHIIaxeLaxS0681Dv4/EJPf
 /CJ6WQjchwd5rm4VI7uL5p+mQ0T7Wnmx37ZF4NtIbHUimeRAi6u5whCjdyoV4UDah1inRiNA+2d
 nRhJT0VGjYQbr3Kunky+BItnwJOSnsy+kjjRGwZINNsm6ugO57K9uG8fK6Fwu5e4pUxAlpzPQPn
 o/sy2cOQuXgmbcJ74PupM6TWwDnudd6Fz3r4L8eqPbpPbKk/50ejJxE2am+ZXz7Why/uU/H8zyP
 gw+C9XSbEiwkfZnENRqm4PdpvGA7AyFnLxs6L7RU8mYsLY9cq0pDxrDOKjsNaQNXwAQnCQ7C1yC
 QnOgomoWXt5gRDm8j1SdWB4iuMzIlJ8ae4Wm3eXwK0CkGbyVNY183fXeOVeqN+EefJKLmR3hxeT
 +UZha8v9DzSAl8U5jEFWdKr5RUOJguBIqrQnApKZXP7eUTYSdjC9tiS0vdbZkf2J6IkDHaaE3N9
 MX4DC1A3m4t5ZYw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset refactors the IP address parsing logic in the netconsole
driver to eliminate code duplication and improve maintainability. The
changes centralize IPv4 and IPv6 address parsing into a single function
(netpoll_parse_ip_addr). For that, it needs to teach
netpoll_parse_ip_addr() to handle strings with newlines, which is the
type of string coming from configfs.

Background

The netconsole driver currently has duplicate IP address parsing logic
in both local_ip_store() and remote_ip_store() functions. This
duplication increases the risk of inconsistencies and makes the code
harder to maintain.

Benefits

* Reduced code duplication: ~40 lines of duplicate parsing logic eliminated
 * Improved robustness: Centralized parsing reduces the chance of inconsistencies
 * Easier to maintain: Code follow more the netdev way

PS: The patches are very well contained in other to help review.

---
Changes in v2:
- Moved the netpoll_parse_ip_addr() to outside the dynamic block (Jakub)
- Link to v1: https://lore.kernel.org/r/20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org

---
Breno Leitao (5):
      netpoll: Remove unused fields from inet_addr union
      netconsole: move netpoll_parse_ip_addr() earlier for reuse
      netconsole: add support for strings with new line in netpoll_parse_ip_addr
      netconsole: use netpoll_parse_ip_addr in local_ip_store
      netconsole: use netpoll_parse_ip_addr in local_ip_store

 drivers/net/netconsole.c | 85 ++++++++++++++++++------------------------------
 include/linux/netpoll.h  |  3 --
 2 files changed, 31 insertions(+), 57 deletions(-)
---
base-commit: d61f6cb6f6ef3c70d2ccc0d9c85c508cb8017da9
change-id: 20250718-netconsole_ref-c1f7254cfb51

Best regards,
--  
Breno Leitao <leitao@debian.org>


