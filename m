Return-Path: <netdev+bounces-100057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 177948D7BBF
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87E4282765
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 06:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FD93D0D1;
	Mon,  3 Jun 2024 06:39:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5039FE5;
	Mon,  3 Jun 2024 06:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396776; cv=none; b=mZ3zalrvab12V/uqymOuuXSsgD0EIVxdwglVZDxXBQwsAYh1ueE05DSt8dLG/k9xUA06o+ty4o12AwC6wkZmbK9iT+BOPzzENu4cugy5Qqh01q/djG9wg1BWmGo3F2gbKIGJzQZRR2DTkMiZrN4lNV6b40e42U1PSd0xbtlGtrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396776; c=relaxed/simple;
	bh=ZpTAvN6hUerwIfZ9CtWKHnQuSfPH3c/DikGOy5+AIjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oh4ByXzz9fVkm+fMF8y1/8T4k3Ps3nOmTSvFVESvVIT5dzmAVQujj5uhOExJyOoaVsELLU9n/xIAXCOK56FUUCLHuNyNm2hXB6adfG3JefVrgy9xo2uPI/B5ssk8KR53PrKDVK47QtuKUZZJ1m/nqEpYMJSPvCKF5JTSkp1fRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4536d2vO52498792, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4536d2vO52498792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Jun 2024 14:39:02 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 14:39:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 3 Jun 2024 14:39:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 3 Jun 2024 14:39:02 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Douglas Anderson <dianders@chromium.org>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: "danielgeorgem@google.com" <danielgeorgem@google.com>,
        Andrew Lunn
	<andrew@lunn.ch>, Grant Grundler <grundler@chromium.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH REPOST net-next 1/2] r8152: If inaccessible at resume time, issue a reset
Thread-Topic: [PATCH REPOST net-next 1/2] r8152: If inaccessible at resume
 time, issue a reset
Thread-Index: AQHasuswBg+aoM1vbkGYnO9BBos/N7G1mwVQ
Date: Mon, 3 Jun 2024 06:39:02 +0000
Message-ID: <c885d8b6ade4442d9cacf36c55d81be5@realtek.com>
References: <66590f22.170a0220.8b5ad.1750@mx.google.com>
In-Reply-To: <66590f22.170a0220.8b5ad.1750@mx.google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Douglas Anderson <dianders@chromium.org>
> Sent: Friday, May 31, 2024 7:43 AM
[...]
> If we happened to get a USB transfer error during the transition to
> suspend then the usb_queue_reset_device() that r8152_control_msg()
> calls will get dropped on the floor. This is because
> usb_lock_device_for_reset() (which usb_queue_reset_device() uses)
> silently fails if it's called when a device is suspended or if too
> much time passes.
>=20
> Let's resolve this by resetting the device ourselves in r8152's
> resume() function.
>=20
> NOTE: due to timing, it's _possible_ that we could end up with two USB
> resets: the one queued previously and the one called from the resume()
> patch. This didn't happen in test cases I ran, though it's conceivably
> possible. We can't easily know if this happened since
> usb_queue_reset_device() can just silently drop the reset request. In
> any case, it's not expected that this is a problem since the two
> resets can't run at the same time (because of the device lock) and it
> should be OK to reset the device twice. If somehow the double-reset
> causes problems we could prevent resets from being queued up while
> suspend is running.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Hayes Wang <hayeswang@realtek.com>

Best Regards,
Hayes


