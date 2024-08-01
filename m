Return-Path: <netdev+bounces-115052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6065D944FBE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B34B1C236E2
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01A81B32A8;
	Thu,  1 Aug 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqObF2YB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854341B372C;
	Thu,  1 Aug 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527866; cv=none; b=ZBuJ3WGBLHtkBY3G4t3g7jgmaRKFXDcN4pgkj5m9wsSklUMoGY6qGZLW1ZizSaY60ZWQ54iOVwn4W6gPEhNBtzo+yMBY2qyDykA8c/DnClGCFR7Lbi4meKprCV8BWr0gpzkg6TpLdVbQ3M3x3YsGCtMGuNDvocSELjCWIj97VSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527866; c=relaxed/simple;
	bh=8m14hEahasFFpyPVs0LnHuvNBIbzLXWbpSAWJByYraY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCAaQUp8vVQD+Wh1DpxTAfC9GKhIMV0i8405yRwoi0ID/ObqBDTdFCYfB7DsEC0iRiNUYeEJp7hmYwPIip3sbHzKiq8L9yukgdHP105PWUyABDNOa+HRylu3yEezwInvaycoQDa38T5yJgCP378gB3mfulq6Zb2HC7wjQ0r3J1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqObF2YB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7448C32786;
	Thu,  1 Aug 2024 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722527866;
	bh=8m14hEahasFFpyPVs0LnHuvNBIbzLXWbpSAWJByYraY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DqObF2YBLRttIjeD0P2PUSTeJhGACde7WH0IQzXbrrD6Ku+EIwRHKZVM8Rxk49I2M
	 KhVLJrNbjpHI4LAqIdYmZuseFRgiJmbAW2NGwJlZcp+eSkWBYSDsSS/U2H/hxHco+L
	 EPGMQeuvspemEdNriXpIwcJF2ofin7TRQViY0om64juF8b/rOl3QQqr+M4dov9LMdn
	 /ivRRSmi30IKUZP2Ed3XHDNWw3PDEzxcXQVj0fXn6skT5SjQai3o5bvVzf5FKWS9Z1
	 7pcdmxvsMugtBJKtJoj8CPFSorOYi7GxqP0ziBYSAQZe0dp7JurpCNiITebcuX7Md4
	 +zoCtVSXRfmww==
Date: Thu, 1 Aug 2024 08:57:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
 <matt@codeconstruct.com.au>
Cc: John Wang <wangzq.jn@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mctp: Consistent peer address handling
 in ioctl tag allocation
Message-ID: <20240801085744.1713e8b5@kernel.org>
In-Reply-To: <20240730084636.184140-1-wangzhiqiang02@ieisystem.com>
References: <20240730084636.184140-1-wangzhiqiang02@ieisystem.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 16:46:35 +0800 John Wang wrote:
> When executing ioctl to allocate tags, if the peer address is 0,
> mctp_alloc_local_tag now replaces it with 0xff. However, during tag
> dropping, this replacement is not performed, potentially causing the key
> not to be dropped as expected.
> 
> Signed-off-by: John Wang <wangzhiqiang02@ieisystem.com>

Looks sane. Jeremy? Matt?
In netdev we try to review patches within 24-48 hours.
You have willingly boarded this crazy train.. :)

