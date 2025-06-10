Return-Path: <netdev+bounces-196126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B68AD393A
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7CA1757A3
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D740224896;
	Tue, 10 Jun 2025 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8RNTPj8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5304A06
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561890; cv=none; b=sYdneyzLHPm28+Zkfr/o8hz5pzffsKYKi8qsMNT1T3E4nBD+KM+0BFTSHJEE9Q9N7lwnENPM0ORlT4bYgPWaNmWrM66KhPUEQTJUGaLQdxQUDrcciI3xe6RQQo/6OKp0h9UOaEpg0ZgzatOW2zJZ/Dcgs7kZ/Jc2JEbEU1kElYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561890; c=relaxed/simple;
	bh=xqKz5FB2mry7HSTcP3J9hsKooLKWhkBW5XQESjH91z0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ODHRFuuULblguE4t8wAAjkX7EPuyHGzb2y4L5MNjhESEkGN+4CNGYpVOoLq75UHULcPRMN/gwmTcv3tPRIAfIGxEN6uwc+ujop1YXGxGrbWK9FgFwPJvhb+vCaCYykvsLEgXRhxM512k61NNyrgtaQRBoooexFmx+hltYSkijVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8RNTPj8; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e819ebc3144so3416962276.0
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749561887; x=1750166687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCtBvon4P5ZoLAIsR1nAgUCi/L9tAHBCKKDYzz4kE0A=;
        b=L8RNTPj8LeqyqACz/L9pqs5Xrdg32LLAFy1IbkNjnfJbsIPHWhFys4Tz/prZuqPxPG
         qvMalQAfLydt4Jp+FcEvclJf7jDODh566UJeXhRRf+tTPs3VDbds5fW7VEGCUoylMI96
         WsnZGtKjKyMeoVNfh4B+wD3S5Wjq2hQ98kfWL5ruH5mN44DuJuB3GceiKxoJ9j8HTDoG
         e0HM5cPmlJIYaB17/YefRTtPS3r8L0q0fHCxyqX4VEVrJWh6G1R/zQ+Ob/nbdZJF5YeS
         +jzHPm4ee25JPaxPS2QacjBQueaeWyaK8D0l47UXZLgosCKve98xp1v82dfNf70Ht+3k
         Q5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749561887; x=1750166687;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NCtBvon4P5ZoLAIsR1nAgUCi/L9tAHBCKKDYzz4kE0A=;
        b=M8xlvkwp8IJJKcFSJlqrVQO+XGTD6LXvs9iHNaZY967Bz/ulUDHmz+HPdV97C5qbSQ
         mjsKzmfc+NxQ9Wt1rta2t4ydGod6RProVoKRJyyn2W0n4AT9TicWErZjakrBKF4+TynM
         7MC1oItiULvi4PODabLy/I8+Aok0SKIjaql5hisccN0JDjKAgKr76yWoV+83X5A7pHeL
         mT4omNwvK3IhQi21Ei7AItiznMRk1duUqYn9rHA0LIaFzqYV0U0IV51VvdWRYPDJWODo
         4BjhDNnShDra9C+SsLJeyqBbD9+7XEr0/RR0OgmE6aUeEWhhZsXE2oRlizdVYfaO6V/6
         hwiQ==
X-Gm-Message-State: AOJu0YwmPKQVLGKRbqIOWuwy6Z2MWBQ29wlvoc93UcCquCn6yyr5UXsx
	p56YrtRY1DEQDJoFV3Z9IXOeiQnDKHqqrnMWzQYjeRc4l8HjH5erzypt
X-Gm-Gg: ASbGncu3zGlc00vtXJzHQdQ67mozyMp3JZAHqutMvhBjTgZu1hI1Y6dqLEaoUQrQA1A
	xxRmiARvAm5MEZoKNTQ7Klsr88fYDlrnt1oNQRlx86L/oiVVvOIDT+zTPIniGHt/McwWGrNxLYG
	jUZgd12ssu4/1LlJEQqX6ZEi5Jo6W7f3GNXWouHSaSeUZ1Cqpk+QjeT0QZgVIQpwr1xi9e5sppB
	DKpuVldJlQWmQE2oqZ8Qdu+JUQ/bbBHppL/HtBwWNJHjJtGewAtAGzG/9g/ACuy35cDCqpei/t0
	iBUEuIfqgDdyhzJtZqFaCXXs8wvqNuCoAyMEao9k5PMI7AkYXcpCu4TGkdXrhYJ5tWdtClsniW1
	o9coAqMv5wMEgjbkSruNWIay10NC7nfWc8NZWyHaYNg==
X-Google-Smtp-Source: AGHT+IEuZSnOWSbt0+E4JC7iWW20iM779SPzjohDhtqGl9YcT6YCTLwIWNoYmVqo7FzWk4WKkPkLNA==
X-Received: by 2002:a05:6902:128b:b0:e7f:7886:d4e9 with SMTP id 3f1490d57ef6-e81a233aad0mr24173134276.33.1749561887455;
        Tue, 10 Jun 2025 06:24:47 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e81a4157f5asm2931243276.34.2025.06.10.06.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:24:46 -0700 (PDT)
Date: Tue, 10 Jun 2025 09:24:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 maze@google.com, 
 daniel@iogearbox.net, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6848321e71ff0_3cd66f29480@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250610001245.1981782-2-kuba@kernel.org>
References: <20250610001245.1981782-1-kuba@kernel.org>
 <20250610001245.1981782-2-kuba@kernel.org>
Subject: Re: [PATCH net v3 2/2] selftests: net: add test case for NAT46
 looping back dst
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Simple test for crash involving multicast loopback and stale dst.
> Reuse exising NAT46 program.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

