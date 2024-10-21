Return-Path: <netdev+bounces-137579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5DC9A6FE4
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313A51F22DD9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E8A1E8841;
	Mon, 21 Oct 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgi/Gl4m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC81E8825
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528804; cv=none; b=J+34oFJ7WJyEmsK/GtDTBQqAolc8CQ6upoNHej+oxxTmJMUxdJricpzRYQm0tJteWs7sCilIIityp/sg472YH50bdCpKMCNc6OMx+/Tq66jorNj+DuN5twoDQ82unsOntwY4Yx5/FrWIeQoYTCTMPJvLdWs8kTJIXaSRrrPqP3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528804; c=relaxed/simple;
	bh=clBz4bxVyFr6lguTWfYs3z+VHb7CP7RgXSsjuX0vklM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFoJJKlC9TbGdDW7u51ILyFBp5muY6AYj9y/KcRGQlpBhCm6+q56WU3JLx1BMh5rw1nC2EY8ky4uk4o0oYBfrsW8UTdv3BAQdxHD57lZlPrVRQ4dfUujST6XXzyxhdgR77N2VphfG2dnWVrkRlEiNt9AJSYUVw+Av0v2qt1sj7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgi/Gl4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F69C4CEC3;
	Mon, 21 Oct 2024 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729528804;
	bh=clBz4bxVyFr6lguTWfYs3z+VHb7CP7RgXSsjuX0vklM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zgi/Gl4mrqn13Yi1LknwfE1hZZCLCYb826CzcYrYT1pqRf2xInNPsdjbuFgbTlss/
	 uP1dSnvqsSgNyKTcuHIWXCvzFneTYSx0qVA0JfDKbbskOZRnPZ5v2d/Gt3A/cf2uec
	 jxi4kGWcudP1gR4xvPTobRN93E4cui3MznU1yaeP3hLHa3HE07dQey+hDHDtTFuHNz
	 qFQw+RclMc3b6+dbbc6cngwj6YDW22kkKtjQbhh5lafeKesRstGEtVpU2S9qzjypMc
	 tNv32TQN8rziL+qE3ULcaFzLJjZxdUpftghnW6p1b19WRwYIPW4qQMqr29lWqbn603
	 XyWvDrGlFSgYA==
Date: Mon, 21 Oct 2024 17:39:55 +0100
From: Simon Horman <horms@kernel.org>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
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
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>
Subject: Re: [PATCH v1 net-next 1/3] net: ena: Add PHC support in the ENA
 driver
Message-ID: <20241021163955.GL402847@kernel.org>
References: <20241021052011.591-1-darinzon@amazon.com>
 <20241021052011.591-2-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021052011.591-2-darinzon@amazon.com>

On Mon, Oct 21, 2024 at 08:20:09AM +0300, David Arinzon wrote:
> The ENA driver will be extended to support the new PHC feature using
> ptp_clock interface [1]. this will provide timestamp reference for user
> space to allow measuring time offset between the PHC and the system
> clock in order to achieve nanosecond accuracy.
> 
> [1] - https://www.kernel.org/doc/html/latest/driver-api/ptp.html
> 
> Signed-off-by: Amit Bernstein <amitbern@amazon.com>
> Signed-off-by: David Arinzon <darinzon@amazon.com>

Hi David,

As it looks like there will be a v2 anyway, please consider running this
series, and in particular this patch, through:

./scripts/checkpatch.pl --strict --max-line-length=80 --codespell

And please fix warnings it emits where that can be done without
reducing readability and clarity. E.g. please don't split string
literals across more than one line just to make lines short.

Thanks!

