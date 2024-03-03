Return-Path: <netdev+bounces-76869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5368C86F3B2
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 06:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA40E283949
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 05:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0772B6FC5;
	Sun,  3 Mar 2024 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU6YqMDX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80426FB6
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709443458; cv=none; b=i01kStJMnetaGmoe+lB40Rnv8oqn11EIge30ZvN9VM59YcM/Vs7NPlMt/Q2KPe+bCVdF6e2JIA3TEbAhwF8kPM+Cs8HAUSPTu1lnKsR9b/eq9vBIpOYcqLM36ZptHsbQVNxfpmvc0xabaDEM+QzxKMvQm8hd0aI+H5ipWxHgjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709443458; c=relaxed/simple;
	bh=kJN9Gcq/Qoa1Ol+ldtKKBLAhYRFhjR+q6dqe++1aHnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqOKKbWU1g3Pw3Y6uxoZ8HQXgh0l/fiohbXWA/8Iannd/MDH7fe2OEYo9JlqvdGWnXA4FUSw9gZGfBMA9M7iimqIa17f3BMxChuK4OqqZx/gqIzIn1i5wRDWmzm8nqK9w0gf/eL+P3oMm07EPQq7Q80S+cPPqe35Jzm6cV3eisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU6YqMDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB623C433C7;
	Sun,  3 Mar 2024 05:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709443458;
	bh=kJN9Gcq/Qoa1Ol+ldtKKBLAhYRFhjR+q6dqe++1aHnY=;
	h=From:To:Cc:Subject:Date:From;
	b=YU6YqMDXxnhtph77YVanxxrC7Xl2/y72otFpAypYwSkmTT1yM8x1GC48lrCuEDQOe
	 pXUanta3yVr2lV1kmC0XZaXZrbejcy5WoAhUN7HqAF0YkaKEwSt7UxhHFfugeCmHxm
	 SxcZfUdpRViVYN/s1O2foduljXQlp339zJqNZ9LQx0yf9u92ZOLZdbTQaaXyGddgm1
	 ULEfcYvgkLt1jzcc7I4iFD4pz3UpHuLqYS9mqcApPNieAD5Az9HFeIk5cFFZe8g2Yk
	 0GzWmBnPoIH/6VPdcujD3Q3gXmM6DPf+/5iM4LpT6gjdOJ57Z1fUGj3VwMCCKEdZqj
	 Z/Ru7l+ttGF8w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	idosch@idosch.org,
	johannes@sipsolutions.net,
	fw@strlen.de,
	pablo@netfilter.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/3] netlink: handle EMSGSIZE errors in the core
Date: Sat,  2 Mar 2024 21:24:05 -0800
Message-ID: <20240303052408.310064-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
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

v2:
 - init err to 0 in last patch
v1: https://lore.kernel.org/all/20240301012845.2951053-1-kuba@kernel.org/

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
2.44.0


