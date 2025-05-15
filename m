Return-Path: <netdev+bounces-190815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E374AB8F2C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA494A757C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78608255E44;
	Thu, 15 May 2025 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTxPGPOk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E01263F38
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747334191; cv=none; b=KwEjBsHavzoN+zep9Hu+wQzeaWnVU8o8UwhYbuiQPU/qB5EWudIfj8U4IKWafVHsJ/ugOBgvro9PZP1EBSRFlPVVWK+ExT+LBJfdzBRdqW/KnAZJAidEVLozCyGHYVHSLO31PI8JNUEZK/F4nEOkWGLu2d1JrjMj8joeqmDwQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747334191; c=relaxed/simple;
	bh=RphQLpYVAnI77ltmge6ZB7SwtHmdzXN0SH9PhNxUAUE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iwfmTmL2DI7MWh90UWiwl0PQFXl1ph/jeM8v1MstFkhfc0Z/SJz8ZKdo8rxsvWdrm2D4AkT3zD7hm7AaHtRnEICJ/Rtp9vx6QuifGo6xVEFRULWWc2VQeSa3fu0qbWo6JQU5BzkbRo5QnvITKyB4O4m9JoBAUQM8LP9JTA5XgeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTxPGPOk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c54f67db99so263875185a.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747334189; x=1747938989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ne2q4yJBVlfesS6s6k0cFjRHjcVvid+Kh3+SjvFFyz8=;
        b=hTxPGPOk8aa7Rpnb65d1FIwfz0orWacvDcqtSw8gByo3jjgTlXbq5kSRpZWIed3z58
         8Ynw03o4Ukap01EU93puFLATkTtgOASeiNuPweX+K1Yn5jzFdVbJsWlUm8Qw5yR0wLNI
         nn1i6kOEhWypsBIOnpvvPECHfb6X+vKSeCompJTlbQc06w/OLIOs7tgpFm82PeCwVOAV
         V+i+GKi789l0ljxpMRQVv8NlE/EesfKIR8ZmPGG6NJgkOl66juaCIag6dGPtOruynq5V
         6CicsT2njhGL0HtUFKQTn4kbriU41TNUlhvcB9QthVdXYbZefohLknst4uXRXp7JLZCK
         wgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747334189; x=1747938989;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ne2q4yJBVlfesS6s6k0cFjRHjcVvid+Kh3+SjvFFyz8=;
        b=Yn3AgZg1yDdKPIZrTKEyZXLR73uM8YzrkYcPzWGK3gNVgwCpP8iWXHPUu0YSY09SxE
         /i+oZPXoMqrJrYiDvbHp2/w1mvENErfqU2om3IMsOSX3fa9iyJq3Qxn7DWejqzq9da19
         kkVburfULdis47ili6SpXBLo25KkiFVrq8PxWCrkJ1JuT4y6Qp7DEyjHyDAgvNovo5wj
         2svK7ehQQIIp6LOqnWGa/90b3QB65PPj68uBiFvkrlav1IXb4/9a7PNCZqj47jHeoRbN
         xYIMMqUnMJRbfv8id2WOBcTvhiRelny3CJiAFB4SOldduKDeFPrmn/lSsnVTM48tMYpi
         fS1A==
X-Forwarded-Encrypted: i=1; AJvYcCUsm3n1LHs/WB2sV5MTc+5PYz9SJvA3XRZYGORjFMLd3lUbz+aPpEOX/rH+q07Ca34rtbdqTSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqxhiap1svwANOj6Fv+9IGOPgX9N8lYMn/PPj4NQ95N79IGJfA
	Jj/ntp238hx2Qsn16IKhd/Efbym0G/jkNpwvbOQ60QdWtzRqWVzrSrnL
X-Gm-Gg: ASbGnctr2qW4gi6IzB4i8jYP+ahxpIcLLpDsfE35Npw5MeewVc4vvlqfrlorLrWs40j
	eznwV9w96w/N9Ls5ejKq9fMfoZF+LsF/Su/kUFrLN3OqBTIAFB2EpSx9b8ApsTWJ1/+7ewSZQWl
	qMP43oQ4ZgtSq2DCiwwIbq3xQbM9NiuU7Kg2I9qvTuikJl/dYINWWNGCx46et02uHehsovczHVh
	MVqbhEJISZm89LkyHvzSBAFM6r+Sf7E42nxcSTZPo5kh6aWDqmHwhWCMOdfeAi/lhehxpi7qKOu
	nFy+ZSzA20n/NpIOClFSLaXGGtFoi3szFqOrFvklSHQ1IOBYTlZU2MioDwkArq8IMl1Sp0zZmVj
	K25/v2kaeq8Ie587PxHf7fu4=
X-Google-Smtp-Source: AGHT+IHn3k5XxPWM8Csv9Zoval+sqpNC4H5+DvTkbRsasWUjfkCuuXxwM5SuATQZyL/qeZYaoZ3xvQ==
X-Received: by 2002:a05:620a:1d0d:b0:7c9:230f:904a with SMTP id af79cd13be357-7cd39de2503mr820983585a.14.1747334188547;
        Thu, 15 May 2025 11:36:28 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd467d7fc6sm17843685a.27.2025.05.15.11.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:36:27 -0700 (PDT)
Date: Thu, 15 May 2025 14:36:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <6826342b40a68_25ebe5294f3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250514165226.40410-5-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
 <20250514165226.40410-5-kuniyu@amazon.com>
Subject: Re: [PATCH v3 net-next 4/9] tcp: Restrict SO_TXREHASH to TCP socket.
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
> sk->sk_txrehash is only used for TCP.
> 
> Let's restrict SO_TXREHASH to TCP to reflect this.
> 
> Later, we will make sk_txrehash a part of the union for other
> protocol families.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

