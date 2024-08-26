Return-Path: <netdev+bounces-121909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AB695F34D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9252825DC
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE5A1865E4;
	Mon, 26 Aug 2024 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="DCb8R/kv"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C4A1E864
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680372; cv=none; b=jC0L7V7lXjJfVq0LFXD04hyQzmZCVXnv7WSfwTKNLhRunfufamzTQq0/yGNca3gXQ9+ILPYnJa+xb4Y+a7iNXOKeJfiUse8QAETURGGgSp/ecgH7iPL2Xwz91JIh4wBgtREhxAgQdDGmK/OOPOi3Mtar2RXbWNYJOAofzJNLQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680372; c=relaxed/simple;
	bh=IZ95XG+zZMKFWCcfVrZ3b5DYT+2gFaYSrTBCz3czPsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q0iLKfWYMEXDdGIXRPfTYrbs63zXyjcLyevD16z45zeJNZew9SGNKtJa4UKwK+GK6mJvozPu1N7GIi2H5p8pEnlUGABDUDocsv2jxIjuitpAevVsQoUJZMcogx3wG5aLhlby+NRSv1NAFloFioVrbz/8maLjP7zIi3tD/WD3BxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=DCb8R/kv; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 52BF1200BE6A;
	Mon, 26 Aug 2024 15:52:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 52BF1200BE6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1724680363;
	bh=5RdkIrqWN/YEcIJHLo/+J600NAdE9OnXZp8pxtILEgs=;
	h=From:To:Cc:Subject:Date:From;
	b=DCb8R/kvj6cBd/5owazkc5GfabHA1ZambadPLAdIiLe8vxs0ciH7syg8abT71+10g
	 O/ssihrzr5p5Lk60gIRIXJs2X7S4qK9J9DU4mUvqILmTY651LS2zh7H++FKN2uzh3M
	 1QfLIBvkvkvOfc/+vs51gAen5Lo9+Lbm1Ifwp1P3oemkRwqkZGbyg/KHFz8LW5giqN
	 lDvWt1YObklJG9dGN8fybetmpd3sK1I7hKIYWM24jQOCrrU9lEjXnO9NhkCVItJZMv
	 jpILxfTOFEEF6Xda5ke5oqolxujSL8IVYYAiMBWAohPRmcGzj0R/JhVSkJos013BLT
	 B9U6eYIwiM/hA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next v2 0/2] add support for tunsrc
Date: Mon, 26 Aug 2024 15:52:27 +0200
Message-Id: <20240826135229.13220-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- removed uapi patch (@David please pull from net-next, thanks)

This patchset provides support for the new ioam6 feature called
"tunsrc".

Justin Iurman (2):
  ip: lwtunnel: tunsrc support
  man8: ip-route: update documentation

 ip/iproute_lwtunnel.c  | 40 ++++++++++++++++++++++++++++++++++------
 man/man8/ip-route.8.in |  8 ++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.34.1


