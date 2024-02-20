Return-Path: <netdev+bounces-73243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA6D85B92D
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB191F21BFD
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC5F5FDA7;
	Tue, 20 Feb 2024 10:36:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D33EA88
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425389; cv=none; b=dX7TNvFiHbdO59dhhLsfY5iM8AVlBg8hhhfQlf1k2SyDllfoPJAunPkZfgxwqL2Qm3ATrCwclz4bJlc/ggK6V6Mj7Tcgyw4BcgTbA7jxhlu0GXQTf6+jy588NwGNeZuj9BFTETP8Af01PC9WfnpjaE/mCpOfTQb2R7r9jvFsVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425389; c=relaxed/simple;
	bh=b0fnN4tJo+dXZsnVc4JP8UP1L62OJmcOPerir6pVoxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbhFgv3ato0UaksPd3MENNAW4yktZNVFZFii6b464WB118c7nT/w/t5Kv1A7kE21Y+tBnbHU1NoMx6KTIn2xt1FPinYAeXn3rDMw6CMv1mxOWsH0GTAVJ73QACZi/euAVp0x6LQkUmntOW/kbU9hv9pp2RMBhdzqRBow58CAE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=35162 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rcNTy-009sz4-1R; Tue, 20 Feb 2024 11:36:16 +0100
Date: Tue, 20 Feb 2024 11:36:13 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: kovalev@altlinux.org
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, jiri@resnulli.us,
	jacob.e.keller@intel.com, johannes@sipsolutions.net,
	idosch@nvidia.com, horms@kernel.org, david.lebrun@uclouvain.be
Subject: Re: [PATCH net ver.2] genetlink: fix possible use-after-free and
 null-ptr-deref in genl_dumpit()
Message-ID: <ZdSAndRQxKGkV/EO@calendula>
References: <20240220102512.104452-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220102512.104452-1-kovalev@altlinux.org>
X-Spam-Score: -1.8 (-)

On Tue, Feb 20, 2024 at 01:25:12PM +0300, kovalev@altlinux.org wrote:
> From: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> The pernet operations structure for the subsystem must be registered
> before registering the generic netlink family.

IIRC, you pointed to a syzbot report on genetlink similar to gtp.

Maybe add that tag here and get the robot to test this fix?

I'd suggest to describe the scenario, which is: There is a race that
allows netlink dump and walking on pernet data while such pernet data
is not yet set up.

Thanks.

> Introduced in commit 134e63756d5f ("genetlink: make netns aware")
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> ---
>  net/netlink/genetlink.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 8c7af02f845400..20a7d792dd52ec 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -1879,14 +1879,14 @@ static int __init genl_init(void)
>  {
>  	int err;
>  
> -	err = genl_register_family(&genl_ctrl);
> -	if (err < 0)
> -		goto problem;
> -
>  	err = register_pernet_subsys(&genl_pernet_ops);
>  	if (err)
>  		goto problem;
>  
> +	err = genl_register_family(&genl_ctrl);
> +	if (err < 0)
> +		goto problem;
> +
>  	return 0;
>  
>  problem:
> -- 
> 2.33.8
> 

