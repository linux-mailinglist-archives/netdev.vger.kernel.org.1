Return-Path: <netdev+bounces-151717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C489F0B6A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9086E1624B3
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C591AB528;
	Fri, 13 Dec 2024 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmGplX1z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27C944F
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089839; cv=none; b=Jn20aBF5Y6MEZeAlJ0BT0V/9szkWLW8ax2wbVTVCLlg/duHMKluyeoLwBGzLIEbfcvGVJaDZ8YA6YJql0PmWcT9Kn3obXd2Y4TNR6z8zgPFf7DwpT6HpnMc5twaezcBlHo7Nzb5lZYWkCfNP4aniPdb1F0LoCfWvmjBCxjCBht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089839; c=relaxed/simple;
	bh=md4/9Wj+bLJ4xvCJ2L4IvpF+mjwFXHhbb3U3Sc4MnAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tf6pKhAiVIe960Wxs9aRQ2fWPfJyXnqhX/afHu2+rlkOtQfLt3PF7OddraK592Pn8whSo7uqd03sD/hkKU/Lr2kZsR9bvCQ0Q21MgeoIgRXfADbfz8E9i5G+yNbOQ+Zeekwab3laofIlQCsjNuO2ydbck6qHvbPLk+yCkF7vvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmGplX1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A1EC4CED0;
	Fri, 13 Dec 2024 11:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734089838;
	bh=md4/9Wj+bLJ4xvCJ2L4IvpF+mjwFXHhbb3U3Sc4MnAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mmGplX1zMsRM92o9FLb2XXGhcYvBkr5zvkss3pcxn/xJP8ymEDyn+NfKn25lRZZ3v
	 GGij0x/nCkH2DxONp0Fy9cISN/pN2J7jOpJTkw5ZrkRe4SVWErTo0k6Go7VRPkPnLr
	 8jORyJWP6g8/YxWFM+fx7F/A0U6H+FMm0mo0Dojelik6ZnALcscAwULuj14D59oxaQ
	 EfVkc+CF2hENXj4seuWXOwUyoHX6Qk28y6GXgSZUGOevJ9Ebpl4SbWb7zuKR9xgies
	 WTSlNCXfnX8Z/iu7j0I1rKCfu7sI1EtjqRGi9yzIHeFZ6xIu9WnDAKxf7/SnKMRvWI
	 w6rj4smZQyaGg==
Date: Fri, 13 Dec 2024 11:37:12 +0000
From: Simon Horman <horms@kernel.org>
To: Shay Agroskin <shayagr@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Arinzon, David" <darinzon@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 net-next] net: ena: Fix incorrect indentation
Message-ID: <20241213113712.GO2110@kernel.org>
References: <20241212115910.2485851-1-shayagr@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212115910.2485851-1-shayagr@amazon.com>

On Thu, Dec 12, 2024 at 01:59:08PM +0200, Shay Agroskin wrote:
> The assignment was accidentally aligned to the string one line before.
> This was raised by the kernel bot.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412101739.umNl7yYu-lkp@intel.com/
> Signed-off-by: David Arinzon <darinzon@amazon.com>
> Signed-off-by: Shay Agroskin <shayagr@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


