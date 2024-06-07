Return-Path: <netdev+bounces-101754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4818FFF65
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE9B28518C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8079915B567;
	Fri,  7 Jun 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OphgJDtL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E178C60
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752399; cv=none; b=WMCk0TgHrUkJl8L7lPFDL+cvNTv+FwcgsQFqLkgUxuSG5UtDVdDXtoK2F7U54xVL1HpeGy2POTXKUMu0EPQ7Bau/ICqpsUebfgk/BPH5v5Ov8CN7w22nUNZPlTPhL4x9VokFntVzkPI2Pw8RuglxLZbrJYa44xqDj05IcG/sKGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752399; c=relaxed/simple;
	bh=vCe9YBcXrbrkkEU4n1P6qgUzd3O5BQ71r3zyOBwNwPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aS0lPGbzK5Kaf/CnWjH+F+U5J5T7yTvM7iiSN5IYOYpmVIWyEhNjjlJAqiPe4VwmcStTv49F6PjkJfkp2lOs/8S9m+BwcCYr0tEsiZuWm+s2q/WypE3B5AXAx4C2MRgi08UiFiGjukXtdpa4e2fnibOMGdCA/HPasOjoUPxBJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OphgJDtL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a1b122718so6141a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 02:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717752396; x=1718357196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCe9YBcXrbrkkEU4n1P6qgUzd3O5BQ71r3zyOBwNwPg=;
        b=OphgJDtLTgZ+rFqFLsxGaZ/gIwJ7q9ss65UGANWx/Z8ge46xt7vjvVTgyoVNnpMdH9
         8Iq7l/7t2s0IG5BvfRqwkAmALEZS/NhBiv4pSDA0iNyB7hx7BF7BLDdqTlE42cCX+vje
         jH+6EblOzK1hOHNrRGhgnDJaYFFsG3gmjfm/VqTwJUKDOFSJZVqqC0kZTCcQ/59VItPH
         z/jMaD25fIgmjYa/QH5uhwuGY98wa3sWrHxfLxMmZ3qhF4l0widxjhjrDN0RC4Gp7foA
         L77POX/K0oLD4sAcYNdpCgMzkiETAmzJ40TcqjGq2RmD4uqH/jpvpzkAVxun6BAqO4Nv
         itIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717752396; x=1718357196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCe9YBcXrbrkkEU4n1P6qgUzd3O5BQ71r3zyOBwNwPg=;
        b=vYLTzp6RoYpKT0q9BQ0TsISav+OuyMRT9k6RnrZ3LwVqNHhjPmcoogjZnoTr5sQo2B
         dGUeAwFd/t2+oEwNv62Cld/GeGkBzclSINJMJN/DyOBFYL/tTvY2GzWEUQu3dZzvr1om
         Vriv+FLUlIJwJBQ6Obl+gHrjJTjNL8aVvoKwdgPPBYxS4mHidT8gio6yCe9UCibxx0rv
         neY/yYiH7jwwD6wbEF/f2NLW5FA3Kiri9JKySbaDzYj2f2xAI6Z7yqGGCpACPthRY/yK
         mybgwSqLOxPV5eFsoOKxboMtLLcfz6UBN68QiI0Jby/D+lV3vgqRfG6iyINoUnyvrMmP
         wDUA==
X-Gm-Message-State: AOJu0Yz7KmzmlqW63caEMRkkkBsx9yZ4QkGLnZmxx7aCUG5NhkFcaAoi
	jmUZaTPKKDXAHoBffpY3GM8kDJS8w3kk7rHbHbf1sby/QmAZV7aavYC7BokhevrXNSUIjLcakXF
	vIhi7JZ2XjKyyZvVQtmJtJPRA6llWeR4qPaAI
X-Google-Smtp-Source: AGHT+IEqzLsmHvscS//RfHdNiM1ZmKjMELCt9XB7BoA7j/yHy8tVO4V9PH+EC2vof2t5ju2Rp+xhYWgMAhbF/agfhr8=
X-Received: by 2002:aa7:de0e:0:b0:57c:57b3:6bb3 with SMTP id
 4fb4d7f45d1cf-57c57b37a69mr64039a12.6.1717752395829; Fri, 07 Jun 2024
 02:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607083205.3000-1-fw@strlen.de> <20240607083205.3000-3-fw@strlen.de>
In-Reply-To: <20240607083205.3000-3-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Jun 2024 11:26:24 +0200
Message-ID: <CANn89iJuSxe5fD7O_J0ZKXEQsyv64X1JH6un5eMZDmL43mJ+3g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: add and use __skb_get_hash_symmetric_net
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org, 
	pablo@netfilter.org, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 10:36=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Similar to previous patch: apply same logic for
> __skb_get_hash_symmetric and let callers pass the netns to the dissector
> core.
>
> Existing function is turned into a wrapper to avoid adjusting all
> callers, nft_hash.c uses new function.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Eric Dumazet <edumazet@google.com>

