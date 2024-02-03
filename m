Return-Path: <netdev+bounces-68740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCAE847DFA
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 01:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53102B28F6D
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 00:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C12643;
	Sat,  3 Feb 2024 00:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH3OvAPr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351FE626;
	Sat,  3 Feb 2024 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921227; cv=none; b=Bqo8UnZik49fjVGRWHPnFyx1ezDbTE4RCD7UiZrN8cNQMmTHIT/2i+EJaLMeyNwwlax/MdUtAB/Qz+Re5oc7gXlTTq50+fsN/7H98J0OPcOGh0Fl0fqGRrWGfli/L4WPLnuELgxN3e0PaKD2ZNgvv2OoPbFL+usE6S5WSrG23E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921227; c=relaxed/simple;
	bh=+qnP1379Ha99LXOuMwG5cKH/6UjcGzGdVUnrXHzqOnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTwFYoHDet5l4c7SXPnuMDWJ+Dwwxn9GKjUZxz5OAjnvh2Mb/5TzAt8pI81sMSiMPSpXqnMSVBeHKcZYJ/6XvMxQEdB6bW5gK/e3+pu6cQedkeiH0Jb2rYlQnaFQ+TF1BMMG77wnFK0yRFH7TV7izeZDGbg7UiPZAMK940efqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH3OvAPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90144C433C7;
	Sat,  3 Feb 2024 00:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706921226;
	bh=+qnP1379Ha99LXOuMwG5cKH/6UjcGzGdVUnrXHzqOnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XH3OvAPrsewpKevjIUMkr00UD5ZXr2JFjVZxsWGEYZ2341KvAOKw524BrlY1egdv6
	 nnjpSMMOVpKiqiSvzB6IlAOcuTlyfsfCSaj6gsxZgGeP7ejHROwrXZjwXYRQDgt6Y0
	 +5zc6BDuza9B4IW4iCkPwHAwjUK3l5GUziV+gfXSa9UNhkXcBlHaHQgti9Y/IoJKzP
	 0LwNfb5C53EhVxkLb/D6SFmZaSxpZRP6y5t7QhkmgvKqGe1JiS2DqZ4DWaV8WhNr3w
	 dtQlvnnE0pGntGKRNbk3OZDIdKvBfQFH9HBFPTgotHVSyGG6Luc0ikEsMlpsolI49f
	 L6kitJFi+yb9w==
Date: Fri, 2 Feb 2024 16:47:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Persistent problem with handshake unit tests
Message-ID: <20240202164705.6813edf2@kernel.org>
In-Reply-To: <39a8176f-7c22-41ac-a027-dac10e349c51@roeck-us.net>
References: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
	<20240202112248.7df97993@kernel.org>
	<f76d66dd-5920-4bf1-95f5-dd64f19826d4@roeck-us.net>
	<39a8176f-7c22-41ac-a027-dac10e349c51@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 12:51:07 -0800 Guenter Roeck wrote:
> > I have CONFIG_NET_HANDSHAKE_KUNIT_TEST=y enabled in my configuration.
> > The tests run during boot, so no additional work is needed. I don't run all
> > tests because many take too long to execute in qemu.

I was wondering how do you discover the options. Periodically grep for
new possible KUNIT options added to the kernel? Have some script that
does it.

> Follow-up: If this test isn't supposed to run during boot, please
> let me know and I'll drop it.

FWIW I don't see why, but Chuck is the best person to comment.

