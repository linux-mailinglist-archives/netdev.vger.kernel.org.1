Return-Path: <netdev+bounces-219368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F565B410CB
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3B6168F7F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B3627F015;
	Tue,  2 Sep 2025 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hs7zH0ev"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6920E00B;
	Tue,  2 Sep 2025 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856113; cv=none; b=SP/qGWvAFQw9m8QnJBf2Re+6YM5T/K82epvkRFg7MW4zO1COb+FsBSaPoESByRTSIblDCHlQ8FuxRUa4OpqB8xrRDuY+llJW3NtJV3709PfTQp8FZDDkLMp6dqVzVeApMR+QzPjqG+5K9D5BTgrOh6ZtUHZA5NotBelKpNZja+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856113; c=relaxed/simple;
	bh=Yu0jVEodkPTvVFabct2RrrX/7iqVU1qZiWO7k25ZXzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkTu8q5XgsBD07ntyO6n6WaSur88Cmrv7R1rUsmigFM9xAFzub9Dh9IHNBR4Y9E6ZpeCVGkXCyJsjyr6RKwoo8cJeGkXsU90K5bNA4tUONe7uXKAv9DAVhrPYtNerp667HUVGKw7geyMmSGdZ7RwizKKkSpAM86/8ZLVmhcmdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hs7zH0ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B78EC4CEED;
	Tue,  2 Sep 2025 23:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756856112;
	bh=Yu0jVEodkPTvVFabct2RrrX/7iqVU1qZiWO7k25ZXzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hs7zH0evhqV4ahtzKH6BZbEYbNGN/VLudXIgIXiJ9Rw0IpEURdoT0Bbpkev9sql0O
	 XaWIhDU8HjBN7jHHvl9/KDIMG46gC8uSkp6m6oDV0Tq0Vvd0B/7IVgNasF1nLfjjMB
	 KJilnTsZ0mUmpX1PBdJ43LT7hfmVPAJJyuNw20lSjzdwABzPrnnXlKyqinP5frRMwa
	 qD7+4lo/pE+MDIZ4Chqz3sVhlqzcUs8HXp7fmCEa8H9Tag01SrHWuEJP093NGLwdUJ
	 6+OVHbWml+V4vO75unL+LMiXztMq96jyJlAzFe10lLJC8fh93kNIIwFHPZMmYLsMQR
	 VBnuxdjYRWSXA==
Date: Tue, 2 Sep 2025 16:35:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Oleksij Rempel" <linux@rempel-privat.de>
Cc: Hubert =?UTF-8?B?V2nFm25pZXdza2k=?= <hubert.wisniewski.25632@gmail.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
 <regressions@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] net: usb: asix: deadlock on interface setup
Message-ID: <20250902163511.181fa76a@kernel.org>
In-Reply-To: <DCGHG5UJT9G3.2K1GHFZ3H87T0@gmail.com>
References: <DCGHG5UJT9G3.2K1GHFZ3H87T0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Aug 2025 10:50:35 +0200 Hubert Wi=C5=9Bniewski wrote:
> Trying to bring an AX88772B-based USB-Ethernet adapter up results in a
> deadlock if the adapter was suspended at the time. Most network-related
> software hangs up indefinitely as a result. This can happen on systems
> which configure USB power control to 'auto' by default, e.g. laptops
> running `tlp`.
=20
Oleksij, this seems to date back to commit e0bffe3e6894 ("net: asix:
ax88772: migrate to phylink"). Taking rtnl_lock in runtime resume
callbacks is known to result in unhappiness :(

Could you check if commit e110bc825897 ("net: usb:
lan78xx: Convert to PHYLINK for improved PHY and MAC management")
isn't similarly flawed?

