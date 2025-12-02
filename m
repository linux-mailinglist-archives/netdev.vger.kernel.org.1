Return-Path: <netdev+bounces-243216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC6C9BBAF
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 15:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A95704E359A
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 14:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11266322551;
	Tue,  2 Dec 2025 14:12:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727E3161BD
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684742; cv=none; b=Fd6RRvvFdom0ZXMVGmj7+htz9+b9RjyWu+K+e5t0dpsuUIj5jNKJ1zoe54BMqUFXYF8+0S8pT/qHVUXHD3l4OZOGEOo0CJ5BfXgpLoXImqptZVQnicUKNcGPS6UVswj6ssweWhTBzW1piAbOvziawC0KrA5KwE3iOucpRGCi9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684742; c=relaxed/simple;
	bh=hRzPnOrMcLnNnsxanMjXmv1O9nDrf3gR3TrYVvkdI8Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LzPnMIcXdy7jOpdBBZ2eJI7oarFhRzdkBT6pWdEacDhXM4gc5zMeRmgjAOxg1HPGRPLd4HVn+PN3eVrnSMUjDOBzIJ+PsIiR+us6HVKGDfE5PIfiRTSbJvtKy4bCwCdpTmrklhyq6Q0d4LrTDLr9iVlf5E6AWeNkFcUKG7T64qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dLN4p1Jb1zJ46bW;
	Tue,  2 Dec 2025 22:12:10 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 322A740565;
	Tue,  2 Dec 2025 22:12:15 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Dec 2025 17:12:14 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>
CC: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH net 0/2] ipvlan: make addrs_lock be per port
Date: Tue, 2 Dec 2025 17:11:47 +0300
Message-ID: <20251202141149.4144248-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)

It seems that initial code of the ipvlan was written in the assumption
that all addr-change occurs under rtnl-lock. But it's not true
for the IPv6 case.

Make addrs_lock be per port and fix possible races.

Note: the race is very rare and unlikely to occur in real environment.

Dmitry Skorodumov (2):
  ipvlan: Make the addrs_lock be per port
  ipvlan: Take addr_lock in ipvlan_open()

 drivers/net/ipvlan/ipvlan.h      |  2 +-
 drivers/net/ipvlan/ipvlan_main.c | 34 +++++++++++++++++---------------
 2 files changed, 19 insertions(+), 17 deletions(-)

CC: Paolo Abeni <pabeni@redhat.com>
-- 
2.25.1


