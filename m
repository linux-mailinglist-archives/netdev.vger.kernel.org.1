Return-Path: <netdev+bounces-175156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51225A63A26
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 02:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AC816D572
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 01:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEEC136337;
	Mon, 17 Mar 2025 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICzomQ58"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870B2FB6
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174722; cv=none; b=ZNk8Av/7PZWIYB3LtOykPdswk4dLbsb7ej8wOtj+rY5R8Tolfz0ZVkSiQjLvDHkVpIh6Am0oARWf2AraGOsA29c5mz38pD2oh4bX0zs0vVRzr9eYGyGs5f9oJo1e9KRoWThz9OtxJ9q1/CC5Sm4Ma9D2olpxkJ/4Any/SirIwkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174722; c=relaxed/simple;
	bh=z2j4KcJQv7zmf0c5iq2uhZ0gNgD/LlN6plFD8qvMa68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3gIKtkzOpjbxhU163SkIcNdYkPOzjlSnc86FUVxbWi7OlgiOL28+9COze4Mickk23TLD8+RtLWUM0YQXZf4uASUIRISgwTK7IDaKJa8UNWV4m5D44XX7pnErPbM6G8UQK6QQWJJF8wDFqxCkW+WuA9u4ckDCBb5Xlqzx5fdaoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICzomQ58; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742174719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2j4KcJQv7zmf0c5iq2uhZ0gNgD/LlN6plFD8qvMa68=;
	b=ICzomQ58MBgRwCTb4onufFl5uy0tSdeRRLR32yV5VdC7lFQHc7JVkYooX5NOaqK2mS1tlJ
	rpeiJuGO9Hd0QogC6HyWe0yQ6kUSXYoVYLPS9Pe/sJibqPWk8jhjGtjeFokKnHZ6NQDO3j
	HGRH1LdQvG5IWpMmemL95tGOK0rfVWY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-AlzFTr7iP_G-ojPzpsp5hg-1; Sun, 16 Mar 2025 21:25:18 -0400
X-MC-Unique: AlzFTr7iP_G-ojPzpsp5hg-1
X-Mimecast-MFC-AGG-ID: AlzFTr7iP_G-ojPzpsp5hg_1742174717
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so2166384a91.0
        for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 18:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742174717; x=1742779517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2j4KcJQv7zmf0c5iq2uhZ0gNgD/LlN6plFD8qvMa68=;
        b=kvW9PFErt89wHOjLBYFtcjT+G8EZNIDvd7a4bqYSB6WhS3JEBoAD9zeeylDHmc/Jfy
         iP8TgkhpLJEK+d2zp6y2jbKaTir084BNS6OQUFHR+zGHeLhFuIQTcekbm/neiDESzqQu
         ZZTZZTGsvHwzSPeGnA1YHW/ThftDqAvk31B+tAihgbr7hy/ajYd00eu1OYkTpjFw3+rA
         5adsZciQcTmXzCa6RLpQLsSSM+LxKTHHOnudjOk+6Ln7HBDS2o3wzRvSY3O87Xm/MReE
         JIER87CqcqWsCDI+pe+lRQm/+pS6mv0UB+J/lu6VoWnSSEMYYmK7ezJLeG0wh4/0+20N
         WMQA==
X-Forwarded-Encrypted: i=1; AJvYcCVUMVzqiXRJuG6yZ6bly+/D8wAqitlK/ZCw9Tm2QUdoAqzOMQNvtcb7ZGDIzCBE3PGYBeQMjts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2zy79FbBbtpSBwn7O6yV+wE9criSB9Xllt5QNxDzETAlPlNb
	67jr3zjzuR6CGZbkWy2sVDItLHO7YQCOxqIqwhDGoifW6BMFq4bf+jqS2dQBuxxIrZxEWvcTbxA
	3erQrUzTZLLHhsvrEjp8HiJC2Tb0dMnIXdbrr0EpC/XeQBvrF7JKJG3CjA6sZnDy6yazL6zK0Bd
	mq1daHbkmleewNEhKpCnKmWgvwAohs
X-Gm-Gg: ASbGncvcIzeevL6doyAvs8y6N0p9chKkN0z/zg2I5g9Z9b8AVO83jkG+XZir+eCSaAI
	lJqHjeOZ5A60Zuqpm9sl9X2ax6pJ7mo8iK3GN5MA7eMETmGeVUGx2SmMXiIPHw+gojLtkCgwpXw
	==
X-Received: by 2002:a17:90b:1f90:b0:2ff:4e8f:b055 with SMTP id 98e67ed59e1d1-30151d820f1mr12979534a91.35.1742174717400;
        Sun, 16 Mar 2025 18:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhY7Q6CEBtn6gSdQV7+N48LRSWSFUwUYTebXNWN8iyFQF0YN/QWMy1GYMr8eTv0NQFETp81q/gb2zZs+fo6Uo=
X-Received: by 2002:a17:90b:1f90:b0:2ff:4e8f:b055 with SMTP id
 98e67ed59e1d1-30151d820f1mr12979510a91.35.1742174717010; Sun, 16 Mar 2025
 18:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com> <20250313-rss-v10-3-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-3-3185d73a9af0@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Mar 2025 09:25:05 +0800
X-Gm-Features: AQ5f1JpE0rK7CwWDqP6FbtvINFxO-X4ILccNQzNMTQCiB6CvQEMSnvUz3v4UdcU
Message-ID: <CACGkMEv8g6JNvGCy95x9jRD893qBvhztkCzBy9sFz+9N6A69Bw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 03/10] tun: Allow steering eBPF program to
 fall back
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> This clarifies a steering eBPF program takes precedence over the other
> steering algorithms.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

I think we should elaborate more on the advantages of *not* making
this implicit.

Or what's the advantages of having RSS has a priority than eBPF.

Thanks


