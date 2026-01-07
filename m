Return-Path: <netdev+bounces-247672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CD1CFD270
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF7EF300E7FC
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B816315D39;
	Wed,  7 Jan 2026 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+QJsvCF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBD03128CB
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767781497; cv=none; b=ST8TNf4SHSpC/HpCo+M8ONKJLC24e7NqjJsaocXR0sflzUKz/YW1abjliOKaq4FzEdx/FPbTRcATjY+Xkk8KlxSqe4Wk2Uu/92xIP/YECuKuQO4hezmeRneudxhz0zQ6yePKSPPlZSYG7V9OOEuI3XbYP0tHU2MVoaDneIY3xFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767781497; c=relaxed/simple;
	bh=GSdzZu4nWA2E5aaBkTTxSMPmgEeiZszj8OmyKcEtTdI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CAP+5moEUQqOec2YSKhdPOJZtt5VcDZkGH+TYgidAHZTPfoeEIabV6Igc2sUaTwjlKPMmrRnwyLptPXL9PpNRG9KtJbZ0D30OQFIwXVXmu14id0DLkqw9kEGuAFZzDdrGyXIN0V59L/rAZcHuO0NKclrNEs85nXM5BVPCGOT+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+QJsvCF; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so15549065e9.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 02:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767781494; x=1768386294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GSdzZu4nWA2E5aaBkTTxSMPmgEeiZszj8OmyKcEtTdI=;
        b=Q+QJsvCFFKYjOmyHvprV+s3qcNANMDKoDIgd0gQ1jt9irrE5uBaScveZiFdghk1xHH
         dpugPoXSj5s58KodbbU8mLfHVXVQxo71kTmx72KnKc7J/N5eYRe6koozpWNRcc08NAHT
         f2HR7E0fhFRRtXN8T8w7b2NpmcqkPSEB0FDTTwBoyNpeUNsPa6RKAirdVZnSo5AaFp8N
         WIMLyW0NecLIagpjvjd37mOWjoXLA9Iso8lfl9S4qA3Av9UNhBdtevrs3tFAnZwBcsHs
         KVfttxkZBetZScgdRVudIW2u+swXXUmUoz0QSOnKkrSeg31PkUHzHDua2GBpl2WnUGEY
         p6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767781494; x=1768386294;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSdzZu4nWA2E5aaBkTTxSMPmgEeiZszj8OmyKcEtTdI=;
        b=FN/CeAbS1lpPOa9a4ZZRYvG74S7r/xwNLFS1aqkCCZmYl28At4/Uc335jkCksBqcQ9
         6e0/6KgqTZRVWi1YP0K2GvqgCYm+o/sRrhWEHYtESk1J74b8SUgOwY38jP4x1fIf6U3w
         RNAPrVo7QDd0Eq4hTY3qmhyDlitmzvlqUhXR99LdPp9JyC8xxHepEsiFgatOlwRDDgAt
         FF3JrHwKXuGEXg92iLDw7Ji3jqt1N4kWHmkpcMWPHqfAzZ/dp3wjtT0G1GwF0Lq1pKwa
         pSBD82CA/D/G7+xdPgW8OL8rC3onKopoN0+xWHT/t+SdIVcIcbxKcqNWuVn3/RAMJMDK
         gODw==
X-Forwarded-Encrypted: i=1; AJvYcCXuoBZnfMN8JcQhprUFiNiuahcHTrA4JY91u6fg7mx9I2L/LwX6h74/ZI0uWW9kd8dvyokAybw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQx5ydjK92RkWDAl1pnKaLJZRN8Hn8RHd+mmrW+yGS/vhqWbRS
	1H6q1Mlz+3nf2cNRVx7LtW+NRwYvkRYHgV4rxChbP8Cg64EHnfQtUhdq
X-Gm-Gg: AY/fxX56rK5m0i8G+ivxNFJJ06DNgf1K/PAtDih2DUOqMdWMmXXCwU8WeiRya6COuK2
	5krKnwA49mdUZu/RYNnoBTOgJ3uRPpf/weFlA9FBWU+qGMSgV4NeNTbeK3Y0UpKVrNUjYpS9baK
	rwPjRFu+mzNvWnxZ3WGZxnZxW5L1Bti4nwQKOIiqaJQfvPX9yn7ayX1lPCdc1YhJ6tOve9Fs41h
	5BsJhzdRglBTv5jRhqGlzMSIAkm5PyXuoj9sO7Qr3HBpeyHMONPwVJIB1s632swlpbBtAFTwy1b
	7IvMo6xM1NqEsstBjrjO0yT0zGQKFk+Qut/L7LlqYEHMjqWd6uofQ6SVqL4LhCAo1Pqu3Z0c3dv
	zdBXz++uJ6lQKNUEXRVzX9z3lDVc3CveiPlr2ViaTrOZCyb+S5B2z2TpJCBQsVQrEIHntFpq3q9
	i6N5RsBElNtqy41vUMffaHAnDiHtLGMdDNDQ==
X-Google-Smtp-Source: AGHT+IFTQENpnm9YH+tI5EH1YalvRvb869aMnLb2Ju6B0Q5s25SG8IKpq9uMtw1ecZIiHlnmbwAhLA==
X-Received: by 2002:a05:600c:4692:b0:47d:3ead:7439 with SMTP id 5b1f17b1804b1-47d84b5403dmr20736785e9.37.1767781493707;
        Wed, 07 Jan 2026 02:24:53 -0800 (PST)
Received: from ehlo.thunderbird.net ([80.244.29.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff1e9sm9971768f8f.41.2026.01.07.02.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 02:24:53 -0800 (PST)
Date: Wed, 07 Jan 2026 12:24:50 +0200
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Slark Xiao <slark_xiao@163.com>
CC: loic.poulain@oss.qualcomm.com, johannes@sipsolutions.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mani@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>
Subject: =?US-ASCII?Q?Re=3ARe=3A_=5Bnet-next_v4_7/8=5D_net=3A_wwan=3A_prevent_prem?=
 =?US-ASCII?Q?ature_device_unregister_when_NMEA_port_is_present?=
User-Agent: K-9 Mail for Android
In-Reply-To: <63fddbfb.60e7.19b975c40ea.Coremail.slark_xiao@163.com>
References: <20260105102018.62731-1-slark_xiao@163.com> <20260105102018.62731-8-slark_xiao@163.com> <83c51a99-038d-4283-9a39-97129966a500@gmail.com> <63fddbfb.60e7.19b975c40ea.Coremail.slark_xiao@163.com>
Message-ID: <3E02ACE7-C86F-4FE0-A930-464F8E7D27E9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 7, 2026 9:29:24 AM, Slark Xiao <slark_xiao@163=2Ecom> wrote:
>At 2026-01-07 09:06:05, "Sergey Ryazanov" <ryazanov=2Es=2Ea@gmail=2Ecom> =
wrote:
>>Hi Slark, Loic,
>>
>>sorry for late joining the discussion, please find a design question bel=
ow=2E
>>
>>On 1/5/26 12:20, Slark Xiao wrote:
>>> From: Loic Poulain <loic=2Epoulain@oss=2Equalcomm=2Ecom>
>>>=20
>>> The WWAN core unregisters the device when it has no remaining WWAN ops
>>> or child devices=2E For NMEA port types, the child is registered under
>>> the GNSS class instead of WWAN, so the core incorrectly assumes there
>>> are no children and unregisters the WWAN device too early=2E This lead=
s
>>> to a second unregister attempt after the NMEA device is removed=2E
>>>=20
>>> To fix this issue, we register a virtual WWAN port device along the
>>> GNSS device, this ensures the WWAN device remains registered until
>>> all associated ports, including NMEA, are properly removed=2E
>>
>>wwan core assumes whole responsibility for managing a WWAN device=2E We=
=20
>>already use wwan_create_dev()/wwan_remove_dev() everywhere=2E But, we ar=
e=20
>>checking the reminding references in an implicit way using=20
>>device_for_each_child() and registered OPS existence=2E Thus, we need th=
is=20
>>trick with a virtual child port=2E
>>
>>Does it make sense to switch to an explicit reference counting? We can=
=20
>>introduce such counter to the wwan_device structure, and=20
>>increment/decrement it on every wwan_create_dev()/wwan_remove_dev()=20
>>call=2E So, we will do device_unregister() upon reference number becomin=
g=20
>>zero=2E
>>
>>If it sounds promising, I can send a RFC, let's say, tomorrow=2E
>
>The RFC only for this patch or the existing design? Since there is proble=
m
>reported in=C2=A0https://patchwork=2Ekernel=2Eorg/project/netdevbpf/patch=
/20260105102018=2E62731-3-slark_xiao@163=2Ecom/#26720828=2E
>
>Currently design:
>=C2=A0=C2=A0=C2=A0 minor =3D ida_alloc_range(&minors, 0, WWAN_MAX_MINORS =
- 1, GFP_KERNEL);
>=C2=A0=C2=A0=C2=A0 if (minor < 0)
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return minor;
>
>=C2=A0=C2=A0=C2=A0 port->dev=2Eclass =3D &wwan_class;
>// when cdev is false, no devt was assigned=2E But wwan_port_destroy() us=
e devt to free
>=C2=A0=C2=A0=C2=A0 if (cdev)
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port->dev=2Edevt =3D MKDEV(wwa=
n_major, minor);
>
>We need to have a update based on this patch if we want to use this one i=
n this serial=2E

The proposed idea for the WWAN device release will entirely substitute thi=
s patch=2E So, all these issues with the virtual stub port creation should =
gone as well=2E

--
Sergey

