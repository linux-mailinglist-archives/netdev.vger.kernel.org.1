Return-Path: <netdev+bounces-164849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE15A2F5F0
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6EA3A7A87
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C7F2566DD;
	Mon, 10 Feb 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="TtTQBdR3"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95C2566EF;
	Mon, 10 Feb 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209867; cv=pass; b=llj4qo8ZxH3Grnfk0lTTPhwYqURtRozeJUT8jCIvkzIFkNu/DPyWfFRZKOzBBrBQ/g4JLiDn3anfziTTH/UmLuXCgQoL7EMkbty7taJESTNOLRmttnp420Cq/EO+z5dO5MbbdWiknN0LVmn+0snBwdYiZ2JtzgfO7cSSQQq9alg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209867; c=relaxed/simple;
	bh=Or/KwVjh8GDidRInVvKZWuWlzhnxsEQ+Z2uxeI9FJfo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YDzJUh91fnAu3xC21WkzXbOPKcRmSkU5NuzY0vqiuRjw/vVNeq6Lp+XUfXMnSUmZBE8PAgVOccAxEFZjprQQHzH3n6xKDPm3yMIoMp8A5jrwDKijSyi8NU69Iq2oeIfxb0V131yo1qQdDBwAUzyoJIz/0RBJ/Vg8vFuJnklEYt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=TtTQBdR3; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YsBvS2LWWz49PyM;
	Mon, 10 Feb 2025 19:51:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739209862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/JLjAzVdUc28Ole8SV+/H8Mtprl6frKq1GhmgkRt6s=;
	b=TtTQBdR3eSXJ4C7kM44eNAT4vwOoSQUgg1mBQ1hibD+pTfAdN1a/a6YRB3gWdt6Bg64E0j
	UAWg2xCZKw6iqcox5KBq5EsCyTzY8CFawbsw/gb8tzFkPJOp1lN+p7teqU1rInhyC9Snbm
	p39NBC0OWG1ocDyXJM3eFdsLWWFWBkqNPRoP9ShOkmcvpPUdz5bDs3WDMgs4yemq1Ek4VF
	iDgwah9EOSTTlpd7sFBV4snKiy92YrHTNoOJEa/W7vJ66HWed+rMoMysaJ/OrfCUDBYv1E
	c2MOFyL7+VGYeCVyiZhg6Z+yQmVtTJNjuWK1aLdvcZjs4NEyezUvhVhsP/0xlA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739209862; a=rsa-sha256;
	cv=none;
	b=j9Oa6QXySHl8K1KbfahVi7fh7gKwQEDTctk+r0+uU/iwbYGVjn2E7dHiecgeGkM2Cmt7ag
	kpE6OwTnWkiKIXpMCC+4scHymx8IT7OMLIxUOA3VfyM4meAwf7G9QXMuMhjq1SItjRyC31
	lrJrA6QEv7KbgPn7zqgpLSLurQEy+dVVlW22Gtxt2EqHvALSba8TJ3xJaz0MxZjauyw1JP
	QBynaQRCROoQcT2G+uia8/F6x5u9ZsU1YUfBYxtFWMXkE90SLbSgm/aMhbO/OnFXE8PVNb
	+p80d73MqkTko2oTpsEU9+rzAi8bl++hQMZsCXFpbehG/HyFL+P943mbxi5yNA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739209862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/JLjAzVdUc28Ole8SV+/H8Mtprl6frKq1GhmgkRt6s=;
	b=CFdsoIbQzx1BATJg1COu3F+DrD8WcuTKHBGKK8imL55wAd+0QMV8b2i5EdjuwiSSpK23C7
	blmQ8Emk42ufyztmk/HDut3z9VgTZpw2mN64ZSAYZgtzHnDROe768xiH/2/bkvmA6auRGf
	sMpGAnxV1TApqDWk8F5IS9Zm8+i1ZFG+DlGG2QOQ1ggInOcDluLx2jCY+1P9eRhLPYyb3l
	s3EWHDfGt//7QZ0+EQbQsNvEhgAO+1iU4cQII+GC1Z9AeKQPuKXlWEYgCAuBx/cM6gw45A
	lWw0hNcZNyTXe1X1Un3TxTrbEU2O+QxeKfRhUOqwgGrxUHCJIpewKUX1IrkdeQ==
Message-ID: <0c86c0db795e1571143539ec7b3ea73d21f521a5.camel@iki.fi>
Subject: Re: [PATCH v3 1/5] net-timestamp: COMPLETION timestamp on packet tx
 completion
From: Pauli Virtanen <pav@iki.fi>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org
Date: Mon, 10 Feb 2025 19:50:57 +0200
In-Reply-To: <67a972a6e2704_14761294b0@willemb.c.googlers.com.notmuch>
References: <cover.1739097311.git.pav@iki.fi>
	 <71b88f509237bcce4139c152b3f624d7532047fd.1739097311.git.pav@iki.fi>
	 <67a972a6e2704_14761294b0@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

su, 2025-02-09 kello 22:29 -0500, Willem de Bruijn kirjoitti:
> Pauli Virtanen wrote:
> > Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software timestamp
> > when hardware reports a packet completed.
> >=20
> > Completion tstamp is useful for Bluetooth, where hardware tx timestamps
> > cannot be obtained except for ISO packets, and the hardware has a queue
> > where packets may wait.  In this case the software SND timestamp only
> > reflects the kernel-side part of the total latency (usually small) and
> > queue length (usually 0 unless HW buffers congested), whereas the
> > completion report time is more informative of the true latency.
> >=20
> > It may also be useful in other cases where HW TX timestamps cannot be
> > obtained and user wants to estimate an upper bound to when the TX
> > probably happened.
>=20
> Getting the completion timestamp may indeed be useful more broadly.
>=20
> Alternatively, the HW timestamp is relatively imprecisely defined so
> you could even just use that. Ideally, a hw timestamp conforms to IEEE
> 1588v2 PHY: first symbol on the wire IIRC. But in many cases this is
> not the case. It is not feasible at line rate, or the timestamp is
> only taken when the completion is written over PCI, which may be
> subject to PCI backpressure and happen after transmission on the wire.
> As a result, the worst case hw tstamp must already be assumed not much
> earlier than a completion timestamp.

For BT ISO packets, in theory hw-provided TX timestamps exist, and we
might want both (with separate flags for enabling them).=C2=A0I don't reall=
y
know, last I looked Intel HW didn't support them, and it's not clear to
which degree they are useful.

> That said, +1 on adding explicit well defined measurement point
> instead.
>
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >  Documentation/networking/timestamping.rst | 9 +++++++++
> >  include/linux/skbuff.h                    | 6 +++++-
> >  include/uapi/linux/errqueue.h             | 1 +
> >  include/uapi/linux/net_tstamp.h           | 6 ++++--
> >  net/ethtool/common.c                      | 1 +
> >  net/socket.c                              | 3 +++
> >  6 files changed, 23 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/networking/timestamping.rst b/Documentation/=
networking/timestamping.rst
> > index 61ef9da10e28..de2afed7a516 100644
> > --- a/Documentation/networking/timestamping.rst
> > +++ b/Documentation/networking/timestamping.rst
> > @@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
> >    cumulative acknowledgment. The mechanism ignores SACK and FACK.
> >    This flag can be enabled via both socket options and control message=
s.
> > =20
> > +SOF_TIMESTAMPING_TX_COMPLETION:
> > +  Request tx timestamps on packet tx completion.  The completion
> > +  timestamp is generated by the kernel when it receives packet a
> > +  completion report from the hardware. Hardware may report multiple
> > +  packets at once, and completion timestamps reflect the timing of the
> > +  report and not actual tx time. The completion timestamps are
> > +  currently implemented only for: Bluetooth L2CAP and ISO.  This
> > +  flag can be enabled via both socket options and control messages.
> > +
>=20
> Either we should support this uniformly, or it should be possible to
> query whether a driver supports this.
>=20
> Unfortunately all completion callbacks are driver specific.
>=20
> But drivers that support hwtstamps will call skb_tstamp_tx with
> nonzero hwtstamps. We could use that also to compute and queue
> a completion timestamp if requested. At least for existing NIC
> drivers.

Ok. If possible, I'd like to avoid changing the behavior of the non-
Bluetooth parts of net/ here, as I'm not familiar with those.

I guess a simpler solution could be that sock_set_timestamping() checks
the type of the socket, and gives EINVAL if the flag is set for non-
Bluetooth sockets?

One could then postpone having to invent how to check the driver
support, and user would know non-supported status from setsockopt
failing.

> >  1.3.2 Timestamp Reporting
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index bb2b751d274a..3707c9075ae9 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -489,10 +489,14 @@ enum {
> > =20
> >  	/* generate software time stamp when entering packet scheduling */
> >  	SKBTX_SCHED_TSTAMP =3D 1 << 6,
> > +
> > +	/* generate software time stamp on packet tx completion */
> > +	SKBTX_COMPLETION_TSTAMP =3D 1 << 7,
> >  };
> > =20
> >  #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
> > -				 SKBTX_SCHED_TSTAMP)
> > +				 SKBTX_SCHED_TSTAMP | \
> > +				 SKBTX_COMPLETION_TSTAMP)
>=20
> These fields are used in the skb_shared_info tx_flags field.
> Which is a very scarce resource. This takes the last available bit.
> That is my only possible concern: the opportunity cost.

If doing it=C2=A0per-protocol sounds ok, it could be put in bt_skb_cb
instead.

Since the completion timestamp didn't already exist, it maybe means
it's probably not that important for other parts of net/

> >  #define SKBTX_ANY_TSTAMP	(SKBTX_HW_TSTAMP | \
> >  				 SKBTX_HW_TSTAMP_USE_CYCLES | \
> >  				 SKBTX_ANY_SW_TSTAMP)
> > diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux/errqueu=
e.h
> > index 3c70e8ac14b8..1ea47309d772 100644
> > --- a/include/uapi/linux/errqueue.h
> > +++ b/include/uapi/linux/errqueue.h
> > @@ -73,6 +73,7 @@ enum {
> >  	SCM_TSTAMP_SND,		/* driver passed skb to NIC, or HW */
> >  	SCM_TSTAMP_SCHED,	/* data entered the packet scheduler */
> >  	SCM_TSTAMP_ACK,		/* data acknowledged by peer */
> > +	SCM_TSTAMP_COMPLETION,	/* packet tx completion */
> >  };
> > =20
> >  #endif /* _UAPI_LINUX_ERRQUEUE_H */
> > diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_t=
stamp.h
> > index 55b0ab51096c..383213de612a 100644
> > --- a/include/uapi/linux/net_tstamp.h
> > +++ b/include/uapi/linux/net_tstamp.h
> > @@ -44,8 +44,9 @@ enum {
> >  	SOF_TIMESTAMPING_BIND_PHC =3D (1 << 15),
> >  	SOF_TIMESTAMPING_OPT_ID_TCP =3D (1 << 16),
> >  	SOF_TIMESTAMPING_OPT_RX_FILTER =3D (1 << 17),
> > +	SOF_TIMESTAMPING_TX_COMPLETION =3D (1 << 18),
> > =20
> > -	SOF_TIMESTAMPING_LAST =3D SOF_TIMESTAMPING_OPT_RX_FILTER,
> > +	SOF_TIMESTAMPING_LAST =3D SOF_TIMESTAMPING_TX_COMPLETION,
> >  	SOF_TIMESTAMPING_MASK =3D (SOF_TIMESTAMPING_LAST - 1) |
> >  				 SOF_TIMESTAMPING_LAST
> >  };
> > @@ -58,7 +59,8 @@ enum {
> >  #define SOF_TIMESTAMPING_TX_RECORD_MASK	(SOF_TIMESTAMPING_TX_HARDWARE =
| \
> >  					 SOF_TIMESTAMPING_TX_SOFTWARE | \
> >  					 SOF_TIMESTAMPING_TX_SCHED | \
> > -					 SOF_TIMESTAMPING_TX_ACK)
> > +					 SOF_TIMESTAMPING_TX_ACK | \
> > +					 SOF_TIMESTAMPING_TX_COMPLETION)
> > =20
> >  /**
> >   * struct so_timestamping - SO_TIMESTAMPING parameter
> > diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> > index 2bd77c94f9f1..75e3b756012e 100644
> > --- a/net/ethtool/common.c
> > +++ b/net/ethtool/common.c
> > @@ -431,6 +431,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN=
] =3D {
> >  	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     =3D "bind-phc",
> >  	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   =3D "option-id-tcp",
> >  	[const_ilog2(SOF_TIMESTAMPING_OPT_RX_FILTER)] =3D "option-rx-filter",
> > +	[const_ilog2(SOF_TIMESTAMPING_TX_COMPLETION)] =3D "completion-transmi=
t",
>=20
> just "tx-completion"?

Ok.

--=20
Pauli Virtanen

