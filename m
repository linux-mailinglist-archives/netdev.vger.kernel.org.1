Return-Path: <netdev+bounces-235742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82165C34778
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EEA18C3574
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD32729B78E;
	Wed,  5 Nov 2025 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSE+LN6y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AA229BD82
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331334; cv=none; b=UBGD6pgC1qMGWeBB23Sp6io+wfIga2luNSSTXD6G0lYFNVhjuIh1kk6cb0VVMynEsmFd3k5ZKhcTUZ4KHzMeIM4hCK5GuFWSiV8d6W86jCzfmYK8+GuvWVRzSMOsRGvb7E4I+g/U35JDztSFAHvC7RRTmH/X68MB+sIYNj72mW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331334; c=relaxed/simple;
	bh=DlD7XZ/bzfpVlq9YilLjwMpbU1Ue9PsSHUN85MwX378=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSE6DJaFD2ozQ4/StgHqdV2vBORe+1l43B/Y4WMevufEaxg+Ze7d/CZMT3e9Ot+13JTqMIsmIpanDxO3UQEr79SITrZmnCUsvrxGEkBfuZ06urXA8gVb0p0jLIhPnDdMICKcAnLps02tJbmrRXLJq6/kc1L9zmrf7xfg+3YtRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSE+LN6y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2952048eb88so70496075ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 00:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762331332; x=1762936132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj9ztHcRJ4eUFcDTiZAvAf9WmJ9pDCq1nGAlcOW47IA=;
        b=RSE+LN6y1PdOwj3FCCkbJvMz1mMOBOHhswFEG+uq16hO0i5AWdZnZA20stKtmmaPDc
         P1XFjP6W5JMfAymjivetGN1Urzfe6QTxfI/jcfwnI0JA1j6Tppjl6cogGn/rGyeXy0Zm
         /yhzWCiNc2cGfxWTbeCupYXzOS3B4SpZ10f5sxfLvrYZw41/mVPBGmbXDQlPUpxVy9vQ
         BXzVp9bi9y1smgYRYy4PSYr3OBRAgXGhBBkbcwLK+bcUJFSj9uWyQWIguLlS/OlSMEmG
         rbP9FWFQhcSyDHEkbBAEVcqz+H5225h5Il93WasCJiXqITyDbQI5NKTCbDTVzvngFUyR
         NsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331332; x=1762936132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vj9ztHcRJ4eUFcDTiZAvAf9WmJ9pDCq1nGAlcOW47IA=;
        b=UgFLYCAvmYW2GTIzs3sh/VogjfjhRH5N/+HLyjvy30KbwADfwqkr8Mwmd9dGoGSOAK
         esg0Nydrg+h2MM8Dkl9CCycmdhmqn2Jor8zEc5/Wv7wv3HMqTAS0t6xsih6IdC/YJUfq
         LoiQ+/RjK1k8UWe/dAHmJpEXDsK3TsDAeGR4exkLCoSCWUKDjyp853aT8ZVCCzMRzKVk
         9u5sm9K3D8YSPS1NCKUWpJ0S0rUmE2o6GkbZDIuh0uq9VQjlSStejXlZuOrAGHTxk5de
         1wyniP/lvGGuMSIFOBdbPSayTZhr/fHEWWgUAeoP8lynLx6m7CIWcXwgdxiXMAICyGva
         HJvw==
X-Gm-Message-State: AOJu0YxF4KJFEuYRfSkARiK6HGDclt0k5krP2JHn/zKFfWbphfa+ALc2
	poplJVPe1KwsmeFBMZjRASEJEKsCkZmyCUQq2beGIifV2rObAGhoWWgK+uTJnEvuYVI=
X-Gm-Gg: ASbGncsaE2t7hArfuUCPR8whYKjwW3tU1aVGYTdg7jH44LIpIH8EfCeZzuSJe7S1ILl
	JJwO1R5tO58vFYsfN0GYCRchp+DFFaypE75d7znPRwToSCoUKc2/iSLgaixo6XM+QaWa+XLSKec
	YZ9J3VfZNa+28UBcTn80gFbFF6vZPPBpKeTAA0bO3hXysR7OrBqtSlLyo9Ns2TZbYf4TzYg7ql1
	5vQmSLodmbBKsaREnPd/xJ7Uqyrg+dTnx8baqsFNx8pvmGEOrjGdZbNRD3fCpmvu6W6oku6bDwu
	y3VP33a4RyMOJBdpJjhEU1r/FKrL/ijK7fyilolfHRhOfZnsC8pyeaS6AYT5+8KAacsnMYZhthA
	6ufcB+dP51i07M/Favwz2pC0OgSa1lHqg7+rCHcPA+IrVjhv0f0RrcNsm7LPg3eISIDlZfIAjfJ
	KFUjGDRxvVPMK5Hl4=
X-Google-Smtp-Source: AGHT+IGT07MqVIWLyaGa6fJx6kFYlwVVGw+QLeCm2PdYaMDiKadI7HZJcYVwzlrRJDLUO0lj8ELndg==
X-Received: by 2002:a17:902:ea0e:b0:295:f1f:67b with SMTP id d9443c01a7336-2962ada2efcmr37879495ad.39.1762331332208;
        Wed, 05 Nov 2025 00:28:52 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a3a0c9sm52171705ad.55.2025.11.05.00.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:28:51 -0800 (PST)
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
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 0/3] Add YNL test framework and library improvements
Date: Wed,  5 Nov 2025 08:28:38 +0000
Message-ID: <20251105082841.165212-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enhances YNL tools with some functionalities and adds
YNL test framework.

Changes include:
- Add MAC address parsing support in YNL library
- Fix rt-rule spec consistency with other rt-* families
- Add tests covering CLI and ethtool functionality

The tests provide usage examples and regression testing for YNL tools.
Test result:
  # test_ynl_cli
  PASS: YNL CLI list families
  PASS: YNL CLI netdev operations
  PASS: YNL CLI ethtool operations
  PASS: YNL CLI rt-route operations
  PASS: YNL CLI rt-addr operations
  PASS: YNL CLI rt-link operations
  PASS: YNL CLI rt-neigh operations
  PASS: YNL CLI rt-rule operations
  PASS: YNL CLI nlctrl getfamily
  # test_ynl_ethtool
  PASS: YNL ethtool device info
  PASS: YNL ethtool statistics
  PASS: YNL ethtool ring parameters (show/set)
  PASS: YNL ethtool coalesce parameters (show/set)
  PASS: YNL ethtool pause parameters (show/set)
  PASS: YNL ethtool features info (show/set)
  PASS: YNL ethtool channels info (show/set)
  PASS: YNL ethtool time stamping

v2: move test from selftest to ynl folder (Jakub Kicinski)
v1: https://lore.kernel.org/netdev/20251029082245.128675-1-liuhangbin@gmail.com

Hangbin Liu (3):
  tools: ynl: Add MAC address parsing support
  netlink: specs: update rt-rule src/dst attribute types to support IPv4
    addresses
  tools: ynl: add YNL test framework

 Documentation/netlink/specs/rt-rule.yaml |   6 +-
 tools/net/ynl/Makefile                   |   3 +-
 tools/net/ynl/pyynl/lib/ynl.py           |   9 +
 tools/net/ynl/tests/Makefile             |  24 ++
 tools/net/ynl/tests/config               |   6 +
 tools/net/ynl/tests/test_ynl_cli.sh      | 290 +++++++++++++++++++++++
 tools/net/ynl/tests/test_ynl_ethtool.sh  | 195 +++++++++++++++
 7 files changed, 530 insertions(+), 3 deletions(-)
 create mode 100644 tools/net/ynl/tests/Makefile
 create mode 100644 tools/net/ynl/tests/config
 create mode 100755 tools/net/ynl/tests/test_ynl_cli.sh
 create mode 100755 tools/net/ynl/tests/test_ynl_ethtool.sh

-- 
2.50.1


