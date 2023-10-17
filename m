Return-Path: <netdev+bounces-41948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583DB7CC601
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458FE1C2082D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0560641AAD;
	Tue, 17 Oct 2023 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+nh/CRT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA24177D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 14:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776C3C433C9
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697553453;
	bh=1lJq6tix0dEGPLvXVit5DOMdJhrLj+q33FjHiOzhIck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A+nh/CRTVa5ebn4PPqMflfwYxc/IOwxDh5jYdT5ygCOihr2AOhCMKy0IETlBp1slk
	 bT929kvbNOgeoo1jOc7u9LsLad80km6csoICjtdKd4woCQf3mpcpiPTICnAKd+jmys
	 ob/b5QdeQcCVyMCtWWwDuEacxwyrM20UzZkk9Qj3WVO0jyVxBL9oBzcsITM0A3li+B
	 qnB1Yo5C0UQkdkqEuBVhje0W0d7OCiDIN+gU+URfpluAKxgRT/PCksUQ1CFUh0XAbz
	 lx/WyScq/YtnQUbdjt+mQOiOE0PLJD2fb0GyIc8WxOwcJRkwzjSywrEodo9xUk1aDw
	 9sD5+AyylHD5w==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-507ac66a969so2944976e87.3
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:37:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YwLSsgvOtI74GWSJSF0NXTKEDwKmhGNNsop+QJ6bR8HZ1b5wKnH
	Z/sSd4SeVz2194mhPkyt8MInvKmMAshioIgxag==
X-Google-Smtp-Source: AGHT+IFKxCwRYfLzAAxG2AfrFyPrTqzwCFO+8PDIbQ6e7uAzfSsLkCSPW4jrmmJRtgGOZmLRRH3h/NbqSx2yanzLBtg=
X-Received: by 2002:a19:e041:0:b0:503:99d:5a97 with SMTP id
 g1-20020a19e041000000b00503099d5a97mr2000608lfj.20.1697553451702; Tue, 17 Oct
 2023 07:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017063419.925266-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20231017063419.925266-1-alexander.stein@ew.tq-group.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 17 Oct 2023 09:37:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKGasMDpb+_d12SZ-uL1FKSRFfJPmPv1fKvRtyCKgikMw@mail.gmail.com>
Message-ID: <CAL_JsqKGasMDpb+_d12SZ-uL1FKSRFfJPmPv1fKvRtyCKgikMw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] net: fec: Fix device_get_match_data usage
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	NXP Linux Team <linux-imx@nxp.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 1:34=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> this is v2 adressing the regression introduced by commit b0377116decd
> ("net: ethernet: Use device_get_match_data()").
>
> Changes in v2:
> * Update the OF device data pointers to the actual device specific struct
>   fec_devinfo.
> * Add Patch 2 (unrelated to regression) to remove platform IDs for
>   non-Coldfire
>
> You could also remove the (!dev_info) case for Coldfire as this platform
> has no quirks. But IMHO this should be kept as long as Coldfire platform
> data is supported.
>
> Best regards,
> Alexander
>
> Alexander Stein (2):
>   net: fec: Fix device_get_match_data usage
>   net: fec: Remove non-Coldfire platform IDs
>
>  drivers/net/ethernet/freescale/fec_main.c | 63 ++++-------------------
>  1 file changed, 10 insertions(+), 53 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for fixing this.

Rob

