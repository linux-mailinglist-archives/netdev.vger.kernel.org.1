Return-Path: <netdev+bounces-205403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD91AFE925
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7A65A4E72
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF9D2DA76E;
	Wed,  9 Jul 2025 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVjbk3YR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD903597C
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064884; cv=none; b=nnuYgli1r7aI5ahfLADk0LDMep8f6qa5v7GFsCKY84aTnkCZLI0quEbxseMGGj91biRLqYkuT0vtMunpg99Yniun36tfC5KJj9gHhQ1EShxZuQY2e46NOFoXLykUQ1DOCQHU5OihNrFdGWpG/E3wGrxdPIOmnX2frRHevWVW8qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064884; c=relaxed/simple;
	bh=J1xDgOe5cYpweMlyooTsldVxb9cU83NUKvesI7+klJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XE635GmrEdH8ndobAxeps7SNI6YUoBbvdcSQWXxE3jBWK57CVeg3ANKUghhHiWQRsTBaBcFHIoRGpmLHDY6g8q1DEMQkBpmwfKLoddMVYipGPAR7v2CY2MA1MOajHe15Qj8+V3Jz0KmkLNhdyQ6cAiA0uwGzn16PbycbQq04EaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVjbk3YR; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a52d82adcaso81830081cf.0
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752064881; x=1752669681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1xDgOe5cYpweMlyooTsldVxb9cU83NUKvesI7+klJo=;
        b=mVjbk3YRt2p3pvSPcOVy9xSOO19GO7bMl0ByNKqKNU8wAYVgaU0GjiXIBr4C7JwxNt
         yXvnQrPWY64OyR1d+DimuEgNwcjJutztmQnf4MKeISJxEHwzsM045tM7eiuZgajVB3fR
         q+DaiOR2a0Dkz1K44eaVe2etEH50I67skaBB8WAyZ0djgpJbER4SQf/WlAaCTmBgZEwY
         IbQcyk5pzqxZcB0LMaT/Gj4+GuIWrrC1s+8Fi1dEPCY/rk+Vk1HDJmFctAfyhiKK/eWG
         xwnvwEIc1UkKcDKAaUJHRm2GaNdKWe1FwQdw2CPY2ETZmxNLOoWaCk2C0nsXf08Wa5Jd
         AVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752064881; x=1752669681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1xDgOe5cYpweMlyooTsldVxb9cU83NUKvesI7+klJo=;
        b=jefJQ6OQx4IURpvkFHd66rQtlShwxabeX4oUOeKfpRNOwoDUoF7h4oaQNi8LlTDfVl
         kPEZEPe7nLsUMsSZe6Cd9Zhc/ICTtyXj/RKtPbyBlvEONwSkU5rH8FcgguebsqLZQzXp
         53L1WMhAAdLoPNG7/2PFgV8BerpUD5hOioPB4ryh5qekEgCWZA2bauyAWTxs+UspkQl/
         8rHkO8oeI4mZACa4ii9Cu3oh3u9Uh35Z36bEr73uQrQgIaIX49jTVMM4EVn01nrGSs0g
         QJCXJ50mbWIAXPCM4W4qw6cDC6vP/vVMxlMOCBDoDKIO88jMDwvUQ7t0fly0U00deYLd
         v7qA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6WIInEzBmkqD6V9FC737DybMmuG3rjq5/weT2u5JDUdbjzuKAJNtbLqtksA6F/dyaLYlHLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTMdIZGasaBzj44U+ekKSFwxmzFmcqOjmiJil/rRJXOiSGyGp
	CnFA1BIIk0vEX4rydSOYWU7zWjAddKfCwB95uWl25PxTxv6264MS9LmtEfUKMlWQpwLD3uKjubf
	J/4P1Q2GCD/8Dt1/0Swm39QZRnvTH8WgIYvDPV9CY
X-Gm-Gg: ASbGncun8Y+51NWh2Ru6Q6yqkX8pg4O23e9rEqMraQTXvtIC2vVfsXW5s4fBv2yJY1q
	3de4rraoqfkqBRoaHYcGDx5zNlHRoFRBNC4hCntxYj73G1jqaiSPJJb0iXzSz4pNJFSQrY+26xb
	3Szt3meQEQmiP81t1fP8LXRCFYUGbUZf3HninXDqhU7esmubHeMyya
X-Google-Smtp-Source: AGHT+IEWxNPG7dp+DjzJRns6J6sHSmisi7D5RqiV/oaoXwu34B9UVWumWvBNs5RbIYibvouSj9c4f2Zog+T9LOGljY0=
X-Received: by 2002:a05:622a:a906:b0:4a4:4bdc:8b1 with SMTP id
 d75a77b69052e-4a9df26cd0emr26277301cf.19.1752064880392; Wed, 09 Jul 2025
 05:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709095653.62469-1-luyun_611@163.com> <20250709095653.62469-2-luyun_611@163.com>
In-Reply-To: <20250709095653.62469-2-luyun_611@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Jul 2025 05:41:09 -0700
X-Gm-Features: Ac12FXyV_uF0R0COhdOT8k3hZSKG1IgtD3WPDSc04tanY9Xn82wNw8OZjX-_CRU
Message-ID: <CANn89i+sZZM6aRC6-yCRSEZV1UBiaDhvsKnm4+JJibW-xwRwrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] af_packet: fix the SO_SNDTIMEO constraint not
 effective on tpacked_snd()
To: Yun Lu <luyun_611@163.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 2:57=E2=80=AFAM Yun Lu <luyun_611@163.com> wrote:
>
> From: Yun Lu <luyun@kylinos.cn>
>
> Due to the changes in commit 581073f626e3 ("af_packet: do not call
> packet_read_pending() from tpacket_destruct_skb()"), every time
> tpacket_destruct_skb() is executed, the skb_completion is marked as
> completed. When wait_for_completion_interruptible_timeout() returns
> completed, the pending_refcnt has not yet been reduced to zero.
> Therefore, when ph is NULL, the wait function may need to be called
> multiple times untill packet_read_pending() finally returns zero.
>
> We should call sock_sndtimeo() only once, otherwise the SO_SNDTIMEO
> constraint could be way off.
>
> Fixes: 581073f626e3 ("af_packet: do not call packet_read_pending() from t=
packet_destruct_skb()")
> Cc: stable@kernel.org
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>

Reviewed-by: Eric Dumazet <edumazet@google.com>

