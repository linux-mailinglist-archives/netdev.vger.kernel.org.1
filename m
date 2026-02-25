Return-Path: <netdev+bounces-261091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDMZNdZqn2lKbwQAu9opvQ
	(envelope-from <netdev+bounces-261091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:34:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 381FF19DE09
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A81D1304A15A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE5A315D23;
	Wed, 25 Feb 2026 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8Udxl1V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZ/JfcSi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C2131690E
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055223; cv=none; b=ML5toTPPVRQQxQ3BKiDxSGW+vvX+X8kC/kX4mIQ4GNK8ea0rvYdQz5fs08LnGrcUxlygdtIcD0WougW1SPaxnAL+cOARMfN9hxYjRBWK2v+uU3drupDl41ZffBZZyO7cCAK7b84nsf9aCyZ+Ih48xiVjlyii9dFTj/JZL/a/vnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055223; c=relaxed/simple;
	bh=bZ2ZMwlCP2o/Rlsq0mwlNtlKwNxHbxt6YdF6EJpDnuQ=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=ryTQIj+CLLyVqmSU9tyxRhUpjLm6wiidnSbrD2KBcLJ4IWWEJ2MOM0OeAH7z3DKazJUwDdmRfnyub6ENqpCvBAiV2/fLXf1ZPDoj2jCxBokeSkiSCP0l81P+HjCr5UDCxPSW0NKVqj4RxbTU1gOj6jeRGASO3lzhOAI/bOz0lP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8Udxl1V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZ/JfcSi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772055220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lpb/h/+nGtK6lWBKP7Rci9ItOO88jR+UV7vuwANsvic=;
	b=b8Udxl1VN6ukiL1iHESZtSmvAoIzi/69drSxWHhgsVDQ550iTtiCr61A4kXO590bMuD5Xb
	WU2ahI/+Ngf204Gmj99f0GplWZPLZZb8TwwUGbVUJqXouN2Bi6Ud+LrvMbxIOozQwrPc07
	vH3jR+aW8I3RDvW6JTFOvp//AOl6y6Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-PX7EEg6EPo2pPvi6nMt_JQ-1; Wed, 25 Feb 2026 16:33:38 -0500
X-MC-Unique: PX7EEg6EPo2pPvi6nMt_JQ-1
X-Mimecast-MFC-AGG-ID: PX7EEg6EPo2pPvi6nMt_JQ_1772055218
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-437681ecd32so311179f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772055217; x=1772660017; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lpb/h/+nGtK6lWBKP7Rci9ItOO88jR+UV7vuwANsvic=;
        b=TZ/JfcSiWSANYre/C8gHgoORQ+L5Bp5CS907ag91j3YsshLPGywpgQlDqyEhrVFd4Q
         DSNAUAHqXygyATwxndJ6k3tmtj9LU8rBovj5QWuKIfsluWVa57CiYD/GsKUX4F1Q2kcU
         w8qRDxSSCi1g4mhJDhr+vrrK1kXNy5QK2on9CzfvH1q388xJPOmcRAbDbMtqOMIfRhC+
         x9qQp7ZOy66hE84Ze6tqzu3o9HcUMRkxGOdfh94YD3b1MFj0oSXoNo+mXIsXYs1Png8F
         Vkp/gK3eXYEORvm9f/A4h75+b2l5YkUkB6sVafiXrnR8HS0P1uqxKZcag85Uc6dBZqes
         kE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772055217; x=1772660017;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpb/h/+nGtK6lWBKP7Rci9ItOO88jR+UV7vuwANsvic=;
        b=vmfOuEzqaAre968WQDcSgbaUsRoJ9+oI0Nt376ZxnNqx7nixckStlCon/RVe2XzTBu
         31bpfYPHMudrzJdsyzIz7UionhwkIeijT+yUR4u9JoOxWI9t1o+26EoGGeI3HDD1dLq+
         ACNxqiZDl7l38VS7EOWGe+fv6T50cVYv07Zbqpu7g8B9IeSh7cwxrvPvs9bePV/dnYhr
         nyRZsv3PMEJCiQghEeyO59PUBThqkXFdHhTTsZk0sWwaV3EbHBacq3ZMQEib3Mx4DkDT
         jWeT+tXF2fib4i1e79Lpu9ai7erYBYVcpk5epnjhlcngUnmeNL5n0WYb9Zn9agmMa39O
         IAWg==
X-Forwarded-Encrypted: i=1; AJvYcCU4mpNSwkcMKUsQO3BUVWXZIm1A9MyNQxMPcRAASHTjb9ib6qeHbj4n7ae5DnB7OcUkmjp70yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFAH/krITIJAUgprGWlLCt8zHHCqbPKWP5Ejvx+dcDTQkAjOQ
	raZeEfcLkK0g5yYZ39I6GY9J+T0wklnYMjF9UHkxw0HWmfDjILZ6bke2lNkfYXr8j2N4JpgAxeU
	Y6kLmzWIduZpg3hwQJJezsj570HB9z97LXlAHwP8JQLgaE/sQark6BfI+EA==
X-Gm-Gg: ATEYQzz5C9+9DBOA8uhM4YF8EgqBT+qpxwetMKPAm5X/t0XaRmsd5Fk7/FheazA8jWJ
	4R6ucWnolvNwdJH88IjpyYsPxvSwHx5JmpBVhhiu+szUnLkM11RhruWqh9XZ5IoklNitH2zYt2D
	zgoOBxzumrPlOMRTaVu51tufd/2mu/6qcIgkEIzYDxybTne7BQ82FyAO+9pRZd3dyh0IBqU1I4R
	gvjlnUsDiS58iDo/iGA/uy0lK+QtLwQEVdI774H3wOPPheStFHjUNEPWZbcKFQNXjewa8aesTDL
	gxYXRj0PeZpA0YKenkQxvC03+rby/x+qYgKm46eEA2Ij9b5TeNz9vNpy8C0E7W4ni4LZrb3Jfta
	9PeBthb3o6KZZriQ9ifJaKWJo6UKZUTsG
X-Received: by 2002:a05:6000:1866:b0:430:f5ed:83e3 with SMTP id ffacd0b85a97d-43994294e7emr3889138f8f.6.1772055217222;
        Wed, 25 Feb 2026 13:33:37 -0800 (PST)
X-Received: by 2002:a05:6000:1866:b0:430:f5ed:83e3 with SMTP id ffacd0b85a97d-43994294e7emr3889084f8f.6.1772055216503;
        Wed, 25 Feb 2026 13:33:36 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9ff5sm38293907f8f.4.2026.02.25.13.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 13:33:35 -0800 (PST)
From: Stefano Brivio <sbrivio@redhat.com>
To: Simon Baatz <gmbnomis@gmail.com>
Cc: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, David Ahern
 <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>, Jason Xing
 <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, Shuah Khan
 <shuah@kernel.org>, Christian Ebner <c.ebner@proxmox.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/4] tcp: implement RFC 7323 window
 retraction receiver requirements
Message-ID: <20260225223325.34468327@elisabeth>
In-Reply-To: <aZ3o8RQehJDK_rcl@gandalf.schnuecks.de>
References: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com>
	<20260220-tcp_rfc7323_retract_wnd_rfc-v1-1-904942561479@gmail.com>
	<20260223232636.1ead2b3e@elisabeth>
	<aZ3o8RQehJDK_rcl@gandalf.schnuecks.de>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Feb 2026 22:33:34 +0100 (CET)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,proxmox.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-261091-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,gmbnomis.gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 381FF19DE09
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 19:07:45 +0100
Simon Baatz <gmbnomis@gmail.com> wrote:

> Hi Stefano,
> 
> On Mon, Feb 23, 2026 at 11:26:40PM +0100, Stefano Brivio wrote:
> > Hi Simon,
> > 
> > It all makes sense to me at a quick look, I have just some nits and one
> > more substantial worry, below:
> > 
> > On Fri, 20 Feb 2026 00:55:14 +0100
> > Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> >   
> > > From: Simon Baatz <gmbnomis@gmail.com>
> > > 
> > > By default, the Linux TCP implementation does not shrink the
> > > advertised window (RFC 7323 calls this "window retraction") with the
> > > following exceptions:
> > > 
> > > - When an incoming segment cannot be added due to the receive buffer
> > >   running out of memory. Since commit 8c670bdfa58e ("tcp: correct
> > >   handling of extreme memory squeeze") a zero window will be
> > >   advertised in this case. It turns out that reaching the required
> > >   "memory pressure" is very easy when window scaling is in use. In the
> > >   simplest case, sending a sufficient number of segments smaller than
> > >   the scale factor to a receiver that does not read data is enough.
> > > 
> > >   Since commit 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks") this
> > >   happens much earlier than before, leading to regressions (the test
> > >   suite of the Valkey project does not pass because of a TCP
> > >   connection that is no longer bi-directional).  
> > 
> > Ouch. By the way, that same commit helped us unveil an issue (at least
> > in the sense of RFC 9293, 3.8.6) we fixed in passt:
> > 
> >   https://passt.top/passt/commit/?id=8d2f8c4d0fb58d6b2011e614bc7d7ff9dab406b3  
> 
> This looks concerning: It seems as if just filling the advertised
> window triggered the out of memory condition(?).

Right, even if it's not so much a general "out of memory" condition:
it's just that the socket might simply refuse to queue more data at
that point (we run out of window space, rather than memory).

Together with commit e2142825c120 ("net: tcp: send zero-window ACK when
no memory"), we will even get zero-window updates in that case. Jon
raised the issue here:

  https://lore.kernel.org/r/20240406182107.261472-3-jmaloy@redhat.com/

but it was not really fixed. Anyway:

> Am I right in
> assuming that this happened with the original 1d2fbaad7cd8, not the
> relaxed version of tcp_can_ingest() from f017c1f768b?

...you're right. I wasn't even aware of f017c1f768b, thanks for
pointing that out. That seems to make things saner, and I don't expect
further issues at this point.

By the way of which, passt struggled talking to applications entirely
written in the 21st century. That's socat, I think started in 2001,
being used in Podman tests, and its only SO_RCVBUF-related fault is
that it uses the default 208 KiB value (from rmem_default) as a
starting value by... not doing anything.

Applications can set SO_RCVBUF and SO_SNDBUF to bigger values
(depending on rmem_max and wmem_max), but if they do, automatic tuning
of TCP buffer sizes (which allows exceeding rmem_max and wmem_max!) is
disabled. We used to do that in passt itself, and I eventually dropped
it here:

  https://passt.top/passt/commit/?id=71249ef3f9bcf1dbb2d6c13cdbc41ba88c794f06

because we might really need automatic tuning and the resulting big
buffers for high latency, high throughput connections.

> > > - Commit b650d953cd39 ("tcp: enforce receive buffer memory limits by
> > >   allowing the tcp window to shrink") addressed the "eating memory"
> > >   problem by introducing a sysctl knob that allows shrinking the
> > >   window before running out of memory.
> > > 
> > > However, RFC 7323 does not only state that shrinking the window is
> > > necessary in some cases, it also formulates requirements for TCP
> > > implementations when doing so (Section 2.4).
> > > 
> > > This commit addresses the receiver-side requirements: After retracting
> > > the window, the peer may have a snd_nxt that lies within a previously
> > > advertised window but is now beyond the retracted window. This means
> > > that all incoming segments (including pure ACKs) will be rejected
> > > until the application happens to read enough data to let the peer's
> > > snd_nxt be in window again (which may be never).
> > > 
> > > To comply with RFC 7323, the receiver MUST honor any segment that
> > > would have been in window for any ACK sent by the receiver and, when
> > > window scaling is in effect, SHOULD track the maximum window sequence
> > > number it has advertised. This patch tracks that maximum window
> > > sequence number throughout the connection and uses it in
> > > tcp_sequence() when deciding whether a segment is acceptable.
> > > Acceptability of data is not changed.
> > > 
> > > Fixes: 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze")
> > > Fixes: b650d953cd39 ("tcp: enforce receive buffer memory limits by allowing the tcp window to shrink")
> > > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > > ---
> > >  Documentation/networking/net_cachelines/tcp_sock.rst       |  1 +
> > >  include/linux/tcp.h                                        |  1 +
> > >  include/net/tcp.h                                          | 14 ++++++++++++++
> > >  net/ipv4/tcp_fastopen.c                                    |  1 +
> > >  net/ipv4/tcp_input.c                                       |  6 ++++--
> > >  net/ipv4/tcp_minisocks.c                                   |  1 +
> > >  net/ipv4/tcp_output.c                                      | 12 ++++++++++++
> > >  .../selftests/net/packetdrill/tcp_rcv_big_endseq.pkt       |  2 +-
> > >  8 files changed, 35 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
> > > index 563daea10d6c5c074f004cb1b8574f5392157abb..fecf61166a54ee2f64bcef5312c81dcc4aa9a124 100644
> > > --- a/Documentation/networking/net_cachelines/tcp_sock.rst
> > > +++ b/Documentation/networking/net_cachelines/tcp_sock.rst
> > > @@ -121,6 +121,7 @@ u64                           delivered_mstamp        read_write
> > >  u32                           rate_delivered                              read_mostly         tcp_rate_gen
> > >  u32                           rate_interval_us                            read_mostly         rate_delivered,rate_app_limited
> > >  u32                           rcv_wnd                 read_write          read_mostly         tcp_select_window,tcp_receive_window,tcp_fast_path_check
> > > +u32                           rcv_mwnd_seq            read_write                              tcp_select_window
> > >  u32                           write_seq               read_write                              tcp_rate_check_app_limited,tcp_write_queue_empty,tcp_skb_entail,forced_push,tcp_mark_push
> > >  u32                           notsent_lowat           read_mostly                             tcp_stream_memory_free
> > >  u32                           pushed_seq              read_write                              tcp_mark_push,forced_push
> > > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > > index f72eef31fa23cc584f2f0cefacdc35cae43aa52d..5a943b12d4c050a980b4cf81635b9fa2f0036283 100644
> > > --- a/include/linux/tcp.h
> > > +++ b/include/linux/tcp.h
> > > @@ -271,6 +271,7 @@ struct tcp_sock {
> > >  	u32	lsndtime;	/* timestamp of last sent data packet (for restart window) */
> > >  	u32	mdev_us;	/* medium deviation			*/
> > >  	u32	rtt_seq;	/* sequence number to update rttvar	*/
> > > +	u32	rcv_mwnd_seq; /* Maximum window sequence number (RFC 7323, section 2.4) */  
> > 
> > Nit: tab between ; and /* for consistency (I would personally prefer
> > the comment style as you see on 'highest_sack' but I don't think it's
> > enforced anymore).  
> 
> Thanks, I missed that.
>  
> > Second nit: mentioning RFC 7323, section 2.4 could be a bit misleading
> > here because the relevant paragraph there covers a very specific case of
> > window retraction, caused by quantisation error from window scaling,
> > which is not the most common case here. I couldn't quickly find a better
> > reference though.  
> 
> I agree, but there is a part that, I think, is more generally
> applicable:
> 
> 2.4.  Addressing Window Retraction
> 
>    [ specific window retraction case introduction removed ]
>    ... Implementations MUST ensure that they handle a shrinking
>    window, as specified in Section 4.2.2.16 of [RFC1122].
> 
>    For the receiver, this implies that:
> 
>    1)  The receiver MUST honor, as in window, any segment that would
>        have been in window for any <ACK> sent by the receiver.
> 
>    2)  When window scaling is in effect, the receiver SHOULD track the
>        actual maximum window sequence number (which is likely to be
>        greater than the window announced by the most recent <ACK>, if
>        more than one segment has arrived since the application consumed
>        any data in the receive buffer).
> 
> There is no "When window scaling is in effect," on the first
> requirement. And it "happens" to be implementable by the second
> requirement (with or without window scaling).

Right, I saw that, but the first requirement doesn't mention the
"actual maximum sequence number" which this new field represents.

> I think an improvement could be to refer to the receiver requirements
> specifically here.

Ah, yes, that sounds like a good idea.

> > More importantly: do we need to restore this on a connection that's
> > being dumped and recreated using TCP_REPAIR, or will things still work
> > (even though sub-optimally) if we lose this value?
> > 
> > Other window values that *need* to be dumped and restored are currently
> > available via TCP_REPAIR_WINDOW socket option, and they are listed in
> > do_tcp_getsockopt(), net/ipv4/tcp.c:
> > 
> > 		opt.snd_wl1	= tp->snd_wl1;
> > 		opt.snd_wnd	= tp->snd_wnd;
> > 		opt.max_window	= tp->max_window;
> > 		opt.rcv_wnd	= tp->rcv_wnd;
> > 		opt.rcv_wup	= tp->rcv_wup;
> > 
> > CRIU uses it to checkpoint and restore established connections, and
> > passt uses it to migrate them to a different host:
> > 
> >   https://criu.org/TCP_connection
> > 
> >   https://passt.top/passt/tree/tcp.c?id=02af38d4177550c086bae54246fc3aaa33ddc018#n3063
> > 
> > If it's strictly needed to preserve functionality, we would need to add
> > it to struct tcp_repair_window, notify CRIU maintainers (or send them a
> > patch), and add this in passt as well (I can take care of it).  
> 
> Thanks for the pointer, I missed that tp->rcv_wnd update.  Could the
> following happen when checkpointing/restoring?
> 
> 1. A client app opens a connection and writes (blocking) a specific amount
>    of data before doing any reads.  (Not very clever, but this is
>    supposed to work; this is what caused the problem in the Valkey
>    tests.)
> 2. The traffic pattern causes an out-of-memory condition for the
>    receive buffer; we see the RWIN 0 segments that do not ack the
>    last data segment(s).
> 3. TCP connection is checkpointed and restored (on the client side) without
>    restoring rcv_mwnd_seq.
> 4. If the receive buffer is still full at the new location, the
>    acceptable sequence numbers in the receive window will not change
>    (restored client is still blocked on write) and we no longer have
>    the larger max receive window -> the client's kernel will reject
>    all incoming packets and the connection is stuck.
> 
> If this scenario is possible, I'd argue that rcv_mwnd_seq is
> necessary.

It really sounds like a corner case, especially 1. in combination with
2., but the outcome would be pretty bad, and I think it's possible.

Typically, once the connection is restored (with TCP_REPAIR_OFF, not
with TCP_REPAIR_OFF_NO_WP), the kernel sends out an empty segment as a
window probe / keepalive, but as far as I understand that wouldn't be
enough to fix the situation. And even if it did, we still have the
TCP_REPAIR_OFF_NO_WP case, even though I'm not aware of any usage.

> > Strictly speaking, in case, this could be considered a breaking change
> > for userspace, but I don't see how to avoid it, so I'd just make sure
> > it doesn't impact users as TCP_REPAIR has just a couple of (known!)
> > projects relying on it.
> > 
> > An alternative would be to have a special, initial value representing
> > the fact that this value was lost, but it looks really annoying to not
> > be able to use a u32 for it.  
> 
> Do we need a dedicated value indicating that rcv_mwnd_seq is not
> present, or is it enough to choose an initial rcv_mwnd_seq based on
> the size of the struct passed?  Both seem doable to me:
> 
> Missing: Initialize rcv_mwnd_seq = rcv_wup + rcv_wnd (possibly
> leading to the problem described above, of course)

Well but if we might run into the problem described above, we need to
dump / restore rcv_mwnd_seq in any case, so we wouldn't have an issue
at all.

Except for a compatibility issue, but what you describe looks like a
reasonable fallback.

> Default value 0: Store how much we retracted the window, i.e. 
> rcv_mwnd_seq - (rcv_wup + rcv_wnd). 0 means the window was not
> retracted and could double as the "we don't know" value.
> 
> For the time being, I will just initialize rcv_mwnd_seq to rcv_wup +
> rcv_wnd in tcp_repair_set_window() to keep status quo. Of course,
> I am happy to discuss enhancements.

That makes sense to me at a glance, but I should still review / test it
as a whole though.

> > Disregard all this if the correct value is not strictly needed for
> > functionality, of course. I haven't tested things (not yet, at least).
> >   
> > >  	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
> > >  	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
> > >  	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
> > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > index 40e72b9cb85f08714d3f458c0bd1402a5fb1eb4e..e1944d504823d5f8754d85bfbbf3c9630d2190ac 100644
> > > --- a/include/net/tcp.h
> > > +++ b/include/net/tcp.h
> > > @@ -912,6 +912,20 @@ static inline u32 tcp_receive_window(const struct tcp_sock *tp)
> > >  	return (u32) win;
> > >  }
> > >  
> > > +/* Compute the maximum receive window we ever advertised.
> > > + * Rcv_nxt can be after the window if our peer push more data  
> > 
> > s/push/pushes/
> > 
> > s/Rcv_nxt/rcv_nxt/ (useful for grepping)  
> 
> tcp_max_receive_window() is an adapted copy of
> tcp_receive_window() above. But it makes sense to improve it.

Ah, sorry, I didn't notice.

> > > + * than the offered window.
> > > + */
> > > +static inline u32 tcp_max_receive_window(const struct tcp_sock *tp)
> > > +{
> > > +	s32 win = tp->rcv_mwnd_seq - tp->rcv_nxt;
> > > +
> > > +	if (win < 0)
> > > +		win = 0;  
> > 
> > I must be missing something but... if the sequence is about to wrap,
> > we'll return 0 here. Is that intended?
> > 
> > Doing the subtraction unsigned would have looked more natural to me,
> > but I didn't really think it through.  
> 
> The substraction is unsigned and the outcome is interpreted as
> signed. And as mentioned, it is copied with pride ;-)

Oh, wow, I mean, "of course"! How could anybody ever miss that! Pride,
you say. :) ...but sure, if it's taken from there, it makes sense to
keep it like that I guess.

> > > +	return (u32) win;  
> > 
> > Kernel coding style doesn't usually include a space between cast and
> > identifier.  
> 
> Yes, same reason as above and I will change it.

-- 
Stefano


