Return-Path: <netdev+bounces-20559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 877F0760144
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EB62814BF
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A15B111B2;
	Mon, 24 Jul 2023 21:36:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2DB1097E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 21:36:55 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382DEE74
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 14:36:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b961822512so69918441fa.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690234611; x=1690839411;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cl41eJ1WC6ILldSjNqzW1R/MpU0yZbIUTyos3W/vR0o=;
        b=J4CUcw3+5oLla8TJKoKYSVEPfeoBbb8HGbt1EaSjZ5ZYN0cwUeijDPUg754M8TWgKq
         i9EBAjICG+W2jNI6eXpwG/Co/CfB4nPkXtHKfV4vAXs8zs1d+e47Twh+4/O1k8ZQGPKb
         i0GyJMUdcXrSAuHZLaWZ2UC9hk2OSsDLE84BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234611; x=1690839411;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cl41eJ1WC6ILldSjNqzW1R/MpU0yZbIUTyos3W/vR0o=;
        b=PcMerEmBwNEbg4l2D96RzHpJBrigTT9hQ8/1iClogLb+xJ3TRjwbNB5+YHTdgDeIym
         rJu8WmvYCG9WcRYNW5oGpFv4eK8i30lVXjfJBLLA4URVqdeiZz55RUulWcEL45mkEuwf
         M/LNenl3i8PKy0a9qcQJCWoHfOtrGp10HGtzUOddd4OYqh6Hav0a0UUnJaNGQlo8jUlv
         n2DMh/zNV81dTr2msmH8B8fW/N+hKk1JSyWAvuGd0nh3zb5T+8LqgMk6HPQK8YmeOvfP
         fhB/te8Lx5L4CnFcUvtS7iFh4gUEDV1jmLa2tGBZRLzSJ1/NGcfBYv0hQ6PSdZowS1Lb
         cGcw==
X-Gm-Message-State: ABy/qLaKj53jiiFNql5Q4Xa6zEKFbtoljss3fcf4IKXyfNQR/Gv5Zfgg
	mQ/nU5cPTPhPFXR1TB2R/LUNvIcYucE9ZJD5fHXmrw==
X-Google-Smtp-Source: APBJJlEIBhBaRS5nkCMsUEUORF8/eFhcX7G26UgE+SkpTlX6AirHvLESoYGQK4lOK9BQqV+Y87oGoQ==
X-Received: by 2002:a2e:80cd:0:b0:2b6:d790:d1a3 with SMTP id r13-20020a2e80cd000000b002b6d790d1a3mr6457024ljg.11.1690234611479;
        Mon, 24 Jul 2023 14:36:51 -0700 (PDT)
Received: from fastly.com ([188.225.251.141])
        by smtp.gmail.com with ESMTPSA id hn32-20020a05600ca3a000b003f9bd9e3226sm11447112wmb.7.2023.07.24.14.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jul 2023 14:36:51 -0700 (PDT)
Date: Mon, 24 Jul 2023 14:36:48 -0700
From: Joe Damato <jdamato@fastly.com>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	ecree@solarflare.com, andrew@lunn.ch, kuba@kernel.org,
	davem@davemloft.net, leon@kernel.org, pabeni@redhat.com,
	arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [net 0/2] rxfh with custom RSS fixes
Message-ID: <20230724213647.GA48335@fastly.com>
References: <20230723150658.241597-1-jdamato@fastly.com>
 <b52f55ef-f166-cd1a-85b5-5fe32fe5f525@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52f55ef-f166-cd1a-85b5-5fe32fe5f525@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 08:27:43PM +0100, Edward Cree wrote:
> On 23/07/2023 16:06, Joe Damato wrote:
> > Greetings:
> > 
> > While attempting to get the RX flow hash key for a custom RSS context on
> > my mlx5 NIC, I got an error:
> > 
> > $ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
> > Cannot get RX network flow hashing options: Invalid argument
> > 
> > I dug into this a bit and noticed two things:
> > 
> > 1. ETHTOOL_GRXFH supports custom RSS contexts, but ETHTOOL_SRXFH does
> > not. I moved the copy logic out of ETHTOOL_GRXFH and into a helper so
> > that both ETHTOOL_{G,S}RXFH now call it, which fixes ETHTOOL_SRXFH. This
> > is patch 1/2.
> 
> As I see it, this is a new feature, not a fix, so belongs on net-next.
> (No existing driver accepts FLOW_RSS in ETHTOOL_SRXFH's cmd->flow_type,
>  which is just as well as if they did this would be a uABI break.)
> 
> Going forward, ETHTOOL_SRXFH will hopefully be integrated into the new
>  RSS context kAPI I'm working on[1], so that we can have a new netlink
>  uAPI for RSS configuration that's all in one place instead of the
>  piecemeal-grown ethtool API with its backwards-compatible hacks.
> But that will take a while, so I think this should go in even though
>  it's technically an extension to legacy ethtool; it was part of the
>  documented uAPI and userland implements it, it just never got
>  implemented on the kernel side (because the initial driver with
>  context support, sfc, didn't support SRXFH).
> 
> > 2. mlx5 defaulted to RSS context 0 for both ETHTOOL_{G,S}RXFH paths. I
> > have modified the driver to support custom contexts for both paths. It
> > is now possible to get and set the flow hash key for custom RSS contexts
> > with mlx5. This is patch 2/2.
> 
> My feeling would be that this isn't a Fix either, but not my place to say.

Thanks for the context above; I'll let the Mellanox folks weigh in on what
they think about the code in the second patch before I proceed.

I suspect that you are probably right and that net-next might be a more
appropriate place for this. If the code is ack'd by Mellanox (and they
agree re: net-next), I can re-send this series to net-next with the Fixes
removed and the Ack's added.

