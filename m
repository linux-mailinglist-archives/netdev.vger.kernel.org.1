Return-Path: <netdev+bounces-110437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1C592C66F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 01:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECBE1C2278B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 23:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A884189F35;
	Tue,  9 Jul 2024 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ml5UFN8z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61912156674
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566689; cv=none; b=QplHztNmjLZ4pUT5HaEfUvWZjiccgt5T2w10skZc3nE+GcSQWyvxqAAbBW9TFDcGYPj7AtBg2tDjq3m2r2lN0ErX+F7qPr6wJK/hUwnTzPbK2wxnztpJADjqDKJQiiprw7Qn4zXmYIPyOfsoE9ZlufT7GODOL/g8Z90Rxph6dPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566689; c=relaxed/simple;
	bh=kqHiTzlsTpCwC+mRhJ3ANcZGbTNLa7dlOqr7e0N5x8Q=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9DLir6oZTWC7ylZzEc4NmmfWJlRd8CDj5tRUNJMP3lz5XjHB1a31e6GhvBtftKAg46ab3y3pfBRrEC2cug/cFIjNv2z1OZiapN+B4NXrAZPfkcruyT8roNZhlQr6qeYY2YLU7lhQ6sy0KyLsxJBOGJDwU+pu/2f0+hzrq3QZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ml5UFN8z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720566685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PoXVxLHrISaurBK8S5yP5fDz6rnlPjSwahgWcJsOvhE=;
	b=Ml5UFN8zD7IoyVLpOgT6BQem9tOaqWV96jynThrlII+JPEjINex9/VJ9YhYsbK/5c+aIC7
	nKW7UyCSH+T08sE2v8RhRCasP+AMyk7yd92ng0T+zUAcoYx69B98LXq5lTU/CoWSjVh8fx
	8PqnoAIyA91ih4TNyhIFMaG0rZxQOXI=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-MN27Oz6QPS6LIBkGy-NKww-1; Tue, 09 Jul 2024 19:11:22 -0400
X-MC-Unique: MN27Oz6QPS6LIBkGy-NKww-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e02b5792baaso10060184276.2
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 16:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720566681; x=1721171481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PoXVxLHrISaurBK8S5yP5fDz6rnlPjSwahgWcJsOvhE=;
        b=e64+uLm2XTBuir/M2QkF1ybBIH8M5nHq0J8cYmxevwoEIAdPEvsXhUZ6/6PsiWLOo5
         bQVCfJcXZ9SV95EzE8MB2Mpa7eAF5zShcR38MBUMolGiSjY8bEE8ymG4kxoiTh5EmL/F
         2iPJJnvpnLKoEgIQ3jYJK8LCBNBDhEQdhEXeMyQOuIcvEqEFmaXIBE+uUei1ua8vF8j5
         llEbGY9mooTFrUW/soMK1GfT7mxzzE4DxKevBmNsZ3cCxQw2HbzP8ooKz8vXQuHU6CZp
         zOPvTPXrEe890JXsMi43FxYDACDNkX9+lt8PBZ9gNFnIFP/iKbxc5xyBPkHbY6WLGPMZ
         /cVg==
X-Gm-Message-State: AOJu0YywIj9AKetm12qgNAv6CxSRfy758YeJDerPBKAadA83sJUftDJb
	SMmqXQY29Z5IdPJg+nHr8V37KL4FEws8BlNH2oE8ZtKMrN9KXrM8kiFUAH6GnICmVc0tkIZZHlP
	PJf0LhDA3tqJsDO6SE0dtz38ICulf4ZBWd1jaEml2hmzC8YHMmpJT2B+Ah9Lu2opYPO2tilEZfR
	iImQdsezgIQpey/wpU4OlEgsBEC9+d
X-Received: by 2002:a5b:94c:0:b0:dfa:7251:72f4 with SMTP id 3f1490d57ef6-e041b039ac9mr4739827276.8.1720566681295;
        Tue, 09 Jul 2024 16:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+cVuh7KFsTed+EwrnB1ORON6jzpEvdT0f6NcgV8m1sDJZRh9dDwT2VNgEcjE7Nf4rsNO775cHSsxQdeqngwM=
X-Received: by 2002:a5b:94c:0:b0:dfa:7251:72f4 with SMTP id
 3f1490d57ef6-e041b039ac9mr4739807276.8.1720566681012; Tue, 09 Jul 2024
 16:11:21 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jul 2024 23:11:20 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240709203437.1257952-1-amorenoz@redhat.com> <28d092ae-96c8-4145-b679-399d2f71bf8e@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <28d092ae-96c8-4145-b679-399d2f71bf8e@ovn.org>
Date: Tue, 9 Jul 2024 23:11:19 +0000
Message-ID: <CAG=2xmMLkgfU5NtvWciDU17gQ9d2vOtzK7HHyZZWG--_2a4woA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: psample: fix flag being set in wrong skb
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Yotam Gigi <yotam.gi@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Aaron Conole <aconole@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:57:14AM GMT, Ilya Maximets wrote:
> On 7/9/24 22:34, Adrian Moreno wrote:
> > A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the wron=
g
> > sk_buff.
> >
> > Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  net/psample/psample.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/psample/psample.c b/net/psample/psample.c
> > index f48b5b9cd409..11b7533067b8 100644
> > --- a/net/psample/psample.c
> > +++ b/net/psample/psample.c
> > @@ -498,7 +498,7 @@ void psample_sample_packet(struct psample_group *gr=
oup, struct sk_buff *skb,
> >  		goto error;
> >
> >  	if (md->rate_as_probability)
> > -		nla_put_flag(skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
> > +		nla_put_flag(nl_skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
> >
> >  	genlmsg_end(nl_skb, data);
> >  	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
>
> Uff.  Nasty.
>
> I'd say we should change the function argument to 'const' to avoid such
> issues in the future.  There is no reason for this function to modify
> the original packet.  What do you think?
>

Yes, that's probably a good idea.

Adri=C3=A1n.

> Best regards, Ilya Maximets.
>


