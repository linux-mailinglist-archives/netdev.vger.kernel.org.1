Return-Path: <netdev+bounces-134684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE1B99AD28
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0E3DB29850
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EE01D150C;
	Fri, 11 Oct 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpnndsia"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FE1D0F5D;
	Fri, 11 Oct 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676587; cv=none; b=Q3HA0H+qO4R+erfqeCk139SYX2OsgBp99VHAcJomdM2AAfg04xodOKLB5Hrt5msEhzSOPpFbjlUDkEvEFstdt6gfyRnAs2N1zo160n3DNMUaCsXMDWhPk/c6lqoHYvSZTZp7dTF/r6ohTQYDg7Pv9BVX702fH/xdoHm207vzhyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676587; c=relaxed/simple;
	bh=ymNOMP+HWHR2t3ZD3XHoeQSClwoHsa44xbPBvh41bYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBQePSInwcsDrpJ9TU/KIZf0mG1MOLJwYMKl/lgfAUni7Nm37JkDDH7o05DTGyqk4D7fJR+nhGiyqxxAbbmKZdcW3wZ02goL0Eg0+aqCDtbT20M7G8sgChO3OR44Gn9f/LzhC5kI5+wiBiKBK4+4q1VqYw5BczEzMJAY8ComgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpnndsia; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20ca1b6a80aso9226195ad.2;
        Fri, 11 Oct 2024 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676585; x=1729281385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/y7a2JNtPW0CwzY7rZKmN5esjEuax/0+n9E1IqCMsd4=;
        b=hpnndsiaALF1LZhwnpW2FBa/yePYZJhbk2V0Io0zL7qJKss014ZvX9kIAKmCvanYSg
         Y8KJE2q0GUk/+w3uiVdOyCI1Gwxr3JH6H0oEEgFdJPEO9O1QbEZMpw2aKROoAVA/kOQH
         ZVZkI+66y83BOUdoqVBitVFhV2hCtgOdUVm22fLnR8ISH5TsOEuPcOKlgmwq/qSy9clT
         JhB2sTeXNrp6Jug0FQvFLhpv5SWJeGVvpYTU9HWH0yAuox6UYdFbjROZmgAqZgtIgLzR
         vSRhw5X1aCeJkbNMQAFLbK2YDKBmn/At4MxPtvGjv5AX06muUwbyGfWjB4MxgkDbH2EQ
         MrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676585; x=1729281385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/y7a2JNtPW0CwzY7rZKmN5esjEuax/0+n9E1IqCMsd4=;
        b=YnGXknMudYA5I/7lrrH/ILA0eGbWW7JPqhA1RXDagfHhcwBrLhQhNBx5GnZbUNxaWa
         53lbjqTNckbeiEost4mzsagDsh1lv+1K4MjgIR5BJLIYBJhXzBc1AJ7NLQ7hV5AgjJd6
         32M2vSXRXgr6t8S670j8UnVKzxhI6g+0rBnNvYx0NTCbKl66dbYz1KEKftKL/cGsrIT+
         FWAMn2RSrXp3esvqDgByhu6E1zI17G6FaAKWfKyihETag9UJ1eTVKOxWpy8VhuvC3wzU
         FE09tx8fJ8LkS37KEmnAXVOe1cvBEJ7LUfBcTY1rsAEQctRRl0I1LLaDVu4Ai52IF2Qd
         lGZw==
X-Forwarded-Encrypted: i=1; AJvYcCUF+irw6ZqHJayMhSk+wsiu/oNMLEWpBX0/YLi5vMi9IYU2rBIcLm/5+cs7oE8cY5ivxb6teKDbNNKZOg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZPBMjZ7fzYQ29ik7xNi6viPT4lwVJNuudhtB746ld2AqC+D35
	6i7InzSJUFNhg2UINd+u0am1RbiERKj7s11GiO5QOG86D8NYMoax4unp/Rrr
X-Google-Smtp-Source: AGHT+IF+9Q1wbCwLJwUdo9rHD87NhyrD4DuC/mWk0a5ApY5zB+04hZSoX7pl5cjckw9tO6S9iKr4rw==
X-Received: by 2002:a17:902:d489:b0:1fa:1dd8:947a with SMTP id d9443c01a7336-20cbb2408b7mr9294045ad.46.1728676584790;
        Fri, 11 Oct 2024 12:56:24 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea44907ea9sm2846025a12.40.2024.10.11.12.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:56:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv6 net-next 0/7] ibm: emac: more cleanups
Date: Fri, 11 Oct 2024 12:56:15 -0700
Message-ID: <20241011195622.6349-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested on Cisco MX60W.

v2: fixed build errors. Also added extra commits to clean the driver up
further.
v3: Added tested message. Removed bad alloc_netdev_dummy commit.
v4: removed modules changes from patchset. Added fix for if MAC not
found.
v5: added of_find_matching_node commit.
v6: resend after net-next merge.

Rosen Penev (7):
  net: ibm: emac: use netif_receive_skb_list
  net: ibm: emac: remove custom init/exit functions
  net: ibm: emac: use devm_platform_ioremap_resource
  net: ibm: emac: use platform_get_irq
  net: ibm: emac: use devm for mutex_init
  net: ibm: emac: generate random MAC if not found
  net: ibm: emac: use of_find_matching_node

 drivers/net/ethernet/ibm/emac/core.c  | 91 ++++++++-------------------
 drivers/net/ethernet/ibm/emac/mal.c   | 10 +--
 drivers/net/ethernet/ibm/emac/mal.h   |  4 --
 drivers/net/ethernet/ibm/emac/rgmii.c | 10 +--
 drivers/net/ethernet/ibm/emac/rgmii.h |  4 --
 drivers/net/ethernet/ibm/emac/tah.c   | 10 +--
 drivers/net/ethernet/ibm/emac/tah.h   |  4 --
 drivers/net/ethernet/ibm/emac/zmii.c  | 10 +--
 drivers/net/ethernet/ibm/emac/zmii.h  |  4 --
 9 files changed, 30 insertions(+), 117 deletions(-)

-- 
2.47.0


