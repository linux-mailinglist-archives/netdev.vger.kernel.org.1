Return-Path: <netdev+bounces-189306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF856AB190A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECCA1C45F48
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21B82248B5;
	Fri,  9 May 2025 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWMWnzFZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15517D2
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805339; cv=none; b=uDLSw8l34WGNIZkIpAAz7pJUTvaFrc5ZMmSYhSSzTDDEKVRIePfHgdW8BQaHbDoXjq0Q5o/WWX5RfAMSfDaoF6yExHHl7P7kJS2ZqbGwdvtgDthgMjLCtm2ri0/eMVs0A8LmX7rLKULpTPEYOEIORXHR6W+PlWD7KNJAXLdy21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805339; c=relaxed/simple;
	bh=0/gnZJQXc29oWFzBUywOpl79hD8csjqYWJf08fMPRuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQDmlNcaZE2/ith/piPnB77HLL1t6FXSf/NLvbslUsiLUpSUIF4v912PNijulNbaJYViEiUURxV0FnkMuVf0xoWRJtw+NPfUwzDsLTzCnkgSM7Ecc/sM8tVzjApt7jpzGsX0Ec1+kje7Lrab2nrq49DsxfxT2lKZPppO96y6z3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWMWnzFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519B8C4CEE4;
	Fri,  9 May 2025 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746805338;
	bh=0/gnZJQXc29oWFzBUywOpl79hD8csjqYWJf08fMPRuI=;
	h=From:To:Cc:Subject:Date:From;
	b=lWMWnzFZBtvPqUgoeDHGlOrM4+VVcJAZWEu5yqd28HJdsB3lXT8hAJB2UewVUQW9O
	 +L0BvTxSoJbu05SCldpN4cEUrFALv19pgia2ido1lMOCNrV4a8b9ExnIehPnu8vQHL
	 vmnU/KKPuaBL8lvrcQxoK/5JbbztvmtiPBuLKjoLSluVcuMqn81vLRidq/k4n4PMjS
	 TkVWT645YZSxwnSP+6yC3xpxrf4gOEy4OuOQbUIMoB97ByaOBGn9Ji+n5Zc9veamIt
	 E3aYPOIZWpiH2wA7uSIFk0/Zac8OgOgNZM8/CZZcHA/Fk4gVOW8+mSLwAeu5wH5Iyu
	 kWxQk3I9yIOog==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/3] tools: ynl-gen: support sub-types for binary attributes
Date: Fri,  9 May 2025 08:42:10 -0700
Message-ID: <20250509154213.1747885-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binary attributes have sub-type annotations which either indicate
that the binary object should be interpreted as a raw / C array of
a simple type (e.g. u32), or that it's a struct.

Use this information in the C codegen instead of outputting void *
for all binary attrs. It doesn't make a huge difference in the genl
families, but in classic Netlink there is a lot more structs.

v2:
 - use sub-classes
v1: https://lore.kernel.org/20250508022839.1256059-1-kuba@kernel.org

Jakub Kicinski (3):
  tools: ynl-gen: support sub-type for binary attributes
  tools: ynl-gen: auto-indent else
  tools: ynl-gen: support struct for binary attributes

 tools/net/ynl/pyynl/ynl_gen_c.py | 63 ++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 3 deletions(-)

-- 
2.49.0


