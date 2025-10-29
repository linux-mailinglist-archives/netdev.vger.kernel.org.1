Return-Path: <netdev+bounces-233842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A37C19144
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17A61CC4CAE
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9409F31A57A;
	Wed, 29 Oct 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7YsI0GK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7431A567
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726179; cv=none; b=cVFKsL++FPcinyHBQGEep5MTWzeE8Fsr29u21UqnFwxuW2+uN9cEDxSOUSFw77mpyZdxSx4fTCE5q3A4A2zq0tTXjvn2MOda5jFU+4rPyM/5Yc3yzu6twYe4Cpx3hUUcL6nGGWjGPXK4gixKZEbUoAzhLm/WMGPOmQZZeykIr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726179; c=relaxed/simple;
	bh=II2ZeAq5d1PqZyNvFep+lfOCaOaR9aIDJK3qwqZxtvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AhdQq+lqUjUfbmvg+BhnP3yyet1saZZ6Ok8JKaDddGKsbdib5ZZYzbxdTtpG/mxszfzSOLcQagmzqBjGTn4HW2e1J2bGWjSRPEGCiOywU5lOTYWLwUuOTvx9nn1aZUSN2kBirG5TpG43a5CMRCsMdbc5IGLj9+Bzt7gmAtgQfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7YsI0GK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so4248980a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726176; x=1762330976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjESO5fQEKLuX6fwGQrrMr1sS1AZEXE62NjhuH0WeLY=;
        b=Y7YsI0GKGozgk7tmV4wM/+RTg0rdqLe5ZwTyElLj9fuq6sgLRjNPFcw8pFEBntVbuh
         vKJ4L1Uonwx2pZNkmrtldJNEzGXxPdonFJv+ETTvehVct+XxpIOp6hT34kEZc0twjYNF
         q+ImXDbunIud/CKTivfI/JbdKaXLabWLVKJ5azemMdMIidWdrDxP7dEkOh5Gd5tPXk43
         +BAjgg9TP5ogfFcgQ3fKMf1+QsqvPL8s+Ko1xf/8YR/YHdV3r6T+YV4Rq/BzoC3oJ0iy
         E8Gp9J/hU8tlnpQZXvpQLEOfLkuAU5MmH7Zb0hVUxuHxbrA7hCQg1pbnEADOI8J+wNeL
         ydMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726176; x=1762330976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjESO5fQEKLuX6fwGQrrMr1sS1AZEXE62NjhuH0WeLY=;
        b=SnmiFOfXQHuwG5fI3LuAxxK08P0HzAqTRB9Gue7wJ/ddwMZSwreh6DqtYlHzbykugZ
         9ydY3IXCWbSdodB4Wr6DVO+hYx6gZmK6SSFB9zqXf5SaFazFASRlllR3LKclqKWmXfKW
         8PGhd3nLLQqZyvicE7kFDgan4qW+cg6RxtM3Lntxf1hG2gbBH/t/ZBseZtmJYOPZhqJ6
         zZgcjmCR5Enz8fH0frSY8186cnzATHB2Jcqeo9RTBla+7CjvsHS2kGd7a72TzKIfgHZ9
         eVPk+XYLxqcS2RwmlUh1AFX/apa2GtJ7jTYu3jaC0tFuKOtI9bLWXoBwSzpnYuvwV7/s
         M5rA==
X-Gm-Message-State: AOJu0Yz9kJtjcEuAqVJJZuA97hiXJ9Kcsa+PmVlkD4QP3krnGB4LpXsw
	cAlDmo9UVN9DrxNVfCdiXJ87zNMH9jYtdibO1m3fLTIMWBcCA50y5kRIqfqJ33h0UVE=
X-Gm-Gg: ASbGncsZF4vkhnW8LK5L5oOww4BIHISFVDw78A+vwdoI3MAGbxCXYTkB8ThMaCqjDKa
	nu0JLB6FO5zIJxy1GH26Ioym9fQXmcd4QcmhbsKxkMuTohhrczIYLAAqPDrE8CYacSmU3KauPlB
	QneExWbfwIfKb3KIWzmbOeG/bTwYqr2ZGfifjv1KMm043ppymwuf6Wzht1i6Z0ht2MhWfi2AGNB
	al97HEa477r3TH169D4N1/lhuJPDzdZ/tH7YNfOpSkviBzXp9x94+/T5RLqwnBhvBRLieRftTSh
	UafdiNDbaOXpx9+u0rZbcuO7XozhsdQjGxjU8RWhhzzMVqAqw2Wtrz6g+zxVmAArnxO0N5wjXhA
	x0ALCak8fsBgi4uB35ZLdfyAi4Ho6FdQ3jlcLW9WO+9ETdWkDLZEPV5UzA15BjUvYvesI1mqCMJ
	nm58ucrG4G16q1eLCutD2W+mu8Sg==
X-Google-Smtp-Source: AGHT+IFtlmUFHwbjWAVa70at2N/ziNZo4fE2Wvt/G/+dSsYuVmuZ+70lod3hZaRVGg519qEMJmCkWg==
X-Received: by 2002:a17:903:187:b0:262:2ae8:2517 with SMTP id d9443c01a7336-294dedfc7dbmr23710645ad.5.1761726176352;
        Wed, 29 Oct 2025 01:22:56 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09958sm141906005ad.24.2025.10.29.01.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:22:55 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/3] Add YNL test framework and library improvements
Date: Wed, 29 Oct 2025 08:22:42 +0000
Message-ID: <20251029082245.128675-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enhances YNL tools with some functionalities and adds
YNL selftest framework.

Changes include:
- Add MAC address parsing support in YNL library
- Fix rt-rule spec consistency with other rt-* families
- Add selftests covering CLI and ethtool functionality

The tests provide usage examples and regression testing for YNL tools.

Hangbin Liu (3):
  tools: ynl: Add MAC address parsing support
  netlink: specs: update rt-rule src/dst attribute types to support IPv4
    addresses
  selftests: net: add YNL test framework

 Documentation/netlink/specs/rt-rule.yaml   |   6 +-
 tools/net/ynl/pyynl/lib/ynl.py             |   9 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/net/ynl/Makefile   |  18 ++
 tools/testing/selftests/net/ynl/cli.sh     | 234 +++++++++++++++++++++
 tools/testing/selftests/net/ynl/config     |   6 +
 tools/testing/selftests/net/ynl/ethtool.sh | 188 +++++++++++++++++
 tools/testing/selftests/net/ynl/settings   |   1 +
 8 files changed, 461 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/ynl/Makefile
 create mode 100755 tools/testing/selftests/net/ynl/cli.sh
 create mode 100644 tools/testing/selftests/net/ynl/config
 create mode 100755 tools/testing/selftests/net/ynl/ethtool.sh
 create mode 100644 tools/testing/selftests/net/ynl/settings

-- 
2.50.1


