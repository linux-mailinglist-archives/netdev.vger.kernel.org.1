Return-Path: <netdev+bounces-153392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDFF9F7D3F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE29E188F18E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07290224B07;
	Thu, 19 Dec 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWexPPXq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E05A17C;
	Thu, 19 Dec 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619080; cv=none; b=fWl2IuWMBFJ4I7yu8DbE1YJQJ7gwF2BtMODPRoJNXYgDJXmmxoomIBJrIaex7PzvbpwLsc+aJo3RtVsIT9L9n0BL0QuqOU2GD/yFmbsKMwt0/tWwspY74bVFJeTepZ2DcRRzidLtSJfzpMFC8xGSx3Yi2pARuzZnnWGBYwJx9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619080; c=relaxed/simple;
	bh=NjI6i5qeo7whHIRT/3vNBPOor6E3SlvcrErnr/ttbCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hzxu1eyqtsAkw5GcgMP6BT/1gxF4dKl68DpqYM3EOta2jStPEeTl5qlyNPmnuiTdXSe6GytDqOU5BR/XhDiJm8QNct8E949tzVME0+abEEMqjcnQ+QTJ1bHmjD0fhDwvz0iDkxgM1oqbrHF+/gbs0V+p7GYjWDvT6uYR8AgjyR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWexPPXq; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so1309253a12.1;
        Thu, 19 Dec 2024 06:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734619077; x=1735223877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXX798Ae/hwtwg3qjpPRVUNwxJBK+LNIPfXosAeJ080=;
        b=iWexPPXqNLUkGJRaEmziCGHhnd0vgPThq6GhzNCksANmyl211lZ9Eg2BbJL2UK2Swy
         XA/zS+8sG4yV6potre8iDgCwI8UIC2Twh22ZREG43ee7q9WL6mJeus99MFhcl0pEZiM3
         BDeUZE1S07U1nEq1wrg4asceA3vh0OlGs/d5cBTIWC3j/eaX1KZO3/W6I3BZHjwE0n7n
         jAQuZCHNiXUuPavTXLrbFGRGJm6lTPClwQeHHTZL6N9+RfLCPoHuvksTlqoFFQQ9llH5
         lfBss1WaYYGOYkDenP8j0/wJZOCYBAL2nz2FphhW3wzRJfNY9f4hAERwMWn3y3rp20CB
         9Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619077; x=1735223877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXX798Ae/hwtwg3qjpPRVUNwxJBK+LNIPfXosAeJ080=;
        b=dT/zlpeu7+SQptS7vQKA/ys0WhY6wrCAtEWNmUc/po1IoseaveAZGdh40S1VOM8K8c
         ua88pI74eBD94Qy6yPceIossRfuMSZb0snUl40I+4c+KqTp/DIEKd11Zbk/dR8lQuKtD
         e4WOxoxTyZdxlwWVkZGfiFNXesogi1Ecl0SXs6ZWDl3urtcXYriMA/IXBTgllBWlA31O
         rr3gLD458Oz83ydJEc0hAi7tCkzsflPJhWgMM8Vlx2G8IcjYrOppJb52h1nnD1xVrXOZ
         fddRcaG0EdPKFhA/UtEnVY5YKSpcycsHlqtoXeit/qfGqH+HhKevaaSolXrVhH4Oo6JO
         1kVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaXe5rzp+X+wSCMmhH8T33bUTMW+BoArUGVPFA5NdnOF1aVJor7w7jDsBrVaxW8Kv3I7Tw6wV0SSw=@vger.kernel.org, AJvYcCXJYPyfBn6TSy+34OXJfX2lPXpvFfr7JGrWroxn0ZeRYeQR7wIFYkgvCsxbhOP+s2A/L5uQCdAx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh3djUBXSnk6GI5mTj7VocwSG2Nh0gjopvV2p0BcwpIZd4Gen7
	momPJktuwGmCfY/CLIvhIorr0ec3o4akm6qVrh7N8Qp6ZyX7aWGieGG4eKRTEUjlKqhgND3BLpi
	t9JXEcUQW7i69S6H1m5iJeWxUkkU=
X-Gm-Gg: ASbGnctzhBoEvVvgqz8K+P68GiQesffNdry5F4fkLV2f8+lGRWr5MPdN1oiDf7MQag2
	9zOfuO4F5PB9Y98SAlM+cPfkUPJTN0+N3oHuol08=
X-Google-Smtp-Source: AGHT+IHCabhWvDWKzLxgFO2fB0d0NozcBMeeacGFfgszVYezH2ilzNU6swwWwB9AKg0E1phdJNroBQYzeZy1Ep2I9eY=
X-Received: by 2002:a05:6402:26c6:b0:5d0:c9e6:30b9 with SMTP id
 4fb4d7f45d1cf-5d7ee3a2840mr6144179a12.3.1734619077525; Thu, 19 Dec 2024
 06:37:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218144530.2963326-1-ap420073@gmail.com> <20241218144530.2963326-10-ap420073@gmail.com>
 <20241218184917.288f0b29@kernel.org>
In-Reply-To: <20241218184917.288f0b29@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 19 Dec 2024 23:37:45 +0900
Message-ID: <CAMArcTWH=xuExBBxGjOL2OUCdkQiFm8PK4mBbyWcdrK282nS9w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 9/9] netdevsim: add HDS feature
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 11:49=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 18 Dec 2024 14:45:30 +0000 Taehee Yoo wrote:
> >  drivers/net/netdevsim/ethtool.c   | 15 ++++++++++++++-
> >  drivers/net/netdevsim/netdevsim.h |  4 ++++
>
> netdevsim patches must come with a selftest that uses them :)
> We support bash, C and Python tests. Look inside
> tools/testing/selftests/drivers/net/
> These tests could serve as examples: stats.py, hw/ncdevmem.c
>


> TBH it doesn't look like netdevsim _actually_ supports HDS,
> as in forwarded packets will not be split with the current
> code, or linearized. You'd need to modify nsim_start_xmit()
> to either linearize the packet or not based on *peer's* HDS
> settings.

Ah, Sorry for the sloppy change.
I will write a selftest. Also, I will modify nsim_start_xmit() to support H=
DS.
The example would be very helpful to me.

Thank you so much!
Taehee Yoo.

