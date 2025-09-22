Return-Path: <netdev+bounces-225440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BB8B93A70
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2451894EEC
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87152F4A03;
	Mon, 22 Sep 2025 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y90a5Fb8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361632C187
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758585402; cv=none; b=aU76YGPCnCMvgsCVCekUAYGGqHWgWrNFy1HvPRRPO3xhc5YbYFknWW8VtnhS6xMudc8YdCgSYI1Kpiw1+D+IJmRDpdE/tWxNws9yUD4wTIOEpxlNCujB3T/uADZwa8Wk4nVZK0e/7HPNmqxjIzP1vWFGnAQ0Nk/Z+YUqAxMaWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758585402; c=relaxed/simple;
	bh=lUVNUim699D2pSehdz0uONhBPvRLCB0gZ2x8hvIHyr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5xn4Jc2Ay6OZ1Go2jyk5Xkx3RqJ4jwUecE4A29gWdbOSeEkdzGwiHUseqFUuoS/lHLRGMT7ZAf91/5TBj0LXrWOk6nKln04NNPyghRmZ0mZYIUxEgOVwXWy9zFZmHAtNHgta4YfUvl1Yq1CLCXfUYw76zUaDc2q+I6HuWbkBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y90a5Fb8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b551350adfaso3903340a12.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758585400; x=1759190200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUVNUim699D2pSehdz0uONhBPvRLCB0gZ2x8hvIHyr4=;
        b=Y90a5Fb8IPKuksW7v1xPaISfe4xK6Ig8JGpUDkGmYLCbOLcYsDWdoP7eUx4PEoC+J2
         /FY64P7VAxsXC4MyGbjj6OqzeCN5iOA+EDMN6G7qtH/VNfR3G22TJDiFYYavm16NQxxZ
         TRH5vA4VyEEC6IDpDGiCwTI+gFV+P+/bVkamD/WaurApVmEPPt/KvwwyKgqaN2VpGML7
         JWzxGD/ETue+FWRjGEgK/FtXdi5U8QtCMkAZubLMoYakNnOaumutmVpBeFU2BMCuyh27
         9GI0rQRS/jD6D8Ena928goQdIe2K3oOlOXhA9M43ntDOYN7j7xF4e0oxV0cpKdOulDaW
         JSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758585400; x=1759190200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUVNUim699D2pSehdz0uONhBPvRLCB0gZ2x8hvIHyr4=;
        b=o29ALl3N6rTNiP70HFtHyLaKNmNAtwFjJWhJ+mCBe6cpFuUs5DQjxyLLACgHD/IpmX
         Ufs0ke7IlDW2p+JSkKgjtar5nmWMgpi4QwORhQZnuVtyQDu/iofH6Rcq5htSLR8KKfVw
         Dh9sgeysdnXVDnRM1YwxU3afQe3bm4fTtSGbTR+X5BSEeUJf9Qs3Veuz+d3Sfdy/Y0LZ
         b3RH6kJwWFfCvV1t77IfYVRITb/BkXww1Tc6qGOnDob4/naTobRNmLMAMQXhGrTAmKq3
         0MhE7XcRLOiWeLik9cvh/dBwOyb7ReWejg0UOWA0SVcnSI3BQgnHOhQKQWje+5Q94vYT
         YHpw==
X-Forwarded-Encrypted: i=1; AJvYcCWcH20mVCljdK4Ii8ces8jC+8OAsaPdTOX6RSbjuqXCwVnKNoWwat4KdRg4NOELvGT/kzh6ZsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDWbogLq9LAY28RUwvDfDCWVc7vZb0yvMxd9O7OOAkwsCUpZUR
	gOGYgZCA+JNcJJf2x8SgmLOMsswkzXtsUgkuIT4RCj/LupkKwxYAI81C+VZvZH9tCwzblezI1Bn
	ETkckt8wPx2NB4jCjInv8KyljxmoZFLXMySVd1puc
X-Gm-Gg: ASbGncvP0RGSouqsl6h7nOFLwlaY0+tS8bi5ZN11swCqJzGWtw/ppEyRtIkxCsvtOsJ
	iIuldZqXOqfvxOjW2eqJrMBXV14WyqVYW6LpTgZJf95U8ECyhHqyMev4A1af4wpKIG1sF6oV/uI
	T1iSNA7WBmVyQ/OpX/kt3OM2u0RqHteWM+W2MAyVTyWVz4Zd0sfaqjL+aHRYJiN7yGk3mL+tQIe
	0FZkk/VkMKrTixF/0DnrRGaGW1IYMxslXEGqQ==
X-Google-Smtp-Source: AGHT+IFr8622ZNA60fEnIpq5SSUfRj55NZPJHcgm3fnFKNsz7du8nJp/ZB2zpMD425cbBy/obySl86UKQHmCjqJcsOk=
X-Received: by 2002:a17:90b:4c45:b0:32e:a59f:b25d with SMTP id
 98e67ed59e1d1-332a9705e25mr875509a91.30.1758585400323; Mon, 22 Sep 2025
 16:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com> <20250919204856.2977245-6-edumazet@google.com>
In-Reply-To: <20250919204856.2977245-6-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 16:56:29 -0700
X-Gm-Features: AS18NWBzRqpGWStLWzou9WNV17sLpphx8hCjvebQKp9Z8AXzzfeXcP8ygniiEeg
Message-ID: <CAAVpQUAV9v04akO6w41TWbQWXy7qwvsOfW7Fc0A+sc9yTKdgKw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 5/8] tcp: move recvmsg_inq to tcp_sock_read_txrx
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Fill a hole in tcp_sock_read_txrx, instead of possibly wasting
> a cache line.
>
> Note that tcp_recvmsg_locked() is also reading tp->repair,
> so this removes one cache line miss in tcp recvmsg().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

