Return-Path: <netdev+bounces-232180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90A6C02269
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516133A4EE2
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0895B2D5955;
	Thu, 23 Oct 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUjebekZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E28C32C93C
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233431; cv=none; b=VttcnowWAWxD6Yy8ZXnURHaQNRMsYlTR7j8HYTB4LWCq0DewarJeYfRMvOJ4cz1mhSCkNVU+Oumsn1p6ndaJqSGaDD1oqapL72Eq/xUOh8zuKDdin5Tc637j+3zN5XSK9RweQeX9QVtiFnFTBeKT8FUKKb+c9i9uztqoO+IepcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233431; c=relaxed/simple;
	bh=YzVTPHdODtgkjfAqPo2TUs8C0w4zPG177BNAJw4rqZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmaHPlhQBDoCCWViSJFWCa2z37BBGf6iPnqdRnsC6klv1ivaN/OHC2rtIw2ztrxvBhj3kup8XpoWVarresDebw1rlVgo6/3hxlANX4U65riG/R37lHlE6FONFqTrUypRgOVOwgDSb20tQScyoVgjFRqsTXLI9WtAXedgkVcJO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUjebekZ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-378d710caedso11409801fa.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761233428; x=1761838228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0XSwLp3rurZjcg/iCUuM2j7M+MsdyW5UCWdMSUqC0M=;
        b=NUjebekZ44xhiOn7fswI/DrPaa8A1m0ey4lS0VvbjzcxgVDR7kH14M8byMgKGnP+Jn
         eP9kZkUYC/4cOUa+PvjOBv1qHd3CIesVPMWSXfNvnhxBMNTHx1U66tBmESFQqGFxjcK/
         5gmGgwCkZU0jqvpNQFgOM2MwwoKMqWXe9dBX/DC66rOU9z/ms9XkeYHmHziYd8DycWY4
         ke1/6laVTb2+n0CyemZdTxO8LT9/Hx1oOEJDlipQOVSp8TeekuMLY9vps62mj7Aji2sE
         7NH97HOw52hea8dGG2/tkHfm7ANKtxwfICoCrpI0PAssYkEOrQCloPJ1FncF2U6bq5J4
         oVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761233428; x=1761838228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0XSwLp3rurZjcg/iCUuM2j7M+MsdyW5UCWdMSUqC0M=;
        b=rLMNYgQt8ib9N7UPcE+7VpzQNwGu48L6dMK053arRWVGy+WBKwl96vCDp8OeRPJ6jF
         Rb+2k2CrA2S2FeXqB/LvoignYZ4AM9S6JM/p4eZpZAA6/WIJh/DrTkwXn8VEppvjymgI
         uah4+3lwMNFdG7cLQayxCIMDeYlyOvoeEbYgN3A5EOZm0zjxHcUr2dMrIuuo0aW60rkU
         R1ZcfNBIVyu/iJVFoUwzs1aygfY+y5Y8OW/s2kxW44DwhsLA0bZqTEhNMoyFdPFvsEbH
         sw/ezWs1LYxw77bIFbhxMeFhd1VEBofMVQMt3A41nTaNDP0sD7EIvR4AP3VqATcpw5UL
         P+2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKMNakhkuQVutkWwLDiQDewYFGIgSmConDX4gb5bmD7rJAM1TNVKpSKdUPnwjRlyGqvteBU74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjJooVH9aCX6qEPbGEdvvx3g5vuP/9ze/Xoy9I0lHDhClNMJF+
	BLuLNsFu+dn8Q6Oz0JACf6j4EHjqkevS++CDLO33ZOFzJkg3HbN6DAb59ve/WUJRDVFo4WNAxCu
	UA2G/G3eJCUbm9EINR7seQ08MjwH5PGM=
X-Gm-Gg: ASbGncvtRNzNOenjdCtLKWeWi90pwWNnudR5v4Q24Di3ynfQkVKYK+AyVNQVY+kaWPk
	vwu5PnBE0omHSptfgFCMRSGk6IAvLEvYWMSkz00S6W3ty1jxIEQ/gkoWCT6HsApVK8shdvaWJiv
	/VXaE+0dG53gI87irDq8daM0g82ChM4qA+K4mJH/7UhPPpvrDjCgo3Wx/EjBs3xXh893qsZLpEm
	84lqRCztG+Dog7V4bEr9KuGiFWi41VHKtYvJqaBDXgn7JeOuIkn2zmxZHo=
X-Google-Smtp-Source: AGHT+IEl2RZUYKaxM0WfteL/2R/j53zPX3tj0HhGZt5tPLqP6lrSOo3325jPU8Ww8DOZFgCUY+vG16twN/43XsEvtvE=
X-Received: by 2002:a05:651c:504:b0:378:e0e0:3b3a with SMTP id
 38308e7fff4ca-378e0e03dadmr2000661fa.14.1761233427702; Thu, 23 Oct 2025
 08:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020151255.1807712-1-Ilia.Gavrilov@infotecs.ru>
 <CABBYNZKUNecJNPmrVFdkkOhG1A8C_32pUOdh0ZDWkCNkAugDdQ@mail.gmail.com> <3935eaf3-3a58-4b2d-b0ee-4c6c641b5343@infotecs.ru>
In-Reply-To: <3935eaf3-3a58-4b2d-b0ee-4c6c641b5343@infotecs.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Oct 2025 11:30:14 -0400
X-Gm-Features: AWmQ_bkT8LCrUdEn-siB3b4sJ2bnnDD9OQtnOwalGePObC_ChNWXpM67mT3yEBw
Message-ID: <CABBYNZJLtTiFZ-1LchJ7Cy1JT=vuDmkkRHjrUY92jC740ihs5w@mail.gmail.com>
Subject: Re: [PATCH net] Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern()
To: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilia,

On Thu, Oct 23, 2025 at 11:08=E2=80=AFAM Ilia Gavrilov
<Ilia.Gavrilov@infotecs.ru> wrote:
>
> Hi, Luiz, thank you for the review.
>
> On 10/23/25 16:18, Luiz Augusto von Dentz wrote:
> > Hi Ilia,
> >
> > On Mon, Oct 20, 2025 at 11:12=E2=80=AFAM Ilia Gavrilov
> > <Ilia.Gavrilov@infotecs.ru> wrote:
> >>
> >> In the parse_adv_monitor_pattern() function, the value of
> >> the 'length' variable is currently limited to HCI_MAX_EXT_AD_LENGTH(25=
1).
> >> The size of the 'value' array in the mgmt_adv_pattern structure is 31.
> >> If the value of 'pattern[i].length' is set in the user space
> >> and exceeds 31, the 'patterns[i].value' array can be accessed
> >> out of bound when copied.
> >>
> >> Increasing the size of the 'value' array in
> >> the 'mgmt_adv_pattern' structure will break the userspace.
> >> Considering this, and to avoid OOB access revert the limits for 'offse=
t'
> >> and 'length' back to the value of HCI_MAX_AD_LENGTH.
> >>
> >> Found by InfoTeCS on behalf of Linux Verification Center
> >> (linuxtesting.org) with SVACE.
> >>
> >> Fixes: db08722fc7d4 ("Bluetooth: hci_core: Fix missing instances using=
 HCI_MAX_AD_LENGTH")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
> >> ---
> >>  include/net/bluetooth/mgmt.h | 2 +-
> >>  net/bluetooth/mgmt.c         | 6 +++---
> >>  2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt=
.h
> >> index 74edea06985b..4b07ce6dfd69 100644
> >> --- a/include/net/bluetooth/mgmt.h
> >> +++ b/include/net/bluetooth/mgmt.h
> >> @@ -780,7 +780,7 @@ struct mgmt_adv_pattern {
> >>         __u8 ad_type;
> >>         __u8 offset;
> >>         __u8 length;
> >> -       __u8 value[31];
> >> +       __u8 value[HCI_MAX_AD_LENGTH];
> >
> > Why not use HCI_MAX_EXT_AD_LENGTH above? Or perhaps even make it
> > opaque since the actual size is defined by length - offset.
> >
>
> As I see it, user programs rely on this size of the structure, and if the=
 size is changed, they will be broken.
> Excerpt from bluez tools sources:
> ...
> structure of mgmt_adv_pattern {
> uint8_t ad type;
>         uint8_t offset;
>         length of uint8_t;
>         uint8_t value[31];
> } __packed;
> ...

Well it is broken for EA already, so the question is should we leave
it to just handle legacy advertisement or not? At some point I was
actually just considering removing/deprecating the support of this
command altogether since there exists a standard way to do
advertisement monitoring called Monitoring Advertisers introduced in
6.0:

https://www.bluetooth.com/core-specification-6-feature-overview/?utm_source=
=3Dinternal&utm_medium=3Dblog&utm_campaign=3Dtechnical&utm_content=3Dnow-av=
ailable-new-version-of-the-bluetooth-core-specification

The the standard monitoring list doesn't seem to be able to do
filtering on the data itself, which I think the where the decision
based filtering used, so it is not really compatible with the MS
vendor commands.

>
> >>  } __packed;
> >>
> >>  #define MGMT_OP_ADD_ADV_PATTERNS_MONITOR       0x0052
> >> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> >> index a3d16eece0d2..500033b70a96 100644
> >> --- a/net/bluetooth/mgmt.c
> >> +++ b/net/bluetooth/mgmt.c
> >> @@ -5391,9 +5391,9 @@ static u8 parse_adv_monitor_pattern(struct adv_m=
onitor *m, u8 pattern_count,
> >>         for (i =3D 0; i < pattern_count; i++) {
> >>                 offset =3D patterns[i].offset;
> >>                 length =3D patterns[i].length;
> >> -               if (offset >=3D HCI_MAX_EXT_AD_LENGTH ||
> >> -                   length > HCI_MAX_EXT_AD_LENGTH ||
> >> -                   (offset + length) > HCI_MAX_EXT_AD_LENGTH)
> >> +               if (offset >=3D HCI_MAX_AD_LENGTH ||
> >> +                   length > HCI_MAX_AD_LENGTH ||
> >> +                   (offset + length) > HCI_MAX_AD_LENGTH)
> >>                         return MGMT_STATUS_INVALID_PARAMS;
> >>
> >>                 p =3D kmalloc(sizeof(*p), GFP_KERNEL);
> >> --
> >> 2.39.5
> >
> >
> >
>


--=20
Luiz Augusto von Dentz

