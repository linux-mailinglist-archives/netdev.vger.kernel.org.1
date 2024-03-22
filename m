Return-Path: <netdev+bounces-81211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63112886924
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 10:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC643B23AEB
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DD41C68E;
	Fri, 22 Mar 2024 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="OZQh7BCf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06AD1CAA9
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099511; cv=none; b=J1kiioxQvqdm/wCp5d/iD7KgScG9wVN+eD3/PdJPDkP07CxAktQ52EuoZKvyXanDtuec1pcE8cUbKBYSmr+t+S10Ial/ALvflTbCXvSggFxBeWEeQKA0MsAQUhlcXY+eQFIkr9PUKEUSVkkBqhqcq1gonnlRycz0YekXS8ICoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099511; c=relaxed/simple;
	bh=1if7BFQwgLxVx3voiZeovJEVGof6kBRuuF6ODWwx63A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+I5u1CEVO5oi8DJ7/CyPCKxVXNJF/bQ4TPxi0BYv9AdybsmjdzQeV7WOtvgqs35dgu+fcnH8Mk9jkqYRc3KReQiI2CqnW6MYZPzBuiGn+p7ojCkhLyUb6mSVkWSrk1SsY2ztAgjVzTBLtoJro+u2y4V1LRY3tjo7NLsZvF2ZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=OZQh7BCf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56bcbf40cabso1998850a12.0
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 02:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1711099508; x=1711704308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5MkR1b8nFs9KfPBt6iM0maCCgb8ISKgftnjTVxrIpw=;
        b=OZQh7BCfgfkpZhbWMu6H4m5bL8Qtt0Z1noYMT2BZ74/CU1Qp9pyd6zThPhRHNIUv0X
         6tI9ZF5CjhhxVAptpO0MFUtqoryO4OUFRph00Ixu79LfpQ9uNgBksM2agxn5BS8M5qdi
         cX+nDXwHWRduy5hYQD7faTyL4VgQnujlN6xGX/s2y9vsEAGCrR8IHqfrNkqxBXzQhSyM
         9soq2x8cAlK/dEFGGu3psTbt7zbooVm0d6QY4TCOOcQAVnYdPQ6hKU1aSWj/hfxWM34i
         h1I7u+bKqwWFmYZXUIP+AhG0XX1G14qAWl05F1Qo/n5JzDacyxmGhhdqA/c00KoQvSkq
         o6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711099508; x=1711704308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5MkR1b8nFs9KfPBt6iM0maCCgb8ISKgftnjTVxrIpw=;
        b=rp13cYipUG2AGNnWUWy3F4el4kfU5r+LjQDgpBEKI1aO6kt0L4PsSno2erHVjtwcdj
         MFZFs6yWz20YhC+oCB7E+GCBxvRwGRjEZYn1xwg1vINbW/3fNVJZwT2snr2/Y5G+/7gl
         y/0sRmAirfhnaf60tOfEl8s/Eh3J0E9tPcAFjsGwXhtnyJlFgD9dbqr51hVhCecWQiIj
         irPMS9aLiRqotnBpefBXyl8uoj2ePxqS5/fnIqX4R3XYKzViVT0NEbo0shYO9Vg9LhQA
         FZdPgTHcuRQ7nv+wWxoJYHlTXr7mwYIOm9XeZNMDON/5iP9VI0OhqQIBIfVfNtPFXlwZ
         KavQ==
X-Gm-Message-State: AOJu0Yzt5g4ZHiQ8LyPr0KDrxInyStQb/lW9UPM15NlkRbMTUDHqYU3a
	i4EbWHyfuVK5ynay6X0vp5pLDOFG9oq6M9i0ddrWs0Xys0TWoAaU/vNAve5KTgJgRkH/aYC+mt3
	a
X-Google-Smtp-Source: AGHT+IFk1iUmTb8JHnehQTzSV1HCFuqRyGHJRY7MUXy/JchuLjhlff6jbCzAZ5z14JSAhRpufCzw5w==
X-Received: by 2002:a50:aa89:0:b0:568:7be0:50a4 with SMTP id q9-20020a50aa89000000b005687be050a4mr1138845edc.11.1711099507868;
        Fri, 22 Mar 2024 02:25:07 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id fj26-20020a0564022b9a00b00568d2518105sm818655edb.12.2024.03.22.02.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 02:25:07 -0700 (PDT)
Message-ID: <d6ac805e-1bcd-4e06-b3eb-58fc2bb84461@blackwall.org>
Date: Fri, 22 Mar 2024 11:25:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: vlan: fix compressvlans manpage and usage
To: Date Huang <tjjh89017@hotmail.com>, roopa@nvidia.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <MAZP287MB0503CBCF2FB4C165F0460D70E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <MAZP287MB0503CBCF2FB4C165F0460D70E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 10:56, Date Huang wrote:
> Add the missing 'compressvlans' to man page.
> Fix the incorrect short opt for compressvlans and color
> in usage.
> 
> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
> ---

Hi,
This should be targeted at iproute2. Nit below,

>   bridge/bridge.c   | 2 +-
>   man/man8/bridge.8 | 5 +++++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/bridge/bridge.c b/bridge/bridge.c
> index f4805092..345f5b5f 100644
> --- a/bridge/bridge.c
> +++ b/bridge/bridge.c
> @@ -39,7 +39,7 @@ static void usage(void)
>   "where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
>   "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
>   "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
> -"                    -c[ompressvlans] -color -p[retty] -j[son] }\n");
> +"                    -compressvlans -c[olor] -p[retty] -j[son] }\n");
>   	exit(-1);
>   }
>   
> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index eeea4073..9a023227 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
>   \fB\-s\fR[\fItatistics\fR] |
>   \fB\-n\fR[\fIetns\fR] name |
>   \fB\-b\fR[\fIatch\fR] filename |
> +\fB\-compressvlans |
>   \fB\-c\fR[\fIolor\fR] |
>   \fB\-p\fR[\fIretty\fR] |
>   \fB\-j\fR[\fIson\fR] |
> @@ -345,6 +346,10 @@ Don't terminate bridge command on errors in batch mode.
>   If there were any errors during execution of the commands, the application
>   return code will be non zero.
>   
> +.TP
> +.BR \-compressvlans
> +Show compressed vlan list

s/vlan/VLAN/
also the explanation is lacking, please add a little bit of details and
what the default is

> +
>   .TP
>   .BR \-c [ color ][ = { always | auto | never }
>   Configure color output. If parameter is omitted or

Thanks,
  Nik


