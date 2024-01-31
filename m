Return-Path: <netdev+bounces-67443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 931A68437EA
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 08:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3444C1F27004
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2711D5027C;
	Wed, 31 Jan 2024 07:31:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036A057326
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686297; cv=none; b=deDosJsDVSuqdVDCZ4fKVc8icDCeBGuR6dQCl90bEa5vFyrFGQyDHuTuy5L+QQ8uV7OCbbp4MAh6AuFM/QwKj1Dz3UVyjoylfu//ZOuSW8fJzRpeWwiqYmuNvd+itiS14nq0CdfNwaEFfoymdPUOZSWvlHxr0MBfbjB9is/BY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686297; c=relaxed/simple;
	bh=7wT3OQOd5erRl/NCw7clOz7k0MbcO5RwW8IDWyqCu+Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=W7xebeyAWsGAZShbuQ30EAwiWNmrI7g3JLujpzPLfri5Y6CyG4WQtPc+BDkc5nv2EBAF0Q8KOfm4NjhhpbBURKAq0aAa9UmIMoJqf2acmV2on130Q3wroHlN973hnEGdibucM3ToZQbXeBZpY9CrV0JeJNMmVzbGbjWyfcdC5Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40V7VTy94702092, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40V7VTy94702092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 15:31:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Wed, 31 Jan 2024 15:31:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 15:31:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 31 Jan 2024 15:31:30 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Report on abnormal behavior of "page_pool" API
Thread-Topic: Report on abnormal behavior of "page_pool" API
Thread-Index: AdpUF0sHyRotE8/qT3KY+LT6QKnbOg==
Date: Wed, 31 Jan 2024 07:31:30 +0000
Message-ID: <305a3c3dfc854be6bbd058e2d54c855c@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

To whom it may concern,

I hope this email finds you well. I am writing to report a behavior
which seems to be abnormal.

When I remove the module, I call page_pool_destroy() to release the
page_pool, but this message appears, page_pool_release_retry() stalled=20
pool shutdown 1024 inflight 120 sec. Then I tried to return the page to
page_pool before calling page_pool_destroy(), so I called
page_pool_put_full_page() first, but after doing so, this message was
printed, page_pool_empty_ring() page_pool refcnt 0 violation, and the
computer crashed.

I would like to ask what could be causing this and how I should fix it.

The information on my working environment is: Ubuntu23.10,
linux kernel 6.4, 6.5, 6.6

Thank you for your time and efforts, I am looking forward to your reply.

Best regards,
Justin

