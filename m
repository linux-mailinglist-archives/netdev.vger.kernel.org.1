Return-Path: <netdev+bounces-152813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF939F5D59
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF4316F142
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6013487A5;
	Wed, 18 Dec 2024 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="YNEB2wGH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1611E487
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 03:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492165; cv=none; b=GJe95hnrjThpmn0WoFtvyCbEL/udcN7JoXN4jF+sr2m3AGfn9pBgOT8lOSStPk7PuwrSFIYsO7G9ngbX1bEeX9GEwszsV2u12L9pweEPfjGnFcJyVrS0oUl92sKGxvvVrEEBLn8mgeLefGkXdaLoZ3jPzvEq/7qTPxFMzlnpwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492165; c=relaxed/simple;
	bh=jRDHySUfntXdaDnksM5CWQg+CoTgyHoU3RjC6zt5y64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HhZqWXDmeGv5BiCX3vUNQmGqyMArmBOaQJkZ9czrNfkWO1UumefG8zqsq8KSfaaPr3jm0slf+vs9T1HSoUlXXefUxNdlbyiWN1zoF6cmr0g3lgT40oU8Bam2ziMMH0mHYrzgYU2Tat9XIEfdbuRwHUOQKzQOvfvCgtrEJ4zKRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=YNEB2wGH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728e1799d95so7042153b3a.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 19:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734492163; x=1735096963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dH8OfjO+U9fv9HfwGv+V0u7SXAYr7eTJxN5M0NoEIkE=;
        b=YNEB2wGH/zU3yOx7Gdik2x4u/2f8AVXgGIa/y4XPcN+TmAGWQNYMhSl5hs7Rt3cIl3
         StXdv23wJ+DqytvT9kamGZ2igvg1pOz9uoypIaDdaQKFbRsNS0rWNIfDOlLe0SGRk+tF
         DL6WL80SXztoRpUjtCJWqljp0sHi5FrMpaqFDGklN1PpGI1Z2gGCwn0S6A4wEw8rGPgg
         lEWCIGwFn/Slwpladrf7Y7m5JDy3BzBMu2p9MgxmfpA0T0uylcJmVovucC1PYN1uEUOp
         5JmDwyNzAaOqyg4/ey8EhEMxhX1D/g0Xc/gGyha+AE9Xm3r3HrLMoUeEblqBWzA1+gD8
         n24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734492163; x=1735096963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dH8OfjO+U9fv9HfwGv+V0u7SXAYr7eTJxN5M0NoEIkE=;
        b=SPF7yWfPYmOY/VglS9LTAbVAGbs6FBq/cnF7hLstE4x95BATkp5XxpARwnriddkgRo
         XIT9a5WJj3o2ejX7MbLTspAPXZtrllTsqdXYXshm3RRhsWvb3uK+pLPgdsywNc1nbsHZ
         BKEyFbR5Yjv3JbuagKXjbbfCTise8Pa/fnRgp7cLi6ICtV9fY/pRwj7Va2aLo2jmGrns
         vAyn/97WqTbE+3Lw1VFB1poXZz/5APRqDbL2rYl1xAlpGjdwpLWDluo8uEQRDtmvge1Z
         hzhdQ0XF+sSazC/eM02B5gyAa5vseBoIz3LoqfTXvO8Yjmd7s/zqy9KCfDuzRrLDj72g
         iXxg==
X-Forwarded-Encrypted: i=1; AJvYcCXRyegB2me5h+ez+rz+tDWSRyYrCn3388rYulusYi4jYP6AenpukmivUGFgIdAVTWhdEyy5xc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9ZUWGzBXLkT5soW5jRBszNOxFg8kyAWh9ieO/NeYyLdCJ1cT
	YzuTbS5PWJ3GZwNcpN/q8BR71ezgRoGOgpzH3tCcQ0w0bbcwiedlNmvT+TLmzPA=
X-Gm-Gg: ASbGncsLOt0kS1qvlYEeqU9A5NOaAxMd8NZWSC5t2b7vzJTYdVTPjr4C49kQMrMxM3j
	lbeSXXlm33mnc7LvWnbpbN1o4klxmNYPaFAjb74jdjYDcTXJz/PycIkoCJ/0Ok+KITncLHlgRe1
	ZI4AIkb6obbDBZWfwEHtl5riqcPKgxVY3oAMtqWY8J5JVCt/VEYpgzhFK+Uw/kBaS8fQBWxQvxx
	Buw3JzpMpGphBLqZ9faG7FOtgZHYOlAFNxBZBSkmEOi7GG0M7sfKs5d/jx7Piwxde2MHJnEADdx
	YMvmXQjSajaajpivoNbkSZin4sbB6mKQGqnVyhE2Kr8=
X-Google-Smtp-Source: AGHT+IEDyLek6dpEgRzkg6K1KIqyJyUAn0y3NbMQoX05/zkq/5Adv5SJ13GKKT1yXdXMQLvb30/2WA==
X-Received: by 2002:a05:6a00:2189:b0:727:3c37:d5fb with SMTP id d2e1a72fcca58-72a8d2a5c5fmr1751639b3a.16.1734492163297;
        Tue, 17 Dec 2024 19:22:43 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bb4037sm7453908b3a.168.2024.12.17.19.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:22:42 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com
Cc: krzk@kernel.org,
	dan.carpenter@linaro.org,
	netdev@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2 0/2] net: stmmac: fix an OF node reference leak in error paths in stmmac_probe_config_dt()
Date: Wed, 18 Dec 2024 12:22:28 +0900
Message-Id: <20241218032230.117453-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes an OF node reference leak in
stmmac_probe_config_dt() and removes the unnecessary argument of
stmmac_remove_config_dt().

---
Changes in v2:
- Call of_node_put() instead of stmmac_remove_config_dt() when
  stmmac_mdio_setup() fails.
- Split the patch into two.
---
Joe Hattori (2):
  net: stmmac: call of_node_put() and stmmac_remove_config_dt() in error
    paths in stmmac_probe_config_dt()
  net: stmmac: remove the unnecessary argument of
    stmmac_remove_config_dt()

 .../ethernet/stmicro/stmmac/stmmac_platform.c | 37 +++++++------------
 1 file changed, 13 insertions(+), 24 deletions(-)

-- 
2.34.1


