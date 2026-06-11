Return-Path: <netdev+bounces-297900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wt2fGUcgKmorjAMAu9opvQ
	(envelope-from <netdev+bounces-297900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:41:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B433A66DD92
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:41:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=mXPemDZl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297900-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297900-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C7C830DC55B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615C12EB5CD;
	Thu, 11 Jun 2026 02:41:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAB1FF7C8;
	Thu, 11 Jun 2026 02:41:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781145666; cv=none; b=c4OEQMSSfPuvoEGZX8/18srYNny1oweZ8t2W6FFCmb/4Xhgr4z4l/KGljbE14y3HGRQ6hBkumWIzlH+lAuu6tZy0nTVin7TQwoHbhUbAqfVIDiEjyxRnwO5NPeQW3/Lw4q+0HoAXtLlT2PqvhYcRar42rTnJv0y6ixJXitoqhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781145666; c=relaxed/simple;
	bh=XMxl21juqOwu7ovEl6DADowLJ/SLFMJx0DTc2rKq0Gc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=brJlDEafy6DwAKePx8CK13aPJOQGTiMRQ+8qQR0zBjHhwTOLzOslTqN2r6NA2OcsdJRa0HUxVcG5QWr/dnQYIOz7ImWyar1YA/na5+AfKKtWaUqbIcbGOF2/L4qHIf3McagaVGmBrpnM0T7eWe0gLLQkaNp2AhmKjNvXDyypNcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mXPemDZl; arc=none smtp.client-ip=115.124.30.97
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781145661; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=ha7BkfjaCY9/CYZC5+QJ/MJxoyTlbQ4TVcB5ZstAvSA=;
	b=mXPemDZlQW+0Ud9foG4/x+rMtjn910aw+avtsgqCg3jrmAN1gEjPVyszlKQlPUyuwieGCk2sp6vp0SSgznYFj788cqXOTDRuKH6F/CQ9Cul5VguuuEmXhXyEzdE91c+MZNcKGFp0A8NjdUCmfR3Mhc8V1zkjmdlrnNR24P4k9AQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X4cF-VI_1781145660;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X4cF-VI_1781145660 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Jun 2026 10:41:00 +0800
Message-ID: <1781145615.903036-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 2/2] virtio-net: harden page_to_skb() big-packet frag loop
Date: Thu, 11 Jun 2026 10:40:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 minhquangbui99@gmail.com,
 bestswngs@gmail.com,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com
References: <20260610232936.1176094-1-xmei5@asu.edu>
 <20260610232936.1176094-2-xmei5@asu.edu>
 <1781144329.8069873-2-xuanzhuo@linux.alibaba.com>
 <CAPpSM+RApuYf3-ui15E+01fWEzUzfh6mgijQyT_+KjusMVxMfw@mail.gmail.com>
In-Reply-To: <CAPpSM+RApuYf3-ui15E+01fWEzUzfh6mgijQyT_+KjusMVxMfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297900-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:mst@redhat.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B433A66DD92

On Wed, 10 Jun 2026 19:24:03 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> Thanks for the review. I agree with that as I replied at the end of
> v1. If we obsolete 2/2 but keep 1/2, is it okay to just leave it as
> is?

You should post a new version.

Thanks.

>
> Xiang
>
> On Wed, Jun 10, 2026 at 7:19=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Wed, 10 Jun 2026 16:29:36 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> > > This is a robustness hardening patch. The slow-path frag loop in
> > > page_to_skb() walks the page chain via page->private until the
> > > device-reported len is consumed, implicitly trusting that len fits the
> > > chain. It does not stop when the chain is exhausted (page becomes NULL
> > > at the tail), nor when nr_frags reaches the end of the static
> > > skb_shinfo()->frags[MAX_SKB_FRAGS] array.
> > >
> > > Both bounds are needed: the chain length is big_packets_num_skbfrags =
+ 1
> > > pages, which for an MTU-driven configuration can be well below
> > > MAX_SKB_FRAGS, so neither guard implies the other.
> > >
> > > Make the loop self-defending so it no longer relies on the caller hav=
ing
> > > validated len: stop once the chain is exhausted, and never index past
> > > MAX_SKB_FRAGS. No functional change for well-formed input.
> >
> > At this point, we are assuming that len represents the correct packet l=
ength. If
> > there is a bug in the validation, it can be fixed, just like in your pr=
evious
> > patch. Indeed, not checking nr_frags is also based on the overall desig=
n.
> > However, I do not recommend adding this kind of enhancement. If we foll=
ow
> > this logic, we would end up adding similar code in many other places, w=
hich
> > doesn't make much sense.
> >
> > Thanks.
> >
> > >
> > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > > ---
> > > v2: robustness patch
> > >
> > >  drivers/net/virtio_net.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index afe73eda1491..518c22fa1b68 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -906,8 +906,11 @@ static struct sk_buff *page_to_skb(struct virtne=
t_info *vi,
> > >       }
> > >
> > >       BUG_ON(offset >=3D PAGE_SIZE);
> > > -     while (len) {
> > > +     while (len && page) {
> > >               unsigned int frag_size =3D min((unsigned)PAGE_SIZE - of=
fset, len);
> > > +
> > > +             if (unlikely(skb_shinfo(skb)->nr_frags >=3D MAX_SKB_FRA=
GS))
> > > +                     break;
> > >               skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, o=
ffset,
> > >                               frag_size, truesize);
> > >               len -=3D frag_size;
> > > --
> > > 2.43.0
> > >

