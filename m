Return-Path: <netdev+bounces-158257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FCEA113DC
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A863A04C0
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE6420F090;
	Tue, 14 Jan 2025 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bonusplay.pl header.i=@bonusplay.pl header.b="RQv6yCk6"
X-Original-To: netdev@vger.kernel.org
Received: from mail.bonusplay.pl (unknown [132.226.202.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B103212FB6
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736892569; cv=none; b=hvZYEKc3WDd98c+aTC6L5zqhD4RK9il2JdlHJDbZrQmTDIT4hsgHHkRuU6x+zrdNfPGvlpHDoadXgEDmuSgMVSr2SjJTBt+0qBGTMulYLxRiMNPADnYW0yMWlE/85KUtGoOR9mQiR9uC7v2diiO0Skf0WhRHzooIGXU04jz+Z0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736892569; c=relaxed/simple;
	bh=07l9m4MOpdkOhMzymkbAbJcpxTym7/9yTGo2BBVId0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtigfUDdg+kU3oCJ7NhNEX7UeOLYQXBjiic7KVfeCJrea+emyTXCg54EAsK8WH3kDT6GFiA6ww+V4lAVGGBuTHlyu9UILbifzB6Y/EFyHFgR+Kul/ZkmJtFYw2DTrxSDJ5tjX52MsR7AL6aThrEbDtvDJy0n25XuWw1vTAfWjrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bonusplay.pl; spf=pass smtp.mailfrom=bonusplay.pl; dkim=pass (2048-bit key) header.d=bonusplay.pl header.i=@bonusplay.pl header.b=RQv6yCk6; arc=none smtp.client-ip=132.226.202.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bonusplay.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bonusplay.pl
Authentication-Results: mail.bonusplay.pl;
	auth=pass (plain)
Message-ID: <0f41d81b-8ba3-464f-b0d0-701b3bfc3694@bonusplay.pl>
Date: Tue, 14 Jan 2025 23:09:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: be2net: oops due to RCU context switch
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org
References: <515516c7-e6e9-450a-9a74-685a60d64497@bonusplay.pl>
 <20250114110849.0eb0ff2c@kernel.org>
Content-Language: en-US
From: Bonus <kernel@bonusplay.pl>
In-Reply-To: <20250114110849.0eb0ff2c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.bonusplay.pl (Haraka) with ESMTPSA id D2231BD6-852A-4318-8CB0-EECC642467E2.1
	envelope-from <kernel@bonusplay.pl>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Tue, 14 Jan 2025 22:09:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonusplay.pl;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=s20211118323; t=1736892565;
 bh=VM65KAkYlMAfAmyzWffb78oPVj+tlsg7tj2czRcDqTE=;
 b=RQv6yCk63MD7uadDb5XVSvlVy1XLEUKqy2WT7YsvFfAzv5NCKJdhHmdxXj2L3qfnvxaG91sDb
 0NE0zlUoz3HGMjglgWr0xwC9btcnWmWQAMo48R0xsxREj+o/9cPWzpt+XifGj8uC9D1/8Ua1zOQ
 a4Gz4uJu17XoOyqSwRQKyCOTJgbfSU7MrpayalYN2xgn6TIpIUOeClrx2T4z7JRoqnCvyxZLngD
 F/mhM+oyELi4kXLkl9nV3/QNvizaynErrJ7InlQ0tpCwODydmunAaiXaTnQnQwsZ1u1wrz9dr9s
 dlOjCoSHi71qQR4wquLQaFcTonYd/js+N7V59VtcfebA==

On 1/14/25 20:08, Jakub Kicinski wrote:
> On Tue, 14 Jan 2025 11:37:36 +0100 Bonus wrote:
>> I've encountered a regression with kernel 6.12 immediately after 
>> booting. I don't encounter it on 6.6. If required i can try to bisect 
>> it, as it is very easy to reproduce.
> Hm. Bisection would be helpful. I scrolled back 2 years, I don't see
> anything very relevant. The driver sees very few changes these days.
> ndo_bridge_getlink has always been called under RCU.

I probably should have done debugging on my side, before reporting this here.
Turns out, this is somehow NVIDIA's driver fault.
Blacklisting it and booting with nouveau fixes the problem.

Kind Regards,
Bonus


