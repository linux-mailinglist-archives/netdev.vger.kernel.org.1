Return-Path: <netdev+bounces-44722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B56E7D96DB
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 13:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D8BB20E9C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 11:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C07418B0B;
	Fri, 27 Oct 2023 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bXxYkF/b"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981DD17995
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 11:44:35 +0000 (UTC)
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 04:44:32 PDT
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75CB91
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 04:44:32 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202310271143281aa3a71994b6fdffa8
        for <netdev@vger.kernel.org>;
        Fri, 27 Oct 2023 13:43:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=T2bfrY/Lm4YZ9SmstD+oGVjrNxvjXUvjSIMyYD3TJS0=;
 b=bXxYkF/beih1D9f2uOlRevAMZEEQhv6/9KyaIer5htY6RPPh8gwyaVRwX1gm0OBkSTUrhw
 l4Z3TSj0jrnG9DgI8YusYk3cWx4A6+p1Dcl7LEV38RsciAnS8HlNxQmdbWRujdfAsyhd8H0+
 GPCIIcLySUeunsEXpZCdEW4kehUGA=;
Message-ID: <d085757ed5607e82b1cd09d10d4c9f73bbdf3154.camel@siemens.com>
Subject: Re: [PATCH net-next] net/core: Enable socket busy polling on -RT
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri, 27 Oct 2023 13:43:27 +0200
In-Reply-To: <20230523111518.21512-1-kurt@linutronix.de>
References: <20230523111518.21512-1-kurt@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Kurt,

On Tue, 2023-05-23 at 13:15 +0200, Kurt Kanzenbach wrote:
> Busy polling is currently not allowed on PREEMPT_RT, because it disables
> preemption while invoking the NAPI callback. It is not possible to acquir=
e
> sleeping locks with disabled preemption. For details see commit
> 20ab39d13e2e ("net/core: disable NET_RX_BUSY_POLL on PREEMPT_RT").

Is that something that we could consider as Bug-Fix for 6.1 and request
a backport, or would you consider that as new feature?

>=20
> However, strict cyclic and/or low latency network applications may prefer=
 busy
> polling e.g., using AF_XDP instead of interrupt driven communication.
>=20
> The preempt_disable() is used in order to prevent the poll_owner and NAPI=
 owner
> to be preempted while owning the resource to ensure progress. Netpoll per=
forms
> busy polling in order to acquire the lock. NAPI is locked by setting the
> NAPIF_STATE_SCHED flag. There is no busy polling if the flag is set and t=
he
> "owner" is preempted. Worst case is that the task owning NAPI gets preemp=
ted and
> NAPI processing stalls.  This is can be prevented by properly prioritisin=
g the
> tasks within the system.
>=20
> Allow RX_BUSY_POLL on PREEMPT_RT if NETPOLL is disabled. Don't disable
> preemption on PREEMPT_RT within the busy poll loop.
>=20
> Tested on x86 hardware with v6.1-RT and v6.3-RT on Intel i225 (igc) with
> AF_XDP/ZC sockets configured to run in busy polling mode.

That is exactly our use case as well and we would like to have it in
6.1. Any (technical) reasons that prevent a backport?

As some time has already passed since patch submission I will not cut
the rest...

Best regards,
Florian

>=20
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>=20
> Changes since RFC:
>=20
>  * Commit message
>=20
> Previous version:
>=20
>  * https://lore.kernel.org/all/20230517110950.78322-1-kurt@linutronix.de/
>=20
>  net/Kconfig    | 2 +-
>  net/core/dev.c | 9 ++++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/Kconfig b/net/Kconfig
> index 7d39c1773eb4..2fb25b534df5 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -324,7 +324,7 @@ config CGROUP_NET_CLASSID
> =20
>  config NET_RX_BUSY_POLL
>  	bool
> -	default y if !PREEMPT_RT
> +	default y if !PREEMPT_RT || (PREEMPT_RT && !NETCONSOLE)
> =20
>  config BQL
>  	bool
> diff --git a/net/core/dev.c b/net/core/dev.c
> index b3c13e041935..3393c2f3dbe8 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6197,7 +6197,8 @@ void napi_busy_loop(unsigned int napi_id,
>  	if (!napi)
>  		goto out;
> =20
> -	preempt_disable();
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		preempt_disable();
>  	for (;;) {
>  		int work =3D 0;
> =20
> @@ -6239,7 +6240,8 @@ void napi_busy_loop(unsigned int napi_id,
>  		if (unlikely(need_resched())) {
>  			if (napi_poll)
>  				busy_poll_stop(napi, have_poll_lock, prefer_busy_poll, budget);
> -			preempt_enable();
> +			if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +				preempt_enable();
>  			rcu_read_unlock();
>  			cond_resched();
>  			if (loop_end(loop_end_arg, start_time))
> @@ -6250,7 +6252,8 @@ void napi_busy_loop(unsigned int napi_id,
>  	}
>  	if (napi_poll)
>  		busy_poll_stop(napi, have_poll_lock, prefer_busy_poll, budget);
> -	preempt_enable();
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		preempt_enable();
>  out:
>  	rcu_read_unlock();
>  }
> --=20
> 2.30.2
>=20


