Return-Path: <netdev+bounces-153378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2919F7CCD
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4B3161C51
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDCF2253ED;
	Thu, 19 Dec 2024 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnvOMPbI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AD3224AF7
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617148; cv=none; b=Ir86zlKWh7E7sWJ3uci0GuY3tThLgf9w+/eSOqUe/DigmogJLUKg1QGbiZW5mSzszuWE68GEAIA0QRHpZT9MVZ82NYEa6UwgHm0cHfyy1Qd0mBGXsjhM6lirLGMDwQaLfEX52HN/iEMPFfaEIeTWVK2VzKDgzsnkYUqWYYOpdds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617148; c=relaxed/simple;
	bh=J4JIg8c7TLLtZwHomusVgchMc16scxcHnbRFolDuzJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=but7zNptTHm4ACGmxl25HVtrRux5OdFWiROze1CLYfonlzJ4wz9TKgz63HsJxS0usB2uYYrGbW/+KZ/QNmSGvoxHLBujwLLDINXHeRj8KJ5Y8Tot37yYK2OGFIihvaVloEFDmyj74j/svj/N/xKUQoIO/6SxIR8t0Qq55t5pFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnvOMPbI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862a999594so33160f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 06:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734617145; x=1735221945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtXNKmzDehZwpVJC21KqNjR2sCn5ZrbtX9TMaSzw3VY=;
        b=LnvOMPbI9OwD88hQ38VH00OcxQ8Q91LBVsN5ymJw3oRVku8BD2RyBlg8B/30lGBcGp
         544HikCIFfzQNbzPZJIoPQarQwjT6wrmyANgtqIY4CacC7BYFcnXImSBYLKLFQFjcDwQ
         03UVGy+/R3ExQ4C0EfEpiv+7q844JPCSkADW4DbznKDnEd2fKT4V32gMJU6QKi61GYLQ
         eQHR16dIEWr86CSfyANCui7iC25l12Y30FB1Vs1Uct1yLZntac+yFTj7OdOZtJdv5YyN
         y/esrm//GQ5uxDjy5vIYtRLnsQVilwJxExCDNrHu+yha1deOB6AOEYoGHHkzrYz8FEHA
         mZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734617145; x=1735221945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtXNKmzDehZwpVJC21KqNjR2sCn5ZrbtX9TMaSzw3VY=;
        b=Ro9A7jvOJLnD25YuBwXtJIoqDYi5PD6aAXPBEpMG/wpfN93RmigriKRztFNgvlQTiv
         yL+Vi4cFTQtfLtYkfzuc3omDYcJLuxMrzrc2NIVB8cAmu9cq3slDujuRt4uSxCFBhTqp
         Lpv9prgvzOsNKbNdBUHtTSr3jAatoQWRnr9eQ1rukw8XyIDGhhdY6VNQhnerCVSWkm+b
         UHoRK1b9v6dx/uxbncRjuB7JW+WwHYSHBYLmEvCwKm4kASS8xkbgYt30RIiCbzLWN2z2
         Eot2dOpiEmYQm8kRCEEP3IM8YeXV35E6s2K939Me3oeDxRJX/0UUa5MCwb9t5ZgwAxLb
         qfNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxI6R1l8omyY0Razt+0YqA/eP+eVAqOtsl/G2NTegMwWKnHuJPhkVvz7cdZwoHZ2vthijppUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQgRAMTxc0ihujJM4ctltBsk2ViOpDFO7QHbMtmGIyBlY39Wm
	X5Y/BVzGyGiwRkGsn+qv8RkmducU+rodctCJ4rssxxL41OnQ/CI++Nhx18Hp
X-Gm-Gg: ASbGnct3xX2DCDXGRu2kr/E6QBp83nUJ+iGJRwnlbV3mYHU9datak2A2uf4AfrYB8fI
	w6J2drt1KPggYtN/Ynjeq3kncg0Z0yklk/hhSXSzRqrhEu94Wh1kHacwkeQlgXvqhzlN5coFK9e
	s1OOrNdPecSHYytHnW1TKHef/ZenWXtR79BmBMlyJ1KwdzNCbWytrUxEoktgJ1RoEgXEbIvuV9j
	+A4yLEhlm7A1ATUHGPwUnxHLL+1Aj5b/X8wunuhHGvZ
X-Google-Smtp-Source: AGHT+IFDd30rUBj8nLpmRZiMcT/yUyc3dEV+ewV28KhXJ7MBcwaUVBJl8pvWAmp2wwFkK2byQqkMtg==
X-Received: by 2002:a05:6000:4b0a:b0:385:df17:214f with SMTP id ffacd0b85a97d-388e4d8ab2cmr2232229f8f.9.1734617144626;
        Thu, 19 Dec 2024 06:05:44 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c515sm19089595e9.30.2024.12.19.06.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 06:05:43 -0800 (PST)
Date: Thu, 19 Dec 2024 16:05:41 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com
Subject: Re: [PATCH v2 net 4/4] net: dsa: mv88e6xxx: Limit rsvd2cpu policy to
 user ports on 6393X
Message-ID: <20241219140541.qmzzheu5ruhjjc63@skbuf>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>

On Thu, Dec 19, 2024 at 01:30:43PM +0100, Tobias Waldekranz wrote:
> For packets with a DA in the IEEE reserved L2 group range, originating
> from a CPU, forward it as normal, rather than classifying it as
> management.

Doesn't this break STP? Must be able to inject into ports with an STP
state other than FORWARDING. I expect that you need a DSA_CMD_FROM_CPU
tag for that, can't do it with DSA_CMD_FORWARD.

> Example use-case:
> 
>      bridge (group_fwd_mask 0x4000)
>      / |  \
>  swp1 swp2 tap0
>    \   /
> (mv88e6xxx)
> 
> We've created a bridge with a non-zero group_fwd_mask (allowing LLDP
> in this example) containing a set of ports managed by mv88e6xxx and
> some foreign interface (e.g. an L2 VPN tunnel).
> 
> Since an LLDP packet coming in to the bridge from the other side of
> tap0 is eligable for tx forward offloading, a FORWARD frame destined
> for swp1 and swp2 would be send to the conduit interface.
> 
> Before this change, due to rsvd2cpu being enabled on the CPU port, the
> switch would try to trap it back to the CPU. Given that the CPU is
> trusted, instead assume that it indeed meant for the packet to be
> forwarded like any other.

It looks like an oversight in the switchdev tx_fwd_offload scheme. Can't
we teach nbp_switchdev_frame_mark_tx_fwd_offload() to make an exception
for is_link_local_ether_addr() packets, and not set skb->offload_fwd_mark?

