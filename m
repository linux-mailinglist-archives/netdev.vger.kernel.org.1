Return-Path: <netdev+bounces-245745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1967CD6DCC
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 18:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37CFE301D5BD
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 17:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D33033890B;
	Mon, 22 Dec 2025 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNa3vbgR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B79337BA1
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766426250; cv=none; b=YoUt96cttee9towCX/RNfwApw8aoDHqgb70GnrL5Ldn+J/h/0HUOAifkZFqZQLzzUjqMw6p9iqNLSxyhrbYiEA1eyevXzS4/bsuqRcLnzYoBIY8th6mgav/Z+LdIXlIX/l3x34xvSXcp4j2LnR9beTNceVH7AxfXuUfPGVSZl3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766426250; c=relaxed/simple;
	bh=wBha3d01qjiMew7UlnJKYluL6OwpP6oM7rEy/5DQKRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlmV9So6ZfGhuvxckVwODT6O3yQeHDWB17CFZxjdfOFb90OPIR7fWclVMk/11bCmTg8hq7rJ0EVpmUv4Sb0jMtXBPbgdko4giNsNNTeTaZhV9mLvEANGDKMaEGzpfhpHL4UIBBjFTeIReIJ8f5C0D+cq9WhAlR6uvwMjm3v5oDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNa3vbgR; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so3830453a12.3
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766426247; x=1767031047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBha3d01qjiMew7UlnJKYluL6OwpP6oM7rEy/5DQKRo=;
        b=LNa3vbgR/8VDkKsgceoMQFQpTBdDrdaU7Ix0pVzNoL1MeQOtmi+a+PQDJi0Ca3XF8q
         ppxU8XvnRPEihqkwhUIRDYfy+jTu7hrjHD9X1de+Qzmtkd5ulyDu9AS5/7YCXO0ra7/E
         Q0myErxYccGUCiRDFhCDFK2M+hsYT5qUpMBx/jFLE9KlXcij37RNBBsz+dTt16lB4gsI
         jVffezsPbNvK++8pGGKoN/Z221V1Ao2pbdLY6VC+WFJrj4wsxbx6KEr7nfJBrxj/wGHQ
         BblWoKp/04rWMM8Aik1GIgXD8oarLZMnU4h8JYlmqp1QixKO0k3CVpxpPi2trsNVpAoU
         vA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766426247; x=1767031047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wBha3d01qjiMew7UlnJKYluL6OwpP6oM7rEy/5DQKRo=;
        b=r0QerEseeod0MmHhM+4Ib4P+RNSp7GcQtX1nE8iY3HtYfgYxW+GGbcd4JAT5E8kGQA
         /4l6OLTPFLy1UMPgqjBgAlgzji9a5E0lweczSdwVnbxq6IgmrYOys/D4Isc6b8EF5arw
         PapPIMK39RwfAuIM3sZoqq0ti5EOswYAUAwx7BgcGOm/uxjG2B6fRWwyQb9Yt9Wd5Dnn
         GkbA+8wEJKd6YXZAWzKPpgnM1tV8i+NqQMrdA5fMrH7WySv4FjjfbBWzSxGBeOjuolxw
         74f8skKAjtK1ZxEXcMfLAgOOMh43ZWxh9yt4jQBNsTvPBQqS8r61CflLD1xXo4nSVoht
         av2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjgkqyyiM4x3yI06hUBs9jGXdxCUm+WJmhijWwnwTUFRpOzCExTd5UYLgn95tig2WVtxMeYiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmckjKZxckwhsGO7Bg794uQGHHiKf6Jb1X1B5CQ+iJIfmog3E1
	g120xBb/kSan25npJIIT6TAPj/GcnRl3o2hwKp4503AXCtdtVBHSQ1K/QD+lrGsxVxusMHKASPl
	EnJ9LaiNmxhSIYefLmEl/BWrvZYvH94s=
X-Gm-Gg: AY/fxX6qR7cXRXUpL5RUDjkyHv8QJ1nV9degoF1TxFYOpEqoBuukvtKGtrfuvzP+qIQ
	obKlW/u4GIPp3FplmskS6CFeUIcb94IBNrSgRtcIZSxPbkWwzosXn742pAJ209fQSewBlJeKuaX
	12D7QXiGJ+RKpsDbYiVJzcxhwdhBjRpqAHFRoZWfN0ghLV3lwV8dcGjAb8OzSFfx6EsUQz+QtZ2
	iVrUEVrRf1sASfyeLcLz7oYWKaIPPi7dM2AsDXcA5aGhMtajaos2bQvMTENh8a5zWWe90O/WjiS
	BsXr
X-Google-Smtp-Source: AGHT+IHGjnM4tssmgrpgdS+QyfppBwGcEa/TtaSTVo3x3z2X4MIp6+nQ00I9y9UQh1U0WtN9dG4OQo1+7sN+Qmf+nvg=
X-Received: by 2002:a17:907:3f25:b0:b80:117d:46e5 with SMTP id
 a640c23a62f3a-b8036f62257mr1197264466b.29.1766426246688; Mon, 22 Dec 2025
 09:57:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOprWotBRv_cvD3GCSe7N2tiLooZBoDisSwbu+VBAmt_2izvwQ@mail.gmail.com>
 <CAA7ZjpY-q6pynoDpo6OwW80zd7rq3dfFjQ1RMGzJR4pKSu7Zzg@mail.gmail.com>
In-Reply-To: <CAA7ZjpY-q6pynoDpo6OwW80zd7rq3dfFjQ1RMGzJR4pKSu7Zzg@mail.gmail.com>
From: Andrea Daoud <andreadaoud6@gmail.com>
Date: Tue, 23 Dec 2025 01:57:15 +0800
X-Gm-Features: AQt7F2pbRWy0Y3qdReSvX4Mn03sO7NEaq-NkFe6B_tFRTn8ukhodMW_kVgnL2-o
Message-ID: <CAOprWov+j6V8XmtQD-K6pBj+7CVP_QJM0ODbJxtPZqG=y2RW3w@mail.gmail.com>
Subject: Re: ctucanfd: possible coding error in ctucan_set_secondary_sample_point
 causing SSP not enabled
To: Ondrej Ille <ondrej.ille@gmail.com>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your reply!

On Mon, Dec 22, 2025 at 11:51=E2=80=AFPM Ondrej Ille <ondrej.ille@gmail.com=
> wrote:
>
> Hello Andrea,
>
> yes, your thinking is correct, there is a bug there.
>
> This was pointed to by another user right in the CTU CAN FD repository wh=
ere the Linux driver also lives:
> https://github.com/Blebowski/CTU-CAN-FD/pull/2
>
> It is as you say, it should be:
>
> -- ssp_cfg |=3D FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x1);
> ++ ssp_cfg |=3D FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x0);
>
> Unfortunately, we have not processed this in the CTU CAN FD repo either.
> I can send it as a patch, but TBH, I have never done this before (the dri=
ver was contributed to Kernel by Pavel Pisa, he is the maintainer).
> If you point me in the right direction to the steps I should follow, I wi=
ll be glad to do so.
>
> With Regards
> Ondrej Ille
>
> PS: The changes are dummy enough that they will likely not cause a large =
review, so it seems like an ideal case for trying to contribute for the fir=
st time.

Unfortunately I do not have an environment right now to make patches
sent, so it would be better if someone else can send the patch.

> PPS: I will go on and fix it in CTU CAN FD repo too. However, ATM I don't=
 have a setup where to really test this.

I have tested it on my setup. I run this core on a FPGA, with PCIe
connected to Linux host. After changing this to zero, I can see the
relative phase of sample_sec has changed to a more ideal phase in the
received bit.

>
> On Mon, Dec 22, 2025 at 3:17=E2=80=AFPM Andrea Daoud <andreadaoud6@gmail.=
com> wrote:
>>
>> Hi,
>>
>> In ctucan_set_secondary_sample_point(), there's a line which runs when
>> data bitrate is >1Mbps:
>>
>> ssp_cfg |=3D FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x1);
>>
>> In the datasheet [1] of ctucanfd, we can see the meaning of SSP_SRC:
>>
>> SSP_SRC: Source of Secondary sampling point.
>> 0b00 - SSP_SRC_MEAS_N_OFFSET - SSP position =3D TRV_DELAY (Measured
>> Transmitter delay) + SSP_OFFSET.
>> 0b01 - SSP_SRC_NO_SSP - SSP is not used. Transmitter uses regular
>> Sampling Point during data bit rate.
>> 0b10 - SSP_SRC_OFFSET - SSP position =3D SSP_OFFSET. Measured
>> Transmitter delay value is ignored.
>>
>> Therefore, setting it to 1 disables SSP (NO_SSP). We should probably
>> set it to 0 (MEAS_N_OFFSET).
>>
>> Is this correct? Would like to hear some inputs.
>>
>> Regards,
>>
>> Andrea
>>
>> [1]: https://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/doc/Datasheet.pdf

