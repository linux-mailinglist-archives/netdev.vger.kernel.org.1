Return-Path: <netdev+bounces-179197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0B3A7B1ED
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 00:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118D71894898
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6051A254E;
	Thu,  3 Apr 2025 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeQZU8xb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B9161320
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718254; cv=none; b=sD5FjxPFmgHzMTJQGt7BUr8CPzwcNWksgDnQ9cHdn047McxU08BBJSYsH5kjFl8uWcHvVHEiCV7k264uroU7SIGH1vYYDDkKR20ThgVsc3NGS+vZhRkZizN8fpi0fATbHXZLetN+aldkGLGsOB8/2+8gnzWg4Jl/Q7h0V9Vw8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718254; c=relaxed/simple;
	bh=KxcyHQ5GwXehTashBkvBpQWrHTU2AjmJDuaE9V4rGNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F45U6XLaS+XFcR0RiOsXytq7NK1QEkQG+63HZLBtt5BMyfrRXpK0LHsvYJ4X8OEa0YAoc6SalN6jH+pJYUgM54BA0HzYIKUOyeF35OutEm7K15HeBBz6QpW19+hzBS1DCR8AeVRHBH+wTQp3Sd+3jGQqMNW5EibTT2GvOZ4YuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeQZU8xb; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af548cb1f83so1299482a12.3
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743718253; x=1744323053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xrJJ67tnSxIkqSC7vF2ewZHoRj6tQeQHJJDf4OYEMAo=;
        b=WeQZU8xbBQM0SRmkqdMVrgSLelqowLX3ykC5JLtUSvogIPkjSxLkKgQmEpVW4Zg06e
         2M9U6VfBl8+cIVNewf4a/LPIQ3QQ+d40jG1XSpxgZCV3didLUzuwdhvmFC2GVFythnU+
         ExiaKLzW1PFKjVprvbg7F2OscnCyTfHmXMx1S4E6cy9VSG5Th//75qWz3Z8Y3d/QM7v1
         stqdCCSWSOGbvbua8hQKBeeKJEwZSmJjuZOfAZGiumYZTXOjEwRvmD52Wb2qsLm79NHn
         7LicbOPh+8tG3CrCm5b7kYuIxZmaZS6ecmfl+a4JSiFTFlqml13MWtg4689N5WQJPdZZ
         qxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743718253; x=1744323053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrJJ67tnSxIkqSC7vF2ewZHoRj6tQeQHJJDf4OYEMAo=;
        b=IcUP76nu7+MAVZr6sqE1rHLehS0PCM0n/OGFMFWN8GEZLE/rCL4i5CkYibTBW8wJmX
         SntZts/7zhBcXVfbVPzbQYJxHapOIaq5pzpSOEw0Zgxs9tnUn7MIWqgtibVaiyZ3QaKz
         NwFX5q8qQqlsmlKtfxDv0Vzzfciy1S+t7+r2vUgMpTjlSdInaGStGvzjvY+3S4xFj3bv
         SQcs++D2gBtNa6q9iflxVI8sJ1p548exbiMEmCeF+NdjlqNc/Msxss0/xgFt8/WqCd7D
         JaGvQ9veAeO216MOnou5DkM7ycmSLdYQtoFQslKGOC8BI2QLn89OLuhtXxDqgsN03eoG
         xfoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSDE2iV5G0Frg9sRpQzsR1tCkmT6outGioRh5TCq+bR0kfzA3O2u1hHhxRHup78KMSJO+Y3IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeN4qNvPpsdgz40yMWTGjD1QsZ5FYPbleBYt9gBQMZU/ImGEhr
	dWqgH6+P78AR3wuvoiP9AEKDHZ4PXoEvrfTnIcLfj+W0mDzpVwdS
X-Gm-Gg: ASbGncuMXrsIbb+0RFDQ9Qxb4uIjf+Q4dKLxUHYtK2nFwRIucrJcg/QCjQn3IsL6GAK
	EzO7FTLoKOwNuItvnaHSHLBXc379dO9ATqyMerWlLf963/PAczZ8Y/KSzwx33IlmYEdGsw4zy5w
	TbDdLi4ylGeHgCNMSvPbUobj/c+Jmzs8BEyqxdvxT/g/CJyPgr1h4oUZdCJT54mar935PYI1zM9
	gGi+W34uEvUnF/50Knv/Q8AnhHgQA9yZx50TW4t70CeG2Aewg2crfT6gdxOFVOnwM7IQuwOyaiC
	DbEraH8pv0IFGwi7Dhh/YVqFF1h1AzKaDw+3/sSSak5dnXZt
X-Google-Smtp-Source: AGHT+IEVvfv/xnKcEWkUOhtohFPem/sqKY1xdInT06b3URrXwVVMpvJa5efu3ZPs+HiAz9zauUZEMA==
X-Received: by 2002:a17:90b:56c6:b0:2ff:6aa6:47a3 with SMTP id 98e67ed59e1d1-306a4892e9cmr1696512a91.25.1743718252675;
        Thu, 03 Apr 2025 15:10:52 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057ca1f49csm2504504a91.1.2025.04.03.15.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 15:10:52 -0700 (PDT)
Date: Thu, 3 Apr 2025 15:10:51 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	pablo@netfilter.org, kadlec@netfilter.org, jhs@mojatatu.com,
	jiri@resnulli.us, lucien.xin@gmail.com,
	pieter.jansenvanvuuren@netronome.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: fix geneve_opt length integer overflow
Message-ID: <Z+8Ha5m911k4H7ew@pop-os.localdomain>
References: <20250402165632.6958-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402165632.6958-1-linma@zju.edu.cn>

On Thu, Apr 03, 2025 at 12:56:32AM +0800, Lin Ma wrote:
> struct geneve_opt uses 5 bit length for each single option, which
> means every vary size option should be smaller than 128 bytes.
> 
> However, all current related Netlink policies cannot promise this
> length condition and the attacker can exploit a exact 128-byte size
> option to *fake* a zero length option and confuse the parsing logic,
> further achieve heap out-of-bounds read.
> 
... 
> Fix these issues by enforing correct length condition in related
> policies.
> 
> Fixes: 925d844696d9 ("netfilter: nft_tunnel: add support for geneve opts")
> Fixes: 4ece47787077 ("lwtunnel: add options setting and dumping for geneve")
> Fixes: 0ed5269f9e41 ("net/sched: add tunnel option support to act_tunnel_key")
> Fixes: 0a6e77784f49 ("net/sched: allow flower to match tunnel options")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>


Maybe it is time to define a max option length in include/net/geneve.h,
but this is not a big deal. So:

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks!

