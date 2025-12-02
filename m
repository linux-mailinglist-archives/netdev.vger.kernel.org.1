Return-Path: <netdev+bounces-243332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6B2C9D389
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 23:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CEA3A5966
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 22:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C0D2F7AB1;
	Tue,  2 Dec 2025 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI4yO3Ah"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12D2D6E7C
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714956; cv=none; b=iHP02E1IqGoQLWAXpcjWT0o6zjfxHTRlk4pZtreRSwa/5aVy4zKqCZAIkAGmH5UFGpOVDdj6TMgaZ5mBcGx2IvnVzKJFzOCWPEo57TCD78c0W+Zca/HW93KmIu7GDcEpcL+9/LThYyjCHRoQLVuGXV25FtOtK3JLMsFlpq/GG5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714956; c=relaxed/simple;
	bh=c3mR6BZuY4hFSjct5BypWPJ9sGu6XgpedPKKtBghZxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVAGg2QNrfRspCytAbxq9inK6L5zE8X45Lox7GBjV/M+8EoMVykQvckNjLwiZNRaWW7VZngKf57KB8uzwnCtEx/8rwAX8W5tvqUhSyDT8/d7plK4ZlK0tNICdTfxykSBMMurW5Xe6XabSSbxLZX7kQGgrMf6+MOHCWiYAc89NWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OI4yO3Ah; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787da30c50fso58507887b3.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 14:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764714954; x=1765319754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ylVM1ZycKfOUhBo0Kx2tN3N0OsyBVhTCMjf7buZNaFc=;
        b=OI4yO3AhmyVxghNkFizjVzQBNIY46wJYyY1teyjvpBjDIsAzqtHIlTzo0patci59bj
         7rDyfHrte1GjbXUm/3Yyc7sbqDQlUfod6tnD4iHNf83sNRqOHAkLA+8t30du4C0jcaaS
         c/MJFtA/WhfmCtITNbphFknSTUA5cDQd/lIt+IUB0b4uHWtn/VwhvY39M+tl9tgD48jJ
         UZobYKCYkzOIng2AWsr6YtoA2aSuFbWvQqg4y3i4MbrnuWluaytaXNjnFosuGkp/8zN9
         Tp+VpstjmwJH+dv1NqWl1TZPsQ3BIxN6cYk88QRRbIsFm69/US5kVyKpieGC09ywVq0N
         h4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764714954; x=1765319754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylVM1ZycKfOUhBo0Kx2tN3N0OsyBVhTCMjf7buZNaFc=;
        b=GYlWxa8HFzZ5Oh9m2kW0GiTVidX6edMJ0+a8iShVLW+ueLo978+1o3RgwnljPBruW/
         O4Uj16plUF4zcaNhWCiZsOTA9ldtwg9G5lGBa7QUpwNhMKZId7F9+w4iVcloy+1dkpjT
         74EgyQsKrMbHX3us3MlAoBlschz9aetzH9gwiroMAaYCQWe2HFn+cmjEc6x/e9149RUz
         k38aqPBid6d5mM+cgTL1edoooqq4GZNjN0DQzGGbyAqcYqPJRO3LcnYA3YjCNICZCt2v
         O/B9HEhzZ8dz5AWM1BCqCRIhluPoxp5yhZ6kNcZuiCYwEIST2p/+VZFCA400jih6M5Ef
         6B9g==
X-Gm-Message-State: AOJu0YzVgH/KnSXWjt6lIHHyqAgLwZwImY+9NiE3fUMQjFTDk94sHFBQ
	eCOjw9uZptkwuD+fguNZNs0B80lEwEx+o7KdgE8JStr65E4ddiC7NHIa
X-Gm-Gg: ASbGncu6nmeQQ7o3nvnbmv9onEGz635HoX94aQ3wSPCamrXkk3c+sv1wItCk7whTpJm
	lwvaSAXcDF6kW5TyuQkBMcH5IAst13SFHsGCiiKcIkDHM06irV30ypL17B2zwnmS9z/F3Ao9U8A
	PRtV1ot3VTMmpujf4LVPstmjgHJzdzVbQbxccYaBcIhdDvMAHoyeIKR3FZYQ9Pv2K0fwoRucLZL
	1FSwhndv5AaStIsHHJEJrteqB9aSF0ydMesgPkFLESb3lYaAVEFBWM47j+SzNlydNMNjDia/4X4
	p5p+6DfqR2+expAv3KuQ9fVzRMlW9u+yMcMN8UAm7VkZUQ7AoHT/33HUKXAnh6whrP2JuYKPjy/
	MvkGWGwwAECS2P517uJbyCjaPrnGy87OqNuQHDoky3Hdh5JlOF4BqcTo6Cc9M1hWO4Lo6VJ/yvN
	1fjbukhiyrqACWRLVtvcYHLuqeAVyawYA4BDVYKmXm5jAvl+TvkRUaqDK/
X-Google-Smtp-Source: AGHT+IEWLac7ShLnOCEKilr1QZDB3R81AMdSAdYpR3XnPeC/KGg5zW4Lsd43s3UjQ6DQjFnauKwvkA==
X-Received: by 2002:a05:690c:2784:b0:78a:722f:a7c9 with SMTP id 00721157ae682-78c0c1e75c2mr3231817b3.47.1764714953844;
        Tue, 02 Dec 2025 14:35:53 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad102d25csm67836137b3.44.2025.12.02.14.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 14:35:52 -0800 (PST)
Date: Tue, 2 Dec 2025 14:35:51 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, asml.silence@gmail.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2] net: devmem: convert binding refcount to
 percpu_ref
Message-ID: <aS9px07mgnNjSu8e@devvm11784.nha0.facebook.com>
References: <20251202-upstream-percpu-ref-v2-1-4accb717da40@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-upstream-percpu-ref-v2-1-4accb717da40@meta.com>

On Tue, Dec 02, 2025 at 11:34:17AM -0800, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Convert net_devmem_dmabuf_binding refcount from refcount_t to percpu_ref
> to optimize common-case reference counting on the hot path.
> 
> The typical devmem workflow involves binding a dmabuf to a queue
> (acquiring the initial reference on binding->ref), followed by
> high-volume traffic where every skb fragment acquires a reference.
> Eventually traffic stops and the unbind operation releases the initial
> reference. Additionally, the high traffic hot path is often multi-core.
> This access pattern is ideal for percpu_ref as the first and last
> reference during bind/unbind normally book-ends activity in the hot
> path.
> 
> __net_devmem_dmabuf_binding_free becomes the percpu_ref callback invoked
> when the last reference is dropped.
> 

My apologies for sending this out after net-next closed. Won't happen
again.

Best,
Bobby

