Return-Path: <netdev+bounces-151413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674C09EEA1B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389531676D8
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB14211476;
	Thu, 12 Dec 2024 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8EuWItT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878352080FC
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015981; cv=none; b=P6Auaysty+iT9nAr67kXzMBuBMWutfjdG8JzeBeEiN4SATxkeqCPhL+mMDd/zrOIm2kzRTWrvpXPZAVrj2WHqXwSnLSoEl3px8PFwvyPU4whb0YiQ50KMMhFd+rb+hN4kfAtKZsFEAtQ/EwwQyyWImqIGIXowfuQH097sWtaAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015981; c=relaxed/simple;
	bh=5URbwwsG9pto6x/IrUl8wAnLkIQt1yBTsO7yAEr6P2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpago3W5aDEo3mUBuadLa8QqFIDvyLQH6774upR9TWOqOSbj4QhsFj9yibCZ2FetqVlJoO+SQWipsyCXxmnRgpMgopxLnR953qB52GY3+WLXYJPDphA+oepX+LYzuMQCtDQ+zTa3KxyGm8/qlOU7/l/ffDBQtvm7UxPx/h/zCkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8EuWItT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa67bc91f88so11247266b.0
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 07:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734015977; x=1734620777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3X9RXZ5kaBuqnND7AIIIsHg5ne8BY/XG6TNoS8WiOA0=;
        b=N8EuWItTMLj7FAoMJRrNV2eENaN12lPQILO4gHjnvdkvSr01g8nR8gaS2EPo69ZEup
         pkUIizDwCxywVHvDEtmWN2rCs1U4t5VPL8huSCM5daUva9+hoJjaqmjO+iBp3BjxlmNV
         CXk3Bu/NC/J3OXf1wffnXOst3SOKsPIjB5RhYQ5R++e9aep6bsSo2ySI8vDZBZru1Tn/
         d/oUOQ0S5rTyaB6FHQfLf9ub1WPPLV1dSVNKKRRhKIk8CmDCdbc9q+wCp1EHNZ7ZH5v0
         JbTWU2A9hGHY0OSW5lic49P6Wq61+MGB7c1KHRYFsuzCAiNGlGfMdOT1bfQXR1ednn8/
         KqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734015977; x=1734620777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3X9RXZ5kaBuqnND7AIIIsHg5ne8BY/XG6TNoS8WiOA0=;
        b=vm44ctgVl89CUHiuCRo9yGLYWas19th0TyUBx8smfgsUDi8bTsllij13fsfjBpYwq2
         ngn5nkhGOIediG5rIfI+YStskf7qvwYDGp8UTyUu5u3rTOk4vKqgg7i0dJWigJ3qZbUK
         ZwDE+IcwsFeIXxJyJBk5lILhTVUxHFL8djKsKJk9ARTF54mtGXkJXEmvVkDxE6bE1Qg1
         q8yMHFXLTL3LuJr23EY6QbpVvo74E0H0Y8sL7mG/AvNrjL/6HcnctOj2wynIhw5S7ol3
         cadZmeemSXBIbPKoZ3n/J8IKaOBut7ZtdaEPnUGvSboglEqk967UNOVYxJnlAYAP0VJ0
         0zMA==
X-Gm-Message-State: AOJu0YxK6sw8aNkLN7KUf15tWgLPjL5O85qukz50jltksUMAp/BthT2t
	z49wQoOdVByikThizVzn3DLP1xzjaZ1KFhaVfxM+Rny2wUPAoSQf
X-Gm-Gg: ASbGncsxCERrNsGajnKLv4ORZ3WjtUYJQ2XX1Difh4k3cVUdVUg/uE7lXqJ3CfdgHZc
	Q/X6y2d6Id9Kjxprj80tvK4genWLfGmlvToUkQDlXc/tDsL30a5pGjA4uzNwxjMX4Y0epZjTkW2
	Jh0ZlIcx8C8wLVnoEXMpKcDTMLuyU4a4FKu6Fo1p4BMZa16OwrGgpaLylxi0aP/vz7A2W6fFGxf
	Hrj/92NP1nlf9BEvJwBiSsez/AlWIWtZro2IU9VTutt
X-Google-Smtp-Source: AGHT+IFXvOKogdYXBf0tSnXoAJsDqtqCCxrYnjkKv25vtP7nEldA5VbCFhzWzNTIO0xzXcbhrLjR8Q==
X-Received: by 2002:a17:907:3f2a:b0:aa6:8dd8:8152 with SMTP id a640c23a62f3a-aa6b134ed58mr299305066b.10.1734015976359;
        Thu, 12 Dec 2024 07:06:16 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a58ee6basm370077566b.119.2024.12.12.07.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 07:06:15 -0800 (PST)
Date: Thu, 12 Dec 2024 17:06:13 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <20241212150613.zhi3vbxuwsc3blui@skbuf>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <20241211154109.dvkihluzdouhtamr@skbuf>
 <Z1qqrVWV84DBZuCn@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1qqrVWV84DBZuCn@lore-desk>

On Thu, Dec 12, 2024 at 10:19:41AM +0100, Lorenzo Bianconi wrote:
> > Hi Lorenzo,
> 
> Hi Vladimir,
> 
> > 
> > On Wed, Dec 11, 2024 at 04:31:48PM +0100, Lorenzo Bianconi wrote:
> > > Introduce support for ETS and TBF qdisc offload available in the Airoha
> > > EN7581 ethernet controller.
> > > Some DSA hw switches do not support Qdisc offloading or the mac chip
> > > has more fine grained QoS capabilities with respect to the hw switch
> > > (e.g. Airoha EN7581 mac chip has more hw QoS and buffering capabilities
> > > with respect to the mt7530 switch). 
> > > Introduce ndo_setup_tc_conduit callback in order to allow tc to offload
> > > Qdisc policies for the specified DSA user port configuring the hw switch
> > > cpu port (mac chip).
> > 
> > Can you please make a detailed diagram explaining how is the conduit
> > involved in the packet data path for QoS? Offloaded tc on a DSA user
> > port is supposed to affect autonomously forwarded traffic too (like the
> > Linux bridge).
> 
> I guess a typical use case would be the one below where the traffic from the
> WAN port is forwarded to a DSA LAN one (e.g. lan0) via netfilter flowtable
> offload.
> 
>             ┌─────────────────────────────────┐             
>             │               BR0               │             
>             └───┬────────┬────────┬────────┬──┘             
> ┌───────────────┼────────┼────────┼────────┼───┐            
> │DSA            │        │        │        │   │            
> │               │        │        │        │   │            
> │ ┌───┐      ┌──▼─┐   ┌──▼─┐   ┌──▼─┐   ┌──▼─┐ │       ┌───┐
> │ │CPU│      │LAN0│   │LAN1│   │LAN2│   │LAN3│ │       │WAN│
> │ └───┘      └────┘   └────┘   └────┘   └────┘ │       └───┘
> └──────────────────────────────────────────────┘            
> 
> In this case the mac chip forwards (in hw) the WAN traffic to the DSA switch
> via the CPU port. In [0] we have the EN7581 mac chip architecture where we
> can assume GDM1 is the CPU port and GDM2 is the WAN port.
> The goal of this RFC series is to offload a Qdisc rule (e.g. ETS) on a given
> LAN port using the mac chip QoS capabilities instead of creating the QoS
> discipline directly in the DSA hw switch:
> 
> $tc qdisc replace dev lan0 root handle 1: ets bands 8 strict 2 quanta 1514 1514 1514 3528 1514 1514
> 
> As described above the reason for this approach would be to rely on the more
> fine grained QoS capabilities available on the mac chip with respect to the
> hw switch or because the DSA switch does not support QoS offloading.
> 
> Regards,
> Lorenzo
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=23020f04932701d5c8363e60756f12b43b8ed752

Explain "the mac chip forwards (in hw) the WAN traffic to the DSA switch
via the CPU port". How many packets does airoha_dev_select_queue() see?
All of them, or only the first of a flow? What operations does the
offload consist of?

