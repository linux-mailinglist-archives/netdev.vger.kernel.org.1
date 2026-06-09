Return-Path: <netdev+bounces-297093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xYJgAcQrKGr3/QIAu9opvQ
	(envelope-from <netdev+bounces-297093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:05:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CCC661826
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:05:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lzd9H3ra;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297093-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297093-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1093313CF5A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8774942B75A;
	Tue,  9 Jun 2026 14:56:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7EC42EEBC
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:56:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016998; cv=none; b=b4lQIZDnJ1xoMbMlG+I1kAZnVFasaUa7I48w+OhnQVpqsR1J7by5wXJN3IVVXI0izk0562m43tpB09wWMHXyE32HOwf99PCdgH1ewmSlXdCoHotj4ne8DVY1VgpaipY1FM4G+B9y0IpX+KEmz17DPDcndWJoVJsP/h2gfrZu1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016998; c=relaxed/simple;
	bh=DEqV/5lbvI7FW5PrAQgd6Rsld5mnlLYTjPCWlMhrEUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzplqnLaeAEFaum9nvBGwUg0oUMEMDSNbXuFxvi1NaZ4bXJwpul+hSUAyj89UWoDeh37pdQ+GIexV9OQrWKIvJUzipo6NRZlb+rj93sLzLDogrJsvMdoau5Tv7Cj4lQRZEZqDtljjdfVP1R1hWsi2kJlFr2m3DTpzbfsEvkluM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzd9H3ra; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b613a17bso55625955e9.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781016991; x=1781621791; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c5H6d+PxNTRxYv/fcH54sKszc+kAyuBoGvl6RAm/GWo=;
        b=lzd9H3raPvLSYW6my3bJ6uMNw1qP4R8kz29UCuUxfI97JYCEKvYlFUYw92X3cu3svQ
         zG6NZehEyT7hpb+A4K4yKEhKoeQGfPUEAA3E1KbBcDt0+gGJTEqNQjTEPumE7mFCFk4U
         GaMBdBLS2YQUSFfVxup2Jzh8wCcBo/ynFQT1Hw+F/F5f9PEQkqVi3VbDs20Tl+N8xVc8
         G426qWIRrD1Vnj2dJMYwZuy3KlcUcT6cju2Kv/oAbNFa3R2doFFBD3PRvKDFNANF2DmY
         U1HSlvILwFzLMhoZb3Gk21+C01uM8Av233UIfojoCGvlOx0RY/7+ubSFQvMLIUhxXvse
         0C5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016991; x=1781621791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5H6d+PxNTRxYv/fcH54sKszc+kAyuBoGvl6RAm/GWo=;
        b=EGntxNW2Q7Y8FutQpCCdCIzcy4Yt18zK7K9UVrp8hzk7ss55AsJYbLvfH/MzrdDS9o
         vSTIiDI5XdJfAouT/zvMfqkAMO1X52appJ9AjR2Ww2Dt+CzaH/HAYHVY3zZcUdiVpQe3
         l4liDb8GSZlWKRRgYYvuTCZGMiqx0ranAUmjW+Wh/V89niGHDa4RGBlaqREg6cyIAe7n
         EMJ7/qa6+t7kbfCGP4+LqeeYpEQKiacWMExP8/sZY5JcyTUWYbx4255QGhbAvwpEV8pB
         I2YGLd7+0PaNYJ7N2Rmu4ftOeVSA7Rj7xW/X3C6OUO4ArGvUzLLKXKIuwzYQuimOzY63
         /K0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+KVFeWZfh14v45wuK6hARzpGZl3Qu+S+KJ2qzeDk3xtenIQA6CnBBy33cVdZ5T+5hegwxZsbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywecbl0pbkp6O/UFW8DzBkHXzdMzFxXPr5fEC+840xZqrIT+gCR
	xkBirOowc5fDl0W6pZmBaMf8ZdUF02akHnCuglAVm5DsNmdOKCtP0yDY
X-Gm-Gg: Acq92OHErm33s+vOMfH/Q8WhyQcfIy8YQtfBj1JWnIY70GfXC+gqTDXEqN0Nn40qZg/
	WdGmHaKtvRT4IwDDjJ7cfb4r2RnnFPmwOK4tPoKF5NJh+XwBWR1h29l+81KYqdOIflsfpWrDW3O
	ZKvAfamE/aXVojRNvjLTU9ZLj/d0TMRYrMSy0vQ/Lj+6+fnNe38n+Zvew9cltf++qsTqxRXw6iR
	8B7DE9jvL62uvE+IGQCCulU7EQUhFgz+QLgeeHerxuCN8KAoF6pKKR+VruV7HecM4L11SSm/bEu
	Qo1KFQMBx23X5z7zPNENUtqSn8oEKKrV+eXJWii157KHG5EMG3WIzaBpBmTrcKKE88kZ4ouhKm+
	2D5vN+1KLwnN+jo/1oSLiExDfM7+/9DqjN3Q4E/7dNKErEAuhRRoVv2/9fbLBNWbmZMyjrzbFF0
	siPjg7Ualcfe5AxUMsZtAKYITbE6zvIWh3RHRxGFN4xYNhtsSnvSP3prQGmEhGGPzHQTM6/w==
X-Received: by 2002:a05:600c:5292:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-490d722e5ffmr41869745e9.27.1781016990451;
        Tue, 09 Jun 2026 07:56:30 -0700 (PDT)
Received: from gandalf.schnuecks.de (p5b2e2404.dip0.t-ipconnect.de. [91.46.36.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcb13sm63493070f8f.2.2026.06.09.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:56:29 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 3355231983B2; Tue, 09 Jun 2026 16:56:29 +0200 (CEST)
Date: Tue, 9 Jun 2026 16:56:29 +0200
From: Simon Baatz <gmbnomis@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: refine tcp_sequence() for the FIN exception
Message-ID: <aigpnYzdgKSF8FZ4@gandalf.schnuecks.de>
References: <20260608151452.706822-1-edumazet@google.com>
 <aic-SfHAIsYCswa7@gandalf.schnuecks.de>
 <CANn89iKybuU_JmTtt2U3JZJZp62oU-0ZXDdWb3vROZLhu+fzSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKybuU_JmTtt2U3JZJZp62oU-0ZXDdWb3vROZLhu+fzSQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-297093-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53CCC661826

On Mon, Jun 08, 2026 at 05:45:30PM -0700, Eric Dumazet wrote:
> On Mon, Jun 8, 2026 at 3:12???PM Simon Baatz <gmbnomis@gmail.com> wrote:
> >
> > Hi Eric,
> >
> > On Mon, Jun 08, 2026 at 03:14:52PM +0000, Eric Dumazet wrote:
> > > Commit 0e24d17bd966 ("tcp: implement RFC 7323 window retraction
> > > receiver requirements") removed the special FIN case that
> > > was added in commit 1e3bb184e941 ("tcp: re-enable acceptance of
> > > FIN packets when RWIN is 0").
> >
> > Commit 0e24d17bd966 did not remove the special handling; it is still
> > present and covered by the test "tcp_rcv_zero_wnd_fin.pkt".
> >
> > > If a peer sends a segment containing data and a FIN flag before
> > > it learns about our window retraction and has a buggy TCP stack,
> > > it might place the FIN one byte beyond what it thinks is the
> > > right edge of the window (i.e., max_window_edge + 1).
> >
> > The FIN exception in tcp_data_queue() is not a generic allowance for
> > incorrect FIN handling.  It is much more specific and only applies
> > when:
> >
> > 1. the packet is in-sequence
> > 2. RWIN == 0
> > 3. the packet is a bare FIN
> >
> > > The data portion (end_seq - th->fin) will end exactly at max_window_edge.
> > > In this case, we will drop the packet if our receive queue is not empty,
> > > even though the data was sent within the window we previously allowed.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Simon Baatz <gmbnomis@gmail.com>
> > > ---
> > >  net/ipv4/tcp_input.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index ab7a4e5435a8a2cbb532d42c54af76d8541c903b..8560a9c6d38207c098d673497caf2c7652c36f5c 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -4812,18 +4812,20 @@ static enum skb_drop_reason tcp_sequence(const struct sock *sk,
> > >                                        const struct tcphdr *th)
> > >  {
> > >       const struct tcp_sock *tp = tcp_sk(sk);
> > > +     u32 seq_limit;
> > >
> > >       if (before(end_seq, tp->rcv_wup))
> > >               return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
> > >
> > > -     if (unlikely(after(end_seq, tp->rcv_nxt + tcp_max_receive_window(tp)))) {
> > > +     seq_limit = tp->rcv_nxt + tcp_max_receive_window(tp);
> > > +     if (unlikely(after(end_seq, seq_limit))) {
> > >               /* Some stacks are known to handle FIN incorrectly; allow the
> > >                * FIN to extend beyond the window and check it in detail later.
> > >                */
> > > -             if (!after(end_seq - th->fin, tp->rcv_nxt + tcp_receive_window(tp)))
> > > +             if (!after(end_seq - th->fin, seq_limit))
> > >                       return SKB_NOT_DROPPED_YET;
> >
> > It is not clear which additional case this change is intended to
> > allow.  Are you sure such a packet would not be rejected by later
> > checks in the data path?
> >
> > (For the existing FIN exception, the previous condition also seems
> > broader than necessary. Actually, it should be sufficient to use
> > "!after(end_seq - th->fin, tp->rcv_nxt)")
> 
> It is possible our internal sashiko instance got this wrong.
> 
> <quote>
> If tcp_max_receive_window() is greater than tcp_receive_window()
> (i.e. the window was shrunk), and end_seq is after tcp_max_receive_window(),
>  then end_seq - th->fin will always be after tcp_receive_window().
> Does this mean the FIN workaround is disabled when the window has been shrunk?
>  Should this use tcp_max_receive_window() instead?
> </quote>
> 
> Can you suggest an alternative? Why using two confusing variants of
> what should be the same stuff?

Judging from past discussions, I think you prefer us to be strict in
tcp_sequence(), so I think we should replicate the conditions
(in-sequence, RWIN == 0, bare FIN) for the FIN exception in
tcp_data_queue() closely here.  I’ll send a patch that mirrors those
conditions in tcp_sequence().
 
> Other points from sashilko:
> 
> > @@ -7185,6 +7183,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
> >  */
> >  WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
> >  tp->rcv_wup = TCP_SKB_CB(skb)->seq + 1;
> > + tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
> >
> >  /* RFC1323: The window in SYN & SYN/ACK segments is
> >  * never scaled.
> 
> Since the SYN packet only advertises min(tp->rcv_wnd, 65535U), does setting
> rcv_mwnd_seq to tp->rcv_wup + tp->rcv_wnd here track a much larger window than
> was actually advertised if tp->rcv_wnd is greater than 65535? If window scaling
> is not negotiated, this maximum window sequence number will remain inflated.
> Should this be clamped to 65535?

We should never violate the tcp_receive_window() <=
tcp_max_receive_window() invariant in my opinion.  The point above
extends to tp->rcv_wnd itself, since that value is used to decide
e.g. when to send ACKs and thus, should also reflect the actual
RWIN.  I proposed to improve this in:

https://lore.kernel.org/netdev/20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com/

These inflated internal tcp_(max_)receive_window() values do occur in
"real life".  Here is a "ss -mit" output for a connection initiated
by an IoT (WiFi) device (connection is more than 2 days old at this
point):

ESTAB 0      0      192.168.74.95:mqtt  192.168.74.115:62897
   skmem:(r0,rb3538217,t0,tb87040,f0,w0,o0,bl0,d3557) cubic rto:373 rtt:152.029/44.771 ato:40 mss:1460 pmtu:1500 rcvmss:798 advmss:1460 cwnd:2 ssthresh:7 bytes_sent:13991 bytes_retrans:4 bytes_acked:13987 bytes_received:1022266 segs_out:16098 segs_in:21817 data_segs_out:6986 data_segs_in:14168 send 154kbps lastsnd:16433 lastrcv:16434 lastack:16240 pacing_rate 307kbps delivery_rate 3.96Mbps delivered:6985 app_limited busy:952155ms retrans:0/2 rcv_rtt:184612 rcv_space:64858 rcv_ssthresh:1021970 minrtt:14.059 snd_wnd:4993 rcv_wnd:1021440 rehash:2

That device has around 50KB of RAM and, consequently, a very
minimalistic TCP implementation (no TS, no window scaling). So all
calculations/decisions based on tcp_(max_)receive_window() operate on
a value that is off by a factor of 15 from the advertised value.

(Before you ask: The huge rb3538217 is caused by having no TS and the
window-based rcv_rtt estimator not delivering sensible results for
such a messaging-style connection.  The connection started with the
default rb131072.)

> [ ... ]
> 
> > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > --- a/net/ipv4/tcp_minisocks.c
> > +++ b/net/ipv4/tcp_minisocks.c
> > @@ -612,6 +612,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
> >  newtp->window_clamp = req->rsk_window_clamp;
> >  newtp->rcv_ssthresh = req->rsk_rcv_wnd;
> >  newtp->rcv_wnd = req->rsk_rcv_wnd;
> > + newtp->rcv_mwnd_seq = newtp->rcv_wup + req->rsk_rcv_wnd;
> >  newtp->rx_opt.wscale_ok = ireq->wscale_ok;
> 
> Similarly here, the SYNACK only advertises min(req->rsk_rcv_wnd, 65535U). Does
> setting rcv_mwnd_seq using the unclamped req->rsk_rcv_wnd track a larger window
> than was ever advertised?
> 
> 
> Neal, what do you think?

-- 
Simon Baatz <gmbnomis@gmail.com>

