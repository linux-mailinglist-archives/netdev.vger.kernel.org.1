Return-Path: <netdev+bounces-159424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D563CA15764
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A771188BD45
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CE41DCB24;
	Fri, 17 Jan 2025 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK8HfPhx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263AF1ACEA2;
	Fri, 17 Jan 2025 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139310; cv=none; b=q+eQ7U0vy+HqysPZsJj+JO/WFXP0AcCoxqWrT6kHKhxPk62JSJ6+d4IMljWCHQDLOtsTfGOk6NyJALHinAJWiUiNECBYIrImAi5nSgNYc8Rlh23aFOALSWNBFWEact12xk8pKOMh4BtjHyBNG11oiwF7c4kxP7ooDql2RD9VYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139310; c=relaxed/simple;
	bh=ppd0S/67u/BA6Vxk5fv3pnmLF9P/Q7DFmrk02Nh+47o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kCXpXyOzgQxSusSzN4c4aosq6SvtUqxntejAVEujNYcILcM7Mqwoa1/tEDDcDa9zFUKd1rI5rgbdKmdJhcZ7ognJbeDKxEeK9oLLHeCw/cQvHPCFN4yeVzFWpVz4VHYJmT1R18S3FyHN03xB3KP+1UOFtwmxHjRdUoJe8FCsXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK8HfPhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D68C4CEDD;
	Fri, 17 Jan 2025 18:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139309;
	bh=ppd0S/67u/BA6Vxk5fv3pnmLF9P/Q7DFmrk02Nh+47o=;
	h=From:Subject:Date:To:Cc:From;
	b=ZK8HfPhxQaR+5CUvUtp6qDplIgLjk3uyh6KeKzUfyHOTHbUVLT6WSqG8sgFZZxCTS
	 booGDXJ1fsXaH1qMNR1Y2GLjyQrJzseDZ+qrf/sbICAkVPS8kbaGL5yNtARqmxMIvf
	 J3o075NFuXt0cFMEez68YFAT24Y6M0MKwBZ+jvEYo5ONUN5tNnHk+R6XkycUbd4iGg
	 n8BfO//Gd4hKibFAz8mxIJlAhrGHY67OgsfGkGxQl/VyhpA9Og161Sbzk/tbmX9cSr
	 O/Sxq9lcu82MVAWQHiEeK7bwKA9ADzyG8KZIB9V3QZh30pzwlJm3J2/2i9w00vJvr0
	 PlAoLKnljJvDA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v2 00/15] mptcp: pm: misc cleanups, part 2
Date: Fri, 17 Jan 2025 19:41:32 +0100
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFykimcC/42NwQqDMBBEf6XsuVs2qYr01P8oHjTd6FKNIUnFI
 v57g9B7D3N4DDNvg8hBOMLttEHgRaLMLoM+n8AMresZ5ZkZNOmSlKrQccpZE04+GY9+wkmiQTN
 y694eNXZkS2Jra6oLyDc+sJX1UDzgt4YmN4PENIfP4V7U0f+vWRQSGuqKq1W1ZaruLw6Ox8sce
 mj2ff8C50VlCtsAAAA=
X-Change-ID: 20250116-net-next-mptcp-pm-misc-cleanup-2-b0f50eff8084
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3085; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ppd0S/67u/BA6Vxk5fv3pnmLF9P/Q7DFmrk02Nh+47o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRq0LTTaFG5TRp7WBhLiAvm3KMyX3dnRVe4S
 f7XCJT7eJWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkagAKCRD2t4JPQmmg
 c5F2EADKoCaGKTXGOwyunaFz2DcytvIbTxUhIQhb/+HXCFpWI/IwxG/2yFIXi5hUUU2HSy/KsMS
 dTyTQ8TTudxC2GtMj9a4eSmPRNVScs6h8zhvz4yJcJm4RS6zbB6pk//vEcMrInfNBVymLBxXuYs
 qHOOM2xmoK8e4TO1pZHWTWk6wBKBe1KG9jo820MBz8Fv8F/ZVINXkbxGKW8hD7JKLhJnERweyoX
 ANJPEek/beIYmPTo7GUz4Q3/7tMrwPfcEdgoIJWGCWV6/srh3I3i+z/FsNDFN4dQ3Ce4A9eR9Sg
 3NzVVoubeWZMBB1K3C2cfteeTk69ZvRAgDqKqqXFriyaIvJH5Ov8dRz++m8wKyBN3nVThyUTyXS
 V/uMmFbb8DZS8nXSLjgt8d6kBC2sjhWWtATLMwOEIYRopbFSJ9p7oRbv2/3t4w0+QBs2GT2W7g8
 /TWkTj8XsVBQBM5Krx7JikAm5DGqOu1iLh6N8nJd43qLi7Qcm8sOMeVSsh7ZJoYvNQM5lOcnhYR
 a+/M/Ka8+EI72HwwBV4x0drlbC67HsSkMYACXcUySUWWmMCzL8DjKumSAoYX7QtuwM/ak72hOJc
 o85p/YujUPOgqxdAawEoCUJ6xPVAXzpOk5iGXg+IKxjJ26/yHTj6eaU8vB3C5p8hc0TtQXL051K
 cLl0OSSPfah7Xbw==
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
Changes in v2:
- Patch 11: a variable was no longer assigned, but still used in this
  patch (and no longer used in the next one). (Simon)
- I hope it is OK to have this series in parallel of "mptcp: sysctl: add
  syn_retrans_before_tcp_fallback", we had 16 patches left in the queue :)
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
base-commit: 7d2eba0f83a59d360ed1e77ed2778101a6e3c4a1
change-id: 20250116-net-next-mptcp-pm-misc-cleanup-2-b0f50eff8084

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


