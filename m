Return-Path: <netdev+bounces-201617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4844AEA11A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0386A4CBB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D928C2A4;
	Thu, 26 Jun 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8XDkmhR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368161E25E3
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948813; cv=none; b=IORXjfys9N/n+83aC3HlYMnq++ac+Dcw+YRIFMY63CFCCDnpI+O4fvn6Q9QlUM8EmLssdNbhaTmqs3DUY/lm0CEzPC/BocnYn63HFDdvlnz9Q1zlWVOwKpYsc/OOQvxcQCKWz/PUy7nIuqZns7I1Y8nVglvwqwi1odXDYL5p148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948813; c=relaxed/simple;
	bh=VLW8usBRShuFNs4L8jRsug/upaJahS7kLto2qlmStyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZj/oVCciHnzLzzGUX0gL4/kQEma7UtKMUIFvCpv7fXXoslIgKktKgmhwdNWEWQoBn5WZZ3t3lg2Kf2fizMTMDx7HTvr7JcylGjRfMjbj4nL1MreujK6njAcMulJWE/37GAv4UnVQ3ASZZhWqrMpqY6CuHGL9CMVulb8eMG5fB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i8XDkmhR; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7cadd46ea9aso152381485a.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750948811; x=1751553611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLW8usBRShuFNs4L8jRsug/upaJahS7kLto2qlmStyU=;
        b=i8XDkmhRyjhL+IT0ir1V4xlQgVV646lEPRYRVpjlibyyZTgOUxpyA0rfCkdC6spZES
         UKQe49GNvqCTwnrB6U4BY38jBqmQWOYObTL16XnzZg1Lm3ppIuGjDQVrpI0Tejse3xng
         05Up1JQAxbki28WNpR6Bg4KEIZ4turiqPm1RlRkKkPdsa7yr8WeKjzaoFKnBmpblQLMV
         yBFAUUYmnTQ4HIidJz1NF1tGVpyZnaueVREU9mgkdmvTetf6Cvdz2VtdmI6rCz8wU42d
         kPZ1qc2ENfgXdvNR1hSQE81lFYH1TVvf8PBR8DwuZVkNLu6We6QI5hgLfM9p4cEafkTF
         rPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750948811; x=1751553611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLW8usBRShuFNs4L8jRsug/upaJahS7kLto2qlmStyU=;
        b=BEMKRcNFAwWXwRxOeVq+LepBgt0tfreVtht+yvxklOl1hoYhi7wb5apv7HP3ke7VXY
         7W9smaWxriHwdh8S8liU3sTveA+rgQKvsOdDulsB8pdGE7uqWptSSCxTZvsWr1bV9Hw5
         5VJZo+GivyIk1M2hZg57w2vMU9e9ZLY0rYtgBcdiAkSEyqGaa52BSORay6+KWuQz5yiS
         tok+DNJSwOYsFvpEq2zZRTjgRS5jXFIBX6xRTiSb4pfKYKUcj7wVY6YevdDbdPUASCnu
         cVHB7a2kg2J72NlVYZK2KCTWV7oa0iL7N/o8LvOl0wa2vesELvwqELMMykn+iaFO3Nhz
         ZF/g==
X-Forwarded-Encrypted: i=1; AJvYcCWwJyxQNoGBUhVW8m9S4McrfZw6VslzRMoD5Dj1GhKoCCCL7o3CO4eRAJ4/6G25qDQAEO8Hi3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvFT+a3Bk//gOT/gxl+Kt7lydFq4D//bt1xWNZZEZj3gN1ev6
	+2RIyy1A36ma3DUPBzlyblEQClndiitId43L9KqT542+XIdyChr+lxq0F4daj6slhoyCmAQMoSY
	mG+Udis4mX/eqDjLmWno14ngERGa/8CTPs4mw+qUA
X-Gm-Gg: ASbGncshUVD1egSALh1yLBZK0XpzSxINhn5wQP20GpITSeC1IROWsm6HDUiEVeqqzWU
	m0lwTMjHeRFKuTsZVzpkUcv6N25jkiqrRRx1LKAZLbBezHWSy+snSNByS+CQIje8muurAAkei5w
	+ybkNoJ3U2QOQwpyzD0KtuLTR/iLzWi5tQ4ES+nQ9Gw8wStmSH3rIF4w==
X-Google-Smtp-Source: AGHT+IG9ah0NefzfpmNyyMsAleJjQ3tc4fanRJOfhBl2nfGzRdw5JlWpO45p3/mG6gaiDUY6CJrX8nVfzArTjCrxsZk=
X-Received: by 2002:a05:620a:1a8d:b0:7d3:f0a0:ea5f with SMTP id
 af79cd13be357-7d4296f4d7cmr975720185a.22.1750948810487; Thu, 26 Jun 2025
 07:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-9-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-9-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:39:59 -0700
X-Gm-Features: Ac12FXxqWyh6lWT5nAp8ttkiOvEog8csAXoJNZJL5zRq_Jp27wGmQjWdvkTVPFM
Message-ID: <CANn89iKRcpyA7MQphPXsm8LxT098m_Hi8H4yVfVG3EbaYgM0XA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 08/15] ipv6: mcast: Don't hold RTNL in ipv6_sock_mc_close().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> In __ipv6_sock_mc_close(), per-socket mld data is protected by lock_sock(=
),
> and only __dev_get_by_index() and __in6_dev_get() require RTNL.
>
> Let's call __ipv6_sock_mc_drop() and drop RTNL in ipv6_sock_mc_close().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

