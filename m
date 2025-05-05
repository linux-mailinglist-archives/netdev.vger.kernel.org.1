Return-Path: <netdev+bounces-187781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E91BAA9A00
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E943217DEE9
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D350E26C3B0;
	Mon,  5 May 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihEL5OSR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD226C3A5
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464547; cv=none; b=SmNdcZodNiYg6C/KaZNFEiomsE2qF3BnI3L4ky7kciGCqhDWlhS28Rn5UgKlUMSK3A8YqpjzVvcdLgmaEHstM/TIwA4ximV8+XjYHgTJu7p3VFQX9Uej3Pliyuz98dEtwtfXbX06au5oBRGghiApWWEW626xdVMoqzh1O5OAwD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464547; c=relaxed/simple;
	bh=LbHVn6bIem+YRYjd0hsy7DAAdZ4e9FdPeZerMoKfP74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7tTSCmQJ1IImGkM66khcNnTo267SMKGyZIy8d+EJQsUkfmntTMNXgfFKzuOVja86HRheAqHQ5YrYtrQ70lYfNZY2hSPIfU7qjJVLTq+P1u+wAct08cWgTRn8vu7weyj966xwXHzWMBhWTXuyi//m8k87n3WzaJ35/jNOlAFM4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihEL5OSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB685C4CEE4;
	Mon,  5 May 2025 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746464547;
	bh=LbHVn6bIem+YRYjd0hsy7DAAdZ4e9FdPeZerMoKfP74=;
	h=From:To:Cc:Subject:Date:From;
	b=ihEL5OSReWkGd/l2tldIsKLD89RLk2Hs8l1YSdn5qjtgcgxedYVOdJlL7RrnVb3s2
	 d5oqhpZ+axYCP+vt67G7NT7q3b4pR7e57HHKYumej636MVqqoAQZIP4GCC028wlBlm
	 yn+k4V/Wc1enqkRenardkL7AQP8V1o2aafPPP/+NZhHCMpTzzd5jSOzIJ4ow66sMUC
	 k0CUsyfP5JpFHtEzZiYGqH9ULazE2dLh+dYjGOwRAn/djPaxdWYU/mnpIo4jGN0piZ
	 ELNEPbV9MCdlrGXiYa1jOD2/9OqKk6y+rKIbT/sQVfrgbUr0q/1308OPZbqIfXAN8c
	 Uelndu7cKeuYg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	johannes@sipsolutions.net,
	razor@blackwall.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] netlink: specs: remove phantom structs
Date: Mon,  5 May 2025 10:02:11 -0700
Message-ID: <20250505170215.253672-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt-netlink and nl80211 have a few structs which may be helpful for Python
decoding of binary attrs, but which don't actually exist in the C uAPI.
This prevents us from using struct pointers for binary types in C.

We could support this situation better in the codegen, or add these
structs to uAPI. That said Johannes suggested we remove the WiFi
structs for now, and the rt-link ones are semi-broken.
Drop the struct definitions, for now, if someone has a need to use
such structs in Python (as opposed to them being defined for completeness)
we can revist.

Jakub Kicinski (4):
  netlink: specs: nl80211: drop structs which are not uAPI
  netlink: specs: ovs: correct struct names
  netlink: specs: remove implicit structs for SNMP counters
  netlink: specs: rt-link: remove implicit structs from devconf

 Documentation/netlink/specs/nl80211.yaml      |  68 -------
 Documentation/netlink/specs/ovs_datapath.yaml |  10 +-
 Documentation/netlink/specs/ovs_vport.yaml    |   5 +-
 Documentation/netlink/specs/rt-link.yaml      | 167 +++---------------
 4 files changed, 28 insertions(+), 222 deletions(-)

-- 
2.49.0


