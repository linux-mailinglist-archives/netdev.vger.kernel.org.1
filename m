Return-Path: <netdev+bounces-150422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB39EA30F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F6618865FC
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F615226170;
	Mon,  9 Dec 2024 23:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vDB5QPUo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153422617A
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787906; cv=none; b=CegYEPAk1rVv/UgWR8I4lGhX6mAwE27/YTYxiuYPQIxz0hE6lhBsu42s6BuN4tbyQG8FTmkCh0JSATAPKRrov8aCoYOSaxk9UP1QpltozX9B8mVJqXg6su+p2u22K8O9sdEUdQCOpAPDh7R1JJAzQI4MopyCl2oAXmiBGZ8Q3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787906; c=relaxed/simple;
	bh=JufgrUswjYv0bzgkH5yoyfwWJxuth+loL86OiEXEGxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKDtv/CsvdjY7hi3lt+0X66hrOe49KnZ/GiC7mOrmxFCxT0zzdTct3uTmb7Egv53SrfonD57VKuoOt9dpUGLApbfCV0IIMnVPjsoXuwZSVawgTkLff87CoCpaNn+3xSJm3P0N9ayuyczSDIYGhVD2yxAlrNTXMfvFawG5L+dSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vDB5QPUo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa642e45241so686862566b.1
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 15:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733787903; x=1734392703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpfE3tT+UCTl6NxBKbi0GxRreWOybLCZniR1NWm7/Nk=;
        b=vDB5QPUoWRkuiuNPzntT19hylCU5e8/36ED06Egh0C4wLyeN48uq6ZoPkmHkWqAVDL
         2XUodI85CFFt2OzxRSSEMxNYbNuAoYOeG0VUMVsR0hj/LvtUpooY9dde8xs6T1lOICsI
         AEW3SWkpSVOvPPhXMJUSBbHK8JyKbGuwgGRXJpUlIewpKMW/53j4F0XUI4Wuf/EVdovT
         AO6m1Ot1jHmOJU9ysaUOPufTfrpTxqd9I+LmiA3b1JfV8zu3cXdD072VLow0I2hJmXJO
         21xx9pwELBPduhi18DZ5b/tq8sRXWSOJ0jZui1nIeGyURLRz5KhsidQz46Ji3GESY+L+
         scSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733787903; x=1734392703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpfE3tT+UCTl6NxBKbi0GxRreWOybLCZniR1NWm7/Nk=;
        b=UYynYGbUXkQYtTcr04oOx9d7MnXQ8n+0y69jAaOIqtEOFMAM0IxFAVxRHL4blH3n1s
         XsBZt+sGEPrxxCfZoUrNJQ8kK0Xa2cgj0Eo8iIlGmDKBHaTX8xJord1um+U+GYzUSv3n
         xpCS0/Yhah5pGmup/+7NBDLBRjsP9vHUNYeARAsu0QiXjVOeQU6ImqiSIRzQ7XMaf1tN
         8//g7hoCOSvoLCQFDNZucSkQa1rJeDsHV3+4eS+wZKTXFZ/zgaVDSmnSkUJ0mbgrAncu
         GfR1yzKNODSQtvs0rioayemdpHxt3YJAtzyb50rmoBwPfgijk50i4So0vSKmoLoZoTjQ
         Vwhg==
X-Forwarded-Encrypted: i=1; AJvYcCUhnkOt/OuTOEtKdvTxgEPtTAkUzRNDIEwgkBpka+0/bJMTw8muf2ypX3ViU+fDExOyeO0eZUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6nJyi1IGPJMFRNlBLzS+RXVPgXJ8AMFrOmA6fvAm7s7plZpe
	/gt360XXHfguzzVazhDHvl24s+CvmdJw4/CK9Yn89hd2/hCr684mbAgtAXvoKrZTHY7lRBJHMR+
	k0imG/2uAhqDR/98Xuh3KRsHnZf0a7Cvm1TCT
X-Gm-Gg: ASbGncsjQ8OKEfMpY3lP6f8zdVPVvkuWKXii8oXXEWP/HMrI1/HCBSP6f2JzjZABHvi
	reUp8GdmmDUzRM+9WFU+btDWZSTRPSr0sz+bayXP/OBz7791nG0o8EGJhNBT4dYO0
X-Google-Smtp-Source: AGHT+IFVzMugsf0zKCWk1dY8q4BFO/Qb0ORCOxMaSWJ1WAiL3cqrPyQt5cGwwfwWS5pXgHMB5SbrqJN57U1CDMuSuUo=
X-Received: by 2002:a17:906:2192:b0:aa6:8275:223c with SMTP id
 a640c23a62f3a-aa69ce3762amr221718766b.44.1733787902494; Mon, 09 Dec 2024
 15:45:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209202811.481441-2-wangfe@google.com> <20241209215301.GC1245331@unreal>
In-Reply-To: <20241209215301.GC1245331@unreal>
From: Feng Wang <wangfe@google.com>
Date: Mon, 9 Dec 2024 15:44:51 -0800
Message-ID: <CADsK2K_NnizU+oY02PW9ZAiLzyPH=j=LYyjHnzgcMptxr95Oyg@mail.gmail.com>
Subject: Re: [PATCH v7] xfrm: add SA information to the offloaded packet when
 if_id is set
To: Leon Romanovsky <leon@kernel.org>
Cc: steffen.klassert@secunet.com, netdev@vger.kernel.org, 
	antony.antony@secunet.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steffen,

This patch was done based on our previous discussion.  I did the
changes we agreed on.  This SA info includes the matched encryption
information, so it doesn't need to perform lookup on the source and
destination anymore in the driver.

Thanks,

Feng

On Mon, Dec 9, 2024 at 1:53=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Mon, Dec 09, 2024 at 08:28:12PM +0000, Feng Wang wrote:
> > In packet offload mode, append Security Association (SA) information
> > to each packet, replicating the crypto offload implementation. This
> > SA info helps HW offload match packets to their correct security
> > policies. The XFRM interface ID is included, which is used in setups
> > with multiple XFRM interfaces where source/destination addresses alone
> > can't pinpoint the right policy.
> >
> > The XFRM_XMIT flag is set to enable packet to be returned immediately
> > from the validate_xmit_xfrm function, thus aligning with the existing
> > code path for packet offload mode.
> >
> > Enable packet offload mode on netdevsim and add code to check the XFRM
> > interface ID.
> >
> > Signed-off-by: wangfe <wangfe@google.com>
> > ---
>
> <...>
>
> > @@ -728,7 +730,27 @@ int xfrm_output(struct sock *sk, struct sk_buff *s=
kb)
> >                       kfree_skb(skb);
> >                       return -EHOSTUNREACH;
> >               }
> > +             if (x->if_id) {
> > +                     sp =3D secpath_set(skb);
> > +                     if (!sp) {
> > +                             XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERRO=
R);
> > +                             kfree_skb(skb);
> > +                             return -ENOMEM;
> > +                     }
> > +
> > +                     sp->olen++;
> > +                     sp->xvec[sp->len++] =3D x;
> > +                     xfrm_state_hold(x);
> >
> > +                     xo =3D xfrm_offload(skb);
> > +                     if (!xo) {
> > +                             secpath_reset(skb);
> > +                             XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERRO=
R);
> > +                             kfree_skb(skb);
> > +                             return -EINVAL;
> > +                     }
> > +                     xo->flags |=3D XFRM_XMIT;
> > +             }
>
> Steffen,
>
> I would like to ask from you to delay this patch till this "if_id"
> support is implemented and tested on real upstreamed device.
>
> I have no confidence that the solution proposed above is the right thing
> to do as it doesn't solve the claim "This SA info helps HW offload match
> packets to their correct security". HW is going to perform lookup anyway
> on the source and destination, so it is unclear how will it "help".
>
> Thanks
>
> >               return xfrm_output_resume(sk, skb, 0);
> >       }
> >
> > --
> > 2.47.0.338.g60cca15819-goog
> >
> >

