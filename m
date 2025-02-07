Return-Path: <netdev+bounces-163744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFCFA2B758
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FA73A5F81
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248B417BBF;
	Fri,  7 Feb 2025 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="smrWzHT2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ADF1799F
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738888889; cv=none; b=W4cdFMgbCEb2tQUSeZTzyAAs8XjZHnchATv/WCU6MP/AKvkwp4WdvxGLCnPDOf/PoLHQ7qpSJU0dtQTRtCfQydqA6EBdbpxXj4q8u5l1WxdqGPYfWWqQmcd8OvJBrOk4zqPqyQINtTED3cn01Wb+cTUn1Ly9xb2VvdTVX7ZztVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738888889; c=relaxed/simple;
	bh=8HYzgZ+yJefb/tKCzmB2sRx4k9O3exnmMZXyc+Sw7L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku+hJXeJg7TjgCtvRDW8355h5J5L10oW5DPNifk+bJdik/9UpVmOgL2p3tTMlmSmChJA6iaPO6/lWy8o0bYrlfu93MfJnoWetdJr74q+8dzDrctHnORwdexo0LaSnoHOoA+8HTmr2tvL1YqdTIlodSqZw0ru9u9KghUdgWea4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=smrWzHT2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f9da2a7004so2432673a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 16:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738888887; x=1739493687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5w7je0K0jBKMjc9ITUEDVeH2TsqEvrI+KlwkmlnWZI=;
        b=smrWzHT28qNGzWC7dkZHQUWU9UDxX78YCWAbDxbWC8boyj9wJ23cRB+0nTvycZbEJx
         YCoWToWpe6wOrYfi1UXwX8lB6DQB+WbPz16n3wbzl4pI/JESgqRwlQ9a2CGld2hWuINm
         8YFjE9m6JnXOCInppv4bsnigP8d6zls23Nzyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738888887; x=1739493687;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5w7je0K0jBKMjc9ITUEDVeH2TsqEvrI+KlwkmlnWZI=;
        b=P0kMxZQMhjl4k9D0debrbahBypL/eU24E4WpJb7C910twFUPh/VZxYCs/u6UKDbNwz
         cWs4IWVNRbZSXVCkKZLWkD0BzqjwsQAC1Rmv91KnrXk254SxhL3gQsFM0Wzf9n/7tqAB
         6Vjs9X2Q2IZFHnEFPT+P9U5eT1hi9WB3ED/4eQC5sQ+AiZVA3DD/Q6gHDKB+fCCEbg46
         hei9tBhV+4PJQfkt3BifR1lPI03yJ3wnNIFEO44n24WOcVpQX7Rn7W6K/rF0pKkW0qmE
         7lNoeA+X8Zva9HoXM67RLvNIDOvv9r+AeMsZE6pIMUyXO1mDHY5r6lMQHCXjY9HhimIX
         mFzA==
X-Forwarded-Encrypted: i=1; AJvYcCWUi4cAhR93vOhgM2qrpd2uMSR/NawwEdmLynFsTMIR0fb0MlqC62yt1E62S58CqYGNsDxHRO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgVy/uEtR5pYhPynoUzN8wBiwlRg9/CivwwMtV1OjweAy9J5+a
	0FeyV5DzTh1p7umogUOWXMOsoDNyyb1fjNDCW1u+8YxVR/ru3UyHvCo4SWAARSQ=
X-Gm-Gg: ASbGncuTaBVCPSi29mmFyk7rVVjNm+wgwMGk/8Aa9797JOxNK11ZFs1JK80fu0/O7lp
	hpZnC7Df752MtoqE/z7VcLvt3AiHYY5XJ9T4Oi6lOSYJG6g5dnSEkShwIcCfTOCMrVw6VL7rUDl
	yDkm7VyP2Uyrxm5+YUwZ6g3Sk36iDPf4iuc0/UKhkbp65+gMzg8d9reBdI/2AM8BSrvEvaMRZfi
	df028dBLB3LnjqD39FhXQLWJqoSMEbolRDAgtiFac6L7RR5/yYuTmgLpRzuWipaXHrEM5YQAhwS
	Ybr9XKkq3GYIjQ==
X-Google-Smtp-Source: AGHT+IEGARW0DmsbyD2uEl3yxj6M0kAOSfKrI5NssZE9Ld8J+uVTzedMfJuL2rpneou4vxSB2FTB/w==
X-Received: by 2002:a05:6a20:9f48:b0:1e1:ab8b:dda1 with SMTP id adf61e73a8af0-1ee03b6f240mr2614749637.35.1738888886780;
        Thu, 06 Feb 2025 16:41:26 -0800 (PST)
Received: from cache-sql13432 ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048a9e0bdsm1902757b3a.24.2025.02.06.16.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 16:41:26 -0800 (PST)
Date: Fri, 7 Feb 2025 00:41:24 +0000
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Neal Cardwell <ncardwell@google.com>,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: rename
 inet_csk_{delete|reset}_keepalive_timer()
Message-ID: <Z6VWtD28h40EB2PF@cache-sql13432>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Neal Cardwell <ncardwell@google.com>,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
References: <20250206094605.2694118-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206094605.2694118-1-edumazet@google.com>

On Thu, Feb 06, 2025 at 09:46:05AM +0000, Eric Dumazet wrote:
> inet_csk_delete_keepalive_timer() and inet_csk_reset_keepalive_timer()
> are only used from core TCP, there is no need to export them.
> 
> Replace their prefix by tcp.
> 
> Move them to net/ipv4/tcp_timer.c and make tcp_delete_keepalive_timer()
> static.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/inet_connection_sock.h |  3 ---
>  include/net/tcp.h                  |  1 +
>  net/ipv4/inet_connection_sock.c    | 12 ------------
>  net/ipv4/tcp.c                     |  4 ++--
>  net/ipv4/tcp_input.c               |  6 +++---
>  net/ipv4/tcp_minisocks.c           |  3 +--
>  net/ipv4/tcp_timer.c               | 21 +++++++++++++++------
>  7 files changed, 22 insertions(+), 28 deletions(-)

[...]

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0d704bda6c416bd722223eb19bec5667df4e7bb7..4136535cd984d85c615a615f8991ce55ad5af42d 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3174,7 +3174,7 @@ void __tcp_close(struct sock *sk, long timeout)
>  			const int tmo = tcp_fin_time(sk);
>  
>  			if (tmo > TCP_TIMEWAIT_LEN) {
> -				inet_csk_reset_keepalive_timer(sk,
> +				tcp_reset_keepalive_timer(sk,
>  						tmo - TCP_TIMEWAIT_LEN);

Extremely minor nit that I hesitate to mention: alignment above seems
odd visually and checkpatch also doesn't like it. I don't think it's
worth resending just for that, though.

Reviewed-by: Joe Damato <jdamato@fastly.com>

