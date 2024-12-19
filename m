Return-Path: <netdev+bounces-153394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF79F7D4B
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DA81894CCD
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9967C2253E2;
	Thu, 19 Dec 2024 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ammv515O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD472253EC
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619335; cv=none; b=WYbuBD0syt+WZm4qfZiGOc0N5cnyGZp0Bdg8c6NoV2Bt69XT9N/XvpWmLDpvQk5kL6imLB3JrL8MIa8mVKg0Xkb8Dg1we2NJR9L6juLOJHQlx+MqP2/YqqVa8N4ZgJiLHWKaafjptiXBknCB6KXfdUS2PzpDe0RRZp81cCYDBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619335; c=relaxed/simple;
	bh=/tOijhdV0VmrGrhon/6ga5/4+xoOYjX4ZKgNBz9b9e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/VySaws2XYfMxgxhoeJKoq6DJh94LWgFISD/bks3rJcXck+YB45aLT/C/OHtzGD6Afmb+2LN0FwT4epFC8OlZTlpzE0T42AJVzFe9pMeQrUdQE5sJ2DRqT+qLoqwq1VERuc42bXW/55DWxRPuYcveiSeP7Qeqc/VF98kh8UEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ammv515O; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434f398a171so1253425e9.2
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 06:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734619332; x=1735224132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ2nOg2dfpWqUt6elpjol266IyrPwg8XgenoY3QoROM=;
        b=Ammv515OF7jk0JAiTetwUBUyMofZ7hGiWwEGexcS2430VuIqJ5Za9gDAx6eUtDB6y2
         K1qM/Q1snC5YiW+HBjfVsvrozJCc4Whs0LACBh7Zt0HuZgmq7mG7TYoW9HyI5IvgkvK+
         l7xoeXkRgpSwBPEhasVfir0aeYadtVqgSK19L5Mp3qcJs3FAeI3ewZzt4gxPDRi896qk
         EsSdE5RFSLTbUI2po4aHFNorTgD4M6BCMgDsBt09qQ1t6ZQLRO0z1loUXddhR/GMdGlq
         LPs3SuSBkmX6C/HrXn2Pz3NxmQjb2jO+5Qqq288Vco8zs+B2R69DWp4hZqEg4bzCE9sk
         3ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619332; x=1735224132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZ2nOg2dfpWqUt6elpjol266IyrPwg8XgenoY3QoROM=;
        b=p4NzptQD+U75THA/sUZgWPAninHl6XHhOG5hh5BjAG43NMAfPL5lnyxCN3ZlR+KfOa
         PS+z+C+dUh4wtj/Bf7T9qHclWBAD9th6BsKUoWQtQIfNgZk3I6cT+HHDwdyJdd+Wvks1
         DJBddBCMWZXcpKJVEUle0NuiIZZALT7uZSQuMJr6+pvJEb95fIMFIUedPYolSy1+hgcS
         zjH+af01GIn1kNfczbG43UBXbCdo7zi3xrasZHjxhPzbBXWBeQd6UuEZKMFjEgUoqMz2
         SkXqJoc3bozA952kXCpHJ8yo5bXblJPMJCFNAKNj4FjoEX5G8x1qFdIXlyZPUwUMCUdA
         aL+w==
X-Forwarded-Encrypted: i=1; AJvYcCXHmEaKVhMYOhiPCpcHOMDnhlGsR52IQV7mi1vvGZaecyKzvnLld0gX7aLawj9anN79y3p9T7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFr+PC7JzXK2TS281U58sqGPfGy4jpT+CDff3RhUJzyVFRSt/
	yIjGu2TgRJ2hWSSGSSuCIyAspnbBJGd6DVCfGxuzknMCPVGnrivJ
X-Gm-Gg: ASbGncvQGlq9H2RIdjn352QaEMpQrOJb55FJ5BBaDciDSEdyvAnS4A+fjR111AJNYgX
	agkmILH78i6i3pmXvEoACXj/vezxwjKehgZ62FSnyWjZ71DQtMCnaubEMvplX/oFJ8GvewnzqAa
	vTUI0YZsf/HCvGgFxMrY4KDU6CFTDS3dLTUiPQLNwC0nk9onuOK67BZHYCrgOtpqiZ4AyVPwiOe
	i9NN8DdRKZWVosV2Nk7W/2IQ14y7z6tldRnhCzBR7NS
X-Google-Smtp-Source: AGHT+IFIY/8QNNjWECKHZNq7YOm+J84/tzg9QCxmTNDW/RTmk7rWduXMtSQINE0ZnqZcKJv+4fFAyw==
X-Received: by 2002:a05:600c:310f:b0:434:f335:aa0d with SMTP id 5b1f17b1804b1-43655349166mr27901685e9.2.1734619331927;
        Thu, 19 Dec 2024 06:42:11 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b119b6sm55107335e9.22.2024.12.19.06.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 06:42:11 -0800 (PST)
Date: Thu, 19 Dec 2024 16:42:08 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com
Subject: Re: [PATCH v2 net 4/4] net: dsa: mv88e6xxx: Limit rsvd2cpu policy to
 user ports on 6393X
Message-ID: <20241219144208.dp7pfbh566htfc4v@skbuf>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219140541.qmzzheu5ruhjjc63@skbuf>
 <875xnf91x8.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xnf91x8.fsf@waldekranz.com>

On Thu, Dec 19, 2024 at 03:34:43PM +0100, Tobias Waldekranz wrote:
> On tor, dec 19, 2024 at 16:05, Vladimir Oltean <olteanv@gmail.com> wrote:
> > It looks like an oversight in the switchdev tx_fwd_offload scheme. Can't
> > we teach nbp_switchdev_frame_mark_tx_fwd_offload() to make an exception
> > for is_link_local_ether_addr() packets, and not set skb->offload_fwd_mark?
> 
> That sounds like a better option if it is acceptible to the broader
> community. I thought that this might be a quirk of mv88e6xxx's rsvd2cpu
> bits. But if more devices behave in the same way, then it would be
> better to just exempt this whole class from offloading.
> 
> Do you know how any other ASICs behave from this perspective?

The other driver with tx_fwd_offload, sja1105, is going to drop any
packet coming from the host_port which isn't sent through a management
route (set up by sja1105_defer_xmit()). So it's more than likely bugged.

We can't fix this from sja1105_xmit() by reordering sja1105_imprecise_xmit()
and sja1105_defer_xmit(). It's not just the order of operations in the
tagger. It's the fact that the bridge thinks it doesn't need to clone
the skb, and it does.

So yes, it's probably best to exclude link-local from skb->offload_fwd_mark.

