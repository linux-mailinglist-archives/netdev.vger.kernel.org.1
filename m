Return-Path: <netdev+bounces-162873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B204A283F6
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 06:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C92218879B7
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 05:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0546E21E0A2;
	Wed,  5 Feb 2025 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="PvgD56ON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408EF21E087
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735018; cv=none; b=lD0bAyoJACE7H3xie7KtClRMpWLUyTC87S0yaxhDBrVC75p98EPphefTq7nUy1M4X/ZOf+nC8saKuGinhNRQClgyry4AEopjfe2IkE+oRHZ24CTvANgggGJWmjO5twzI4EmbcCeCyIDVhEBH4IF460ZBOioMSkD3ijD7z7/7nEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735018; c=relaxed/simple;
	bh=MrX4MfuXKWj5ytSNxwkhkKn37o5v+Re4uJYrYKu/+kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMTdJGljGEYLFI5WkxWsJ4cN+57Y6w5FwiRNFIfyFMmFAu99qmChA6INdqxJLfgnx49UvS3rbSfe7z9rUUQcYQbwfB2Ic4IEUlvNCt/s+5PNMjhVqjqSJUBUkWYYKxXkG0Gr/V2zZ6+8KubD2hz4xUwVACwg3TnL0reQ8PsJRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=PvgD56ON; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f9d5e0e365so1550190a91.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 21:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738735006; x=1739339806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns0GvBmqZ/ALUPGbyiEvtLecO6r/ScOTIN440LsR8U0=;
        b=PvgD56ON9ydeM2frr0Pss/6EhwfrpkPotumZZBi9t9hWG23SK+BTxTll+89eVAGSWd
         3kmqGfQQG0d0BGoqKYHmLzz9iqIEa6sGy4dvpTjTVP3xJzK8zMtOv/rsUbL76G/lX9eO
         K4I4KiRMbd22Pg1ak/CvdWT7PFzyXidj9qDpOFNzrnwap0X6vHzzfgnP59LB4o73WZ/W
         F9JpdZZLDEfN/hifDXy7onJtBq7PLxkJvbE38gScAFOXSRrJND2D9PrRjJQHdZNo9ZXR
         7/fmohklHSn72E9v+U91y1cJK86brk1XM/gCJh7YKcAyWfBxVNXzbbUqYurCyj9i68wW
         JZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738735006; x=1739339806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns0GvBmqZ/ALUPGbyiEvtLecO6r/ScOTIN440LsR8U0=;
        b=JkvgnQflgMhEWDXsZr/OvNY/BQ7LNhzCSCMqK9Dc+Kdg46we5MXWy/RyjjIy5gdoEE
         7FzcKj9DB6TbeoREFwEhPBlyqJupohlaHG+A/W3Wocuf5cPF3MksYOEHAlDTSo2/CJ53
         CCsmLnuGIEOi6DMVN2wsaYSJG/+L3X42XmfeuczPRA4P+CVQMcBvm4SLE2YuDqshwo99
         LUN3HnX8NZ4AU1Rr5oMe+xaCqfyBD5PrmDhe7TmAY3/Wt2yeaColqrv6m6jozvUKO4qb
         v1Zk6Q04wxObYLBHCDTbfRKEJK9sGqLiQ3n8Bz2mggNO/JqK6NP+nERYXLG5OulhJzjq
         TQdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjn2lgEc4AZCQyYNNch5CeqhVkrSfBcX6RurVP1BesbwdH46SBcj4czJ57Zgm30R146/ypwcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDYm2FMopIYH/P1YbpF/Ky1lyjV7ghAMKHyUy+cQ0XM9WzNVi
	S5sRistVA9NbY5ZC3t3tF9d5I6dDo+/LGUlxkOmmLelXwBjMXkptO0pE017FEIM=
X-Gm-Gg: ASbGncvIEGWyDCeQzxtZnz5Kr7D7Add+LIDsgytJ3WLghNOcIRlGOJAvq9Cgh3jHPxJ
	uHB34WJpy02EyuT6SX4ciNeoy9ZuyweLwN36ZB3e+0iGQKTz8vr4znF5DnawVpRE8vM31DP0CVr
	IFhXQwCgqTha+l6kO6VV8M6QjmUUeaD+0TzObo3a3NFxT5y4Mwe6VXZqH0diKjyeUMVodTRqczH
	3pPB/K2AP2lurbraT2i5iNIIqGnEtjLrqoVog6EGVTLacQdbnN4pjzOfoP+edx9qYk5rXXq21mS
	WrTIFtIwgKVf0rBb5sZDudhcvtxGuVHUzFd5WMUKUxjMRBHULnsbhKCFX5ZUxapn7z+p
X-Google-Smtp-Source: AGHT+IG04CF5Qx7s6xBWVy3NG/NTiwTMF528huN8sMDzFrqgklOtDQvD8VpkkKg5ZaYCNCuNQm5zHg==
X-Received: by 2002:a05:6a00:4642:b0:72d:8fa2:99ac with SMTP id d2e1a72fcca58-730351255c8mr2340033b3a.13.1738735006329;
        Tue, 04 Feb 2025 21:56:46 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a18cb1sm11561432b3a.169.2025.02.04.21.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 21:56:45 -0800 (PST)
Date: Tue, 4 Feb 2025 21:56:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Long Li <longli@microsoft.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH 2/2] hv_netvsc: Use VF's tso_max_size value when data
 path is VF
Message-ID: <20250204215643.41d3f00f@hermes.local>
In-Reply-To: <1738729316-25922-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1738729257-25510-1-git-send-email-shradhagupta@linux.microsoft.com>
	<1738729316-25922-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Feb 2025 20:21:55 -0800
Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:

> On Azure, increasing VF's TCP segment size to up-to GSO_MAX_SIZE
> is not possible without allowing the same for netvsc NIC
> (as the NICs are bonded together). For bonded NICs, the min of the max
> segment size of the members is propagated in the stack.
> 
> Therefore, we use netif_set_tso_max_size() to set max segment size
> to VF's segment size for netvsc too, when the data path is switched over
> to the VF
> Tested on azure env with Accelerated Networking enabled and disabled.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Since datapath can change at anytime (ie hot remove of VF).
How does TCP stack react to GSO max size changing underneath it.
Is it like a path MTU change where some packets are lost until
TCP retries and has to rediscover?

