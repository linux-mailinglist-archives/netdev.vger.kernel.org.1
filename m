Return-Path: <netdev+bounces-160910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A52CA1C29A
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 11:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B67167B5C
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921311DC19D;
	Sat, 25 Jan 2025 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XGGL6onE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A71D95A9;
	Sat, 25 Jan 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737799583; cv=none; b=SDnyTvqg6P/4UUat8slDu3oytfcFg3ygbd5Lv+ADp7fROKCqkmrpggK4CM1VutTpC5JKNFGulmf9MsEYFszteOHcBCTfOiDooHPFrgd1zD+faOotKPpRdHvUbbvzVJyJybxNIJvYtADWLx41sNZzwnNb9uX1ZwCnI1tjzvPlNls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737799583; c=relaxed/simple;
	bh=iJ3M7K4QM6DBBxG3G9Irgz+ksk5PoZAGeZMd97/fgfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB+yxRNrgrrfAJpUO9p8idrbvcJb0mehzPK8kAzYWmJuEF2S8VIQj1pGBhlh+UF2DGtYNfBFU/V/QmyOi7nV9UPqUwZ5mopfuFknPoRb5MfF/byfiXsL3xIt4Tnipp56GZf1rSHMgMxSlwPo/Ivt34WCnz/DD1WNygDzwBRdIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XGGL6onE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A07BC4CED6;
	Sat, 25 Jan 2025 10:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737799582;
	bh=iJ3M7K4QM6DBBxG3G9Irgz+ksk5PoZAGeZMd97/fgfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGGL6onEQKSThd53Af9VanIC39Lpvo1qzMootiPzIQKm8QK4vsPlNPN8ImMU3WPzY
	 TPFN3r/V3T2jF7zzqUqIhEaklMkt3S6AZ/plOacFl/Vs6I3K0GhK+uZb1+phfvGNuQ
	 bmWT+n9scOnBfJ8ngxXqGoZUJl4gjlhMP8PcifX8=
Date: Sat, 25 Jan 2025 11:06:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: U Michel <ulv@on2.de>
Cc: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: usb: qmi_wwan: fix init for Wistron NeWeb M18QW
Message-ID: <2025012501-pediatric-abide-b802@gregkh>
References: <20250125093745.1132009-1-ulv@on2.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250125093745.1132009-1-ulv@on2.de>

On Sat, Jan 25, 2025 at 10:37:45AM +0100, U Michel wrote:
> From: U M <ulv@on2.de>
> 
> fixed the initialization of the Wistron NeWeb M18QW. Successfully tested 
> on a ZyXEL LTE3302 containing this modem.
> 
> Signed-off-by: U M <ulv@on2.de>

Sorry, but we need a bit more of a name here other than just 2 initials
:(

thanks,

greg k-h

