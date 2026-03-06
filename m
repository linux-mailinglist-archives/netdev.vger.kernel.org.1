Return-Path: <netdev+bounces-264769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGtMG93HqmnVWwEAu9opvQ
	(envelope-from <netdev+bounces-264769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:26:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4C9220927
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4E33304201D
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 12:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06E396D26;
	Fri,  6 Mar 2026 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Vz1PiQbn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB275396D0E
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799752; cv=none; b=otIvLup3RZjGJJTgMzkJY8R+1DluVDsf+KbLXjoROOBPcOkWtndCrjZJZ5ske7/pYJTnnVbjO1iZRmtxJIJOjxfTLE8ia/TduEsw7a9/A7eAlRsRHpVj8bTNElGubxNX/0C73U1qwg51VIi/f6RxEj7RGQQZck+C93M7ppikups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799752; c=relaxed/simple;
	bh=j/764L48Xx+7Zu6cS0Hd0T/spRfk3/nWHgaW8v7Xkv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqwWMJx0atMHFqq+rC3dHsyJfz5XWrQ80Z5TuzaPsMgKg1fNhUJQxaf2AR8eDtX733qfPdqhceI7Tfq8XYwwq9Jt8fAnRUEWBMRP/CyIod6FmyuNf8WMQKygPgnlErEMrQhKnDdctrK3GhMqqktzFeUe8EtZbXCKleDyExZbLoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Vz1PiQbn; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso5419736eec.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 04:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1772799745; x=1773404545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WBRlKfOOjwlbHnXlngH96DL1JB+TDBbvPTEmG+WuzGA=;
        b=Vz1PiQbnvraLQQLr+JNTThMPce2UvP3/bHOO0NnnqOfuCkdX/d+7ik3D1IRSuvM1bf
         8sK2zTc+viLEw2A1R6X+fuCBLp/uWaQ9nVkpkNOZWRXaRfuhe2RTtxqNGguDyVksItN9
         iFqOrbTXnh0zVXpkM6CtPL6CQCNIWxsEly/C5gLZQ3VIpn14UW3hPEuUje0XcBq80d69
         GwAFKVfGuaDZGe1yz0MYFKu0EXMAefwuxB+LH7kOQM4H9gRKB7uT9dzUX5QiAfazaEpd
         MFSvGXZy2AHxknKHLAzFS+Jmrn5THTQNjVhEL9i6DAs//I0OOd6Ua4jf1s9FOainvaE+
         vUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772799745; x=1773404545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBRlKfOOjwlbHnXlngH96DL1JB+TDBbvPTEmG+WuzGA=;
        b=J77+CVQ8HBO6j2XkobggDA5MXiuPlEP+E04rld0Vhclm2h1wWzuLF77K6h9NikHk7x
         8UlHbB1L9cYRCb3hNrrgRw4tlvAsbZX9P3B/YYOSdh2RoH13O84fwoutjg+l9L+HWezA
         fzlF57sobcgfNuMZp7TNiVdZiVs60Azo1uAVCDBSHXLuc7aQ7p8A8Gl1zk5BdIcxMNc3
         1irle5I4mDq3+grXNZxuRaINlC74jazadlFVDyiS3DZTWTo22FQNMdRN1Fw2g1q7NiPw
         16K/KnQ7cG3cpW1rISrqvb3Wvptrx6qHkLR4WRX8ELA1zCGhq7dcVNKopytioWZLDI1A
         x1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjnCPTEXNh8ouV7L/OjVqMNDKUY4gYgw64PAQX8IxpH8AAiIoAIVCHYmTr3rlx/4RBdn0qUd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCO0Cgt8BheRL4ToRpccz3A96OWpLAdf1hcSLRszqJ6fET6PF+
	6z8ciHVkaYp5R2S3yr2OhaWtD6vcpkZNuCJrPjBaxOzcQTMm9cj3JG92+CIg7mbhUAM=
X-Gm-Gg: ATEYQzx2mkA2q9lprXtPbKOgjtRlwYvlg9yzwaVD/lriNvtZMejUIumeaxKCai9lf1P
	fa8YLCAo25Ar4Aitk++crRA+At+ZBY3oTJ6KOpbG/dPvU/nv/eVBiQKSKNkgcENBSj7XOCobayT
	KSum8ho6fXk+04nZTr9UfWU5TWIwqAvvgJIqtoESGZdISQhWiJ+TdsVnO2oawdBoB1hgwJxFK0e
	Z5Ml3jqMVd763mdg4jhE2MA7XJLYtRdSMrG4xmTIwuX4SSxKdDxSMY8Rh4z7vn0jEZvxhZhiWah
	X0uRjPfhSm8uLyRnp0azy8wL2qfNlXjstvkYrZ1gvcwBg+ZiENQnZhy0nyrJvTWuRpZ7gCJQHP5
	2H2sZBVXGlbF4SDKdVbc72aFms6tyV89rpDDVPRDccFbWXKKzj/+AFycfHJrnqFsEmQoJBllSJV
	gPtenbpX0GsV1uuXEkyDFu
X-Received: by 2002:a05:7300:434b:b0:2be:13e1:d2c4 with SMTP id 5a478bee46e88-2be3e62e8c4mr2125798eec.12.1772799745038;
        Fri, 06 Mar 2026 04:22:25 -0800 (PST)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f807a30sm1015873eec.6.2026.03.06.04.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:22:23 -0800 (PST)
Date: Fri, 6 Mar 2026 14:22:19 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org,
	jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v4 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
Message-ID: <aarG-99qsXKgPMws@penguin>
References: <20260304074301.35482-1-jiayuan.chen@linux.dev>
 <20260304074301.35482-2-jiayuan.chen@linux.dev>
 <aahWymAi_CtRG0gJ@penguin>
 <1293120.1772645248@famine>
 <aahsuPt7cY8LxETN@penguin>
 <1356528.1772744631@famine>
 <e08dcb78a13fc69be07d28d032cebe3734797a3a@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e08dcb78a13fc69be07d28d032cebe3734797a3a@linux.dev>
X-Rspamd-Queue-Id: 0F4C9220927
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264769-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[jvosburgh.net,vger.kernel.org,shopee.com,syzkaller.appspotmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,linutronix.de,goodmis.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,blackwall.org:dkim,blackwall.org:email]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 02:42:05AM +0000, Jiayuan Chen wrote:
> 2026/3/6 05:03, "Jay Vosburgh" <jv@jvosburgh.net mailto:jv@jvosburgh.net?to=%22Jay%20Vosburgh%22%20%3Cjv%40jvosburgh.net%3E > wrote:
> 
> 
> > 
> > Nikolay Aleksandrov <razor@blackwall.org> wrote:
> > 
> > > 
> > > On Wed, Mar 04, 2026 at 09:27:28AM -0800, Jay Vosburgh wrote:
> > > 
> > > > 
> > > > Nikolay Aleksandrov <razor@blackwall.org> wrote:
> > > >  
> > > >  >On Wed, Mar 04, 2026 at 03:42:57PM +0800, Jiayuan Chen wrote:
> > > >  >> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> > > >  >> 
> > > >  >> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> > > >  >> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> > > >  >> when the bond mode is round-robin. If the bond device was never brought
> > > >  >> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> > > >  >> 
> > > >  >> The XDP redirect path can reach this code even when the bond is not up:
> > > >  >> bpf_master_redirect_enabled_key is a global static key, so when any bond
> > > >  >> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> > > >  >> interception is enabled for all bond slaves system-wide. This allows the
> > > >  >> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> > > >  >> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> > > >  >> reached on a bond that was never opened.
> > > >  >> 
> > > >  >> Fix this by allocating rr_tx_counter unconditionally in bond_init()
> > > >  >> (ndo_init), which is called by register_netdevice() and covers both
> > > >  >> device creation paths (bond_create() and bond_newlink()). This also
> > > >  >> handles the case where bond mode is changed to round-robin after device
> > > >  >> creation. The conditional allocation in bond_open() is removed. Since
> > > >  >> bond_destructor() already unconditionally calls
> > > >  >> free_percpu(bond->rr_tx_counter), the lifecycle is clean: allocate at
> > > >  >> ndo_init, free at destructor.
> > > >  >> 
> > > >  >> Note: rr_tx_counter is only used by round-robin mode, so this
> > > >  >> deliberately allocates a per-cpu u32 that goes unused for other modes.
> > > >  >> Conditional allocation (e.g., in bond_option_mode_set) was considered
> > > >  >> but rejected: the XDP path can race with mode changes on a downed bond,
> > > >  >> and adding memory barriers to the XDP hot path is not justified for
> > > >  >> saving 4 bytes per CPU.
> > > >  >> 
> > > >  >> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> > > >  >> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> > > >  >> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
> > > >  >> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> > > >  >> ---
> > > >  >> drivers/net/bonding/bond_main.c | 19 +++++++++++++------
> > > >  >> 1 file changed, 13 insertions(+), 6 deletions(-)
> > > >  >> 
> > > >  >
> > > >  >IMO it's not worth it to waste memory in all modes, for an unpopular mode.
> > > >  >I think it'd be better to add a null check in bond_rr_gen_slave_id(),
> > > >  >READ/WRITE_ONCE() should be enough since it is allocated only once, and
> > > >  >freed when the xmit code cannot be reachable anymore (otherwise we'd have
> > > >  >more bugs now). The branch will be successfully predicted practically always,
> > > >  >and you can also mark the ptr being null as unlikely. That way only RR takes
> > > >  >a very minimal hit, if any.
> > > >  
> > > >  Is what you're suggesting different from Jiayuan's proposal[0],
> > > >  in the sense of needing barriers in the XDP hot path to insure ordering?
> > > >  
> > > >  If I understand correctly, your suggestion is something like
> > > >  (totally untested):
> > > > 
> > > Basically yes, that is what I'm proposing + an unlikely() around that
> > > null check since it is really unlikely and will be always predicted
> > > correctly, this way it's only for RR mode.
> > > 
> >  Jiayuan,
> > 
> >  Do you agree that the patch below (including Nikolay's
> > suggestion to add "unlikely") resolves the original issue without memory
> > waste, and without introducing performance issues (barriers) into the
> > XDP path?
> 
> 
> Sure, it's basically similar to what my v1 did, but the patch below can be more generic.
> 
> https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.dev/T/#m08e3e53a8aa8d837ddc9242f4b14f2651a2b00aa
> 

IMO that is worse, you'll add 2 new tests and potentially 1 more cache line
for everyone in a hot path that is used a lot and must be kept as fast as possible.

> >  -J
> > 
> > > 
> > > > 
> > > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > > >  index eb27cacc26d7..ac2a4fc0aad0 100644
> > > >  --- a/drivers/net/bonding/bond_main.c
> > > >  +++ b/drivers/net/bonding/bond_main.c
> > > >  @@ -4273,13 +4273,17 @@ void bond_work_cancel_all(struct bonding *bond)
> > > >  static int bond_open(struct net_device *bond_dev)
> > > >  {
> > > >  struct bonding *bond = netdev_priv(bond_dev);
> > > >  + u32 __percpu *rr_tx_tmp;
> > > >  struct list_head *iter;
> > > >  struct slave *slave;
> > > >  
> > > >  - if (BOND_MODE(bond) == BOND_MODE_ROUNDROBIN && !bond->rr_tx_counter) {
> > > >  - bond->rr_tx_counter = alloc_percpu(u32);
> > > >  - if (!bond->rr_tx_counter)
> > > >  + if (BOND_MODE(bond) == BOND_MODE_ROUNDROBIN &&
> > > >  + !READ_ONCE(bond->rr_tx_counter)) {
> > > >  + rr_tx_tmp = alloc_percpu(u32);
> > > >  + if (!rr_tx_tmp)
> > > >  return -ENOMEM;
> > > >  + WRITE_ONCE(bond->rr_tx_counter, rr_tx_tmp);
> > > >  +
> > > >  }
> > > >  
> > > >  /* reset slave->backup and slave->inactive */
> > > >  @@ -4866,6 +4870,9 @@ static u32 bond_rr_gen_slave_id(struct bonding *bond)
> > > >  struct reciprocal_value reciprocal_packets_per_slave;
> > > >  int packets_per_slave = bond->params.packets_per_slave;
> > > >  
> > > >  + if (!READ_ONCE(bond->rr_tx_counter))
> > > >  + packets_per_slave = 0;
> > > >  +
> > > >  switch (packets_per_slave) {
> > > >  case 0:
> > > >  slave_id = get_random_u32();
> > > >  
> > > >  -J
> > > >  
> > > >  
> > > >  [0] https://lore.kernel.org/netdev/e4a2a652784ec206728eb3a929a9892238c61f06@linux.dev/
> > > >
> > > 
> > ---
> >  -Jay Vosburgh, jv@jvosburgh.net
> >

