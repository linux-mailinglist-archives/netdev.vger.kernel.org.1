Return-Path: <netdev+bounces-117198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B4794D0E8
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CAAA283B5B
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43469194C82;
	Fri,  9 Aug 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="HYVT52Bd"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDD3194AF4
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209272; cv=none; b=Bs/1PvPYet1PxnmuhTakg1KIVpp8ZO3lXcxTzJoSMyB0orFM9B8kT3bfqMBL4dSp08Jx5pXOG95GS9SSCLU6eMvvzHFhXXmHyIkqZmIICo1LaTrDL5CArBYR7UAvQCzrOIWskQdEtczJ8UzeFJXpY350xpEobVS29TvG9J88yR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209272; c=relaxed/simple;
	bh=VbxkUIGb79qlP8nxSyBOWIZHgY4DRK1rIhDpDKXuWOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E8cXoQIivEbXLzJdSTMYAu1igqlZSKF59h/cNr+TWhJQLiNJhy2q849xnmyejanF0ePhju73VL468+TKSlIDzh+3L5Qa7B78b2Q+4r07legPug+awt0cKM3W1vlr+rTsvt+Og+1MkU2lFbykqkncd5GXH/1IvAybMBACMuQ/Xx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=HYVT52Bd; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 6F4A4200CCED;
	Fri,  9 Aug 2024 15:14:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 6F4A4200CCED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723209268;
	bh=+yxBhnCNtWEZs0eqE1fbQl7gkpdp6/uZYPN/W0K+jHk=;
	h=From:To:Cc:Subject:Date:From;
	b=HYVT52Bd1WLRRwgu3cJBOOF6ESJFkzq4j08RBX1qQPbF+c7TypMbk9UQcq3kRo6Ae
	 xRL4zaAgJZAQUTzEuqRGOb5/mqRPjXbXB9m2zvLOJM5vd+ZfbevAQCKHBnnEic8p+I
	 gG2Y3RAqECHGz0/W0DF0LeIrxwYOPsqfiChR/xdw11r0DBGuJzdBP6EMNYPobHo51Y
	 W+EtadSYUu59n/0iAOs5VqNMC3Tzvcz7LT8cOqYUpdEWkZU7QRUZA88fWFAYoO7MLI
	 s+zJiLs3cOJiJ0er6deAwZGhGCCYy8Fe9QKvkl0AqK+xIxdQxVMv0BqZ8xGPkP96s2
	 CzkphKBc+SWVQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next 0/3] add support for tunsrc
Date: Fri,  9 Aug 2024 15:14:16 +0200
Message-Id: <20240809131419.30732-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset provides support for the new ioam6 feature called
"tunsrc".

Justin Iurman (3):
  uapi: tunsrc support
  ip: lwtunnel: tunsrc support
  man8: ip-route: update documentation

 include/uapi/linux/ioam6_iptunnel.h |  7 +++++
 ip/iproute_lwtunnel.c               | 40 ++++++++++++++++++++++++-----
 man/man8/ip-route.8.in              |  8 ++++++
 3 files changed, 49 insertions(+), 6 deletions(-)

-- 
2.34.1


