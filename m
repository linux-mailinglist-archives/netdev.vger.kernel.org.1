Return-Path: <netdev+bounces-185696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04536A9B694
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E731B815F0
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F341628F52A;
	Thu, 24 Apr 2025 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDLK3F07"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248DF1624E5
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520034; cv=none; b=ArMjeIB88j+gVz8XVutP4eF+a7fujAuo9aF9T1/hSy4elhmBur855olMU8CjDQUZD7N61kkot3qVSVg1gbRxr3TRBKtGnAZtZ0273MSNsBLnEenbnZsfS4fMaB2RALLvJf7z5d6j9TCBtty2B4fFVaJBQTHxKfdc+TfYqgSnI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520034; c=relaxed/simple;
	bh=9K3353xM1F7GwutY9NLd32kwoXWfOWD8VxNIa8tke44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DMS9b0dWvo29DGl5cBQyECvscrRe74J4UWtjPJXdfjRFYf1Xr3chI6Xi63nesSr8j0uejuUbgusnAOgQZ6QhojgY8VqmPkGSfUldPlJkZTRTzmkCGyP37anr+ecClWHczmzQKqaibP4ys+TmLoVoUHZ1MXugGQjgHLNYfhdZT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDLK3F07; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ef83a6bfaso5565e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745520030; x=1746124830; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGnBj0MctxhiYiDydSa3ktosc/eiAtqwYCSjVbP7Yy0=;
        b=jDLK3F078GbCQCdFHmfSDzHlBqE/Woh871lQK+mf6Go2C/v4Bnk/4lVv36K2X49IyA
         bjpYtO5dW/6VHydNToOCjrlPgBEtytb2EDVW09RheOMuuoFCEstcIqigfEE0DU0qF5Sh
         /vG789zTfEb0S2hnBTmzAhlfy3qRkQ3BsMWZ9yqOVtG/YxM8a3e1+rZXb4hWwXdo0CuV
         7BeSohlicvSeStYNfvjTj5KGkLe6Gth4uesT3oFrLQ0qRzNhpD+VqZH/80rRi2fguElf
         onfOAIhPpP45eRpJJzaFaFxtckgZcJD96FD5W6Pz+HWS0yqZO8kQ+fB3Rpe+2cVSWMYC
         6hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745520030; x=1746124830;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGnBj0MctxhiYiDydSa3ktosc/eiAtqwYCSjVbP7Yy0=;
        b=GJRzPA+R7Kri4Ks/jQeESOsGye0FL+BuZ/pQlkdPNq1m0aj+R4bnjP55/2ooSCKE+U
         NzhV+zB39WVSCvcFRZzSXS8LUW7zNVkRDkSpDUPNeAvBVUdxzrGCdN1ImzHFPsJrtAMr
         1NBrLJZha4rKYLzR4JWYQj11Y/xW9icnQGmqAOxG3PwuTbl/ExZz33/bfmJsLG8rlxuH
         TAipNkbs0GcXt3MwtNMe49AXyxh4Rcya1D9a0jj9j5eCYu7g8jQo3fF7n7HXPujJujb8
         uiNNx7O+AE58h7vgLp6mKc9zU7PsCZmKtaiUTltVG/QfFpbpzNgxy1ov5gLoFEoT/caV
         kX9g==
X-Forwarded-Encrypted: i=1; AJvYcCXWPWHqJHTSavVH89BCSrYHBw3qHuNQYO1ezYYEI28cFgQS6c9cEHWxeSbn4+NfiP0vloEnx6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYFeUBhqOO60iJm9T6qidSWO3eT4WyWJl01WjZk90K2ejjjY/j
	yaW1ALduwNuA85Miq6KOE45v81f2fz48RMwRqEk5XNu7815yTTWc45lWqggQd6inhRIS/qTe3rv
	++xzwafGm37YOxoABDzE11GY3GpkBLECKbQF+
X-Gm-Gg: ASbGnctqcWU+tJJttvTmIytxjo3ZG445t1AOUBVCQMioopIv0DdT8CFeHT5G8aWPyYb
	7g0DzHHKvYnkt+CziALF99Nm2Bt1O2lMeAjDIEat53ExJZh1JefKICDQWYtecUq9xswIw+aj0p6
	U+hgPDbpbeYs5a8sxHPCnksW8/5XqUhx87MQSnVxdVyqSU8+lqBygK
X-Google-Smtp-Source: AGHT+IHCDfyrvPHTWs19PO6sPDWq1lwku0sveEmb/WxDj6x7vMBn1Lw9bzxITGNCvBq7r0DH0K9t5HNCFwGLXJjO4Jc=
X-Received: by 2002:a7b:cc94:0:b0:439:7fc2:c7ad with SMTP id
 5b1f17b1804b1-440a44f0416mr22845e9.7.1745520030151; Thu, 24 Apr 2025 11:40:30
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418221254.112433-1-hramamurthy@google.com>
 <20250418221254.112433-5-hramamurthy@google.com> <aAhAoxmUSCQkq979@LQ3V64L9R2>
In-Reply-To: <aAhAoxmUSCQkq979@LQ3V64L9R2>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Thu, 24 Apr 2025 11:40:17 -0700
X-Gm-Features: ATxdqUG7DLE-ThxHaw-kjJHK32RQCJr7u_Hq3pz_Q8T6X49JnDM-rU6-HmnvJL4
Message-ID: <CAG-FcCO5ntfrdETS_WbEu9qvz82SF1rqabJKw9rTxeX=XiO-8A@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] gve: Add rx hardware timestamp expansion
To: Joe Damato <jdamato@fastly.com>, Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	jeroendb@google.com, andrew+netdev@lunn.ch, willemb@google.com, 
	ziweixiao@google.com, pkaligineedi@google.com, yyd@google.com, 
	joshwash@google.com, shailend@google.com, linux@treblig.org, 
	thostet@google.com, jfraker@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 6:21=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Fri, Apr 18, 2025 at 10:12:52PM +0000, Harshitha Ramamurthy wrote:
> > From: John Fraker <jfraker@google.com>
> >
> > Allow the rx path to recover the high 32 bits of the full 64 bit rx
> > timestamp.
> >
> > Use the low 32 bits of the last synced nic time and the 32 bits of the
> > timestamp provided in the rx descriptor to generate a difference, which
> > is then applied to the last synced nic time to reconstruct the complete
> > 64-bit timestamp.
> >
> > This scheme remains accurate as long as no more than ~2 seconds have
> > passed between the last read of the nic clock and the timestamping
> > application of the received packet.
> >
> > Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> > Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: John Fraker <jfraker@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 23 ++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net=
/ethernet/google/gve/gve_rx_dqo.c
> > index dcb0545baa50..483d188d33ab 100644
> > --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > @@ -437,6 +437,29 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
> >       skb_set_hash(skb, le32_to_cpu(compl_desc->hash), hash_type);
> >  }
> >
> > +/* Expand the hardware timestamp to the full 64 bits of width, and add=
 it to the
> > + * skb.
> > + *
> > + * This algorithm works by using the passed hardware timestamp to gene=
rate a
> > + * diff relative to the last read of the nic clock. This diff can be p=
ositive or
> > + * negative, as it is possible that we have read the clock more recent=
ly than
> > + * the hardware has received this packet. To detect this, we use the h=
igh bit of
> > + * the diff, and assume that the read is more recent if the high bit i=
s set. In
> > + * this case we invert the process.
> > + *
> > + * Note that this means if the time delta between packet reception and=
 the last
> > + * clock read is greater than ~2 seconds, this will provide invalid re=
sults.
> > + */
> > +static void __maybe_unused gve_rx_skb_hwtstamp(struct gve_rx_ring *rx,=
 u32 hwts)
> > +{
> > +     s64 last_read =3D rx->gve->last_sync_nic_counter;
>
> Does this need a READ_ONCE to match the WRITE_ONCE in the previous
> patch ?
Thanks. Will include it in the V2 patch series.

