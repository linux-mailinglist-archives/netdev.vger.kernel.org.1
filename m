Return-Path: <netdev+bounces-73875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A985EF10
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 03:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914612836D9
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 02:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5121427A;
	Thu, 22 Feb 2024 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEulN8AZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE27812B83
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708568235; cv=none; b=P+1JNLJt5Kg9ICDmn+A7P33rTHmNWTFfnVlN1a2OPRaZqb2GA15VcZbvxfi9sNuxGayCUfgvXuNeJrAJlx1WsrfQLd8rBVG3Os0BKYlzbjCdnGPMBPfQl3z9jLWMC8wz7+j6QFeQZG3ExolGFXj7KPZPgC2iPpZVZ8pMtxcrDss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708568235; c=relaxed/simple;
	bh=gRuNLhh9Cqtip1TZzPb0RQ006t3/MBa0KOw6BpxiFbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZS4nWTy+RgLwyeM6IGhLNNHk3RJq7O9ojxfNK3hRia+9T59+pJsOT96ja2MN2ARVY4V7vOb4I8f1LwfldNIsMfTQ6OJ6YPXk5XdOc21yUAft/DCBP7EblGhNqZNUwIKBK/DZsdcKz6bE9D+K5ljwhB5dYWoJJ8AIy9A6MvDp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEulN8AZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso9192198a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 18:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708568232; x=1709173032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdTVljSiYMvdyb7hZUyDb1pau2VzbY4nyzz7XwrWgyA=;
        b=YEulN8AZBNRe4qxDU9fAXECmHKCQ7KEL994lm+4ZrMrPvjY9d25miPzu1dxQofj5ig
         J9MVpnB1NFm8qeV7JA9fdetnoiGlMfO9E8xSy+SAAJiJKIjAxJZ2pDtrFxEhbFyX4t6P
         mW6XkAPJ0RXYam0Z38u7Bub9z+DbgCuTmW5OjLCCPGsdGWkAkEqe5gWHHX26BI9sSYOt
         4aM48bSnqeFVOYzLrJxmGhoJWTFxtAEL+hP9R3ExdOTa2KcttI+xLFcaNgPdQjZ6MW1R
         njc5MJ4vp9ke9rqhqDTeDgASpw9+X5Lgtfpvn8WeVt54kyZED4M3MSiwanpUR1BwBabh
         Wtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708568232; x=1709173032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdTVljSiYMvdyb7hZUyDb1pau2VzbY4nyzz7XwrWgyA=;
        b=sYW07QVS2fKfMbN0Ido/1wE/53yXvpRIRuiT/NsyItSI4h/QNd0Pl+jT7Li5xNVseK
         5h1dpOpnA73J2xHayk0F3UhtD0KfztyMgZ5avnYXRQjbXRjqlt4LF6aSlz9lzaW8aLEE
         WBTLhIRFynmJkG8fQQSTe5JsUJ/X3E/bO8zfKrOs4MCvCRByzcVXGeum00ocsJWBu/lK
         J/NcnBeeO+r+eJu5Qqvaj3j//cCDVCIQAaKwdUoGgXiStm8UQelTrilA87Lqd1ovfIUr
         Ug3J7ovrshhiMlDPrqUlD3y82OmCbMjF4dgwFeVVBb+TLVJTdyy9fnGUK6dn9BGi49qd
         lVSw==
X-Forwarded-Encrypted: i=1; AJvYcCWfp4OJUMaPdIka1MwlRWeGMafwzOyCx6s0PbLTJ/7GVUYwsyfPzp/9RODJBvYDJAU+sKEOYIldJqVsDElmIfSRXSdOGWxk
X-Gm-Message-State: AOJu0Yx6SdtYwNczuCPsd76DTnoDuIbV9xZVu1rdBBt6N9rbkQAafzdZ
	ipNIA0wjQIGuN34mtPKm6ZLx3UP35HEj8xMetB117zxbMg0F0SB+nGrS0ZBOvBe/MYWg9f2jKGC
	R/Bpvgt6wkLM+xzWkRy1E+E70Pao=
X-Google-Smtp-Source: AGHT+IFdNv07jcJZJBpqyuv6cHRx2Rvwgx2I+F3sN5TIhfOauT5E/ItM2Aq48H/Ot9yOGyRo68n7uKg8VXEhZMEqk1Y=
X-Received: by 2002:a05:6402:395:b0:565:b58:a0f2 with SMTP id
 o21-20020a056402039500b005650b58a0f2mr1781079edv.20.1708568232088; Wed, 21
 Feb 2024 18:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221025732.68157-1-kerneljasonxing@gmail.com>
 <20240221025732.68157-12-kerneljasonxing@gmail.com> <CANn89i+huvL_Zidru_sNHbjwgM7==-q49+mgJq7vZPRgH6DgKg@mail.gmail.com>
In-Reply-To: <CANn89i+huvL_Zidru_sNHbjwgM7==-q49+mgJq7vZPRgH6DgKg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 22 Feb 2024 10:16:35 +0800
Message-ID: <CAL+tcoBdmgnxoqnFpjijQLYc9Mit_hAh2Rfni-XbMW0Abd2_3g@mail.gmail.com>
Subject: Re: [PATCH net-next v7 11/11] tcp: get rid of NOT_SPECIFIED reason in tcp_v4/6_do_rcv
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:47=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Feb 21, 2024 at 3:58=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Finally we can drop this obscure reason in receive path  because
> > we replaced with many other more accurate reasons before.
>
>
> This is not obscure, but the generic reason.
>
> I don't think we can review this patch easily, I would rather squash
> it in prior patches.

I will squash it in patch [10/11] since that patch just finishes
adding specific reasons in the v4/v6 receive path.

Thanks,
Jason

