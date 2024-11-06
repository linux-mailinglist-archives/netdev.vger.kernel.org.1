Return-Path: <netdev+bounces-142266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3329BE175
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913E51C23277
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505091D5ACF;
	Wed,  6 Nov 2024 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KfIBiQoq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C420B1D0DF7
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883605; cv=none; b=JFa0dV9p7kP8UcddSyDTM1UffZFhftdmxg+f5I8EBJeE/TrpZmg3GUB8jGg1vueyx95GWlgFPBK3VcpfuL+CFH7B6MAqPFtONUd8svdMB76hRueMO5zVufLr20I6t3MAWEKqq3F0YTldKVjPYM4Pn+D7oWLWj3gA08QN6/RiCqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883605; c=relaxed/simple;
	bh=CTRNTO8ZKCW4lZ74lyok6RIGIoeOi2Z73uX0/rcDlxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=of0/RML3DH8x5mmBrqllSHvVcugjUYswdqe+CGUlUfo6s4uoxttRmoCgOhlrDSpKDYcpDIJsFF3MCctzaHyb/tnryysPs3jmGa9wGERQrygDrTUlPvqoCQi0LShVgwJe6jCXPWlZXt1HOQbPIh4+BsyMgsH8N3vsDYEEJKnvsak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=KfIBiQoq; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 568773F185
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 08:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730883598;
	bh=CTRNTO8ZKCW4lZ74lyok6RIGIoeOi2Z73uX0/rcDlxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=KfIBiQoqbzp1QjIgdMYuFdeCiPLqw9ipzGW9ambQImMidSoGZNWMmGFOWXTD0zNb/
	 itF6wzG/vRNSGfHlq7C27aUQe2QwpUlzJqO8M4SA7dhQ7WQX/sz6Qeqza65FMZNXyD
	 zX4xTqUz4pPxkGnibOJGJZhalZmaWjhWgnQQxdj+NdyOhGzhzxJc7S8IXsxZR/RI8c
	 d2lZqq9/dFDsdV6V7K8Y2mOmzc0BgDNRb00gqIcsPJHH2Zi3+MX3utDh7SlCeN/xa6
	 ip1AIr95imMjLYGepw//UuYaD821vue/M58yh/EINkW1M48pDliJ56lHdGedZy4Ukr
	 ntevNtun0LyUg==
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2fb57430706so48315531fa.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 00:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883598; x=1731488398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTRNTO8ZKCW4lZ74lyok6RIGIoeOi2Z73uX0/rcDlxs=;
        b=Zz02zogF/wzBFbyUOvRpkNRmr89iwRXffzliwVd6kzO1tW4lFb0MfaHNKZI/EuiR39
         wRKhGPqAusD5vj3i/Jv+5QeOjrHEjIVo90KIT50uFR/7q/zDFrj+sXTGzpdGteOucS5S
         +huEYyItcWiFeRo7B8DX/RZH8Ao0fMeAfXkStPe0hfrnFy5BWXoXIkHfx4RsIEDQyrN5
         klvEw13RdAzbNBbF6x38OqtpKufcvNhoD3MxxC89TQP8NirvjO62TRV2tMnv+xB9JVk8
         GtUhzKX/m7TTwCZ6snhYi026SVS4bGBDzhEPE/PxAAKojC0blC+ucKkABKZPyf7rWAnG
         xwoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhGT90hiXubWRqlBPpifGlSpmphO2WOczTEPzOM7hgRytWX8U9xfAAtO5FZQoTvjoMmbKUoLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFYBWz9b3UfYHuzp4i+KIpc8ltN7Sf7NtMQOBHqzxiCHu8EqNw
	AoSFuReXM80Lt8zL5Q7fzPdsJZy/oCP7PUMNJl+xHuAkHH9pzX2W2TFPrCAj4BlXVcptpmeVCR3
	2IaH5yQEI9bpi0AMxMbF7PkAJvq/+fh8DC3KwIJW8yBpq766mjwc8rVZTeOtkwRNIUQXUlFTo1f
	rwHfMAIFHFYnRV725gmCTjoZAunJ5oAs+elPYnZU/5SNUn
X-Received: by 2002:a2e:6806:0:b0:2fb:607b:4cde with SMTP id 38308e7fff4ca-2fcbe0786b1mr150047851fa.39.1730883597647;
        Wed, 06 Nov 2024 00:59:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJaGEtokguifM8cMLvOdkXIu4iNYbgiZGNV4MPaQC6rYmju6qYIm7lGJjDAWz5wVYgI/LssZmJVriSpqiFGMQ=
X-Received: by 2002:a2e:6806:0:b0:2fb:607b:4cde with SMTP id
 38308e7fff4ca-2fcbe0786b1mr150047661fa.39.1730883597123; Wed, 06 Nov 2024
 00:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <660b6c9f-137d-4ba4-94b9-4bcccc300f8d@nvidia.com>
 <20241106071727.466252-1-gerald.yang@canonical.com> <2b64b3d5-3cce-46b3-81e8-f914a1f18d2c@nvidia.com>
In-Reply-To: <2b64b3d5-3cce-46b3-81e8-f914a1f18d2c@nvidia.com>
From: Gerald Yang <gerald.yang@canonical.com>
Date: Wed, 6 Nov 2024 16:59:45 +0800
Message-ID: <CAMsNC+uz7pga-W8XmDmk+0mH5AmPjhh1Cc_9y3PJ=ZVP9g0TAQ@mail.gmail.com>
Subject: Re: [net 09/10] net/mlx5e: Don't offload internal port if filter
 device is out device
To: Jianbo Liu <jianbol@nvidia.com>
Cc: Frode Nordahl <frode.nordahl@canonical.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Ariel Levkovich <lariel@nvidia.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeed@kernel.org>, Jay Vosburgh <jay.vosburgh@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 3:28=E2=80=AFPM Jianbo Liu <jianbol@nvidia.com> wrot=
e:
>
>
>
> On 11/6/2024 3:17 PM, Gerald Yang wrote:
> >>>> From: Jianbo Liu <jianbol@nvidia.com>
> >>>>
> >>>> In the cited commit, if the routing device is ovs internal port, the
> >>>> out device is set to uplink, and packets go out after encapsulation.
> >>>>
> >>>> If filter device is uplink, it can trigger the following syndrome:
> >>>> mlx5_core 0000:08:00.0: mlx5_cmd_out_err:803:(pid 3966): SET_FLOW_TA=
BLE_ENTRY(0x936) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0=
xcdb051), err(-22)
> >>>>
> >>>> Fix this issue by not offloading internal port if filter device is o=
ut
> >>>> device. In this case, packets are not forwarded to the root table to
> >>>> be processed, the termination table is used instead to forward them
> >>>> from uplink to uplink.
> >>>
> >>> This patch breaks forwarding for in production use cases with hardwar=
e
> >>> offload enabled. In said environments, we do not see the above
> >>> mentioned syndrome, so it appears the logic change in this patch hits
> >>> too wide.
> >>>
> >>
> >> Thank you for the report. We'll send fix or maybe revert later.
> >>
> >> Jianbo
> >
> > Hi Jianbo,
> >
> > Thanks for checking this, since this issue affects our production envir=
onment,
> > is it possible to revert this commit first, if it would take some time =
to fix it?
> >
>
> Hi Gerald,
>
> I already sent the fix to Frode last week. Have you tested it?
> Better to use the fix instead of reverting it, right?

Definitely! Thank you for the fix, I will check with Frode.

Thanks,
Gerald

>
> Thanks!
> Jianbo
>
> > Thanks,
> > Gerald
> >
>

