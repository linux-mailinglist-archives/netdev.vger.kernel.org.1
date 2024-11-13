Return-Path: <netdev+bounces-144364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C869C6D40
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3098828214D
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42EE1FEFA1;
	Wed, 13 Nov 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PG1HtZm1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xmU8CF/A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PG1HtZm1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xmU8CF/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809A16DEB4
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495556; cv=none; b=HHvcjKuuXMG0xXlimdL+iz5Q0QBRmmYFgsgfq1uP8DYWFdlhZsoMtN+2YUD7W9i8mEWdad3gaoeKfvrgEgNWrBYk69NCcXG4pxwtVpAD8YPlVxEbb0KWaaMHl8vNu90Vdj5ynwW1jhs96s/dEA+Nhzp/8bfym5FKz33pU1UUses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495556; c=relaxed/simple;
	bh=9FeIHKe1uzz18RyY+J21/zF0O64zmnpZ/OVHK9ngV24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvxhSelm4BkMsF5b4hzv9z7y6/paOlDdbt7lkYnqHx5EHgBl4Nzbfg6poamqKe3VSfBnqs55rLMkZ2MaeB2chBy1fvZmWVS3vHojDuqGbl2RuxavMNVWhclHZT2HDaqrQgigWpZg/NYuG7sTwEISu+P1FFOlNeD0OGRA6lsuE/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PG1HtZm1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xmU8CF/A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PG1HtZm1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xmU8CF/A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B59D211CB;
	Wed, 13 Nov 2024 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731495553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0FDAN2F63MXR1d8O0vzocVQPndFV3If8O7vgyKaitA=;
	b=PG1HtZm1zsiqlvTDiH+JyfuSyz9efm1ATetcVUILVY4fQTvPs0rFtO+ycQ4gpo2NpzuXvn
	CNkfPFNDiO6RXH0s0b9BoCBXZTFnuJKjiBvsHYvWynAQw3Z/0g6K1jwmv9ST2ph4CHXhvd
	mKylWkT9UH0r/TA2WSQruf46F/yY5NE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731495553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0FDAN2F63MXR1d8O0vzocVQPndFV3If8O7vgyKaitA=;
	b=xmU8CF/AVKG6O1pHuApmlnum9bqWHujnLlQhUjGtFaTvZoCmpqbstEol4eIbQLMsw3yZb4
	aAQKkmZUwr70LdCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PG1HtZm1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="xmU8CF/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731495553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0FDAN2F63MXR1d8O0vzocVQPndFV3If8O7vgyKaitA=;
	b=PG1HtZm1zsiqlvTDiH+JyfuSyz9efm1ATetcVUILVY4fQTvPs0rFtO+ycQ4gpo2NpzuXvn
	CNkfPFNDiO6RXH0s0b9BoCBXZTFnuJKjiBvsHYvWynAQw3Z/0g6K1jwmv9ST2ph4CHXhvd
	mKylWkT9UH0r/TA2WSQruf46F/yY5NE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731495553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0FDAN2F63MXR1d8O0vzocVQPndFV3If8O7vgyKaitA=;
	b=xmU8CF/AVKG6O1pHuApmlnum9bqWHujnLlQhUjGtFaTvZoCmpqbstEol4eIbQLMsw3yZb4
	aAQKkmZUwr70LdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DD0913301;
	Wed, 13 Nov 2024 10:59:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +1AwC4GGNGc9QgAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Wed, 13 Nov 2024 10:59:13 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id D7488B6ED3; Wed, 13 Nov 2024 11:59:12 +0100 (CET)
Date: Wed, 13 Nov 2024 11:59:12 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: Xin Long <lucien.xin@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH] ipv6: route: release reference of dsts cached in
 sockets
Message-ID: <20241113105912.GB19776@incl>
References: <20240930180916.GA24637@incl>
 <CANn89iJQDWEyTC5Xc77PEXyxbbvKjm=exb5jKB0-O3ZzZ=W1Hg@mail.gmail.com>
 <20241001152609.GA24007@incl>
 <CADvbK_cmi_ppJyPwmh77dHgkm=Lh52vtEWddwSAFNhZpmmev6Q@mail.gmail.com>
 <20241003170126.GA20362@incl>
 <CADvbK_e_Etot3nzMC=FEt-cqoWfnER4SVOC5dOm6aH43iME1iA@mail.gmail.com>
 <20241112085655.GA19776@incl>
 <CADvbK_dz9ewsEmGa63DgMOwRwFyE-evALq61CUYi54-K_WTvog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvbK_dz9ewsEmGa63DgMOwRwFyE-evALq61CUYi54-K_WTvog@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Rspamd-Queue-Id: 3B59D211CB
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Tue, Nov 12, 2024 at 04:51:27PM -0500, Xin Long wrote:
> On Tue, Nov 12, 2024 at 3:57 AM Jiri Wiesner <jwiesner@suse.de> wrote:
> >
> > On Sun, Oct 06, 2024 at 02:25:25PM -0400, Xin Long wrote:
> > > We recently also encountered this
> > >
> > >   'unregister_netdevice: waiting for lo to become free. Usage count = X'
> > >
> > > problem on our customer env after backporting
> > >
> > >   Commit 92f1655aa2b22 ("net: fix __dst_negative_advice() race"). [1]
> > >
> > > The commit looks correct to me, so I guess it may uncover some existing
> > > issues.
> > >
> > > As it took a very long time to get reproduced on our customer env, which
> > > made it impossible to debug. Also the issue existed even after
> > > disabling IPv6.
> > >
> > > It seems much easier to reproduce it on your customer env. So I'm wondering
> > >
> > > - Was the testing on your customer env related to IPv6 ?
> > > - Does the issue still exist after reverting the commit [1] ?
> >
> > The customer tried reproducing the issue with 92f1655aa2b22 ("net: fix __dst_negative_advice() race") reverted and the issue appeared again. My next step was capturing more points within the stacktraces when dst refcounts are changed (I do not have full stack traces - the trace entries I store in the hash contain only the instruction pointer and the parent function). This is the trace for the leaked dst object:
> > > dst ff1c4157413bf900
> > > alloc: 1 destroy:  obj diff: 1
> > > hold ops: 5 put ops: 4 refcnt diff: 1
> > > Function                            Parent                           Op  Net            Device Dst              Number of Calls
> > > inet6_csk_route_socket+0x1c2/0x2d0: inet6_csk_update_pmtu+0x58/0x90: dst ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> > > __ip6_rt_update_pmtu+0x183/0x3c0: inet6_csk_update_pmtu+0x4b/0x90: dst ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> > > ip6_dst_lookup_flow+0x4f/0x1d0: inet6_csk_route_socket+0x198/0x2d0: dst ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> > > ip6_dst_ifdown+0x5/0x250: dst_dev_put+0x2d/0xd0: dst ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> > > tcp_v6_connect+0x37e/0x790: __inet_stream_connect+0x2c8/0x3a0: dst ff1c4151bcac1080 eth0 ff1c4157413bf900 2
> > > ip6_dst_lookup_flow+0x4f/0x1d0: tcp_v6_connect+0x320/0x790: dst ff1c4151bcac1080 eth0 ff1c4157413bf900 2
> > > __dev_queue_xmit+0x1af/0xd20: ip6_finish_output2+0x1f1/0x6e0: dst ff1c4151bcac1080 eth0 ff1c4157413bf900 675
> > > inet6_csk_xmit+0xa1/0x150: __tcp_transmit_skb+0x5f8/0xd40: dst ff1c4151bcac1080 eth0 ff1c4157413bf900 675
> > > Function                            Parent                           Op      Net            Device Dst              Refcount Diff
> > > ip6_route_output_flags+0x76/0x230: ip6_dst_lookup_tail+0x215/0x250: dst_hold ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> > > ip6_negative_advice+0x66/0x2d0: tcp_retransmit_timer+0x5ed/0xac0: dst_hold ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> > > dst_alloc+0x5e/0x180: ip6_dst_alloc+0x27/0x60: dst_hold ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> > > ip6_route_output_flags+0x76/0x230: ip6_dst_lookup_tail+0x10f/0x250: dst_hold ff1c4151bcac1080 eth0 ff1c4157413bf900 2
> > > dst_release+0x32/0x140: ip6_negative_advice+0x137/0x2d0: dst_put ff1c4151bcac1080 eth0 ff1c4157413bf900 1
> > > dst_release+0x32/0x140: inet_sock_destruct+0x146/0x1c0: dst_put ff1c4151bcac1080 eth0 ff1c4157413bf900 2
> > > dst_release+0x32/0x140: rt6_remove_exception.part.53+0x7f/0xe0: dst_put ffffffff90ee2a80 blackhole_dev ff1c4157413bf900 1
> > > Function                 Parent                      Op     Net              Dst              Socket           Number of Calls
> > > sk_setup_caps+0x5/0x200: tcp_v6_connect+0x428/0x790: sk_dst ff1c4151bcac1080 ff1c4157413bf900 ff1c4158c07aaf80 1
> > > sk_setup_caps+0x5/0x200: tcp_v6_connect+0x428/0x790: sk_dst ff1c4151bcac1080 ff1c4157413bf900 ff1c418e49bac280 1
> > > sk_setup_caps+0x5/0x200: inet6_csk_route_socket+0x23c/0x2d0: sk_dst ff1c4151bcac1080 ff1c4157413bf900 ff1c418ea04f7200 1
> >
> > The refcount of the dst was changed only when a dst_hold or dst_put operation was logged. The hold in dst_alloc() is balanced by the dst_release() in rt6_remove_exception(). The three holds in ip6_route_output_flags() belonged to the references held by sockets which were balanced by the dst_release() in inet_sock_destruct(). But that leaves one hold operation outstanding and unbalanced. There is a put operation for expired cached dst objects in ip6_negative_advice() but that one is intentionally balanced by a hold in the same function.
> >
> This makes sense to me.
> 
> The code prior to 92f1655aa2b22 ("net: fix __dst_negative_advice()
> race") had no longer been able to release the cached dst for the
> reference held by socket in ip6_negative_advice() since
> rt6_remove_exception_rt() is called there.
> 
> Hi, David Ahern,
> 
> Can you confirm this?

I have submitted "[PATCH net] net/ipv6: release expired exception dst cached in socket" which should have clearer explanations not burdened by the debugging process. I initially debugged the issue on a customer's server without having any idea how to reproduce it. I then reconstructed the steps to reproduce the issue from the tracing data, which allowed me to check for the issue in the latest upstream kernel.
-- 
Jiri Wiesner
SUSE Labs

