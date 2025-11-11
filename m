Return-Path: <netdev+bounces-237678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C906DC4EAC4
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 723BD4FF9A1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3C530FC15;
	Tue, 11 Nov 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6jrN+0X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5625C818
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873023; cv=none; b=OgwiL7jcSggtecoGyztldHAeYO+rPO91tWx+A3YlBFnb8DA3VBCmIpg/QnVZBy+pF7mq6LOzCpPjfAllyL1ZRo5zpLl4AcXTScdhtqYn31a4XXAWSxhqB8DZUv5vzXXaZQYDrymKs6P3/gtj7JhwmqP71+feB7lEVeJWLCUIXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873023; c=relaxed/simple;
	bh=vKLyZ1/WPsSmzpJ2BPEEFpoo3aKBulZYZQJo6Fa1tqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFMpN3RY6t4Mqf/RLeDckQcSz7/t5RQtnpQEBYKUqv71mtuNBwwEOI2QoBtx4F6hd60M+46r2JozKvnlHqS7aNfcsW93i80OF/8JC9MQlMMT/K4LImQ3vS0ZMMWwTcS8/Al49aWncDIlZ8TudE5ZRFNaTjyuKJOX/IJUp9SyRDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6jrN+0X; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47776c366ccso2204495e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 06:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762873020; x=1763477820; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UHlTUvZj92x7RcHxGH3QRIo+y7WwDlRAXV6qXNutD24=;
        b=a6jrN+0Xrqa63kjVB9WHV1tvYA3S7fX9p3P5H+I7x+l7QEdFzTOuUQWmMl5iv0UD4G
         SzjV9dVPQrqoqqBZVdC2h0HRpmDINA/ETP5rnJzvqo3a0e9qo046ERMqRtFZZGKdzaZs
         HaHUWWwunmkMDvSNT2pVlQMOuF6g8F+plZ5on4DodhHUo8C06Vy/VSKxFu2Z/pc0muMe
         Vfc8YKYXQqYqnXyODA6zN3IL7NR7IpKjYjQ2s5JloNLL0UJN4H1REb27D6RKFTQeM1aS
         mDGuqAMl7/bgCjEgolYYuRh+yxdIipHSGiOiAbFimG7FXuKl3R+E7JjiPpieyMuXMEiX
         ja8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873020; x=1763477820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHlTUvZj92x7RcHxGH3QRIo+y7WwDlRAXV6qXNutD24=;
        b=BoMGHGLWtbsxPGC+MUwmtjp9gHRB8JsbjFUp20/RKmOFWgobe0AwcbLPRKxIa+0IPD
         froYsct0oln061Rdo8SHFYvUAr8HQ4Z100oUUjhbvwo2bDX6lLbbBTHnf6E4Z8jnoDhz
         tAc+OhykdqiRDtkB+iCVqsYHZQVtYDRDA9Np1GrJQ4eQEz+60KOdfj4Q6mZSDae86K13
         m7EGJHlLKuYUNDJyg+w5f1TynTN+ronRDnYl58DShRRJsIuEcdyylg2ABwkWNIptr5Zv
         YYJ4p3iwCZmueuCKLnYPruFtc0qeDs/p+C/6DOq4aZoTg7VWy9x8GVseWYZ0MvBgq8ea
         WEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7MD5UzpoNKlp9XwscftC+W2g9qno5m+rjQBemqm3oicRU+pZswSDfryrfs8P87ZVe2CvKpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAdIGyU46pS/LUhwzWrr1TMlX28eohYPG+sFnMfvDpxmWDWrR/
	+1bcGKNiCCc2zALfbxKpJz4IlqOzmj6gjr4lkfwumfr0pLoZN+ro5OA/
X-Gm-Gg: ASbGncvDaM/36bIO5eDrSAB+XomqPBzgKNSF4JQU7jp9bcBTmzt2EKFLpyjqOMavVRu
	nMI7s+YjQQGu3EtZkvS5UsPjjuabG7islq6VbrIwDn/hRbGG+Uz1eViiUNvFgdCwfUP/zWdTXaO
	kzqBwt955YqzsOWQ7BNLMFPoi1WHNVut4XT88TXoO4moANn+2zmwC0BypYBQhze6Zyy0efECeoi
	SigQmTpzO+G2crcERrfKo28JYzZsPCRyuRPdONLSUt18+F8J1VcxeQbY/aEXjqtblDyFouu2hZj
	R9403hUZZ4J6Lm2iU63uA4anEOQhbLlz0G5dORpbJNeYATiKa9OdFboJLPmLCaRPJuejFNLRKBS
	BjwKWB4zM0rdcOcPwYbIV0a734sEOSCN6aoJ2jdJvlbKRD5c+phAencxeWK1PuKndDVLFDBcjds
	UWn7I=
X-Google-Smtp-Source: AGHT+IHsw/1UR7CCCNbfBvlessezxYC2Txq569BxsyavfnqoxbTIchMBkQqP/NHUkOUYRkwBcT2zPw==
X-Received: by 2002:a05:600c:4ecf:b0:477:7a95:b96b with SMTP id 5b1f17b1804b1-4777a95bbe9mr41805785e9.1.1762873019837;
        Tue, 11 Nov 2025 06:56:59 -0800 (PST)
Received: from skbuf ([2a02:2f04:d104:5e00:40fe:dea4:2692:5340])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b30f1cc4esm19171541f8f.36.2025.11.11.06.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:56:59 -0800 (PST)
Date: Tue, 11 Nov 2025 16:56:56 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: deny 8021q uppers on vlan
 unaware bridged ports
Message-ID: <20251111145656.3lmaul35cfswan5k@skbuf>
References: <20251110222501.bghtbydtokuofwlr@skbuf>
 <CAOiHx=k8q7Zyr5CEJ_emKYLRV9SOXPjrrXYkUKs6=MbF_Autxw@mail.gmail.com>
 <20251111115627.orks445s5o2adkbu@skbuf>
 <20251110214443.342103-1-jonas.gorski@gmail.com>
 <20251110214443.342103-4-jonas.gorski@gmail.com>
 <20251110222501.bghtbydtokuofwlr@skbuf>
 <CAOiHx=k8q7Zyr5CEJ_emKYLRV9SOXPjrrXYkUKs6=MbF_Autxw@mail.gmail.com>
 <20251111115627.orks445s5o2adkbu@skbuf>
 <CAOiHx=naX6RbV0qBFZP3QhpKCnZ2KWdq8L23rUh4D7xwmGARbw@mail.gmail.com>
 <CAOiHx=naX6RbV0qBFZP3QhpKCnZ2KWdq8L23rUh4D7xwmGARbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx=naX6RbV0qBFZP3QhpKCnZ2KWdq8L23rUh4D7xwmGARbw@mail.gmail.com>
 <CAOiHx=naX6RbV0qBFZP3QhpKCnZ2KWdq8L23rUh4D7xwmGARbw@mail.gmail.com>

On Tue, Nov 11, 2025 at 03:09:08PM +0100, Jonas Gorski wrote:
> On Tue, Nov 11, 2025 at 12:56 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> > On Tue, Nov 11, 2025 at 11:06:48AM +0100, Jonas Gorski wrote:
> > > But I noticed while testing that apparently b53 in filtering=0 mode
> > > does not forward any tagged traffic (and I think I know why ...).
> > >
> > > Is there a way to ask for a replay of the fdb (static) entries? To fix
> > > this for older switches, we need to disable 802.1q mode, but this also
> > > switches the ARL from IVL to SVL, which changes the hashing, and would
> > > break any existing entries. So we need to flush the ARL before
> > > toggling 802.1q mode, and then reprogram any static entries.
> >
> > I'm not clear on what happens. "Broken" FDB entries in the incorrect
> > bridge vlan_filtering mode sounds like normal behaviour (FDB entries
> > with VID=0 while vlan_filtering=1, or FDB entries with VID!=0 while
> > vlan_filtering=0). They should just sit idle in the ARL until the VLAN
> > filtering mode makes them active.
> 
> When in SVL mode (vlan disabled), the ARL switches from mac+vid to
> just mac for hashing ARL entries. And I don't know if mac+vid=0 yields
> the same hash as only mac. It would it the switch uses vid=0 when not
> vlan aware, but if it skips the vid then it wouldn't.
> 
> And we automatically install static entries for the MAC addresses of
> ports (and maybe other non-dsa bridged devices), so we may need to
> have these twice in the ARL table (once for non-filtering, once for
> filtering).
> 
> If the hash is not the same, this can happen:
> 
> vlan_enabled=1, ARL hashing uses mac+vid
> add static entry mac=abc,vid=0 for port 1 => hash(mac, vid) -> entry 123
> vlan_enabled => 0, ARL hashing uses only mac
> packet received on port 2 for mac=abc => hash(mac) => entry 456 => no
> entry found => flood (which may not include port 1).
> 
> when trying to delete the static entry => lookup for mac=abc,vid=0 =>
> hash(mac) => entry 456 => no such entry.
> 
> Then maybe we ignore the error, but the moment we enable vlan again,
> the hashing changes back to mac+vid, so the "deleted" static entry
> becomes active again (despite the linux fdb not knowing about it
> anymore).
> 
> And even if the hash is the same, it would mean we cannot interact
> with any preexisting entries for vid!=1 that were added with vlan
> filtering = 1. So we cannot delete them when e.g. removing a port from
> the bridge, or deleting the bridge.
> 
> So the safest would be to remove all static entries before changing
> vlan filtering, and then re-adding them afterwards.
> 
> Best regards,
> Jonas

If you just want to debug whether this is the case or not, then as I
understand, for the moment you only care about static FDB entries on the
CPU port, not on user ports added with 'bridge fdb add ... master static".
If so, these FDB entries are available in the cpu_dp->fdbs list. For
user ports we don't bother keeping track.

Regarding switchdev FDB replay, it's possible but has very high
complexity. The base call would be to switchdev_bridge_port_replay(),
then you'd need to set up two parallel notifier blocks through which
you're informed of the existing objects (not the usual dsa_user_switchdev_notifier
and dsa_user_switchdev_blocking_notifier), whose internal processing is
partly similar (the event filtering and replication) and partly different:
instead of calling dsa_schedule_work() to program the FDB entries to
hardware, you just add them to a list that is kept in a context
structure, which is passed to the caller once the replay is over and the
list is complete.

For the moment, dp->fdbs should be sufficient to prove/disprove a point.

