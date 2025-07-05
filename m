Return-Path: <netdev+bounces-204274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE885AF9DA7
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 04:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A735565820
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 02:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B303E26CE30;
	Sat,  5 Jul 2025 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4C3yGeR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830AD2FF;
	Sat,  5 Jul 2025 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751680797; cv=none; b=douath5cbgxRzowBGzbTlDUlRaU/DP6bsMABTH6YVKmbDur14nSkzMtjvNmGo+WrUNQVR4GO0EVVCazsAE9A3B2/oDJmuRL3oAPWY+Zbez7YBYWfCsJ4D21jPNUcdr8JuW5z/VpgEjP+WQURbzPcaQXtWTK8pdyDOYp6OQzSG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751680797; c=relaxed/simple;
	bh=FCd1d/K6fC/wBAGNX11XsXMzrhZV+mxFf8OZMsRgy0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XreexpRYIlWc/zWYOChpqBt9SXUiUm6o1XWkLD6jcSWmUz+thg6pCW3uHxcPGPZOfGSxavwUauRR/G9T5GpNOaW8QpY49Kz+SrwyCKXFWGS7Qq9GldgAZzzvdwHJESeefwF5byATY3ZPDEhhAUtTuPAJKkJII7s+tC//cYQqfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4C3yGeR; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3dc9e7d10bdso5698675ab.2;
        Fri, 04 Jul 2025 18:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751680795; x=1752285595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvTFfaTQbz5ceAbOX/5BwnBOFv0ed8wpLUo0cmp6sEg=;
        b=Z4C3yGeRff2DMiBxEWeiQxIqmsuXdrPU20EjS3natMdj0NwWVJblOWg8aZL+Gy7BfW
         IT+eVw6ttGFGCx9bhfu9KlgfoH7oA8Kue7W9d3OOlSOBELFVgO7Pi0TWaaw9sHI9mIgI
         jELQxfj2m/nhuz79rzrDXXrDMsAXVJUK5sMpGy19T6Ublub9ejPfIxvsNfxsoZFRQiqK
         NP8n/uSIBZVccT8GFYrTK/JTDxfCIejh9GDZTMotuB2ROhGJTjEnySGEWZb2NRQ/EBd/
         MuJmsky8IjR7jA1rGXkNOBrk7PG4PiB6r95r2Y797rnaOXdN8HLkC3EiAf/vcHPWYeWK
         t8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751680795; x=1752285595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvTFfaTQbz5ceAbOX/5BwnBOFv0ed8wpLUo0cmp6sEg=;
        b=GyRnCte2CyWwkJ/cUKTPPZoDdtJFy8w+stgcPzDTRWi+4bdc2YRogGGRYfGBTrJAKI
         CQLmt71g1NjqU8u1wiwFJXvP1PU/Q44Dq9ipplnwP+g4zJufu1sPK+rDObZ+JTBsH97o
         Bo65JASq1i5itKud47ID5mqwGOaxcsZobS2Fy1kFvEz+OV4d7y6JlIOK/wGEdoMYwQK6
         xVQIAF4Y958D5A8mmI8i+DDSggkyKV/qc+rLepFckvR1GnEC7XdoPrFLhH9eh6tzbeXb
         yKeVmCOMbI8nYOZnXXWB1KDy7mXVgY3Jm+TgjI8oW0bjNnKZexVVB1w6h6a45DFhMTFS
         BBmg==
X-Forwarded-Encrypted: i=1; AJvYcCUV2TIjILEmTPdNpNz4VfB1c5IkwWeLiUYeyi49ZLfj5GWGmUisxd6IONZRkgjbHLki2tJkDrfR@vger.kernel.org, AJvYcCXINqY+8C1BK/caFIzTrf81VlWZ80JC2CKRbm+6vkf5w3yAn8cTGlLjv9jwPV9M2fhRdxaADxEx6n7pPJXP@vger.kernel.org, AJvYcCXNjwveBR+U9VGEvlmiCMuxwQdj/K4CQYQtWcLmTFuKQ/o0MAlfL9X9ZQ5psAAE2EUJ4P5ctkkN26bVTpuVgcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzgFEmFP7KtshJZN+d3U2Rhl6XaKJG2Jw9me6Nmwgc9mxa9Ptn
	izR6MrSXTlGnbRhiWuCYrNp5IgAl39u6PNcR4izQJwDuni3KADse4X4KJnjEEK+VC8BtG2zJ2bZ
	Au2NTQI1stGxI3aM9sNnd8JGyGPRTR84=
X-Gm-Gg: ASbGncsjCEDLkHgyuYp1ihifjVvUi42zrdhBuAoGAAojaCFgWprn/4hBhMb28j2Q6BB
	mdPLZcMO8OpRMOQXL+v9gAonFjeSMHHQnMoVt7CyYOJREfhUJgP8xuB0QWXB3SSL3B9Oi1UzhHo
	2WONnbmVCVbZHODpusN7bRhudAy7yWBet34hZb4f6Norc=
X-Google-Smtp-Source: AGHT+IGdCXBchpRMQCqORUJWEuDS5EyBDntZyt4/2/88v4pBd0QjPDICGNid8TyJLpyBU99JO8ztDs6TT8TexwCsSTY=
X-Received: by 2002:a05:6e02:1d86:b0:3df:2d65:c27a with SMTP id
 e9e14a558f8ab-3e13545d5f6mr47074555ab.1.1751680794984; Fri, 04 Jul 2025
 18:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
In-Reply-To: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 5 Jul 2025 09:59:18 +0800
X-Gm-Features: Ac12FXy_4rJRcmDzn8UyYBJj6WI_LYpydeme8fVOJEy5-tg6gI_N5u7FutFHvB0
Message-ID: <CAL+tcoAXCbhNG2-Pdd7C3iJD9h=GvM1PNstyMJXO8KE7XKAzDw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
To: yang.li@amlogic.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Fri, Jul 4, 2025 at 1:36=E2=80=AFPM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> User-space applications (e.g., PipeWire) depend on
> ISO-formatted timestamps for precise audio sync.
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v3:
> - Change to use hwtimestamp
> - Link to v2: https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c8068=
@amlogic.com
>
> Changes in v2:
> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
> - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb=
@amlogic.com
> ---
>  net/bluetooth/iso.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index fc22782cbeeb..67ff355167d8 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2301,13 +2301,21 @@ void iso_recv(struct hci_conn *hcon, struct sk_bu=
ff *skb, u16 flags)
>                 if (ts) {
>                         struct hci_iso_ts_data_hdr *hdr;
>
> -                       /* TODO: add timestamp to the packet? */
>                         hdr =3D skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SI=
ZE);
>                         if (!hdr) {
>                                 BT_ERR("Frame is too short (len %d)", skb=
->len);
>                                 goto drop;
>                         }
>
> +                       /* The ISO ts is based on the controller=E2=80=99=
s clock domain,
> +                        * so hardware timestamping (hwtimestamp) must be=
 used.
> +                        * Ref: Documentation/networking/timestamping.rst=
,
> +                        * chapter 3.1 Hardware Timestamping.
> +                        */

I think the above comment is not necessary as it's a common usage for
all kinds of drivers. If you reckon the information could be helpful,
then you could clarify it in the commit message :)

> +                       struct skb_shared_hwtstamps *hwts =3D skb_hwtstam=
ps(skb);

The above line should be moved underneath the 'if (ts) {' line because
we need to group all the declarations altogether at the beginning.

> +                       if (hwts)
> +                               hwts->hwtstamp =3D us_to_ktime(le32_to_cp=
u(hdr->ts));
> +

I'm definitely not a bluetooth expert, so I'm here only to check the
timestamping usage. According to your prior v2 patch, the
reader/receiver to turn on the timestamping feature is implemented in
PipeWire? If so, so far the kernel part looks good to me.

Thanks,
Jason

