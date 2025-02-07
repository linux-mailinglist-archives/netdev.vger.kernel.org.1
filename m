Return-Path: <netdev+bounces-164007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D977FA2C45C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690A416BDF2
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA05D1F9F61;
	Fri,  7 Feb 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mzb3v+O1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F71F8AE8;
	Fri,  7 Feb 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936769; cv=none; b=g/Z6zFzAFV57ZbPEPCvP4iNftStF3ZfU6786/o4iNYYKefLRUGbvI9YyW/MkNr9bmQnAkGdwc86OrQ5Trc7iqUV/iOwQxIOkjI5MXKsmmY6x/ysJw4QgXEuIDq7AS9Fde46k1LXU3pqJCnW1Hwp8NtpbEV1PU8n4LqqEmSBjTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936769; c=relaxed/simple;
	bh=1Z1+NL8yeZN9e9Y7PheCaIDo410qxsv0w5WsGMG7jd0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=raBKmKGl5VwRGk/tLKnNNGou6PwcE9PozQtqqlqQM7ggdph6tSRad5IUfcTptP0CLjJva+ZvbQesv9IZTrpLaGTEPwy7AclRQ/0BdKr+3gkUmS+cge6zWC1PLXlLXm0ftDgk5p6edDZ/LlxO5sCrl5zA/Il4dfswE/sygjXBwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mzb3v+O1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFEBC4CED1;
	Fri,  7 Feb 2025 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936769;
	bh=1Z1+NL8yeZN9e9Y7PheCaIDo410qxsv0w5WsGMG7jd0=;
	h=From:Subject:Date:To:Cc:From;
	b=Mzb3v+O1yft7lyMAZukW4IvRF/4p4M+QvJmVnThgZ0WEbmtS6NyFmRepo0k8BLIJa
	 Xkwsjs1Zlm6akochNdwETzOFJ2kdNMxDEvMuze1HS29qaBl0WOkbkETMszAMGQLjHP
	 NyZpCNIypjPvr1aDrKC7lIqpWAvjLOmN38eJq/nhIxxcBQIt6Shp3+b5L7lTMafTTz
	 AajnQzKZDCfTviUQAtbllGiERkWHj8kS6Ydv0V1bjcsvqM7LNAHfXpBlfLQl6bCLyz
	 6JyRR4jb5Gocd51o9/qEdw0qn7wpCXQdkWS3Ixag5XHvgQQL6tv6xhzaJzPCVWpXAm
	 waopiT4KtXTPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v3 00/15] mptcp: pm: misc cleanups, part 2
Date: Fri, 07 Feb 2025 14:59:18 +0100
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALYRpmcC/43NTQrDIBAF4KsE152i5qfSVe9RukjMmEgTI2olJ
 eTuFaHQ7rKYxeMx39uIR6fRk2uxEYdRe72YFMpTQeTYmgFB9ykTTnlNGWvAYEi3BphtkBbsDLP
 2EuSErXlZ4NBRVVNUSlBRkcRYh0qveeJOvt/kkZpR+7C4d96OLPfHZyIDCpJ2VamYUEib2xOdw
 em8uCHrkf+KlwMiT2LD+ipptWhQ/In7vn8Aa58GOy0BAAA=
X-Change-ID: 20250116-net-next-mptcp-pm-misc-cleanup-2-b0f50eff8084
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3259; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1Z1+NL8yeZN9e9Y7PheCaIDo410qxsv0w5WsGMG7jd0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG9lRnBPv0YSIvaVRrtU+I7VLFpBVrB9xAAl
 BLUnk2aJPuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 c/EhEACZCiM5ZIeuwZ+3CHKHFdEgVVN2YnO5FlDtlHlI1q5As9P+6yDHuGyRCMaT555HwYVV9pv
 7dNJEJeDtvLZlMwEjVHrpOWw4lbIgfxKnIQgq3cf1ULy2gnuRVBz5A6W9Yvyp4x8dYdjgsLG02y
 Y//9IIs4dbGGzuSksVISmpVnbJLWz3XfDKadjLVIIDPYkl9gA10G4LAcvhJeKDfWhYpWWS240t4
 fPXHsSkpf6o3GiKSsBMd7DXXOv+qvVT0Fpx+7XYr9UZGlzaR9eHuY+hhRasX4OrFoGbWsaWp2Ll
 XzBhhCsdQHuAIezCLxPB0y/lEbj+5ywZ+4nnX0qmxKTCReCQ3egNBBHdTYdFzKZwStDPOQzjYhY
 mEYj8s4xsIxIJDnZ9hDwgQdnKoFhvZMxoM06S+dkiWiya7Ult6w4RSEuilv6SMzjIjirO2ItVoL
 IdTvStg1hnABUOU4qFnJgPnzkTJ8/lU1x/tPg3a9sNh66Ygpbq5Jno8ka6eP+fcM3yokKFpjys6
 oHYYeYCUWE1H72c95YSN5VJm7UmqXli4aWD36tKw3KnTXDs25OLegJdAUCOapD5q5WsQYMlPdcK
 7LbNAcv4vMjBwyF5PpiWK3Oq0j0ahHeH7Fh/im83ZvFFvNAGgQ2045wKAL5klR1PnmfyArDtZu4
 asCpKIDh8g/MQCQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These cleanups lead the way to the unification of the path-manager
interfaces, and allow future extensions. The following patches are not
all linked to each others, but are all related to the path-managers.

- Patch 1: drop unneeded parameter in a function helper.

- Patch 2: clearer NL error message when an NL attribute is missing.

- Patch 3: more precise NL messages by avoiding 'this or that is NOK'.

- Patch 4: improve too vague or missing NL err messages.

- Patch 5: use GENL_REQ_ATTR_CHECK to look for mandatory NL attributes.

- Patch 6: avoid overriding the error message.

- Patch 7: check all mandatory NL attributes with GENL_REQ_ATTR_CHECK.

- Patch 8: use NL_SET_ERR_MSG_ATTR instead of GENL_SET_ERR_MSG

- Patch 9: move doit callbacks used for both PM to pm.c.

- Patch 10: drop another unneeded parameter in a function helper.

- Patch 11: share the ID parsing code for the 'get_addr' callback.

- Patch 12: share sending NL code for the 'get_addr' callback.

- Patch 13: drop yet another unneeded parameter in a function helper.

- Patch 14: pick the usual structure type for the remote address.

- Patch 15: share the local addr parsing code for the 'set_flags' cb.

The behaviour when there are no errors should then not be modified.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- Patch 11: a variable was no longer assigned in pm_userspace.c, but
  still used in this patch (and no longer in the next one). (Geliang)
- Rebased on top of the latest net-next.
- Link to v2: https://lore.kernel.org/r/20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org

Changes in v2:
- Patch 11: a variable was no longer assigned in pm_netlink.c, but still
  used in this patch (and no longer in the next one). (Simon)
- Link to v1: https://lore.kernel.org/r/20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org

---
Geliang Tang (9):
      mptcp: pm: drop info of userspace_pm_remove_id_zero_address
      mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK
      mptcp: pm: make three pm wrappers static
      mptcp: pm: drop skb parameter of get_addr
      mptcp: pm: add id parameter for get_addr
      mptcp: pm: reuse sending nlmsg code in get_addr
      mptcp: pm: drop skb parameter of set_flags
      mptcp: pm: change rem type of set_flags
      mptcp: pm: add local parameter for set_flags

Matthieu Baerts (NGI0) (6):
      mptcp: pm: userspace: flags: clearer msg if no remote addr
      mptcp: pm: more precise error messages
      mptcp: pm: improve error messages
      mptcp: pm: remove duplicated error messages
      mptcp: pm: mark missing address attributes
      mptcp: pm: use NL_SET_ERR_MSG_ATTR when possible

 net/mptcp/pm.c           |  86 +++++++++++++++++--
 net/mptcp/pm_netlink.c   | 129 ++++++++++-------------------
 net/mptcp/pm_userspace.c | 209 +++++++++++++++++++++--------------------------
 net/mptcp/protocol.h     |  14 ++--
 4 files changed, 225 insertions(+), 213 deletions(-)
---
base-commit: 26db4dbb747813b5946aff31485873f071a10332
change-id: 20250116-net-next-mptcp-pm-misc-cleanup-2-b0f50eff8084

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


