Return-Path: <netdev+bounces-218518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC24B3CF49
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 22:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE052040C3
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 20:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD532DF6F8;
	Sat, 30 Aug 2025 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="EUH1BIOE"
X-Original-To: netdev@vger.kernel.org
Received: from cmsr-t-4.hinet.net (cmsr-t-4.hinet.net [203.69.209.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013A13D51E
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586636; cv=none; b=DzoY+hPwtr4Bm3Hj5Dse3AKAhmCzl61fLRHSjpnf3sZqj4XvXr7cz4vtJamo9SMYIyFNn8enpC/AuQwUlcCPGH3ZNbUKMOlV566TXRlm+frZN704sxhvs5fckP8OxlFmoi6PUuQSYG20jodGS0cD7XHh0tQ8uU6LLS6hyYxydGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586636; c=relaxed/simple;
	bh=oyMCGO1a6aNiZMUQ7sl2/U2TykMRg4cT5rWCugmHr+M=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=RJL4P16By88X8ff5QYJtPrv3kXfmNzM19T6x/ONdV+Su9cb0gt3Sz3ljlqdDsOMS3mutVKXs2N2XBLht1TCmYJ1HiNdR8xD7WbooejG5LFX83wTH6TyvrnWZiv/IkDougGH0vSc8qWBnnkHMM7+WnpMhgO4AA0i5zLQQQ428Cgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=EUH1BIOE; arc=none smtp.client-ip=203.69.209.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr8.hinet.net ([10.199.216.87])
	by cmsr-t-4.hinet.net (8.15.2/8.15.2) with ESMTPS id 57UK9hlQ397758
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 04:09:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1756584584; bh=oyMCGO1a6aNiZMUQ7sl2/U2TykMRg4cT5rWCugmHr+M=;
	h=From:To:Subject:Date;
	b=EUH1BIOEt0eutCpkNgC6RdHzuns5Wg6gBPZeKPvoSbrFkvRlVfH/QzdD9qtuEt0Pm
	 rNqoLyRQgqgJL1K1HbV/dIowvlfk3GiZuIq/r5wjK9Yr7jgQHA8md+SM3QYGC7UHbr
	 Znc0D2vWJtZxvu+iVKCN5dRAm728C98Qzx45We3V2vNxneJ5HIJUavqAFtAmouNInr
	 midjqVga5PgUZ4eH3iFCA3Ue11+HxlPSTEh5f3+Dm8ynNXmyHekX3TmLdoqMA4+M0F
	 zVIeH8OiHU/zZQglVN871Y487yqJX0zZq1AeauHBjqFUeYO5IIqjVMjMFERCLx0jhq
	 Flx7PHvWOd10w==
Received: from [127.0.0.1] (61-230-192-37.dynamic-ip.hinet.net [61.230.192.37])
	by cmsr8.hinet.net (8.15.2/8.15.2) with ESMTPS id 57UK9Elm863196
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 04:09:42 +0800
From: "Info - Albinayah 703" <Netdev@ms29.hinet.net>
To: netdev@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gOTA5MTkgU2F0dXJkYXksIEF1Z3VzdCAzMCwgMjAyNSBhdCAxMDowOTo0MSBQTQ==?=
Message-ID: <bbfe3d38-6ce8-5ffa-767a-5f93acb2305a@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Sat, 30 Aug 2025 20:09:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=ZJd0mm7b c=1 sm=1 tr=0 ts=68b35a87
	a=v5BfitmIEQD35Mg+6JuSWA==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=OrFXhexWvejrBOeqCD4A:9 a=QEXdDO2ut3YA:10

Hi Netdev,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

Albinayah Trading

