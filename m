Return-Path: <netdev+bounces-62667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB133828706
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 14:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02E21C2419C
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F30B38F8C;
	Tue,  9 Jan 2024 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUilqq+d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C8381DB
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 13:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A33EC433C7;
	Tue,  9 Jan 2024 13:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704806770;
	bh=/cIBJt7Bt0hanb92hp2LXRXZr/QtDzNpP6XjV2HAFeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUilqq+d3zgmA8fmo16ltP36aTuJuZkyNxWN7drQzKv2bNQNNOv79T+HBuUi53LO3
	 Z896AUmWDdkU2RetEKjpb7KtvHS9PYaaeZh8eM50vjC5BSI/Tp+6igGOjimO336wvF
	 q3jxTT8keKvI/HtG6eJ4SIMbGAq2iyw3ROfK4MjsxKARb9L3/uujrhS8jsqpuzSntZ
	 FjsHVZBTCHezb+gAmqn6iM9SPKJweG/JXlyWbdfL2pM16i5W9JrIgWiE1QVuX6QCUj
	 riquUSa2twuGK3Tm7mf5PQaz84xOEC7Js+eEP1kWcbXnL7nAnft4kiJBJalJpHz87a
	 jpt0WPoWOzhsw==
Date: Tue, 9 Jan 2024 15:26:06 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shachar Kagan <skagan@nvidia.com>, netdev@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	Neal Cardwell <ncardwell@google.com>
Subject: Re: [PATCH net-next] tcp: Revert no longer abort SYN_SENT when
 receiving some ICMP
Message-ID: <20240109132606.GB8475@unreal>
References: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
 <CANn89iLNGrZo_z1L184F3WetrWV8bQwYrfyEDgn2-gtnPndDgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLNGrZo_z1L184F3WetrWV8bQwYrfyEDgn2-gtnPndDgA@mail.gmail.com>

On Mon, Jan 08, 2024 at 04:52:39PM +0100, Eric Dumazet wrote:
> On Tue, Jan 2, 2024 at 10:01 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Shachar Kagan <skagan@nvidia.com>
> >
> > This reverts commit 0a8de364ff7a14558e9676f424283148110384d6.
> >
> > Shachar reported that Vagrant (https://www.vagrantup.com/), which is
> > very popular tool to manage fleet of VMs stopped to work after commit
> > citied in Fixes line.
> >
> > The issue appears while using Vagrant to manage nested VMs.
> > The steps are:
> > * create vagrant file
> > * vagrant up
> > * vagrant halt (VM is created but shut down)
> > * vagrant up - fail
> >
> > Vagrant up stdout:
> > Bringing machine 'player1' up with 'libvirt' provider...
> > ==> player1: Creating shared folders metadata...
> > ==> player1: Starting domain.
> > ==> player1: Domain launching with graphics connection settings...
> > ==> player1:  -- Graphics Port:      5900
> > ==> player1:  -- Graphics IP:        127.0.0.1
> > ==> player1:  -- Graphics Password:  Not defined
> > ==> player1:  -- Graphics Websocket: 5700
> > ==> player1: Waiting for domain to get an IP address...
> > ==> player1: Waiting for machine to boot. This may take a few minutes...
> >     player1: SSH address: 192.168.123.61:22
> >     player1: SSH username: vagrant
> >     player1: SSH auth method: private key
> > ==> player1: Attempting graceful shutdown of VM...
> > ==> player1: Attempting graceful shutdown of VM...
> > ==> player1: Attempting graceful shutdown of VM...
> >     player1: Guest communication could not be established! This is usually because
> >     player1: SSH is not running, the authentication information was changed,
> >     player1: or some other networking issue. Vagrant will force halt, if
> >     player1: capable.
> > ==> player1: Attempting direct shutdown of domain...
> >
> > Fixes: 0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving some ICMP")
> > Closes: https://lore.kernel.org/all/MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com
> > Signed-off-by: Shachar Kagan <skagan@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> 
> While IPv6 code has an issue (not calling tcp_ld_RTO_revert() helper
> for TCP_SYN_SENT as intended,
> I could not find the root cause for your case.
> 
> We will submit the patch again for 6.9, once we get to the root cause.

Feel free to send to Shachar with CC me and/or Gal any patches which you
would like to test in advance and we will be happy to do it.

> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks

