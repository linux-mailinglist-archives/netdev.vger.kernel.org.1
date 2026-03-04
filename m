Return-Path: <netdev+bounces-263895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB2tLadZqGlxtgAAu9opvQ
	(envelope-from <netdev+bounces-263895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:11:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F1B203DF9
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D71C306B056
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A6F35B65D;
	Wed,  4 Mar 2026 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="bCl7mpAT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C83222585
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639953; cv=none; b=PPq0p5qFaHnQbyXsWLxnl1zaWsr6BbqhCfoUjOJnaBABzVfVFsG+nlSdm5UDKZaDKj4UV7ih29+kOc5xdwh/NXXt39OHyJdBLIvurlk7lEuEKYHOkSkyLYa9qW4fLiVJoYTW0ixU6OFJ8bF2OS6kwkBCc7Pl4XiM3kzRd5Sl3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639953; c=relaxed/simple;
	bh=sRkO7eLIQ3gUqOEx4ySJKyymRH2K2LfoKGh++9p0oBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHQZr1MCeuKwdWS6EZQqCNd5KjaSTRCSpZMXkdDrH4XynJ1cnXCjgUgXzuwu/yCIhxm9kSGvoxfZ68fofzhyQsO/U1p47TeV5KqRoTcgnqvAD0dvyhiPw660GH8/JEri1rnlGF8YxKoaYqqjWmnHWIw7Ne6/XMZgICnnEhv6gEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bCl7mpAT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso58829185e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 07:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1772639949; x=1773244749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOSnZzfeSc3oCHq3PRnVd2F+xX7z1Nwp9tzlqrjRhhw=;
        b=bCl7mpATphtDitT/eSLxiEA6FtOIYGrpkTySJuJVnZiyRj41rVH10N6ylXXNJcoasi
         JuIc2+hmQ++Ja5/gsKlcal7/XTp+xh8nfblN5go2qu2QJLQeNVnJ4NXThFznSTlyl0We
         jTJ4oYxSdgPhhjrWcmBvZvZ/csYOhhTtSgkpX+qlwj0k1NCWQwO+2E7QrH56xXdsq3lx
         np5cNxcuPyXHDADxhrNVpJeKRU2VR5OK2WK51Q8JeGpZsQ4q6w6DstTeKZPVYN6G7lv8
         cJdfsXJRot7b8jyykENAjFS3lFAIvPoMCDLB7H1wq3p+bynF/CRsfz682RXxQEsIIGv5
         pA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639949; x=1773244749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOSnZzfeSc3oCHq3PRnVd2F+xX7z1Nwp9tzlqrjRhhw=;
        b=F5Zo+7wEwQuQ+HOD2flKr9D3eLMchMA9l1w6BPqutz29Z8rLbNinzbuhXGGFBrXa4W
         pw//HNtPjIisnOhnWDN9HVao6ceh1msXMwWJTnK8K0hXuhdhgCK/l1kEszKNPWxcfUHf
         ThRQvnb1Peu2WWN5P/IwXd7nQMeSlZWijkms5eoP+pgdSEkdyQ70wXbZ/CKPcNdd/Pcb
         feJWaiTcQA6hUrrsijb06pPRjZet0xKpHay5RVxEXrQFUzhR8bK1eB5043aqDXQe/agQ
         Y9seWhQSRIhYCPZsBod4u7rLNtuslrYWqU3Zo3Y8RTlb9J+bscCUocQA5v2Fbb9lBsbd
         DA0w==
X-Forwarded-Encrypted: i=1; AJvYcCU6Km20fqwmRjj7dHGuttsHo1Igq8qkVfVaF5D0TnK4FKgA9klU7rNWB+fjC+qEC4m89J3npTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxci7yuVvfZunCSd+nSDJha6LLwMUNF0TTh74jYw34WSa8Z7ANy
	2+sFExIy+nQB0nOGuisT2GYvJ/8lRka6A6pBCFHQytIdS68kFRjwV4DA2eMUeYjsEFg=
X-Gm-Gg: ATEYQzxatFZmr79kJ7UusoB78A11L8ataY/qSPdxNL6pjsrBS4IQ0CSOTUnSjcybWkQ
	djay91mmkk8zyyRp1BA0AwDXkd2qui6ZOJ4dGG/kP5XqxbRHtdajHJaIzJwtWGonCYcQbTw5SYK
	mUD0LI8bI5hoGmeJHwihtN0/CiAOdOb4vRGOGVOkTz/y+g6hvGb5nr2hrJGeBapv9ZaiAZz/jiH
	PdX/IyTTvqj3hwRZdM5o7iI5MF//QLwVrC2c0gse7wa0MuK62GL4XkzTiJQTgfLBuJ5ReoZc2wX
	YqUrojMehWtZtmP81JWGLgXKiVtGQ1UAEm0brhN5BtYATcviUPyY5SLe3rspR73qeFQg8aMZ3OM
	pDdJEPOi5MGGLjQItkIAy3PmWEepXaOP7ID8z6y3+O8OqVybqPHKQO3UsklT5LAVvAc8fWkjnPy
	TSTDI74tIiJFOGHT6bPLHP6NoweQ8hJX5+BU0OXjEpJ+LTvolr71g9sAfI4A==
X-Received: by 2002:a05:600c:3b29:b0:483:7980:4687 with SMTP id 5b1f17b1804b1-48519899381mr45743415e9.17.1772639948325;
        Wed, 04 Mar 2026 07:59:08 -0800 (PST)
Received: from localhost (176.111.182.151.kyiv.nat.volia.net. [176.111.182.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851acfa177sm21037355e9.4.2026.03.04.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:59:07 -0800 (PST)
Date: Wed, 4 Mar 2026 17:59:06 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: jv@jvosburgh.net, netdev@vger.kernel.org, jiayuan.chen@shopee.com,
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
Message-ID: <aahWymAi_CtRG0gJ@penguin>
References: <20260304074301.35482-1-jiayuan.chen@linux.dev>
 <20260304074301.35482-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304074301.35482-2-jiayuan.chen@linux.dev>
X-Rspamd-Queue-Id: B3F1B203DF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263895-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,blackwall.org:dkim,shopee.com:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 03:42:57PM +0800, Jiayuan Chen wrote:
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
> Fix this by allocating rr_tx_counter unconditionally in bond_init()
> (ndo_init), which is called by register_netdevice() and covers both
> device creation paths (bond_create() and bond_newlink()). This also
> handles the case where bond mode is changed to round-robin after device
> creation. The conditional allocation in bond_open() is removed. Since
> bond_destructor() already unconditionally calls
> free_percpu(bond->rr_tx_counter), the lifecycle is clean: allocate at
> ndo_init, free at destructor.
> 
> Note: rr_tx_counter is only used by round-robin mode, so this
> deliberately allocates a per-cpu u32 that goes unused for other modes.
> Conditional allocation (e.g., in bond_option_mode_set) was considered
> but rejected: the XDP path can race with mode changes on a downed bond,
> and adding memory barriers to the XDP hot path is not justified for
> saving 4 bytes per CPU.
> 
> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  drivers/net/bonding/bond_main.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 

IMO it's not worth it to waste memory in all modes, for an unpopular mode.
I think it'd be better to add a null check in bond_rr_gen_slave_id(),
READ/WRITE_ONCE() should be enough since it is allocated only once, and
freed when the xmit code cannot be reachable anymore (otherwise we'd have
more bugs now). The branch will be successfully predicted practically always,
and you can also mark the ptr being null as unlikely. That way only RR takes
a very minimal hit, if any.

Cheers,
 Nik

