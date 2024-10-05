Return-Path: <netdev+bounces-132374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47813991707
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 15:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A63C2835CE
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 13:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E61914B94B;
	Sat,  5 Oct 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="JYVhR14W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2C14B08E
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728135529; cv=none; b=CdnBLWN8sB7+Cdem9whyZlUb4LceKEzFFJa5G9f4oARSrb+VErnIlsAyb8QP01K9Aj5/yL6PfN9h0X1ekDuu6XPg67Qn2ASBhWtEL2L2BdsU1QMAXqcvqMbox5DABvLdPnai+/RBeJL7S9fKbzJnW118lO+uddNVeqjIY+TUu6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728135529; c=relaxed/simple;
	bh=PIFZn6MyWpQ8pRwfPGnUQ3hsc5ASWv0mWU/clUVOBvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYVoqt7Np9yfMnBrGS4RdHbbeLcBXjyf3Cfbb0yhPsFjKqWG2oQ4Yt966wPQupEs69KzlTap71uQBoUQJtMaVxglH8n8Q+i9J0zfdoDkhGUfEW+jD+njwjmKXbr5hNqBXOPYiEi3edJCi08xPK/JlsS8al1gRf19wvjtoZ7P3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=JYVhR14W; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so38697835e9.0
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728135526; x=1728740326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q9mlPESnRtr7rTacrhLYbEtOF3ohRx6U2hR+wPtUjJk=;
        b=JYVhR14WkipPNfwqzRCkwycRKWe22NEfOtoQr1jJwBFBLxLOEgPzUNFopV4+bGZ7Ux
         AxhXk0uUeptSnVSfpTQGXGXVemcLEw3KwCauW4CYvyO/rFPAZTmfnUmz7w6gYEzTKvq9
         9OhEg2mrsGulh542iNLk9wvCUa+WHvFoNLdtDkoPcyTRkEy8USw26z4ZkTPXns+M4Ox4
         R8uR/z6TyqxDUgaDpNm4lG3iBEeqaaVu0O0m0IJvTll1NM3qaR4aA2XpqjG/sfhgLONd
         4vFK7mZ8/sWtpzSMSNIL18DdNfT5qDspvPsnPRP6fEgShs1eP9JdAbNSsjI1iAubRjla
         Va8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728135526; x=1728740326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9mlPESnRtr7rTacrhLYbEtOF3ohRx6U2hR+wPtUjJk=;
        b=aJ2q7yHlJz5y7TtDL4EbjfyGzyFQr+Sw5zUAqATljUnjFlNw3iKSgX8zJ9PuAC+jHF
         Pp9U8v2+ZhrpzLBZfxqE7VRv9tvIeKI4q3WPMDsvqDmT3p/dnOj3uqTArotKiyNQSveR
         /+y5K831BBdIXI0ZN7uDiQP/QgxmrH0EqVmtqTdwY8OZ0HXa/qnyKPe2mqY0Tek+HQkY
         w4gqi6F+mMYxHNXygeFKNL5nANeOQK0fcDLXqPt2ia3nBHWTerKSTQfHbdB7q9xcFQ0o
         ds4bX0W/dRAVpvmeCCH4MduQueGwq8P3rfmbVmXPRGo7nwbPJvoB5g9T6FvSHv8kgzgP
         IdVg==
X-Forwarded-Encrypted: i=1; AJvYcCW0S2aOfhvfPfCh/55fxpKokaz4A52z/Cdxjgqj8FbKuLgJkQUop4vDvxwuIaqckecL5P9ggY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ir493LqkD4zn8LK3lM+CH7g+H8XF6LtotVAMQOPGyHuEJIr5
	AYPr5T55MhPtl2Va1/C8hsuWS74GcIMhCcUkNQvvr1welvYlpEEUq2Z1kxNODXs=
X-Google-Smtp-Source: AGHT+IHJg5R7X6JsCvCPOyp95VIYVOkW8k8F+GQPIaZ+0v4cwMEQfQniQk4VDjCWVju9whETauqwXA==
X-Received: by 2002:a05:600c:1d20:b0:42b:ac3d:3abc with SMTP id 5b1f17b1804b1-42f85ae9481mr64313085e9.24.1728135525972;
        Sat, 05 Oct 2024 06:38:45 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec63c3sm22835155e9.38.2024.10.05.06.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 06:38:45 -0700 (PDT)
Message-ID: <384a4051-dc9d-476a-8bb4-2bd976f06887@blackwall.org>
Date: Sat, 5 Oct 2024 16:38:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/5] netkit: Add add netkit scrub support to
 rt_link.yaml
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: kuba@kernel.org, jrife@google.com, tangchen.1@bytedance.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241004101335.117711-1-daniel@iogearbox.net>
 <20241004101335.117711-3-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241004101335.117711-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/2024 13:13, Daniel Borkmann wrote:
> Add netkit scrub attribute support to the rt_link.yaml spec file.
> 
> Example:
> 
>   # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
>    --do getlink --json '{"ifname": "nk0"}' --output-json | jq
>   [...]
>   "linkinfo": {
>     "kind": "netkit",
>     "data": {
>       "primary": 0,
>       "policy": "forward",
>       "mode": "l3",
>       "scrub": "default",
>       "peer-policy": "forward",
>       "peer-scrub": "default"
>     }
>   },
>   [...]
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  Documentation/netlink/specs/rt_link.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



