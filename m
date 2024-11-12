Return-Path: <netdev+bounces-144003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC68F9C5147
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275401F21831
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 08:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196E4204932;
	Tue, 12 Nov 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BnAehZw1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ln6TGg/n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lEGADL6E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wrMTumnS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CCC20C000
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401825; cv=none; b=dzKk3F/gB8aLqc5saaJmO5cDlFGVPJqhZGJkGiRD1fXjV09/F6BnQ1ZfQI8JxQ9dbL1mR2uFPHjohBQQgLB9KeJlE1LX1HBplLN86ekYCNerZrOmko67x+e7QWZABlmVhnkgTDtWJ5JAoe6YzFgEB7WKPhDfqfEuoTZ0PPC7MCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401825; c=relaxed/simple;
	bh=xHCfaELrEaBYK9mxOLePtDQGUmCp5gWwtkPRtv/CKic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxLZwSa8pxNSDpsWbM9lMTpQQ4f+/jIUTMR3c93GWOTNaKCSml7S6dU8LE+SpIUKpNtjORtVX8nvEO8pZ5H79Rb1ViaVgigUhx/+SM9jdfQXp0IRb+ekvZ0uBuFiUzGWhsGtxT41OX8xqT3AwpbsWY2QNp+glNKUwo4uw6sCbWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BnAehZw1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ln6TGg/n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lEGADL6E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wrMTumnS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEE841F396;
	Tue, 12 Nov 2024 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731401820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bwa+pBamx6WwgJJPJPYfJre2lQemc2GGnZehwF0QHyM=;
	b=BnAehZw102ZM2JWbRbZOicwAk9uAi95Egfr1UMrrggGL2Thsw+U2TzTokGFZhhBmRvPnOP
	rx/wS9Twj6sR+Nu4Twga+i0g8b0EpfUoWbTF+aQQZZDnvmUC4g4jys1FfjulACuBG7tmUb
	PYdxor2ivweykzax9iexOE/JFGiNZCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731401820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bwa+pBamx6WwgJJPJPYfJre2lQemc2GGnZehwF0QHyM=;
	b=Ln6TGg/nny3yRAX0GWufXgtMDYDEK4YiakuhLsP1UVTfHwWguIFozTcxDaq/Hk/tke+SU0
	iGi0Npu4Gf6hIMBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lEGADL6E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wrMTumnS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731401819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bwa+pBamx6WwgJJPJPYfJre2lQemc2GGnZehwF0QHyM=;
	b=lEGADL6EvOSqVB9TrmhCLlYz9h+lcjbc/ZaQ+ViWOu0W28DGG1q7dmpvsstaeH3xv4547U
	lJqeYZ6IgTbhJB58tQZUdP/f82kefLL7CMck6ao62okYScc0bo+1DoY/pRCCPxhnl81Gxy
	MQTjn9dqDwVVNwwY3XpcDBMY0ZtCZkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731401819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bwa+pBamx6WwgJJPJPYfJre2lQemc2GGnZehwF0QHyM=;
	b=wrMTumnSMwFQ2yvK3isVXv4V7DaPNEt3bcwy9O0AiqY5S48M3YJa/e02q4gypoqnIKoFw6
	6El3lkJpViOZBuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E329A13301;
	Tue, 12 Nov 2024 08:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rLdxN1sYM2erEgAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Tue, 12 Nov 2024 08:56:59 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 98687B6EA7; Tue, 12 Nov 2024 09:56:55 +0100 (CET)
Date: Tue, 12 Nov 2024 09:56:55 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: Xin Long <lucien.xin@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH] ipv6: route: release reference of dsts cached in
 sockets
Message-ID: <20241112085655.GA19776@incl>
References: <20240930180916.GA24637@incl>
 <CANn89iJQDWEyTC5Xc77PEXyxbbvKjm=exb5jKB0-O3ZzZ=W1Hg@mail.gmail.com>
 <20241001152609.GA24007@incl>
 <CADvbK_cmi_ppJyPwmh77dHgkm=Lh52vtEWddwSAFNhZpmmev6Q@mail.gmail.com>
 <20241003170126.GA20362@incl>
 <CADvbK_e_Etot3nzMC=FEt-cqoWfnER4SVOC5dOm6aH43iME1iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CADvbK_e_Etot3nzMC=FEt-cqoWfnER4SVOC5dOm6aH43iME1iA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Rspamd-Queue-Id: EEE841F396
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, Oct 06, 2024 at 02:25:25PM -0400, Xin Long wrote:
> We recently also encountered this
>
>   'unregister_netdevice: waiting for lo to become free. Usage count =3D X'
>
> problem on our customer env after backporting
>
>   Commit 92f1655aa2b22 ("net: fix __dst_negative_advice() race"). [1]
>
> The commit looks correct to me, so I guess it may uncover some existing
> issues.
>
> As it took a very long time to get reproduced on our customer env, which
> made it impossible to debug. Also the issue existed even after
> disabling IPv6.
>
> It seems much easier to reproduce it on your customer env. So I'm wonderi=
ng
>
> - Was the testing on your customer env related to IPv6 ?
> - Does the issue still exist after reverting the commit [1] ?

The customer tried reproducing the issue with 92f1655aa2b22 ("net: fix __ds=
t_negative_advice() race") reverted and the issue appeared again. My next s=
tep was capturing more points within the stacktraces when dst refcounts are=
 changed (I do not have full stack traces - the trace entries I store in th=
e hash contain only the instruction pointer and the parent function). This =
is the trace for the leaked dst object:
> dst ff1c4157413bf900
> alloc: 1 destroy:  obj diff: 1
> hold ops: 5 put ops: 4 refcnt diff: 1
> Function                            Parent                           Op  =
Net            Device Dst              Number of Calls
> inet6_csk_route_socket+0x1c2/0x2d0: inet6_csk_update_pmtu+0x58/0x90: dst =
ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> __ip6_rt_update_pmtu+0x183/0x3c0: inet6_csk_update_pmtu+0x4b/0x90: dst ff=
1c4151bcac1080 eth0 ff1c4157413bf900 1
> ip6_dst_lookup_flow+0x4f/0x1d0: inet6_csk_route_socket+0x198/0x2d0: dst f=
f1c4151bcac1080 eth0 ff1c4157413bf900 1
> ip6_dst_ifdown+0x5/0x250: dst_dev_put+0x2d/0xd0: dst ff1c4151bcac1080 eth=
0 ff1c4157413bf900 1
> tcp_v6_connect+0x37e/0x790: __inet_stream_connect+0x2c8/0x3a0: dst ff1c41=
51bcac1080 eth0 ff1c4157413bf900 2
> ip6_dst_lookup_flow+0x4f/0x1d0: tcp_v6_connect+0x320/0x790: dst ff1c4151b=
cac1080 eth0 ff1c4157413bf900 2
> __dev_queue_xmit+0x1af/0xd20: ip6_finish_output2+0x1f1/0x6e0: dst ff1c415=
1bcac1080 eth0 ff1c4157413bf900 675
> inet6_csk_xmit+0xa1/0x150: __tcp_transmit_skb+0x5f8/0xd40: dst ff1c4151bc=
ac1080 eth0 ff1c4157413bf900 675
> Function                            Parent                           Op  =
    Net            Device Dst              Refcount Diff
> ip6_route_output_flags+0x76/0x230: ip6_dst_lookup_tail+0x215/0x250: dst_h=
old ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> ip6_negative_advice+0x66/0x2d0: tcp_retransmit_timer+0x5ed/0xac0: dst_hol=
d ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> dst_alloc+0x5e/0x180: ip6_dst_alloc+0x27/0x60: dst_hold ff1c4151bcac1080 =
eth0 ff1c4157413bf900 1
> ip6_route_output_flags+0x76/0x230: ip6_dst_lookup_tail+0x10f/0x250: dst_h=
old ff1c4151bcac1080 eth0 ff1c4157413bf900 2
> dst_release+0x32/0x140: ip6_negative_advice+0x137/0x2d0: dst_put ff1c4151=
bcac1080 eth0 ff1c4157413bf900 1
> dst_release+0x32/0x140: inet_sock_destruct+0x146/0x1c0: dst_put ff1c4151b=
cac1080 eth0 ff1c4157413bf900 2
> dst_release+0x32/0x140: rt6_remove_exception.part.53+0x7f/0xe0: dst_put f=
fffffff90ee2a80 blackhole_dev ff1c4157413bf900 1
> Function                 Parent                      Op     Net          =
    Dst              Socket           Number of Calls
> sk_setup_caps+0x5/0x200: tcp_v6_connect+0x428/0x790: sk_dst ff1c4151bcac1=
080 ff1c4157413bf900 ff1c4158c07aaf80 1
> sk_setup_caps+0x5/0x200: tcp_v6_connect+0x428/0x790: sk_dst ff1c4151bcac1=
080 ff1c4157413bf900 ff1c418e49bac280 1
> sk_setup_caps+0x5/0x200: inet6_csk_route_socket+0x23c/0x2d0: sk_dst ff1c4=
151bcac1080 ff1c4157413bf900 ff1c418ea04f7200 1

The refcount of the dst was changed only when a dst_hold or dst_put operati=
on was logged. The hold in dst_alloc() is balanced by the dst_release() in =
rt6_remove_exception(). The three holds in ip6_route_output_flags() belonge=
d to the references held by sockets which were balanced by the dst_release(=
) in inet_sock_destruct(). But that leaves one hold operation outstanding a=
nd unbalanced. There is a put operation for expired cached dst objects in i=
p6_negative_advice() but that one is intentionally balanced by a hold in th=
e same function.

Accoding to the sk_dst trace entries, three sockets held a reference to the=
 leaked dst. All of these sockets were eventually distroyed so there was no=
 socket leak causing the dst leak, which rules out one of the possbile hypo=
theses. The dst was stored in the socket object while a connect() sycall wa=
s being executed for two of the sockets. An IMCPv6 packet carrying a Packet=
 Too Big message was received by the third socket, which lead to the execut=
ion of routines changing the MTU for the dst and storing a reference to the=
 dst in the socket object. As for races, sockets are locked in inet_stream_=
connect, tcp_write_timer() and tcp_v6_err(), and the mutual exclusion preve=
nts races when reference to dst objects are set and reset for sockets. The =
put operation executed from dst_release() in inet_sock_destruct() is not pa=
rt of a critical section protected by mutual exclusion but it is guaranteed=
 to run only after the refcount of the socket has reached zero. All the oth=
er code paths in the trace increment the refcount of the socket while they =
manipulate dsts (the connect() syscall uses the refcount incremented by the=
 socket() syscall).

This is a trace for the socket for which ip6_negative_advice() was executed=
 for an expired cached dst:
> socket ff1c4158c07aaf80
> alloc: 1 destroy: 1 obj diff: 0
> hold ops: 9 put ops: 9 refcnt diff: 0
> ip6_negative_advice+0xcd/0x2d0: tcp_retransmit_timer+0x5ed/0xac0: sk_dst =
ff1c4151bcac1080 0 ff1c4158c07aaf80 1
> tcp_retransmit_timer+0x50d/0xac0: tcp_write_timer_handler+0xba/0x1f0: sk_=
dst ff1c4151bcac1080 0 ff1c4158c07aaf80 2
> ip6_negative_advice+0x169/0x2d0: tcp_retransmit_timer+0x5ed/0xac0: sk_dst=
 ff1c4151bcac1080 0 ff1c4158c07aaf80 3
> sk_setup_caps+0x5/0x200: inet6_sk_rebuild_header+0x1f9/0x2a0: sk_dst ff1c=
4151bcac1080 ff1c4153a762d500 ff1c4158c07aaf80 5
> sk_setup_caps+0x5/0x200: tcp_v6_connect+0x428/0x790: sk_dst ff1c4151bcac1=
080 ff1c4157413bf900 ff1c4158c07aaf80 1
> sk_free+0x5/0x100: tcp_close+0x100/0x120: sk ff1c4151bcac1080 0 ff1c4158c=
07aaf80 1
> __sk_free+0x5/0x190: sk_free+0xe3/0x100: sk ff1c4151bcac1080 0 ff1c4158c0=
7aaf80 1
> sk_destruct+0x5/0x150: __sk_free+0x83/0x190: sk ff1c4151bcac1080 0 ff1c41=
58c07aaf80 1
> sk_alloc+0x195/0x2a0: inet6_create+0xd5/0x450: sk ff1c4151bcac1080 0 ff1c=
4158c07aaf80 1
> sk_free+0x5/0x100: ip6_rcv_core.isra.25+0x27c/0x440: sk ff1c4151bcac1080 =
0 ff1c4158c07aaf80 7
> sk_reset_timer+0x7b/0x130: tcp_connect+0x83f/0xe00: sk_hold ff1c4151bcac1=
080 0 ff1c4158c07aaf80 1
> __tcp_close+0x15d/0x4c0: tcp_close+0x35/0x120: sk_hold ff1c4151bcac1080 0=
 ff1c4158c07aaf80 1
> sock_init_data_uid+0x107/0x2d0: inet6_create+0xec/0x450: sk_hold ff1c4151=
bcac1080 0 ff1c4158c07aaf80 1
> sk_reset_timer+0x7b/0x130: tcp_retransmit_timer+0x4e3/0xac0: sk_hold ff1c=
4151bcac1080 0 ff1c4158c07aaf80 6
> tcp_close+0x5/0x120: inet_release+0x3c/0x80: sk_put ff1c4151bcac1080 0 ff=
1c4158c07aaf80 1
> inet_csk_destroy_sock+0x90/0x1e0: __tcp_close+0x2ca/0x4c0: sk_put ff1c415=
1bcac1080 0 ff1c4158c07aaf80 1
> tcp_write_timer+0x61/0x260: call_timer_fn+0x27/0x130: sk_put ff1c4151bcac=
1080 0 ff1c4158c07aaf80 7

Besides dst ff1c4157413bf900, this sockets held a reference to another dst =
- ff1c4153a762d500. Regardless of the order in which the dst references wer=
e held, the extra dst_hold() in ip6_negative_advice() would preserve the re=
fcount increment owned by the socket while also resetting the sk_dst_cache =
member of the socket to NULL, rendering it impossible for the socket to dec=
rement the refcount in the future. We see that the socket was destroyed but=
 the sk_dst_cache member was most probably NULL at the time because all the=
 dst references were reset in tcp_retransmit_timer() and ip6_negative_advic=
e().

Based on this data, I went back to recheck the kprobe module that was meant=
 to implement a dst_release() in ip6_negative_advice(). I found a mistake i=
n the module that resulted in executing:
> static void ip6_negative_advice(struct sock *sk, struct dst_entry *dst)
> {
>         struct rt6_info *rt =3D (struct rt6_info *) dst;
>         if (rt->rt6i_flags & RTF_CACHE) {
>                 rcu_read_lock();
>                 if (rt6_check_expired(rt)) {
>                         /* counteract the dst_release() in sk_dst_reset()=
 */
>                         dst_hold(dst);
>                         sk_dst_reset(sk);
>                         rt6_remove_exception_rt(rt);
>                 }
> --->		  kprobe_calls_dst_release;
>                 rcu_read_unlock();
>                 return;
>         }
>         sk_dst_reset(sk);
> }
instead of this:
> static void ip6_negative_advice(struct sock *sk, struct dst_entry *dst)
> {
>         struct rt6_info *rt =3D (struct rt6_info *) dst;
>         if (rt->rt6i_flags & RTF_CACHE) {
>                 rcu_read_lock();
>                 if (rt6_check_expired(rt)) {
>                         /* counteract the dst_release() in sk_dst_reset()=
 */
>                         dst_hold(dst);
> --->			  kprobe_calls_dst_release;
>                         sk_dst_reset(sk);
>                         rt6_remove_exception_rt(rt);
>                 }
>                 rcu_read_unlock();
>                 return;
>         }
>         sk_dst_reset(sk);
> }
which clearly shows why the test with the module resulted in negative overf=
low of dst refcounts. I fixed the module and further testing showed the iss=
ue is no longer reproducible.

I have managed to put together a minimal set of steps needed to reproduce t=
he issue:
ip link add veth1 mtu 65535 type veth peer veth0 mtu 65535
ip netns add ns0
ip link set veth1 netns ns0
ip addr add fd00::1/24 dev veth0
ip -n ns0 addr add fd00::2/24 dev veth1
ip link set up dev veth0
ip -n ns0 link set up dev lo
ip -n ns0 link set up dev veth1
ip -n ns0 route add default via fd00::1 dev veth1

ip link add veth3 mtu 65535 type veth peer veth2 mtu 65535
ip netns add ns2
ip link set veth3 netns ns2
ip addr add fd02::1/24 dev veth2
ip -n ns2 addr add fd02::2/24 dev veth3
ip link set up dev veth2
ip -n ns2 link set up dev lo
ip -n ns2 link set up dev veth3
ip -n ns2 route add default via fd02::1 dev veth3

ip netns exec ns0 bash -c "echo 6 > /proc/sys/net/ipv6/route/mtu_expires"
#ip netns exec ns2 bash -c "echo 6 > /proc/sys/net/ipv6/route/mtu_expires"
ip netns exec ns0 bash -c "echo 900 > /proc/sys/net/ipv6/route/gc_interval"
#ip netns exec ns2 bash -c "echo 900 > /proc/sys/net/ipv6/route/gc_interval"
sleep 30

ip6tables -F
ip6tables -A FORWARD -i veth0 -d fd02::/24 -j ACCEPT
ip6tables -A FORWARD -i veth2 -d fd00::/24 -j ACCEPT
echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
ip6tables -L -v

(ip netns exec ns2 netcat -6 -l -s fd02::2 -p 1234 &> /dev/null) & serv=3D$!
sleep 1
dd if=3D/dev/zero bs=3D1M count=3D100 | ip netns exec ns0 netcat -6 fd02::2=
 1234 & clnt=3D$!
sleep 1
kill $clnt $serv
wait $serv

(ip netns exec ns2 netcat -6 -l -s fd02::2 -p 1234 &> /dev/null) & serv=3D$!
sleep 1
dd if=3D/dev/zero bs=3D1M | ip netns exec ns0 netcat -6 fd02::2 1234 & clnt=
=3D$!
sleep 1
ip link set veth2 mtu 2000
sleep 1
ip6tables -D FORWARD -i veth2 -d fd00::/24 -j ACCEPT
ip6tables -A FORWARD -i veth2 -d fd00::/24 -j DROP

sleep 10
kill $clnt $serv
wait $serv

ip -n ns0 link set down dev lo
ip -n ns0 link set down dev veth1
ip -n ns0 link delete dev veth1
ip netns delete ns0

ip -n ns2 link set down dev lo
ip -n ns2 link set down dev veth3
ip -n ns2 link delete dev veth3
ip netns delete ns2

I was able to reproduce the dst leak under 6.12-rc7. I will submit a fix sh=
ortly.
--=20
Jiri Wiesner
SUSE Labs

