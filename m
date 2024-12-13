Return-Path: <netdev+bounces-151897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 250A19F181E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 22:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D89188C59A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95E218D65E;
	Fri, 13 Dec 2024 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="x5hzqS6w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50884039
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126348; cv=none; b=YNNrLYd3oDkJF4kT7kESxb5uwU91fxCqWhpXzFRjHByETGrB/kDPQIhkeB7/OjDO/sQ75925oOQrqKOZFwDvA+vMlUkBuzPpsoiSkaVeDlKtBUMM6qksmS6PJOdqkVUGlPlWCkHmx3OHXgOFiNGKfi31EAb9voOFdbHzrMxKIzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126348; c=relaxed/simple;
	bh=Oryo4DtHAVCGKdnoY6tLSlqxkuo/p4102xzFsZVhqiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8Lj4ioLDSS6dUizx2LhMpUema6zI6VAiHCB5LWZ4eTsVjMA21tK20oG1vHcj8KrXcec0Ow+ZG4L0qH/qBQFC/teEIrf2QQLMX0jQ6aQwjAUqclVR7TURwOaKJzCL0Bjcaq+NBcde7INJok9zwe4VppFsP7cxQVGEp7Fusy7TiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=x5hzqS6w; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728ea1573c0so1960485b3a.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734126346; x=1734731146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNmC3cu3vg7MxdQKYj5V+QpCbALTvxA0H8jo3qwt7SU=;
        b=x5hzqS6wN5h7PgeWHmETfYEE9V+8r9laVbUq667lVVC2mLXewIpeNz4L09cKZ+KDcX
         Z3T8iKlD5IU+DCDbLz7MGZnr3phMBPTgu7mp4+IG5pDvkenAot1dVwu8e32IDbND4FYN
         6+i5/EjgSjREVHZjh4Hh8V7O+Gw9lPDlRrAtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734126346; x=1734731146;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNmC3cu3vg7MxdQKYj5V+QpCbALTvxA0H8jo3qwt7SU=;
        b=CZZ2k+fYm3Z2xmIjsxomElq+mIvuAegn5Als78IZ2MV0mh7mFNt5RtlR+xmvOWzCHs
         wlPKSIBTIiYIzs4S0rex/dw6FlTPPcLtsTukEwagk9U7gqoY63Qf3zDtGqqiQM4C9EoI
         udlUY91F0huiq0X6Bot5+GRf4hMinG2Z21wGDGiSLJCptRAqIw0y8vOMailMNNblHmYH
         0OddsMC8Vo20yjnB4fkeqBK/3YToaQkDqdNSefDOsCb3Ws/GzC17qvOjn+N4vdZWEW/N
         R+T8XE5Qt+GGRnEn/Ke1Ogbw6n7NpYApQeaKoRuSE2KN/Z3OvKhlgvs3fAcpsBrqjovq
         GfbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpvU6GERKaid5oARDhBNDqLqgKkUO9n3UCYWbWhU7/Dkxnehel4A7ZgsOH1ZNXFCoIog4tBpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFHQCHEimQMSFOIJ9BBXMbfkCUFvzwy8xmp64UZGCD6l2qZRVk
	KgfHoo5KbwFmohCKxbxFBLTvA+FqjJTE10LTe7Fi70YN4aNcRoDifSRdIy91+NY=
X-Gm-Gg: ASbGnct8cp1aDSZ9EsYsuY4kqtDsSqwElaeNy1IMS7elkOFsu2O7p0qpoYmrXFcJ/RN
	QOhqLUD04Ps8Wy2zrUNSLgJCNDsieMUTZg1P9zl/9+EgVgXHin0cdkTAG22CLBVmJxFpjw0RIVK
	AAeeEbGsHyrdaZthkcw7c50EvCZidvcIrOUG+UQfgpO1lU+87l1/720ojDjPb1wcHqdOTgKUAP3
	rf0CXleNrRy9HDesukyqK61J9JRmnq3tFCLdZgEyQGEYnD5O6mS33kYR8KsX1PMkIeLlSnMblW/
	3qTV5Fr/7t73GNElRZJ4sjOAuHS2
X-Google-Smtp-Source: AGHT+IEyY6hCf68I/LqyLlYNBGakzhFhyOpexibxD/1qCzc3zUfiI4YpKf6SgafAidVXETSYq8n6Lg==
X-Received: by 2002:a05:6a00:cd5:b0:725:f376:f4f4 with SMTP id d2e1a72fcca58-7290c182365mr5562045b3a.13.1734126346599;
        Fri, 13 Dec 2024 13:45:46 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5bc5sm262970b3a.69.2024.12.13.13.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:45:46 -0800 (PST)
Date: Fri, 13 Dec 2024 13:45:43 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org, jiri@resnulli.us,
	petrm@nvidia.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/5] selftests: net: support setting recv_size in YNL
Message-ID: <Z1yrB6Sid7Modq52@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, jiri@resnulli.us, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org
References: <20241213152244.3080955-1-kuba@kernel.org>
 <20241213152244.3080955-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213152244.3080955-4-kuba@kernel.org>

On Fri, Dec 13, 2024 at 07:22:42AM -0800, Jakub Kicinski wrote:
> recv_size parameter allows constraining the buffer size for dumps.
> It's useful in testing kernel handling of dump continuation,
> IOW testing dumps which span multiple skbs.
> 
> Let the tests set this parameter when initializing the YNL family.
> Keep the normal default, we don't want tests to unintentionally
> behave very differently than normal code.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: jiri@resnulli.us
> CC: petrm@nvidia.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/lib/py/ynl.py | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
> index a0d689d58c57..076a7e8dc3eb 100644
> --- a/tools/testing/selftests/net/lib/py/ynl.py
> +++ b/tools/testing/selftests/net/lib/py/ynl.py
> @@ -32,23 +32,23 @@ from .ksft import ksft_pr, ktap_result
>  # Set schema='' to avoid jsonschema validation, it's slow
>  #
>  class EthtoolFamily(YnlFamily):
> -    def __init__(self):
> +    def __init__(self, recv_size=0):
>          super().__init__((SPEC_PATH / Path('ethtool.yaml')).as_posix(),
> -                         schema='')
> +                         schema='', recv_size=recv_size)
>  
>  
>  class RtnlFamily(YnlFamily):
> -    def __init__(self):
> +    def __init__(self, recv_size=0):
>          super().__init__((SPEC_PATH / Path('rt_link.yaml')).as_posix(),
> -                         schema='')
> +                         schema='', recv_size=recv_size)
>  
>  
>  class NetdevFamily(YnlFamily):
> -    def __init__(self):
> +    def __init__(self, recv_size=0):
>          super().__init__((SPEC_PATH / Path('netdev.yaml')).as_posix(),
> -                         schema='')
> +                         schema='', recv_size=recv_size)
>  
>  class NetshaperFamily(YnlFamily):
> -    def __init__(self):
> +    def __init__(self, recv_size=0):
>          super().__init__((SPEC_PATH / Path('net_shaper.yaml')).as_posix(),
> -                         schema='')
> +                         schema='', recv_size=recv_size)

Reviewed-by: Joe Damato <jdamato@fastly.com>

