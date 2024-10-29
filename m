Return-Path: <netdev+bounces-140155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960FD9B564E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105BC283AD3
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE5620A5C1;
	Tue, 29 Oct 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOLEtsWY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0418FDC5;
	Tue, 29 Oct 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243004; cv=none; b=EsjH+Tvm9wbnaodNJHfGOy9DCgk4KPmKkn0aR6NUX/DJZ9NoiJUvKgbecqbzNzpWqlE5pJyeh1oIXn0IHA6fOLIU1biRUnTd/ahbc+Y9bxsDED1c2TBcgWhzY4kvYBy1BXXdijlyQ0HSXYiX01w8deRqmhcPFyH8V4wcFFKMflQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243004; c=relaxed/simple;
	bh=v0+8IKTme5rO5Hgw1sOdSwSw6/tlI68VWRHybbNIjd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ux0h0RVAFw8C/+mO+8GtWCJdRQkoZVB3btHEf7Xji0fMpBNox49y+nV5MA8N8yxlKAZKCXPOI34f7iCFUAaiCVzfA0Aor5aWhQJu3eqvFDTujmBKORk+5wNqrxPLZbSCha/nBElelbo4wyJeHR57Oy6/AilFl6vTc0k2KqU9aeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOLEtsWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0910CC4CECD;
	Tue, 29 Oct 2024 23:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730243004;
	bh=v0+8IKTme5rO5Hgw1sOdSwSw6/tlI68VWRHybbNIjd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SOLEtsWYiZeBWHbOwcNVIDsFsBiG1ZVLB+QskNH2MbNYnazhWRJjzWfpW/ggLFfrg
	 SGp8KWIGdBRM0VHwuwnz4owNoibOoXMBrIY8MXbQYRkYSDArmERIP5VsZc38btvJs5
	 7SAV999nw07MigjHLRCkk+WJUfgcbxh10BOqyBXm4bc8Ez1Aqo+07RaxRhLe5jtz3b
	 LSADQ59+L5BS9PI87hlbHx1vEAQXyxaxGmAJMsCbMxy+9po48GoBELIz2ZOhT3N9jL
	 eptq9O1afKJixi81rwtahYdTATbeplep5O8pY/hlKwO7ABYIB3SsLkZGD3bkSYgZnj
	 Pzdss9zUnftpg==
Date: Tue, 29 Oct 2024 16:03:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Sudarsana Kalluru
 <skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, Doug Berger
 <opendmb@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>, Sabrina
 Dubroca <sd@queasysnail.net>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: broadcom: use ethtool string helpers
Message-ID: <20241029160323.532e573c@kernel.org>
In-Reply-To: <20241023012734.766789-1-rosenp@gmail.com>
References: <20241023012734.766789-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 18:27:34 -0700 Rosen Penev wrote:
> @@ -3220,13 +3212,13 @@ static void bnx2x_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
>  			start = 0;
>  		else
>  			start = 4;
> -		memcpy(buf, bnx2x_tests_str_arr + start,
> -		       ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp));
> +		for (i = start; i < BNX2X_NUM_TESTS(bp); i++)
> +			ethtool_puts(&buf, bnx2x_tests_str_arr[i]);

I don't think this is equivalent.

Also, please split bnx2x to a separate patch, the other drivers in this
patch IIUC are small embedded ones, the bnx2x is an "enterprise
product".
-- 
pw-bot: cr

