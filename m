Return-Path: <netdev+bounces-155818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E452BA03E7F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE09B3A269D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF231E9B33;
	Tue,  7 Jan 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evjvBk6Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DB01DFE3D
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251455; cv=none; b=YrVZE5FOtdACof1FS2dlOdDznNyYTEGc1gxW6gyQvqN4xX9KNPSSZKpTaIwNC6mcXtz2hVHL2LJLZsdREMlmjOSmETN64ZusqUNBrXwM9isMzlEmOCDhlX6IeVM3RAMumopStNdOPqdQnVoOePx0H8VfICRYvGS5jQhZYj4yvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251455; c=relaxed/simple;
	bh=FJ2nluP0U1DNjzdsDupwT81e9JypfHhfzlKI5y49qRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9MmXHM72P7cwC4L7OqfQMgPuixTL6YUjXw+EEsUDingChBRudP+Y2ZrDIA59oJihAJMPdyLdpN4WU4pBR1Mj1C9i3SP1VCrSPvC3sM+uhMpjYrzO0qyf47FqB1BXjy4pNmTwVxCK7HTpIH/DtxG8dcj3koJtYp++HZPedaJ+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evjvBk6Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736251449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dzBLLOp8eNpGsd6cUumXxsmOdst/gq9nNd6WoidZRM=;
	b=evjvBk6YXNFamXVrHmsUD+Af494Sqbhib6I/9+rQtzNlnR0nDEqjaU67fuNqz4MPPPG41r
	N9btq18cRKLyNzL1v97kWKLcyAgEi7gvTVUVNXdynrfiak+LTdu0c0tXTmI5rGWn96/LCF
	X0V8RG5ptFQYb1i7hbUzMC+r1yalkqM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-l_7NjBmgOcar8pdjPYf6ow-1; Tue, 07 Jan 2025 07:04:08 -0500
X-MC-Unique: l_7NjBmgOcar8pdjPYf6ow-1
X-Mimecast-MFC-AGG-ID: l_7NjBmgOcar8pdjPYf6ow
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38634103b0dso9106172f8f.2
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 04:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251447; x=1736856247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dzBLLOp8eNpGsd6cUumXxsmOdst/gq9nNd6WoidZRM=;
        b=oht5X38Y+aty2YAoSdDyqZeCnIi9SdqDfDy3F2n2h4JiHCx1Wpn/dndDRp8fe27B/r
         gPKT4orHR5zn/OxVi5XUvnrvYEg3Hfzf8lNn/x9N1KYymfaoDlKuzrpLDbhgfPpyLe6G
         c2Zm4pZeRyWVzQ6jub+Ao8EhW2Ay+pc1wSTza34w8lGpvrCGxUppXVf8HEqkBTp/p0oE
         O9HQRUYW4x1i/50KL9R13vpwdR5NI11we0rvD/91a6u7Yy5xoBnvXAcPioMhCJQZx41f
         bwARfzO/XPULc8LPviwapSEodNfA+l9Fb71IM1h20yCyVsFcUSObsB/1Il0Mi+o4RjbS
         /vsA==
X-Forwarded-Encrypted: i=1; AJvYcCW8N42PunURy4OrrToiBhpnSsYAIw9FZDxMTT8kpo6XOO90HUazPFzFs3+el2wPkFYTlPYj+yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR4cVoXEsSLLneKBc9yDn1I+hgStRAo6xcNC1hnzoY8kUffId/
	m5VUXx4u33yv2MGL8JsJOz9a2o3eDWI3s7mC/khh6lmD1gODQOw4w9IildquO4Gg/dyrv94PmAE
	sV7Lwo9l+0QP10MUNQ2718DoP7jevUOO/JZSgjKo5zvcmCAggPgf9BA==
X-Gm-Gg: ASbGncu1bcwg/Hjc1PNhNA1GmbPY2F9+OIXy3l1w4LikYjIIS20lrJCOUdnxp6teyz+
	140ps+1Jpx0slPGuimTDmPXijkq54Ze7ub/aFwtk4DZVU7kMkwTJLeQ0tFrcmgiXJec7mzvpDMq
	qu0U+JBudQ9UlpQupO6AOBfT7FY/pKJ+88eblLr1x5OeMAz7J+YypdGvSg3A4cLYt8oRv01XhMr
	8/G3J8XnMcaz+1Ybv8uD4t+VLjPx4vxtLsI9XpCaVf17Iw2TmfjxrMwEWo45Jtiv4I9M2satpUg
	OH8XOgmr
X-Received: by 2002:a5d:5f56:0:b0:386:1cd3:8a00 with SMTP id ffacd0b85a97d-38a223f5b41mr59871346f8f.40.1736251445744;
        Tue, 07 Jan 2025 04:04:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWfb9Vm3Vt9Qk+wKzvMGFSZQzXSCS52o6qWqfR8nKRXCO5SfQ0ddtzkhw83y3pCZhrNPA7iw==
X-Received: by 2002:a5d:5f56:0:b0:386:1cd3:8a00 with SMTP id ffacd0b85a97d-38a223f5b41mr59871192f8f.40.1736251443868;
        Tue, 07 Jan 2025 04:04:03 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e278sm50877687f8f.75.2025.01.07.04.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:04:03 -0800 (PST)
Message-ID: <c6547053-7de2-42a2-b8f7-6837e9ab85ca@redhat.com>
Date: Tue, 7 Jan 2025 13:04:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ptp: limit number of virtual clocks per physical
 clock
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, cheung wall <zzqq0103.hey@gmail.com>,
 stable@vger.kernel.org
References: <20250103-ptp-max_vclocks-v1-1-2406b8eade97@weissschuh.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250103-ptp-max_vclocks-v1-1-2406b8eade97@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/3/25 2:40 PM, Thomas Weißschuh wrote:
> The sysfs interface can be used to trigger arbitrarily large memory
> allocations. This can induce pressure on the VM layer to satisfy the
> request only to fail anyways.
> 
> Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> Closes: https://lore.kernel.org/lkml/20250103091906.GD1977892@ZenIV/
> Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> The limit is completely made up, let me know if there is something
> better.

I'm also unsure if such constant value is reasonable for all the
use-cases. Any additional feedback more than welcome.

In any case, I guess it would make sense to update
Documentation/ABI/testing/sysfs-ptp accordingly.

Thanks,

Paolo


