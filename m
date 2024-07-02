Return-Path: <netdev+bounces-108389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA79C923AB9
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7644E1F22139
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D22C156C6A;
	Tue,  2 Jul 2024 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdIIRF8D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C141514E3
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913962; cv=none; b=ezZb6b+VtzAKB2EqQnMyVA/9q7Uo2gBz/jUEecgz1zjEOOCpzNCJaMcmqfvL6OU+caU/sGPgPsA7gcoXmbmyFso5FyegUl+mwgGjLJjaJ5up8c+4JHiqneYqja4IXWpvwVDcAYVbXwOquHIQTuwrGdxiwJ8iIH1xplBo0xKvODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913962; c=relaxed/simple;
	bh=VOJKjCp3jR7kcHcYPgkIxJUAg/3LFIoGG0GeL022wbE=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbKk6CWzsTAtwdlUnfarIKRCfNnX2S1n5d8m7KaiVZE9VpM5/6UZS4LSmLLjTOEsGkUTeMyOJofRBhBNg/Y2v0b5QxEJaETnWrKXl3uyMfPuuY/QIr7NbhYRjKLjN7gZY38a+Vwbk4at/mcrbBjOSkSmR6lKZ1q5pJTyTJsRvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdIIRF8D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719913959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DP5F3FQZT9AEjJbD/+HIliGJ1E4COuK06MVeuQ7o+74=;
	b=VdIIRF8DKTZkEI2CCo90p2bvdhr7LpKTt82aY2ccm8Kk4/lzHghI/X8g9i9wk43dcO0I3k
	mcmUnLOeXwFwcpb14ZVa8sih3bjZI2nLy+8Golr+um/QUZvUPSjJCEeVuGAZ3aOUtzr+XH
	AYOBFa442UvcHyh1lg61cjiaY0nwGPI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-h1Z-1gXhPIu_tC58QbUIfw-1; Tue, 02 Jul 2024 05:52:38 -0400
X-MC-Unique: h1Z-1gXhPIu_tC58QbUIfw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b51725a7ebso47876396d6.2
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 02:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913958; x=1720518758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DP5F3FQZT9AEjJbD/+HIliGJ1E4COuK06MVeuQ7o+74=;
        b=lXFbGRzutctSnTysy3qpk0dYyLH74CF6jBdDTkqkqmn7m+kUsYMascgbMxf6bI1gY4
         5+RUPSpff8deQYoT5Bu0cGfarcBjghHJWyY3wog9RTQ3aaEbAyMZgSki1mo35wyJn3T5
         r8A0+F6yweUhEQg2Q/CaNaiZPpG1kYOgvLgbHPxKUx15ldojLGv9Q4q8r4ercZUl7YK8
         u6HA3rjohKQU7VO8G1udnnyQ1Q//ffQnIDbHyOP1VzhAAUAyw5K63wk0dw7kBcL4e7LQ
         20bo/iVkncBhtTYR1k5clYFRHEEC/bBiWVHlQ+5u7/qRUiT9rJm8f+1SBcW8/xKXPUXc
         tB8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTarZsLGSvovHFQs7GOiAmiHRBUdGHSy/v6Svzt55Vx7bsJQ3B0FbsR34CtLV1sp0cbVh+YT67N3emtT/3gszExH+TgI4V
X-Gm-Message-State: AOJu0Yx1+8kJNvX6yLeUNF+zwNX8bHHXZSXENOISq8/QGHIDuXbPnpoZ
	NHQEaMifG+qBVfJS1Ncw/kBLwuugqCV64wkKlRTOjXu/W+bAHLbF8LmVcBfnNHFZL85zgfJTc12
	kGFNBbGC1uvgPG5jBDp510q/bjxlKGEMdd476QcvNt5Q0V8J3/hEO0MDPu11LPOSbaPfKne6jMr
	HvEiBEshjV/KDnX5s8jGiIdjFpQENw
X-Received: by 2002:a05:6214:5094:b0:6b0:77a8:f416 with SMTP id 6a1803df08f44-6b5b716c590mr91539116d6.47.1719913958175;
        Tue, 02 Jul 2024 02:52:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0pXlmMNoeRDeiooxStpfBdXN4rvBZfr/TYjnTJqrAO2XPoSia5lnQ7HNIgp+xR7Oyai5jussGPovwhsA9FeQ=
X-Received: by 2002:a05:6214:5094:b0:6b0:77a8:f416 with SMTP id
 6a1803df08f44-6b5b716c590mr91538996d6.47.1719913957850; Tue, 02 Jul 2024
 02:52:37 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jul 2024 05:52:36 -0400
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240630195740.1469727-1-amorenoz@redhat.com> <20240630195740.1469727-6-amorenoz@redhat.com>
 <f7to77hvunj.fsf@redhat.com> <CAG=2xmOaMy2DVNfTOkh1sK+NR_gz+bXvKLg9YSp1t_K+sEUzJg@mail.gmail.com>
 <20240702093726.GD598357@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240702093726.GD598357@kernel.org>
Date: Tue, 2 Jul 2024 05:52:36 -0400
Message-ID: <CAG=2xmOwtdBJVk+=7KMgp1oEMuL=-OLzaWgvvV3n9Y=thnfwgA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 05/10] net: openvswitch: add psample action
To: Simon Horman <horms@kernel.org>
Cc: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org, echaudro@redhat.com, 
	i.maximets@ovn.org, dev@openvswitch.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 10:37:26AM GMT, Simon Horman wrote:
> On Tue, Jul 02, 2024 at 03:05:02AM -0400, Adri=C3=A1n Moreno wrote:
> > On Mon, Jul 01, 2024 at 02:23:12PM GMT, Aaron Conole wrote:
> > > Adrian Moreno <amorenoz@redhat.com> writes:
>
> ...
>
> > > > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>
> ...
>
> > > > @@ -1299,6 +1304,39 @@ static int execute_dec_ttl(struct sk_buff *s=
kb, struct sw_flow_key *key)
> > > >  	return 0;
> > > >  }
> > > >
> > > > +#if IS_ENABLED(CONFIG_PSAMPLE)
> > > > +static void execute_psample(struct datapath *dp, struct sk_buff *s=
kb,
> > > > +			    const struct nlattr *attr)
> > > > +{
> > > > +	struct psample_group psample_group =3D {};
> > > > +	struct psample_metadata md =3D {};
> > > > +	const struct nlattr *a;
> > > > +	int rem;
> > > > +
> > > > +	nla_for_each_attr(a, nla_data(attr), nla_len(attr), rem) {
> > > > +		switch (nla_type(a)) {
> > > > +		case OVS_PSAMPLE_ATTR_GROUP:
> > > > +			psample_group.group_num =3D nla_get_u32(a);
> > > > +			break;
> > > > +
> > > > +		case OVS_PSAMPLE_ATTR_COOKIE:
> > > > +			md.user_cookie =3D nla_data(a);
> > > > +			md.user_cookie_len =3D nla_len(a);
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	psample_group.net =3D ovs_dp_get_net(dp);
> > > > +	md.in_ifindex =3D OVS_CB(skb)->input_vport->dev->ifindex;
> > > > +	md.trunc_size =3D skb->len - OVS_CB(skb)->cutlen;
> > > > +
> > > > +	psample_sample_packet(&psample_group, skb, 0, &md);
> > > > +}
> > > > +#else
> > > > +static inline void execute_psample(struct datapath *dp, struct sk_=
buff *skb,
> > > > +				   const struct nlattr *attr) {}
> > >
> > > I noticed that this got flagged in patchwork since it is 'static inli=
ne'
> > > while being part of a complete translation unit - but I also see some
> > > other places where that has been done.  I guess it should be just
> > > 'static' though.  I don't feel very strongly about it.
> > >
> >
> > We had a bit of discussion about this with Ilya. It seems "static
> > inline" is a common pattern around the kernel. The coding style
> > documentation says:
> > "Generally, inline functions are preferable to macros resembling functi=
ons."
> >
> > So I think this "inline" is correct but I might be missing something.
>
> Hi Adri=C3=A1n,
>
> TL;DR: Please remove this inline keyword
>
> For Kernel networking code at least it is strongly preferred not
> to use inline in .c files unless there is a demonstrable - usually
> performance - reason to do so. Rather, it is preferred to let the
> compiler decide when to inline such functions. OTOH, the inline
> keyword in .h files is fine.
>

Ok. I'll send a new version.

Thanks.
Adri=C3=A1n


