Return-Path: <netdev+bounces-120591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DFE959E98
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FE32834E6
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB16192D90;
	Wed, 21 Aug 2024 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mamsNsDv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D7196C86
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246769; cv=none; b=U921eU4HheN+VC3SsbBI7iQVUiCYOBBlaUsHUVjhO5GK1VgXN0gbxlEBDF8BmZWvsI3giWwYGda7B7629u6Hmk01fMcgU5Ndm98ACKnaTBi4lNWkD4quhWR6M1YllNbTIFcTUqxbRWXmgNZeTCVciP9m9EC9peahDMd+BKjuudQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246769; c=relaxed/simple;
	bh=uB6l2qA644Qvz5iw9yueUj3dh8aLOpKegsDXd70dPCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCNRyE13TXAuDe2gKE0T2ZfBwPEEfoOgrC82F8UFybMtYtDbuCX9Bn4/6UmqllzQOLM/IQS+pvpTJY6W9cgdUis7ehB6kcddgX1VYCerWwLJiGCttzEafJ8QW0dFfPjHPS8FRxjbUv+6b5bMpqdCKq+SIlbb48s9ApO/vXCBumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mamsNsDv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d3c05ec278so4699849a91.0
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724246767; x=1724851567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=izAZlKs3Y2RGKb64FPkDsSdJcYsJKDXkxfcAGQrQRis=;
        b=mamsNsDvmPUugbVqNN735+odSiuQoO4JM2nd4W0FjVJViS0OZxcMnVWQK6CxIIfDwn
         q/qoOAJHmw/RYtcZRK6MXr28ZPl8LZXDHxmzvT71i/OWo/W8mbgBoGAb7iRIdHxABOCO
         Je2benWkaZkStHGxjIpYNa3gIm6rUEOqXoGZFZA0qb7QjZ6nVQrgAGp59aawq6ytP+dc
         +xXJbGn2UZSEOs0lE/gFDmPLjOU9nZcDSTQxNT13y3l1dQrNuCjK1ajzjp0qOdRosYo9
         uBvwFWZNqomgwbJXWCf0vzLu1v8B4XNNSHZmDVaEO3pVZKVrHlCXJv/j2tPP2neopJaj
         OhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724246767; x=1724851567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izAZlKs3Y2RGKb64FPkDsSdJcYsJKDXkxfcAGQrQRis=;
        b=Q1GtdSeoHOwDvHZT4Yf4NT658nJ1RENxZjVOuT2nvalfOE/RsEZaGFq3xqsng6eO2S
         NbpgpZd6Udm6Dr5MXvpbBhG/aCC6nx17CGJu+MiPaPNl/ZP8lTo4/r4ODzlbY6H6jU7k
         NGmTuLn+xrArOn+k51k2PnHAB3T0HhVcWWS/tUO6DVcDewsD7ef1G3nOYpfUgBZ2qJe4
         kirzk5+1ZjPRu6u4VdFD3XsPqdTzaxJs+ijWqB3DDNkcccAh8kGOQL9R/0jCPH6V0db1
         rtQZGeoIDuqsesqpI9Zdmq4IlVRdPmNvBr/ENdEFKNmBepewNqubwyjQ1bnukC5VDj5s
         3f1w==
X-Forwarded-Encrypted: i=1; AJvYcCUDHs7ZwL/AoUytBixuiZbaqi5KZ4O4s1SUKvgeK1bjzA/MkyfHcrfWEWaB1WPahTvsr57STu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjkFUikVKzpIdVXB2xVc+dWIxqx2luT84bP379/tWCB1d4W+RA
	S9S4UJtyeJG/m0pJQNq5QMoRmk+cYPbniyyM3FYjfHGyK/TkFJxe
X-Google-Smtp-Source: AGHT+IHHXbzHhCtmJHg9uziDcOT5GJI8bwifEpCoM3cvgbI7dio3FN/3cAY72i+o/eF+o/x2SXDODQ==
X-Received: by 2002:a17:90a:dd85:b0:2c8:81b:e798 with SMTP id 98e67ed59e1d1-2d5e9da9ccdmr2292379a91.30.1724246766801;
        Wed, 21 Aug 2024 06:26:06 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba2e44bsm1792942a91.13.2024.08.21.06.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 06:26:06 -0700 (PDT)
Date: Wed, 21 Aug 2024 21:26:00 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <ZsXq6BAxdkVQmsID@Laptop-X1>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
 <ZsXd8adxUtip773L@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsXd8adxUtip773L@gauss3.secunet.de>

On Wed, Aug 21, 2024 at 02:30:41PM +0200, Steffen Klassert wrote:
> > > +/**
> > > + * bond_advance_esn_state - ESN support for IPSec HW offload
> > > + * @xs: pointer to transformer state struct
> > > + **/
> > > +static void bond_advance_esn_state(struct xfrm_state *xs)
> > > +{
> > > +	struct net_device *real_dev;
> > > +
> > > +	rcu_read_lock();
> > > +	real_dev = bond_ipsec_dev(xs);
> > > +	if (!real_dev)
> > > +		goto out;
> > > +
> > > +	if (!real_dev->xfrmdev_ops ||
> > > +	    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
> > > +		pr_warn("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
> > 
> > xdo_dev_state_advance_esn is called on the receive path for every
> > packet when ESN is enabled (xfrm_input -> xfrm_replay_advance ->
> > xfrm_replay_advance_esn -> xfrm_dev_state_advance_esn), this needs to
> > be ratelimited.
> 
> How does xfrm_state offload work on bonding?
> Does every slave have its own negotiated SA?

Yes and no. Bonding only supports xfrm offload with active-backup mode. So only
current active slave keep the SA. When active slave changes, the sa on
previous slave is deleted and re-added on new active slave.

Thanks
Hangbin

