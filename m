Return-Path: <netdev+bounces-242646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E093C9367E
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 03:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1E63A8D19
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 02:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0371C4A20;
	Sat, 29 Nov 2025 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec8U5Jm6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F7A19E97B
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764382097; cv=none; b=KPLiMVcKOXE/HwrsWFxR9jyXI13iPrztxTwuQx91uZ2vksn+9X0HfHbUbiWKU5yijQCT5anlb9oc646RqYahyM/7C7Gq52efUyVa9p5NA2k1VzFcWM29WQAt8nCqg0A6t0eaNKSG9sH0OG/eFUjH3QNj3I2DHoxOnnC9ix3cQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764382097; c=relaxed/simple;
	bh=CRc4BissXiBFHsGxmQeeGYsKNXpLm3Hmb6y7vM/q4E0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dFd+WhueZiutBY3IF5xQMBRbpQFBqrGRauaBS8PR+eM2RUVF7/3mzfdoa/trxqoMhKimAzB5gmR2VbMhXJ6MA985QN1tpGhsEq3BCqpN0qUrviLR5W8slA9nNjWf/DHXsoVX+rlmtkRjC9YdtteVHMHw1FlevSEsDnOBJR0mUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ec8U5Jm6; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-786943affbaso16211407b3.0
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 18:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764382095; x=1764986895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsRYCdc4G4wEDADpE0nWasPGvye4RSjOQQ03w+jfvak=;
        b=ec8U5Jm6LrgoizdqlsjfvLZVaF/TzvnaRy4dXkvr/d1JTSGPJhdI3VHT3vWfsZ95O+
         Kg7T7hs3LpGiIuwy61WOvZ/6LLDZC7rfkGNexFCfHVVV65nH1TcPHfLntsJ1KUXSezrd
         Z1S6G+BDvf1nTbJJhD5untHkCUM0z6+dEEgMdzSOvlXjSa2neBtoSC/Hww6UT0BUtTVO
         hZLZU3Ijagw1D9XZ/dnc7o6UwGHV5A30pa27A2mJpmW1JF/+LXNDyRmrJqHc2P3inv1o
         y19Z2rtv5EwnWYQiX5KNsVTayVxHEGXkhYortYaWrWAWL7MSN7GOOK3GfwCYqX7wuahE
         Yl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764382095; x=1764986895;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsRYCdc4G4wEDADpE0nWasPGvye4RSjOQQ03w+jfvak=;
        b=IeXMJVkVZfGJd4H71N25EW5XuQ65KdY7Q42bW3qvUUrWcQhNTcStVguYpGSAnzYhWR
         Hik/FJP2J4T+aEUiBaXeElqgydtaOK09JG5pDYfNBvVKG6DeSQO+ketws2o1KC1LRyGT
         /VSmnEzl23R29EexG/ychi4W2sDg/tAGVn9Y9PetIHEwCClzishRph/UbWtudwSHhHBD
         6j+7eAzf1tG06ywFymr0UC8GWeA+O/GeIDX0uag4ZyWnjvGv5XTiuGcSw9jIvO1GpKWK
         d0eNL0eBtBOLrQI+XQxM6s7NwwKg4kGb0tscPXMnlf0OI+TnK47DUSfcei6c62Lytb/t
         KDZg==
X-Forwarded-Encrypted: i=1; AJvYcCWbDPtRUqe7mTD2tPDM9VNC1AKC6xvedmTd/udvYANkpiqnBkcBqBooNL+uReCm910TBrAXPts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZnl31eSzA+uF5gvZ7Ma5h5HBOCbJuWhR4/1orU67UUh5hYBR
	k4FzeMbjluP71FFJDSwQKRSk1sOsqnlMz57EA3M2dYm9ufKhZ1rpvYpq1urY3Q==
X-Gm-Gg: ASbGncv9sGbdZKi4H9LNPYbsQy3GR4nJ3IDjebGoQ3EHirqykhAzm6Agcxty2/BLnil
	v1+FEM1n1g8QuzJkX5Apx8lhbGtSL7YPJkMrJO3qdwrDa2ED9vp7tOvjo89U+a9PaQcgSpvhsGn
	4t2vF7Hqa0Zj6z/zSoCaBW0nID9r5ocLMICUZaT8+C1njUq1E2Upn6JG8/NRSvcW2+LLUoBh/J6
	QOyIiHthGTEf33vK7BtR7ZUMxr+7hTr7MBlYNveqiuU+sEJ9UEP1Gz73ToPULKThAYSm19chgYx
	/L6jW5JydTjMQOxcmW7/RWF1g/HutHNdiVz8obtmazlPiSX/j6HzrJKhdh0xrhvG1CtTrLAfpgb
	rRmZeZd2KnCiogwCWo6XOu27DFB3IkBiCNobrtNn/EhrySTbZwox0RWsquriqGctDlnbXKns1mz
	r0uJDIyQfPt+2ZELQ+cH7jTdern+OQEEJajswhf6fD+T2i6Bw9FrdqpdytMysMwVgc8FY=
X-Google-Smtp-Source: AGHT+IEmqYXBYpPqEYCSQkz8zSv3rzNYAa0HQAd47UXkkbuR8k3qdccCqSRbB3zv+SwTOcIUYRCuAw==
X-Received: by 2002:a05:690c:6d93:b0:787:cb0c:c240 with SMTP id 00721157ae682-78ab6e01205mr143757197b3.19.1764382094910;
        Fri, 28 Nov 2025 18:08:14 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78ad102d25csm20916737b3.44.2025.11.28.18.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 18:08:14 -0800 (PST)
Date: Fri, 28 Nov 2025 21:08:13 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: =?UTF-8?B?Sm9uYXMgS8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, 
 netdev@vger.kernel.org, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Message-ID: <willemdebruijn.kernel.2e44851dd8b26@gmail.com>
In-Reply-To: <20251127-mq-cake-sub-qdisc-v2-2-24d9ead047b9@redhat.com>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
 <20251127-mq-cake-sub-qdisc-v2-2-24d9ead047b9@redhat.com>
Subject: Re: [PATCH net-next v2 2/4] net/sched: sch_cake: Add cake_mq qdisc
 for using cake on mq devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Add a cake_mq qdisc which installs cake instances on each hardware
> queue on a multi-queue device.
> =

> This is just a copy of sch_mq that installs cake instead of the default=

> qdisc on each queue. Subsequent commits will add sharing of the config
> between cake instances, as well as a multi-queue aware shaper algorithm=
.
> =

> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  net/sched/sch_cake.c | 214 +++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  1 file changed, 213 insertions(+), 1 deletion(-)

Is this code duplication unavoidable?

Could the same be achieved by either

extending the original sch_mq to have a variant that calls the
custom cake_mq_change.

Or avoid hanging the shared state off of parent mq entirely. Have the
cake instances share it directly. E.g., where all but the instance on
netdev_get_tx_queue(dev, 0) are opened in a special "shared" mode (a
bit like SO_REUSEPORT sockets) and lookup the state from that
instance.=

