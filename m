Return-Path: <netdev+bounces-105773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DA5912BB4
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C801C2663E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0B150A80;
	Fri, 21 Jun 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5xA3ylq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF686AE9;
	Fri, 21 Jun 2024 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988399; cv=none; b=pvSIiwEBLwd6/HbjFI1myh5RrnCLg/N5OZ1JAAi/TqHZhg+C238nYC8/Igx8GxTDfxPCJKIk65CkxoQam2NCQJFR6snb/vUVBeAUqjKYk8IuOQzf19/f8lftDVvjHglpqHyrkRIScPiG3tPQmruUAcS16rmhZbAwSXxwLTaiKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988399; c=relaxed/simple;
	bh=PGoKH4PSN+KRCZ8p3NeqGDrRalQHGHilH0uTblx8H+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmEQNKPlKMgOgkhHVzo3YMOElkJJFfBDG4GHVh5NP8NvYkszyVbQW0LurZ5oy40mJVaWy0bgqq0MXBsKQXCm9W8Dpmz4cNn2BnGjHJ1XqFiYD4rkj5QKShR2iR8BU3egrGM18VXMHUYh+BgkBC4BEPUrZEFztsnHDVn77DTC/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5xA3ylq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so20618145e9.0;
        Fri, 21 Jun 2024 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718988396; x=1719593196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+XfO36X67iK3WTlKxvf9cKHL+bKZPfdkpQdWPAIJK4=;
        b=e5xA3ylqPixrVl6TdSrbuZWzgYsr9UFThWq1w+bEgfrw24NzqmAy0kqIRU1P8QwOr/
         Safdo9h5f9DlCUo8DcPdMJQQn4wLATNPaX68yMSIwYk3Sc8V2fA9qeq2P/TZ/9XNwFMa
         aG+rcRFtdoSJWQy0bMywx7Mw0SFcUMNKGiY8SR9piJ+Ux4KDAX0XeakZZXztZaHIcZln
         hGg5u2ip7jmE6L59dPOApOTLAULLq5onhB0VrkPEmQsDC06UQZKLCgDhR6do6H8NFY22
         73m5WPbeb7ehZOgCXcmVdKOV7wUsTSsg7J7AtBf1HK8x6jPyuQsqZy+E8IRMFKokk8bi
         +Owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718988396; x=1719593196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+XfO36X67iK3WTlKxvf9cKHL+bKZPfdkpQdWPAIJK4=;
        b=g3o3JU1erE9ILQbSzOvpW+38nX7daDdwJeOvqy2KQZnwoHEK6yaf4hAOqUilohDQ/X
         wA/6/jhIpZ6RyFSPlKIPodfdYqg5dIUAG/iw3KtEhjKn1HCk31DR00h8vbzZRS3tshIt
         j6w+Ox8B/wSeYW/pIL5+Ysy+Zjwk4y/XSZFyiGXpNw9K6mSKfGDH7Ec4a4FlTrJGxbR2
         D01kLp1+miQewTItbZgvRYFitapqeGUxpmhORPAOO1uPB6Qs+11H4LEP/kBujNONVlQ9
         GGA1N+2KpadO2OAr3P+ET92xW72s984D5YvodseKu3i0BLd2gT5I3e7HbzMPzZUc6qx0
         rrCA==
X-Forwarded-Encrypted: i=1; AJvYcCVbw0BsaWaipBBcmZ6w8BjdwUyodtDvVlph4cKiOpbgUwcIjO++U4bt9PZ56XV6WFwvJHJ8R+WVYlVvwFWlaNbIqQl/ve4avcNj3aabxC34KAUU/ZPNWIJ+wXtWs4rlCarWwdsu
X-Gm-Message-State: AOJu0Yzz+TVDdso4D7jtbEmJM2rbbjMikFcTbQ/O5oWdDiEs+5Lw/0JE
	AEbwD989JcNAmD6QXjDMmAZFwSiKVzk+hhRcUWtb8rCC8f0brcFu
X-Google-Smtp-Source: AGHT+IEI7F0S16TUfaBF3jQIzqFKTiHCAwZEgQ8MrMnfOO0Vlb55qc/OqHZvZRDGWANPAlCNn8dM7w==
X-Received: by 2002:a05:600c:2317:b0:424:76db:3583 with SMTP id 5b1f17b1804b1-42476db371emr61852465e9.30.1718988396299;
        Fri, 21 Jun 2024 09:46:36 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663ada128dsm2261736f8f.117.2024.06.21.09.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 09:46:35 -0700 (PDT)
Date: Fri, 21 Jun 2024 19:46:32 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: dsa: qca8k: add support for bridge
 port isolation
Message-ID: <20240621164632.cnkcznjtuuna33cg@skbuf>
References: <cover.1718899575.git.mschiffer@universe-factory.net>
 <78b4bbb3644e1fabae9cc53501d0842ccd1a1c5d.1718899575.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78b4bbb3644e1fabae9cc53501d0842ccd1a1c5d.1718899575.git.mschiffer@universe-factory.net>

On Thu, Jun 20, 2024 at 07:25:50PM +0200, Matthias Schiffer wrote:
> Remove a pair of ports from the port matrix when both ports have the
> isolated flag set.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

