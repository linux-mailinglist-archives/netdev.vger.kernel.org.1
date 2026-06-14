Return-Path: <netdev+bounces-299268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kGWmOUkBL2qO7AQAu9opvQ
	(envelope-from <netdev+bounces-299268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 21:30:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA768209C
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 21:30:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Iyq5T8U5;
	dkim=pass header.d=redhat.com header.s=google header.b=cRX7gwTj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299268-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299268-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DF25300E256
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 19:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48EC30F7F2;
	Sun, 14 Jun 2026 19:29:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F682F7EF4
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 19:29:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781465395; cv=none; b=W5Zo1ydoCuqiCp77k9AvAqPhL7cxshQhgoovjXVI7yqprifD1XKMsbPIFe1SBt2Fxm7k9q1NZPFANEkf87+OmZubkvDtgE6qIsrX17K0n8nBD/xzu1ewGT3clNfn58mB6r/XONcCsToJf1dMU2buDWjAskWGpMMU0eNIf4yJihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781465395; c=relaxed/simple;
	bh=CSg0YZ4b1saGbeK/3fq2xrN4WdQC6l/mdlg8Tzb8zlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOFteEcTbOZZetpg8twPk///BzSkATGXjjwrvadBotG80v0tyrk5QVQ6T7AAThPB6+Mr+nw7m6sazvcRJKtV5EZAYZN0H4VCkLXj5Qwyq17kcXIgWVD7/kYoeM1XqlQZFuRVnlqUSjikVu67ATpNdM4osRcwG+I5BSLbxiup68M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iyq5T8U5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cRX7gwTj; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781465392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpgsCWY04Ero7XAmbrGxjHAhswt6Bct4cgGHg8NRGnY=;
	b=Iyq5T8U5fCWFVXiVWEEVdyFPZZ+eGFed9Dl15Qq5dAi/wAEJn/tpoQNBsCYz273XQZhl0B
	EyvVCcCkYFi3Qt8yEyiuHWinvOYwwxhmcLr1gA8/BYDH/csV0JkyGJG1AOPdzYwC3nRbM8
	3JheDOJMg53Nkj6jFn4kT51UWIsG+jc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-El4sxheOMDepwKU5IcCFtg-1; Sun, 14 Jun 2026 15:29:51 -0400
X-MC-Unique: El4sxheOMDepwKU5IcCFtg-1
X-Mimecast-MFC-AGG-ID: El4sxheOMDepwKU5IcCFtg_1781465390
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b8adf8b8so22593825e9.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 12:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781465390; x=1782070190; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vpgsCWY04Ero7XAmbrGxjHAhswt6Bct4cgGHg8NRGnY=;
        b=cRX7gwTjbTnQlRiQn+bNwrGzSdxdfiQaHwA62uUaRD+wfRDngYj+6Cq2TyCHwDZa2H
         QEGWBr+jzvH0A0IVPxdj7o93dRaHsJDPQSMztaVFLfQST9aZs/uZY3CxGonVWBQ2Mx9I
         Ve3VA+SVHoqlYuYM9uBwPZTBKr25ElcOZRvHE1VIPCIqOA8p0kOIKJ+QJ2yoxth1Enca
         ApJDkfOOOMMFse2TjN4krRhjCmRgc3UWR0Sg4/Y8hhkpFJ37sSmXWt36qfV5LND3+gdg
         eCn+ogRzom8kuA3jZRvv5kSiFT064FQkll2CV73rbsAcHFPVw5Q9pp9G17JJMfXOHMWI
         eavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781465390; x=1782070190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpgsCWY04Ero7XAmbrGxjHAhswt6Bct4cgGHg8NRGnY=;
        b=s6ByXUcuEoTN/C3Q+daQNfez7f5IQWa8TerktH155VGapth3XcIvIRRNAvbdydR8bq
         J3J5nSJSQT34NrcMwb61YG4mWyTApM+BbA1CBlGqkQkfyi7n9sQTsPHWDBBI/Uz+SCDY
         ZpvbCSUG8eCTz6wwv6TFQXsB7vmZ+ffN84bPosR52Xxssumt0bmyQJRlGaFaGdPmovTe
         9vsKz5Al9o4Fg92PshcKhKRKFDlPJ9ogq+E8VCq/y0wjjAPww3gZMS4vBsBTmJ3XHgFC
         /1xi2nnDgCr7pDbckTero49W+4YTYNyvMPooM579nE5JvS22qsYScguhSAZN2ikXLJ2E
         tedQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bwHI8cRVJVVy+xJobUSlmWQEESdA0waoD1spaXVq42Ey/yhW0p++OfAFdDPsMpwrU6Vz98n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPG57F+hHFomipU0Chgc/fEEO0lZnh73q05SFULFCJtqr04qe
	TDrh8Qclo3Gx8+SrjKFKcULYileFpPfUwgeWSx5KVUW8UcABSigMgqYWNTf2RnW+woWCnh3cpJP
	V5LguiBQRjAW5+bdjcWM8Fwjz11hMu4mShHmJtr48N7qRYnA/M4cM6Y59tg==
X-Gm-Gg: Acq92OGj73iYYuE808yXzsny6lwKHsJ8HV07XmgTOc0M9JseVLNWP0BE8X+SwUNJXkf
	uESkcrD7WiHEQcS44PI4Ll4ikMU6VSvm7/iXrZ06y9v4KhBa1457hJfs9sGP/UoFn56M8wKwjrZ
	83cWjuBWbqACplmAVq7RJ7OSbwZ4a6S6lw/IJl6p7WFRaPviv6Qbh8IZKFHlf8DDWI96K+DfNbI
	pq+XW37ipX0kwhRJCTVDXgsrT7APkGQEV/DFsQLIqjI0zoI0CEZap/c7CP9jp02OG/Vq2HBoziM
	JCxnHadtSR9zCHb43xTESXcyz9q2ldYOVy4w9Fz0Xu1JeTf4FTQL2t6gkTAXf0QOpuWzwW6dDPc
	10XhJwN5u5SQk6DcsmSvcrtDSlFlsf9aILvGONjhMnLQ=
X-Received: by 2002:a05:600c:c3dc:20b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490ec4fbd85mr106062075e9.26.1781465390254;
        Sun, 14 Jun 2026 12:29:50 -0700 (PDT)
X-Received: by 2002:a05:600c:c3dc:20b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490ec4fbd85mr106061735e9.26.1781465389701;
        Sun, 14 Jun 2026 12:29:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922031b7d2sm198939285e9.5.2026.06.14.12.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:29:49 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:29:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com, bestswngs@gmail.com
Subject: Re: [PATCH net v3] virtio-net: fix len check in receive_big()
Message-ID: <20260614152904-mutt-send-email-mst@kernel.org>
References: <20260611024616.1408317-1-xmei5@asu.edu>
 <20260611014519-mutt-send-email-mst@kernel.org>
 <CAPpSM+Q=NM0WeBmZvyOEkyx73VU10AOHQjPbWDSet675B7AnCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpSM+Q=NM0WeBmZvyOEkyx73VU10AOHQjPbWDSet675B7AnCA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299268-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,lists.linux.dev,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72FA768209C

On Sat, Jun 13, 2026 at 01:15:02PM -0700, Xiang Mei wrote:
> On Wed, Jun 10, 2026 at 10:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jun 10, 2026 at 07:46:16PM -0700, Xiang Mei wrote:
> > > receive_big() bounds the device-announced length by
> > > (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> > > add_recvbuf_big() sets sg[1] to start at offset
> > > sizeof(struct padded_vnet_hdr) into the first page, so the chain
> > > actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> > > big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> > > check allows for the common hdr_len == 12 case.
> > >
> > > A malicious virtio backend can announce a len in that gap.  page_to_skb()
> > > then walks one frag past the page chain, storing a NULL page->private
> > > into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> > > write past the static frag array and a NULL frag handed up the rx path.
> > >
> > > Bound len by the size add_recvbuf_big() actually advertised.
> > >
> > > Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
> > > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> > Thanks for the patch! Something small to improve:
> >
> > > ---
> > > v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
> > >
> > >  drivers/net/virtio_net.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index f4adcfee7a80..afe73eda1491 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
> > >                                  struct virtnet_rq_stats *stats)
> > >  {
> > >       struct page *page = buf;
> > > +     unsigned long max_len;
> >
> > Assignment can happen here?
> >
> > >       struct sk_buff *skb;
> > >
> > >       /* Make sure that len does not exceed the size allocated in
> > >        * add_recvbuf_big.
> > >        */
> > > -     if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> > > +     max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
> > > +               vi->big_packets_num_skbfrags * PAGE_SIZE;
> >
> > Took me a while to figure out what is going on, but I finally
> > understand:
> >
> >
> > Reducing
> > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE
> >
> > (what we allocated)
> >
> > by sizeof(struct padded_vnet_hdr) - vi->hdr_len
> >
> >
> > right?
> >
> > So clearer as:
> >
> >
> >         unsigned long max_len = (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE -
> >         sizeof(struct padded_vnet_hdr) + vi->hdr_len;
> >
> Right, that's the same value. Yours reads better!
> 
> I'll fold this into the next respin. One thing I'd like to settle
> first: David suggested storing this in a vi field computed once at the
> probe (it's a per-device constant) and just comparing len against it
> on the datapath, instead of re-deriving it in receive_big() each time.
> I'll wait for his take on that and send a single v4 that covers both.
> 
> Xiang

I don't mind.

> >
> >
> >
> > > +     if (unlikely(len > max_len)) {
> > >               pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> > > -                      dev->name, len,
> > > -                      (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> > > +                      dev->name, len, max_len);
> > >               goto err;
> > >       }
> > >
> > > --
> > > 2.43.0
> >


