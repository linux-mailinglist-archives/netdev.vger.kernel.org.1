Return-Path: <netdev+bounces-78250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF8187482F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 07:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08601C228C4
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 06:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097471CFB2;
	Thu,  7 Mar 2024 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/I3SFol"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3041CD20
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709793001; cv=none; b=HfZTRGiEVzPyBuw5YIpNhzz7OGH7Y3jZ9akbI8w6XX2iY/JZ3VrF5vUx8J53H7zU+l6ScvpVoi0Uda0mCA/oP2zk8T4Mw2xYo5h/8pJb+zMEXgHJmIHnoBWPLqO0vAiRA8g5IMLRhYg1vRm/eXtQt6x2F9cRC53YPM+W7e0UUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709793001; c=relaxed/simple;
	bh=pQudPlGkZi7nLdd3r5u27oEC5zqBvNR6AkcRY0RjzpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE/pukx7/bCza05cAdtgTj9bAQ9n2eTtjVmr4Ha5WKdhTAL9kS7qEX/Kbca9+RZiLxLGYvo8eW0pdijAU3TO1H5rKW7DncWl8vwoQnE9GeySZME1WEMZD6JYMRlY3VNSOmCELp7iuWAeVK2Fm/ZFpu/DPzVeyT7++IusGGYJCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/I3SFol; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso8655a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 22:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709792998; x=1710397798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQudPlGkZi7nLdd3r5u27oEC5zqBvNR6AkcRY0RjzpI=;
        b=Q/I3SFol/5kKf6WEHNP8m3bGEpy98Teh8cyAcei7QTtZ5GaULoAUcvdFf5+GOo8sq0
         OGz9+hsZ/pgJ/1WmBk+dzcmi8CIHb30C4nli2txWNeLeclHylnD5oOoq8jZjlaL1LC1G
         FFzsyHAUomBh3rij92jhOaBZh6DUDMWfaUn0KdwrDSbjATrX+BCBloCQSLsHHg3nqU5E
         qRCBFY+dx9f0DhYBm9CgGc9Q3CPrdnpb8sh7/ksBoCQe8wLzplJ+RQ9cD4jljHLQi/yq
         iEtI/OMqYr8UVlsSJGQkZB/ZCAkkYrbniSUw/a8bXN6kBKi+YO0lsE5jGjybYTSFXJR/
         eCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709792998; x=1710397798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQudPlGkZi7nLdd3r5u27oEC5zqBvNR6AkcRY0RjzpI=;
        b=i3Rdfl2/GEM435+N+r4MYaBmJTafQ2NjSAiktGTle1HflvYoFjSqiYvV0FycMFju0Z
         0Nmy3x65SXZm+anOnobPiVOwnfxhNacpBGq5IJdhx+4HEhw/5jhCgUlasHhVcTsWEx4R
         1MKPmaoIC2WxzDcSZfiOLr6qD+sZoaCYNNlnpqO6AxUp2WEQdeTHHJIWb0UZjSqYlrsv
         LQco5/S1bvv3rIpcF8miD8QeZY+aZ8cfxP558ptRwfrF4Zn6HenQU0VmVVhG2NEItX12
         YGb64LugfcYmn4v0mW5g+tw4cHAk9RhA81lpeiReSxJgLUyA3jgNFsCq90Ht3Pbc1OMn
         ArsA==
X-Gm-Message-State: AOJu0YxeYyvm5bSGLZnFmwPwuL/Dyp3smP4dD9kK+pUqubVzc4suAkfL
	WHV7e+0uD12s82b9n1yiAH09qzEfMO6b2Sarkk9UDRfuvjHAKx+pq30UbtWr5k7Lraa6yr2F6TV
	ovham2WcfeCa4ehVgCvaNfWohOCu87fPYcjgs
X-Google-Smtp-Source: AGHT+IH2cmzKIcTqYzHvj2RhWmNsfFi4INJ+wIiSdSx3AVm/nDp7Fur/zyU80RzkdZmIhZm2+sMez+i8jmufZYJ8Ts8=
X-Received: by 2002:a05:6402:5202:b0:567:eb05:6d08 with SMTP id
 s2-20020a056402520200b00567eb056d08mr142537edd.6.1709792998269; Wed, 06 Mar
 2024 22:29:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307061143.989505-1-gaoxingwang1@huawei.com>
In-Reply-To: <20240307061143.989505-1-gaoxingwang1@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Mar 2024 07:29:47 +0100
Message-ID: <CANn89iKJSGek0vKtH-0QhFgZ9S4Cb1jTmpTq1ZmUFd0G0+b3ng@mail.gmail.com>
Subject: Re: [PATCH] net: fix print in skb_panic()
To: gaoxingwang <gaoxingwang1@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, liaichun@huawei.com, yanan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 7:12=E2=80=AFAM gaoxingwang <gaoxingwang1@huawei.com=
> wrote:
>
> skb->len and sz are printed as negative numbers during the panic:
> skbuff: skb_under_panic: text:ffffffff8e2d3eac len:-1961180312 put:-19611=
80408 head:ffff88800b6ac000 data:ffff887f804ffe78 tail:0x1e0 end:0xec0 dev:=
team0
>

This was on purpose.

I prefer the negative values, I find this more useful to immediately
spot the issue.

Thank you.

