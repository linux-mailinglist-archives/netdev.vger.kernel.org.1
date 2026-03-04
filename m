Return-Path: <netdev+bounces-263952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGn6HMJsqGn9uQAAu9opvQ
	(envelope-from <netdev+bounces-263952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:32:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1415D205318
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F81B3007525
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 17:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3DE3C278F;
	Wed,  4 Mar 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="l5TuBfJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B53BED7A
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645566; cv=none; b=raIWQAJEtjw57bRd5ZqKE9gjlM4bI4xVX2t7B87rnb4Fjr/2j9rmmvlmpsVwOvQCFr6KvQZKxDLvo0XWUjvgrBlv0wZs8gfgX3g2JJNN0hpkphA78opHVTWzSpE9uPRYFnAQ+1rIS9bz4BIYxUfZOTJTw2FWgijFVrHk45CUuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645566; c=relaxed/simple;
	bh=N47v7eONnQY3buJuOKooWDUtMXrII78TS3KNla41Zlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHnPGNqfdisjxWPzNWjIm1hKq6rMHAyG1n1UrPONq7jyZW9nh69ZcMRhIIZijjNzbubB9276RBvzYhnEmvZA0x76Ev02XYHUzITsuwshF4IzZpMsqKv8KdVOQOS1/OoiFGDObYJSkzgrbcNevhqc0Palvuh3rSq7NLSsPSdf7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=l5TuBfJD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483bd7354efso95248435e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1772645563; x=1773250363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CvZHzwfBez6SktFHis/UP+MVLhoMj8/M/nCRuUvbuQA=;
        b=l5TuBfJD0yd2e4QSZwFscYrag7RycsKhSf56F281OerWnHQqhIgrHn7ForIkVMUDXA
         bQHB/DJYaz2Q4cCBiMuhnzdcwEipcFHIqSifLRP30foC4RlbU8UwuYpFKjFUTtiVN4We
         XfdWNgJOrlxfsQAL0o8LLUZE3HaKe/w+LKZK8Q3dvqo6sgNJJ5s0+VDZEJJq6he7/NBP
         SkkbBGPUX2qsrJ6tjouPbR4/z1LtB0OhRKLsxcw6p9FnOdxwhz9oudT+n0v8wZgpKBy5
         iJ3frWlYD4L5Ljxn+XfFKUhBzZzHnLZGZuF987Gv44POrCz+/u57joN8VXm0n2hbdVRt
         dkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772645563; x=1773250363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvZHzwfBez6SktFHis/UP+MVLhoMj8/M/nCRuUvbuQA=;
        b=b/07GZxMwXbyua3YhlSFoKfzOVs2MCLLss9a+dZvRF1HEDuVWckFacnerRyJFhdBcZ
         5o+bvCgPSsbpw2+YUgOs6bqZ5jbn+rODqXXl+aM7z2JAeb6YWqdKEAyWDqTK1oyXVRy1
         lQ5sgeg6LXzR4HfPAsqHXeLgmzPf/cyQFcY8TIBIbxfFvxcQzW5vRqaknZ9uROsXUiaj
         ANka4Islqkou7buuaBo4dLba0ltWvomEQIP7viRKRvosjRO6oViKaWvAV5jlLnBH//nF
         MD/rvV+dID5XqApV4/K2FBVel2ButtR98h2nRC9DM3Zhhas/97hwStHfZPM+Fm8sc2IO
         PipQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOrPZ0YvTyo4q2kGLrKQxDhwXo2tE8yjwMI400IrbnnPHwNvMA0onQeUyANHwfQVMdZkf4b0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLTGWVxC5sQ44b/dtB3Jdhs6w6+np5Z74l1gn0Cz7GALwCcjKP
	TG/0vU9WniWVlo/0kJ/ntdMZL1YtTE+NF0e3Win5Kx0aE4I3yrzXBb1kEavYS9iWO0s=
X-Gm-Gg: ATEYQzznx9lRUO+tfvHkqXP7woU6WrwhJUOTue/mPCisWPEHoVXNGb2NADJm3QmRuk2
	sjT6yx9eSklne4RHkNfDZUApvU6Au//w9Tk0/n69LYyOS/Dqv/aa9VRvpZfmgyGJcCtWpAScr6j
	wjfgv7xcnvP9J4HktruUS8LJ552NHKi3JUyC0FnHKWb0BFHlwbgxB5et0/HJGHcSceL2cI6u2Nk
	62WvduUAdYLmBmeCdG5frs+QNltvyaIZL/p/7zMGyWDTdezq0IRSU/sYhOeJSiUJzXqMoPOLnzL
	Ni5umV8kukHVWQX9PPtkAtd0qPbzG3bNtL6LUEqh1Y4gczhGkby+Cl1vBYHIvBFw39oQYXFGvk7
	ZgZxjWpmSGFKOjxvRybjjcsVoAbsPD/CDvQgE5lH0TG2630LHkBTapAN23rJkppgFldz7vwFxY3
	h4n/fWKoVRc/c4G8E6bl9IR2m62oCX87s0KBhCuKzYNAX+vHBEGZDixrBBwBo53fsvfAfo
X-Received: by 2002:a05:600c:34d6:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-4851983936cmr53536205e9.5.1772645562765;
        Wed, 04 Mar 2026 09:32:42 -0800 (PST)
Received: from localhost (176.111.182.151.kyiv.nat.volia.net. [176.111.182.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48518839ae7sm56386405e9.1.2026.03.04.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:32:42 -0800 (PST)
Date: Wed, 4 Mar 2026 19:32:40 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
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
Message-ID: <aahsuPt7cY8LxETN@penguin>
References: <20260304074301.35482-1-jiayuan.chen@linux.dev>
 <20260304074301.35482-2-jiayuan.chen@linux.dev>
 <aahWymAi_CtRG0gJ@penguin>
 <1293120.1772645248@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1293120.1772645248@famine>
X-Rspamd-Queue-Id: 1415D205318
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
	TAGGED_FROM(0.00)[bounces-263952-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,shopee.com,syzkaller.appspotmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linutronix.de,goodmis.org,lists.linux.dev];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,appspotmail.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,blackwall.org:dkim,blackwall.org:email,jvosburgh.net:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 09:27:28AM -0800, Jay Vosburgh wrote:
> Nikolay Aleksandrov <razor@blackwall.org> wrote:
> 
> >On Wed, Mar 04, 2026 at 03:42:57PM +0800, Jiayuan Chen wrote:
> >> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >> 
> >> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> >> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> >> when the bond mode is round-robin. If the bond device was never brought
> >> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> >> 
> >> The XDP redirect path can reach this code even when the bond is not up:
> >> bpf_master_redirect_enabled_key is a global static key, so when any bond
> >> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> >> interception is enabled for all bond slaves system-wide. This allows the
> >> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> >> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> >> reached on a bond that was never opened.
> >> 
> >> Fix this by allocating rr_tx_counter unconditionally in bond_init()
> >> (ndo_init), which is called by register_netdevice() and covers both
> >> device creation paths (bond_create() and bond_newlink()). This also
> >> handles the case where bond mode is changed to round-robin after device
> >> creation. The conditional allocation in bond_open() is removed. Since
> >> bond_destructor() already unconditionally calls
> >> free_percpu(bond->rr_tx_counter), the lifecycle is clean: allocate at
> >> ndo_init, free at destructor.
> >> 
> >> Note: rr_tx_counter is only used by round-robin mode, so this
> >> deliberately allocates a per-cpu u32 that goes unused for other modes.
> >> Conditional allocation (e.g., in bond_option_mode_set) was considered
> >> but rejected: the XDP path can race with mode changes on a downed bond,
> >> and adding memory barriers to the XDP hot path is not justified for
> >> saving 4 bytes per CPU.
> >> 
> >> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> >> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> >> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
> >> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >> ---
> >>  drivers/net/bonding/bond_main.c | 19 +++++++++++++------
> >>  1 file changed, 13 insertions(+), 6 deletions(-)
> >> 
> >
> >IMO it's not worth it to waste memory in all modes, for an unpopular mode.
> >I think it'd be better to add a null check in bond_rr_gen_slave_id(),
> >READ/WRITE_ONCE() should be enough since it is allocated only once, and
> >freed when the xmit code cannot be reachable anymore (otherwise we'd have
> >more bugs now). The branch will be successfully predicted practically always,
> >and you can also mark the ptr being null as unlikely. That way only RR takes
> >a very minimal hit, if any.
> 
> 	Is what you're suggesting different from Jiayuan's proposal[0],
> in the sense of needing barriers in the XDP hot path to insure ordering?
> 
> 	If I understand correctly, your suggestion is something like
> (totally untested):
> 

Basically yes, that is what I'm proposing + an unlikely() around that
null check since it is really unlikely and will be always predicted
correctly, this way it's only for RR mode.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index eb27cacc26d7..ac2a4fc0aad0 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -4273,13 +4273,17 @@ void bond_work_cancel_all(struct bonding *bond)
>  static int bond_open(struct net_device *bond_dev)
>  {
>  	struct bonding *bond = netdev_priv(bond_dev);
> +	u32 __percpu *rr_tx_tmp;
>  	struct list_head *iter;
>  	struct slave *slave;
>  
> -	if (BOND_MODE(bond) == BOND_MODE_ROUNDROBIN && !bond->rr_tx_counter) {
> -		bond->rr_tx_counter = alloc_percpu(u32);
> -		if (!bond->rr_tx_counter)
> +	if (BOND_MODE(bond) == BOND_MODE_ROUNDROBIN &&
> +	    !READ_ONCE(bond->rr_tx_counter)) {
> +		rr_tx_tmp = alloc_percpu(u32);
> +		if (!rr_tx_tmp)
>  			return -ENOMEM;
> +		WRITE_ONCE(bond->rr_tx_counter, rr_tx_tmp);
> +
>  	}
>  
>  	/* reset slave->backup and slave->inactive */
> @@ -4866,6 +4870,9 @@ static u32 bond_rr_gen_slave_id(struct bonding *bond)
>  	struct reciprocal_value reciprocal_packets_per_slave;
>  	int packets_per_slave = bond->params.packets_per_slave;
>  
> +	if (!READ_ONCE(bond->rr_tx_counter))
> +		packets_per_slave = 0;
> +
>  	switch (packets_per_slave) {
>  	case 0:
>  		slave_id = get_random_u32();
> 
> 	-J
> 
> 
> [0] https://lore.kernel.org/netdev/e4a2a652784ec206728eb3a929a9892238c61f06@linux.dev/
> 
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net

