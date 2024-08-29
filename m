Return-Path: <netdev+bounces-123202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC07C964173
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFA31C20CDD
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35FE18E754;
	Thu, 29 Aug 2024 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asZmFB+Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDD18E750
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926669; cv=none; b=ssB5rn8JUXz9l40Er8EDV8ux2/TTxo1J9o505lFC6N1hQZT0hmZ3lSlIhPp64rIHK1cF0z+hKMyX4x4tDWBAwKnr3lHKsigXFN6duJgcStEIVEwt/kDU/eRDCQvtVKHfh82e+P67CqBfJl/BHLf4HHjB/v5JI0KxanhLt2o7BMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926669; c=relaxed/simple;
	bh=wHItm0cKnnaiF4q9fmEemTB6NMjNhRCJeehB+N+PzI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3vMKKlE+JW6iyYAHjjtcMdMPJQ934s1IW1t0z7TRZgas4Ouw83ozuQPtbWc9ZrA8ItfR0G25jidkZNP0tCY3mcC3vWkUdzkB0kIkgrEBFFlQdYs5cd9sfOfTGk4D/gfUV/T5VbLCduqED7Ducg6ShbXCRl35nQJJad2KvdXne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=asZmFB+Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724926665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mmwGYx8IP56w8yEP/hicn/i9wnPK+R/r3F9WzYay6Q=;
	b=asZmFB+QTcq/llP1/zsbvGYjcE5szJ9oFXJPQLitGX7VMjWwGqfcvsXvR+WfCchkHj9p74
	Kd4eNlCCbhuTP8p0puYEqCoc3jQbfmxNmQMTvKQ20WjBeWnG7AOb9lC83NoGfk5iBB7oA0
	L9u3U4d3TAYnH8UAzkxyY2UWmvHcFWA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-qfBe5vulPc6AOmjTrTeyNg-1; Thu, 29 Aug 2024 06:17:44 -0400
X-MC-Unique: qfBe5vulPc6AOmjTrTeyNg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5becb612a13so367326a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 03:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926663; x=1725531463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mmwGYx8IP56w8yEP/hicn/i9wnPK+R/r3F9WzYay6Q=;
        b=TwblTQsjsuD7jd5PyU9htqf8bMaFDcV7Dvsy+uqIwCoKBkE32tKvPEyMa60+0XkYQd
         mCzF7RxlPrIwU1JobcWZGJ8sb6idUhnwVmKM4zj2dY/n0RMmvCZtylAkgknZ4tjAqL3E
         l6wcccfMainSXn5aDaCy6VyjGEo+WNJuMthMNcO6OP8/BQ/rLXt2l5Gq2Bul1a9P7dYf
         D4vgNuZdmjZnei4bF94J0jcoxuU66pMpQilL0I6nidgKAWNjoL01R1JoUvZ5Cjw2if8k
         oIn9ryScp5m1rXvIJn+BRi60EyihbyXSi9KOjtq457wryC7whyF5BzCCIQOy10uuE6ys
         NmcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/80XPyaziLqKbB4HAcVK/ORpXtI1rpgn+ZxR0uteKRuMD+HFVddQPJZuy6IHvdsZgX9+f06A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOef0PbiIdpKCKv9NN1VlNpjX+s8GvH9FnEJFM2pokyf4kxJ+h
	37vAPJfAvrxJIO6DvjdlXk5BgwZ3ZAztEMtMiuewOeURQqwyLWYYsmhsWTru8Ub/Z4wJSHYQmRp
	LnQFySm2GF5In1Pbv4AcG5+y7EHbbaV0S75mm3htq9DXINd2ocSKyuQ==
X-Received: by 2002:a05:6402:2353:b0:5bf:a2c:4f35 with SMTP id 4fb4d7f45d1cf-5c21ed3fd0fmr1711571a12.10.1724926662972;
        Thu, 29 Aug 2024 03:17:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnxtX1dyLotbngOwRntZMasp8GlOKnrQUf/CTxmCFchZTpvVeZZxoc/aKq03HesYuywXiFag==
X-Received: by 2002:a05:6402:2353:b0:5bf:a2c:4f35 with SMTP id 4fb4d7f45d1cf-5c21ed3fd0fmr1711541a12.10.1724926662241;
        Thu, 29 Aug 2024 03:17:42 -0700 (PDT)
Received: from [10.39.192.156] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ce784csm527340a12.91.2024.08.29.03.17.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 03:17:41 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Yan Zhen <yanzhen@vivo.com>
Cc: edumazet@google.com, pshelar@ovn.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1 net-next] net: openvswitch: Use ERR_CAST() to return
Date: Thu, 29 Aug 2024 12:17:41 +0200
X-Mailer: MailMate (1.14r6056)
Message-ID: <CF346267-CFB2-4DC9-9E88-C502E1358830@redhat.com>
In-Reply-To: <20240829095509.3151987-1-yanzhen@vivo.com>
References: <20240829095509.3151987-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 29 Aug 2024, at 11:55, Yan Zhen wrote:

> Using ERR_CAST() is more reasonable and safer, When it is necessary
> to convert the type of an error pointer and return it.
>
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>  net/openvswitch/flow_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netl=
ink.c
> index c92bdc4dfe19..729ef582a3a8 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -2491,7 +2491,7 @@ static struct nlattr *reserve_sfa_size(struct sw_=
flow_actions **sfa,
>
>  	acts =3D nla_alloc_flow_actions(new_acts_size);
>  	if (IS_ERR(acts))
> -		return (void *)acts;
> +		return ERR_CAST(acts);

Change looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>

>  	memcpy(acts->actions, (*sfa)->actions, (*sfa)->actions_len);
>  	acts->actions_len =3D (*sfa)->actions_len;
> -- =

> 2.34.1


