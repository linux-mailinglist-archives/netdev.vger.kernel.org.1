Return-Path: <netdev+bounces-91403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C4C8B2733
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FD60B21A31
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49A814D6EE;
	Thu, 25 Apr 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sidaq.id header.i=@sidaq.id header.b="ApPd6kWp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="OXo15VLO"
X-Original-To: netdev@vger.kernel.org
Received: from a27-250.smtp-out.us-west-2.amazonses.com (a27-250.smtp-out.us-west-2.amazonses.com [54.240.27.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78F12B9D9
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.27.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064940; cv=none; b=io23qYXNizmaFJJezzfgGYLYk0DEu4bUHCjc2J44gvMOI1bQ4cQoJd9MdUwXg5EdC4ITp7LlBx1R6KmKs5m1mhXN7LI0akvYSGroaoF1Wi7Ey12Fk1VnYMSWkkbethgj1lio0FnJEDTZcD5nJ8wgs9ElDHUvIIyNX/NjKiMMjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064940; c=relaxed/simple;
	bh=hTjJTFBtyn7IsNny2GC0e4jhalc2bfCGI8u8nyXhIcI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ac7LI2qktK9Qn5LAzMXp3+Lvap22X2GYv/SHf3hSQ1qFSDTTEAuxSKFSvdXYwYFUAEcyzqPfbeAnyI+LTtMHN/GCOFhWi/LjOqtLMy6E6BXfs1l8waAkReusrSiMTvwfBiwRWeFpf7TUXJwMl0ojnYztKeVXIbUXZP8VJVydSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sidaq.id; spf=pass smtp.mailfrom=email.sidaq.id; dkim=pass (2048-bit key) header.d=sidaq.id header.i=@sidaq.id header.b=ApPd6kWp; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=OXo15VLO; arc=none smtp.client-ip=54.240.27.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sidaq.id
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.sidaq.id
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=fm464lzmn5c36cqjghih4ejpjob272ef; d=sidaq.id; t=1714064936;
	h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:List-Unsubscribe:Content-Type:Content-Transfer-Encoding;
	bh=hTjJTFBtyn7IsNny2GC0e4jhalc2bfCGI8u8nyXhIcI=;
	b=ApPd6kWpF/F0st/AovhqMhQWLa11asNUykh3/xanyO5CqUdVajT4MrKHytz7BlkV
	CmU1mRrVnhFlL1GIgc12Ru5AxPvvtvrZzrMXQl/5obzBf4vbJa0vTPba2FK9Vzn4Swv
	a111MpSQYWWdKwfCmZ+D9grSMxH8Tn8Yi/73COzEkaHab23dvflj0EP3UatyV+5AYgZ
	O0Wv4uWac5RAO12WWcW2iTNnCfoxQHQYlZHOabc0i2GTpMb0mztu3kaG45KcgcXtRlr
	GSq//hT/rFTUuBbERU8N7n0uFeSsQVoNnDMvXmu49nsW1EjTNPJSUW6KNFzEgORCw0W
	omfD8/oEkw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=7v7vs6w47njt4pimodk5mmttbegzsi6n; d=amazonses.com; t=1714064936;
	h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:List-Unsubscribe:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=hTjJTFBtyn7IsNny2GC0e4jhalc2bfCGI8u8nyXhIcI=;
	b=OXo15VLOdHWMn3wlGWfJ3uraLjytxfNPKjLZZI1N8b/fYw1oBtpKXamc3yVTS4TQ
	Kl2vDteRhP0haTmYYP4ZTop8Q+urotuTip/5QZXlX8A+XUg/hJW5L2Ew0IeHd5OJ5yQ
	mJ8LnYz4iT/fa1Q0aEJt203195xQ5xeyOiOr1jeQ=
Reply-To: Name Name <davidchanel@lycos.com>
From: David Chanel <dchanel@sidaq.id>
To: netdev@vger.kernel.org
Subject: 2023 Extension Tx Return
Date: Thu, 25 Apr 2024 17:08:56 +0000
Message-ID: <0101018f163b4c66-88edd3b2-2877-49ee-9e9b-b1136a4458e0-000000@us-west-2.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Feedback-ID: 1.us-west-2.nAxLNmqAh9SqIExJZA2BZaCwSiNMoigKLazTamLflEg=:AmazonSES
X-SES-Outgoing: 2024.04.25-54.240.27.250

Hi,

 I checked online for a new Certified public Accountant and found=20
your information, I need your service for my 2023 taxes. My tax=20
return situation is very simple. it is just a basic 1040 with=20
interest and dividend income and some deductions and credit.


I already filled my extension in anticipation to the end of tax=20
season. incase you are busy right now, I can wait till end of May=20
to come in.

I can send you my previous tax return and current tax documents=20
so you can review it and give me a quote.


Kind regards,
David.

