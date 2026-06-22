Return-Path: <netdev+bounces-301093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tO58GEEqOWrhngcAu9opvQ
	(envelope-from <netdev+bounces-301093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:27:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA05F6AF6E6
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:27:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=qNoKMFCJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301093-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301093-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7B7D301F156
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04D33A7186;
	Mon, 22 Jun 2026 12:27:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74462379C2B
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 12:27:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131261; cv=none; b=npUjO/7vm6ywnd+GcKd4HiW7VHHNXp1WbTCCM2k9U5d0juSt4BAuYAeeoTWZQSdsYS57qLf5TdWIusEge2xD4PfjXogw+VvL+4P9we8mYwKG3v62mDGyh4YxQtFB2siulRlQZydjP6q4O6qvB+vxlLb6m9NNxXCNw9ZmHtdo54A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131261; c=relaxed/simple;
	bh=4j+00HlElQLUoISmCOPJXqeurRhtEPbVpFjE5IFbxRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnTJ7Fj2+by+JpsPsaKy7sx87QD3McdetRw88fB8YiSII4JUnbhFxXpTF+Bxy4AMKFcNn6fd9HmWPP5jega9iNoRVSuaXCegC690L5n5oYfW2gjXwaP7I0HjdMXpXeJ8e1dhZoJsES+fuEGhWRUz6NHVxOQfeE6caEcfhfD/9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qNoKMFCJ; arc=none smtp.client-ip=91.218.175.170
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782131248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6E5HMCsv8V1TPYr18y2WYeLDGDrIQonKulSBFvWahE=;
	b=qNoKMFCJnFR4CvkeRtR1vTwxlLckCqkvtCcuFiGtfAqIwNWFb9aq9lQmIpydzevkV+OeDb
	0kMMHupSXevfA8IMgrpMaTgCZJY98iYHldvQXt2y7CpqYz77imAP3AyytLFIMQArjyyvX+
	7tI6SUIUVr1FRFSRNSSavnMiRZvUIdQ=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jasowang@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Date: Mon, 22 Jun 2026 20:27:12 +0800
Message-ID: <BMgCMK8nRYC94QK7N1SXpQ@linux.dev>
In-Reply-To: <20260621182119-mutt-send-email-mst@kernel.org>
References:
 <20260616115912.513183-1-dongml2@chinatelecom.cn>
 <20260621182119-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-301093-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	FORGED_SENDER(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:menglong8.dong@gmail.com,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA05F6AF6E6

On 2026/6/22 06:31 Michael S. Tsirkin <mst@redhat.com> write:
> On Tue, Jun 16, 2026 at 07:59:12PM +0800, Menglong Dong wrote:
[...]
> > =20
> > +	vring_size =3D virtqueue_get_vring_size(sq->vq);
> > +	need_wakeup =3D xsk_uses_need_wakeup(pool);
> > +
> > +	if (need_wakeup && vring_size =3D=3D sq->vq->num_free)
> > +		xsk_set_tx_need_wakeup(pool);
> > +
>=20
> why are we doing this here?
> the check after virtnet_xsk_xmit_batch not enough?
> I vaguely think it's some kind of race we are closing?
> Pls add a comment to explain.

Hi, Michael. Thanks for your review.

Yeah, it's for a race condition between user space and kernel
space. I added a comment in V2, which is too confusing, and
I removed it =F0=9F=98=A2. I'll make it more clear and add it in the V4. The
origin comment is:

 * If the sq->vq is empty, and the tx ring is empty, and the user
 * submit an entry to the tx ring after virtnet_xsk_xmit_batch() and
 * before xsk_set_tx_need_wakeup(), we will lose the chance to wake
 * up the tx napi, so we have to set the need_wakeup flag here.

And the logic is like this:

Kernel: tx NAPI is waked up from skb_xmit_done() ->
Kernel: sq->vq and xsk->tx_ring are both empty ->
Kernel: call virtnet_xsk_xmit_batch()

    User: submit a entry to the xsk->tx_ring
    User: check the wakeup flag
    User: wakeup flag is not set, skip send()

Kernel: call xsk_set_tx_need_wakeup(), because sq->vq is empty

If we don't send more data, the data in the xsk->tx_ring will
not be sent forever.

>=20
> >  	sent =3D virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
> > =20
> > +	if (need_wakeup) {
> > +		if (vring_size =3D=3D sq->vq->num_free)
> > +			/* we can't wake up by ourself, and it should be done
> > +			 * by the user.
> > +			 */
> > +			xsk_set_tx_need_wakeup(pool);
> > +		else
> > +			/* we can wake up from skb_xmit_done() */
> > +			xsk_clear_tx_need_wakeup(pool);
>=20
> But what if we don't have get tx napi so no wakeup in skb_xmit_done?

Sorry that I'm not sure what "get tx napi" means here ;(

There are entry in sq->vq, so skb_xmit_done() will be called after
the entries in the ring is consumed by the HOST, right?
Then, the corresponding sq->napi will be scheduled, as we ensure
that tx napi is always enabled, which means napi->weight is not
zero, in this commit:
1df5116a41a8 ("virtio_net: xsk: prevent disable tx napi")

Right?

Thanks!
Menglong Dong

>=20
>=20
> > +	}
> > +
> >  	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> >  		check_sq_full_and_disable(vi, vi->dev, sq);
> > =20
> > @@ -1470,9 +1488,6 @@ static bool virtnet_xsk_xmit(struct send_queue *s=
q, struct xsk_buff_pool *pool,
> >  	u64_stats_add(&sq->stats.xdp_tx,  sent);
> >  	u64_stats_update_end(&sq->stats.syncp);
> > =20
> > -	if (xsk_uses_need_wakeup(pool))
> > -		xsk_set_tx_need_wakeup(pool);
> > -
> >  	return sent;
> >  }
> > =20
> > --=20
> > 2.54.0
>=20
>=20
>=20





