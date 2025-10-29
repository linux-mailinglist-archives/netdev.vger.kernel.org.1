Return-Path: <netdev+bounces-234111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E88C1C8DD
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FFE134BFB2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31542F25E0;
	Wed, 29 Oct 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHdQBQxG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4122652D
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759970; cv=none; b=B+WdwoAOUqAa7uCHViEYR4Q9Y2el/uyP2LPZdzOqnAhceFIoevmViNmsF5IRIEAQj3MJHDjT9M58URw3wKazZa7xptBPhboNGmUInrLASJt+Icuk3a/Fj4+uIxqiZhkuLMgBkdiHT6P0ucQKNUWXDrhr1JFE5ohfX9IHLU+NKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759970; c=relaxed/simple;
	bh=HmmGYhM5wEFgtrVaXjxp+kjvktfBMuB0AXjpjmQyndk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RmlWFiYhsMNT82EKlQ1D451mvJvA+RFn1YAZ7IHKNAUoj4mSc/ubctq/f41g6cvDNZ7a9NneUuPxsM+mq8wuIV8PnHGAGg/Qp8z1EOvWQrV2OGeT5BeejA/iHtzur5iCsp3sQ0gB7f0K6YcVzenUaJoU8jiuHBHvWmVfLqkC9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHdQBQxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EADAC4CEF7;
	Wed, 29 Oct 2025 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759970;
	bh=HmmGYhM5wEFgtrVaXjxp+kjvktfBMuB0AXjpjmQyndk=;
	h=From:To:Cc:Subject:Date:From;
	b=EHdQBQxGrigT0cw/abOb5INfu25d5i0Kqz92X3A8EkxRWnHQM8Qpaq5u80MLeKi7W
	 E2wq5Q+yeRAIW2J7CDio7MGrSYZByPakLCeWOfjtFd9HXXPzvPN0Jj1bUGMvDZ3tmG
	 SVIl5a5J6MOYJeZ9tC2Ji6l9ykNJt50eK7x0nDJ0yYJbXi2Lm03N4cvVeM6EhvSnlo
	 o125+/nRNvrDgvSCch9Qu2W8ymtcpciIoVUV/8JCGMVV0KcYRcI4Q70cipcjRmK+Ab
	 C7p/FyT+0usW6DV3B24SsUOu0tHIZUS9ZkHiMKYCreWg7qqrglpZlX8GcZ3TxtXi62
	 R4sDMdorsZg2g==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: allison.henderson@oracle.com
Subject: [PATCH net-next v1 0/2] net/rds: RDS-TCP bug fix collection, subset 1: Work queue scalability
Date: Wed, 29 Oct 2025 10:46:07 -0700
Message-ID: <20251029174609.33778-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allison Henderson <allison.henderson@oracle.com>

Hi all,

This is subset 1 of the RDS-TCP bug fix collection series I posted last
week.  The greater series aims to correct multiple rds-tcp bugs that
can cause dropped or out of sequence messages.  The set was starting to
get a bit large, so I've broken it down into smaller sets to make
reviews more manageable.

In this subset, we focus on work queue scalability.  Messages queues
are refactored to operate in parallel across multiple connections,
which improves response times and avoids timeouts.

The entire set can be viewed in the rfc here:
https://lore.kernel.org/netdev/20251022191715.157755-1-achender@kernel.org/

Questions, comments, flames appreciated!
Thanks!
Allison

Change Log:
rfc->v1
 - Fixed lkp warnings and white space cleanup
 - Split out the workqueue changes as a subset

Allison Henderson (2):
  net/rds: Add per cp work queue
  net/rds: Give each connection its own workqueue

 net/rds/connection.c | 15 +++++++++++++--
 net/rds/ib_recv.c    |  2 +-
 net/rds/ib_send.c    |  2 +-
 net/rds/rds.h        |  1 +
 net/rds/send.c       |  8 ++++----
 net/rds/tcp_recv.c   |  2 +-
 net/rds/tcp_send.c   |  2 +-
 net/rds/threads.c    | 16 ++++++++--------
 8 files changed, 30 insertions(+), 18 deletions(-)

-- 
2.43.0


