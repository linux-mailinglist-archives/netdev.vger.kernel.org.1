Return-Path: <netdev+bounces-107854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D282091C99E
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 01:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020601C21DFC
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 23:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A6578286;
	Fri, 28 Jun 2024 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HHglxMDg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BD6BA53
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719617790; cv=none; b=s8Vfe9B2jNmF40chQ4fAlZ3txUNPH4Uri91f7Z8qcr3dWIt/4JIa1tQS5uTWG5msbMrUF/PP1y4KDR0f5WRMQv+iGgUnpn+Z4RFZwvH2nyVXCXWz8UlPvrnkrIzrgjjMplaM/U2oAGFG8HQzQktilR3furdzUxRzvmApxGPInng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719617790; c=relaxed/simple;
	bh=MUI0Z1qvWCy79CRxccjUPCl7hsRG+73jN/5v4m60dMY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=pFV7A6mDXuuD+OMU7ZWCEM971AvG3VjmiI7vleaaK4T/n4PSO1opgOIwuafCj9epMLV0raVPATJzHkHeeUEoTku8fJJZtqSIiJOSTid0OblarL05SNf50VMkacWTrfRU27X2M0R9p3cunKAV7pF1sX91g8wyRqkNXXwNsZcis3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HHglxMDg; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8861C3F8DE
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 23:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719617780;
	bh=PdRDEddoUupXP2xLQBakrELnh8voZdp1wksDEeMmmbQ=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=HHglxMDgS+Y7TvLNQnLa9Y7+cww8L7pcX13aXvXf8w1K+/lAB2k4hG8q8JszYPcai
	 jZN0dvJe60Jaes/gpTwGP3bXlvaMAchQ5G4seh6z6j3bprvkhrE5OMqtWJTrN6zOlk
	 IKn1NVlp9ASjXp5b9CrVwC1GdoJKphUQP5J84hAI/zZzIraEY5j8OxEJngtk4y4CGj
	 rMmJS+5T2+XdIYNQW5VncZ2cYvNhrqyIz7bUABUmCNRd637Ry9i+ICXPpkR4Fg/S3q
	 vcu/fXwuNf13ODNMApLdj4GfgSfku4jlU9NsFfHhZ3opVTcc194kc15Y4uIgWZkaQq
	 8vnETD0WidnGQ==
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5ba793ceccaso942501eaf.2
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 16:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719617779; x=1720222579;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdRDEddoUupXP2xLQBakrELnh8voZdp1wksDEeMmmbQ=;
        b=tPQVlXI13D1FwaT/ujW4YpL8l1RUhBQlVGwNhCMgiyp0IF3wLW9yX1qEGQNVO2dRyM
         fHJPTYJeo7ERIAqW9cY7g15hCpBBbc0yIncTXc+bPUABi40aoomV0YhgNPdqe+lz3vMB
         TerCWVQCXy8CV16SK2jz/WtmJeoNQdrv78TUwiLvUQ5Y37efCI2whB0fKSelBo85+E0M
         3CsO+9CY9mVH9P36ZYFOPoT2Btay+1wTiX6fy9YSRDUW0WCMryPPjp5wsGSTIc/QsK49
         WwQBnVjC2CvQbtNYvF3v7mRWJePzBZTexr4eEJXeHPe4qbi+pDLStDz99RdiXAZhcCgK
         HPtw==
X-Forwarded-Encrypted: i=1; AJvYcCWtvGj06E08lYrTLW7xNR0hXxaW25p9LNO/2U2FU1vbOQP4VkSJ/0NRD3fDu6pYecB4CBXKEb5ixZFLo8x0IPsXu2zAndf0
X-Gm-Message-State: AOJu0YwFrdE2cKEWD6Fq16hOTdHnaCnpAHTmtmu24l4jLFb4G+ADiOU4
	ucQ5jttXIXOfYyo+iRIpGvYM7/svVhaR6N6OmwOaJqpe0qGDjTlLOYJbCt33hIYnY2Ls80NZchY
	lcbU6LyHhYfUOqZ1ye1sOVNVwT7lj3RRDIaCnl+uJ1fUC/ygz+UMprfugGPcH9Ux6M9VZww==
X-Received: by 2002:a05:6359:5fa6:b0:1a6:7e01:e4e9 with SMTP id e5c5f4694b2df-1a67e01edfamr581556755d.25.1719617779094;
        Fri, 28 Jun 2024 16:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHKL/Jes7h3SRTQekWmAI0mKeLwtIaI35DopzkOkrZlKqxA3nxEz5RU8SW15DHJTBCYx4s2Q==
X-Received: by 2002:a05:6359:5fa6:b0:1a6:7e01:e4e9 with SMTP id e5c5f4694b2df-1a67e01edfamr581554055d.25.1719617778557;
        Fri, 28 Jun 2024 16:36:18 -0700 (PDT)
Received: from famine.localdomain ([50.35.97.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce1683csm2220731a91.8.2024.06.28.16.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 16:36:18 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 667EB9FBA2; Fri, 28 Jun 2024 16:36:17 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 638C29FB9F;
	Fri, 28 Jun 2024 16:36:17 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: Nikolay Aleksandrov <razor@blackwall.org>,
    Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
    Andy Gospodarek <andy@greyhouse.net>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
    Amit Cohen <amcohen@nvidia.com>
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
In-reply-to: <Zn6Ily5OnRnQvcNo@Laptop-X1>
References: <1429621.1719446760@famine> <Zn0iI3SPdRkmfnS1@Laptop-X1>
 <7e0a0866-8e3c-4abd-8e4f-ac61cc04a69e@blackwall.org>
 <Zn05dMVVlUmeypas@Laptop-X1>
 <89249184-41ac-42f6-b5af-4a46f9b28247@blackwall.org>
 <Zn1mXRRINDQDrIKw@Laptop-X1> <1467748.1719498250@famine>
 <Zn4po-wJoFat3CUd@Laptop-X1>
 <efd0bf80-7269-42fc-a466-7ec0a9fd5aeb@blackwall.org>
 <8e978679-4145-445c-88ad-f98ffec6facb@blackwall.org>
 <Zn6Ily5OnRnQvcNo@Laptop-X1>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Fri, 28 Jun 2024 17:55:35 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1518278.1719617777.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Jun 2024 16:36:17 -0700
Message-ID: <1518279.1719617777@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Hi Nikolay,
>On Fri, Jun 28, 2024 at 10:22:25AM +0300, Nikolay Aleksandrov wrote:
>> > Actually I was talking about:
>> >  /sys/class/net/<bond port>/bonding_slave/ad_actor_oper_port_state
>> >  /sys/class/net/<bond port>/bonding_slave/ad_partner_oper_port_state
>> > etc
>> > =

>> > Wouldn't these work for you?
>> > =

>> =

>> But it gets much more complicated, I guess it will be easier to read th=
e
>> proc bond file with all the LACP information. That is under RCU only as
>> well.
>
>Good question. The monitor application want a more elegant/general way
>to deal with the LACP state and do other network reconfigurations.
>Here is the requirement I got from customer.
>
>1) As a server administrator, I want ip monitor to show state change even=
ts
>   related to LACP bonds so that I can react quickly to network reconfigu=
rations.
>2) As a network monitoring application developer, I want my application t=
o be
>   notified about LACP bond operational state changes without having to
>   poll /proc/net/bonding/<bond> and parse its output so that it can trig=
ger
>   predefined failover remediation policies.
>3) As a server administrator, I want my LACP bond monitoring application =
to
>   receive a Netlink-based notification whenever the number of member
>   interfaces is reduced so that the operations support system can provis=
ion
>   a member interface replacement.

	What notifications are they not getting that they want?  Or is
it that events happen but lack some information they want?

	Currently, the end of bond_3ad_state_machine_handler() will send
notifications via bond_slave_state_notify() if the state of any member
of the bond has changed (via the struct slave.should_notify field).

	The notifications here come from bond_lower_state_changed(),
which propagates link up/down and tx_enabled (active-ness), but not any
LACP specifics.  These are sent as NETDEV_CHANGELOWERSTATE events, which
rtnetlink_event() handles, so they should be visible to ip monitor.

>What I understand is the user/admin need to know the latest stable state =
so
>they can do some other network configuration based on the status. Losing
>a middle state notification during fast changes is acceptable.

	This is a much simpler problem to solve.

>> Well, you mentioned administrators want to see the state changes, pleas=
e
>> better clarify the exact end goal. Note that technically may even not b=
e
>> the last state as the state change itself happens in parallel (differen=
t
>> locks) and any update could be delayed depending on rtnl availability
>> and workqueue re-scheduling. But sure, they will get some update at som=
e point. :)
>
>Would you please help explain why we may not get the latest state? From w=
hat
>I understand:
>
>1) State A -> B, queue notify
>       rtnl_trylock, fail, queue again
>2) State B -> C, queue notify
>      rtnl_trylock, success, post current state C
>3) State C -> D, queue notify
>      rtnl_trylock, fail, queue again
>4) State D -> A, queue notify
>      rtnl_trylock, fail, queue again
>      rtnl_trylock, fail, queue again
>      rtnl_trylock, success, post current state A
>
>So how could the step 3) state send but step 4) state not send?

	I'm going to speculate here that the scenario envisioned would
be something like CPU A is in the midst of generating an event at the
end of the state machine, but CPU B could be processing a LACPDU
simultaneously-ish.  The CPU A event is sent, but the CPU B event is
delayed due to RTNL contention.  In this scenario, the last event seen
in user space is CPU A, but the actual state has moved on to that set by
CPU B, whose notification will be received eventually.

>BTW, in my code, I should set the should_notify_lacp =3D 0 first before s=
ending
>ifinfo message. So that even the should_notify_lacp =3D 1 in ad_mux_machi=
ne()
>is over written here, it still send the latest status.
>
>> +
>> +             if (slave->should_notify_lacp) {
>> +                     slave->should_notify_lacp =3D 0;
>> +                     rtmsg_ifinfo(RTM_NEWLINK, slave->dev, 0, GFP_KERN=
EL, 0, NULL);
>> +             }
>
>The side effect is that we may send 2 same latest lacp status(the
>should_notify_lacp is over written to 1 and queue again), which should
>be OK.

	Looking at the current notifications in bonding, I wonder if it
would be sufficient to add the desired information to what
bond_lower_state_changed() sends, rather than trying to shoehorn in
another rtnl_trylock() gizmo.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

