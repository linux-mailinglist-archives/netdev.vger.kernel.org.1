Return-Path: <netdev+bounces-204414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C6DAFA5AD
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0E83A50F0
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12187260B;
	Sun,  6 Jul 2025 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek9p4g2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B338F80
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751810661; cv=none; b=KwkEEFI8XW6Cxre3+vTkVyvjlgQATmeeElVJk3EhsuC+/6jl1BIlGV1szxF2ctG2R9rOsIyN8YaGxkProm8OtA9IQczQl5TVYES3A5TuP/yAoPN6m8OYJfRpJSeuJLDCEgD0JY7UcnIxGKhMPx51KrSKk1WhlJp2lU4o9zzgnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751810661; c=relaxed/simple;
	bh=daVhVV4/7b7hZNVqQ6Tr+QEnwUg/o7CrEl3QInxJ2YE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Pi8Oog90IJIiXckNLyhzVlCg41iM9wOjZyKYy2ZcWdzcEjCW1o2lgTLIwoCjp6IeVcqDeCQRzjY2Ra+32rsu6ZWknt86/fDrEq554jaJorA2GJosmjcH+hI/31Z5n1WyKPDxqWkv33gDYoMf0ogt0p2CTofEGZfj5ncZr2DylAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek9p4g2C; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e75668006b9so2151993276.3
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 07:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751810659; x=1752415459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqgBsTk5ZjhRchinRfZ8KJvkqtTkih02E5+Vn6ouPxU=;
        b=Ek9p4g2CBe/yl1F9lw/nNPgQ/2Dp3GrFlePub2Rb13PboMYxQgzZ5oSFdA3wbBoRbs
         hTwgA62qMURgYSv4dlpKQhP+Ec3YLnqTz6BjV0QPwAUo7qYCpRKtrjGdKJ5CBqXiIJDE
         +QR69O2eupBD6BbN/PYHON5bk5nk5Y99sOBoKa9Vr8g3c7uIB/VSgOs234aALi8XpxoR
         dvAiaLZVyw+IaRrLpk7EE3kzy1cZretH09Ta2boWG016HxwUOWuzIzMRdRwrIH0lsHsw
         EQRqUebC18DA6NTA+xOxBs55hRAdWYJfXTFt7frZPG/HPtWdMWXs2bELi5hyyfTJm936
         zMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751810659; x=1752415459;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qqgBsTk5ZjhRchinRfZ8KJvkqtTkih02E5+Vn6ouPxU=;
        b=sUXn8usgjJu1MuarF4/8k458KnI6GKMs+/jpHiJoxF4BZSHQ7toIrg+uCt/s7VAKEI
         1dMf6F5XRV0EphVfDagMK95QobybTM04LqTLLai6MeDwftUZ5LVC+IMw8wdWd/tmrmiX
         8bicRfU75dq3Hhk+csf8l05NHNQbhBRHAEdE6d/0PuIJcTuiiQcJ0ruc0gh7fRAh4YYD
         U2KX97oEQ9zFRaZ7pRLbnzMLFJ51g0n6A+2Z6/hs+hO8WvCr89jPFtsampQ00oPdQ2E9
         oRtfcRXigDu0fkGrsbLYF3rq6u4pIUDXC2HM0KRFd6/wfBenWjc07cohtcAu3RSPjhEK
         gNMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaQDwiSQBv1fQm6PbuZSoeD94Il2i686J/IqNz8IuAPg9CLXdAUFuPUP2MutvUPMIibnTtvJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvaYh9TLj4bOHgumbmCJr9xEBxmLD804lPuQNiaoeV+87h5Dq
	17RpPgE87x0tw8i+tV+aq5fSU3fhwF4Su6NaDl4YsjOILR1ogwiGf3tR
X-Gm-Gg: ASbGnct4o8beD1SUHHAmeT7+343/DnU7UuGA2U5TSbVKhkqAFPk2ZQm9Bbbq4RrT9bh
	zRfaKfojhaoC+Z2uVBl+MYq3ZM02gLIPsta1D0oY++S3nVl3h82kpPjlTfV4drgG/nko7FbDJj0
	HnbE8/dmWES+2QjAJ+rhGXZZGJrsVZlJZIgZVOLu4bfdjbosXyQ7C4++eC4V7s9ARYSeBo6/I2C
	bP7UhLlcwHoaEheJFfeBIJhZOnMvoC9EiXs9GceIlBdnWpYTGgID4Qryw85t7qDqebaBifGZGc4
	RDXrcM6vfjK2WVaVgHeT3qf9Lc1ocK7SZkZKmE5vDnmLR7VvUr7klQ2+NxbEuj0fW/gVI1yTNbq
	SmgDJbWQRyRHm8bwcaVsBaoV/532dWvmoqKFCgu75UXOGkWZR/Q==
X-Google-Smtp-Source: AGHT+IGFwX5zcuGNgMYuhzX3AngXRgqfOOvzkmV2PrF1+wzXXnWVesGo31ALhx+mHceorS2bBqgmYw==
X-Received: by 2002:a05:690c:6f82:b0:70d:ed5d:b4dd with SMTP id 00721157ae682-7166b699231mr107752947b3.25.1751810659271;
        Sun, 06 Jul 2025 07:04:19 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e899c440855sm1997089276.33.2025.07.06.07.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 07:04:18 -0700 (PDT)
Date: Sun, 06 Jul 2025 10:04:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <686a826267390_3aa654294e1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702223606.1054680-8-kuniyu@google.com>
References: <20250702223606.1054680-1-kuniyu@google.com>
 <20250702223606.1054680-8-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 7/7] selftest: af_unix: Add test for SO_INQ.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> Let's add a simple test to check the basic functionality of SO_INQ.
> 
> The test does the following:
> 
>   1. Create socketpair in self->fd[]
>   2. Enable SO_INQ
>   3. Send data via self->fd[0]
>   4. Receive data from self->fd[1]
>   5. Compare the SCM_INQ cmsg with ioctl(SIOCINQ)
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for adding test coverage

