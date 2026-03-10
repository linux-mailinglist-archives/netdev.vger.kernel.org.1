Return-Path: <netdev+bounces-266034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLe3M5wFsGlregIAu9opvQ
	(envelope-from <netdev+bounces-266034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:50:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 873FD24BA80
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 298BF30330CD
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B4C38A717;
	Tue, 10 Mar 2026 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="PXjZhYpl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F87238A703
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143374; cv=none; b=AoHKXmSXCWLYBRMFRgBZzorj/TK4FeY/6qNkEC2GPWdlpCZnds8fcyqX92KV1BZbbvLiKc3LHyjvYV94IkWozoy4QDEbsIkEivYDEg6aUMVf2b2KJL1aqd4U56uD5QvWH1CvdNt+aEe9on1L9QsuemiO2ntpRo4EXucVDJDDYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143374; c=relaxed/simple;
	bh=Zr3qcMn4OLx1slxxG1q/v6XHjn/W58Jij9qVOShgcro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjbURedlWcN+9mjW4gQUsru1NjVWXX/JEHuk5SzNCfIzMdWuiAUWVsQ7Z4QSmUPa+H9R7SySj+1sb8YpZ649/W8ZB/fH85hpjK6bPiLPMf6gEJsYZuMpHEBYkJkHzmR6MrlMu1a4yqEnwOH7/xgw1BHdSFry7MWLwg8XzTVwLRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=PXjZhYpl; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-466f00535cfso1998104b6e.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 04:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1773143372; x=1773748172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRz2iGuRS5c9gUYKqTban2ycHL3n1P/vxXJWakDhtNM=;
        b=PXjZhYpl/0RcIXC8chJ7scSvE5Gc0t9PMWcQuLETEA9mAUo997liJ6mkRtJLM98kvK
         zktcoxY40FQk0tM4to7SERn5YNKhzzaYvNr30l2pBagYy1rYJA29gdPO4UnLUgIzOKQQ
         gOWObrNLkUTL22syetszXwubcqcbJawC8B4XVal9HvVBQNcdVdChOunuk/AJXe2JstAy
         aT7sbbbSKuJbqZblzgLp/4ACm73zNfcr0OBJPfDOlTgLPkWmykXksuk74zdVSyafdiFb
         CcK7on7sPZ+TlthhdaWuXy/c2pH1Leuchq29jfh5IvzgB0rFWEidDmxXoiDG96KGtbZJ
         9KaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773143372; x=1773748172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRz2iGuRS5c9gUYKqTban2ycHL3n1P/vxXJWakDhtNM=;
        b=cLgojMUNnL2LOESA5I/qfHvE+rrjts7XvG8ctNWXYsX9X4Nmb9FiWxKivEFmEqn3cs
         Q2u48MxbEMYkPUv7Lx5fsfRe+co569Qw0eD2R3Mdv3OZc4CEjkv3EgQOQDGr90heii6t
         2boYAcpBOoYIr+0pRfys/q8Es4mrdY6LuHMu70MVM0OB2C0SV2mnlNXgVA6d4M7mSPSV
         HEV06PLMNSmM0isyVBYIL9ShiDIJppcoFbGqsmGBMHCJlCuAS+EqfqCYvExFcdSCIJXF
         3nGL0hE2KBwQ6afFuJgYuvmyVD8nykXxOZqImXzIrgBxdiI11YPZhRPpi0IUOQOeAPxF
         SO7Q==
X-Gm-Message-State: AOJu0YxxPlsX/9U0A4pNiB+l8zS2HzqDdZgfxysQqj3DsZUMrnti2Gni
	Bsd8pRQfGtH62oZ/rwvd63iIcb19F2vmPdPcWnViuOY7xdWAp50aHUZfk6Xc2bmHrgs=
X-Gm-Gg: ATEYQzyR3e+NFDnidKg+eEqwcCe/oOXkvMP/mNCrlMYu4uR8RH6yjR5xJsmkjMgWqns
	ybjpnceLoP7Pb71loCFwSV060fRY08gi+2w9WTAKVTJxSTH64IL0+F1LXk7kmJbaI/geA47IZZE
	tTYqiIPCPSpUUfoiIs7CIiIX+FEh6j2kSOUi+EhaFAHG7Q0P6Wc0sqDTwbAw1ppq7dCBuRrEiS4
	nfnqkfRvgnrZpyNmYTTdFF++Fps9XocHVe7htL/09FTlnkRhTYaZ7fm/ozWRK2ZZMWCL8z3A9MO
	co5lq9J1+ERdMQ4VxgWqhYUmhjDOaz7azDXrVaY592incGCr38oHPysbav+V/x7DhCAKZd9v2xE
	P3bPoLFZbr4Rf+CM1H3YnX3pPovrtFpNWStjlP3RaZpiK7SfrJnrNao2iANZ3Hd25LNnpiWkitb
	qAmxC+XRe+vFB4rb0Sdyh7
X-Received: by 2002:a05:6808:171a:b0:45c:a040:e53c with SMTP id 5614622812f47-466dcb1c40cmr7605844b6e.32.1773143372180;
        Tue, 10 Mar 2026 04:49:32 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfac3472sm7496849b6e.15.2026.03.10.04.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 04:49:30 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:49:25 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Jay Vosburgh <jv@jvosburgh.net>,
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
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
Message-ID: <abAFRbJNinhN3O5v@penguin>
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309030702.128520-2-jiayuan.chen@linux.dev>
X-Rspamd-Queue-Id: 873FD24BA80
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
	TAGGED_FROM(0.00)[bounces-266034-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,syzkaller.appspotmail.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,linutronix.de,goodmis.org,lists.linux.dev];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,shopee.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,blackwall.org:dkim,blackwall.org:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> when the bond mode is round-robin. If the bond device was never brought
> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> 
> The XDP redirect path can reach this code even when the bond is not up:
> bpf_master_redirect_enabled_key is a global static key, so when any bond
> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> interception is enabled for all bond slaves system-wide. This allows the
> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> reached on a bond that was never opened.
> 
> Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id()
> before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was
> never opened), fall back to get_random_u32() for slave selection. The
> allocation in bond_open() is kept, with WRITE_ONCE() added to safely
> publish the pointer to the XDP read side. A plain read suffices for the
> !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
> under RTNL lock and is the only writer of rr_tx_counter.
> 
> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  drivers/net/bonding/bond_main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

This is Jay's patch + the unlikely change, looks good to me.
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
 Nik

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 444519078da3..b8ec87625ce3 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -4290,9 +4290,11 @@ static int bond_open(struct net_device *bond_dev)
>  	struct slave *slave;
>  
>  	if (BOND_MODE(bond) == BOND_MODE_ROUNDROBIN && !bond->rr_tx_counter) {
> -		bond->rr_tx_counter = alloc_percpu(u32);
> -		if (!bond->rr_tx_counter)
> +		u32 __percpu *rr_tx_tmp = alloc_percpu(u32);
> +
> +		if (!rr_tx_tmp)
>  			return -ENOMEM;
> +		WRITE_ONCE(bond->rr_tx_counter, rr_tx_tmp);
>  	}
>  
>  	/* reset slave->backup and slave->inactive */
> @@ -4883,6 +4885,9 @@ static u32 bond_rr_gen_slave_id(struct bonding *bond)
>  	struct reciprocal_value reciprocal_packets_per_slave;
>  	int packets_per_slave = bond->params.packets_per_slave;
>  
> +	if (unlikely(!READ_ONCE(bond->rr_tx_counter)))
> +		return get_random_u32();
> +
>  	switch (packets_per_slave) {
>  	case 0:
>  		slave_id = get_random_u32();
> -- 
> 2.43.0
> 

