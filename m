Return-Path: <netdev+bounces-64889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE6A8375A7
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76ACD28A17C
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209F5482DA;
	Mon, 22 Jan 2024 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmpP3ni8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17048CCF
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960525; cv=none; b=ruSAK1ghEWunMPgTEhdS+3GEKC0mZKjc/toHN6CQyrLcJ1KtTjeU5Khkds12K1vMKZ02czKRq6BfdMqmTGBQnCe8fdeCbRldlniwjOdYkzTW9TxspmuroONieo/CRNJM0DuBw+b90THN5oO5XNZBbPL5RM0M7sNYHyWR/QHDsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960525; c=relaxed/simple;
	bh=Qrczya+cogNkG+BuQ+s8gXjminVX2V8xsSfVKTfez8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rwucOLQIgH+25AS8fwHRzFqMQ5d8P8a+jMoYMsZsjJUFQ4zBft9iamk5orcDjzqjKQph/AgNjoccEOcGF6bPeDQTgTy8BDYiYAK8XrJI6C/UqzujI9K7UzjYxw8VdAN1NBnhOvDO1S1ZEdefGsRknDjvrBde3VPVOeck3lzFsgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmpP3ni8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39469C433C7;
	Mon, 22 Jan 2024 21:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705960525;
	bh=Qrczya+cogNkG+BuQ+s8gXjminVX2V8xsSfVKTfez8Y=;
	h=Date:From:To:Cc:Subject:From;
	b=KmpP3ni8/GP0f0cipxLERLK3iL5/TJFINaqjLLSZ77KSBDe3H89bT/iRgx8Vja9H+
	 vwbRS3vr6AN/jZVLZQldDt3N3NZuoDx/1R2sqI2LFcIwiogNTesz3vMkyzFSZSY2i7
	 dz/oFoSYkNJf4VHSl2o3y9VtsCS9s6ntEaF0SXmiWJ0HI/JQMlQ6vAF84BFysDRpE4
	 v87EJMm9KvbcuNgFgVIBqSYR+tOGeQQpD3EadEBMnQA0P1PP8KueOBbuS1ud9IopP4
	 Ij9KqlhiKu+n0YcQmHzpGa/qdxCv6K2dcxzjGoilceTnzLANW2Fy4iKjpWk0BwLX9m
	 QY7GW63EBc9Nw==
Date: Mon, 22 Jan 2024 13:55:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Jay Vosburgh <j.vosburgh@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [TEST] bond_options.sh looks flaky
Message-ID: <20240122135524.251b0975@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi folks,

looks like tools/testing/selftests/drivers/net/bonding/bond_options.sh
is a bit flaky. This error:

# TEST: prio (balance-alb arp_ip_target primary_reselect 1)           [FAIL]
# Current active slave is eth2 but not eth1

https://netdev-2.bots.linux.dev/vmksft-bonding/results/432442/7-bond-options-sh

was gone on the next run, even tho the only difference between 
the content of the tree was:

$ git diff net-next-2024-01-22--18-00..net-next-2024-01-22--21-00 --stat 
 Documentation/devicetree/bindings/net/adi,adin.yaml | 7 ++-----
 drivers/net/dsa/mv88e6xxx/chip.c                    | 2 +-
 drivers/net/phy/adin.c                              | 2 --
 3 files changed, 3 insertions(+), 8 deletions(-)

So definitely nothing of relevance.. 

Any ideas?

