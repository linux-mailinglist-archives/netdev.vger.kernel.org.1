Return-Path: <netdev+bounces-181616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F3A85B7A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167F0460639
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B78D290081;
	Fri, 11 Apr 2025 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGRo+LKC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C705238C08;
	Fri, 11 Apr 2025 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744370587; cv=none; b=TWcahHpqsgLBQhHrXUwjywal64Pm3sNOTm9d5cIovAbww7HPMxXxjWM6NRGke87pmCnvS3a1Id/Vbf72zOBHoy+dR4Cia0aoXNcUS/mk0LaCXy0G7vgez/ywRj56dRGFb9YgIIK7NrlytUGu8YVuw6zYIJg8I9fEGt9t65Q8q7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744370587; c=relaxed/simple;
	bh=cLaRCpsuY1Y9GibZumfX7daXsbuLN+zkYfh+d2mvyUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSCsrOX8uxMx5I5faYmbCSPsbiqNPusMvN9yTr2RNgJNJefTlJh4DDOO+ZveB29MzHQ98pFymVuWVESWWunyw5dheKgDeWI6rjAI6kcBQU1bsRV1RIqGqsggEP0ss4F5tkFOOyJNPlpsXhxFY2/aI/KZZUTzxlce9oHPAoDDOjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGRo+LKC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54acc0cd458so2097384e87.0;
        Fri, 11 Apr 2025 04:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744370583; x=1744975383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HT7r3fDuEL1KH751TSC5LDiGn90lVSNqfi4tD94lhmw=;
        b=OGRo+LKCool8TVJzf6DyiMzR8OuevxHhF13CBdfLlKH+pnw70269xYoie5GzKzWQCq
         3OjtfJl8ZVpcE/9OsDQAXcaXKqXS85bbhyd7ExU2WpkKsKFWTN1wg3QHYuN8UxIcVKDr
         /9lbDgY3RuY41MEfqKqrTYgxVl5PUM+57jPFcZVp2GbgqpMSWXMkhU6m3u5ZHXbEGVDc
         xWHAVlMP6DhHlZreOeUBCxcRyyPbDlC4o68eZN3uqcsAD2jPP6d9WQ11DBxgniAA2KDS
         qTPHFiSOCYISMEpSjpyfz2LIx7d2Etwh9VFQLBrb/oMXthD8vopGB3szZNxeUn/IGe27
         DsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744370583; x=1744975383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HT7r3fDuEL1KH751TSC5LDiGn90lVSNqfi4tD94lhmw=;
        b=MfoIjbaLhlEbDEcmBXZId+1+5Ny+4xx6HyfMJXQJ1eydT204FG+EvB3yRo49BqjhBR
         4tO1x0HpnVDpIif6i+vqbw4+AR9dHNFVK8SpVZo4W/nVOHw72bvMFRJgW8Kl4XcC6dxx
         jw+U6ulasK0GNpcn2/stD7LeANODI1JtrMAhqyXcGp0Uaz0WtzyOh65AXbiXU3lzXZ7S
         yf5dbZWAT5DO6fo5yNd9KuFaoFo+6jMXmMkGYP0slpnjfIxoD0Qi+knsXp2tDQFqsZ/s
         MFlH/5yeeeI/fjgiY06QkYb6GhKndJl+8WVy0tlF3PwuB0s/6ySnF7bNgF9JYNd+qzuT
         1RhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKsZ9LwnD4ocrZdD9WigOePz2Sp3YEe4C/c9Vc9agdsapXRh8wMaju8wZViC6HKxZSF4yFQHeu7lseopo=@vger.kernel.org, AJvYcCXd+5exI22wiO+pT+IUFJzKVd7J9EEMcbst//m3ZDnOznhKQcUA45nSQ9mvmX5ObsAx2SlXbht3@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9PyHSAsYsO5wSbtMvC31a3bWBY4Ab5hsruTMwzOuu1Lgzutd
	ZPk0KTFwP+i95kbtzWdDWDlwBRU/V/91+c7uCH4yl6ARnU86907Q
X-Gm-Gg: ASbGncvn1A1ULJgCTt7SSFyY/81ebbRySWY7nEG62akvNDGoc4PU/b7NqdpBsFlskXO
	ZXj+Z951AcRuHrexDRwWihhoQ+bxs419FcJzp+Qx6BZn8vqVRPiLDhpaYeGbQKjB1wFqG6ww32G
	WpGSHJONGV5E0306eYcFBwuvAtVmrLfJipk80NZL39TVQSGguBaQzMFGlAp3nrBs3H1FxGxz0zq
	kWGdmI1fTuwXLNcNH6fMUxNsDhK59KHt1dCSEOD8by6bOGKmPyoE3nOmTFYOqvY//J4vZlLtw3I
	RPYSutr7JlwK8c/7pC7N+liK2DpEjntFm1e02PzgYM2WICB5BHvR1lY=
X-Google-Smtp-Source: AGHT+IGYU2dQ+mYo0a/xjnGmMYdyBFO3HCLYch5FmyWp7AJ0fIZL0TPs0HDRDiXOqnfVRTNveTGXrg==
X-Received: by 2002:a05:6512:4006:b0:549:59d2:9ac0 with SMTP id 2adb3069b0e04-54d452e13d9mr759462e87.47.1744370582988;
        Fri, 11 Apr 2025 04:23:02 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d123469sm407200e87.24.2025.04.11.04.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 04:23:02 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 53BBMx6g006990;
	Fri, 11 Apr 2025 14:23:00 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 53BBMvM3006989;
	Fri, 11 Apr 2025 14:22:57 +0300
Date: Fri, 11 Apr 2025 14:22:57 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: kalavakunta.hari.prasad@gmail.com
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        npeacock@meta.com, akozlov@meta.com, hkalavakunta@meta.com
Subject: Re: [PATCH net-next v3] net: ncsi: Fix GCPS 64-bit member variables
Message-ID: <Z/j7kdhvMTIt2jgt@home.paul.comp>
References: <20250410172247.1932-1-kalavakunta.hari.prasad@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410172247.1932-1-kalavakunta.hari.prasad@gmail.com>

Hello Hari,

On Thu, Apr 10, 2025 at 10:22:47AM -0700, kalavakunta.hari.prasad@gmail.com wrote:
> From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
> 
> Correct Get Controller Packet Statistics (GCPS) 64-bit wide member
> variables, as per DSP0222 v1.0.0 and forward specs. The Driver currently
> collects these stats, but they are yet to be exposed to the user.
> Therefore, no user impact.
> 
> Statistics fixes:
> Total Bytes Received (byte range 28..35)
> Total Bytes Transmitted (byte range 36..43)
> Total Unicast Packets Received (byte range 44..51)
> Total Multicast Packets Received (byte range 52..59)
> Total Broadcast Packets Received (byte range 60..67)
> Total Unicast Packets Transmitted (byte range 68..75)
> Total Multicast Packets Transmitted (byte range 76..83)
> Total Broadcast Packets Transmitted (byte range 84..91)
> Valid Bytes Received (byte range 204..11)
> 
> v2:
> - __be64 for all 64 bit GCPS counters
> 
> v3:
> - be64_to_cpup() instead of be64_to_cpu()

Usually the changelog should go after --- so it's not included in the
final commit message when merged. I hope in this case the maintainers
will take care of this manually so no need to resend unless they ask
to.

Other than that,

Reviewed-by: Paul Fertser <fercerpav@gmail.com>

Thank you for working on this. I'll be looking forward to your next
patch where response validation is added.

BTW, have you already discussed how exactly you plan to expose the
statistics to the userspace, is that something that should end up
visible via e.g. `ethtool -S eth0 --groups nc-si` ?

