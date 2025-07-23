Return-Path: <netdev+bounces-209279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6DAB0EE2E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9355676F9
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3D2281525;
	Wed, 23 Jul 2025 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo8UmjRB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677D20CCDC
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262211; cv=none; b=W+CVbDm0sGlFtyQy0mMOnVRMHf3BRyKiyZEC8+tfQiH26NV+nOjFR+Hn8RtQXdSxGZ8HjerixecHMTO6raB4jenxSvLdQtVlMkAf32t+fl3JoYuPpvTBATlryCHZxhuGo9s6ra5qJqAcKEJcPstgecICAZYfu0Fg8vpxQ9Z6Wm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262211; c=relaxed/simple;
	bh=EdNHdN9c7E8Dv+E28NJ/b642Qgf745BrQ//S8K7Ang8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=gReWJbWwktIsfO02F2d5CEmI2WjZ+CeIdnqzu9dhM5U9y35e2BxDFnaTB/i/QFGZI0RrbHSdEWUMfThWt7lIcvm1gkLD5SU5cP7XnqSxB3cd2wGmvPLX/iTE3HmDI3P3wMeA/ZR/dxM7tXwytKeLcp/G9nGaUcu6KrYanooTwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo8UmjRB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d7b50815so48761005e9.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 02:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753262208; x=1753867008; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EdNHdN9c7E8Dv+E28NJ/b642Qgf745BrQ//S8K7Ang8=;
        b=Eo8UmjRBwY3J2p1ecTllzYWu1Ad3sGwttptBjd05T4RjO9LaiejhHMvgUALqipmsMR
         TEIuwxlHO/TqIaj3NK/z80s2SPJ+WDKKdQYvMAE6B065hPEbG2Qdlslb4pdq0W+7B+rB
         elC5dy4O3h8sMVkZRf3D3zvFe/iyznbwvm39vyj+3tD5xMsJYt3Q/Xp3EkZsvLgErphv
         8ecEGmm9jXn10lxySzqRbqCmoK+ZiMV/JSTcGRs8nydlfLt+lPC535y8k6J9CKpc13hJ
         49378CtKEnrKcqIggGQw+dAcfLLKAXE9qWowQKn9D/FC7vQ6wl150PQ+SRTKFUeMaa0K
         dqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753262208; x=1753867008;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdNHdN9c7E8Dv+E28NJ/b642Qgf745BrQ//S8K7Ang8=;
        b=kz5VjK2GepDiMx/gTbcxXavOWj6SGNfh+PCMgbV0c3D5RbbilI9nVlY4OlYnJHJLlv
         iTe1XUslLvmS3gHabkoEJKsFElZ9+p6+pNFkb162ouERomXm5zvo6jhtyaff/4SxtdLN
         QmOI2aX6tBJMxw0EkR9ScDnU/POAhdpgZ6amk1HueScUVZAh8DQThSykHoGydfemDI9q
         pUyUr0PCEXrgv4EQzreFsP4AAznfKU7P1p9BJXkI2w1pm0+lf5PsAUxpXvPDBPLdM3AD
         pt/QgLyq3ob+xkfOHZ6QxsOGGuDvYgnqhEFg/jrRB0zSViADu0BXUIlcow8uUt/UhIQ3
         8wew==
X-Forwarded-Encrypted: i=1; AJvYcCU87iFnZ3lRMdEwH5KoxG5R0m1GRb/P+0TSo1QB70c+/zd77BtePlVvDySCCzQkOv21/+PWeDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95ClHAToE19t4zWpyo4NqEvAE4W+O0mKvOpOs0ehbCvbqtjDf
	QcC5m7/gktGUgTL1VxN+bKvsOUK7Xol+zcHSsWKniKg02clFDiWxC3Ct
X-Gm-Gg: ASbGncvYBDpLlqS2FBWrJzDazomNs9m1k984DMRneeTQBWiHS+yez8x1RbqIXIP1UAX
	qys3mU4mJAmYiGihfWut0EKOsjPOjc8ftQvPvBb3saFsTPuIE0WKsL1NQF2ONfr1YOIKWz69imj
	FDBP1hsje4+ssIVgttdJiEXIWHFe6cpoQ2kpZJqnNf5IKlzAdL7o6MfLSpMaCPRqn1eu6fWBaJZ
	BN9zChQu50IuL34EIV7CLHC2vwxbpjhz9VijzR8DGcFOPTN/zVkJd4PZUnf31MsLwJ+aiyt97Jp
	A+8kJiuzL8XZWL2vcRz2y0zobvuMZLzpYjsxOpIBNlaHhxXNSHX7oyJeM9YBzz+SKuSrsesQeDx
	bzNis49QP6/ccPrB4AgKYNvKnUuBc2VSe8g==
X-Google-Smtp-Source: AGHT+IFEGAQDPnFXbC2P0PbkGWUH8BFo2+hb3RuUMKTBcV7wyg3WjTePmQm0rm58QrQxrPrpmMLhKg==
X-Received: by 2002:a05:600c:1548:b0:455:f187:6203 with SMTP id 5b1f17b1804b1-45868d51a1dmr16726395e9.27.1753262207416;
        Wed, 23 Jul 2025 02:16:47 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:b8c1:6477:3a30:7fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45869198e5dsm17242985e9.9.2025.07.23.02.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:16:47 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  almasrymina@google.com,  sdf@fomichev.me
Subject: Re: [PATCH net-next 2/5] tools: ynl-gen: move free printing to the
 print_type_full() helper
In-Reply-To: <20250722161927.3489203-3-kuba@kernel.org>
Date: Wed, 23 Jul 2025 09:58:03 +0100
Message-ID: <m2pldr9td0.fsf@gmail.com>
References: <20250722161927.3489203-1-kuba@kernel.org>
	<20250722161927.3489203-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Just to avoid making the main function even more enormous,
> before adding more things to print move the free printing
> to a helper which already prints the type.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

