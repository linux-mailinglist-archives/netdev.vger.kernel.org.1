Return-Path: <netdev+bounces-90591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B918AE92F
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 16:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960AEB2633A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAA513AD3C;
	Tue, 23 Apr 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SvoKQV2Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA213AD0B
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881420; cv=none; b=DrBd4hVgX9TJtcSQcnCQ6gsATbUIU0oqEMSIFBCDMfy8co80i8JmOub/ZipeP4YrhPV0+En9zwVHDQeARn/+NjriNTEhCvUFz7dKEpz+H/V3mM29g1Ao2EqiqywfQqf7ofwE2mnbNJ0vZnSQ0pfbqmBegG//UOBMmFS8oMpwPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881420; c=relaxed/simple;
	bh=8vCT6GgBfiWWTRo1K6S36+Bf7DHRYQO9bOz5YVWhoM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEbiuqzMhOl9Qct15sjj1zCvsvYWECJcXxGe2csGVdZaROIDT9vLsyJDlu9u0PxVkxuE4OjlHNkBy1pYybS+xgUxPbQYKua+FdEpA0yToKI1uwhhIw71usfUSP74qzEZxT8dQumMeLnNe4/5PqtUcwsIp+AHz7w9//LZPaalHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SvoKQV2Q; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so15144a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713881416; x=1714486216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57fbJa8Cqm06V2ZeHJvielxUFsz8TmnwQIW1J9QeY04=;
        b=SvoKQV2QrJlLoA2z8jctD8mQdnIavT1dq8XFjVlWoJ+PALeAzIwLyBEGScAU3CT67Y
         J+vikZNfao8PT9N0219iX8zxF3MKoP1uJv8E7wUBzJ3o8klTOloC1AQ1oBZfVsqg5I1v
         dZ9WxrcfHczXJT3jKkQxLSKEnUmU4BUmaDjZBwiNqRW6GmTqwjaakP03PleO/35nKR2z
         KOgrDxY9dHn8tFus6bpFiNfde37HjgOzhRAnCZE1pLOCym05m8+xB5ONcte37wRuDQwl
         wgewGHotZ08WD1dD2Ks54bNdm/sDYuJPTIS0cOGL6+EjecC4z3th8svKzdLXFaOIxhKp
         uJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713881416; x=1714486216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57fbJa8Cqm06V2ZeHJvielxUFsz8TmnwQIW1J9QeY04=;
        b=r+10clBNROYc3e08cg+jFvZh+RU1V3uwNIxo0M2R3pvjERmPE34IdXILibDQpVWwuv
         eo6YBtAEy8+Gq8iwZmmqFyt/mgsO3mzln7xADlLqAAGtGjCZJkVPcYg17BzQNsuTHFWf
         KtWj2npDQf/RXMmy68Q/jgeEoxAcgA1z0yPvHettTeGe5LxKlhXL6XEPabLNhLkrytx0
         dXbmwxgrjWAi9JJDJLK1aiNjY/qOUBapJ7BL9955zW7A+UZkHfnu+oz/YgdkJBJ6pM9X
         cJN9ILALSmUyJWvPENBLhYsQJGoraFiOnsUvqh5VXbAmRznlxsU7g39r78iXtfhVtkbq
         7Csw==
X-Gm-Message-State: AOJu0YyMQs31UNEVSsX/L87mC9843TqbUCWr0u3ln/1IDyK+IBfqvS2Q
	RV3W6dMw7dzj7QZ0JBnWCsqirKdWQMnyth3vvP/g9/G+Qo4FAHn5c3VUAhnUoAaZdWcG5Ibhvmr
	wi7G8jTCH3rulrXFm1amKwXv4hmuzYWvoYNN8
X-Google-Smtp-Source: AGHT+IFKMJbkXvNVepKk5DFhQD95LPFER6KYKwveNEskM71CTHSLjko+K/mmIBKYtON3Ufe0XHQHKGyKgRlS3i13O24=
X-Received: by 2002:aa7:df98:0:b0:572:2611:6f38 with SMTP id
 b24-20020aa7df98000000b0057226116f38mr29594edy.2.1713881416313; Tue, 23 Apr
 2024 07:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423134731.918157-1-vinschen@redhat.com>
In-Reply-To: <20240423134731.918157-1-vinschen@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Apr 2024 16:10:05 +0200
Message-ID: <CANn89iKv1J3AS3rEmEhFq5McHmM+L=32pWg3Wj4_drsdKUx77A@mail.gmail.com>
Subject: Re: [PATCH net v2] igb: cope with large MAX_SKB_FRAGS
To: Corinna Vinschen <vinschen@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, Nikolay Aleksandrov <razor@blackwall.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 3:47=E2=80=AFPM Corinna Vinschen <vinschen@redhat.c=
om> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> Sabrina reports that the igb driver does not cope well with large
> MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> corruption on TX.
>
> An easy reproducer is to run ssh to connect to the machine.  With
> MAX_SKB_FRAGS=3D17 it works, with MAX_SKB_FRAGS=3D45 it fails.
>
> The root cause of the issue is that the driver does not take into
> account properly the (possibly large) shared info size when selecting
> the ring layout, and will try to fit two packets inside the same 4K
> page even when the 1st fraglist will trump over the 2nd head.
>
> Address the issue forcing the driver to fit a single packet per page,
> leaving there enough room to store the (currently) largest possible
> skb_shared_info.
>
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRA=
G")
> Reported-by: Jan Tluka <jtluka@redhat.com>
> Reported-by: Jirka Hladky <jhladky@redhat.com>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Corinna Vinschen <vinschen@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2: fix subject, add a simple reproducer
>
>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index a3f100769e39..22fb2c322bca 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4833,6 +4833,7 @@ static void igb_set_rx_buffer_len(struct igb_adapte=
r *adapter,
>
>  #if (PAGE_SIZE < 8192)
>         if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
> +           SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||

I wonder if adding IGB_SKB_PAD would be needed ?

adapter->max_frame_size does not seem to include it.

I would try using all mtus between 1200 and 1280 to make sure this works.

Thanks !

>             rd32(E1000_RCTL) & E1000_RCTL_SBP)
>                 set_ring_uses_large_buffer(rx_ring);
>  #endif
> --
> 2.44.0
>

