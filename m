Return-Path: <netdev+bounces-150956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790BF9EC299
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85441629FB
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52F1FC104;
	Wed, 11 Dec 2024 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGBFh4Q8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BCC1422A8;
	Wed, 11 Dec 2024 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885815; cv=none; b=NrRtBn1fs4xdG9q4hXoHdJbhs7cAhzikheZiDTnykA95jiHXC8/7iRm2XVMHID4x5TTIYJcvttyvdnDUPEKem5vrQ+gUfNHXX8GkQ64qy9Bai+00kqV8Y8z2Xwd8F0HYXCyGDG8fpLeAolhUzUv+h5dS625UyQjGbRnr4TqXlKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885815; c=relaxed/simple;
	bh=o3JmklEEpYi+85RJMrYvYgONB8Y6N2ylZ+A8lqo4PsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agul6hzNicp6Vnz8akK49BmNbqmzhbBMbCl4g402xlmp08coi/WFTdh4+g/kxpazfWp4wMRxjD+0UUJd3f9AmdpcnZyKfMT4qUGK1Oe3WG9HaUrzeP9UY9wFTfXtV/zqNb1NoAgsa3Bbf9FrsBhKWvcYhODCy8xeil9mVpta5Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGBFh4Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8018C4CED6;
	Wed, 11 Dec 2024 02:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733885815;
	bh=o3JmklEEpYi+85RJMrYvYgONB8Y6N2ylZ+A8lqo4PsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eGBFh4Q8wx8y/7XVjXop2OVsRrur2njZy+CW38EP6he2u0i1E8Bw9+Xerwr9XWwt5
	 wBQaxq6xrj4L/hF83bjfAW3tpfCUo3OK+yGwQCAOExACr+isG7/EtAHNIRfCBt8F84
	 e/AC89niUjtIv3bdxoyBnwLDwUJFON3Gu/LPG8eMu9E7phNjPRpd5ccWM1D7JoOLfr
	 mADknKE8Y9Zvsj2KeCwVD9D8Weoqmbmrwsr629/4MML+7rwSFQE7Z7X/KEQFB629Ti
	 OT/ckezmGyVaGuPcgiOqKnaJGW8kCXnO7aCCicRq1M8j5iSfYwuo7sRmM9nT5TmOBD
	 675nyOjjlLpEA==
Date: Tue, 10 Dec 2024 18:56:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Woojung Huh
 <woojung.huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, Phil Elwell
 <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 11/11] net: usb: lan78xx: Improve error
 handling in WoL operations
Message-ID: <20241210185653.3c41fcec@kernel.org>
In-Reply-To: <20241209130751.703182-12-o.rempel@pengutronix.de>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
	<20241209130751.703182-12-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 14:07:51 +0100 Oleksij Rempel wrote:
> +set_wol_done:

exit_pm_put: ?

>  	usb_autopm_put_interface(dev->intf);

