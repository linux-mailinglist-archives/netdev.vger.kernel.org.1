Return-Path: <netdev+bounces-109637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342192944F
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 17:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08FB1F2238B
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7513AA31;
	Sat,  6 Jul 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="jaLGGeVf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2353A93D
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720278068; cv=none; b=qFOUCfIfqdT95HJgQhnnowje7gDq3EJHgpzVPgygoqlQJQNwWqgcEQvz/qcQ794TVcN7OJjdzyHwTPVYUtLGsC7xULF2FbCSiNC1o9Hrhio8ZF38UiLI8XG34shnoQKUTYSJJZeJ9uKTu8f52hU7TZ6vXR800QHYljjrQNmuVgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720278068; c=relaxed/simple;
	bh=jVeX7+4IUBGnV02niKmsaWbyp3kHVb8dzcapvBBZ2zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tp6FvRaFh4B2m1HK86NQtHzXpZk4kSFlX4Xya8a2WECUQQmiRuR31lmjiqiKjY/3Iu4sAnuYtqwiSLq6/qpqstdQ7KZkyRgP1QCMZ8xctw+2zt9G6hed+ORMTqYRAMLgjosCE6yPddP9Y6/wvM8mVIvKhGb0aAXw3NrZPGFK2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=jaLGGeVf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fb472eacf4so8887495ad.1
        for <netdev@vger.kernel.org>; Sat, 06 Jul 2024 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720278065; x=1720882865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAWYTvtiIY8NcQkOGzbhh7BtEaPH5yqjahYON2y5z0k=;
        b=jaLGGeVfqdd+MmCbkKVeTgsP7GNHgrNH16gI+2+KDheMavRV4SFmBapUrTEhn5HTtK
         565+fLr+ow7mbkNLqS+J/N/66aIh3dodAMe8a35Xm8cp9+cD4sTl/niFqjCUFlL5PJFk
         0AtIY82ffzc6s4HxVuUFym6Gdp9euHpSypPt6V2cyiaectfJ6VGTPD3oXoZXGw4fwxDK
         BAx8ndSjrT6orsL/bFuZqHMwyqIkb4bc/Gsm3yqDcHSmPUpP8G2Iaha0rrP1cfoLntL4
         hYyhGFOS81unXYAoCEpsVlTjGsoOh04rrwrrOTWNcMFrdwE8fRo8kzCYq5FarobdtD4A
         MhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720278065; x=1720882865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAWYTvtiIY8NcQkOGzbhh7BtEaPH5yqjahYON2y5z0k=;
        b=r8//NLSsHZMWpTIm3nc080fF/AXk/+aE64loBeHSzRF1EoaUPShXsEBuTqjDTtC+yY
         BylTl/Nu9Hxl/cKt5gsMt5giHiQzVcYjXxs15zDXEFZ9EOsZ+VoMNcWpgVfP2Wvt6w8R
         /qxb8KAEcvZWRFasLW4Oj7J3N3vSZxm++/blzeouN9DnvG4i8j61aEJYP1AKgak90Hw9
         kGz9Mb3Sa5JPkuN5uHfMrv61BAWGrghTTBLqQImI2AAXFvBL4Kqsox9nFYcwRjFv5zLa
         nvuov2byxbRlCTaB/p3HtYoYYYID9mcTx2Bp5Jl1GbH2PoKq92/Axt4del3GPysus1C3
         8m6w==
X-Forwarded-Encrypted: i=1; AJvYcCXrBTbP6Iam1A8JWwpSWPMQvSYNC2skLpQTigtaaIc+PQNK6pFv59FWhfWqgLg5hc9pngU3geqzzYELQT+a/MtwBxeh+BS1
X-Gm-Message-State: AOJu0YyJxPLL30jwkPJFh0RI/++HPUvlxlqV3BFtGkzATUv5/CAfI+Xb
	Yb2oI+c0tOwDJDYVNf9pdM4DwC1ZsYiIDAS17l9Ff02kcSqCwMoAqBZdZLTkSgM=
X-Google-Smtp-Source: AGHT+IGwCBSy3RF0IVxFAlZD1xI+vBHVcZRITuvom/R/MEJ/oDNKpMkh0Hy3QEU+cB6HEzJWJKAqaA==
X-Received: by 2002:a17:902:f601:b0:1fb:6ffe:2d72 with SMTP id d9443c01a7336-1fb6ffe308emr6728465ad.30.1720278064724;
        Sat, 06 Jul 2024 08:01:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1c78sm161360025ad.23.2024.07.06.08.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:01:04 -0700 (PDT)
Date: Sat, 6 Jul 2024 08:01:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: jiri@resnulli.us, syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net,v2] team: Fix ABBA deadlock caused by race in
 team_del_slave
Message-ID: <20240706080102.1cccb499@hermes.local>
In-Reply-To: <20240706041329.96637-1-aha310510@gmail.com>
References: <000000000000ffc5d80616fea23d@google.com>
	<20240706041329.96637-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jul 2024 13:13:29 +0900
Jeongjun Park <aha310510@gmail.com> wrote:

>        CPU0                    CPU1
>        ----                    ----
>   lock(&rdev->wiphy.mtx);
>                                lock(team->team_lock_key#4);
>                                lock(&rdev->wiphy.mtx);
>   lock(team->team_lock_key#4);
> 
> Deadlock occurs due to the above scenario. Therefore, you can prevent
> deadlock by briefly releasing the lock before calling dev_open() in
> team_port_add() and locking it again after it returns.
> 
> Reported-and-tested-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
> Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---

But if you drop the lock the actual data structures might have changed.
Usually not a good idea,

