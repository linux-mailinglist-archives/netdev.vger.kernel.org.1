Return-Path: <netdev+bounces-38444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE297BAF2B
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E96CB281FE0
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 23:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7987B436AC;
	Thu,  5 Oct 2023 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="msoA5i6P"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8CC43693
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 23:16:10 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E7830F7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:16:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-692779f583fso1259462b3a.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 16:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696547769; x=1697152569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XoRVyjHSUupXJ8vwdSNmy0inK+VUnYPJqwiXoClFAZk=;
        b=msoA5i6Pn7CUopt2Qy2IBaaG0mkbqBJnMctxelZJgWhH/cXaANsTvcYLyW7JqJmUhi
         Pegb7A92SsaDDoHoT3duSLVWRIoUAHsK1GT5ENXeMELh9HKZZfS0YqxAywEI17CyWVFw
         CAZCb5K1XQfNxSVSBCRAUNWCBQyGsHWF+8fuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547769; x=1697152569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoRVyjHSUupXJ8vwdSNmy0inK+VUnYPJqwiXoClFAZk=;
        b=bGlTSPKgp92F0IZ5tBCIMaXymQ3/6mwxMqUzZjaJ6NbjTSE9jyDtWWgMdm2UvvXKl5
         tqJ2xZ+iufnv+kH1hiVf3iQHWs/CLwHXoX4w2PmRHKZHRBc1017W1k5H46xWyKPyI3K0
         OAKcLDmx1KQcKLINMfmCq51puAMg2ObepxwAfKLESUOa4ys/2AiPgDFgGFxEAsHCZqnx
         KDT4Fhn6n2tQdbpeR9M2fhRfZE90urVP2phykRa7iBWVgaXo6lJzlUbvR6unrmt1eeyP
         Ky0HuMtpgZTVtJX2U+1ghqie5J42xSOga3OZawjtZshyKO0isquwKa6Mx+7iC9GGI+zh
         6PGA==
X-Gm-Message-State: AOJu0YwibgSfpizPlgeXs22byPHGSRSLRe8f21Xw6vRnb+K6aQqy45Fx
	Q/QquGQYtH0fyfb+0oKP2rRnRQ==
X-Google-Smtp-Source: AGHT+IHwunWHAgIMpda/49ivr4x5F1Uvq/kdncw4ZNONZb04RYoXCt4etys/yNHm+LlzK1fxlOaWpw==
X-Received: by 2002:a05:6a21:1f02:b0:14d:abc:73dc with SMTP id ry2-20020a056a211f0200b0014d0abc73dcmr5361824pzb.32.1696547768852;
        Thu, 05 Oct 2023 16:16:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h21-20020a62b415000000b0068bc6a75848sm116728pfn.156.2023.10.05.16.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 16:16:08 -0700 (PDT)
Date: Thu, 5 Oct 2023 16:16:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Derek Chickles <dchickles@marvell.com>,
	Satanand Burla <sburla@marvell.com>,
	Felix Manlunas <fmanlunas@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: liquidio: replace deprecated strncpy with
 strscpy_pad
Message-ID: <202310051615.4DD6C6C6D@keescook>
References: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_main-c-v1-1-663e3f1d8f99@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_main-c-v1-1-663e3f1d8f99@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 09:41:01PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We know `fw_type` must be NUL-terminated based on use here:
> |       static bool fw_type_is_auto(void)
> |       {
> |       	return strncmp(fw_type, LIO_FW_NAME_TYPE_AUTO,
> |       		       sizeof(LIO_FW_NAME_TYPE_AUTO)) == 0;
> |       }
> ...and here
> |       module_param_string(fw_type, fw_type, sizeof(fw_type), 0444);
> 
> Let's opt to NUL-pad the destination buffer as well so that we maintain
> the same exact behavior that `strncpy` provided here.
> 
> A suitable replacement is `strscpy_pad` due to the fact that it
> guarantees both NUL-termination and NUL-padding on the destination
> buffer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks like a safe replacement with strscpy_pad().

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/cavium/liquidio/lio_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> index 100daadbea2a..34f02a8ec2ca 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> @@ -1689,7 +1689,7 @@ static int load_firmware(struct octeon_device *oct)
>  
>  	if (fw_type_is_auto()) {
>  		tmp_fw_type = LIO_FW_NAME_TYPE_NIC;
> -		strncpy(fw_type, tmp_fw_type, sizeof(fw_type));
> +		strscpy_pad(fw_type, tmp_fw_type, sizeof(fw_type));
>  	} else {
>  		tmp_fw_type = fw_type;
>  	}
> 
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_main-c-b05f78661635
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook

