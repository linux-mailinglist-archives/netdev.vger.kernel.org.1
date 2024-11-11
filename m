Return-Path: <netdev+bounces-143624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A84B9C3623
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60C01F21E05
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 01:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97F213E022;
	Mon, 11 Nov 2024 01:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="LlxF5RKk"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FEE34CDD
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288760; cv=none; b=ZxgkPbSIQsfQ9Kqx6vdmZB/41U9poWi7zOc8U4xrSCNhDD0ZpAkKDXlCOTMKXKqoSOkKvJSjRpmVt8yL+wfWGTavKh0R0XtSG3xLzsvlw8hsX5JnPG1nJhagRGcko4MJuFNBgHGQgn+VYkKQ97EaBld0InRQta6qrNdACSwv9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288760; c=relaxed/simple;
	bh=rMM28hM/Aps2hfial4jkigW1GV4zNvbCMvWYRNCzh8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=low8ctpLi88ARew2NREVKR2r8VABGujYFyE8OF3E26Xsfg9Nh0egjv2P8Xq5Ep6pB4aoKrKarVAfqTO3KkVC+MwOa/masmvP4sqznmLA82vk7HOCez41sA+dH2xeAM000b7mAQvD5mqw+zG/8tGzhJsNEBNBCwJt/EEmoS6Z58Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=LlxF5RKk; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0668D2C0504;
	Mon, 11 Nov 2024 14:32:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1731288748;
	bh=KTrrNUyZUaLN3h1quCtw3ITTGBRzPq71xlnXKA8ZV6Y=;
	h=From:To:Cc:Subject:Date:From;
	b=LlxF5RKkpUVWEQlbiVgMp8yOpSOwChbewa50cMCrFPQm6Ld2Xz/0GCR6qabU9oy7C
	 Gcnt83nb0a/eWatAZkZ7+8lBHeqoZ3qQURS+iMJrBk7cKR6iD8VK3dLjH3dYxG2JSe
	 yL455ULPdTELvWsr0eZd7IB4BJzFsTpstldB7iy56PVgm1e2S58M3fhmZY9J4XeOWq
	 PYSMIPHy9QIBfVWo9GvP/vwvu4U+zT1PFj8dYoYPF5MgyN+4aVGv8VsHOZeTH87j+2
	 /nQ2e7c8xCbKTnzZrkPlktBzzR/jQs05sBvDd0nZjcgWQtw17jFMQ6FCcL7pVILxF/
	 puHMrVeDFPrqg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67315eab0000>; Mon, 11 Nov 2024 14:32:27 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id CE22113ECD2;
	Mon, 11 Nov 2024 14:32:27 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id CBB4B2A151C; Mon, 11 Nov 2024 14:32:27 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Subject: [RFC net-next v0 0/2] Add bridge offloading devlink config  
Date: Mon, 11 Nov 2024 14:32:15 +1300
Message-ID: <20241111013218.1491641-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=67315eab a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VlfZXiiP6vEA:10 a=2uogx45ClAXbkQ8DETcA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add ability to configure if a DSA port should offload briding to HW.
The following patches add a configurable devlink port attribute, which
in turn configures a DSA port. This setting on the DSA port will then be
used to determine if HW config needs to be done when a port is added to
a bridge group.

Aryan Srivastava (2):
  net: devlink: Add port function for bridge offload
  net: dsa: add option for bridge port HW offload

 include/net/devlink.h        | 13 ++++++++++++
 include/net/dsa.h            |  1 +
 include/uapi/linux/devlink.h |  2 ++
 net/devlink/port.c           | 41 ++++++++++++++++++++++++++++++++++++
 net/dsa/devlink.c            | 27 +++++++++++++++++++++++-
 net/dsa/dsa.c                |  1 +
 net/dsa/port.c               |  3 ++-
 7 files changed, 86 insertions(+), 2 deletions(-)

--=20
2.47.0


