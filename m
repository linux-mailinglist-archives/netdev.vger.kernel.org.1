Return-Path: <netdev+bounces-105498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09C911837
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 03:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177831C22184
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 01:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157F82D93;
	Fri, 21 Jun 2024 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="b/JnG/e/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01182D68
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 01:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934763; cv=none; b=aLWaBDEFx+uSDNMD5UpjWXUEyABpuZRuHqzdZ89Sbys7D3jITa1c/XBEuwzkLNq8tpz6t1CFaegtZWy+cKixcgWP7ZoHUnIQPORbn375jLyX8ArxlmyGSIYPYJVrGdhMBzReS+iABVGBuRf7LTOYi83LXwD1LieXJlO54hmWqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934763; c=relaxed/simple;
	bh=E3jN7PYwltX7pPs9uOYZtiZgVXywSY2RUqrZ6vJfNNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q83PM7hbh7jXl7FovDt6P+5SNQLl+f1y3qoyTiiamAM1f8xlGR57Wwr0nU4IiKuzkdjcQ3ZyfOowekxz7pymfQtwSo47AuCKqhzZjX6AlOFGBQYRX8WI4yHtzLtBtz3JC/EmU//HHBZy6cp4earmjkDBUw4RKiIB6A5I0mpxtpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=b/JnG/e/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-701b0b0be38so1390774b3a.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 18:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718934762; x=1719539562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IR1cJIENU0poOm/AQU0E+nG8ziiHu2ATfyyJOVv9EZY=;
        b=b/JnG/e//cF4nYl3Gc20YImEiDuvCIXagQWMh7bOhATuAYSDyLde3bDrvEcUjFqaf6
         CERCsXGj8g5NeUu6Pj8WldiE5S0BJVwuRje8Z2fe1/Yw48THTUpHg1yLbsKlSgfga5r7
         AwYroNL21fm6WLo57VGn5vRNFj10IHZb0r+Nf/bPFUUszgWwY8dJVUJ/CywqoJOT+yvm
         R16nTHUJKQ8J9QASZrtic+zNiSYv5ryNF1wdrtCeH2MSOMEpRxygpwhgXQqdHreo91wV
         8mL2429GyH1cfX+ZH2UkyvlYp/bKSxnl8KYKYMO+8dWE9NNJixnCeS4KEvRcZwcw2UYe
         1F0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718934762; x=1719539562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IR1cJIENU0poOm/AQU0E+nG8ziiHu2ATfyyJOVv9EZY=;
        b=E9lU1ikz3dlRGUZyWn/XtfhVEjtQR7KmTqIRI780U57Z9V97dWPRU8nzXpiHAFUesB
         nwej1WiEhMejjimH2tyAuHcy96VHD2rudcjl7/wRVwDrLA1jrTh3H9U8RcU8A+vsZVkO
         LQg+mVzir10k+Jy2ND2sODOQ3jVEKwrwSsBKGRn3/C6Mat8EvWDM18PRrpZbZsIm9Qxj
         WfZr68JC6j9Nw07MWN7SDBgjZPf8DxXiNVxyOW34sVQGT5ZkrCv+5oQk9WFEpig07sDZ
         v2YWi15hEbLoScTrqghwfQOF1yhSbGcbEAPtIFntK8zMuH2vfYbUPpRwQaMR5UneRwW3
         eBQw==
X-Gm-Message-State: AOJu0Yx/4Rs0Z+5io3+7AYoBjOupOjhHwDhOA0VM5sFBmnNoGX0SflhK
	MCmrgBhpGmzt37nVLsJpn0cAHHXankBUkjj5G4oV57ZuX0KTcc8tydQXyLLWE2M=
X-Google-Smtp-Source: AGHT+IFzJIuoYw3gWaeVyUMDXp8k+i+9PEnvMKCCCgVo8o6ZvyoBaqyrr8i6vyBse6GbP3O/8EdnIw==
X-Received: by 2002:a05:6a20:6386:b0:1b4:6f79:e146 with SMTP id adf61e73a8af0-1bcbb40b73amr7351658637.17.1718934761844;
        Thu, 20 Jun 2024 18:52:41 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::6:b127])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651194187sm301716b3a.58.2024.06.20.18.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 18:52:41 -0700 (PDT)
Message-ID: <04d4c1fd-b50f-473c-b5c4-00a5b27954e5@davidwei.uk>
Date: Thu, 20 Jun 2024 18:52:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] selftests: drv-net: try to check if port is
 in use
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, ecree.xilinx@gmail.com
References: <20240620232902.1343834-1-kuba@kernel.org>
 <20240620232902.1343834-2-kuba@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240620232902.1343834-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-20 16:28, Jakub Kicinski wrote:
> We use random ports for communication. As Willem predicted
> this leads to occasional failures. Try to check if port is
> already in use by opening a socket and binding to that port.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/lib/py/utils.py | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 0540ea24921d..9fa9ec720c89 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -3,6 +3,7 @@
>  import json as _json
>  import random
>  import re
> +import socket
>  import subprocess
>  import time
>  
> @@ -81,7 +82,17 @@ import time
>      """
>      Get unprivileged port, for now just random, one day we may decide to check if used.

That day is today ;)

>      """
> -    return random.randint(10000, 65535)
> +    while True:
> +        port = random.randint(10000, 65535)
> +        try:
> +            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
> +                s.bind(("", port))
> +            with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
> +                s.bind(("", port))
> +            return port
> +        except OSError as e:
> +            if e.errno != 98:  # already in use
> +                raise
>  
>  
>  def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=5):


