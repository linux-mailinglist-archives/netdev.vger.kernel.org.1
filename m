Return-Path: <netdev+bounces-164506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E84A2E043
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 20:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85C83A5A86
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 19:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8360B1E25F9;
	Sun,  9 Feb 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="G47BCSxD"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC78A1DEFCC
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739130294; cv=none; b=lHaVIPWYV6lb/6i75FNJIUEXPobcu1671lIMqso2rmXdodGDoiJB5TROmo5ZHkOniivqoBgUlgaoaSihq25exNtga/1IWklWV1KMK/ju0yaDfpB0Si2vX3QABXQcZG273D0EfstfFSmkK8klKS59Us1dhtVAz4Zen/Tk0AMxk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739130294; c=relaxed/simple;
	bh=PyIiM7/uyENseYVz2Z8ksgNH3rUaDgZlIiYO7Qa8Ppk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JXjpwbKAgVeyxV6rY9JVT42jf6bMkQPOuTuoSH4hsXih5ze6tOQlsmomGTsRnF+wjms9Mylu1TC2F4+wHduILNO4bxsZPHfrJ0TJfZt0VC2iUevkPs06VlNtzor07fmamZVNPcqrdsn5D8aPeFUUcmTskXvyrqxPxmE2++a7PFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=G47BCSxD; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (lfbn-ncy-1-721-166.w86-216.abo.wanadoo.fr [86.216.56.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id CEED0200E2B4;
	Sun,  9 Feb 2025 20:39:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be CEED0200E2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1739129975;
	bh=UUiO6rjh3qUf0QNOZQvupv0ylJR/cAovUks91VH4A4I=;
	h=From:To:Cc:Subject:Date:From;
	b=G47BCSxDJHptIdr5aHrh4vZF+gUCYAJBxfuaKDY8YoVgaaT78DOHitcucoi8XTEXs
	 14k4qtArAylV+ymAU+4tZZWkpiAdORXuINw/RIdf8TRc4GfeGgzNKMoEiYZ/IDyq1f
	 dEAK3FrD+ON64igcfp/9jnQmr/KbP2IIZWoe0cAXIKDF/7uLqV22TGCBvywIzcCLXp
	 Wf9dzrbRhcnVtHWuF3jGsMh87rO87xV5zXExhhVM8erPeJhSKt5TuoavgPxZZTCUU1
	 OauUe3Q1XgOXEqGjpfRUq+mWQ/hhiL6RzsHMCtWVlhJsQ/5KBe8SMSelydpziLNGmx
	 SRpiWuzqOxI2w==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net 0/3] several fixes for ioam6, rpl and seg6 lwtunnels
Date: Sun,  9 Feb 2025 20:38:37 +0100
Message-Id: <20250209193840.20509-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset provides fixes to prevent loops in ioam6_iptunnel,
rpl_iptunnel and seg6_iptunnel.

Justin Iurman (3):
  net: ipv6: fix dst ref loops on input in lwtunnels
  net: ipv6: fix lwtunnel loops in ioam6, rpl and seg6
  net: ipv6: fix consecutive input and output transformation in
    lwtunnels

 net/ipv6/ioam6_iptunnel.c |  6 ++---
 net/ipv6/rpl_iptunnel.c   | 34 +++++++++++++++++++++--
 net/ipv6/seg6_iptunnel.c  | 57 +++++++++++++++++++++++++++++++++------
 3 files changed, 83 insertions(+), 14 deletions(-)

-- 
2.34.1


