Return-Path: <netdev+bounces-219050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCB7B3F91E
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCCC3A5804
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A106D2E5B13;
	Tue,  2 Sep 2025 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXWq0EUy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC42E2F03
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803001; cv=none; b=FA2psfvLUab+lsr8qaJfUZBfBMcUSOYpJIJ1qmQhtYCXMiRdqf7GzS/jDsXv5O44crbyoZsXaIYbUmWrL6T2Ok4t9vgjILZ/GNooykDELSV6GCWXuw6c81MAWh3Mj8DNdqO+iMrFvBKo5bYSpHmtj6zn2RzIsu4OCnsGxgp2wfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803001; c=relaxed/simple;
	bh=Mhp8jXVEHGh++RDIq3pIwMyTr4EHDwopzBqSg7ZECE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Whg3HG1XbAYQl1w+wEwW2oZp4iH6ZzHEH5Cu7LIyvTCCGn40KjClKwk9Krs05YsdGleh0Lzmn8L3Z1h8FW5a0N5G5DTGKXTU7SVJ1NFznl6tNlD2hj453HfUeIfc5Ob/LpwAL7RngnlIh2U1OzfsDdMqXycGLO5c5hsi5VC1VKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXWq0EUy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756802998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rh9RBkvVSEWGQuJL+dDVXK1RYGYVIG9XjSg6HK0oJXI=;
	b=SXWq0EUyXYtgEFyz33YPekVMjatMbvgGlFskmqCL/iwUhZMMK11N7gf4b3smuTFj2Ivxq9
	n3y6gY8bsWmA9isOLpGzFwMfpOPuQiJsB8ujXgpJQ1DR0EhYKZWZ8hiGLiI/ykNNz65Ppc
	jxbP7zhftRs/RfuWj62CvK5G515bAHk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-yA-eQKxJO3mJcsSBOqCU_Q-1; Tue, 02 Sep 2025 04:49:55 -0400
X-MC-Unique: yA-eQKxJO3mJcsSBOqCU_Q-1
X-Mimecast-MFC-AGG-ID: yA-eQKxJO3mJcsSBOqCU_Q_1756802995
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7227bea8b73so32821297b3.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 01:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802995; x=1757407795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rh9RBkvVSEWGQuJL+dDVXK1RYGYVIG9XjSg6HK0oJXI=;
        b=Rjq0v/ZALgK0BU8S8kwi2FEcAk93R6UCxDiC919CNX8/Zgsg4FnNsxXJ4e0G1H/TCP
         LwYD0loyOOSLzeo6jjUDGsgnsMq3koajNxel6qVbTAIU4+/5AXLUiCFEH3juUIuopbre
         I9SbiwFiFzuScgUzNVhkJxFum+O0bKfrAePHmlxIFu6v5jeXXil1uCEGm6I9Tezz2HZV
         MU/uj+szM4DQsjdZ3pvJBZxk8YCuaCIMp5A+yS3RjIizKVgvlJqbUut0ZdW2mLnoIJAa
         XeV0BHiwUxNf535vf2KYthAeheubKBjqOoWwZ2Tut3YS8gwp5jtBvUB6aNnB4BvXrES6
         1Y+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKB9awXQZA5vNLJfX7As5cw8DI7EBlEtp1UImSwhoFsg0Ip6QY91fbICWqQCN1GM8agAgqonE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjLLvccW0N1aUGNSGYjPMtRPpeEXggG9asgbf2jRpZHcC4KeEQ
	mFAOOz+XlzciXDN1vjxonkogJ1d6loL1DsT9btdpxgRTYdlnFL9WEDrHt6+ZJhRrdT0MvUESfnQ
	xhIJ3cL4isV1SdwIA9YfR/0d2pxX662u+/NRSdwWdlTGy9kYcKkeSM+4CKw==
X-Gm-Gg: ASbGncteV5K2WxnYtxhPLjFY7P1wzWYZH3R5nrMQw5sP5uc4uQn3+SSR9GUAXk+q/Ks
	QHV5nmG7OhGNa1Z/g9cNPXkL+MVN5dFvHNgnwISaqcE+kyMIGlP4yziDOrLIcsY6/3ch65nfmuK
	DrlHRmXoUljPF2NYlclQ4inLNcfhwS2nYci2U1yr9IxYlvPDuGMZwAymOY7XH87/ErVcQ68g5mo
	42aQLdQPNAnUhhYCdxsaXz3hjKvhbh8ClOF5QHHEVAeuevUMvlklsA0h1gzJrIt7H+PVcTMYTNn
	buHnPqHWANNb669eLOh5H/gVq4Nlry6iQx5xcNqvw8W95nbLvWRVfZP0WGv+XhGGqcmWlRo6rgr
	gGOlkA8k+dxU=
X-Received: by 2002:a05:690c:3809:b0:721:28ef:a9b0 with SMTP id 00721157ae682-7227635c856mr112866607b3.9.1756802995130;
        Tue, 02 Sep 2025 01:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlypMLI8XIGJHMOhhMRO1ynE8DNTCjD9jv/OySdjluZx5qwOhTyzmXtYsCxg0aNhm/A8apVA==
X-Received: by 2002:a05:690c:3809:b0:721:28ef:a9b0 with SMTP id 00721157ae682-7227635c856mr112866387b3.9.1756802994683;
        Tue, 02 Sep 2025 01:49:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e00:6083:48d1:630a:25ae? ([2a0d:3344:2712:7e00:6083:48d1:630a:25ae])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a850288asm3642597b3.44.2025.09.02.01.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:49:54 -0700 (PDT)
Message-ID: <03991134-4007-422b-b25a-003a85c1edb0@redhat.com>
Date: Tue, 2 Sep 2025 10:49:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] selftests: net: add test for destination in
 broadcast packets
To: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org,
 bacs@librecast.net, brett@librecast.net, kuba@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, stable@vger.kernel.org
References: <20250828114242.6433-1-oscmaes92@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250828114242.6433-1-oscmaes92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 1:42 PM, Oscar Maes wrote:
> Add test to check the broadcast ethernet destination field is set
> correctly.
> 
> This test sends a broadcast ping, captures it using tcpdump and
> ensures that all bits of the 6 octet ethernet destination address
> are correctly set by examining the output capture file.
> 
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> Co-authored-by: Brett A C Sheffield <bacs@librecast.net>

I'm sorry for nit-picking, but the sob/tag-chain is wrong, please have a
look at:

https://elixir.bootlin.com/linux/v6.16.4/source/Documentation/process/submitting-patches.rst#L516

Thanks,

Paolo


