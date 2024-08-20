Return-Path: <netdev+bounces-119977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDED957C14
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 05:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31191C23950
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD7B3A8F0;
	Tue, 20 Aug 2024 03:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Peo3cvq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5456A33A
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 03:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125730; cv=none; b=QbhMOnCgBlugAnK/MUcHpknuEox6GO5zX8QnFv2Z6i77ruq9PH2/t6O6DeouTbKXjqLq92eycHgZW6j5f5kshK+R0UFr+AqO2jaeVP755yA56A5RyqCe9Zewq1PU7MgoBZcHCFyiTj5SXh2xWEiIPHlu3+jrZkoo0MDjGM1VnrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125730; c=relaxed/simple;
	bh=c9yDdNrYN7ePqtLVaQgq5De3C59Drj7PZ82IR3DNBtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3eu9F6uCuzabkCzGPDhm057enlibMQRzZQGT4QsCoV/PWsiWvCm1dA2TrbaksJqE14oBRBx6oM1q2gOC0Ni7HlSQg4/8RDmWEbJ+mmPcp0ffp+zyz67JYKbsyXxdOolstUoanulw32OSp7hWtSd1iXR1iRGMS9YUlA5j2OjOMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Peo3cvq4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d1c655141so3216939b3a.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 20:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724125728; x=1724730528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=klajZpVCTdhogcptiSuUetKYwyxBAiZa+QgCWj+k/PE=;
        b=Peo3cvq4XDXYSjUSoWsacGoR8tFKQU84xfGtTxOamSdJdOUWMcH6sI9L1Qh4cBk3s9
         goo/8tIaj3A3lqRfwLDvvu8hWdCTXb1jmWwLzepvCZEPNOipRPrTMTo25Uxa1QXIYC7A
         tvxO+8FY8QexRvzZ03ORWgbjlVV0TPDqk8iBGRl3/pbWw0gfiQj8XQrP/WAqHSHtMiPv
         5JO6r1hsP6gkZuCls8goYUY1IzCsY8JAieXd4jcxV2kJFVsYThy70oy6vZwmBCCEBU7H
         dV9pks+3rTQQtqi+w1orQvUYLaidx6YHawTHgDLiixnRF392vcAtIb/hmUodL89i8Wvv
         hQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724125728; x=1724730528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klajZpVCTdhogcptiSuUetKYwyxBAiZa+QgCWj+k/PE=;
        b=S0AggFILH3snTNoimlaB9G9qnLXEKfCGxtGzGB1vtdTB/glP8cbgj2je9/iziDejWS
         XxVHVvngB3W/Yc6HvpEeB4Dsju1/p6o2GpKvbFsINypTHJcl/BuQTWTAHv0uvhhFAxNH
         GeZr37Z4/sOt80rYEDSCdcMPs9a2GbuiA31ZMaQPgYMBPqd+JCzgW+yKNsRipxXtcZPY
         xiIRbZjNNPHabEk7C91jGczDr1V8dVROsHr2ph5rIk0Ac8bf6WQElXwXuh6eHdYOHlrL
         fDD9/F0leOEiFN2iUebH1QRtYAWPQhyT7TghcjrfW4sPCEVM8BHnKcfFycvYkmH4PB8c
         VRvg==
X-Gm-Message-State: AOJu0YxrngltjabiJytNx9MNKYT1Lmt/1prAfRVB8O48F7OphPu4r7Z0
	ho4cZ4Yq6FdItIXWNNZdXzRF3+D3XwJ6secNkydodRMH1Dz+xWfI
X-Google-Smtp-Source: AGHT+IExijo1Aq1/wSWTeMmItAT5GJGkQpbsg2KAYME56esvBs749jE8eCAfhSpN0Fm/0TNgw1MTUg==
X-Received: by 2002:a05:6a21:3416:b0:1be:bfa2:5ac3 with SMTP id adf61e73a8af0-1c905026109mr12954463637.35.1724125728425;
        Mon, 19 Aug 2024 20:48:48 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03795edsm69069445ad.153.2024.08.19.20.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 20:48:47 -0700 (PDT)
Date: Tue, 20 Aug 2024 11:48:41 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net, jv@jvosburgh.net, andy@greyhouse.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jarod@redhat.com
Subject: Re: [PATCH net 4/4] bonding: fix xfrm state handling when clearing
 active slave
Message-ID: <ZsQSGRGoNaHCnTHD@Laptop-X1>
References: <20240816114813.326645-1-razor@blackwall.org>
 <20240816114813.326645-5-razor@blackwall.org>
 <ZsK2hY8w6zP8ejUY@Laptop-X1>
 <ff8d2230-245a-4675-aca1-775be6b03777@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8d2230-245a-4675-aca1-775be6b03777@blackwall.org>

On Mon, Aug 19, 2024 at 10:38:01AM +0300, Nikolay Aleksandrov wrote:
> >> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> >> index bc80fb6397dc..95d59a18c022 100644
> >> --- a/drivers/net/bonding/bond_options.c
> >> +++ b/drivers/net/bonding/bond_options.c
> >> @@ -936,7 +936,7 @@ static int bond_option_active_slave_set(struct bonding *bond,
> >>  	/* check to see if we are clearing active */
> >>  	if (!slave_dev) {
> >>  		netdev_dbg(bond->dev, "Clearing current active slave\n");
> >> -		RCU_INIT_POINTER(bond->curr_active_slave, NULL);
> >> +		bond_change_active_slave(bond, NULL);
> > 
> > The good part of this is we can do bond_ipsec_del_sa_all and
> > bond_ipsec_add_sa_all. I'm not sure if we should do promisc/mcast adjustment
> > when set active_slave to null.
> > 
> > Jay should know better.
> > 
> > Thanks
> > Hangbin
> 
> Jay please correct me, but I'm pretty sure we should adjust them. They get adjusted on
> every active slave change, this is no different. In fact I'd argue that it's a long
> standing bug because they don't get adjusted when the active slave is cleared
> manually and if a new one is chosen (we call bond_select_active_slave() right after)
> then the old one would still have them set. During normal operations and automatic
> curr active slave changes, it is always adjusted.

OK, I rechecked the code. The mcast resend only happens when there is a new
new_active or in rr mode. But bond_option_active_slave_set() only called with
active-backup/alb/tlb mode. So this should be safe.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

