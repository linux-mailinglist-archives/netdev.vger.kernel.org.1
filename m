Return-Path: <netdev+bounces-197411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91EBAD8957
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F8B3A4691
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98D82D1F5F;
	Fri, 13 Jun 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FlyieHba"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF52D25A320
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749810039; cv=none; b=uH4mZSDvpXerq7XoK3z0TRWDcUcHiFSBxQ+JHKd8lji4zqQRevT/UxbTEPZ7msDlxeBkr/Xjjle7/QJFj87ngLBsiyEqe/sY019QnfE6mdkRZj9dDX6Mj3YYjQV0TrfFMUJOnWfiJCf9NwRbKoO7cXTNMNzVS+Hi5ySdUju73Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749810039; c=relaxed/simple;
	bh=wTDvkTqqquDXKbIGU2O17oiLClKHNDwoOkXGQVDycvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhN7mqn68XG9DoH5ZEEwxYdjbS1UUwioAA8cGOhfp8pOpi2Vi4MeZVhSLvFRigb52sVEQrwd/PoFXCVDiayfsFtcaaVvUltkPoVJJosq0Lx9d0nSOFvHfFt4y/NDJhOnvjAsTXhYCNBINF0vcwRUgKPxHRpWoAd6oeBBowOT/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FlyieHba; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad8990ad0a3so29472866b.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 03:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749810036; x=1750414836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2H8yA5klxG4PLqd7e+FG1lHucZWSI3//UG2RyPUekJk=;
        b=FlyieHbaZuiN/1P/ut6o+/fbCC7CZ2d/KCVXhOChO3S2MvM8SL/iAb+Y4JAa+XGsYu
         OWYjuHALRQDoYowUyTBryG9fJipfb+3UvOjMsfa1izCp2oC874qifcoCGgC0YKur6Su4
         BNCfGTz/IJkT1jaNMD+/zea3Fl05Lfa4bejWlDaj/u31YWPdN3ixqEGM6H8WLeC9T15v
         w3bVpgun4NsBEpo2iEG/zx13GmNXTU/NnxUGd4rEpBr+Fonm/Yw9qAoukYvkPZOYiVcq
         Tan2xmQdeXcjT2WBIA2MDxCtUWCovOXeiXCW0u03Fr18lLz5j+HYMJ+52tii11R7akQ2
         vJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749810036; x=1750414836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2H8yA5klxG4PLqd7e+FG1lHucZWSI3//UG2RyPUekJk=;
        b=KA4gqapHd4tXqzNcQJiTAqtqCAhdPYtmEOxJqXI2Idzjet32uF6TtiIVTnin7uuEK0
         2dZlyTX9EUtPaT5KpQk4lj1VbQA7eyhWqB585h+6o0Uq7i3dSPQv3QF1BN+wQfWYyJhu
         mJSAmKDcsB3AcL3PLAZpLaCNUxE61mhrKGIdEfF1DAB6t6izBfSrHA4P0Km4N/ZUCsXP
         aQuS+YRxE9/BcrsQ0307kLHh5x/XaNLbl6qsm6t0Bw17zPg8KETMqBxL7q/KkoXqv/09
         IdHYphGoT7N4RCv7EKtVw3dlR88Zzx9HFIHACdotJaltfiXBRNP4WNkG9lh7pvi5ZIbL
         tI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoVwzxJNWzPEY+uUFN9z8Bkm14zI98biI5zxCMFxVx1PMsZJ7pq/AarsQPyG17eO0wxtM5K4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw06vSp6UrNJK/6bUzvv7QhFVzXRTHP5Cd92hlnZU3mUUIHuhOh
	utn1IVU++CMyHhbZan7qXM53Sb626DYgqdVFg0yAyOgWzZRfK15V1HAxHFjxfFJ3pxM=
X-Gm-Gg: ASbGncsWSdSiWJD0HU0LxOV7Ud2VnROgz8JaNf6liPMZ+o7MybbkeYCHfMNkizY1hxC
	MvoPJtP8TzKC5TaX0mk4vXdEtWoHDMtxB+tl/rrsuyNDy6TftFyERpVHJbam5fvI4Rhm2rPHI+G
	JVuqB4nIjSBoJ+lQVqQr4CzTiGfsxRpu/Qh5ElZnwrkmQtiYX2cDDQ/FQX9WtcM4B2DuQ/0uoGV
	c+Fy4ooNXsHRFsbA96QBFJki17flwLZ3iMhAmR4u7UFV0x6CHfDjczuL9vvjyyQiP6PgvMBA3C0
	gpmWbaibihspsGEhJCaM8T69vbzqlv7XENgMjFdOpbgWA+yankC3LNQM6B3KD25ZVyRsiheZPfD
	5hy/uEnnmktfQyqFHEQF11D3azOR2Iw+u8Tn6gA1PkDsrU/6XPDFL
X-Google-Smtp-Source: AGHT+IFtiBQ/X6ly+rGpLgdRP25eckbTqMqUzpUwaD9hI53mS3aM58ZgMPHaJfNcKCk2EZT+YK3ghw==
X-Received: by 2002:a17:906:478f:b0:ad8:87d1:fec4 with SMTP id a640c23a62f3a-adec56870a6mr80663466b.7.1749810035936;
        Fri, 13 Jun 2025 03:20:35 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec892cd85sm103095866b.139.2025.06.13.03.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:20:35 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org (open list:NETWORKING [TCP])
Cc: David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH net 0/2] tcp_metrics: fix hanlding of route options
Date: Fri, 13 Jun 2025 12:20:10 +0200
Message-ID: <20250613102012.724405-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I ran into a couple of issues while trying to tweak TCP congestion
avoidance to analyze a potential performance regression. It turns out
that overriding the parameters with ip-route(8) does not work as
expected and appears to be buggy.

Petr Tesarik (2):
  tcp_metrics: set maximum cwnd from the dst entry
  tcp_metrics: use ssthresh value from dst if there is no metrics

 net/ipv4/tcp_metrics.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
2.49.0


