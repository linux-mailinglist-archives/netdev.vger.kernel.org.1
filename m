Return-Path: <netdev+bounces-145983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 603719D18A3
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 20:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC45E1F21EE4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 19:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFA01E130F;
	Mon, 18 Nov 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E7Tpcp8v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HZop6vl2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E7Tpcp8v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HZop6vl2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153B41A08BC
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731956751; cv=none; b=jhOoObMDYCkCImSqGYeMtq+E8/BkyJa20qV8fJioyAzTDuJS52Iz+qwyUep5JOs4BbSzS1I/BwcmgrTgD7fY4hM/LqZwemtG7rznfJHI8BXAVDE1lpqZPtKS2IN6mpKAzb23XFtkvbLmOulCZf+etatJG34b06VlF/4mgJN/ufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731956751; c=relaxed/simple;
	bh=AqEovV/E9pyJ5buqQrwg+P/YzJypYr+PH8VKkzH6qNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0FqBVhAfdzI25VgOW1ApZ5mOLp0fovF2OxZj3EaIpcsOpv4+dcjuVzj48ZFHr5pQ4XJwQaPrBrIdrYwXwGSGPXSQblIZKtk3qnSarFIXkFmfzFNmAwGGyk33ICjxzModBbajidaSpnzMCMXBZaoj1kx27q8kG/fa071lOPiW2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E7Tpcp8v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HZop6vl2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E7Tpcp8v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HZop6vl2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29965218A0;
	Mon, 18 Nov 2024 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731956747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEkMwGkyvDS2ljv353ZyNT3g0f4xxoQw2g3xOT/CVbE=;
	b=E7Tpcp8vx+3AnYGi6kLSzWPcFOH6/pbOpWeo7yCPbef4e4RH3oyHIkVXRpPqTKbM5SJ5R+
	88pZLkT3mHGVcvkFR3pDWoc5ENILU8jCU2l1RWZHFfkzrAjxxAPrKpp1/EmpP/W1Xxqmrk
	Etnq1BKPWSe5uWGa3WFQ0vZBY0SEEj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731956747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEkMwGkyvDS2ljv353ZyNT3g0f4xxoQw2g3xOT/CVbE=;
	b=HZop6vl2pTp74vqQdy8jY9T1qAJeyGcjBbXwo9dUbK9sqxz1AKBMfen6n3WhuK1jmLZ4jV
	BegXeRhxcsYSKcCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E7Tpcp8v;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HZop6vl2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731956747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEkMwGkyvDS2ljv353ZyNT3g0f4xxoQw2g3xOT/CVbE=;
	b=E7Tpcp8vx+3AnYGi6kLSzWPcFOH6/pbOpWeo7yCPbef4e4RH3oyHIkVXRpPqTKbM5SJ5R+
	88pZLkT3mHGVcvkFR3pDWoc5ENILU8jCU2l1RWZHFfkzrAjxxAPrKpp1/EmpP/W1Xxqmrk
	Etnq1BKPWSe5uWGa3WFQ0vZBY0SEEj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731956747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEkMwGkyvDS2ljv353ZyNT3g0f4xxoQw2g3xOT/CVbE=;
	b=HZop6vl2pTp74vqQdy8jY9T1qAJeyGcjBbXwo9dUbK9sqxz1AKBMfen6n3WhuK1jmLZ4jV
	BegXeRhxcsYSKcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05A081376E;
	Mon, 18 Nov 2024 19:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9AMJAQuQO2e9TAAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Mon, 18 Nov 2024 19:05:47 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 83317B6FE4; Mon, 18 Nov 2024 20:05:46 +0100 (CET)
Date: Mon, 18 Nov 2024 20:05:46 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
	yousaf.kaukab@suse.com, andreas.taschner@suse.com
Subject: Re: [PATCH net] net/ipv6: release expired exception dst cached in
 socket
Message-ID: <20241118190546.GC19776@incl>
References: <20241113105611.GA6723@incl>
 <9813fd57-1f0b-427f-aa47-e0486e6244fd@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9813fd57-1f0b-427f-aa47-e0486e6244fd@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Rspamd-Queue-Id: 29965218A0
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
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,gmail.com,suse.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Nov 14, 2024 at 12:04:36PM +0100, Paolo Abeni wrote:
> On 11/13/24 11:56, Jiri Wiesner wrote:
> > Dst objects get leaked in ip6_negative_advice() when this function is
> > executed for an expired IPv6 route located in the exception table. There
> > are several conditions that must be fulfilled for the leak to occur:
> > * an ICMPv6 packet indicating a change of the MTU for the path is received
> > * a TCP connection that uses the exception dst for routing packets must
> >   start timing out so that TCP begins retransmissions
> > * after the exception dst expires, the FIB6 garbage collector must not run
> >   before TCP executes ip6_negative_advice() for the expired exception dst
> > 
> > The following steps reproduce the issue:
> > 
> > ip link add veth1 mtu 65535 type veth peer veth0 mtu 65535
> > ip netns add ns0
> > ip link set veth1 netns ns0
> > ip addr add fd00::1/24 dev veth0
> > ip -n ns0 addr add fd00::2/24 dev veth1
> > ip link set up dev veth0
> > ip -n ns0 link set up dev lo
> > ip -n ns0 link set up dev veth1
> > ip -n ns0 route add default via fd00::1 dev veth1
> > 
> > ip link add veth3 mtu 65535 type veth peer veth2 mtu 65535
> > ip netns add ns2
> > ip link set veth3 netns ns2
> > ip addr add fd02::1/24 dev veth2
> > ip -n ns2 addr add fd02::2/24 dev veth3
> > ip link set up dev veth2
> > ip -n ns2 link set up dev lo
> > ip -n ns2 link set up dev veth3
> > ip -n ns2 route add default via fd02::1 dev veth3
> > 
> > ip netns exec ns0 bash -c "echo 6 > /proc/sys/net/ipv6/route/mtu_expires"
> > ip netns exec ns0 bash -c "echo 900 > /proc/sys/net/ipv6/route/gc_interval"
> > sleep 30
> > 
> > ip6tables -A FORWARD -i veth0 -d fd02::/24 -j ACCEPT
> > ip6tables -A FORWARD -i veth2 -d fd00::/24 -j ACCEPT
> > echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
> > 
> > (ip netns exec ns2 netcat -6 -l -s fd02::2 -p 1234 &> /dev/null) & serv=$!
> > sleep 1
> > dd if=/dev/zero bs=1M | ip netns exec ns0 netcat -6 fd02::2 1234 & clnt=$!
> > sleep 1
> > ip link set veth2 mtu 2000
> > sleep 1
> > ip6tables -D FORWARD -i veth2 -d fd00::/24 -j ACCEPT
> > ip6tables -A FORWARD -i veth2 -d fd00::/24 -j DROP
> > 
> > sleep 10
> > kill $clnt $serv
> > wait $serv
> > 
> > ip6tables -D FORWARD -i veth0 -d fd02::/24 -j ACCEPT
> > ip6tables -D FORWARD -i veth2 -d fd00::/24 -j DROP
> > 
> > ip -n ns0 link set down dev lo
> > ip -n ns0 link set down dev veth1
> > ip -n ns0 link delete dev veth1
> > ip netns delete ns0
> > 
> > ip -n ns2 link set down dev lo
> > ip -n ns2 link set down dev veth3
> > ip -n ns2 link delete dev veth3
> > ip netns delete ns2
> > 
> > This trace has been created with kprobes under kernel 6.12-rc7. Upon
> > receiving an ICMPv6 packet indicating an MTU change, exception dst
> > 0xff3027eec766c100 is created and inserted into the IPv6 exception table:
> > 3651.126884: rt6_insert_exception: (rt6_insert_exception+0x0/0x2b0) dst=0xff3027eec766c100 rcuref=0
> > 3651.126889: <stack trace>
> >  => rt6_insert_exception+0x5/0x2b0
> >  => __ip6_rt_update_pmtu+0x1ef/0x380
> >  => inet6_csk_update_pmtu+0x4b/0x90
> >  => tcp_v6_mtu_reduced.part.22+0x34/0xc0
> > The exception dst is used to route packets:
> > 3651.126902: inet6_csk_route_socket: (inet6_csk_update_pmtu+0x58/0x90 <- inet6_csk_route_socket) dst=0xff3027eec766c100
> > At this point, the connection has been severed and TCP starts retransmissions:
> > 3652.349466: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef4a0f3780 sk=0xff3027eeeb1f3d80
> > 3652.349497: inet6_csk_route_socket: (inet6_csk_xmit+0x56/0x130 <- inet6_csk_route_socket) dst=0xff3027eec766c100
> > 3652.769469: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef4a0f3780 sk=0xff3027eeeb1f3d80
> > 3652.769495: inet6_csk_route_socket: (inet6_csk_xmit+0x56/0x130 <- inet6_csk_route_socket) dst=0xff3027eec766c100
> > 3653.596135: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef4a0f3780 sk=0xff3027eeeb1f3d80
> > 3653.596156: inet6_csk_route_socket: (inet6_csk_xmit+0x56/0x130 <- inet6_csk_route_socket) dst=0xff3027eec766c100
> > 3655.249465: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef4a0f3780 sk=0xff3027eeeb1f3d80
> > 3655.249490: inet6_csk_route_socket: (inet6_csk_xmit+0x56/0x130 <- inet6_csk_route_socket) dst=0xff3027eec766c100
> > 3658.689463: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef4a0f3780 sk=0xff3027eeeb1f3d80
> > When ip6_negative_advice() is executed the refcount is 2 - the increment
> > made by dst_init() and the increment made by the socket:
> > 3658.689475: ip6_negative_advice: (ip6_negative_advice+0x0/0xa0) net=0xff3027ef4a0f3780 sk=0xff3027eeeb1f3d80 dst=0xff3027eec766c100 rcuref=1
> > This is the result of dst_hold() and sk_dst_reset() in ip6_negative_advice():
> > 3658.689477: dst_release: (dst_release+0x0/0x80) dst=0xff3027eec766c100 rcuref=2
> > 3658.689498: rt6_remove_exception_rt: (rt6_remove_exception_rt+0x0/0xa0) dst=0xff3027eec766c100 rcuref=1
> > 3658.689501: rt6_remove_exception: (rt6_remove_exception.part.58+0x0/0xe0) dst=0xff3027eec766c100 rcuref=1
> > The refcount of dst 0xff3027eec766c100 is decremented by 1 as a result of
> > removing the exception from the exception table with
> > rt6_remove_exception_rt():
> > 3658.689505: dst_release: (dst_release+0x0/0x80) dst=0xff3027eec766c100 rcuref=1
> > The retransmissions continue without the exception dst being used for
> > routing packets:
> > 3662.352796: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef00cab780 sk=0xff3027eeeb1f0000
> > 3662.769470: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef00cab780 sk=0xff3027eeeb1f0000
> > 3663.596132: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef00cab780 sk=0xff3027eeeb1f0000
> > 
> > The ip6_dst_destroy() function was instrumented but there was no entry for
> > dst 0xff3027eec766c100 in the trace even long after the ns0 and ns2 net
> > namespaces had been destroyed. The refcount made by the socket was never
> > released. The refcount of the dst is decremented in sk_dst_reset() but
> > that decrement is counteracted by a dst_hold() intentionally placed just
> > before the sk_dst_reset() in ip6_negative_advice(). The probem is that
> > sockets that keep a reference to a dst in the sk_dst_cache member
> > increment the refcount of the dst by 1. This is apparent in the following
> > code paths:
> > * When ip6_route_output_flags() finds a dst that is then stored in
> >   sk->sk_dst_cache by ip6_dst_store() called from inet6_csk_route_socket()
> > * When inet_sock_destruct() calls dst_release() for sk->sk_dst_cache
> > Provided the dst is not kept in the sk_dst_cache member of another socket,
> > there is no other object tied to the dst (the socket lost its reference
> > and the dst is no longer in the exception table) and the dst becomes a
> > leaked object after ip6_negative_advice() has finished.
> > 
> > As a result of this dst leak, an unbalanced refcount is reported for the
> > loopback device of a net namespace being destroyed under kernels that do
> > not contain e5f80fcf869a ("ipv6: give an IPv6 dev to blackhole_netdev"):
> > unregister_netdevice: waiting for lo to become free. Usage count = 2
> > 
> > Fix the dst leak by removing the dst_hold() in ip6_negative_advice(). The
> > patch that introduced the dst_hold() in ip6_negative_advice() was
> > 92f1655aa2b22 ("net: fix __dst_negative_advice() race"). But 92f1655aa2b22
> > merely refactored the code with regards to the dst refcount so the issue
> > was present even before 92f1655aa2b22. The bug was introduced in
> > 54c1a859efd9f ("ipv6: Don't drop cache route entry unless timer actually
> > expired.") where the expired cached route is deleted, the sk_dst_cache
> > member of the socket is set to NULL by calling dst_negative_advice() but
> > the refcount belonging to the socket is left unbalanced.
> > 
> > The IPv4 version - ipv4_negative_advice() - is not affected by this bug. A
> > nexthop exception is created and the dst associated with the socket fails
> > a check after the ICMPv6 packet indicating an MTU change has been
> > received. When the TCP connection times out ipv4_negative_advice() merely
> > resets the sk_dst_cache of the socket while decrementing the refcount of
> > the exception dst. Then, the expired nexthop exception is deleted along
> > with its routes in find_exception() while TCP tries to retransmit the same
> > packet again.
> > 
> > Fixes: 92f1655aa2b22 ("net: fix __dst_negative_advice() race")
> > Fixes: 54c1a859efd9f ("ipv6: Don't drop cache route entry unless timer actually expired.")
> > 
> > Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
> 
> The patch makes sense to me, but the changelog is very hard to follow,

I see. Thanks for the feedback.

> please:
> - move the testing code to a new, specific self-tests (possibly tuning
> the timeouts to a [much] shorter runtime)

I have been looking into turning the steps to reproduce the issue in a selftest script. I found out it is serious business and not something done in an hour, which made me question the need for creating a test for this issue. AFAIK, it is not common practice to supply a test script for every fix merged into the kernel. I could reduce the runtime to roughly 15 seconds but I think those 15 seconds would be wasted for testing an issue that may never come back unless someone decides to redesign sk_dst_reset() or rt6_remove_exception() in a rather disruptive way that would result in an unbalanced dst refcount again. I would much rather just drop the steps to reproduce the issue from the changelog. The commands themselves do not make the issue obvious unless someone runs them and uses a tracing approach to log what happens to dsts.

> - clearly separate the probe logs from the describing commenting text
> - try to be slightly a bit less verbose
> 
> Additionally please solve a formal problem above: there should be no
> white lines in the tag area between the Fixes and SoB tags.

I will send another patch implementing these suggestions.
J.

