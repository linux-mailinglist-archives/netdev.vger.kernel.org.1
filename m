Return-Path: <netdev+bounces-51927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9817FCB3E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 01:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEDB1C20AD0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D43371;
	Wed, 29 Nov 2023 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndgQ/cB4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF2019A6
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 16:20:15 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35c9bca5600so12440275ab.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 16:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701217214; x=1701822014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0Xg8/pl4Dz8DLjOzEcU1I6i5X3gqvOGHmn8Uja8rq8=;
        b=ndgQ/cB4R1wcDvdrWAzVEkP6y9dBAsFzhV/TU0vKb0xXNoNwoLDBu97AXmtZdokq+g
         y7LzX0GgeXq+7T3JdqxQ1TNy8I1Mi1sjlJRY7MJh4Ya2Qsyv1XFTssgJro3+J3+hx9WR
         /GrgbnGK/7NzdCP4eff+/1f3vZRpI20WROZOnzSCCAulEh/FW+nBoI5Z3OTumSo5lhTY
         xmPmtPUPXfhPJK5kqhn6BdRnxRarLzAoKd5PACqS8q4WzfLIFW5O1L3zooljFl17CUy9
         e68EQhzrYhB5xOOboNwrEU2q1GVC3vn1d6sd45Bjhr4DV03raSFBzADI/1bKVJml/zHY
         nkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217214; x=1701822014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0Xg8/pl4Dz8DLjOzEcU1I6i5X3gqvOGHmn8Uja8rq8=;
        b=lpXOlwP5kt1dOBkOVH0OWbQj4ASSxmkBSXdTUnP40o74N17u9FDk2/QothioDDbA28
         1rK835EuTmck9TTwXgOZpI2xnPabw8hUZx6NOmrLrNaBYHqcRr/vwdEaa9EIFyhiwM+y
         Y47Y7nmFUr/6b9VZJqWJQafurSi2kPPyzTk3nsgYNGywVWKrW6C7zBp33u+70w8C7iwf
         OCnhq4p35P/OtU6btxGzOwwwZEngc/eV/Htx5nHnLmyxP8YjJTDzRtkPJijKX2SS1BzO
         X6Jvsk85LCRMy17ybby07a2E87KLgxg6zxPyvtVvumLPQCNSg3/spCENNUK7shA+nx2d
         MMuA==
X-Gm-Message-State: AOJu0YxlH4uzUcQdsos2zd1h+MlOoN4VTaZsPMGazxZ3BCdyTrIVmnx+
	BbL3DLYmauikAKfHSXASh6rnqAQSRTE=
X-Google-Smtp-Source: AGHT+IEryOIiTb9LN8REttwq+bawNWgOSRrWoaOzCoOEgO/HSqc5oDDjemXFYxb19MS2fp1idcYc/g==
X-Received: by 2002:a92:c689:0:b0:35c:a5c2:3958 with SMTP id o9-20020a92c689000000b0035ca5c23958mr11290860ilg.22.1701217214548;
        Tue, 28 Nov 2023 16:20:14 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:3d85:e988:5190:b96c? ([2601:282:1e82:2350:3d85:e988:5190:b96c])
        by smtp.googlemail.com with ESMTPSA id di5-20020a056e021f8500b0035d2fc4ce47sm19990ilb.9.2023.11.28.16.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 16:20:13 -0800 (PST)
Message-ID: <b41c7f20-34f4-4644-9e7a-a94cc47a8228@gmail.com>
Date: Tue, 28 Nov 2023 17:20:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ss: prevent "Process" column from being printed
 unless requested
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>, netdev@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>
References: <20231128023058.53546-1-qde@naccy.de>
 <20231128023058.53546-2-qde@naccy.de>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20231128023058.53546-2-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/23 7:30 PM, Quentin Deslandes wrote:
> Commit 5883c6eba517 ("ss: show header for --processes/-p") added
> "Process" to the list of columns printed by ss. However, the "Process"
> header is now printed even if --processes/-p is not used.
> 
> This change aims to fix this by moving the COL_PROC column ID to the same
> index as the corresponding column structure in the columns array, and
> enabling it if --processes/-p is used.
> 
> Signed-off-by: Quentin Deslandes <qde@naccy.de>
> ---
>  misc/ss.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/misc/ss.c b/misc/ss.c
> index 9438382b..09dc1f37 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -100,8 +100,8 @@ enum col_id {
>  	COL_SERV,
>  	COL_RADDR,
>  	COL_RSERV,
> -	COL_EXT,
>  	COL_PROC,
> +	COL_EXT,
>  	COL_MAX
>  };
>  
> @@ -5795,6 +5795,9 @@ int main(int argc, char *argv[])
>  	if (ssfilter_parse(&current_filter.f, argc, argv, filter_fp))
>  		usage();
>  
> +	if (!show_processes)
> +		columns[COL_PROC].disabled = 1;
> +
>  	if (!(current_filter.dbs & (current_filter.dbs - 1)))
>  		columns[COL_NETID].disabled = 1;
>  

this one should go into main as a bug fix. Resubmit as a standalone
patch with:

Fixes: 5883c6eba517 ("ss: show header for --processes/-p")

