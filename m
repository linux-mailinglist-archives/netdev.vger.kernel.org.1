Return-Path: <netdev+bounces-69613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E301784BDD0
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 20:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135FE1C23849
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 19:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B77813FEA;
	Tue,  6 Feb 2024 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUWHW+tR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11F13AE9
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246340; cv=none; b=WcCGlZGjkr1OFyo9TDjk0x0obM+H9sPzMb76q7A6WT2JqnR4acMWGqswukLN/FBU7bhxnvyLo4EdIsQ+lXgROYA8rODgaSOLTq3hDvT00eUN5f/QMUxYTN/4hLcxWezGF54/s4TrOUcvpmzTk9j2FtSP5b+6sYnVMx5PIhSJc7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246340; c=relaxed/simple;
	bh=cDXt8/KgezbQ9k4QrWmg55pFGn8sVaFpM2xAgpGdXks=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oQUWPPJ0suYn7XB6QNb+IZkWgSLdfvhBgyptjYCw9GlxZIP9kX9O+u+lV4yTQIfDaBFz3wtaMGgSSdcxjNWLoHpH6fFYlpEAc701JKl2LUJXhOrOEz34fEBUAhPnz7H/dSUzbb1GKNOaDzfMvwZBO0PsnmldpkGvtiEJ80HTZTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUWHW+tR; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cedfc32250so5132204a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 11:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707246338; x=1707851138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8QVZlmzeYNePpIX/m9g1cnWLftSxxyFSQRCe3h6EOJM=;
        b=aUWHW+tRT2JHPkamI9AHO9UQSPBjvRPb6MpxR9NRN4SktpU0mmIFmCPIananxsziPa
         qXidcPxy02A5FdVG3pSioia9ZQILwOd76DgUvA3FbHfRZxmdHXZcnoPYbre3kdeNFPWI
         taf68zyOMnVeRkN9jHMrQqAA8b48rkDdJ9yQXhIsDIgoD8UcWNSiI2UaJdfrv8U5xZYF
         2O8sYSWuJgTTkGx3g+6N5bC4tWvYkCkgaU42v/dtcC0k8+GwwNWuch/zL92QyMFTdbz3
         NkbcLnLW+b1tHM54/5DktMziiUeS2lKEni9wlfVg7iUYi4ht1uMwpAm7WWaShzsSU/GA
         ITdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707246338; x=1707851138;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QVZlmzeYNePpIX/m9g1cnWLftSxxyFSQRCe3h6EOJM=;
        b=oUwcBhmvpJcJXaevwqFjtwFKI7mqN8cLqwRR2jl9XWJITgVh0zFNpMT+5CM3K9NO96
         L5oo7/jByej8SDDZGVHpHSaUHJnGtaVEPcbuioK7W3J65jLSYZ+pAnOtvs4i5zkROsnc
         j/p99oHB6N1dSj4wJosNhpSVwNZHu5+Nw7O6KdzxFiHeKPVO2xQenX3E+ZZ6eDQwG5ZM
         Remk2nySnL4s5Kv8Hmy3xGcfDLReE+nFJNyFBBjXT14r9iKRGuWpjp0bv5jgCHSK7yg5
         O0MhVtBUO7TZ6emcFriF3hIx6IVlVnn2bc079WU/Bsx+wwfysDtVgWCK/USJ/jd32NzX
         n8Ow==
X-Gm-Message-State: AOJu0YxhCeC3bA46AgBj02C6B3GJHfLH/WfoloX6PZboZ2A7fgu+kEEe
	3SzE0JrQjXcY7gNdnEA8kt8nSWVGO0D/+pi7iwDTHZmD9+aNtwWuEZsSlBXl
X-Google-Smtp-Source: AGHT+IHGSvXwd+dYz6UHVRMeSKq0y93IGmxQ9k/Ia8I95uhAMj+OmpB4WP/5ovE11sZo9Aq0wtYikg==
X-Received: by 2002:a17:90a:d443:b0:296:a13c:8f84 with SMTP id cz3-20020a17090ad44300b00296a13c8f84mr448444pjb.33.1707246338197;
        Tue, 06 Feb 2024 11:05:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX3xK73HpD7OrcdlWXhMD2cKB+xmkfOrbNGlL2fgJsKVaPKIiS75N66BcUZu6/jaUmLy6OZzY8immeogxLCav7g8y7nCqIp
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id sc12-20020a17090b510c00b002932ec731d1sm2112094pjb.18.2024.02.06.11.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 11:05:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e6e235a2-85d9-4e3d-9ee4-3a9f00aaf1a5@roeck-us.net>
Date: Tue, 6 Feb 2024 11:05:36 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Persistent problem with handshake unit tests
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
References: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
 <ZcJihCDh30LD4NPy@tissot.1015granger.net>
 <6904162b-5ac1-4f2c-a48a-02c104f6fe4c@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <6904162b-5ac1-4f2c-a48a-02c104f6fe4c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/6/24 09:55, Guenter Roeck wrote:
[ ...]

> 
> Since the destroy function runs asynchronously, the best I could come up with
> was to use completion handling. The following patch fixes the problem for me.
> 

I don't know if it is a proper fix, but I no longer see the problem with
the patch below applied on top of v6.8-rc3.

Guenter

> 
> ---
> diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
> index 16ed7bfd29e4..dc119c1e211b 100644
> --- a/net/handshake/handshake-test.c
> +++ b/net/handshake/handshake-test.c
> @@ -432,9 +432,12 @@ static void handshake_req_cancel_test3(struct kunit *test)
> 
>   static struct handshake_req *handshake_req_destroy_test;
> 
> +static DECLARE_COMPLETION(handshake_request_destroyed);
> +
>   static void test_destroy_func(struct handshake_req *req)
>   {
>          handshake_req_destroy_test = req;
> +       complete(&handshake_request_destroyed);
>   }
> 
>   static struct handshake_proto handshake_req_alloc_proto_destroy = {
> @@ -473,6 +476,8 @@ static void handshake_req_destroy_test1(struct kunit *test)
>          /* Act */
>          fput(filp);
> 
> +       wait_for_completion_timeout(&handshake_request_destroyed, msecs_to_jiffies(100));
> +
>          /* Assert */
>          KUNIT_EXPECT_PTR_EQ(test, handshake_req_destroy_test, req);
>   }
> 
> 
> 


