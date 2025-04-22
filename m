Return-Path: <netdev+bounces-184786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B102BA972DD
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8EC173588
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50C8293B65;
	Tue, 22 Apr 2025 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJdRDl9i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645F2900AB
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339790; cv=none; b=FYVz3z6LA/B3ygH4wTV+liLH99Lj0O/LIk4LWVuoh0/VLnMIFdp67VR05JO8zR1mLF9hA0D82Th7CwM6OK/rh3TVzPsz7mYwsKaEgaGJf4Z3FMCBYqkMjgNApTJv2p6VxgBdQ/2OK/SVC7c+4FWQtde6iPoz+dvm2xex2s8iGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339790; c=relaxed/simple;
	bh=b/SOpMGjLbEOxepLw3Yx1X4fTeOX1MUXL5EOgZkj+oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR29rd6DO5d47e8wO8owkXWLotn1RvBWBd3XOyGYAI+Htb4MF8uYRo9kX8P7h4fVWQxsZ8jB4k0GYujEisDw62nIt4xukbni6B5WvZlnfnM+M9XsTcUVhriGDPEcVQrc1N+8qa9dHLOwSuJhC6FAktRlxauVtpqmFuYfkQDoSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJdRDl9i; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736b98acaadso5134264b3a.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745339788; x=1745944588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jjv19RP32slCxDiB3HUggjCBjxZ3dmJqul3pXWqIvrw=;
        b=dJdRDl9i4Re+Q6eratRcviqlVpPqAzWeZyLXtDQdH5HE+ykhFIOcIG5FwYRt8PxYn6
         7rmYVMxIlpiraSRzyKFByCZS9ILur9XKzakNEB675/CHm+i185U8Fqnm58dAR3OWox4H
         Rg2rBtgxgrdxRqNrvUm2/gNdGgulSAa2iPGibiNOai+hSGyJrHAKzaQVqg+42YcYbbex
         dlirH2QLA/+vn6FqVkHfhPVAYpeqwlWu6aj2h/HWaOzT21acwKG5z7rBfz1aAWD60rdf
         shE8w4bwhIwsMuPvXNAy7RaBRfAccutO9TZZMymDwdHigaqKK04QhHpAEFUgSSuQJ+5l
         Dcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339788; x=1745944588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jjv19RP32slCxDiB3HUggjCBjxZ3dmJqul3pXWqIvrw=;
        b=r7MtNZbrGZJmarn6nFaxknflRSSVsobh7WirBWk1FxT30rFAy73NOLL2MRnEW5Ys5J
         QxKW+k7WK96ql2rhFBOVlQUkLDz4W2coB0wfX4hL83Hp5FEwe91HW0zpNMVcXcXcRB9U
         zVGZG5Y6OJmELzPbJ3Xh3zz1kHrD48ed0fv0B+cdOCUUcq70bnxvZQikBT57uBI9fy2M
         ARe2nh1sZ4/ZNR+pISFwZxYyhGC8ggTqG/zptP06hIkSjykHeJ7w6srNl1PT4RtObZ+w
         7n88YN92kij6a3ZN0cgBeNl29SMOXEVevPG4iwmfl9FZf9BzQsALg+Hox5OWlxbTGO+g
         V/dw==
X-Forwarded-Encrypted: i=1; AJvYcCXd05L2UcCwFBebB0wR2qVr9/u9UwGCYlOS45RYlMiy75rE81EY43hMkBqQemzPxgWB6HY3Z80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoFdCxaD5brQuh1hBmOXSbFmW8JJ1Cgnpy1gJHXDeG+koy/qLW
	wlvLcPcok/VoRnDuKisdI5MK+L43/2UPf2Hmhvd0Gz9IEOW7Mis=
X-Gm-Gg: ASbGnctUvuJ96TKEnRI9ot6AdrX4cdCH5KdWm2ktkDDgboFVQJk49AlW/FPIub9RhS0
	BtNZLqCos2yEabNTdqsGPn/7zHapUOG9fURHWDWlknp3D5qb94qMDpHms7iyklrLdxN1H+Ws7b9
	EwSxIPjpRls+rL3UPriaTyYjjOvRDXSiYGuN6VlNCggOxl6H8lM96ufo8ZdMFX+LIjX2JcWzPFQ
	FjKfNRHMFbgqaujXdwsrWiiDsX5TdYlx4DDmVqF9FW8HMGQi+eoCoFQFsLycR30kIk0XKzm/AqH
	4bpa8YnA3FBJ4uTuroG8p6aNBsA9LyktCcqsXVC0
X-Google-Smtp-Source: AGHT+IHavBQeaiI5gxiHHi1AOhk6Vg8smx0Hiwk/+yHxS99KzKm1EKf0+ZNjvXtHx4uwb5w2SsCbLQ==
X-Received: by 2002:a05:6a00:8d8c:b0:730:7600:aeab with SMTP id d2e1a72fcca58-73dc14e01b3mr20551819b3a.13.1745339788220;
        Tue, 22 Apr 2025 09:36:28 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbf8e13e1sm8867248b3a.46.2025.04.22.09.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:36:27 -0700 (PDT)
Date: Tue, 22 Apr 2025 09:36:26 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 21/22] selftests: drv-net: add helper/wrapper for
 bpftrace
Message-ID: <aAfFilVul0zbE20U@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-22-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-22-kuba@kernel.org>

On 04/21, Jakub Kicinski wrote:
> bpftrace is very useful for low level driver testing. perf or trace-cmd
> would also do for collecting data from tracepoints, but they require
> much more post-processing.
> 
> Add a wrapper for running bpftrace and sanitizing its output.
> bpftrace has JSON output, which is great, but it prints loose objects
> and in a slightly inconvenient format. We have to read the objects
> line by line, and while at it return them indexed by the map name.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/lib/py/utils.py | 33 +++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 34470d65d871..760ccf6fcccc 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -185,6 +185,39 @@ global_defer_queue = []
>      return tool('ethtool', args, json=json, ns=ns, host=host)
>  
>  
> +def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
> +    """
> +    Run bpftrace and return map data (if json=True).
> +    The output of bpftrace is inconvenient, so the helper converts
> +    to a dict indexed by map name, e.g.:
> +     {
> +       "@":     { ... },
> +       "@map2": { ... },
> +     }
> +    """
> +    cmd_arr = ['bpftrace']
> +    # Throw in --quiet if json, otherwise the output has two objects
> +    if json:
> +        cmd_arr += ['-f', 'json', '-q']
> +    if timeout:
> +        expr += ' interval:s:' + str(timeout) + ' { exit(); }'

nit: any reason not to use format string here ^^

