Return-Path: <netdev+bounces-184120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F45CA9363B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE191447367
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B5B274659;
	Fri, 18 Apr 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZQeBz9R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE42741C2
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974000; cv=none; b=Ll8U6+HCpxPahT3DnLHAW02+2W6yWfLYXUpf1JQT/DwL00E7z1p0j6lKHRURSsp6jS+STwCEorqAXFvMA7g34xPcIa29EYkKEqJUMGIPLGI/3kCfotyQAXIQDioJO1zuiZI2uXixmsCxw110FntO/TM272UrU5HJtcj1mj8o4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974000; c=relaxed/simple;
	bh=ZZJi9FWvfDeemiqLog1dYPs63b9YfTm/6HUfx4sdddQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=fWT0+Ap2r7d5rBuzPamPZ1L1hVbljPf1ivI+IZI9z2e1MFgDK0ZI++2dB6uEUTgMlnTC3itCQzCxBYu6PsGbQTB32QmGpw0QP/xGu638zgA8vuDKv8LZ3jKCfqJxHP7KpFo71tUXG6k516dj1PciuZNlKcNLJs/BGOOvWdf8b1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZQeBz9R; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39bf44be22fso1189212f8f.0
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 03:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744973997; x=1745578797; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XldNvecDk9vMY6D4ocLxjIX0trtOHxAUTnExLdve3mc=;
        b=YZQeBz9RyDScwprX49GLKK0mkXZtoyNu4vj+GepTLVxVZ9IzfRdgSrf1HGucOWAhIO
         bvf1A+5Lldogsa4gXQsOJPniHgCbUwSdlzxBBmYjpUp0levVBcTez+sOqApBd+c/ROB1
         EnvY63KetQzqi229FsjCawNsNHuawYtN1pVAtqH6kQSTrPrhFeH2lT1/ssMBvXcypxsn
         hEuFEWdU3Lgk59Ag1uGC/T/05vOkGueJjrUM2yq9oAKXpLChkxRqgbqcETD4Eq99vPAj
         qUK4PKiAiOHuwqY5XK7vsdsYnZdyeRH1i7TPlvZcAv0qg1St10sWVGbWRaxILUgBLADh
         Q4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744973997; x=1745578797;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XldNvecDk9vMY6D4ocLxjIX0trtOHxAUTnExLdve3mc=;
        b=Ub+Mc3+lny4Zl6/kAk047N2sCCLX5Q3A8Fju24xAGsJX4GCA+rxD28q9kVvZl1Khih
         lFnTZQk33/4wcuMPv4DF8CwbEc691SQB7q4Lkh9HjVGGIqyWLi8TODk/CW5RlvAYqK/I
         J2PYwKGIQ4SBeJGgEBRoVmMY6EOtsGmy4/8b3JWflpz21J/+5jcLQXrZmQxMvnGO8O2q
         8u/uhuWNMfa+8HwEWZgHm1Q+7NbxZCuQVDEbGOz7J9eQ5J03+DJSF954BxhnWiRoRIOE
         46QP5/wdFTdWqh6AvjxXBa9eb1IdJrw9DD61NPlFYtzxUO2YFfWjGDLSyj7RXc7mSjKx
         D3oA==
X-Forwarded-Encrypted: i=1; AJvYcCU9LMU9N5U+rGHz8eZDEF2uMoqneSmgM+5sYXqOT4c+F22v3PQ2e5dWi5myj5cgTSkUL+S/fxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8BSfm6kss2uZo0leZ5nd/rxI0402CCf2qvIzm01ACjFP8JEd
	r70TU+VxuPPJKr6fez5Yqhnqqc38vN3Bdeszk0pv3DlmQLPT60oY
X-Gm-Gg: ASbGncuGwXEZg920M3mQlaxp/ksno+YI98+6B8XZFJqlWTHUA51zpvcojZiL1NyFIAS
	ny3g9f64nV7Eyj5uUFwnjptiPdnAvOeEZfPaV6M7BscYJtSYSYYhUOY2ZdtDkHEXq5P0qlyO+d5
	6ZjVGVRLJOf5ugEk55K8s+Lll0SypmVS6wUtjZ9A5Yoh/503W97YCOT+yQ51/9hesLQV3Tf2smB
	DDdNHxZ3KLm/jzRP1k1KvUUiAA244gztDdeRwbB8FRfaXTCWEg2+G4MhuyheUOVzgTbHOkET766
	edauTzMDUM2+vpCytnt9Xo46qDiiIP7PAbFwN3EaUeihqq0c+t6TpxoQB1o=
X-Google-Smtp-Source: AGHT+IF3bCcuVn7/pn4NOSAdj5IYP0WOD5QZh+Z17fFcTe7K2T0Q8uadSnKF4A+DiojGLUvpjXVIBg==
X-Received: by 2002:a05:6000:1acb:b0:390:f6aa:4e80 with SMTP id ffacd0b85a97d-39efbaf1ee3mr1969360f8f.53.1744973996603;
        Fri, 18 Apr 2025 03:59:56 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:24a3:599e:cce1:b5db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43319csm2478606f8f.38.2025.04.18.03.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:59:56 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 03/12] netlink: specs: rt-link: remove
 if-netnsid from attr list
In-Reply-To: <20250418021706.1967583-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 17 Apr 2025 19:16:57 -0700")
Date: Fri, 18 Apr 2025 11:31:29 +0100
Message-ID: <m21ptpkbge.fsf@gmail.com>
References: <20250418021706.1967583-1-kuba@kernel.org>
	<20250418021706.1967583-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> if-netnsid an alias to target-netnsid:
>
>   IFLA_TARGET_NETNSID = IFLA_IF_NETNSID, /* new alias */
>
> We don't have a definition for this attr.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

