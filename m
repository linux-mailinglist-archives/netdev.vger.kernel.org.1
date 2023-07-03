Return-Path: <netdev+bounces-15176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF2B7460EB
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 18:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C8F280E19
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 16:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7F100B9;
	Mon,  3 Jul 2023 16:46:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC2DF9E4
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 16:46:40 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F23E41;
	Mon,  3 Jul 2023 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hGh0RjSMKjqK2Wktq8A3Dwgw/Zxp8Whsd7BqywESmC8=; b=qtKB0VE7XS/zPSFAFKc+aThafR
	LCQB1gwLxwZEa/ooBzb8rCnkiW1tM9mPEEeOLJkzdv9W87fOp6flmOmoy3/9pjSNdzzhYNyyNausq
	pVBILaIj/KPN8JD21o365Av1uppESQ171x5jOgt4L1Cou6adKhr8WQswXFXZ5K8u/cuc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qGMgz-000Unb-El; Mon, 03 Jul 2023 18:46:25 +0200
Date: Mon, 3 Jul 2023 18:46:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: leitao@debian.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	sergey.senozhatsky@gmail.com, pmladek@suse.com, tj@kernel.or,
	Dave Jones <davej@codemonkey.org.uk>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <4b2746ad-1835-43e6-a2fc-7063735daa46@lunn.ch>
References: <20230703154155.3460313-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703154155.3460313-1-leitao@debian.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Cc: Dave Jones <davej@codemonkey.org.uk>

Signed-off-by should come last.

> +#ifdef CONFIG_NETCONSOLE_UNAME
> +static void send_ext_msg_udp_uname(struct netconsole_target *nt,
> +				   const char *msg, unsigned int len)
> +{
> +	unsigned int newlen;
> +	char *newmsg;
> +	char *uname;
> +
> +	uname = init_utsname()->release;
> +
> +	newmsg = kasprintf(GFP_KERNEL, "%s;%s", uname, msg);
> +	if (!newmsg)
> +		/* In case of ENOMEM, just ignore this entry */
> +		return;

Hi Breno

Why not just send the message without uname appended. You probably
want to see the OOM messages...

Also, what context are we in here? Should that be GFP_ATOMIC, which
net/core/netpoll.c is using to allocate the skbs?

> +static inline void send_msg_udp(struct netconsole_target *nt,
> +				const char *msg, unsigned int len)
> +{
> +#ifdef CONFIG_NETCONSOLE_UNAME
> +	send_ext_msg_udp_uname(nt, msg, len);
> +#else
> +	send_ext_msg_udp(nt, msg, len);
> +#endif

Please use

if (IS_ENABLED(CONFIG_NETCONSOLE_UNAME)) {} else {}

so the code is compiled and then thrown away. That nakes build testing
more efficient.

     Andrew

