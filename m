Return-Path: <netdev+bounces-193427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06505AC3F0A
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E2DA7A999F
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 12:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED211FC7D2;
	Mon, 26 May 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="tYuJu3mM"
X-Original-To: netdev@vger.kernel.org
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F31BC5C
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748261211; cv=none; b=OFoY8v3x8MkU9VkqBLrgQWFv0gPGgGUSRP4vaN6Qk9WrDYwYXsdYBPLRmwU5FFeO5JFvx7affVGc0MN8NB2eKakGfz+JNZMdE1Llgb1ALfT23PU8Hyup9NFRescGxKo2owicjQaZLkuOsqbbZsgINHOSBaR3TSnppHRNqS6HfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748261211; c=relaxed/simple;
	bh=6bWKJrIXFBGvUcEonAwIKw4DUV+u/7zsHiHN8v+N9d4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sGsl1S5cEPpV7j5MOTgI4MCdv//DCz55/+1wODFNhvfCxlBILqBL/j9xiOvLaZm0kLbdcOj/MUxwgbJUEh2B78Qb8WMCMyUJ2JyLj/p5Mzo7iI47vLrxwD2VZP5vg5rVVDx+kgG6/1SOu+NP18qRo9aj72B4D9CudH7AICViSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=tYuJu3mM; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:842f:0:640:b96f:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id 4C91D60F87;
	Mon, 26 May 2025 15:00:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id J0SLMxJLgKo0-6MkaC1A3;
	Mon, 26 May 2025 15:00:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1748260820; bh=6bWKJrIXFBGvUcEonAwIKw4DUV+u/7zsHiHN8v+N9d4=;
	h=In-Reply-To:Date:References:To:From:Subject:Message-ID;
	b=tYuJu3mM7LHkJf5OpzdM4klwh7MU9+9pz/wM9FnDj99MDijK11aSieVPzDFL6arC7
	 6tB+K5D+Jk6GX3Esrf2FtSynUdDRGbR/KJpS9MAF6U/NRTAbU59EB+pd95xJBTmdTE
	 m139J3REl043AHr8ODVl6mG8OuhvBXeQJ7VSixVg=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2a85cc0b3932c7e7e891a8d4558b0372924bc625.camel@yandex.ru>
Subject: Re: Does "TCP Fast Open": not work on 6.14.7?
From: Konstantin Kharlamov <Hi-Angel@yandex.ru>
To: Jeremy Harris <jgh@wizmail.org>, netdev@vger.kernel.org
Date: Mon, 26 May 2025 15:00:19 +0300
In-Reply-To: <55787952-ea5b-4b1f-b285-4036e2897161@wizmail.org>
References: <985e79fa5c4ea841cb361458cdcf0114050bfb62.camel@yandex.ru>
	 <55787952-ea5b-4b1f-b285-4036e2897161@wizmail.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-26 at 12:40 +0100, Jeremy Harris wrote:
> On 2025/05/26 10:02 AM, Konstantin Kharlamov wrote:
> > 3. Connect to it with `nc -v localhost 8080`
>=20
> The application needs to specifically request TFO.

Aaaah, I see=E2=80=A6 Thank you, I thought it is a transparent feature.

So that's interesting, apparently as of today, decade later after the
feature was introduced, it's almost unused. I'm writing this from a
laptop with 1 day and 5 hours uptime, where I've actively used
Qutebrowser, Firefox and once Chromium for browsing (and with
tcp_fastopen =3D 1 OOTB), but all values are 0=E2=80=A6 Anyway, I guess tha=
t's
offtopic, thank you for clarification!

