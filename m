Return-Path: <netdev+bounces-209702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06449B10765
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9B216B9ED
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2A725EFBE;
	Thu, 24 Jul 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa8ghlW6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE6525E47D;
	Thu, 24 Jul 2025 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351586; cv=none; b=ZcDbY1T0s72T2uOuOyOEm/UJv1UFq8gvwnuJvRZja/qyhlis785b//THxDAtwKjmmnMSXOLfhyQjDyY4/n7sM+kyWe7hM2JvsjJLyCLh7/VPA4G0AGuhMCD2rI0ge4shCBYuGdcfiHA3EHcxeV1lLU9JcqYJ+MD+2Lxgy7iPOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351586; c=relaxed/simple;
	bh=uqcAan/WHcwl+faf1cDvlJ3T6UYWofW7UzVI0/0cUzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJ0F2zGGnyC3yjl+i5tDA2YtLTlqBCXa/s3li+Huqp8M1FCxX5eGSiiBP5wRcmji/VI+6nk0Qr5POZWXaQFgC/aVrDlQ4bBY4JS6HMbw8aQ9hMIFbHgN8/c1pZByocvX5dJ15KxCVqjh6PIL6xVIuijNRlLJPpFrfE0nVHwC6Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa8ghlW6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74b52bf417cso593528b3a.0;
        Thu, 24 Jul 2025 03:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753351585; x=1753956385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PTtVikJ5rldJ7a0Bx4KyzH4Gmr3XIo2PlqHaVbjSgs=;
        b=Oa8ghlW6NvAzpIV6bzNb0mWfAJab2xojwStakEWsMTf0m2e255LGxBhHbm+X+5qCgg
         7QYBSiP6J0BbkaVWq9Ur9CJiBGqIbugjL6RNoniDmYlP9CroRjhNohdwVQOQVWYvdTRE
         83zM89tsNG3S5khyPINiwsj8dmI+u9u0dnF67ELWHCUSlljFONmw5S+iqDO7yx4EkXNA
         +4bYPRQGL1NhypyOo7nPBYUuyVlK8AHAtRHqtst8PWwFOCS1K+fqLYWuN+OSYfu2iBLo
         sk9hvfbThwcZXLUauIkof/jJpz7+LEmejmis35HMgn9P1p2gtIv8GQvx9B3FdTO+VraW
         5j2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753351585; x=1753956385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PTtVikJ5rldJ7a0Bx4KyzH4Gmr3XIo2PlqHaVbjSgs=;
        b=XgqF3Td53xf3LKO4edBPBWbJLznqv7uv4EQe5bEbsmmQ5SVqGqUbixy4FvY1VuTnL2
         OlEiutGS+ASNV5CfhPJmnpZG5mZfj/q4/89Ad/65rFXblItW6C144LpCKTMihHx3+wAz
         YlmjRtKzIlZ6Bm57Z03NdV7JZ83MmUKv8Ns74Cpep2/exGuj+Glb6Wp/vNl4YvqEjA9m
         GtzArJKyVuNmnMiTkU+CMX2Qxe2S14ciylwKmiOF2oCtUQLNwCGKMbP3S3vff4SKuixC
         bdMPmRoOpFDpk5Am7ZOMlII1esX6PMJNgSIMoYlra+b8UGetg6rpuY9eOeIxK1aMFsvF
         7kcw==
X-Forwarded-Encrypted: i=1; AJvYcCWUrjOPuPgE3pELcgu9PMTUxn8RWi4tkN5PoBoqf3oDi5m0TiuPjtMsp7NBsTPW0hPCyAoBVs1FMaFGoP0=@vger.kernel.org, AJvYcCXwq2gYX1G2Lz69AL2hTEIBKHxUSZwCyB45df3pTOoWnxQIsuH+1HymE/Xy1oLYO+1c+euXuY9r@vger.kernel.org
X-Gm-Message-State: AOJu0YxZSGoMlsRkQUKMJyoUr28sQ8DE9RjeZ/J2Bet9Gv0O79SJeoQU
	qv6Z2rx91lazgyyOhU+VVWW5qxNuHeF4e6c1JytC98NayNqCKPYlwOUp
X-Gm-Gg: ASbGncuF7tKXwFjtG+LmoNWngV+eGGi1FuVgaDVcSUGPtztLEOcYQqayzJdNbIr9jJ7
	qreM4ArN7YR3Hw7b7vLnH3uxvsniAtW4uGxrpudisc4ei89kzUs3LnZZREyqADAIZZ+S5/lH99E
	/kendTCErdPFD/c73Dx0IH4cVtEIwU9/9UETyK/UMT7ml5ijJmutLMXe90EzR5VpXPvRYzIfpNX
	M4CXFXhCFjbuA0VMwSKWdcxo8J5qdLVJmPNVSW5N5elv+T1QVzAhetH2Kb6F04Ck4+tJe7O3eH1
	xMI3Exvcy6raBKGGu3dhq0rq7OV/T3ZOh39RfMnc7uClOxF/p9zPbqu9vsEURpIeHty36aZGKvO
	qJev/A9FulfFCd7bNKiLCt1swQwvAe55CC9nQZA==
X-Google-Smtp-Source: AGHT+IGHBZVavTurxO5YvmggetR2PsZcO4wfnUG6mLgmBsI2k/NAxeY7NUsB8mzhqPMJDLCKaNzScA==
X-Received: by 2002:a05:6a00:14cd:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-76033b17f44mr9632273b3a.4.1753351584638;
        Thu, 24 Jul 2025 03:06:24 -0700 (PDT)
Received: from C11-068.mioffice.cn ([2408:8607:1b00:c:9e7b:efff:fe4e:6cff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761ae1588d2sm1230548b3a.41.2025.07.24.03.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 03:06:24 -0700 (PDT)
From: Pengtao He <hept.hept.hept@gmail.com>
To: willemdebruijn.kernel@gmail.com
Cc: aleksander.lobakin@intel.com,
	almasrymina@google.com,
	davem@davemloft.net,
	ebiggers@google.com,
	edumazet@google.com,
	hept.hept.hept@gmail.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mhal@rbox.co,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	willemb@google.com
Subject: Re: [PATCH] net/core: fix wrong return value in __splice_segment
Date: Thu, 24 Jul 2025 18:06:10 +0800
Message-ID: <20250724100610.6702-1-hept.hept.hept@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6880e365b84d2_334c6729452@willemb.c.googlers.com.notmuch>
References: <6880e365b84d2_334c6729452@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Pengtao He wrote:
> > Return true immediately when the last segment is processed,
> > without waiting for the next segment.
> 
> This can use a bit more explanation. Which unnecessary wait is
> avoided.
> 
> The boolean return from __skb_splice_bits has a bit odd semantics. But
> is ignored by its only caller anyway.
> 
> The relevant __splice_segment that can cause an early return is in the
> frags loop. But I see no waiting operation in here.

Sorry, I didn't express it clearly.
There is no wait operation, just avoid to walking once more
in the frags loop before return true.

> 
> Aside from that, the commit also should target [PATCH net-next],
> assuuming that this is an optimization, not a fix.

Ok, the prefix [PATCH net-next] will be used.



