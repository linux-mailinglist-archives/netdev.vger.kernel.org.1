Return-Path: <netdev+bounces-200813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF391AE7001
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C810B3A882A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE1F2E7631;
	Tue, 24 Jun 2025 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="vhdpqu3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="od9X+9q6"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389622EACEA
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794210; cv=none; b=kVlS2PrszWf0tSKewEXhwOUFVrV0WUMXl3tEc9Q1Df4QTwnST/4qjCs0tuK4DNHr98pM++6oUyVsGqWVupa46ghJdNw4PhWP0v1neHZB97Nz48CHobEeMJit6G2bU6ORMwt+3RB7VvTZ7dGTQMP2PLeKzIoLBCg5jKmo6lqCe0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794210; c=relaxed/simple;
	bh=Nn8pvNqvqDUGmkJ4pjaHhtBFtSnLufDa2Eh4bYGLMyo=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=rTLJs9BaBnQ5qqqDN/qtJAWlCzr3BfndnTQ87JXYOmZOEbMFVwfcdRudSb1OrMSykhJ5jUpUH8J19lJqsHfV7uU38LafT6lzdAxwvnwtQEaacPO52lbkpBnYWeG/kPDoXoXuNrLHwfvg+JAFBmts+AQ/28ycc+Cq71yrT6dreig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=vhdpqu3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=od9X+9q6; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E1E281D0017C;
	Tue, 24 Jun 2025 15:43:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 24 Jun 2025 15:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1750794205; x=1750880605; bh=wy2IsrOX3+c1TmzCABwumJcNQZ1tR2og
	wpgdf3LQN5A=; b=vhdpqu3S6csy6UPkGdWHBNH6oNqxPI3uonAGde8K3/vu6aas
	iKgg2Uv4+WFX0KNea8mZ3YEPMFtiZdJNLiSAPFkbMbl7E0oFsKkacNW2mIrnN0zU
	TJgwzcP3SW1pUeiKiFKPLgpieKrMfteGagEeW6DJn8ZWYrNZB/Ls6bpebWAo6wd2
	VrZ4bR1bXfmYmiITe1ZVyUtSbvKLCu4HWFAOMxkdPwjox6hGH1t1+f3KE97+a0R+
	atjC1YUhEs7ztG9EdZZF3k+flkMQF1XHLAF6+Tx7u9HDv9z8L54MEVGFJqMpHU91
	ytXrx+K7ozPhHzJA1C2J6CVi3n7fyVzwRIBnHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750794205; x=
	1750880605; bh=wy2IsrOX3+c1TmzCABwumJcNQZ1tR2ogwpgdf3LQN5A=; b=o
	d9X+9q6esgk7jUbZGxa7iTFhEv86TdwQejsEDaXXgD60Zb/r7+649W5vBeJRmtqQ
	2ehWVG7hxeWurTSzBTB9kCHSsfGv0dC62164i4ftqTfD8zKShQ+hDMTTAM5OPEF/
	WDalUVMXbEr+ZHFgI3fZMuxyBsb5CNTe7ANwxWItnXQiG/s2p7NU2wlDjkBHn5rO
	dcMtm1iTFtWYghRqs11SnxG26VNCFiKQIEoQUau7bVIuwEiq6SjLw0T0/t5ud7AU
	wcBCfemYD/5ijYhaQO7BG8VzbXJ9sNXzUykxtQHScgQkgGFBfmjiExMVBy2dSEHg
	nwjtFckzm5UBjF9q8Os4Q==
X-ME-Sender: <xms:3P9aaJzkhxpVvId81Qfo-RV99XSJL033M5DvejFATwjFwLBfZBYuQQ>
    <xme:3P9aaJSaBrMQ5YrSAgmryJkAPNz18gialmBhRKa-3DKeEH0h3dnnLj1tjUcBjugQq
    hwFVhzkk_Iu6PEVfQ4>
X-ME-Received: <xmr:3P9aaDUhgfgogh2muJD9hbYnOpxtLW1AwWAHCu0y2qdFXo4wakFhvzBRH0Yz3bcNnjY3sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtjeenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeegfefghffghffhjefgveekhfeukeevffethffgtddutdefffeuheelgeelieeuhfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehtohhnghhhrghosegsrghmrghitghlohhuugdrtghomhdprh
    gtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehtuhiivghnghgsihhngh
    esughiughighhlohgsrghlrdgtohhmpdhrtghpthhtohepmhgrthhhihgvuhdruggvshhn
    ohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesgh
    hoohgumhhishdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    husggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3P9aaLgtkKr4SXg__rzFqSHnfotHuDn3IdVU0GkfKfbM1y7FKWEGYQ>
    <xmx:3P9aaLCLWhqVH-Fhydq-5p23P7XaNZQwXjBq37uiEOz0JcYC_-tAmg>
    <xmx:3P9aaEI2NHm-oGAR-MpBwCgFT3wKXLtSyMZtdgegPdR-sFV63CloSw>
    <xmx:3P9aaKD3bzcb7a3uWsnWlBGUFVTwZUHxMvailC7EeYmDgGhxK1u2_A>
    <xmx:3f9aaKSP7EbEgNtEYNcHahwj3uLlhsRxXOPqlmP6sNl9kjDhJgwwap88>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 15:43:24 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 8DF0F9FCA2; Tue, 24 Jun 2025 12:43:23 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 8CD459FC54;
	Tue, 24 Jun 2025 12:43:23 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Tonghao Zhang <tonghao@bamaicloud.com>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Steven Rostedt <rostedt@goodmis.org>,
    Masami Hiramatsu <mhiramat@kernel.org>,
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Zengbing Tu <tuzengbing@didiglobal.com>
Subject: Re: [net-next v6 4/4] net: bonding: add tracepoint for 802.3ad
In-reply-to: <8DB4F573-128C-4A2D-A4D0-3909586AFF8C@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com> <10b8f570bd59104a1c7d5ecdc9a82c6ec61d2d1c.1749525581.git.tonghao@bamaicloud.com> <1931181.1750120130@famine> <C75C5F1F-544F-4613-91D9-4F876EF286B3@bamaicloud.com> <8DB4F573-128C-4A2D-A4D0-3909586AFF8C@bamaicloud.com>
Comments: In-reply-to Tonghao Zhang <tonghao@bamaicloud.com>
   message dated "Mon, 23 Jun 2025 10:11:04 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Jun 2025 12:43:23 -0700
Message-ID: <2482590.1750794203@famine>

Tonghao Zhang <tonghao@bamaicloud.com> wrote:

>> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 18:37=EF=BC=8CTonghao Zhang <tonghao@=
bamaicloud.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>>> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 08:28=EF=BC=8CJay Vosburgh <jv@jvosb=
urgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>>>=20
>>>> Users can monitor NIC link status changes through netlink. However, LA=
CP
>>>> protocol failures may occur despite operational physical links. There =
is
>>>> no way to detect LACP state changes. This patch adds tracepoint at
>>>> LACP state transition.
>>>=20
>>> This patch really has nothing to do with the rest of the series
>>> (it's unrelated to the broadcast_neighbor functionality), and should
>>> really be sent separately.
>> =E2=80=A6 monitoring the lacp state is part of =E2=80=9Cno-stacking=E2=
=80=9D arch solution. So I sent it as series.
>> if unnecessary, I will set it separately.
>>=20
>>> That said, I recall asking about work that was proposed some
>> Sorry I may miss your commits about this patch.
>>> time ago to create netlink events (visible to ip monitor, et al) when
>>> the LACP state changes.  That would be a cleaner method to watch the
>>> LACP state machine (as it would integrate with all of the other event
>> Why not consider a BPF+tracepoint solution? It provides more flexible LA=
CP data collection with simpler implementation.
>We developed a component. It collects kernel events via kprobe, ftrace, an=
d tracepoint. Events include:
>- Scheduling latency
>- Direct memory reclaim
>- Network packets drop
>- LACP state events
>
>BPF + tracepoint is our optimal approach. I think we should support this m=
ethod.

	At present, as far as I know, networking state change events are
exported to user space through netlink.  Absent a compelling reason why
the LACP state change cannot be exported via netlink, my view is that it
should be consistent with all other network events.

	Also, to be clear, I'm asking for justification because this is
a request to do something in a special bonding-unique way.  There are
already a lot of special cases in bonding, in which things are done
differently than the usual practice.  Adding an API element, such as a
tracepoint, is forever, and as such adding one that also differs from
the usual practice deserves scrutiny.

	-J


>>> infrastructure).  Maybe I missed the response, but what became of that
>>> work?
>>>=20
>>> -J
>>>=20
>>>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>> Cc: Simon Horman <horms@kernel.org>
>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>>>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>>>> ---
>>>> drivers/net/bonding/bond_3ad.c |  6 ++++++
>>>> include/trace/events/bonding.h | 37 ++++++++++++++++++++++++++++++++++
>>>> 2 files changed, 43 insertions(+)
>>>> create mode 100644 include/trace/events/bonding.h
>>>>=20
>>>> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond=
_3ad.c
>>>> index d1c2d416ac87..55703230ab29 100644
>>>> --- a/drivers/net/bonding/bond_3ad.c
>>>> +++ b/drivers/net/bonding/bond_3ad.c
>>>> @@ -16,6 +16,9 @@
>>>> #include <net/bond_3ad.h>
>>>> #include <net/netlink.h>
>>>>=20
>>>> +#define CREATE_TRACE_POINTS
>>>> +#include <trace/events/bonding.h>
>>>> +
>>>> /* General definitions */
>>>> #define AD_SHORT_TIMEOUT           1
>>>> #define AD_LONG_TIMEOUT            0
>>>> @@ -1146,6 +1149,9 @@ static void ad_mux_machine(struct port *port, bo=
ol *update_slave_arr)
>>>>  port->actor_port_number,
>>>>  last_state,
>>>>  port->sm_mux_state);
>>>> +
>>>> + trace_3ad_mux_state(port->slave->dev, last_state, port->sm_mux_state=
);
>>>> +
>>>> switch (port->sm_mux_state) {
>>>> case AD_MUX_DETACHED:
>>>> port->actor_oper_port_state &=3D ~LACP_STATE_SYNCHRONIZATION;
>>>> diff --git a/include/trace/events/bonding.h b/include/trace/events/bon=
ding.h
>>>> new file mode 100644
>>>> index 000000000000..1ee4b07d912a
>>>> --- /dev/null
>>>> +++ b/include/trace/events/bonding.h
>>>> @@ -0,0 +1,37 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +
>>>> +#if !defined(_TRACE_BONDING_H) || defined(TRACE_HEADER_MULTI_READ)
>>>> +#define _TRACE_BONDING_H
>>>> +
>>>> +#include <linux/netdevice.h>
>>>> +#include <linux/tracepoint.h>
>>>> +
>>>> +#undef TRACE_SYSTEM
>>>> +#define TRACE_SYSTEM bonding
>>>> +
>>>> +TRACE_EVENT(3ad_mux_state,
>>>> + TP_PROTO(struct net_device *dev, u32 last_state, u32 curr_state),
>>>> + TP_ARGS(dev, last_state, curr_state),
>>>> +
>>>> + TP_STRUCT__entry(
>>>> + __field(int, ifindex)
>>>> + __string(dev_name, dev->name)
>>>> + __field(u32, last_state)
>>>> + __field(u32, curr_state)
>>>> + ),
>>>> +
>>>> + TP_fast_assign(
>>>> + __entry->ifindex =3D dev->ifindex;
>>>> + __assign_str(dev_name);
>>>> + __entry->last_state =3D last_state;
>>>> + __entry->curr_state =3D curr_state;
>>>> + ),
>>>> +
>>>> + TP_printk("ifindex %d dev %s last_state 0x%x curr_state 0x%x",
>>>> +   __entry->ifindex, __get_str(dev_name),
>>>> +   __entry->last_state, __entry->curr_state)
>>>> +);
>>>> +
>>>> +#endif /* _TRACE_BONDING_H */
>>>> +
>>>> +#include <trace/define_trace.h>
>>>> --=20
>>>> 2.34.1
>>>>=20
>>>=20
>>> ---
>>> -Jay Vosburgh, jv@jvosburgh.net
>
>
>
---
	-Jay Vosburgh, jv@jvosburgh.net


