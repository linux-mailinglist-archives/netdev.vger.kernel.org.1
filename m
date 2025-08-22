Return-Path: <netdev+bounces-216049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB2EB31BFD
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2ACB1D61153
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608C331AF36;
	Fri, 22 Aug 2025 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKwv2MBG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC830BF6B;
	Fri, 22 Aug 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872608; cv=none; b=iEsle9sNGCO/R91+sSBG59So8NI+X3MNYxmVkBUUGtuyDcyFD73ZDDcuUeyQl0L7TkkHfgfrOVFAVtxtLvzZu0ySh1Xm/LqCB+uGCosENPaWoh6gQGUaZ55xoXwoiapI2ijkgvkePyuWOzXhf8gYJtWfYRJTRP5qusz7fXX9X6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872608; c=relaxed/simple;
	bh=NRmbokerOkaoNwUm/ECSYcST0Xx0kquTkzlGfTjqUAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ei87yKKi9K+a34nkzNK9szqxOW+5l99IhgySSLXPLTb9hoJuDzoVZ0vo7/uXiKVuE+XdnM4bagu51UOY0cO9bCis2/7UUKR71Sfb+OzinQKyNYdWUmIZM1lvZs1nb+h1r1QUobbFaN1dC1QBrjQtpoI5Qn6/R1jN1HuuARV5gYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKwv2MBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77710C4CEED;
	Fri, 22 Aug 2025 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872607;
	bh=NRmbokerOkaoNwUm/ECSYcST0Xx0kquTkzlGfTjqUAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qKwv2MBGVd60tTdMjme/4HLd0iQIXLtwZmOtuD2UVfs5ZQEvImFR6TMHfvyxbnsFg
	 B4CM5hMy0a4F2JmlzB2iTbhE3hTp0QgAareINSGbG8HzmMArh9KJxfigR197iBtoyr
	 SUQdMXSaY2xt/JiVqShNh7EYBSMVASHgTEpiZmLa1EMiAmi1TXe82jp4zRkxh2tqaN
	 Y9lOoCsTcUnwSh/j8iwN58YjrKBbNppGWw4IaERnrzbZCK/R8jqvCI9P7U/XeYGDmA
	 E2C7RBa3YXRNlVFQOrbrfnjoCyXsgngRIvtX4m4r+LlgmwQTY0FCJXDkOCvn29HvZ3
	 RRO9yeZQfePhw==
Date: Fri, 22 Aug 2025 07:23:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Michal Schmidt
 <mschmidt@redhat.com>, netdev@vger.kernel.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
Message-ID: <20250822072326.725475ef@kernel.org>
In-Reply-To: <aKfwuFXnvOzWx5De@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
	<CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
	<aKXqVqj_bUefe1Nj@mozart.vkv.me>
	<aKYI5wXcEqSjunfk@mozart.vkv.me>
	<e71fe3bf-ec97-431e-b60c-634c5263ad82@intel.com>
	<aKcr7FCOHZycDrsC@mozart.vkv.me>
	<8f077022-e98a-4e30-901b-7e014fe5d5b2@intel.com>
	<aKfwuFXnvOzWx5De@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 21:23:20 -0700 Calvin Owens wrote:
> > > If you actually have data on that, obviously that's different. But it
> > > sounds like you're guessing just like I am.  
> > 
> > I could only guess about other OS Vendors, one could check it also
> > for Ubuntu in their public git, but I don't think we need more data, as
> > ultimate judge here are Stable Maintainers  
> 
> Maybe I'm barking up the wrong tree, it's udev after all that decides to
> read the thing in /sys and name the interfaces differently because it's
> there...

Yeah, that's my feeling. Ideally there should be a systemd-networkd
setting that let's user opt out of adding the phys_port_name on
interfaces. 99% of users will not benefit from these, new drivers or
old. We're kinda making everyone suffer for the 1% :(

