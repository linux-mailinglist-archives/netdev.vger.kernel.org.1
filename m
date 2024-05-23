Return-Path: <netdev+bounces-97832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BD58CD6DB
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7741C2151C
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF34B64C;
	Thu, 23 May 2024 15:17:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5413AD55
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477463; cv=none; b=JkwqjqpU4uZIx2TVvY3wDayHtLHegaI7ThOdLh71VcO6L5otybhaCD1XwSlUZyppS/9sJpAaX1n1yCrsFSr8wdmeLLbtW0TydGzf4DThT1PLAhjkpXIXF0kTNe0SMyU2FUw3WRUlioas/y9bewldzx+82OAdJftrACFpea1Mz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477463; c=relaxed/simple;
	bh=Kbms4sNm/PXZkDyU8jiumH28Gf4voGihRk+H/zXU8A8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqDnGGIZyPlN/g0n747KcESwJjAud3nyr0fuPxPc3mhqLOoHS8msPfPH87uBUzqAYFKi86M3vB7cP4fyBQhKRaarbQx6jMzXZcRIQHUfJwRErUt+o9uPzjD4OsBx6LuRLzP4JW4aENsIVUXEPt03xs0nZCaU9O0I3/bF7hBss6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from coffee.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	by smtp.chopps.org (Postfix) with ESMTP id 4C2647D128
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 15:17:35 +0000 (UTC)
Received: by coffee.chopps.org (Postfix, from userid 1004)
	id 3675D180EAD; Thu, 23 May 2024 11:17:33 -0400 (EDT)
X-Spam-Level: 
Received: from labnh.int.chopps.org (labnh.int.chopps.org [192.168.2.80])
	by coffee.chopps.org (Postfix) with ESMTP id 27FDD180EA9;
	Thu, 23 May 2024 11:17:32 -0400 (EDT)
Received: by labnh.int.chopps.org (Postfix, from userid 1000)
	id 1A11FC035DA30; Thu, 23 May 2024 11:17:32 -0400 (EDT)
From: Christian Hopps <chopps@labn.net>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	devel@linux-ipsec.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH iproute-next v1 0/2] Add support for xfrm state direction attribute
Date: Thu, 23 May 2024 11:17:05 -0400
Message-ID: <20240523151707.972161-1-chopps@labn.net>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary of Changes:

  This patchset adds support for setting the new xfrm state direction
  attribute.

  The change also takes into account the existing "offload" direction
  atttribute. If the user is already setting the direction when
  enabling offload then that direciton value is used, and the general
  "dir in|out" need not additionally be specified.

  This work was started based on an earlier patch from
  "Antony Antony" <antony.antony@secunet.com>

Patchset Changes:

  4 files changed, 57 insertions(+), 16 deletions(-)
  include/uapi/linux/xfrm.h |  6 ++++++
  ip/ipxfrm.c               | 12 ++++++++++++
  ip/xfrm_state.c           | 49 +++++++++++++++++++++++++++++++----------------
  man/man8/ip-xfrm.8        |  6 ++++++

