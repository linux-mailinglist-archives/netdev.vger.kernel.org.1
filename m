Return-Path: <netdev+bounces-164696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE2AA2EBFD
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989933A2E22
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EF61F78F2;
	Mon, 10 Feb 2025 11:56:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B1A1F755B;
	Mon, 10 Feb 2025 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188587; cv=none; b=mMZyAKAYNTVL1sgHdJioV/tXUTgxWEwcQAuB+IFkCKAt1mf/0OQnNmJotgZUVXFiwM6ltlun70SeaHogHG/xe2uh0+3AfbW1Q2Crj7esoF1kLSsVu3iRUL/e4I/QHWVx5S9K7Auxdr69fbb7vF45WmzwFklhMN2pulEyjSqbyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188587; c=relaxed/simple;
	bh=z9yeHDbgesyAop8J/xhuf9T37HwtOqBrMuvjoPlJ118=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CtSC8mb0rL6RdraECFUYuonL/9dQkt1WjwMx7Os+Xi3SIkpmm4fsTJG/Mn1oivC7L0zOgu12LOB0mzaqL2vFzut09fZoZhI7eQx9Z14ueOXqYb0LMstnepwxpFVBr6BIyXineLwCobhi1XplszXGhuqBp6bTCYvG/5eS2Zzj8tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de5e3729ecso3632769a12.0;
        Mon, 10 Feb 2025 03:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739188584; x=1739793384;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kkm8pXToztPygZByRYYaU4n1/d0TQsKNxr/EGVlpDX4=;
        b=IERJ9/dfXQbfVBymTL/HfWTCLaZoXXyZVIzbpsgCZbmjkiU/44728wvN7jFTuZ/ozN
         74+JmummJM+Z1XtHCuMfvlrTAhQmBhpiIDRAMzt2tFVq5+jR30SkVRC1cO5xoyhV8Z4C
         U7vaeaOJVs1XzD3+kJ0Bb28PRRiffuhf6zww4eD282j3O/mzR7Kgeq1jEi02SBlU9tpl
         M9fGLZvPQHYbXMkL1txqjz0HwZZId3QAx6DE/F9vqFuo5294qZ8OKzhzaml1UsD9MD3l
         Xbk6BEJSqGoPR50vboLmGUJW9KhLKcH/iNYi11gE8vTolCEyObGYWFgnf8KTTDwboZXy
         OxKg==
X-Forwarded-Encrypted: i=1; AJvYcCV+MBKRrv6WIiXswt0/hlQmkgJQ3HEBUEAEOKJeVYRzLqDPJ5PIdsfzcSihUhAa8Jk4h2iPIs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQW091eN1dytfBpU/5IXG32oQeh+iNny6O+G5BPwRC6UXqoq2K
	vuHqKpu3xrS2FKp4J3pINqxWvwDfUpn17FiqDp07n0QYx1Limsze
X-Gm-Gg: ASbGncuniLanuwWi9FmKL4NW++x5jjsHYqdKFnxqBA7XPkLU5vMTqbzpTQJzUPxPKvR
	lrz+7VIRUGQpUR5QvigjKP3s+qFE6Qi3ALIJYMbZDZpKeG3qYRs0ralwNbhzejGsawRSxnlizY1
	asLL3/fvFCQY2fsYn1Ecuh9h0y1WnU3ESd2DzAqPiZH4rq8XXrrIBg3a88IA8peVxiisUIPKWuL
	BkzFsoPUaQ6Zwg3DrxBI6qF1pBoNXhD4lzZEOEI1PVTfjqBQzP/HYT8KC3XVHwwDkifNjlj6ZnW
	QQ3SOw==
X-Google-Smtp-Source: AGHT+IFlFDig1R2dW1HutgA9LEms4/TR3NnPy4CkIA9o4o8/MRwYv5X51SXo8oXp7qVg6cLixvyt2w==
X-Received: by 2002:a05:6402:4607:b0:5dc:7464:2228 with SMTP id 4fb4d7f45d1cf-5de44fea743mr12015863a12.2.1739188583999;
        Mon, 10 Feb 2025 03:56:23 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de525f35b7sm5504942a12.53.2025.02.10.03.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:56:22 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/2] net: core: improvements to device lookup
 by hardware address.
Date: Mon, 10 Feb 2025 03:56:12 -0800
Message-Id: <20250210-arm_fix_selftest-v2-0-ba84b5bc58c8@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFzpqWcC/4WNSwqDMBQArxLe2pQk/rPqPYpINC/6oI0lCWIR7
 17qqpvS9TAzO0QMhBE02yHgSpEWD5qpjME4Gz8hJwuagRKqFErU3IRH72jrI95dwpg4omrtMOa
 5ERVkDJ4BHW1n8gYeE/e4JegyBjPFtITX+VrlyX9nV8klF7ZCHESh2havFgcy/rKE6bP5YxZNX
 crGKmfl+G12x3G8ARGq+Oj1AAAA
X-Change-ID: 20250207-arm_fix_selftest-ee29dbc33a06
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, kuniyu@amazon.com, 
 ushankar@purestorage.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=leitao@debian.org;
 h=from:subject:message-id; bh=z9yeHDbgesyAop8J/xhuf9T37HwtOqBrMuvjoPlJ118=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnqellHS29GXkDpALHPObzLLi+AmtFK+jC7qNBh
 USj/NIrW02JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6npZQAKCRA1o5Of/Hh3
 beo4EACODWpeVKtNvHz0VD4I1TA6XRP/yWzyA8NtkNECjjy09Nj0w5hhtQQ9dJYhy89CG0TrGKQ
 O4DCbD7IOhKUv9637FTE4+g5ls0f0XZ+srVVL4teZ1E24WoKlBVlK91529oVMP3/hsZPb0WnU1U
 6JgczsStIwNBl9Ryn74BcKjYphXEMmcoX6wyQSYO667IH+EPedOyz1WH2nCMvSLjMySihRA+6j1
 TlzBI6ZIphFn1r5wqAEKXugqIixFqdi3HkzJmwEarKuBMlpD8JwtS/QQk3ChhMdxrMevPHk95r/
 h+HUV8xJiU9FQ/ySv2rPzdwPMTMuRlEmLgMQ7JKYDrAEIq4E30g6/VZHcUbaaMPtDu/Z2fcuVQS
 TvjOOWaQ0YopdKjAtHL+ciGf38b+39aNeaEJG+xy2R8H2dJxUsUiuWH8eEXAskP7jLiHsG3VoSw
 N+Do5kHS48nYl42bxPj1qA8GMU4pfLe8pcgCKCMN9ODlmkhga+ElvbwVkq1W4BLnK+InM8Z6Jdn
 YSUiDA92xAI2qbWXW0E2g9nsczxJTjhfA4cK82ctRQDPJpBWlm/0PxC3iB7cwLfeEr5iBM15kK2
 lZzLamWm6gUxXpsHM5MwuSkXh5txAOlkeGUb6MFC6RP3ndlWFrqgtQJ/UY4Gx3VMIR7I6YQ3spt
 WxxGahA6h6bdI5g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The first patch adds a new dev_getbyhwaddr() helper function for
finding devices by hardware address when the RTNL lock is held. This
prevents PROVE_LOCKING warnings that occurred when RTNL was held but the
RCU read lock wasn't. The common address comparison logic is extracted
into dev_comp_addr() to avoid code duplication.

The second patch adds missing documentation for the return value of
dev_getbyhwaddr_rcu(), fixing a warning reported by NIPA. The kdoc
comment now properly specifies that the function returns either a
pointer to net_device or NULL when no matching device is found.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Fixed the documentation (Jakub)
- Renamed the function from dev_getbyhwaddr_rtnl() to dev_getbyhwaddr()
  (Jakub)
- Exported the function in the header (Jakub)
- Link to v1: https://lore.kernel.org/r/20250207-arm_fix_selftest-v1-1-487518d2fd1c@debian.org

---
Breno Leitao (2):
      net: document return value of dev_getbyhwaddr_rcu()
      net: Add dev_getbyhwaddr_rtnl() helper

 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 38 ++++++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)
---
base-commit: 0d5248724ed8bc68c867c4c65dda625277f68fbc
change-id: 20250207-arm_fix_selftest-ee29dbc33a06

Best regards,
-- 
Breno Leitao <leitao@debian.org>


