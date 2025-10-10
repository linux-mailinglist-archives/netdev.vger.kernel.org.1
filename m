Return-Path: <netdev+bounces-228552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91C5BCE03D
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 18:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF32D1B20799
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110FC2FC87F;
	Fri, 10 Oct 2025 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVTg8c3A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B32FC024
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115493; cv=none; b=tL4szsMNZoxEyY7h5yH9bIiqF9BEXL/cs42U6G7i8YmkL54SuZ4wc3YDa9yezjia8lRhRRd561BQNdHjxFgI6ld8g9w3lk8Qo8cichhgM6aG/QFkDnQfCaV/PTCmP1GsxO+O8iunD9HDtTuTHUxA/bzzQkRTkSrdFRZ8pecdeP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115493; c=relaxed/simple;
	bh=YQIzgJBxlzPG5AlRv9L+UYbZx6Wu2WPPbf0x9Y29Mts=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=eNjVRN+tVl74KvVPhJ6xX+ZG3ucvvagy6pj/bfUigGzdseprpxHol8IjZnoW2UUzkgGEAvf3kiOe/yu6rpq/2KGF2GhCCy8WLKBt8xtraa3ukde1uuRuFDCyEet2nntQKhr802TuMwZy55kID81dhO8CTswjsDNRed93bFyNggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVTg8c3A; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b5515eaefceso1964130a12.2
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760115491; x=1760720291; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQIzgJBxlzPG5AlRv9L+UYbZx6Wu2WPPbf0x9Y29Mts=;
        b=IVTg8c3Aj6VRZ9oSUNVWWb31sDwJwi0JGoyCtWNmkGB5qHshdK2u0c2b9ZDYDaY1Fd
         a1QCDSfJSM/Ova+7O48NUEprNfuOl6BytiBe/JgG7mn5w41qVIeZGgFwg1SFOtbPr0DI
         H2IskcjC/CfgqGcr8/K127IDoXaomYcf0f/vPnnBqCM4ZIFKaY1KJRymUb0kamswiFA8
         neAq970dBldmoB9PfEtXmEpTgJwMCebbebDD1qWl4CcnFTHDIF1ahj0gUTc/OCVrvvQ2
         hwXfmKOMyR7iuFMscZGwVa8dM7MJ5JeCazeb5xvEnPbIiZxaavNcIbMPjUI4Lq8RUDj8
         EZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760115491; x=1760720291;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YQIzgJBxlzPG5AlRv9L+UYbZx6Wu2WPPbf0x9Y29Mts=;
        b=dUk583oqXz9Kn03pyrjTroRvvCb9lkun+5adPZqCX1nYwJHzjbtB6V+Q9yy0goWo9S
         rVBacfmE52+WiY7z6zeCHZoHFpt1gqsuByuJjF63egyBdx2Dn3vPwB2XBK30+TGT2YFQ
         kQVKuT/a+7EFLZmktnzE+E1uKprfCuqS/tGgd0kMWZ1nqhfGLJ9XqvC6ZhRNMDrCkb7l
         f4zTN42C9/ne86YIgSGDj/q9+vtU7u7LXaCMQ2O947IRKADtCMfs2SBio44nJ8lbbd7d
         yXdcqhDAYGesNawf2kzTYFtmZSh4GPZywRVuAbJgkDdo5H0BCMW1nxHYbnFn8uD++WTO
         HJEw==
X-Forwarded-Encrypted: i=1; AJvYcCUYo7cJbVpfuboGm4WJ/Ztinazd1PrLWHnPEoouhKDBpRSqUeOwtnV4vkQRwLqd6O2nwYh1Ggo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqzaM2Vkh9eTRAUrnDzPblTkBQ5qiH2+PFaVLmrLMGjFQ/XvG
	odTQQ2OJOEsi4TCYmdapa2T+1opSFRdIl29e6ASuFia3lgXWvEq0G/tL
X-Gm-Gg: ASbGncuWiUr0L+grbh3lkMfw3MyPjx/VjTb+jmRuH7ci/B7iNfmrlUHsuiRMxmuy1l8
	vqZqWR1YOL91+ghQlnSJbuicw2MIENrkLw75V76qXVyHrEF/L8bCrffFtScTebgiFtMKqb6uarN
	IvioTxk3i8E8SVyVvS2GJ8Xo5qlVTp3tgd6FkkGGQFsKMFNo/dPrORZt6H8xSfnFp6P89tDeExA
	nwKh9tOC2WjdG3kXULEtX6B3ZoCTOfTU2J5561bEeZSk9+t29qKDeTN2I02dufi2iLcahP5O1I4
	C2vqCR4yWdAx6jweQpEGtfEub1LUWTrXTHN7RXBTeqH6JAjtpS4zstKOocr/GbThkXMDBFwVip+
	k+UGXqzK4YF+WDKpm1zQ9di3d+LQvJ5HoWcWYNw==
X-Google-Smtp-Source: AGHT+IFe5XfGJsLG96cHOz2cIoZiFjCxmIX4mzf9nbE5HrQUc4cqUqYqn0FJn0Nd1KULwqb0Pe1Evg==
X-Received: by 2002:a17:902:fc46:b0:27e:ef12:6e94 with SMTP id d9443c01a7336-29027418f97mr154166675ad.55.1760115490627;
        Fri, 10 Oct 2025 09:58:10 -0700 (PDT)
Received: from localhost ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f362fasm61712045ad.97.2025.10.10.09.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 09:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Oct 2025 01:58:07 +0900
Message-Id: <DDESV8839WLY.MLMFM3ZOOQPN@gmail.com>
Subject: Re: [PATCH net] net: dlink: fix null dereference in
 receive_packet()
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20251009190222.4777-1-yyyynoom@gmail.com>
 <20251010071835.GB3115768@horms.kernel.org>
In-Reply-To: <20251010071835.GB3115768@horms.kernel.org>

On Fri Oct 10, 2025 at 4:18 PM KST, Simon Horman wrote:
> On Fri, Oct 10, 2025 at 04:02:22AM +0900, Yeounsu Moon wrote:
>> If `np->rx_skbuff[entry]` was not allocated before
>> reuse, `receive_packet()` will cause null dereference.
>>=20
>> This patch fixes the issue by breaking out of the loop when
>> `np->rx_skbuff[entry]` is `NULL`.
>
> I see that if np->rx_skbuff[entry] there will be a dereference.
> But I'm less clear on how this situation can occur.
When it failed to reallocate `skb`, and then a lot of packets come in at
that time, `skb_put()` in `receive_packet()` will cause a null dereference
and the kernel will panic.

> So I think it would be worth adding some explanation of that
> to the commit message.
Sorry, I'll make sure to describe the scenario more clearly in the commit
message next time.
>
> Also, I do see that break will result in np->rx_skbuff[entry],
> and other empty entries in that array, being refilled.
> This is due to the refill loop that towards the end of receive_packet().
Exactly, that is correct.
> But perhaps it is worth mentioning that in the commit message too?
You are right. I should mention the effect of the break in the commit
message as well. Sorry for making you point it out twice.

