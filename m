Return-Path: <netdev+bounces-58980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A74818C34
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 17:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2951F24494
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563CF1D552;
	Tue, 19 Dec 2023 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1+y46sKO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B61F94D
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so14918a12.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 08:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703003360; x=1703608160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+HI8VRB97V9ukNCw4PGPycHE1WNyqlOtmOXfjeiCeg=;
        b=1+y46sKObUzph/8mCCXQ3ImaXwi5GQVu7nDpdPnZaFbLsXTNdvVVcHB4a183J/VWkS
         0t3/tjOeWaRqWvQtJSxbcbrFtfE+SZWOoZyASaa8dLPEcaTGkANJQKfViquFhf7f9jMC
         cV9Q81Hn0EX4bwY2ck1S31ElqvLcvPH61oXzvpGGL+tDAy5WlFq+Ntv+wT/AqzupAdJu
         efyzykQfi7uLrKzJ2MtI26LALsSBcyryUdousvOREhgaMzmJ5YEvid+TxdZDx1EMQAnw
         J/GY7Ewhyxgy4wSbmBWm6J5GOBS3PCEusYQeCpNw3/WBthJ+rDGQAgK+JINFDeLZ2Shq
         aKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703003360; x=1703608160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+HI8VRB97V9ukNCw4PGPycHE1WNyqlOtmOXfjeiCeg=;
        b=j5iJOcQvg6x5CszScrHwpmOhVuGybDqXtqvl7rFeA2fT8WHhUaT6tCCTkSZB4orQLg
         SwgKJ/D2aKvLKRQD/3ljTQDi0gETW60tcATtPRRrjKAqIuB7h+IfwoTNqENnt+uO90iZ
         DxYj5ePGTOBodd40BkL3mV9rtLTZAJ7nIcxmuS2mKWHcLV6curEc7ifBHnzEnWIddA6j
         YO9c6uI9XPZxsKHOTSZSk58FpPXni23oXmK3AEBjn3faDU3XvDuaXZU1THZklbs61GiW
         Uj6WhTD1lMnSoZ1DmiJMaTLJonaHp17N7oTM2rhGylMFXYRMQIfHVLPcASmBWbbVPgak
         X7Ow==
X-Gm-Message-State: AOJu0Ywa7Bii6Pcp236syWZqLGYo38O/Qqmp+QUxKVnY5vD+jlAqwngv
	WZkohY9dbgduLS281At5YADIxs3B035FNpWAmV6nOwtWZN2n
X-Google-Smtp-Source: AGHT+IEO0YSACAslWtOthIm77NEo/XYziJm3IS8SPBS043mIF8caM7ncCknFkZSSUvBbL3XlGwUJEHnYld2HXGvgqm0=
X-Received: by 2002:a05:6402:311c:b0:553:b7c6:1e47 with SMTP id
 dc28-20020a056402311c00b00553b7c61e47mr5838edb.2.1703003359857; Tue, 19 Dec
 2023 08:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702563810.git.lorenzo@kernel.org> <b1432fc51c694f1be8daabb19773744fcee13cf1.1702563810.git.lorenzo@kernel.org>
In-Reply-To: <b1432fc51c694f1be8daabb19773744fcee13cf1.1702563810.git.lorenzo@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 17:29:06 +0100
Message-ID: <CANn89iKytnOU3_mR2RidXE74ad3x9QdWxGf+OZei4tpL8Wvcbw@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 1/3] net: introduce page_pool pointer in
 softnet_data percpu struct
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, bpf@vger.kernel.org, hawk@kernel.org, 
	toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com, 
	sdf@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 3:30=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> Allocate percpu page_pools in softnet_data.
> Moreover add cpuid filed in page_pool struct in order to recycle the
> page in the page_pool "hot" cache if napi_pp_put_page() is running on
> the same cpu.
> This is a preliminary patch to add xdp multi-buff support for xdp running
> in generic mode.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/linux/netdevice.h       |  1 +
>  include/net/page_pool/helpers.h |  5 +++++
>  include/net/page_pool/types.h   |  1 +
>  net/core/dev.c                  | 39 ++++++++++++++++++++++++++++++++-
>  net/core/page_pool.c            |  5 +++++
>  net/core/skbuff.c               |  5 +++--
>  6 files changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1b935ee341b4..30b6a3f601fe 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3319,6 +3319,7 @@ struct softnet_data {
>         int                     defer_count;
>         int                     defer_ipi_scheduled;
>         struct sk_buff          *defer_list;
> +       struct page_pool        *page_pool;
>         call_single_data_t      defer_csd;
>  };

This field should be put elsewhere, not in this contended cache line.

