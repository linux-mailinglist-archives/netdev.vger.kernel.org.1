Return-Path: <netdev+bounces-212039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C91F9B1D6CB
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 13:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77625189A09C
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 11:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8253726C38C;
	Thu,  7 Aug 2025 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuQNwabu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D67226CFC
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754566567; cv=none; b=k1BeEOa7onaH7ug2brMlsQ/46W24fGqNFgnT5u2HgzrQ6fInyPT9daAG8b0U0DWDbwDiLP2VthQ3gS0J1YoOrn9C5MUH1PKoca4nRorUlC5T7quoWZsrnvAO7NDFrAs4N727RPX05gvU4znD0ut6QJ7o9ESxe9VyUAc6W55xNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754566567; c=relaxed/simple;
	bh=rINS/1oBgFK82gTJZ3TSjDbuZA0dUTDcTbyacL5IJ30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFkIrmEtr9Nv54YmqXKM2kQUBSY0kOFJMKh2KwADLjQKyThIYTQvZMknOM89/UnTa+GiRj/musNd5RUG643467W/UwnLQ7UF260vVU4fBav5t3DQUadgUECLhIEN0C9Bed/MKm5YJuacOPZ29UcxcFQl5RaSwzyILw7MpYhedME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuQNwabu; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b07cd5019eso10209411cf.3
        for <netdev@vger.kernel.org>; Thu, 07 Aug 2025 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754566565; x=1755171365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rINS/1oBgFK82gTJZ3TSjDbuZA0dUTDcTbyacL5IJ30=;
        b=BuQNwabuuyQBn3d7E38XB+/Emgwen3zGwf4gvwkunelyO2tLKK1LSabhzzR/Q6+QxS
         Wvr+q1bVGR1c5bbUUlWcQdS95mG/PYNCBH/rF05HKWeJtLkocNocsJZtIHl0+Z39sPBN
         t2t5PtxI06+PRVJ6BtXFKIjN7aqNEgx1rvz7vOj1JHhQlD28KM/1p1BIteHZn8hMoHok
         6pQklnninczalZi45SzeGa6ncTTkJB9tmky3G8y+Pel58eSIEKLmXv000g+DabTECeMd
         JWNPy5NW82ps8llDbrhvd5F5uSzJZL3UqWxYRCyNlqO/FfVCXpN2dsZJkm3mmk9e3mV9
         3qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754566565; x=1755171365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rINS/1oBgFK82gTJZ3TSjDbuZA0dUTDcTbyacL5IJ30=;
        b=Y2ITwMf9ALZheiOl/4PaTxSOD0f8Lumi3vo8LYXkohx+9JIjn72QWZIWNreL80leCA
         F5smavV6zHDL0cQzkh+udmOZfyo5rVZqq8UNXelWsc5SDrXVo+wSdr6wmsvK0ZK7Dh02
         jvMhoQY3ARaop5t+P3fsKlbwuSxudIqn3MBXl/2C49BBkdQ+T4Syabq4ruXPnp0rRFHR
         f6dBA5HO5u+OY2cgnRugcfqtP9AR9pzNKgxjpgyppqM6m/J0pZnHb2o22GoZ72v7/Rtq
         Z+yC0wB3cxIhHaYyGYyojR1Tbec1/LIAZK++ZtlgkSHHbOC78v/elXo1e9sMBqtCYQxz
         emeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQpm2UusjLJOHF7F2qqmUNDbYFEEG+WNWLvfrWWqJlF85/JTF2dM7IUldJotrASQVufYM4GdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1aBbq+k+bqS8RdahFq8kDndUIruCueo2VPVSNKC3SA2sCjN9
	DxiqffJS06A1QqvVchLKU3+182CgHX0jwoCpbfOOO4BopFhhyZcvIkzXnkrmzsGaHR/7i9DXsYw
	2BsDWuCuKOgNiVEViKOFXaeIC0s+5cUOFVxvBYMD8
X-Gm-Gg: ASbGncs5T/FLYT2/fNvz4TaOAG3uaJrEgq0aW4V3Qheubm3TCGcyhCRKxcoZp5m2WE1
	o32RphUNPFNH06TPp3as0UuXezCjTKV+z3jCmmqnZnjPtLFR6oe43HBvaWK1Ts2SjgdN3VRZvQA
	AdgZ2Rv4mzu2DXMG/SBc/gdICKP5CS0plZkDs2kYocNJvq+4x8ukxwubZZ3WotMrlvBI63s9IMO
	Kdww1Rv
X-Google-Smtp-Source: AGHT+IHVg9rMkoh0qVm3TF7LjNVDVApq6CFUBuY/LSvBIkOM08ZaIhb4ZF9e0y76nOETS7IpnStuVoxiWRcO6yBVp/E=
X-Received: by 2002:a05:622a:20c:b0:4ab:cf30:1892 with SMTP id
 d75a77b69052e-4b09254bd74mr101451741cf.22.1754566564482; Thu, 07 Aug 2025
 04:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807112948.1400523-1-pablo@netfilter.org> <20250807112948.1400523-2-pablo@netfilter.org>
In-Reply-To: <20250807112948.1400523-2-pablo@netfilter.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Aug 2025 04:35:52 -0700
X-Gm-Features: Ac12FXxvf8GDtHZlGhsGTiJkMDxY38vb5E-S7wVaKk5vvJbhIidQjY_eSM4kwm0
Message-ID: <CANn89iL1=5ykpHXZtp0_J-oUbd7pJQTDL__JDaJR-JbiQDkCPQ@mail.gmail.com>
Subject: Re: [PATCH net 1/7] MAINTAINERS: resurrect my netfilter maintainer entry
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, fw@strlen.de, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 4:29=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.o=
rg> wrote:
>
> From: Florian Westphal <fw@strlen.de>
>
> This reverts commit b5048d27872a9734d142540ea23c3e897e47e05c.
> Its been more than a year, hope my motivation lasts a bit longer than
> last time :-)
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Oh very nice, welcome back Florian !

