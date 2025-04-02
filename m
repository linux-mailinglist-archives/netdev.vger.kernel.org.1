Return-Path: <netdev+bounces-178712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE6CA785FE
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 03:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E5316C7E1
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 01:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC028837;
	Wed,  2 Apr 2025 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YffvZmg2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6022F5A
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555783; cv=none; b=FWzRHxMdUGBijQJKxRwbptOzlMayEtU/eC0sQKfLkSLarHT5DoAllTK7t50Ew11U0sUX9bnADHBN1NqqBmwREZfxGIFuTRED91zWx0qeERjHfXOgH98Dw2NUxyoncxaSzgcFcsbHyayGXgosRz3MjhJdn9Mw3fZ5lLaIpdaxUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555783; c=relaxed/simple;
	bh=RbJFfKp8ZcX5mxV4juME+dgaIUhhP6NHttjTZQWbVfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNADGpwS8wDqEOX1Cwt3ThgNx87AKgRATz38aTJ8yhs3m9+Pb0zGiU9cVFyVv1BsYb392XXor67t+042k84devPJBZJvVSwYMq13v5MRb6RiJ8DZMGjsqlWHcXeLmPLcqCaNO/uDr0IC1yYWau3O9HJIe7W/vwlgkqnB9cvkrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YffvZmg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E563C4CEE4;
	Wed,  2 Apr 2025 01:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743555783;
	bh=RbJFfKp8ZcX5mxV4juME+dgaIUhhP6NHttjTZQWbVfE=;
	h=From:To:Cc:Subject:Date:From;
	b=YffvZmg2qHlA/dDtfg9Juj1z0MJzHyN29WHH7j6Ts1OwIe4a7dM/5Cf/FTchCojk8
	 EyNBFHikj9kDWdjHgzic+65eskgMaNPoDn3IOfWYztbfRxj1zHx+gbpIA08pclik+8
	 7MlXv0YhE+pa3zK+m9IKKDdgjHSr4TgmW9nfR+giEmi98kth9gjB3MMUUHT76Qbd/7
	 COvs3WkTHmVPnwf9qzhJx0mYHUIEJW5TKBndHqsDdImtJiSXXdnQtt4aXwI1G6cUUX
	 AfVD+a1PwdGrDgyOCTyMEkpyGyFczRPaSM02vnzXwL9E9xEyWVOAl4NeMre0rKLQjp
	 3mBZCREu6zIWw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	yuyanghuang@google.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 0/3] netlink: specs: rt_addr: fix problems revealed by C codegen
Date: Tue,  1 Apr 2025 18:02:57 -0700
Message-ID: <20250402010300.2399363-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I put together basic YNL C support for classic netlink. This revealed
a few problems in the rt_addr spec.

v2:
 - fix the Fixes tag on patch 1
 - add 2 more patches
v1: https://lore.kernel.org/20250401012939.2116915-1-kuba@kernel.org

Jakub Kicinski (3):
  netlink: specs: rt_addr: fix the spec format / schema failures
  netlink: specs: rt_addr: fix get multi command name
  netlink: specs: rt_addr: pull the ifa- prefix out of the names

 Documentation/netlink/specs/rt_addr.yaml | 44 +++++++++++++-----------
 tools/testing/selftests/net/rtnetlink.py |  2 +-
 2 files changed, 24 insertions(+), 22 deletions(-)

-- 
2.49.0


