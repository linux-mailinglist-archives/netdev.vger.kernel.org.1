Return-Path: <netdev+bounces-203496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AD4AF628E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F464A808B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E002BE656;
	Wed,  2 Jul 2025 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ByItZai0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC412F7CFD
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484301; cv=none; b=N/X2fsZu4Xr+UvDqoTjwKbza2dVuWAB2AruOwuxCtFKu7JxgKrUNPQ2oFXjl7Slci3TI07+rMAmAHWtMI0bnazSg+ZRT49zKYeL9y86lQQUFX0ygK86skMMAbP/iRPj/4kkhshsH5ISe94wzqJ3DVnyxRyI4YzhEYWfr+0Gm4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484301; c=relaxed/simple;
	bh=KK4ynMiBHY0thbjaKNOn/kUYd4MYbYdKNVAr0/lf4n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0yb8llQ252ra9L0kuv+1vz5x+6CEpXxJ0GGhAMy1ROfY0WiiuytnqK1ooVriK/F+wxtV4K7dNEwRC8Z9vSSTfp9u4C05wnOlZIDx3BtSWnmIjUdcUg1vKlncYZQUAPAao2zJZc+XBx5IUGLExp8nVkcU5SyL4BNB+PWhe2mDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ByItZai0; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8187601f85so6494251276.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1751484297; x=1752089097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RisGUs6Qykk07nJw80m0Ftg7mf8erIx6Cg/HctC8ynk=;
        b=ByItZai0w8MGT3rkQg9Fse6epWc0z7aza9psyjNIslDY02rb45inRL5w27IE/oJ11f
         toscM2B9hzhUCDHK15bMnsPE/Di2s1Fnzup6bh7976ZiwfV/heNX4UwBgb9ogSoco/OL
         k8ON+PSZdN4V8YpzO6Y9Ggr/S6rKfC40f5GbvphbrqMm9Xzo20823UAr62YyCVa6TdV6
         5kiXFi6zt5BX5S4WFny3X9Qf+qxgCUBdRgJ/F/hF0BTnYamqKTtPEijdzi4/9ClftHUD
         oAJ5qjAaRWbqoSuQSZK8e4mnB9jHFs9k/8Ko8BjapzrR+Z4FqGj85d7nSwCD1SUGYz/q
         GIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751484297; x=1752089097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RisGUs6Qykk07nJw80m0Ftg7mf8erIx6Cg/HctC8ynk=;
        b=CxaMr5tSi5f8D88wWiGDJSj63xTv+mhYZOjoglV82pDayr/++fwqCuOlNNcYTOIs7R
         L0Q20eUUv1S+hJ81h6Myzww9mdRmgl/dCk4L0SOkT7qJ+sAcYR7ljRv3ciGdkUhC+tXo
         8yzsfw+Qmg/0ys5K6lpjQXGRREhVo5ivb3nRjIKlkoR4f6D8EnC/E1v3/6oQjaEmGAIZ
         i+c6U8jPjab+LtcRaeSg+93ni+Miblx5LxOoxD5AKWxh7BumxiW7t15GVEnJCeJAC3rx
         gJGfBBGKUuKJCoBydyAWxg9gQx6aNJt0FkC3h0Q+Cve7ywuY1C9FzJ/TVUthNUzJS74Z
         Akww==
X-Forwarded-Encrypted: i=1; AJvYcCXThO1LJcPg+y03Lh7V1Mqr5tVNR1iOBMzELihMtxNFLQBzYaZvc1XgXJ62iNWXgggZAOWc29w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5apNs8BT1jSMOZpN9gHFnLRwEJiZnftAHjkx+jiTTUx0YlXJg
	uYlU5dE5KJHNCsC8nTku6u/xv+Rmxr6XwGSnfkjSYfA5RpW3eZLTh1PHV2mtqoWmJlJCob+gZ4O
	ct6d/6onCVJijeIKMlAX5i72MnMSrY1TXcoTXh5iA
X-Gm-Gg: ASbGncu0RL7TKdKYzqkS/Nv4s3ZYfNXSPFAOZjPpdNh1U8FAJiC32iRFsMY1pGXwCZ1
	NP2zhBYtE0bgFJZLUe/Ow4Z/QcsDVp6tbI9Tt1j7csKTK8XwEyDFBy9VzrZf00XBrLjsfKfILmp
	jNXKV2n+oumVGGQy3NSTVS5L0gqtlCxYL09rJSUmaFmQo=
X-Google-Smtp-Source: AGHT+IHvhasAtxRO9RpFu2NYbRrcynF3zeEZltmoq9Luzh1btO4Igu87XYFa3nEiA/TfmY8TNO2agVgG/zRUYfJtTIM=
X-Received: by 2002:a05:690c:6486:b0:70e:185b:356d with SMTP id
 00721157ae682-7164d398834mr54967477b3.14.1751484297140; Wed, 02 Jul 2025
 12:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702055820.112190-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20250702055820.112190-1-zhaochenguang@kylinos.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Jul 2025 15:24:46 -0400
X-Gm-Features: Ac12FXyjMghT7240fFXsw7E25qCJfe8hMIplSYH8wjk3i5VEZLbQ2yBp0Z1HQmU
Message-ID: <CAHC9VhTg7cwXu17tHMgSJF3ZRWjA_ozZg3TK3aLJOs2X4QBJ=w@mail.gmail.com>
Subject: Re: [PATCH] net: ipv6: Fix spelling mistake
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 1:59=E2=80=AFAM Chenguang Zhao <zhaochenguang@kylino=
s.cn> wrote:
>
> change 'Maximium' to 'Maximum'
>
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  net/ipv6/calipso.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

