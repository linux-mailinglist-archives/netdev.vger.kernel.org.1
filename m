Return-Path: <netdev+bounces-152360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B67849F3A1F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 20:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC7D16C8CC
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 19:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D9F2063F7;
	Mon, 16 Dec 2024 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfb/Wup2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D648161302
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378408; cv=none; b=FrxFEL3f/I0gSkUUWhq1fs2zA6UOYUNghgSM4Jetow36ZkZoANreb8+KFSNSSsx/UoFBprfs9rR92dymEG37H+U0h/5aKldoNiHNjSItnlSa7WGObaa5QKl5e2cXz+T93Te05u1RuwvqxghybqMHJw7cY35ajsAp8I349fhzBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378408; c=relaxed/simple;
	bh=ioP7Lw038XZDV20hcGzrQGjfCSKyjOjb+sN/MeKzHA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WM5ojOhlofcdIkNXWn4hGHelpH35uPYq0oIce8+CqjKITDNWQ4L64GhKysxwSPJJ5jhRYEhOSMyE0fRk5n+Dgs8gom9/xjh7WnKD+yUghdHJ3bS6G2blCTjdmnz5ahB67NcDgLUv7pNg1dwiTyBBzPOXq40wNx9GPxN16Y/4KY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jfb/Wup2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43637977fa4so1891095e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 11:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734378405; x=1734983205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLy7G1MinRyUFdLaysX7W+iEnX/wIoGK4esywMdgnOQ=;
        b=Jfb/Wup2wNJROoPoPVlmoYaDUVPgIfij7uijDucmvekJ0+PEhg6iFSW2LzByCOuTFc
         rhHyR/ENzH49mIjXW+uKISDkqaHJ6z4NQDe6sWxfC5cNFalkJZrC2Yeys15UaIpqHVOr
         SNUJp3BpWucg8/F+Wkq+HGjaRIx2CNk8uEkNrb1Dk9+8hkDpzyF7CN/MMX3/1ntralvt
         LrCgEMbiiHASoH3mUgkSPZlSUOeayLaAPpRofn+ZBmDnA3r7lxpWWpE1EMKSzRbXIlk9
         qSMxNep6VysJvhHxpl2WE7VK8JkyovPQPtsS91NMbLxmil2k4l3kfWsYZ6G1XhPVzfQe
         HgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734378405; x=1734983205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLy7G1MinRyUFdLaysX7W+iEnX/wIoGK4esywMdgnOQ=;
        b=RBBIWdsWOV/OU0htmWyTc7q64ua30gJRm2yUU4trnFLdPLT4+jAaz+bhxE+duCn00U
         9GeazxPxOL5xYiVK27RwVsR6Dv5OlrLKS7wdbN/T5kXko0Svx2dAJYa+JB2ZDuuVrgXj
         bABFRMv5FjznkIWUEBEFF94vrjnI2P8pkG7G4w4tR82rqIQ1eIjnfs3dONjRQtI6e6Xn
         mTVBkbMcdRX9qoUE02CqBX/WzKkoGIju+WNleBBHxZa63+22leIyQj7w42ezXPY/S4Fz
         TrTA8IKlnPdKMI/9mV7fhs/ZUXK8Vlk2MFBt+OqbYtl19GhPlV2Qr6Q1V6De5aM99OKI
         2Lmg==
X-Forwarded-Encrypted: i=1; AJvYcCVbZtMGrS908RFLDIbOe4N8SckFAL89YjIfHTnIcxjajjH0C+reLhWS0tUnh7dBp7hOB+G1JYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0poFLH0+EuDGp1LFN+9AziZuP+2jrgmPLWlvM1mwplRbh1Tg
	CLsrONmUs7Mys+2YJpgmr3om989b4KVIIW4RfixvPOiyATEDJA+q
X-Gm-Gg: ASbGnct138IZDFuiATrweawuX0p8H9XXETSJVtKZB+W/xjNp8xtWNCLykbcoMYYQYuS
	HHuQXx2zWJaF0zbYMM9V2A+minRMtYHpg0ne7POzf/PROcHv/RnyCZsrhHpQE3uxvBi1yuI38Vp
	Hx3a3Ioso2e4PDlmrro1Ub4dvLILt2IoKAbZ4MMKKQutiZfWUWfCd9wdtiOsJMHc5SpfibT1j+2
	loghnD/MsbXlH5QZqVXMPJBbx2JiOaHw0a2m2Nr1zWu
X-Google-Smtp-Source: AGHT+IGTe6Bqwf4u4Sc4McC3uETMPXclgqlQMZI5IKk+3saFCp+5FydkXp43eXh/d29A0aaXmuoOtg==
X-Received: by 2002:a05:6000:799:b0:386:3213:5b78 with SMTP id ffacd0b85a97d-38880ac18cbmr4254702f8f.3.1734378404555;
        Mon, 16 Dec 2024 11:46:44 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801626asm9033965f8f.29.2024.12.16.11.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 11:46:43 -0800 (PST)
Date: Mon, 16 Dec 2024 21:46:41 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <20241216194641.b7altsgtjjuloslx@skbuf>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <20241211154109.dvkihluzdouhtamr@skbuf>
 <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2B5DW70Wq1tOIhM@lore-desk>

On Mon, Dec 16, 2024 at 08:01:33PM +0100, Lorenzo Bianconi wrote:
> Considering patch [0], we are still offloading the Qdisc on the provided
> DSA switch port (e.g. LANx) via the port_setup_tc() callback available in
> dsa_user_setup_qdisc(), but we are introducing even the ndo_setup_tc_conduit()
> callback in order to use the hw Qdisc capabilities available on the mac chip
> (e.g. EN7581) for the routed traffic from WAN to LANx. We will still apply
> the Qdisc defined on LANx for L2 traffic from LANy to LANx. Agree?

Not quite, no.

ndo_setup_tc_conduit() does not have the same instruments to offload
what port_setup_tc() can offload. It is not involved in all data paths
that port_setup_tc() has to handle. Please ack this. So if port_setup_tc()
returns -EOPNOTSUPP, the entire dsa_user_setup_qdisc() should return
-EOPNOTSUPP, UNLESS you install packet traps on all other offloaded data
paths in the switch, such that all packets that egress the DSA user port
are handled by ndo_setup_tc_conduit()'s instruments.

> > How does the introduction of ndo_setup_tc_conduit() help, since the problem
> > is elsewhere? You are not making "tc qdisc add lanN root ets" work correctly.
> > It is simply not comparable to the way in which it is offloaded by
> > drivers/net/dsa/microchip/ksz_common.c, even though the user space
> > syntax is the same. Unless you're suggesting that for ksz it is not
> > offloaded correctly?
> 
> nope, I am not saying the current Qdisc DSA infrastructure is wrong, it just
> does not allow to exploit all hw capabilities available on EN7581 when the
> traffic is routed from the WAN port to a given DSA switch port.

And I don't believe it should, in this way.

> If we do:
> 
> $tc qdisc add dev lan0 root handle 1: ets strict 8 priomap ...
> 
> in the current upstream implementation we do:
>   dsa_user_setup_tc():
>      ...
>        -> ds->ops->port_setup_tc(ds, dp->index, type, type_data)
>           (it applies the Qdisc on lan0 configuring the hw switch)
> 
> adding the ndo_setup_tc_conduit() callback we have:
> 
>   dsa_user_setup_qdisc()
>     ...
>       -> conduit->netdev_ops->ndo_setup_tc_conduit(conduit, dp->index, type, type_data)
>          (it applies the Qdisc on EN7581 mac chip for the routed traffic destinated to lan0)
> 
>       -> ds->ops->port_setup_tc(ds, dp->index, type, type_data)
>          (it applies the Qdisc on lan0 configuring the hw switch)
> 
> > Also, flower is a classifier, not an action. It doesn't mangle packets
> > by the very definition of what a classifier is.
> 
> yes, but goal of the series is the Queue scheduler offloading, not
> classifier/action. Agree?

Classifiers + flowid are an instrument to direct packets to classes of a
classful egress Qdisc. They seem perfectly relevant to the discussion,
given the information I currently have.

> > Can't you do something like this to guide packets to the correct channels?
> > 
> > tc qdisc add dev eth0 clsact
> > tc qdisc add dev eth0 root handle 1: ets strict 8 priomap ...
> > tc filter add dev eth0 egress ${u32 or flower filter to match on DSA tagged packets} \
> > 	flowid 1:1
> 
> If we apply the Qdisc directly on the conduit port (eth0) we can just apply the
> queue scheduler on all the traffic egressing via the DSA switch while I would
> like to apply it on per DSA port basis (but using the mac chip hw capabilities),
> got my point?

We need something as the root Qdisc of the conduit which exposes its
hardware capabilities. I just assumed that would be a simple (and single)
ETS, you can correct me if I am wrong.

On conduit egress, what is the arbitration scheme between the traffic
destined towards each DSA user port (channel, as the driver calls them)?
How can this be best represented?

IIUC, in your patch set, you expose the conduit hardware QoS capabilities
as if they can be perfectly virtualized among DSA user ports, and as if
each DSA user port can have its own ETS root Qdisc, completely independent
of each other, as if the packets do not serialize on the conduit <-> CPU
port link, and as if that is not a bottleneck. Is that really the case?
If so (but please explain how), maybe you really need your own root Qdisc
driver, with one class per DSA user port, and those classes have ETS
attached to them.

