Return-Path: <netdev+bounces-152416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ED59F3E12
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 00:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABCA718839B1
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 23:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2D01D5CF2;
	Mon, 16 Dec 2024 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDIEpBSx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577601D5ADB
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390799; cv=none; b=mwh4tA+a1guL7i2dDvE/UBeB81L2cLb3vbEXIcRPbdnODc+LMUU8CsRZ0NvoxZW3luAPylUY9DhjWj4ucMXWjpIsHbxCtn6wFdQyRWTI8ajmtaKdmARCEH/yrA7tBl5JW5CnIPrf7D01++sltGgeGauGM9KVxoC8f+Wbi+6+NN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390799; c=relaxed/simple;
	bh=oOH2KyIRjm64Z/I+MYirMj8ITm4djt7zGL3X1xebpeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUBT+s53KQd0fxnbKhe4goDg00Znd6CkwGTVcZGGS0P/SC7RQHI7CzbZXA0rYAqEQH6eVxl2id700sJ3+Tm1aE0/14K/N5k+Mbmpl41A/mjbvMbJxxJcyWlU9i5YjEfSS/z3sEEKe0b+iw7Dr0VmmUxE4nFzOIj2MgH+p2lWcnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDIEpBSx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa680fafb3eso74152366b.3
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 15:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734390796; x=1734995596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vh6DaEXjnTn3l8gKn1It6UFgb6Qxo42X4kiCDFO7Zo8=;
        b=BDIEpBSxZqzalnpnnOlzUxTn3vfN7EtbYeQf1ZDw5+1wYu0gcx3oGBrMvkOSlZk+YP
         Y2GnVqpX/SxsfJRhlasDVXmfl93XLFROAmYjAvSJw8rgT6CtrjxMGGnBlBhs+/1bKIzX
         CYIzyBmRYK5/dxqOHSmuEp47Unz8Rlj3bpZoGI4EExpkaZH/szkM7t2tYm23K0wM/TCJ
         JOgLMew6QFFNh5m6hEr/fKdCi1jsNiOxgchsYG5YzbLZetiG3oYcGryZIYuSNih4uNIL
         CvVihZBqEHUPr2aU9Xuw1xvcglhWt88hCtGAW2u6tIutIj4290kNZ4CGECj9iTjobJE8
         +yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734390796; x=1734995596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh6DaEXjnTn3l8gKn1It6UFgb6Qxo42X4kiCDFO7Zo8=;
        b=qJl07G687Qq7e7qx3odph46s/xyhwQN9k/aAVqr7JHjeTkJlz/uvx74NU9HUa9S5wl
         4/P9GxJKh5P3sorzgnQHVWX16reY1ws1wnBl5Nu3T038+PxfL51G5f9mMR4elHXCLUy+
         mFajUNMLJakSD2X4GAdPUByzOrUtpMjRzg331qcSPTdAQfMntQEe3Vj6b3w18N5+TF1K
         sZhlCiOrKQHcKRw1u/grkFxLBbl9+jv2Rq/2tlbvtJGfChZg+/G6xCzbfC/k1QxErlyR
         7QX0YecgY55QAcImVJmzWW0GEZH0DCjcTG7BZm3DYNUgGRiFgg4y+iLuD9gjVcbdJ+WF
         QTQg==
X-Forwarded-Encrypted: i=1; AJvYcCW53tJq0Bo0CXb3VFdwD9qTcDtxFbAt/ZLhBl+YLbJD+RSP+25dFLNi6KoeVXX8O5CcFeXBfmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq6gk3tKFqIdGCxyv9tBHaUtz/OwwHCcT3061PCsVZKMO/9YN4
	UC3Dz8zeQwgRpnrtx3ucBP1az1N6szFegs8R0ncE/O1SvFeANlIEwAbijyfO
X-Gm-Gg: ASbGncv/LvKysTqh2e8ckRzqcwsU5fvvo8pqIRlrB63sIRSYDwzM1E6T5Qq3aEzuVDj
	3WKLXybmf2hetfbhnRi1LtqjKJQOlZ7okBKEvmWq5T1Atak7pZdKiGq7OccNODKbx4AUKG09hae
	YrKUQV6g8PDjGJR/zCCXsiJ1/tD8JwcuP/aDJx/DeSLxUA9cEPXASqCvjQGdrNujo8rpClJx1x/
	bOjsR8TfRRP/iFreILwVsGk86EUBVTUR8uKu5fAP/Ud
X-Google-Smtp-Source: AGHT+IHqG6jafQJ54W4A+yXdR0VQhT67YmemEDKqVRQauVjzqpCIBRPWoUCDucAF6uWatI1faUZTOQ==
X-Received: by 2002:a17:907:c28:b0:aa6:9407:34e3 with SMTP id a640c23a62f3a-aab77e89c1emr508203466b.9.1734390795274;
        Mon, 16 Dec 2024 15:13:15 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963b33b0sm380460966b.184.2024.12.16.15.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:13:14 -0800 (PST)
Date: Tue, 17 Dec 2024 01:13:11 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <20241216231311.odozs4eki7bbagwp@skbuf>
References: <20241211154109.dvkihluzdouhtamr@skbuf>
 <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
 <20241216194641.b7altsgtjjuloslx@skbuf>
 <Z2CpgqpIR5_MXTO7@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2CpgqpIR5_MXTO7@lore-desk>

On Mon, Dec 16, 2024 at 11:28:18PM +0100, Lorenzo Bianconi wrote:
> > ndo_setup_tc_conduit() does not have the same instruments to offload
> > what port_setup_tc() can offload. It is not involved in all data paths
> > that port_setup_tc() has to handle. Please ack this. So if port_setup_tc()
> 
> Can you please elaborate on this? Both (->ndo_setup_tc_conduit() and
> ->port_setup_tc()) refer to the same DSA user port (please take a look the
> callback signature).

I'd be just repeating what I've said a few times before. Your proposed
ndo_setup_tc_conduit() appears to be configuring conduit resources
(QDMA, GDM) for mt7530 user port tc offload, as if it is in complete and
exclusive control of the user port data path. But as long as there are
packets in the user port data path that bypass those conduit QoS resources
(like for example mt7530 switch forwards packet from one port to another,
bypassing the GDM1 in your drawing[1]), it isn't a good model. Forget
about ndo_setup_tc_conduit(), it isn't a good tc command to run in the
first place. The tc command you're trying to make to do what you want is
supposed to _also_ include the mt7530 packets forwarded from one port to
another in its QoS mix. It applies at the _egress_ of the mt7530 port.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=23020f04932701d5c8363e60756f12b43b8ed752

Let me try to add some squiggles based on your diagram, to clarify what
is my understanding and complaint.

               ┌───────┐                                   ┌───────┐
               │ QDMA2 │                                   │ QDMA1 │
               └───┬───┘                                   └───┬───┘
                   │                                           │
           ┌───────▼───────────────────────────────────────────▼────────┐
           │                                                            │
           │       P5                                          P0       │
           │                                                            │
           │                                                            │
           │                                                            │    ┌──────┐
           │                                                         P3 ├────► GDM3 │
           │                                                            │
┌─────┐    │                                                            │
│ PPE ◄────┤ P4                        PSE                              │
└─────┘    │                                                            │
           │                                                            │    ┌──────┐
           │                                                         P9 ├────► GDM4 │
           │                                                            │    └──────┘
           │                                                            │
           │        P2                                         P1       │
           └─────────┬─────────────────────────────────────────┬────────┘
                     │                                         │
                 ┌───▼──┐                                   ┌──▼───┐
                 │ GDM2 │                                   │ GDM1 │
                 └──────┘                                   └──┬───┘
                                                               │
                                                ┌──────────────▼───────────────┐
                                                │            CPU port          │
                                                │   ┌─────────┘                │
                                                │   │         MT7530           │
                                                │   │                          │
                                                │   ▼         x                │
                                                │   ┌─────┐ ┌─┘                │
                                                │  lan1  lan2  lan3  lan4      │
                                                └───│──────────────────────────┘
                                                    ▼

When you add an offloaded Qdisc to the egress of lan1, the expectation
is that packets from lan2 obey it too (offloaded tc goes hand in hand
with offloaded bridge). Whereas, by using GDM1/QDMA resources, you are
breaking that expectation, because packets from lan2 bridged by MT7530
don't go to GDM1 (the "x").

> > returns -EOPNOTSUPP, the entire dsa_user_setup_qdisc() should return
> > -EOPNOTSUPP, UNLESS you install packet traps on all other offloaded data
> > paths in the switch, such that all packets that egress the DSA user port
> > are handled by ndo_setup_tc_conduit()'s instruments.
> 
> Uhm, do you mean we are changing the user expected result in this way?
> It seems to me the only case we are actually changing is if port_setup_tc()
> callback is not supported by the DSA switch driver while ndo_setup_tc_conduit()
> one is supported by the mac chip. In this case the previous implementation
> returns -EOPNOTSUPP while the proposed one does not report any error.
> Do we really care about this case? If so, I guess we can rework
> dsa_user_setup_qdisc().

See above, there's nothing to rework.

> > > nope, I am not saying the current Qdisc DSA infrastructure is wrong, it just
> > > does not allow to exploit all hw capabilities available on EN7581 when the
> > > traffic is routed from the WAN port to a given DSA switch port.
> > 
> > And I don't believe it should, in this way.
> 
> Can you please elaborate on this? IIUC it seems even Oleksij has a use-case
> for this.

See above, I'm also waiting for Oleksij's answer but I don't expect you
2 to be talking about the same thing. If there's some common infrastructure
to be shared, my understanding is it has nothing to do with ndo_setup_tc_conduit().

> > We need something as the root Qdisc of the conduit which exposes its
> > hardware capabilities. I just assumed that would be a simple (and single)
> > ETS, you can correct me if I am wrong.
> > 
> > On conduit egress, what is the arbitration scheme between the traffic
> > destined towards each DSA user port (channel, as the driver calls them)?
> > How can this be best represented?
> 
> The EN7581 supports up to 32 different 'channels' (each of them support 8
> different hw queues). You can define an ETS and/or TBF Qdisc for each channel.
> My idea is to associate a channel to each DSA switch port, so the user can
> define independent QoS policies for each DSA ports (e.g. shape at 100Mbps lan0,
> apply ETS on lan1, ...) configuring the mac chip instead of the hw switch.
> The kernel (if the traffic is not offloaded) or the PPE block (if the traffic
> is offloaded) updates the channel and queue information in the DMA descriptor
> (please take a look to [0] for the first case).

But you call it a MAC chip because between the GDM1 and the MT7530 there's
an in-chip Ethernet MAC (GMII netlist), with a fixed packet rate, right?
I'm asking again, are the channels completely independent of one another,
or are they consuming shared bandwidth in a way that with your proposal
is just not visible? If there is a GMII between the GDM1 and the MT7530,
how come the bandwidth between the channels is not shared in any way?
And if there is no GMII or similar MAC interface, we need to take 100
steps back and discuss why was the DSA model chosen for this switch, and
not a freeform switchdev driver where the conduit is not discrete?

I'm not sure what to associate these channels with. Would it be wrong to
think of each channel as a separate DSA conduit? Because for example there
is API to customize the user port <-> conduit assignment.

> > IIUC, in your patch set, you expose the conduit hardware QoS capabilities
> > as if they can be perfectly virtualized among DSA user ports, and as if
> > each DSA user port can have its own ETS root Qdisc, completely independent
> > of each other, as if the packets do not serialize on the conduit <-> CPU
> > port link, and as if that is not a bottleneck. Is that really the case?
> 
> correct

Very interesting but will need more than one word for an explanation :)

> > If so (but please explain how), maybe you really need your own root Qdisc
> > driver, with one class per DSA user port, and those classes have ETS
> > attached to them.
> 
> Can you please clarify what do you mean with 'root Qdisc driver'?

Quite literally, an implementer of struct Qdisc_ops whose parent can
only be TC_H_ROOT. I was implying you'd have to create an abstract
software model of the QoS capabilities of the QDMA and the GDM port such
that we all understand them, a netlink attribute scheme for configuring
those QoS parameters, and then a QoS offload mechanism through which
they are communicated to compatible hardware. But let's leave that aside
until it becomes more clear what you have.

