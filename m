Return-Path: <netdev+bounces-74089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4608685FE5F
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778361C20B4B
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B226C14A4F4;
	Thu, 22 Feb 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztUGGNaz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC98E14601C
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620339; cv=none; b=rQHwKG1Pg6Fkw60Q7tCJ1oOGbuvsL+/b7Q8fukb34jvpmf6LNi8GVli9w0VESLgoanhBrapVzp7NLLScSgQUKVGWfSRK2u/cHlSi5lcahhkbm3bb0fCJFC4UDVp4NeFtZOzPtOO+5/Mc2q98ZgS8sGT8yf0IYaOLjErcVNokkfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620339; c=relaxed/simple;
	bh=bl0yVy/HHW0stM/MH68DbZJFgiF+7NFjnUMS4N5eqh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUr4oiL4TZQi1pag3ciykgN2k9+yung0TsYl9F91vMXyUpYC27bcqsHGZ3xml5yyxzvM/UUW0SM63ZqmcX8uGSu4UQ7OYGqvi6oFwsBtu7/ri1JXHN4S9j8pb7or2PeB2O7bTdzObGTsG/AiXPLj4G+X4nlCpy23ovY5bL/sG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ztUGGNaz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so13887a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 08:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708620336; x=1709225136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl0yVy/HHW0stM/MH68DbZJFgiF+7NFjnUMS4N5eqh0=;
        b=ztUGGNaz5fTQ8Lt0npmA3YWei27m3rA95rHwKXWRKeA4oyDN6oGsO3K8y3Sx0RQd+/
         cLWo9nFTw2GxFsyMi47b9eCoHqjwclo6lBod/HZ+dhFPEq6ODUvdrJLx3z89GX3D6dzJ
         MVgJDWchVjLhoXotXY4s0cohB6d7JPAGwHoTwisz3cQQtzPF7Jbjcx7GhoEj162hy6hi
         F2detpWNF4/giQAp6Yuo/vR6tI2ZZ/h+ZD+D7u5r5zyn4WD7UmIZErnnISu2fwVWbRHp
         2/8xSOP5fm6rymuzPV8yIM7TrPPLjhK2+9VgZSkFsAQH2rTsaO72JhesYTjJVon8WtcD
         ZH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620336; x=1709225136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bl0yVy/HHW0stM/MH68DbZJFgiF+7NFjnUMS4N5eqh0=;
        b=KzkSR1Ocv700Dfm+07zp9eObWtuIWF+A6LQEfPw6GvgbhdQmHN29Lp8a39BnL5g1wl
         43aqtBvSfSFuebraLnVq4NheoGj1wS7/Qo+88QDDBIfTbnF3JeELvJFQG9qU7lxYDX8R
         bHtTbvBy/kHO8muFnmDfCDuZgDKlTw0XA54w6gx6ktqvrEvt3RVCPP/X7HArbqBTaVSt
         IiczJcOEh6FikNn9+WVGSqJga+vXXQ4xStNHo4E/Vcs/gJI73zs4pIHObxEVhPvm6tFd
         f7oUsOFShWoB95jev0ZH1dK+tREVl50V4xIHXPVrLmYt0B1nqbfIPumr1CAN9rtCNCx7
         RqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWU0Esou/IGMeyqQvBMHAdLQtEabJijB/3fzqK7DBuQvLnb0m7BNOUhf/hJ0drrNxtGxt0EA3zZf8p211sD/9uZ2WjYHXd
X-Gm-Message-State: AOJu0YzHB2xQur6ZO33T7Wckx3pcpRfUcKkF2YjPcOdSrzRYyW2WVDh2
	+Sm+5NBwJiXUYdTK6A+r7Zaiw7l0CzytkQK2HFmrMQ2FDj23xAzLnCKB2MPehXl3Xmob3D8bFJg
	Eq+tqMwu5gyVaR3lL3DzdAPWgt11p31UJlgIy
X-Google-Smtp-Source: AGHT+IFX/bHpN0jiv8xiuAhibmDmFcOn7DNnLbDo++G2n8OKY3GFF0gtCCpzqFZKYOFG2GHx4KuFWtPdk5Zyv1bDqKs=
X-Received: by 2002:a50:c309:0:b0:565:4b98:758c with SMTP id
 a9-20020a50c309000000b005654b98758cmr118231edb.4.1708620336055; Thu, 22 Feb
 2024 08:45:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com> <20240222105021.1943116-4-edumazet@google.com>
 <Zdd4HbfO2Bn9dfuz@nanopsycho>
In-Reply-To: <Zdd4HbfO2Bn9dfuz@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Feb 2024 17:45:20 +0100
Message-ID: <CANn89iJsmOk7AhGo2+rD53T23+JfQvo7kqg-ARY7d43T683Hdw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 03/14] ipv6: prepare inet6_fill_ifinfo() for
 RCU protection
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:36=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Feb 22, 2024 at 11:50:10AM CET, edumazet@google.com wrote:
> >We want to use RCU protection instead of RTNL
>
> Is this a royal "We"? :)

I was hoping reducing RTNL pressure was a team effort.

If not, maybe I should consider doing something else, if hundreds of
kernel engineers are adding more and more stuff depending on RTNL.

