Return-Path: <netdev+bounces-214250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DAFB28A2D
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 05:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE01AC67E4
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 03:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CBA3C01;
	Sat, 16 Aug 2025 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rrn294Ht"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09B1B85FD
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314110; cv=none; b=Q27+Qi38hR0EkXETOkInI1IjVcnz8oDHXeJEWdY0LoQDFi+/9koKYBOXrftY7bO42Kc4Xq5LKNQltNhK+zj2mYvSonB35wHG7Fse5u4uawqZZVOxDBUpscY8h77K5pOyMOn5wh11yyVqrGa+BEwEaDbPoqIOeYgBvWPxxmDH5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314110; c=relaxed/simple;
	bh=CtqmI8eA+brte7Vu6IoKZ8THjh0v1CdW1Cfv5VHsrMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YRQ1NmNJzhpo6vcoq9+n8PI3trq/LzTbOX6c5M7D4ujmS/dxzuy09Zoww/VllD8Yi0VziontMwUyPxrQXPSZCfjZAQfo/PnD/Sn2E8APN92AOe7SVkzIMUZ5Ob5s+HpZow3UmUKpZfeAotBH+CH+X6Zd2AlSetjWR5Ttz+IPSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrn294Ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809D4C4CEEB;
	Sat, 16 Aug 2025 03:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314109;
	bh=CtqmI8eA+brte7Vu6IoKZ8THjh0v1CdW1Cfv5VHsrMs=;
	h=From:To:Cc:Subject:Date:From;
	b=Rrn294HtkvWPoZkdcGGlJrvTaQKmrwtCsq5YA2fo5CukNY9cQaNwh3hh3DrxSMFdp
	 P1ZHO8MH5w0+fIN1qTaT/DXDtAcGtqEdtAB5uX4R5mgJOZa1YT0Ohp23POdgFFx34c
	 /evSv4maz85Mk996QQuMWlIUzhEYDoLTVKDpuaD4c6J60w2XLVDoWeyr9RqNwHouPP
	 UOBI0TX2umq9tSRznr5tgsMzv+ois+nqQOxesXSBgQWy6i1LN9bhyhiA2mNCWCnxnn
	 ikKHu6cPwOys5xyugzyjL/59PImHN3xXp+O/upy37/1GrQoh5I5QWnBZhyEgvH72Lb
	 lAcKD4JxKZrhQ==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org,
	Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: David Lebrun <dlebrun@google.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net-next 0/3] ipv6: sr: HMAC fix and cleanups
Date: Fri, 15 Aug 2025 20:11:33 -0700
Message-ID: <20250816031136.482400-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up the IPv6 Segment Routing HMAC calculations.

Eric Biggers (3):
  ipv6: sr: Fix MAC comparison to be constant-time
  ipv6: sr: Use HMAC-SHA1 and HMAC-SHA256 library functions
  ipv6: sr: Prepare HMAC key ahead of time

 include/net/seg6_hmac.h |  20 ++--
 net/ipv6/Kconfig        |   7 +-
 net/ipv6/seg6.c         |  20 ++--
 net/ipv6/seg6_hmac.c    | 202 +++++-----------------------------------
 4 files changed, 46 insertions(+), 203 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


