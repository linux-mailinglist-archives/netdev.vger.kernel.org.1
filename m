Return-Path: <netdev+bounces-243429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29589CA0B89
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 19:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9A17300723D
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 17:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DAD32C333;
	Wed,  3 Dec 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+a4KuIx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FDE329E42
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784257; cv=none; b=mXWl+MJAquNenSTRNwDVa69DgZzkeDcWh9fyfEVR6glC5LBrwTl1xrUqQ7nB/lcqiuhndUNHWxhSsSqP9E6WSOZ5YWtHl5IuKBjDNsBuXKaG6+uB49s60/OC8+lxtehVB0dI5zCvUonUxKm9kDA7vb6gnHkUoNCtLecOqcnvViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784257; c=relaxed/simple;
	bh=L1Rjrz0SBhHBnz94D8LyL42lPT5lBfs2KcvUjbK/wuE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=D5gVVCpv3iR+tJ2TwwgtKKGe5pfXA7exKXs4n2mqCPCcBmYZh33JpWnPzA8+jMDzjOAOlc/NSXhl9IUuF3PtDOOzuhLbYf+Mwrm7eQJtQpgtiHp08J11fzZHExbwz9vphcmcr5X2/rJGFWvGSsYFwFtp/jsxx1NEObGO+y96zdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+a4KuIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE726C4CEF5;
	Wed,  3 Dec 2025 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764784257;
	bh=L1Rjrz0SBhHBnz94D8LyL42lPT5lBfs2KcvUjbK/wuE=;
	h=Date:From:To:Subject:From;
	b=N+a4KuIx2t2euweDgaiAMdfdUorO2A8WHrBYyCfOCsDZCEYxd0EAC2G37Kp7T4nts
	 cGv/cOjJSi7RZqX6J6mrg9S8bEm9I5+l6QN4fS6xxJm2ox5hNxC30WQReKEkevKaxS
	 Kn+EQJ13mXVTzYR8WLaLbgae6iWERQBvhPUDBukGda/9ZBMr9ORv8EYxiRLYWL9yQ6
	 OqeQN8qIr4qu36YR41NfdZqGm0T7zIHFAWB+8ymaiJ3klt0ibVvMDay/W1T8T7UMlW
	 iYHqyOskbVU4R4CQQfZNfWLOstt71IRAgqMZs66Q1a9XG3BFzi9Djj7DEkuJ7ExnWv
	 CzR4ibg9kknrQ==
Date: Wed, 3 Dec 2025 09:50:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org
Subject: [TEST] vxlan brige test flakiness
Message-ID: <20251203095055.3718f079@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

We're seeing a few more flakes on vxlan-bridge-1q-mc-ul-sh and
vxlan-bridge-1q-mc-ul-sh in the new setup than we used to (tho
the former was always relatively flaky).

# 141.78 [+13.13] TEST: VXLAN MC flood IPv6 mcroute changelink                        [FAIL]
# 141.78 [+0.00] Expected 10 packets on H2, got 11
# 141.83 [+0.04] smcroutectl: mroute: deleting route from lo10 (192.0.2.33/32,233.252.0.1/32)

https://netdev.bots.linux.dev/contest.html?pass=0&executor=vmksft-forwarding&test=vxlan-bridge-1q-mc-ul-sh&pw-n=0

Perhaps we should make the filter more specific to the test traffic?

LMK if you need access to the system.

