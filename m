Return-Path: <netdev+bounces-199328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C70BAADFD83
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB491785EF
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D84243958;
	Thu, 19 Jun 2025 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5XaU3VA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B920E711
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750313671; cv=none; b=P16WSVn3pFsJhvNktisTeLUEJUW16tqIajN7tRE/1xgclFAORhPitOydCQnT6uP/EMZATaY8Q9jcOXuFg/6diQ3seosvt9Q6B9fbvFLYMCzt1LYK19tiIJX0sl72Z+TYNGKH6wuIJKZpIbt5yYFECyLjRDAaG/J8KcNP5eEnd9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750313671; c=relaxed/simple;
	bh=AXkIxNCEBXUfFVobLDMKn3ADHgUMIYU8ephw2IhGnfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPtxpd/6XBhLuDC76HTfbndu84EeODuAVUq7Nu8Ve8Cc2EGt7fze7fdEis+e2DooLMsewOvgriFiatYxxj8Pr1G4wibAVX3EZ8BsezR294xk2n7RGBzWQOmp5AxnYcg00CCJ9mzgdbHlExt9m3AFyl3lj+nmUGcQi5k1SIVtRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5XaU3VA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2352400344aso4526025ad.2
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750313670; x=1750918470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGcHVi3hqaDqG2UsbKeqnoCE2zax2F0zDemIPkOpEQI=;
        b=e5XaU3VANr3fX5tgaahpgDvxsLsbOtGyakFVFkn1SZ5sr9oOimunABlyZW42vgEad2
         Ik1pEi57TEjkHr177CVkur+eyzfcEg6dLAXitzAX2qYMGW1bz5TR8vhOdmwXt9ozTugM
         pTxb/iyO3WP7JuvBo0WHjVEyKJFoj1bpdGYRV2cTSh+XRgADQHWPocY4yauMR5SDnmZe
         qaS1MHdeUYrsBn7amYALR2pwpyxdbMjq1sY59bilvWx/Gt4FH3GFgOUg7W8ag65bx4Tk
         8uTuVtQTJqumTh0899qevo9dy1Jnya2FVMZ5UI8saaMhSbs87wnaQiG2HqD+JMj0wAdO
         /YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750313670; x=1750918470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGcHVi3hqaDqG2UsbKeqnoCE2zax2F0zDemIPkOpEQI=;
        b=COwUzJn5G7R20OeNHj0IaxxnZV7wL6g9EVHLKWXJJWorv2k++NYWICMkfXL0AKAz8+
         9gSLbW7Epbj5yOCnfDQmco8kDezgdzwalNRZujwBL5x1x/LnE/YVwy5BFXPH3bY5BnfL
         ITl+Uxhe1slv0YiRQqNXDjI9fYYijruh3nFaLe/EElP+TOaecTrEIzKUZusN3id0bqzF
         Dol6elbNVy4wsSNojEM+/Q8A8FM18Ez5NKlBGCusqI62BCTd4R0XYcXEyAfCOm4/hWX+
         GSr0hUVvrTm28/GdPK0iaEvytY0CjQdXoPCiaoRQxPPxEX+Zchl1GirX8ATWhnXgLsf3
         y9/g==
X-Forwarded-Encrypted: i=1; AJvYcCXWZJbbTcRXUpvON0TVbBaShyDIkZyeY4wca6Bzuqc9wRo5RTxEK5jP37Bpa2BCyyXofYP8QOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpx5VHdMu6D9w5wVSUivEgnN/gDLq5pgviZtLJv8a5MCf9cwbf
	vrb8Af5evoXDm4qzrQP07BrqdngkcRnziu0ICQYbgZSSPPSRGqAgwoIFo33opk3RWazm
X-Gm-Gg: ASbGncvsZGewTg22t2v68o/MVDygXZqRmJybJ3o6pnC1/zoCePRSX53oIOcUBMYxpJL
	6ghKperjj36l0MD9gvWBEpfK7vZsiBX0pIVz4iGW3OBRuM046Wl95aH9SxOl09UsuQHZclfzsQx
	MXxHuJUVrmP8ROTWy5iVBhCC49scXZH1eQunxqaAM6mO5GNA4PS73Lw6RnPFmjhFknGybziMvGB
	+Eu8P6NplJoN2lrMdKbI1y/7NJrBm+0FiXnUTap+AxOFutqs5SgOsajalnJnXKryaNqeR311Flf
	UC2g2/HbC62jWRGB9uxlsXqaCUofKRr35QfhfCT/aqNxn0OA4g==
X-Google-Smtp-Source: AGHT+IHP6sVzw3c7LP9A5HLgZamK/NwMsMfFOeRPiUcWl8SgTaYWaGfpgYa8LMce3Id9gUo52RScAg==
X-Received: by 2002:a17:902:f683:b0:234:c8f6:1b11 with SMTP id d9443c01a7336-2366b144efemr348000745ad.44.1750313669399;
        Wed, 18 Jun 2025 23:14:29 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365decb5b6sm111631765ad.204.2025.06.18.23.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 23:14:28 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: jbaron@akamai.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 3/3] netlink: Fix wraparound of sk->sk_rmem_alloc
Date: Wed, 18 Jun 2025 23:13:02 -0700
Message-ID: <20250619061427.1202690-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2ead6fd79411342e29710859db0f1f8520092f1f.1750285100.git.jbaron@akamai.com>
References: <2ead6fd79411342e29710859db0f1f8520092f1f.1750285100.git.jbaron@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Baron <jbaron@akamai.com>
Date: Wed, 18 Jun 2025 19:13:23 -0400
> For netlink sockets, when comparing allocated rmem memory with the
> rcvbuf limit, the comparison is done using signed values. This means
> that if rcvbuf is near INT_MAX, then sk->sk_rmem_alloc may become
> negative in the comparison with rcvbuf which will yield incorrect
> results.
> 
> This can be reproduced by using the program from SOCK_DIAG(7) with
> some slight modifications. First, setting sk->sk_rcvbuf to INT_MAX
> using SO_RCVBUFFORCE and then secondly running the "send_query()"
> in a loop while not calling "receive_responses()". In this case,
> the value of sk->sk_rmem_alloc will continuously wrap around
> and thus more memory is allocated than the sk->sk_rcvbuf limit.
> This will eventually fill all of memory leading to an out of memory
> condition with skbs filling up the slab.
> 
> Let's fix this in a similar manner to:
> commit 5a465a0da13e ("udp: Fix multiple wraparounds of sk->sk_rmem_alloc.")
> 
> As noted in that fix, if there are multiple threads writing to a
> netlink socket it's possible to slightly exceed rcvbuf value. But as
> noted this avoids an expensive 'atomic_add_return()' for the common
> case.

This was because UDP RX path is the fast path, but netlink isn't.
Also, it's common for UDP that multiple packets for the same socket
are processed concurrently, and 850cbaddb52d dropped lock_sock from
the path.

