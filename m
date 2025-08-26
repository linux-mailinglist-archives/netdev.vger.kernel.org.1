Return-Path: <netdev+bounces-216777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A520B351D9
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 04:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14FB2458B2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C53928313F;
	Tue, 26 Aug 2025 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFgwSEui"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26D1F8AC5;
	Tue, 26 Aug 2025 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756176328; cv=none; b=G9OxAYX7VaqhsYO3Eje/G3g8UZT6xhMwP+7wfZpNgbHvEMbWbnu2qKWNIdQEhTzWN9ecxGR8Qgz98kL8vN+GUGshKmlPgOy8HzNhlrbvVbmtIseps5sd2fd1Dxt3NUJVxswUfOTtqfSTjvp8TlMuZbbzc7EGmDWEDol2uTM3ZCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756176328; c=relaxed/simple;
	bh=abnLgTNhG7CaI2gsEnFS2UxypTk09Y2tZlorm1O9M68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFREFaBaTUW8VN/kpcAbIYt4fxqyEYxU3wBZMzGnOk92+GGX0XD54WZq4HHyGbXDaH8GHL4y3otJuBGw4WhlZgrxNPtIp0T/8YErzxSAmN3uHlozUelOQyfjiaIVajShwz8H9Uer/oGpMao79o/JpyefOl74j0Sr0FULYTXd8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFgwSEui; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-771fa65b0e1so39254b3a.0;
        Mon, 25 Aug 2025 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756176324; x=1756781124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM05FkQJlEO4i7eReXjUpbYL00uCaHajUI1BGg8LR98=;
        b=EFgwSEuibOPUIIJnH5ng11HlTebbibnA99jkwBY+JVxOF+irgt2yFSl6jC/hQtjt1/
         oeLu3S7gngTkNXtmNI06UgelmQ4s9kTAFv5j0QlJkgWQWq9Ek5fIcuS8TjV34RZzK0no
         TpQ4UuAx6yg8bW2afnHBbUD82Kquf3DFMrpliuBxtEbq+1XxPdS4+xU3RSQVAZj601Tl
         yFqf5O7gSBtVRtAlFVDSb47Aq/rVtzs8k+M7PT+fpMi2yiBxYlU6ZaaFyWgHzaKIz/Lr
         i3Sw6TF6g8IsM5MT6VmaH9vnfwjWBIuI7E065poSrF50jEtlZ8rCKUCu2XUxTNZ/OJ/a
         cHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756176324; x=1756781124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM05FkQJlEO4i7eReXjUpbYL00uCaHajUI1BGg8LR98=;
        b=NiV3ORGb4pMYVaNTsxYuTX/vUJ2QWJl3sNh7CeO9uC7d/9qT0v+EnbUgPTqhq8fOcn
         hgTKYzfBqNbQYWmwfMPxXNpCTCsiHCKloHTAnfotWYZYy0Dq6g2Y14g4WX7snmziteIF
         +sBDi2pb1mFepR8i5oFASMCCWfswzIgEBokZjJPbmwmIwGnAFpY9V0QoevKB1cNUFXVA
         mfWoSQUpiP2kvRCxNkwuzrfQltODEWnl9koITFl3A+HSsMov4SqQkbPCDkeOCiy/6Xle
         8YHHYb4f22hHWFedRwkIZhR2J2h2e6ywUIn1lc9sUtt/4ouC0g1hygRLfGBxPmcM9NK+
         c/zA==
X-Forwarded-Encrypted: i=1; AJvYcCUiJqGzV1cEPtBiP1wmXTBqxyfxTBzHqc2wa9u6GjyUfuH7exWEwLM4sI8cgDsTnPHBmT9Rgwir@vger.kernel.org, AJvYcCVLBMNlJu5bGzXgzths9KRR2w2cNG/wJKhoMKLr220aYNjUYbumGesLq5NFOINRQNrqX8FW2TWvm6yS@vger.kernel.org, AJvYcCXgJBbhCx7Kh499teaiMNqNCGqI0HDOaQ77N2MAlDBb7wFgyZtmVzgkinAiU/8VLPTUZeJpbwAgMVQSQ4as@vger.kernel.org
X-Gm-Message-State: AOJu0YySF4nZpuGB160HoGfwO3zGMEJfJbztbJkAgHtFX00g+rXtIFbr
	GFRhqStplK+hmIOHoFH3qtE//jmhWPa0OyIm9IhNxSwb/q+vyAqmWqbxEHDHIfCl5D0dm7jAZRV
	IL3sgpbtAFV2nMRVIzMI3Ckev1VqyhPY=
X-Gm-Gg: ASbGncuuG+/NYHLcITqkHoW9S1seYJV0gvtjakuVIjcVm9TcJZR3EsY5VmnhmWg2svO
	ML1WGf+DUPGrfuRSrVHtout1AW3uO/sfL4zGCY9Zz3jeFKoXzltc/ylf8nfmtfJPk15+PLMze+g
	0ZbLTQKDPqvoGlfaVKcuJAQNDCsdG45FFEDaurXNPB9tNwSakPat/eEWDi8TRBFgLj5YWW4V6ha
	Sgz8YmqPw==
X-Google-Smtp-Source: AGHT+IFFuv2IUmcx2fHy8lkCEcCKHoqYT3hBJkZ82z5DlB1q+/wf9lyVVMXUYC/y0d0QMkg0yFM3ck61E7kLLjkCDtU=
X-Received: by 2002:a05:6a20:3c8f:b0:243:78a:82bd with SMTP id
 adf61e73a8af0-24340da245fmr21525743637.55.1756176324223; Mon, 25 Aug 2025
 19:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824005116.2434998-1-mmyangfl@gmail.com> <20250824005116.2434998-3-mmyangfl@gmail.com>
 <20250825221507.vfvnuaxs7hh2jy7d@skbuf> <CAAXyoMNh-6_NtYGBYYBhbiH0UPWCOoiZNhMkgeGqPzKP3HA-_g@mail.gmail.com>
 <dd494b15-8173-4b17-a631-f19e9dddf9b1@lunn.ch>
In-Reply-To: <dd494b15-8173-4b17-a631-f19e9dddf9b1@lunn.ch>
From: Yangfl <mmyangfl@gmail.com>
Date: Tue, 26 Aug 2025 10:44:47 +0800
X-Gm-Features: Ac12FXy1JuzM1gNaaw75TB7Abb-essQ4-jJcdoOE5NaAwqv1TPFAbHwxBGqM0dQ
Message-ID: <CAAXyoMO9HmNGxsx6nLH0rbgS6Pgmm0XgU=W5ej977+tF032G2A@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/3] net: dsa: tag_yt921x: add support for
 Motorcomm YT921x tags
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 10:18=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > > > +static struct sk_buff *
> > > > +yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
> > > > +{
> > > > +     struct dsa_port *dp =3D dsa_user_to_port(netdev);
> > > > +     unsigned int port =3D dp->index;
> > > > +     __be16 *tag;
> > > > +     u16 tx;
> > > > +
> > > > +     skb_push(skb, YT921X_TAG_LEN);
> > > > +     dsa_alloc_etype_header(skb, YT921X_TAG_LEN);
> > > > +
> > > > +     tag =3D dsa_etype_header_pos_tx(skb);
> > > > +
> > > > +     /* We might use yt921x_priv::tag_eth_p, but
> > > > +      * 1. CPU_TAG_TPID could be configured anyway;
> > > > +      * 2. Are you using the right chip?
> > >
> > > The tag format sort of becomes fixed ABI as soon as user space is abl=
e
> > > to run "cat /sys/class/net/eth0/dsa/tagging", see "yt921x", and recor=
d
> > > it to a pcap file. Unless the EtherType bears some other meaning rath=
er
> > > than being a fixed value, then if you change it later to some other
> > > value than 0x9988, you'd better also change the protocol name to
> > > distinguish it from "yt921x".
> > >
> >
> > "EtherType" here does not necessarily become EtherType; better to
> > think it is a key to enable port control over the switch. It could be
> > a dynamic random value as long as everyone gets the same value all
> > over the kernel, see the setup process of the switch driver. Ideally
> > only the remaining content of the tag should become the ABI (and is
> > actually enforced by the switch), but making a dynamic "EtherType" is
> > clearly a worse idea so I don't know how to clarify the fact...
>
> If i remember correctly, the Marvell switches allow you to set the
> EtherType they use. We just use the reset default value. It has been
> like this since somewhere around 2008, and nobody has needed another
> value.
>
> What use case do you have for using a different value?
>
>         Andrew

I don't. I'm just giving reasons why EtherType should not be
considered "fixed ABI" (or it is the reason it can be ABI if all of
you are fine with the reset default value).

