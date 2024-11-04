Return-Path: <netdev+bounces-141593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBC69BBA99
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52B11F22502
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7B61C4A07;
	Mon,  4 Nov 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS3rrS4u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80F1C304B
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739245; cv=none; b=NtnDa74+nEa15M0s7TPE03YoKJUGeSBHGTciNWxUj2Wyg++DMfSzuME96c66CsMZDMuTk4FUD4fytAvbFb1bCzVTDqjtcWaycZ/tDLgjlgHf4NtZIO4tetKu6TBVqR6DsEINkLY0gb6V6zU5mvSRpjcQX0jYEreNsY1KyeWP/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739245; c=relaxed/simple;
	bh=PalyVIEJgetnZgVeiXxw16ytu6k43Ef+gvpB3lzpCpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0rTpCuxMV1bOD88ubbW6eHBJLn5WQobnPGPNbbVMG/oTwhlU2SFxav/jzcZZPvVmBxT1YqgHnkJ25OaLav0aS/l2ilcz53rGGuBfCmDPWJiER7pczVemq7keVZ+8Wa2UBLLvNxyPAb/P2mmsiAuvMkAcaktSz5pDGvKlbv0T8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YS3rrS4u; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4319399a411so38886485e9.2
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 08:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730739242; x=1731344042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lu+PX4eg3XLzrzdFO/07o0stso0MynG7ok/c7nqfy0=;
        b=YS3rrS4uWgzTjla58txkK4jAVGwRryKA7kO91aUwDghRARBZI9uJkeMaPwm8B05wcU
         RWknVdCNkg27ylGKMt3XGO7o9n+HqmRxEIh94FKU7feep2+z0tlgdD+UrhEMUt3dYLqL
         k0rVz/ox8s1h4nywNxeWUa4RzXEyKFt2rwVSU/skjRvIhPNMQyXY8YQhyik00W2y3+kf
         l+l8eNrgOgn6QT7PmTqIw82djH1H4w5/lEbcr+U42sxJobBv89j+k2BgEPry3cV7AAw+
         4zV9djAX6aYCHRJdvusnWxg31OxodPkPgo1An1KMD7CRORnKxQAv6uJxTAQHRsT5vvgp
         sAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730739242; x=1731344042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lu+PX4eg3XLzrzdFO/07o0stso0MynG7ok/c7nqfy0=;
        b=K5g3OQYTq2nYzPWiMntIckoj7Q1BbkORKLqL4BQMgraphR2P1PN4UM/kTITUxyeU4e
         5O0jyz3GvMOsCuo3aFQWbx0ol1lAZnyboxdM2o249bYuXfU53AoXhMksaB0JRsdRNZDc
         yJQcS8U6BO59pY5DoU+kGi3SP5pXRGn3cj5OBnDksrNxfavbpKMLj8rCFDf5DtKRRj7G
         63xIZ6ukL8h6Es/+uvzlRsAb8BpojNHT5bvisZxHBF81hnDJA2ahNWMy9OgrKg4MRIjF
         7S4noLzwIqmoJPw5CKqzxFYD5JuN74iaPekfzacFxPs56O5hIYhISzkEqLb1YJOf52/4
         wh2Q==
X-Gm-Message-State: AOJu0Yw8MTsz2Thfob8q6SkOJpbsndx4YlE37Nk8FqNZ8IwzZj6OAQlN
	WNZJPEgeH3e1iCyP6ykIPbVHCBYXqYsYTAgzobHqrUZi4oEA1fJBNo1eTg==
X-Google-Smtp-Source: AGHT+IFHUPv2D5Gl5Vi8CtpVLhV03P1fYOScyV3DKrydQBYc/YG6dIBQNZKnAOl4GhQC7Fq32IghnA==
X-Received: by 2002:a05:600c:1d99:b0:431:1868:417f with SMTP id 5b1f17b1804b1-4319acadccdmr336704035e9.17.1730739241485;
        Mon, 04 Nov 2024 08:54:01 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:71af:4a7:35c:6d53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6852e4sm156878085e9.29.2024.11.04.08.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 08:54:00 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 0/2] netlink: specs: Add neigh and rule YNL specs
Date: Mon,  4 Nov 2024 16:53:50 +0000
Message-ID: <20241104165352.19696-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add YNL specs for the FDB neighbour tables and FIB rules from the
rtnelink families.

Example usage:

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/rt_neigh.yaml \
    --dump getneigh
[{'cacheinfo': {'confirmed': 122664055,
                'refcnt': 0,
                'updated': 122658055,
                'used': 122658055},
  'dst': '0.0.0.0',
  'family': 2,
  'flags': set(),
  'ifindex': 5,
  'lladr': '',
  'probes': 0,
  'state': {'noarp'},
  'type': 'broadcast'},
  ...]

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/rt_rule.yaml \
    --dump getrule --json '{"family": 2}'

[{'action': 'to-tbl',
  'dst-len': 0,
  'family': 2,
  'flags': 0,
  'protocol': 2,
  'src-len': 0,
  'suppress-prefixlen': '0xffffffff',
  'table': 255,
  'tos': 0},
  ... ]

Donald Hunter (2):
  netlink: specs: Add a spec for neighbor tables in rtnetlink
  netlink: specs: Add a spec for FIB rule management

 Documentation/netlink/specs/rt_neigh.yaml | 442 ++++++++++++++++++++++
 Documentation/netlink/specs/rt_rule.yaml  | 240 ++++++++++++
 2 files changed, 682 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_neigh.yaml
 create mode 100644 Documentation/netlink/specs/rt_rule.yaml

-- 
2.47.0


