Return-Path: <netdev+bounces-80732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDC4880BA1
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 08:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8544283EBA
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 07:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DAB17C77;
	Wed, 20 Mar 2024 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0cnpYdD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3B1EB20
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918102; cv=none; b=tp8UhrF7111aAp+yyfLqFHimDnEaJRX369qoAs3tyLdYpleuzzUdREQXIlAQ+dHE/GieoWzaZewS2QfNM+lVIBW1IiFDeuqLlcQ1cYpryupq//oSzZMBg/7/oUeqkQybMlsWmMQ2632BsHidFG4NIW206vmdnKifVu5MoFi69jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918102; c=relaxed/simple;
	bh=r7oWTzYCjB6Df53mfwmPSNXsaN4ZeooXf0nfVRJIfr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9FpEp54WPrNTo89hMxXWViKy6MPnCM1/M0UYHvnp4RMF1PE2D+vYI/TUBiU13EsYoGMCAbYqyhxvnV8O4DwWVhQ3ZitTcJgNzAUb+HX1oY/6brXFnOrFCnbnOZytJwaY3lt33O1nTwM1u830/zWi1w44sORHmstBAbcHegl5/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0cnpYdD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e74aa08d15so931155b3a.1
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 00:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710918100; x=1711522900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6lNl/xkUfLseQsaqmJTuBBi+Fyq2VcwMN814gbky8c=;
        b=W0cnpYdDVshed/cAxUMtrLzwN1boPC5dVx0ayfjbyKt2cdEklcFvhoHxJwJauP5eHy
         U5VHVrOcnBF+hptv1HpZJchx27kAk9sg8wjSlhE4FwcIeMe15/EOkE2aJW++0C4QDpd5
         Ry3wmlY87gzr1F9oQ4DdUtDEmjopFWdrle5jbwAun7hTv95Ka1LPHGCDOMWYOOjkXsYc
         n/BmkQntJiBKJ8izQ/XDdPI5H6iz1zbcVwd1qDuMf/AW3ViKIdapQAvJYZHwgtAff7XT
         lioMgT656WcGmcXqdBm9L+faDofcQmYybwieBqHRoQpKHp7V48KVr7w60BrUDf21hMap
         cwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710918100; x=1711522900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6lNl/xkUfLseQsaqmJTuBBi+Fyq2VcwMN814gbky8c=;
        b=B/mbMUSQVoPD1nE8xPN7UMiKxYxTenPrkrFrs1WtbDcgtb9tkvhkSdr/WtXzt8JXUC
         yHPfxEFZNCmFo7k7qgkolziTrLUf8x2IOTUNLeWt8qpR7/dDT8eTP6jIdyfluGp65rMj
         Z4bTSAbUJouzm9ka1s7umK1lo8qh/fv9ZtdItrMF+zC6Q5DuXlHsV18VGW9RUzDiPTH8
         7fWuyFIjqyp7IyHRCMFAbC6Ypinr5O/Qey+RYAsIgA2W7qLz6N+ItsH2D/CTX0qOsxbx
         N6AflBy2eaq1pcijlx1bAPxyoJMbYEV4QLmH+BquAOugt+xtBUAXwH4M7/q++I09KGQk
         He3g==
X-Gm-Message-State: AOJu0YwTwmU8cZgnsVrqDjVzAjIwq3tMlXeFD/O/jzhs05qvD7Jo7bpV
	gE8wqHnS9pYOBhBgCjShlhecm+Ifpi40Jw83FPe5OEQ11jdQxjlT
X-Google-Smtp-Source: AGHT+IHzNzo7FwKEldfTDx3FGgDzzhFFQhxFBjM6vLEXL3EgwdJp8Lefk14hHafYOFVKX1F/L+mZUw==
X-Received: by 2002:a05:6a00:b55:b0:6e5:d3b9:2d06 with SMTP id p21-20020a056a000b5500b006e5d3b92d06mr6152503pfo.21.1710918100532;
        Wed, 20 Mar 2024 00:01:40 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a24-20020a62d418000000b006e68984419asm11288921pfh.105.2024.03.20.00.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 00:01:40 -0700 (PDT)
Date: Wed, 20 Mar 2024 15:01:34 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, amcohen@nvidia.com,
	petrm@nvidia.com
Subject: Re: [PATCH net] selftests: forwarding: Fix ping failure due to short
 timeout
Message-ID: <ZfqJzoIOminBdWCe@Laptop-X1>
References: <20240320065717.4145325-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320065717.4145325-1-idosch@nvidia.com>

On Wed, Mar 20, 2024 at 08:57:17AM +0200, Ido Schimmel wrote:
> The tests send 100 pings in 0.1 second intervals and force a timeout of
> 11 seconds, which is borderline (especially on debug kernels), resulting
> in random failures in netdev CI [1].
> 
> Fix by increasing the timeout to 20 seconds. It should not prolong the
> test unless something is wrong, in which case the test will rightfully
> fail.
> 
> [1]
>  # selftests: net/forwarding: vxlan_bridge_1d_port_8472_ipv6.sh
>  # INFO: Running tests with UDP port 8472
>  # TEST: ping: local->local                                            [ OK ]
>  # TEST: ping: local->remote 1                                         [FAIL]
>  # Ping failed
>  [...]
> 
> Fixes: b07e9957f220 ("selftests: forwarding: Add VxLAN tests with a VLAN-unaware bridge for IPv6")
> Fixes: 728b35259e28 ("selftests: forwarding: Add VxLAN tests with a VLAN-aware bridge for IPv6")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://lore.kernel.org/netdev/24a7051fdcd1f156c3704bca39e4b3c41dfc7c4b.camel@redhat.com/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

