Return-Path: <netdev+bounces-237365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1416C49A5F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F45A3A50B1
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 22:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6F42153FB;
	Mon, 10 Nov 2025 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRX1C9ig"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6163635958
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814919; cv=none; b=Gru4zAypV6qIf+3lULWE7jDSJRAhxzoRKM0Nb+Nq6uZEGCXKyHjFO0pgePKFZKkkLmrtHc7irpdBmnT31WtoMmtSILk8T4YOpigR4iaomeSXRysuzIGNHt6xgzklt5GpVypWFMwMW4AlizGQWru49ZFCm1ayrvpSKy5FxRaymCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814919; c=relaxed/simple;
	bh=wSFL8ejyxW7kMg6dR7LSCkpCUCxvuFHLLetgwPrZcLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqLITboig3/OUOqNYnUKpkkRIfbfzqXu8rr/gi5fqd1/K5KeVoCFEv6L2+SG4BD7+NjVl16jZhPJx8EKF7GTRi7LdhK5ZnLod7edoK2SOBEFsb0u0eLxob19FvPfXL9qj5pwo1ClL2Ai5X3M1U1jBMIczHCnN/83db3VFX7oZhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRX1C9ig; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34374febdefso2567330a91.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 14:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762814917; x=1763419717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzUd1xsf1Cz/NsknbALQRdXioBMZnJ6BlcUAVgh0Mj8=;
        b=gRX1C9igqhIEKlL8y87ktLAzEXjPP2bGjdc8n6MP9PdOIRRuM9hJwCy1+ixC2z0fGI
         IKXH4pcdkJnFJQq7+eXpbENy4PTYXCIhrXXULvUco6FSIE544b5MHdskzq+d4PrCO17x
         wjjUyvI1H1N96w0KqH/OZsnJKjxf6NNz+eIPS2hbBV8jMPkLAz0SBDqr0QwN+OunW7AN
         8aYyqh0mZtMso8HwFLx/aHhReNaMYeYb6UQ1PggXgYrMYAWx07ph+rThKgRbpahhPn8n
         rGu+1U003g6aXY42XVDOqMIDOZDPak8SZQ8n3kY90xayNvSK7BASyHWEK2m8R6Lvusb2
         uAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762814917; x=1763419717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzUd1xsf1Cz/NsknbALQRdXioBMZnJ6BlcUAVgh0Mj8=;
        b=uhiAmmfufuihduaah/5KDnJdPdeIEz4e62rJVUOV8a7UOI2dbK3dTTihvVWwZnDntq
         n/OcfZbn9m3IezoE4xqqpEGIkh0N7oCzcFRCddHbYPcbB7aZbZhXFpeKPH2sLXMNjgqk
         7tXw2i0P2AVIdjlEfSEjrIKEBFLuiG85iRyKmQYcZY15+bqCmzKLiqohquHesNRk+87D
         c+LfZz4MbA7++M5rqJJNLbVSQltBSsXSTrC/MVaol3i4rN70F9jORW2ne6u1FLxgwwPf
         juDQdIJlACtJlL8nGP8HVNk70JryACQqkFG8HiQAwoRdtVOCtgbr7KLVnv9MJcjggo8S
         fZGg==
X-Forwarded-Encrypted: i=1; AJvYcCVByQhrFO+fomQsnBBpgQw5bxWX+3l5ailU681AM6VkMWfRp4X+XCuZD97JE2lkf5w3FpCY0W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfMH1EHgxlz61icLm1kE9se4uXui5nVXbezFIxwL9Ld3Tadef
	67JRitHIhiqdFRNUHh2BY50nTvGYA6l581GBMFrTv6ME1gMZE4eZC/L7
X-Gm-Gg: ASbGncvbmNKGnfRUsyUB2Bvkv2PRRGnrS6fgTkZqu6TEs2KBlIbg6QrifJeto5x/DML
	0mzOCT+bWdzHGaUzKhuSS/4ieD/WOGCoP6uiPFgWMXE1NhF1Cgzd06fc00jeh6u5PbCRdTZvxZi
	eI/9mO8YKjO0bOFZcz8YEdv6mVRKZ+fDX5IcNJNv3DIVBcUArkW1bABcfTs/iDAYqHfI+H1bk4P
	7y2Jg3Aojh9kzod7IcLLpK4qb2sVpUsoRjeShMdYudvdB4oYekCyYlEWWIa02SRYxRWkTScq33Y
	u7ggrzS809C1EPw7NV0FO5781n66yCleY+oq9Rkf0zOktCi4X6qN7458JL0ZRXdhB67krg+P8C/
	lwqxPatw6py6hGgp9UAHWHPjWukP7HgdZTwg4YKX2xk/3KNaNJohmyn8XjhX/WVx9QvzyLDoVii
	PNusw=
X-Google-Smtp-Source: AGHT+IEqhmNhFjSU/TmuvVKV3oS9D8zng/3u9ekiILntszQdgFXnCgx2RlGYStMyxlYsguTLuNUMiQ==
X-Received: by 2002:a17:90b:50c6:b0:341:194:5e7a with SMTP id 98e67ed59e1d1-3436cd06567mr12255278a91.29.1762814916821;
        Mon, 10 Nov 2025 14:48:36 -0800 (PST)
Received: from localhost ([173.8.162.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c31d86esm12473316a91.8.2025.11.10.14.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 14:48:36 -0800 (PST)
Date: Mon, 10 Nov 2025 14:48:35 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org, wangliang74@huawei.com,
	pctammela@mojatatu.ai
Subject: Re: [PATCH net 2/2] selftests/tc-testing: Create tests trying to add
 children to clsact/ingress qdiscs
Message-ID: <aRJrw5vMAwPKqJNP@pop-os.localdomain>
References: <20251106205621.3307639-1-victor@mojatatu.com>
 <20251106205621.3307639-2-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106205621.3307639-2-victor@mojatatu.com>

On Thu, Nov 06, 2025 at 05:56:21PM -0300, Victor Nogueira wrote:
> In response to Wang's bug report [1], add the following test cases:
> 
> - Try and fail to add an fq child to an ingress qdisc
> - Try and fail to add an fq child to a clsact qdisc
> 
> [1] https://lore.kernel.org/netdev/20251105022213.1981982-1-wangliang74@huawei.com/
> 
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.ai>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Cong Wang <cwang@multikernel.io>

Thanks

