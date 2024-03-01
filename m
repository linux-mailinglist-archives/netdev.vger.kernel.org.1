Return-Path: <netdev+bounces-76383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1265786D8C4
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A806AB2168B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 01:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE672376E2;
	Fri,  1 Mar 2024 01:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+gHwnk0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF402B9DE
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 01:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256691; cv=none; b=upFHkKiE8hp6vcd8L3NQ+icnWbMYX3qSe/1XLyrCQY/HlMPdMywbgVTrfJzVvS82qPEbTW2ybYnHFtGyq95gbZTX5hNGi+ApuJY7mXPuUBmRUM9y37z6d5xJ49+o3HKaD3OO2p7vCaX4G0ZAnbSYfQGqq5EWfTJqHkFTzw1vdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256691; c=relaxed/simple;
	bh=C0waZBjgNSQR4ZcQbvAJRhLQhGMRfqJFKRUcOaVOFYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NyeXETgIkvajMm0qyY5iV59uWNswGIHSKiED3+LcmRnbAjesi/NzJ/I4oW5WaXVzH3VDFIZ5etehCO4b+2q5uZYJpLbB/kRRBjU/DkioGZRhUvn+XEooVrNwmt+YFMxQjrNUC3T0m/bunn+Bc16OGazkS0vN6WPYxZGSaBKGPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+gHwnk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CFEC433F1;
	Fri,  1 Mar 2024 01:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709256691;
	bh=C0waZBjgNSQR4ZcQbvAJRhLQhGMRfqJFKRUcOaVOFYM=;
	h=From:To:Cc:Subject:Date:From;
	b=s+gHwnk0Mj6g9Y8ovuy2Zq8GeHLWdaHP6u/vhBYvYSDsA3ETMqbAvHvToNINW8YlL
	 XiF/Y4f0qyHlFodwBpgTiDn1/36vox1DuqANu8ReC4uLgQiRNCR5J5kQkKhJS73nLa
	 Ukbe+Mh138BIiFiOxrlVnSO+puZ3GWeqxUjiTf+qaSVYpRfW0QjMlexMvTwu4ima8d
	 wWejNAIuKHHslP9+cmSmQUWVinh3raNY2VnBm86vlq+rF+b049nfSF7w3WtoduqXIs
	 R5CtP/it/ASvbXnQ45GSw5IR6VI5eWb+6WxoFdeYcs1jDgAt8Tu3lZh32oD5OHQKmx
	 golNRkowtpmgA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes@sipsolutions.net,
	fw@strlen.de,
	pablo@netfilter.org,
	idosch@nvidia.com,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] netlink: handle EMSGSIZE errors in the core
Date: Thu, 29 Feb 2024 17:28:42 -0800
Message-ID: <20240301012845.2951053-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ido discovered some time back that we usually force NLMSG_DONE
to be delivered in a separate recv() syscall, even if it would
fit into the same skb as data messages. He made nexthop try
to fit DONE with data in commit 8743aeff5bc4 ("nexthop: Fix
infinite nexthop bucket dump when using maximum nexthop ID"),
and nobody has complained so far.

We have since also tried to follow the same pattern in new
genetlink families, but explaining to people, or even remembering
the correct handling ourselves is tedious.

Let the netlink socket layer consume -EMSGSIZE errors.
Practically speaking most families use this error code
as "dump needs more space", anyway.

Jakub Kicinski (3):
  netlink: handle EMSGSIZE errors in the core
  netdev: let netlink core handle -EMSGSIZE errors
  genetlink: fit NLMSG_DONE into same read() as families

 net/core/netdev-genl.c    | 15 +++------------
 net/core/page_pool_user.c |  2 --
 net/netlink/af_netlink.c  |  9 +++++++++
 net/netlink/genetlink.c   | 12 +++++++-----
 4 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.43.2


