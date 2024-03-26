Return-Path: <netdev+bounces-81941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A582888BD4C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AA61F3C083
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 09:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F8D3DBBC;
	Tue, 26 Mar 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAa0ydeV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40911CBA
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444148; cv=none; b=Km7m3alFCUf4Vh7LbHCWR3newjHmVOLm2PQxFUmRTBJKswYbSGZsYqo/f8gdrXT3a5OeNfa8NLqQQkzh9rLWP9JU+Bh0Zol2UjFgB7o9kNlb8uBxVGGpW3YHMiixTp7qnztywRduhEDxIs6f1OcnTtSeWpx+ErRBihJIykNiZhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444148; c=relaxed/simple;
	bh=CUiHeuSgy7tHqAEUAJlCT80zHtWNLVUst1a03tbki5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=roxj+eH6ixs5/FqEIMkehV2LEgtYvN9Qic27uFbTAAGTJgGW/tuITsURzO4NafUiui/cNTBjq+JJydpDrvDb2dVE2lyfWF3v2Ken6A0+IXIzTTuqL7g05wtbn1wrWyyttN6+bA3oelfeXz4sUsuKRfnWNQZ/P+zCZoBI7JzMKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAa0ydeV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711444146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6xILks5m/kwxRXBEhAh4JgyHqnyFdk+Ku7zOgmzY1FA=;
	b=JAa0ydeV4O8pn4IE+5il0NYQbP0RBnneT1qc/L1o1wZR1zHCeBCHRkr3U8S1gTyMFUWhRH
	TEEzY9xm/HGwSSK4Bxx80+WzTh3/VNpgNjL+k7gnXcFmPP8NUgWakp/s077IYIS+Kkb/mz
	ERjOUyyINCWAwkohEh7n+02BoFiP4Vc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-1maZ5-8LNhiiXRcnslq6lg-1; Tue, 26 Mar 2024 05:09:02 -0400
X-MC-Unique: 1maZ5-8LNhiiXRcnslq6lg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ecafa5d4dso982093f8f.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 02:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711444141; x=1712048941;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xILks5m/kwxRXBEhAh4JgyHqnyFdk+Ku7zOgmzY1FA=;
        b=cxoSfU5A6/jFl4MFS91HurEdcPU4N0ALOH5JRXNx7wqbW+gi8n2J1nh1jVqvX/r2/C
         w6NS+Nwy/rdceZ6ZXipS42nG79EubMEJnioATKIHaBJFemX9KXGO0oH1kDHRL2D78/GG
         /cFwTZc+PAU0vdU6ThnTg3SyaaQsh2vjqJO/naJxxxGFZDoWCvVO2/yPVvJ/Z7lA8ylR
         Qs0VaC3Edv3bNL+Frr0IJi0zLbv4pq5wqVqP4fyNIr16GrXMmwmOgn1L5TKC/1rIdDh7
         R6G04jA9qpau6g3B6H4S3i5SkV+vIJsVECT5DBSKfYBMbfyCYsXreBdN87RVndhdr80E
         yezw==
X-Forwarded-Encrypted: i=1; AJvYcCUVlFAxq/alA4pJRHdHArp6NoqMELJaJZ3hh2nWVhrpCqjDmfQ21/KPmWR8hujQ2Z4f+JVVZi8mquUGBxp2z2mIjjsAWN2Y
X-Gm-Message-State: AOJu0YzvXvYnppUXKhW7sj3HJO/zGVl0Xd6NVzdsrfoDJ+DzXuHLcHCe
	byCN4l/TRf1h4FlU5BhRkYZNE3FJiH2qChP0iG39X0ENJh9bG0/wX8qE0wKwbJtlBXscteWVDM3
	H6nekCsS6WWRPJBFMdH9v6KVOMFRIyiQdyIZN5PSlOeC8X1EfKrGTNQ==
X-Received: by 2002:a05:600c:3b0e:b0:414:8889:5a60 with SMTP id m14-20020a05600c3b0e00b0041488895a60mr4360185wms.0.1711444141196;
        Tue, 26 Mar 2024 02:09:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsySWjX9wymKD6dLde9ncsd4IfET+JCWMcgUqCnI0Lh4ShgidRvOf8DME9pD/MkgTD3PtIjQ==
X-Received: by 2002:a05:600c:3b0e:b0:414:8889:5a60 with SMTP id m14-20020a05600c3b0e00b0041488895a60mr4360171wms.0.1711444140815;
        Tue, 26 Mar 2024 02:09:00 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-229-159.dyn.eolo.it. [146.241.229.159])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c191300b00414610d9223sm10957826wmq.14.2024.03.26.02.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:09:00 -0700 (PDT)
Message-ID: <bdfd3a4938e2eb37272a9550c869bb557fb70cab.camel@redhat.com>
Subject: Re: [PATCH v2] r8169: skip DASH fw status checks when DASH is
 disabled
From: Paolo Abeni <pabeni@redhat.com>
To: pseudoc <atlas.yu@canonical.com>, hkallweit1@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, hau@realtek.com,
 kuba@kernel.org,  netdev@vger.kernel.org, nic_swsd@realtek.com
Date: Tue, 26 Mar 2024 10:08:59 +0100
In-Reply-To: <20240322082628.46272-1-atlas.yu@canonical.com>
References: <Zf0-cXhouMkgebDR@nanopsycho>
	 <20240322082628.46272-1-atlas.yu@canonical.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-22 at 16:26 +0800, pseudoc wrote:
>  drivers/net/ethernet/realtek/r8169_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index 5c879a5c86d7..a39520a3f41d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -1317,6 +1317,8 @@ static void rtl8168ep_stop_cmac(struct rtl8169_priv=
ate *tp)
>  static void rtl8168dp_driver_start(struct rtl8169_private *tp)
>  {
>  	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_START);
> +	if (!tp->dash_enabled)
> +		return;
>  	rtl_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);

You are replicating this chunk several times. It would probably be
better to create a new helper - say rtl_cond_loop_wait_high() or
something similar - and use it where needed.

Cheers,

Paolo


