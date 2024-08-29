Return-Path: <netdev+bounces-123503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C94869651B8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9A61F21B39
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5647918A94C;
	Thu, 29 Aug 2024 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSVfkmoF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B94D108
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966382; cv=none; b=U3Eo+WtQ5gEvOZWz3uoba/fb6yUU5SayeDSBhdmRceAocSFFo/lrDs26G1xuXhl2fjupDDUsO/c5oaffzEPN5HxhovYwiZFStrJCk8iFHq6IQ50McomJX0mrABSQy872SEzkbj1QhbsHcwh3jxZCsTQVy3eV5gITzp9xC5tH6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966382; c=relaxed/simple;
	bh=cSSHR+7MIgv82yUhJt1tPdyAdr9oWGKwjfORiHPFS0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fq/rtiucmUFYNAcduizXW5FiK1GGZJIo4qVdioYDOcUMe9jhL+gqq5oNtl62UcW4ewrhp2vwUUOS9ClVpna5ULQZaW3JIxFPJiyLbRx0L05Btc6hOO6+iyXw6EIRHKbnbEJx9GFEeGlFVgZxOCbQq+y0WyeIp5DsV9ZExapHljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSVfkmoF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso12557575e9.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724966379; x=1725571179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cSSHR+7MIgv82yUhJt1tPdyAdr9oWGKwjfORiHPFS0Q=;
        b=rSVfkmoFRu6MriUP5eOkVinYRHqhhPoHe5G56FvTdLUvvXT/go9pb8TZrwDf3UFpre
         vOX7gTf7fwC2lPffjjR/nlBE64AprSv1Yh0Yu9w/2hVZ7G1Ua0V6RyipRdC7VgUa1Ln2
         fgi3XAGwkFj/SNZH7llRGQx0fLbfzxF90xniCd9aV1i3p9OlowRT8e84b15VlqcZMJx/
         9+/EqJHgSV68x2WWcvXcQ5dr/smoKKsuRGfFk78VPYp8yJzybypuUBpx+BjLj+9h2jwX
         VrcEt/0V58/lwRY7DBTU6hwEsqXxXTZuaOhWKR88waBDY2cydwu9ZGdj7ypuU2QvWak5
         at/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724966379; x=1725571179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSSHR+7MIgv82yUhJt1tPdyAdr9oWGKwjfORiHPFS0Q=;
        b=FVCpUuHpFlhcsKkZuyYXDcf+PC83nGTDwDIadOoeJDkQYLDNhSBCYcVqZATA7crK8a
         JqaDBnlUKmT79pGiUnJRUv0/bn+IoOG6qRXXa0YSlqcpcpcAJdfRzux9g+ngWxtL1aQL
         EdnxpMHvWh8b7Pf9NAnh1nlDYIBFwrqdg9xe9a+D9Vi7Q8UEhxCLmwd/JP5DuH0a71so
         GvfPK4/zE9FScr7CucG6sQzl07UhhqdrkjR3T4zUjSHqWjT0BFGdlN3FqUWv0axskZLM
         aaT2FScVU9R9ZHegf36U1Ty3+tBD/oZCbz4bfu7v1iLVeCbPgLNd3TDzXES08OIXDU1A
         KKpA==
X-Forwarded-Encrypted: i=1; AJvYcCWwxdhYY/g2hPmsXxe8TUCn/7vDonradS7ZLxwHoDPWOi2//Q971NVN6XLgzNDCtKspAZqZvUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OpHE4KFnt2sw/6IuYUS2c9gPuo1XBYK1B+uyI0r7/5Ku94hN
	3QAXhVhbyHdwjV0zWL7O9o7jHN9XVuwoJLxA/N9o+IYVjfpRXym/idm7+qEpxCZrIeuhpi3BVT0
	WDLiXsb8Askc5Kk1Y7qUoLc4ldfpRl1O/GQNjT+KyxSBvitxHeASCyhM=
X-Google-Smtp-Source: AGHT+IF1b8OxSqTUnBvA3hUgcZ09FQh+dY865bjdQ0W331PM802F47DuxbG3pcH75Q1I8a7qWne9QJFzYgk2lxFHceg=
X-Received: by 2002:a5d:468f:0:b0:368:4b9d:ee2c with SMTP id
 ffacd0b85a97d-3749b544ac6mr3406186f8f.19.1724966378230; Thu, 29 Aug 2024
 14:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822200252.472298-1-wangfe@google.com> <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240828112619.GA8373@unreal> <CADsK2K-mnrz8TV-8-BvBU0U9DDzJhZF2GGM22vgA6GMpvK556w@mail.gmail.com>
 <20240829103846.GE26654@unreal>
In-Reply-To: <20240829103846.GE26654@unreal>
From: Feng Wang <wangfe@google.com>
Date: Thu, 29 Aug 2024 14:19:25 -0700
Message-ID: <CADsK2K8KqJThB3pkz7oAZT_4yXgy8v89TK83W50KaR-VSSKjOg@mail.gmail.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	antony.antony@secunet.com
Content-Type: text/plain; charset="UTF-8"

Hi Leon,

Thank you again for your thoughtful questions and comments. I'd like
to provide further clarification and address your points:

SA Information Usage:

There are several instances in the kernel code where it's used, such
as in esp4(6)_offload.c and xfrm.c. This clearly demonstrates how SA
information is used. Moreover, passing this information to the driver
shouldn't negatively impact those drivers that don't require it.
Regarding a driver example, the function mlx5e_ipsec_feature_check
caught my attention.
https://elixir.bootlin.com/linux/v6.10/source/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h#L89)
As you're more familiar with this codebase, I defer to your expertise
on whether it's an appropriate sample. However, the crucial point is
that including this information empowers certain drivers to leverage
it without affecting those that don't need it.

validate_xmit_xfrm Function:
My primary goal in discussing the validate_xmit_xfrm function is to
assure you that my patch maintains the existing packet offload code
flow, avoiding any unintended disruption.

State Release:
I've noticed that secpath_reset() is called before xfrm_output(). The
sequence seems to be: xfrmi_xmit2 -> xfrmi_scrub_packet ->
secpath_reset(), followed by xfrmi_xmit2 calling dst_output, which is
essentially xfrm_output().
I'm also open to moving the xfrm_state_hold(x) after the if (!xo)
check block. This would ensure the state is held only when everything
is ok. I'll gladly make this adjustment if you believe it's the better
option.

Thank you once again for your valuable insights and collaboration.
Your feedback is greatly appreciated!

Feng

