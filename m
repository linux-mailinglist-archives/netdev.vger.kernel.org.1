Return-Path: <netdev+bounces-156059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4830A04C8C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2803A5A63
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0519A1D5151;
	Tue,  7 Jan 2025 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/O/O8qL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724AF190664;
	Tue,  7 Jan 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736289783; cv=none; b=av44Ub958FclJ8rD0vS0EGR7+slNlJgBY5gx5ybAqWP/D2A1AOIUdAREJX/7ujj897ASf2KltHJUv/NQrlhXwxMYkRUJD5A8BV1HzBYaV+LlifwaFMf+KNrbIhbDctTBqnk0S/Akj/hS2/z/erx5jkKApflgGslNSK3YSBEWusw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736289783; c=relaxed/simple;
	bh=haT46X4tq5ydqbQTTTwqpHw0sbj/QsmJHW57ObyBcUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYf5NNTm0OdQqd1lJG3UZGSC3a8peSGwlKeJYwL2MlusTeAK0AYLLy0WUMqeVrOJDFuJKIMrgzbRrcAnRr6kx34BK55zyZ5NvDezPpQdMQZZUHbG5gZvIPKvVI17ohP8pJCpKVIDIeXge2mPPjHa9i2Dpfk4wgGcGQ0BT+fsBK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/O/O8qL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2161eb94cceso167751065ad.2;
        Tue, 07 Jan 2025 14:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736289781; x=1736894581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTsDxbyrO38CBtnrx7tweqDOP5VEWORZ2f515i1af/s=;
        b=d/O/O8qL6eOdXEss+K9LiNQLaJpm4kikXJbxwsLl/pqxdwBfpaflP7l6VHYCfm5U/f
         8qtIo3Je8Z0Xs+3xHi4gkZy2roobegkeRnGE1wvoXypk8S1MOfyLxiQN5dUfSbsQ4glL
         GtADXfsjV5J6rcDaOGgibaLwGZVWODGzargC7dsQmdxxw0sDFaY/5EEd0+CJYHmfkIsp
         PXSGunWcPXkIx67DHPHrWIO9bM6Ow9BDliqoBnRGrkZNNdUyLLq+2PtREICKY3twhcFs
         b/JNJKBxAAfY2hIWXo19tu7svxgix0Xigu/wjXdpDbHX7cgSvKx9W0wpOfzMjsYeecXw
         mUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736289781; x=1736894581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTsDxbyrO38CBtnrx7tweqDOP5VEWORZ2f515i1af/s=;
        b=iVZPhYLHsikJOeWk0dDCHAjp41GhuOaeprALwwHQLxAzHVLEdL97m8SZRYE4RbaJU6
         WcdvYU3z8W0Mlc2HfYmMY+LRLldf6/sKqg98swylb63lSTs16Hd0JFWknbmxWjHWFXea
         OeBEW7JgCUNhFQx5aWeV285SabOdQ0r4tfo2N1/Uji/EArLt68crs07ntp0pLO07yOvc
         +uW+juGjNLH0rfZtVS+ZSdgavbfdfdnRJafSSZIuHRaUt1567b0UZVpKRcymDd/4N8y3
         9h+j/HZO7T6gsdZ9ruErQFT0MU6Z+9gIAvHiIB20eJx/8DVJJuLXGReiie+RtsJJOivt
         0Ljw==
X-Forwarded-Encrypted: i=1; AJvYcCWkOZv91C7oOIvDfH73sTjj6K0zN9zVTykZ1nFZQJioHs02azCXPwXvmnBpH9RxCb6zKp/2u5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+/wg/D0SyQDnhy6uWkIzL4dmbnCvFnE8v7ytebRy5TnrJAeY
	qZXaMCiZdxtJtqjU1C3Acw4+W49cshbvNYpN4/IJzbedxm1qOm4r
X-Gm-Gg: ASbGnctZi75ztR3RkqCrhAgNROhgeOI5UHEbECl7wryGo8FTUq86WiXs5eEoW4TZSx/
	yahm++7oNhuq5C6IMI4Tkl8qA6ArnAHMolcLaO9eQVH7m8V8Kr6VgSuJPE1qSd6eLIvu6Emlk95
	h71UpFspYXGkTRsaC5QlXAYd4hm0JHZXPJN3IP0FFaNLL2G975+bPlg63kuqz+4mFcQgD7FWQ9J
	vsxXAU5c8f5dsZ1qrElNBoTO4wBw++RPdiD3+71cgWXfhQJEdcPawiM
X-Google-Smtp-Source: AGHT+IGMNrHmKwHtJMQIeetE11mIavkI1sE71c5XVHpznlNl8Dj/rgoyz/Ujkb+Fu75xPqH/4BOviA==
X-Received: by 2002:a05:6a00:928c:b0:727:3935:dc83 with SMTP id d2e1a72fcca58-72d21fb1e07mr890974b3a.10.1736289781449;
        Tue, 07 Jan 2025 14:43:01 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbbebsm33903786b3a.114.2025.01.07.14.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 14:43:00 -0800 (PST)
Date: Tue, 7 Jan 2025 14:42:59 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 03/14] ibmvnic: simplify ibmvnic_set_queue_affinity()
Message-ID: <Z32t88W3biaZa7fH@yury-ThinkPad>
References: <20241228184949.31582-1-yury.norov@gmail.com>
 <20241228184949.31582-4-yury.norov@gmail.com>
 <Z32sncx9K4iFLsJN@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z32sncx9K4iFLsJN@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>

On Tue, Jan 07, 2025 at 04:37:17PM -0600, Nick Child wrote:
> On Sat, Dec 28, 2024 at 10:49:35AM -0800, Yury Norov wrote:
> > A loop based on cpumask_next_wrap() opencodes the dedicated macro
> > for_each_online_cpu_wrap(). Using the macro allows to avoid setting
> > bits affinity mask more than once when stride >= num_online_cpus.
> > 
> > This also helps to drop cpumask handling code in the caller function.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  drivers/net/ethernet/ibm/ibmvnic.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> > index e95ae0d39948..4cfd90fb206b 100644
> > --- a/drivers/net/ethernet/ibm/ibmvnic.c
> > +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> > @@ -234,11 +234,16 @@ static int ibmvnic_set_queue_affinity(struct ibmvnic_sub_crq_queue *queue,
> >  		(*stragglers)--;
> >  	}
> >  	/* atomic write is safer than writing bit by bit directly */
> > -	for (i = 0; i < stride; i++) {
> > -		cpumask_set_cpu(*cpu, mask);
> > -		*cpu = cpumask_next_wrap(*cpu, cpu_online_mask,
> > -					 nr_cpu_ids, false);
> > +	for_each_online_cpu_wrap(i, *cpu) {
> > +		if (!stride--)
> > +			break;
> > +		cpumask_set_cpu(i, mask);
> >  	}
> > +
> > +	/* For the next queue we start from the first unused CPU in this queue */
> > +	if (i < nr_cpu_ids)
> > +		*cpu = i + 1;
> > +
> This should read '*cpu = i'. Since the loop breaks after incrementing i.
> Thanks!

cpumask_next_wrap() makes '+ 1' for you. The for_each_cpu_wrap() starts
exactly where you point. So, this '+1' needs to be explicit now.

Does that make sense?

> 
> >  	/* set queue affinity mask */
> >  	cpumask_copy(queue->affinity_mask, mask);
> >  	rc = irq_set_affinity_and_hint(queue->irq, queue->affinity_mask);
> > @@ -256,7 +261,7 @@ static void ibmvnic_set_affinity(struct ibmvnic_adapter *adapter)
> >  	int num_rxqs = adapter->num_active_rx_scrqs, i_rxqs = 0;
> >  	int num_txqs = adapter->num_active_tx_scrqs, i_txqs = 0;
> >  	int total_queues, stride, stragglers, i;
> > -	unsigned int num_cpu, cpu;
> > +	unsigned int num_cpu, cpu = 0;
> >  	bool is_rx_queue;
> >  	int rc = 0;
> >  
> > @@ -274,8 +279,6 @@ static void ibmvnic_set_affinity(struct ibmvnic_adapter *adapter)
> >  	stride = max_t(int, num_cpu / total_queues, 1);
> >  	/* number of leftover cpu's */
> >  	stragglers = num_cpu >= total_queues ? num_cpu % total_queues : 0;
> > -	/* next available cpu to assign irq to */
> > -	cpu = cpumask_next(-1, cpu_online_mask);
> >  
> >  	for (i = 0; i < total_queues; i++) {
> >  		is_rx_queue = false;
> > -- 
> > 2.43.0
> > 

