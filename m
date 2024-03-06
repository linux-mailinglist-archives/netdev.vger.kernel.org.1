Return-Path: <netdev+bounces-78097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE358740E5
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9631C218F0
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36F513DB9C;
	Wed,  6 Mar 2024 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJxuDjob"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F8142627
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754918; cv=none; b=Z/vzYAHTLkxa2Wv8SJMicwZSoI8CpOBmOj7JlG0Pb30kNWpaTHGxWEYND3BGvYl9jhs8owBVvlPB3rc5A2C58wuf7edXDOhIhxwy5GC2ec/HkDvTPVB6lNjzhmeVM+5fBcsShHSnbhCVttY2gcao0JPyMwp5SNyXog0K0Nh1ayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754918; c=relaxed/simple;
	bh=V6nM5VXdPmZSeagnpuD2OkE9T80kS8wkV7P+joAaK38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5DpXF6B230+osU49Ouv+iXeq9R3seNk0Jg6WNUy+BtQiw11KdkPjNrTmPPuV2U5frU/+0BdwgNGmtBFrlQFDPjochrxr1AI3pRijrma4CRrYI1+2a/X0Oprwc5u8r7y+zySYaRvDq3xcrBJyu6+6hmgrPXlevUUrN31l1YZbWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJxuDjob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEAFC433C7;
	Wed,  6 Mar 2024 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709754918;
	bh=V6nM5VXdPmZSeagnpuD2OkE9T80kS8wkV7P+joAaK38=;
	h=From:To:Cc:Subject:Date:From;
	b=BJxuDjobc9lWyxFnTEfhtKPabx5vcrn2snmaKMhM3Z9oq4YIZjkCxAe3OSh5BHykA
	 +Ss7388LCEtg4Mm5DHvWrsKMPytmNhcYQwAfQyYsuhk/+/gv2kEA+SQaZa97NKmn3J
	 6tPl+ivBsN9DukU9hWFWjBau7fOqg7VD2C14v07rOJw/2y4rm58cXOf/CshGrES24s
	 zQalbaVXuY2q4LgEnVP3tOPJTYaFL6cqcu1ul81OMnfabY2ja+jXNMn/d0MB9nFhLp
	 kWIdWylCPD89acixdIOdilVy9jlJv6V5PWPSFTfHlIiLFaq6l2iFD+locVr6GKnIHo
	 bVUWIGAQfMGGA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	amritha.nambiar@intel.com,
	danielj@nvidia.com,
	mst@redhat.com,
	michael.chan@broadcom.com,
	sdf@google.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 0/3] netdev: add per-queue statistics
Date: Wed,  6 Mar 2024 11:55:06 -0800
Message-ID: <20240306195509.1502746-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Per queue stats keep coming up, so it's about time someone laid
the foundation. This series adds the uAPI, a handful of stats
and a sample support for bnxt. It's not very comprehensive in
terms of stat types or driver support. The expectation is that
the support will grow organically. If we have the basic pieces
in place it will be easy for reviewers to request new stats,
or use of the API in place of ethtool -S.

See patch 3 for sample output.

v3:
 - remove the dump error handling, core does it now (b5a899154aa94)
 - fix ring mapping w/ XDP in bnxt
v2: https://lore.kernel.org/all/20240229010221.2408413-1-kuba@kernel.org/
 - un-wrap short lines
 - s/stats/qstats/
v1: https://lore.kernel.org/all/20240226211015.1244807-1-kuba@kernel.org/
 - rename projection -> scope
 - turn projection/scope into flags
 - remove the "netdev" scope since it's always implied
rfc: https://lore.kernel.org/all/20240222223629.158254-1-kuba@kernel.org/

Jakub Kicinski (3):
  netdev: add per-queue statistics
  netdev: add queue stat for alloc failures
  eth: bnxt: support per-queue statistics

 Documentation/netlink/specs/netdev.yaml   |  91 +++++++++
 Documentation/networking/statistics.rst   |  15 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  65 +++++++
 include/linux/netdevice.h                 |   3 +
 include/net/netdev_queues.h               |  56 ++++++
 include/uapi/linux/netdev.h               |  20 ++
 net/core/netdev-genl-gen.c                |  12 ++
 net/core/netdev-genl-gen.h                |   2 +
 net/core/netdev-genl.c                    | 214 ++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h         |  20 ++
 10 files changed, 498 insertions(+)

-- 
2.44.0


