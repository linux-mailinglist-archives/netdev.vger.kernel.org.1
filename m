Return-Path: <netdev+bounces-81271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC28886C65
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9E41F2320B
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACABA40843;
	Fri, 22 Mar 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="eaYuLFGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE651EB31
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112062; cv=none; b=WUkzGwfJelnaqM2uEIoGd7N6WDdqrwNGeENmyQYkoCVnwiJPOuGlHWcx0ZvjaJQZlv7X15hZbDYPfoxmITt72nzbtA0wevPy/Kg5tvw8XKQgv/AwTRkN7g5vOC5IjIrB12NGk7qr1Ry0MHPyIftJHKlbQjfKzx2oySNzWYHNQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112062; c=relaxed/simple;
	bh=QqV7VV5EObT8Q/oxcBr4k0DipDuTOpP52G2tdoq8gjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gdo3x5QkIKnuTV1WuQzekZhIlL6DdPlGTjqXjXfWIQKBLj4xJMtseSm/dafPYD70lYPlB9rnK+UOcrtabPR8oy/2p920b01LvASx0xwC25vWtBjKRKUo0Cd9d4wCCu8cEeoVgk2ImpIByFMOGWfPcM5t+6XXXtywW0kqaX1VKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=eaYuLFGZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4715991c32so222445166b.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1711112059; x=1711716859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6RemCy6dcZjDYEdLINT2xX2A+yK+ZiPj+rD9BKuGTk=;
        b=eaYuLFGZczNR96Sk+S6zd44QL+xgEt2ra/sTNVnPX/VcnwWhUiLg5HsowQjPerAJaX
         AxyhTbVTKOtcifS12f/Z+gfVI1A2s4DVDeZO4XRm9TAkPa642EjkClCUcYOXKncA0ezq
         8XZfHBxa3vZSUAj8Pljhahj6iegBzRNXvWQo+n0nQkZU6yGpKDUea/9xSbIdZMpbN2Yq
         aZUW+IbKVskc8zoe7/PDr3W/k6k5xNUi/2WkbC+HXi4HLg9vzd8/1DLbpJh1NUwyxAOR
         6+UjmAa0FjAF3Gf7anVlBf+NrYB8gh9AYdxbxRAvZsU+CukEOvpqrSnVq/nI9DkgevIN
         EqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711112059; x=1711716859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6RemCy6dcZjDYEdLINT2xX2A+yK+ZiPj+rD9BKuGTk=;
        b=V2EyZ30ew97/pjsRpAwJjFJHcxOc79yTUyTr4uneDS5ss5kDcrCh9G1JQptzucggB+
         Qm/crV6RXLwGRM5OFdEEqW8bvRQo9sTA3uJUXcc7MxRrQ/yTfBH2YZ8e1S4nTgNFgqy7
         U+eMHtTAXEaSpYzOXw/6LAi7jMN5YDBBzM+nHfOxAMlJSlT6GHJRp14ge/ZRaXzpmXw2
         Yz3qTnqKZ+3KwEvAp1oQY2uEvBQF/Vb1Og4WACWmItgzGCnr5Mz/TNkz3/HnALanSZXH
         9IzlcCsGL2egYit5YJmWfTYARikzgZYVP4ll1JX+2sAzW7iWYjTNKcrLB0RrykQWfdYJ
         QdWA==
X-Gm-Message-State: AOJu0Yz4mVONLQKD2YZWEcde0NVw9FzJLiy/8m8jJRq+IxjKJMmCZ0y5
	5Gb3QglWnZTTnW7D3YTHSeJIs0eeNiDxHecIxv2C6b3WEgHtnGlRWMF9XpP2lbs=
X-Google-Smtp-Source: AGHT+IEOk/CQbPfNPXKEWjYKhI/+zm9LAWF+rORIUKr2/t6WfDjz6KaNKQe8OqPEypnYRDeg2IXDVw==
X-Received: by 2002:a17:906:6958:b0:a47:1ebb:d8e8 with SMTP id c24-20020a170906695800b00a471ebbd8e8mr1697819ejs.2.1711112058900;
        Fri, 22 Mar 2024 05:54:18 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id f6-20020a1709067f8600b00a4674ad8ab9sm980245ejr.211.2024.03.22.05.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 05:54:18 -0700 (PDT)
Message-ID: <7a59719c-c0c4-49e0-af78-dc3a6eed6cb4@blackwall.org>
Date: Fri, 22 Mar 2024 14:54:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 2/2] bridge: vlan: fix compressvlans
 usage
Content-Language: en-US
To: Date Huang <tjjh89017@hotmail.com>, roopa@nvidia.com, jiri@resnulli.us
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20240322123923.16346-1-tjjh89017@hotmail.com>
 <MAZP287MB0503BB0A5D2584B43A734CB6E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <MAZP287MB0503BB0A5D2584B43A734CB6E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 14:39, Date Huang wrote:
> Add the missing 'compressvlans' to man page
> 
> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
> ---
>   man/man8/bridge.8 | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index eeea4073..bb02bd27 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
>   \fB\-s\fR[\fItatistics\fR] |
>   \fB\-n\fR[\fIetns\fR] name |
>   \fB\-b\fR[\fIatch\fR] filename |
> +\fB\-com\fR[\fIpressvlans\fR] |
>   \fB\-c\fR[\fIolor\fR] |
>   \fB\-p\fR[\fIretty\fR] |
>   \fB\-j\fR[\fIson\fR] |
> @@ -345,6 +346,11 @@ Don't terminate bridge command on errors in batch mode.
>   If there were any errors during execution of the commands, the application
>   return code will be non zero.
>   
> +.TP
> +.BR "\-com", " \-compressvlans"
> +Show compressed VLAN list. It will show continuous VLANs with the range instead
> +of separated VLANs. Default is off.
> +

How about:
Show a compressed VLAN list of continuous VLAN IDs as ranges. All VLANs 
in a range have identical configuration. Default is off (show each VLAN 
separately).

>   .TP
>   .BR \-c [ color ][ = { always | auto | never }
>   Configure color output. If parameter is omitted or


