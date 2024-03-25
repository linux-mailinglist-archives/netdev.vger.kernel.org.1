Return-Path: <netdev+bounces-81670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C2B88AB2D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40861FA175B
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A08152179;
	Mon, 25 Mar 2024 15:56:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A39142901
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382217; cv=none; b=U3LoR/llnaXSZkibsNhF3FyJEnPL0jEYT05fZiXpFk7ZAdc58x7qJ8WJ4lZ+ww41m/szhLVfBOhSEHTlzuUvbsGUhNVMO9MfFqjMQBJMDIO6bCXXAiL42KjchhJVYTa/VYsuOpjfPTxY3UFrAWgLPZJl5Ln800uvp+7cYkmFmX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382217; c=relaxed/simple;
	bh=lWH1Mo9esla8kq4NWFe1towTVleSv3HEmtguE8xjAAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b00Uqd/zSb0qGiY84shgZtSw/jjunSvkH0ZTMqxVWNjq5pPRBHFnHv0wxRtvC+YQi++QuBMQNrtQ4002VXzZCQbBfz3kGW6jQtvmdWfOr95ZwG5ubcKJwZjpAMtg2oCZgy4uMBMtJMvDDw3niyQnDMTagXskgWtd4tb73zpLl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E1562000E;
	Mon, 25 Mar 2024 15:56:51 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 0/4] tls: recvmsg fixes
Date: Mon, 25 Mar 2024 16:56:44 +0100
Message-ID: <cover.1711120964.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net

The first two fixes are again related to async decrypt. The last one
is unrelated but I stumbled upon it while reading the code.

Sabrina Dubroca (4):
  tls: recv: process_rx_list shouldn't use an offset with kvec
  tls: adjust recv return with async crypto and failed copy to userspace
  selftests: tls: add test with a partially invalid iov
  tls: get psock ref after taking rxlock to avoid leak

 net/tls/tls_sw.c                  |  7 +++++--
 tools/testing/selftests/net/tls.c | 34 +++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

-- 
2.43.0


