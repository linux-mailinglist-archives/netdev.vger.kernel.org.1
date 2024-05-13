Return-Path: <netdev+bounces-95829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AF98C39BA
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 02:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0BE1C2084C
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 00:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630C88BF6;
	Mon, 13 May 2024 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0IelIiD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D25234
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715561277; cv=none; b=tlu8QM7dZANCXtenSY0+jSPQ03AiXr/xODYksWcU37tB2EwW4XR3KxAagaXz/7/YFVxx7MFyaHA9zM6wnaXrzxLU0u8dFLkY+/kcDrkZZY/Bs7uf41ZZ0DIQKGN7bSuxUaEoyushys6U/J8MalXmXEgVFaozGMUVHsgGemVSv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715561277; c=relaxed/simple;
	bh=g/GRCiSHRBsQ7M66A47eLdpCBlOs2ctDx1Et/zMhAQ0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nHBECgkAwciuT9iwWPLOz2zKl2nyAqFF2wk8UUbeqqVwV3fKbSKdexnECK1//lQbXjBsAa+S/1/9DxRNYpD1H9TPC7CfXNKs55MkOguJNp3Kgi4I8fhfvz/NoM4JB6zw2AtAy7YiDWA4oBkgLsL6K3BFNld9YI23mXKNI1Erao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0IelIiD; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792bd1f5b28so407527785a.2
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 17:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715561275; x=1716166075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQAZhG1VejboeCmH5UhDO5lz0LWCXGhIs3htyfC6ycY=;
        b=Q0IelIiDoCbYtcsVSw1hIudMMUVH7v8O9LuTh83CF7GQofG9GRxqyop6ZWBkkBno5U
         kDx1/Vcsq2yMMLrQ9O71srPh5hGotP1XP+heohsad35Nd0QdGpxIz0oIxidJvnaxC5uU
         o2oKuIPACVSdqqIw9AhwpwMt1c8aKcCRZZt+D2AU+rtjDCQQ9oEwW8TDM9fcldPSA1Di
         snnxeTh+z6+8RApltZSDn4cTSMBPxjjstenPzhoobBroDfhjtsTk634eQxd0nBPu36Xg
         8Fj6HD/GBf7Ld28INXd81aZemNPFGSbWi5EIcnYLjO+IPYv4DR/tXp+DJwQ/KXfiX7RR
         NZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715561275; x=1716166075;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kQAZhG1VejboeCmH5UhDO5lz0LWCXGhIs3htyfC6ycY=;
        b=I0GOPbuuC8iqSZLp34QqyEhhEc+cDqXsVyP/yXHczCAUhnZ50GT0PBLNFjvp+H37hD
         uniGvw4rula+HFTnxAGoCRHJ6INFta2qddIv+eB0sOVCGO9zNaEbg+TsxdsOnV7lMlWR
         /ycEybIWIl7ut7/z6a9cJidr0YjCtfRKD7hNpK+enDKWNJmg3iwR8RngB+dvIKIoiYrc
         qZH37uV17dZMM61GvN9v7eMuvdUSLiBwncjQ/q+SY+VqNEq+Qgnchxkg0ziT9q4700Mh
         wwf0uj2pZQnYhEeb1zwRK/VcHBH7utxpZT+zMFauOP+VuoNw5AwvJSWqG+9mp6os/Djr
         TBPw==
X-Forwarded-Encrypted: i=1; AJvYcCXwAOXwenAo3i+bKRSPuKCCREL+SfXGqjqrTk66CXpnMh1/LLF9emsRMpvVvNVoUuPzeqq2gzMZfzaBSrhMWeXwvWekI4g1
X-Gm-Message-State: AOJu0YzJ0rHfVGoKJAfzrhPv6SOSw36cfhI8kYI/xXPew4D/T8BPdW0U
	JRkJOeORRgiP9GcMk6/NTILDIcE0375Hk7dKBhTBjHT0atDaNzfp
X-Google-Smtp-Source: AGHT+IHa0CPYyO+tNHYkLVHh5YDFzWyJ/iv7gTuhAfViRVYN9M9Mv0TUyvG8N3T/cUymwjeQumEzAg==
X-Received: by 2002:a05:620a:1466:b0:792:ba08:17c2 with SMTP id af79cd13be357-792c757749amr984717185a.8.1715561274642;
        Sun, 12 May 2024 17:47:54 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf310c21sm403943485a.111.2024.05.12.17.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 17:47:54 -0700 (PDT)
Date: Sun, 12 May 2024 20:47:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <6641633a1cdd0_1d6c67294eb@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240510155900.1825946-2-zijianzhang@bytedance.com>
References: <20240510155900.1825946-1-zijianzhang@bytedance.com>
 <20240510155900.1825946-2-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v3 1/3] selftests: fix OOM problem in
 msg_zerocopy selftest
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
> on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
> until the socket is not writable. Typically, it will start the receiving
> process after around 30+ sendmsgs. However, because of the
> commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> the sender is always writable and does not get any chance to run recv
> notifications. The selftest always exits with OUT_OF_MEMORY because the
> memory used by opt_skb exceeds the core.sysctl_optmem_max.
> 
> According to our experiments, this problem can be mitigated by open the
> DEBUG_LOCKDEP configuration for the kernel. But it will makes the
> notifications disordered even in good commits before
> commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale").
> 
> We introduce "cfg_notification_limit" to force sender to receive
> notifications after some number of sendmsgs. And, notifications may not
> come in order, because of the reason we present above. We have order
> checking code managed by cfg_verbose.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  tools/testing/selftests/net/msg_zerocopy.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
> index bdc03a2097e8..ba6c257f689c 100644
> --- a/tools/testing/selftests/net/msg_zerocopy.c
> +++ b/tools/testing/selftests/net/msg_zerocopy.c
> @@ -85,6 +85,7 @@ static bool cfg_rx;
>  static int  cfg_runtime_ms	= 4200;
>  static int  cfg_verbose;
>  static int  cfg_waittime_ms	= 500;
> +static int  cfg_notification_limit = 32;
>  static bool cfg_zerocopy;
>  
>  static socklen_t cfg_alen;
> @@ -95,6 +96,8 @@ static char payload[IP_MAXPACKET];
>  static long packets, bytes, completions, expected_completions;
>  static int  zerocopied = -1;
>  static uint32_t next_completion;
> +/* The number of sendmsgs which have not received notified yet */
> +static uint32_t sendmsg_counter;

minor: comment typo. Consider a more self documenting variable and
drop the comment

static int sends_since_notify;

