Return-Path: <netdev+bounces-66164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5258C83DA53
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 13:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FB71C23FB7
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E492514A83;
	Fri, 26 Jan 2024 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXhzlhV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C31B592
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273586; cv=none; b=UragyoRWV7S6XETLhRVwviI8xxeE0TN1Ivo5XNE4mvRvHVYcacD90X9fnLuoBq3mERmXBOHCYJ6pCi5y4PmvRqASanJ6+ke8lVBrL44bT2bZ3mjbzJtENDcv8Dggj7Ps/ypGAHYPpo5KcoeBmxvCW6T23ULHo6XOsJQyD3OSGcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273586; c=relaxed/simple;
	bh=nsnVe9evv5RGZqCYRMTq3AD03e1irCYHVlZVRKHzt/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nf+zTE6pngD23nVDV073IRxwvtTqZAIVY4MBJSNi7XO7MNKw/6RqoMo/08PVvOuoG5QN4DVtBja69CShqRspCJj04L0jIROJQAjrFF8bxXZmoDZM4SOh9RfGnrBefTcXbsF9b0oXxpX74YKY1uS2ICsNzh7Xa3PXJb6/b6JTVgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXhzlhV6; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ddef319fabso213449a34.1
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 04:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706273584; x=1706878384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/tqrBtkLZP2T7bUYQazOVxf9vB6ZMQ4rdWExEEeL38=;
        b=OXhzlhV6MQ58yH2HN8VJMKjJIpkOIgg4sHBQx7nFPeNQ2phMxHevIZ2Yah8CPBO2s3
         QnsjIa540xWk8pPfVJpTYM6b7Y+VqnlLInpz0FZh/B2P8XhN49eWyp4Ux1Hxx8ztWeFm
         14PBxgNJAegPNOAmXl/N5GGP/tIwJrAcQs3ub3gGFhphPInffnsGlyd0oIMcb/LeD5Oe
         n1kM+F9LmElIum/b1ARTKQOeoB34tSxw8lo4h4SLW6ZC6D4ghD9qAPLmyWce8ofqQluF
         S68ekMCM0sBmaekSA1bOIiCQCCW4kkcF9J3hCyU51my80wtB2KkCUt+YlVrX6QHJV1pM
         Lykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706273584; x=1706878384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/tqrBtkLZP2T7bUYQazOVxf9vB6ZMQ4rdWExEEeL38=;
        b=Z1n9BQgf173OPisbMjCmIezpbkAOaz0Y9crx3cTXkktQF47MzInsqRCbTXpTVqb4f4
         C6i7/VhxgTMWrBTAdx99uag9T9YLU3lG5Csz6QUH4bolENocmMgE8BH5RX6GzWjuHVHt
         SgDZfgwHLwcQOQmBeu9eAmCiOt5jPF5XF0syD/3Iz5upbVij3VUmFJcqDr6PFh8cUYrR
         fwiN18pUyHy30Kt/cauHqCU6BrdlWf9ed1q8QykTED7FOh196qvsmpGEJlHBzJTl/D9c
         TFdU3dY13TkKxEUX/+IakpG//Kc4pSKBpRFBAcIEPdcF1UFm6nL22BINDb60v/kJXquD
         4mSQ==
X-Gm-Message-State: AOJu0YwadFDF/a/c09wOjKNGRZALVlkEfNpNOYMc/XlII9RNyiA2A96i
	uGqVYCPEUHYRzKAbNwOb3QMObNLz25mmcgwxX6zupo/1uuWRNtI8
X-Google-Smtp-Source: AGHT+IESsMz6jFJq2bwh4NLWs2t/vmPyXajxREdKlX5ghN/eeVjcwD/kozLmyBO5q3QqDNC6kwCgeQ==
X-Received: by 2002:a05:6358:8821:b0:176:5200:bc17 with SMTP id hv33-20020a056358882100b001765200bc17mr1659629rwb.30.1706273584268;
        Fri, 26 Jan 2024 04:53:04 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k10-20020a6568ca000000b005d400e0787dsm879815pgt.83.2024.01.26.04.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 04:53:03 -0800 (PST)
Date: Fri, 26 Jan 2024 20:52:59 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jay Vosburgh <j.vosburgh@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net-next 3/4] selftests: bonding: reduce
 garp_test/arp_validate test time
Message-ID: <ZbOrKyuGXYYaKibx@Laptop-X1>
References: <20240124095814.1882509-1-liuhangbin@gmail.com>
 <20240124095814.1882509-4-liuhangbin@gmail.com>
 <e130d1ee30f2800c7afb548683dc1313dc33eb53.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e130d1ee30f2800c7afb548683dc1313dc33eb53.camel@redhat.com>

On Fri, Jan 26, 2024 at 10:57:31AM +0100, Paolo Abeni wrote:
> On Wed, 2024-01-24 at 17:58 +0800, Hangbin Liu wrote:
> > @@ -276,10 +285,13 @@ garp_test()
> >  	active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
> >  	ip -n ${s_ns} link set ${active_slave} down
> >  
> > -	exp_num=$(echo "${param}" | cut -f6 -d ' ')
> > -	sleep $((exp_num + 2))
> > +	# wait for active link change
> > +	sleep 1
> 
> If 'slowwait' would loop around a sub-second sleep, I guess you could
> use 'slowwait' here, too.

OK, let me change the slowwait to sleep 0.1s.

> 
> >  
> > +	exp_num=$(echo "${param}" | cut -f6 -d ' ')
> >  	active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
> > +	slowwait_for_counter $((exp_num + 5)) $exp_num \
> > +		tc_rule_handle_stats_get "dev s${active_slave#eth} ingress" 101 ".packets" "-n ${g_ns}"
> >  
> >  	# check result
> >  	real_num=$(tc_rule_handle_stats_get "dev s${active_slave#eth} ingress" 101 ".packets" "-n ${g_ns}")
> > @@ -296,8 +308,8 @@ garp_test()
> >  num_grat_arp()
> >  {
> >  	local val
> > -	for val in 10 20 30 50; do
> > -		garp_test "mode active-backup miimon 100 num_grat_arp $val peer_notify_delay 1000"
> > +	for val in 10 20 30; do
> > +		garp_test "mode active-backup miimon 50 num_grat_arp $val peer_notify_delay 500"
> 
> Can we reduce 'peer_notify_delay' even further, say to '250' and
> preserve the test effectiveness?

Hmm, maybe we can set miimon to 10. Then we can reduce peer_notify_delay to 100.

Jay, do you think if there is any side efect to set miimon to 10?

Thanks
Hangbin

