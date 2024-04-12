Return-Path: <netdev+bounces-87403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D767B8A2FD8
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92346282181
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 13:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30C385289;
	Fri, 12 Apr 2024 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="M0rkQ086"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AC384A40
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929779; cv=none; b=fqqxAcpjA7VHXU6hQVoIN29h8LvI3m2jWlcX7FnJpv73rpOgDqGl7zuFPhOh3T9JacOAWCubFayoq+8y48ME9VkFC0jdI9ylW+ZNQ7uHwTkrkaJCMPUTJ9+SR47OSYf+xBWYsZcynx+RIMN/IMkidyG+fD98TdN72Hj1lErsMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929779; c=relaxed/simple;
	bh=VvypFjy8U9k8qoAbeR6ELxzV7LaJdd0K3vNlzorllcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szJ+n/tgadX6xH4Fsiq+nijAT5WqGHYL/uYwelMMJattmfaAo/oVolnBLBDGN/qDz+ijp+HMiVO77hhdOGvgAXlMu79SMztkTAWlCcZjIj7LY5dPlmy9vI+OGmIjpyX0zP01jzsJKR2dKTl8rTk93pTUGExpWqfF0uExvFD0k3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=M0rkQ086; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41802e8db57so3364395e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 06:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1712929776; x=1713534576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vKY0QfOgl/LqDk220BZi1ROJQwhEEPnxDvr6tFCB+5A=;
        b=M0rkQ0864SYXhrZ252QcOLabm/pxAzIZIUr3SMWcUOg9ZMERINFxjzhwQm7Am8LGfn
         SFGO2LiWnLJaTg/8PeiY7BYJkv/NZ/+p9WaCRXyJWSmTT/AhCV5YCsk+gA97URAGTNTV
         ih13rBWJ6Vler8A81IcmPDLMDz60E8BS/4Aqyf83d1bY4uFv2q88CqrNcvgioFaRCTko
         i6+e7DP/1c/HKXF1GU3+7ZoczP09Ue5fwEWE2Cf9SogdCRvKXcZ908yOrSfFx6rgUUBy
         xV54jGZIe+zc1tsF6EwkzsIRotZMZxFpcOU39qlozJOJ8CQZxS4sRJPGaFuCr0F9JN7D
         XXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712929776; x=1713534576;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKY0QfOgl/LqDk220BZi1ROJQwhEEPnxDvr6tFCB+5A=;
        b=LihDlGCYCPMOO20crqxehbSVkTGJnkPkD4njxjEi2CtxPwHkQwhvDV6u5wJ//cK8ZO
         3eKnHqn4HD6oR4VBIBcBIDVPHt3gD6CPNQdKHMcFY/QKWt+g2Y/602gGIf5OYjt+pQVj
         BOgcpPNRVQn9niARH3q3fwzBc7lTh42zjjBSN5VexUdaLFuvfIjkwvv4gQxUnV1u8BCX
         E0P9ypO+06rMZr7E6CIUQ7+8Mk+0/EBD9HWKdzW0PcX9SgMpT8IyHxa5Js8B+Sydy+Qx
         gZ4vDzEWqrtVWlf2fxWHzKQ4t55HoTm5R6nRkm51hEQX0ozFsAkk1igpzj8K03QMHl22
         8kAA==
X-Forwarded-Encrypted: i=1; AJvYcCVvcZw3YjYCNnT3mygwI1zbNKhyzzAGP/ITMGcJ7H5xrJEJEEuWNr3JnEGmaN/nYg7KJTAQBQLp3EI7ZKwqK0xtbRJAY/Ng
X-Gm-Message-State: AOJu0Yz4/0B0tNAHiN92TnOMHgJZgHxCI8vnn2ZfqPASIURF1Bk/xAJr
	tnxBubYGwH9NDGtOyQzTDAgRck23gLyg9YWHFNizcLksCPYXQp1mGGNG7jUxXPI=
X-Google-Smtp-Source: AGHT+IGb7dyiW20O15CQPiZkrKgOr3kxmGR2QwUWAfP+ABmeHc+M7x6zVBI7+Wo/JeooYHNQPIQXfA==
X-Received: by 2002:a05:600c:314c:b0:416:7460:6867 with SMTP id h12-20020a05600c314c00b0041674606867mr2299401wmo.26.1712929776108;
        Fri, 12 Apr 2024 06:49:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:309f:895d:c00e:dad3? ([2a01:e0a:b41:c160:309f:895d:c00e:dad3])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c299000b0041644e9f3a9sm7084079wmd.0.2024.04.12.06.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:49:35 -0700 (PDT)
Message-ID: <c40ada3c-595c-4948-8a2f-ab96c9755130@6wind.com>
Date: Fri, 12 Apr 2024 15:49:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v10 2/3] xfrm: Add dir validation to "out" data
 path lookup
To: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
 <274c82dfea0d656f59f69ccaab46d4319f0ef54c.1712828282.git.antony.antony@secunet.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <274c82dfea0d656f59f69ccaab46d4319f0ef54c.1712828282.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 11/04/2024 à 11:42, Antony Antony a écrit :
> Introduces validation for the x->dir attribute within the XFRM output
> data lookup path. If the configured direction does not match the expected
> direction, out, increment the XfrmOutDirError counter and drop the packet
> to ensure data integrity and correct flow handling.
> 
> grep -vw 0 /proc/net/xfrm_stat
> XfrmOutPolError         	2
> XfrmOutDirError         	2
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

