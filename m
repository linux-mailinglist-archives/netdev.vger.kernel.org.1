Return-Path: <netdev+bounces-209010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB45B0DFDC
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B157B7F53
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D111EDA02;
	Tue, 22 Jul 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cf9Gx2sd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1C1F153A
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196448; cv=none; b=X3y3TCJskhZwkufEVKuaz1N2cQpLoreprJaoczGq7YFL62pCyD9M8z9bwKtL+NdRseJxJwYQgmXYJZ8TTnvtHqBynFqQ8G4dE2M3NXHlXg71cfdnjEg685O5dSLYWlvOuSNrokEYPUTBTE1MnRL9cqGhqtEYWdD6J2dp9USxQFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196448; c=relaxed/simple;
	bh=+nxKNO4a2BCMIJuvj3w0sl1mqftW1a06HRS7ZufxTrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiT/Q24MoraWjU5Ay5oJIFLEfskL07b5yJxFW3+JKWuDp/0uzUkfQwPMnmjEDhwfuab2yQkDP3NXNk53VnPg32Yb0Piu6XT5dJPJYSfK2njIpL3N2DCeZxTp35e5KBV8d+2ER5IfyEmNP32T6Ql8OivufVGQZ74vJNkySKzebzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cf9Gx2sd; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab92d06ddeso81140031cf.3
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196445; x=1753801245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nxKNO4a2BCMIJuvj3w0sl1mqftW1a06HRS7ZufxTrM=;
        b=cf9Gx2sdyStJE+YMWgPgdXtf5biIFwX/eV560qhIit0bnkKdh7If9YHYgHTyxkmMTL
         XWjOIOtnNDAbLIlSLX/cWcd1lsIDOW1akSsS4k35pwSB345qQC0zph1G7QytBnAYON8C
         nFlrgbP9A2qvmK1y/D2SjJo48Je143WoIKS5e0s6PNXR3ZE7msbikKyAQ0KvWCPmmF4a
         ggQ+BOn6aPZ9KOXoFnKsZpjYSudHIyNY+owXDyfcGbaOw6mtYwakjmbO9vgrtYYlK1cB
         509HyQI/TIAv3w2lbJilk6hgd4cgpq0xOdlD2oE2lGAE92V3qbwQDTwzMVumfar+IhXC
         hChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196445; x=1753801245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nxKNO4a2BCMIJuvj3w0sl1mqftW1a06HRS7ZufxTrM=;
        b=AYYME4ozWKPSArE+a9NpdgA4FBz1JIba9hz7tq3NFW85PRvn7Yno9u3z/bO6O7Emfi
         HioFu2+WFrsCCvHK7PrXPXUJ3Ms7aHdBvJbTdFx1JuS19gf3yxsN4AOPHaokHUFbXB/g
         AZhL3m2G9h85Za5LAT/cwVE57jDNhDKbqWItJCEE8Uj87a5oPRisTcKLK0R8tG0Icsnf
         LUL7ZElWmXnFRB1tdb/r3fRm6Kg+/er+I244zD7tx0ygSxnKpGoZ7tNIwGKrrkyaXWbl
         YXZDtT6Um4CMMXVKfYHXk8DvzlWfeFyT9sSUB5ygn4aioDtOLNgOi08d4EJ6iwbA/t1w
         x9Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUO4D9GNVOQPk8suS7N0ZGmHbAxgGv3gU6F/kpqQzgf0rpHoLkhEkmb82Wq9xzK7cB63aNt5X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFLurhfACeTceLBGpVquoSt2x9MpbDrS04Z0cwmxq6uNoZmHG+
	W/7dMhbA2wpgNuiksA4OISKClmAjBlUqlaa9F59Dcssume2YNRiKJHQ6U3sbquyrMBsQwi5rspU
	+aLvrjFIcpPWUGr6iy8f9hgmKFPqgqxTprrVZkIrp
X-Gm-Gg: ASbGncstQ5i/CyBdjIbeFjFYiHWrhyK0g14qhxi1Ly0uAAKBWHlUlhjllx7oFJCD8d8
	T30ggZZpHCm6Phwm+izljFw3cjV2IvV99Rktdd7OrtYSGDqBnRF7YPvcAXXGpb5GERVjfVog4fY
	JGG5LNcL+KBKOZyJ4+19USeA4rQq+7BH+2kCIQq+pN3WCjAtdXHdTj8VKaFPcwukBg5L4HbfUCz
	4MwuQ==
X-Google-Smtp-Source: AGHT+IEAwdtOOJZle/vAWN8RPtXy4MisNzaqxiiiStWuk5ZuXoX4lqwhlAmVuPypXJlxrGh34p2aRu8UWxGzVff9IMU=
X-Received: by 2002:ac8:5d4c:0:b0:49b:eb1d:18ad with SMTP id
 d75a77b69052e-4ab93dbed7cmr385323141cf.41.1753196444364; Tue, 22 Jul 2025
 08:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-12-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-12-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 08:00:31 -0700
X-Gm-Features: Ac12FXxzCSficlnnF49FJ-AwqyidP1dhOSx-V9OvnBpoHWZaDg3cQQfRkuFyMag
Message-ID: <CANn89i+mvoZ4rqtow2SRR0ZRB9gS4an9syCLuXyqcW=4-8Ek4g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 11/13] net-memcg: Add memory.socket_isolated knob.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Some networking protocols have their own global memory accounting,
> and such memory is also charged to memcg as sock in memory.stat.
>
> Such sockets are subject to the global limit, thus affected by a
> noisy neighbour outside the cgroup.
>
> We will decouple the global memory accounting if configured.
>
> Let's add a per-memcg knob to control that.
>
> The value will be saved in each socket when created and will
> persist through the socket's lifetime.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

