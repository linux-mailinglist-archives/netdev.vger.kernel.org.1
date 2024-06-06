Return-Path: <netdev+bounces-101476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D0A8FF07E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E12B28C640
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4AF196C9C;
	Thu,  6 Jun 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOMaOGI5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3811196D80
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687035; cv=none; b=AlkXxUN4UZVeoGz4NK0xtYucDisPuoLYDC5OnLSL9K7aBVcE42lLuMJNXwRgcp3A9NUiyaYjKUEwYAsQXDzcep34vty0peJ6tM7AfQBXF0f4333I/QVbFjnAHtvUGFUhpVQM1YPw0yppcopmU69lDOXO9R/AxmSQY7VrjFspJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687035; c=relaxed/simple;
	bh=vrEo50+N9LsOdr9iMUZ6gJoQ+HV2SmoPx/0MOFlRhwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgAaQSAAtTd1XWjt+3czbvYuW0EbeISWMUiw0s8CqAFytFO7QhoBvdMmaLaLL5Vby6Peq73NuO/ZY/f9aJBtkXVI/EnWgifgb9a5M5sMDVGfH3T0zbLCBEvg3FKThGEN5zRAlvybdKHzjCAM+3I2YXJIjAQK2WMvnNJ4mQNRnVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qOMaOGI5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so17704a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717687032; x=1718291832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrEo50+N9LsOdr9iMUZ6gJoQ+HV2SmoPx/0MOFlRhwU=;
        b=qOMaOGI5rINgNDqe+e1VAmCSrnS1IxTPunZYrsdU3MH1kB/IqkU2toOu+A0+Oq+5EJ
         VKrIxhfEx6SSzzbUuPR+37X2gtSKlchIExKqZzeM0uF3Vvx9jiJcvLrEuVLXU8lbragP
         4vONQd5+6WCdWHZCopAH3xLraYhl7Ngt3Hnxd6Z+c7E2FBxfz0YlHm0LzbL9emGOzQ4U
         wcS2L330T/YiuqUXvlrHUE9tBOK/C2mvkp6aABd3TciTA0OrNyXgxgukQKAaxmvhihZO
         RyVT8G3M7oK30osEqQkVs4d/A+MOQfVy0ztR/9T5XofWKybl5M6LwomrChelIO+o5mnC
         ChpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717687032; x=1718291832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrEo50+N9LsOdr9iMUZ6gJoQ+HV2SmoPx/0MOFlRhwU=;
        b=CxZDx8J87XcLKFdvl4fnFNNUTBEeDjByGm6FJ834oZKIQ0q1WdxnmNV4csOk/bfXEC
         yBfzQXov9qpVl/b48NLCVNdCkxu/7H3dU0i4hqvIZ5W71o5wz/gtrhuso3rb7ROOq60K
         QSLqcqTwBvTOErjMSr6yELGZWz6q8UteLixBN0U/wR+GAcqOsrI7r3sEVuNHhFRYBfzq
         jOXjMiZ1xQB+Pr14Nyv2zO/q3qBzLPAk4czIfam8VaxdGMUBGjTbXmO/FqwWcSQBS99L
         IFfKqfYn0C18aBjQqY0YtT7MCAT7QdMQo8imokDOzP4YGwc11tvls7RUc1GtFxhLzz6u
         MeOA==
X-Forwarded-Encrypted: i=1; AJvYcCWmLQtT5Fw7yDB35vJb0TNBzgBj3ynGK+j2ZJ9AD8gKticwci+0W9UCrLTbxfUX86o8jx8E6B9FMZSy9MqWidU73N84gc0T
X-Gm-Message-State: AOJu0YwQuNKedKSmsWFaWFuTEA8QUKvLMHTm3eQw4pj7EiUK6Y43InAf
	h5gkgjuBYvtydhZQikufsnMtmpofaTIfHB+5lrA5MMm6wvviz1hOoWwiKQ6OGn0iffGNUiy0zv+
	aiCbNylHGrHIMhRqsRW8TufdVeC6xXxWtoU33v+palb39eaw+3Q==
X-Google-Smtp-Source: AGHT+IEVaVziOlVS5rMISIzfPTxkZPzOS0NY+IH2BhupTFcjZTaPLuTkOe9QxwPK3lA1bVMsXNXV/0Qvpms63wrG/Y8=
X-Received: by 2002:a05:6402:220e:b0:57a:1937:e28b with SMTP id
 4fb4d7f45d1cf-57aac9137c2mr203698a12.1.1717687032044; Thu, 06 Jun 2024
 08:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606150307.78648-1-kerneljasonxing@gmail.com> <20240606150307.78648-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240606150307.78648-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jun 2024 17:17:00 +0200
Message-ID: <CANn89iL30PH6mvwbqd47npf6M8g6rRXs7Bq-rbLaXCWrnPBxbg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: fix showing wrong rtomin in snmp file
 when setting sysctl_tcp_rto_min_us
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> A few days ago, sysctl_tcp_rto_min_us has been introduced to allow user t=
o
> tune the rto min value per netns. But the RtoMin field in /proc/net/snmp
> should have been adjusted accordingly. Or else, it will show 200 which is
> TCP_RTO_MIN.
>
> This patch can show the correct value even when user sets though using bo=
th
> 'ip route' and 'sysctl -w'. The priority from high to low like what
> tcp_rto_min() shows to us is:
> 1) ip route option rto_min
> 2) icsk->icsk_rto_min
>
> Fixes: f086edef71be ("tcp: add sysctl_tcp_rto_min_us")

Same remark as for the prior patch.

We can not 'fix' the issue of an old MIB that can not express the
variety of situations.

