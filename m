Return-Path: <netdev+bounces-181164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0420CA83F51
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF863BF667
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6282676E0;
	Thu, 10 Apr 2025 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="u6/NUyqN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82952153FB
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278301; cv=none; b=fD0xMIRSTitTeIMI13Tt0etNrbQp+Qtj/cfYwDkwvpoQmIoHML/o1V/VIE3Pks0Lkyr84TmOLU7KW10APxxu6zzp9eSLa3KWGLstLlXU3oDlcrfOMSNZlvxt8C20nbnCwJARXIsg+Eij2dt4XK17TmSsxVdsQ9eEnbzmsvckCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278301; c=relaxed/simple;
	bh=Nv3DgIiJrN+CeuSZ75EzHd2+/d+VcNDqsxZHfD5vCDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qX3f3viUK3ywIC9ctnIyyLlGPkuZ5HTm/lygVtfGZ4kIOCWhwOW7X7paSf0HQR2hvZCwEhqGTnVkyurkpAtYk53N5Q+DqVKbR758+dLHjrfIv0dyDIj495ojgGOZP1r5UfZLAR5NUBAn3FnXQ74AP3peELrK1ZHOHcAjm7GPU70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=u6/NUyqN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso6983785e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744278298; x=1744883098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRDbM8ywEFZUaTCcyFxEMbta+D3qeG8ISCBM+z368c4=;
        b=u6/NUyqNpMnRXtuNKIknFIx/EWBZc6+5HCwJuwE0aUggYUVPZ56AhWE7IQ344WROzN
         ZQj709vDrbsvAWn/SF+2Lgl9ejAeVmA4+x/I1LOiUsqDJqVWZbr2hBBIlcW3ApKGpsjQ
         ym8iMkEIhvVQBC2/FrSAPjS6V4EL52elWc3LzXu4dq/9Ji4D95R8Hd9xrvPq+qdJcwlc
         Tz2jFCDbHlonctp0+i69ihUKU75IcgUgeDihrGrzloIIZ23MrHwE2InK3jthLFFRdP7l
         tft7jeH/5HdO1qzQyvTDosQF9J7Djy5Uwsw+n0dkndeRwtVRRgbSGFsrp1n0av1TEnUU
         l1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744278298; x=1744883098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRDbM8ywEFZUaTCcyFxEMbta+D3qeG8ISCBM+z368c4=;
        b=m1oKidgenj/3pEw4jIff+wDIaGp0EFPzPDAxB4ghSmd6AQIeYhm8jKHd5BQwvVycvy
         dUn8AqxxeAIgidt7yTe+sWBIkTWVWKOSVrUDvxS89BxJNUB1amT5ZhrdNhaf51Cq7Mxz
         cPT/agGIofh2lygD3YCjOzvHrObjD+JHstszG2jpsHGfdj2D6YTbIc/IhB0y1sn9Pfqb
         X+NauLfAQ0PoZTmUnPNhfUMlcJauE1caPDrVBEBKv6Ry9pINaqnMd44bXecDRtveDAwR
         ud4vUhom0yFl/KsZXnSfo8dM6aHpiu+ShGWlMG7mJu2w10egErbs/dMlt0vt/pF2pm0z
         BXDA==
X-Forwarded-Encrypted: i=1; AJvYcCVhyc7l/x6dJMk4FAI8on6r94yqkHw2BNr0ZznOUtgnbSg5+XxADfTDLS4Euql/fGWChtG8/Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBL7i/jCPlYU7bYNf/4KfXQMsWVTO3Eo2Y+N7kBzsrfW/qcj9p
	QPyvUayRHlbQFihnCHEb2bCL/ymGRuikyOvwE0pCJz+CPkXJOoG0FMDyWQM3zG4=
X-Gm-Gg: ASbGncv5h1IGZZ2TXfD6xRX8YE1CDd5C01hxl3y9Ixb0XlXwYrebixWWO5e4BinP9aZ
	Imac8bsm+aavI/RwLWCDnEIGiAYniaiL3fTpieKPTc1cKJYoc2J3feVKLJbCCmCqFCSFMOTeqm/
	HZTsehq+u6Ls9z5MONOLJ1Ee11Xn0O9Kd6mUOAfmgS+Jac3rEZL49x/PDgBwsHrQqEcuroWM4M7
	B6AcmrO0sPJlXEYCeHdXRi84fyEOwk0poFWin5r2GwZ1PKWFgpfwFAKYB/yFReJ45XNl9VY83Xq
	+ERTBSc9kcxHC6rtAX1E/75a0dZ7MVypKWqgOE8QZa5uWYnVBS7/lI5FUpShID/LXialffZt
X-Google-Smtp-Source: AGHT+IFX0JlVauakPZPoRpgxPfxML6W/G6P4vNe12L4C2SMMjWIhCwbN4pOwoAOQCsSTa4mPpsbwxQ==
X-Received: by 2002:a05:600c:c86:b0:43d:22d9:4b8e with SMTP id 5b1f17b1804b1-43f2fee0392mr21068045e9.10.1744278297912;
        Thu, 10 Apr 2025 02:44:57 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc8esm49222545e9.30.2025.04.10.02.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 02:44:57 -0700 (PDT)
Message-ID: <10302fa8-9feb-4d20-b0b8-4850037f2f1c@blackwall.org>
Date: Thu, 10 Apr 2025 12:44:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 10/14] bonding: Convert
 bond_net_exit_batch_rtnl() to ->exit_rtnl().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250410022004.8668-1-kuniyu@amazon.com>
 <20250410022004.8668-11-kuniyu@amazon.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250410022004.8668-11-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/25 05:19, Kuniyuki Iwashima wrote:
> bond_net_exit_batch_rtnl() iterates the dying netns list and
> performs the same operation for each.
> 
> Let's use ->exit_rtnl().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> ---
>  drivers/net/bonding/bond_main.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



