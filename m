Return-Path: <netdev+bounces-224247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4286BB82E16
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 06:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26643ADF1B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 04:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51A2221544;
	Thu, 18 Sep 2025 04:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+/WwJ5I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA6881E
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758169378; cv=none; b=ZPcgndzo8i66WTbYBZGOE1h9II9G/CeY6OyzrRO8hXOTdabkyUgb6y1ZZ1AzADGAJVWaEnHH+RoC/upaDV0vIxhVi0RWbF77rOp1IIzF+PODbjV4T6vNFNH3jEwD4hrvgsftH1F0uViIpikDQ2OIT7lC1IzsrlS2g8QdEJqjOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758169378; c=relaxed/simple;
	bh=MLmHfQyCJ5uEHgUcVYYqJh4sebmoMUAh1vp8crmzXLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMYX+dLYD5/iMG/9jjTmov/sfViUQKkIZk+UBPZjlt56szRLe0b4js0+9jOmjI7CSuCpP2r0sIpPfZjsoCY9133RW84IRDsCoXRGIsFsUmNqEPMzacZNxJkoxK5eIXyajJ9AD0SgUSut2CUJrT7be8CGmHveJ9x2VGI+0thLToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+/WwJ5I; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b7a434b2d0so4362991cf.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 21:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758169376; x=1758774176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLmHfQyCJ5uEHgUcVYYqJh4sebmoMUAh1vp8crmzXLY=;
        b=N+/WwJ5IfQ3qRqp8QlRQzzWOzrR71lKhwwRaATWnXtT/U7qdPPRLu+R2gPBLoDNSW4
         CShhoVfZtomHuronWglmRlRVrErNgfg/WvmrRiq6JYaYZEWEbN/h+3fqOKj6HzmGCzm2
         SS1SOo5JXCQ5rnGW+IMnsf6al4iP0ixjUSwc+XK1jEBof16rNNRwXCpWeINKfF/Pvw0w
         nPNixa06GQaTPZko8wH1N1yWWLFlZPpKMtL1Hxao9KeBgPTqWITUlPZrfRp/p/0X4Qfv
         ZygGuhrCpC3vulFOrTCJMm0N2lFtqP7iecUNDF4ycKK6aV+fj/Ll1QbozpV5wmiyqD6a
         yDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758169376; x=1758774176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLmHfQyCJ5uEHgUcVYYqJh4sebmoMUAh1vp8crmzXLY=;
        b=nTov9DMDuN/31HPYQyPJNVyaV9NgaXOQcxEVZtmofHUSqRd6pDYJLK1sy5MbfQm7DD
         qQmx0yDdD3lG1ovY3PN1vja495MDfJWgDyyDwS/3DEF+8J/xP9Eo3I+yBT6THiCkaavQ
         40Sl5r9vImLkSPsKK9jurIOE4WXs3TeGHj+6qrpbIyk8wiO1m12JtB2HQCGXYzjtQLP+
         P85O+acHMtAtYHiIqreDqPeAPbYxXJnfQjjEx6SMG80h0LbK82UTYwMUW9HxbyVfTKG3
         56OpAmgwNVW161gCi/r1/T9r89/k6OhvIgX/5t2539qiVk7RwzqanyLYMZy7n4PFKxBV
         YbCg==
X-Forwarded-Encrypted: i=1; AJvYcCXmJMcqAnmCbvePmbic7gMsgACAAbnjuhBkm/QZieQo7YEwaC1a9Q2I9J4l/BLICJHUKdDGCaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGAmmWc3TbhbVnMr4KNUQXT09Tt1ZeYtET7SxxBGEYOKgrvyRf
	+sRqM+WCcCa++nZFWQyZnfE/E23xXASohKg5T53qFWKoG9/JI9zVB5vDGzmcfWe933J+czWC+ol
	UKtNIiEa/ab3hsk+Zzn8CAE+t6DedxBqDir8gvCGK
X-Gm-Gg: ASbGncuYSqXmRqiGtkErzDHjOQ4yxY9G+O2c8ITNAFUJNaBhd4J+rhczQVZnkGP8lVe
	ZdMi8I5I9aHiRvqd+ORtzvsejio4Lz8TEMsuV/OV6DfQul98Bs6NHwOr0dFwas11AeLkepceNVW
	WmK7TYdlJ/c9QVVugAizLYvUUMQLBbO7uzfpsNnHMa1VIRNSqB4N3ktk0AwU7sBIuz1IkfaRSLH
	5we9dQhXx1pKmR6d9GlgQUpN+h9A0bP
X-Google-Smtp-Source: AGHT+IGbR9TqssdlTAuHEmUmzT871XF6GBdHZrvujcie22OFXy02aqe9XVyOYsEq/BPqMSpjbhTPK0WR9UMcpsL+kzY=
X-Received: by 2002:ac8:7d8a:0:b0:4b4:989a:a292 with SMTP id
 d75a77b69052e-4ba687165a5mr52850681cf.26.1758169375864; Wed, 17 Sep 2025
 21:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com> <20250917000954.859376-11-daniel.zahka@gmail.com>
In-Reply-To: <20250917000954.859376-11-daniel.zahka@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 21:22:44 -0700
X-Gm-Features: AS18NWDWVrh5DV4Ljcs7wBu5HKOcLi4gb4Aac2SN-LcouQ9Zr2OwN5cKuP_yO50
Message-ID: <CANn89iKK5eJDmijNvxPESDOTEYBPcZfFWiDqvb9Bd+rGk=3bQw@mail.gmail.com>
Subject: Re: [PATCH net-next v13 10/19] psp: track generations of device key
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Kiran Kella <kiran.kella@broadcom.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:10=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> There is a (somewhat theoretical in absence of multi-host support)
> possibility that another entity will rotate the key and we won't
> know. This may lead to accepting packets with matching SPI but
> which used different crypto keys than we expected.
>
> The PSP Architecture specification mentions that an implementation
> should track device key generation when device keys are managed by the
> NIC. Some PSP implementations may opt to include this key generation
> state in decryption metadata each time a device key is used to decrypt
> a packet. If that is the case, that key generation counter can also be
> used when policy checking a decrypted skb against a psp_assoc. This is
> an optional feature that is not explicitly part of the PSP spec, but
> can provide additional security in the case where an attacker may have
> the ability to force key rotations faster than rekeying can occur.
>
> Since we're tracking "key generations" more explicitly now,
> maintain different lists for associations from different generations.
> This way we can catch stale associations (the user space should
> listen to rotation notifications and change the keys).
>
> Drivers can "opt out" of generation tracking by setting
> the generation value to 0.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

