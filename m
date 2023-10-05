Return-Path: <netdev+bounces-38446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2067BAF45
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 78FEF1C20944
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 23:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE343AAB;
	Thu,  5 Oct 2023 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LVj33L2U"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7835C43693
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 23:22:15 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F3BD50
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:22:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-578b407045bso1192557a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696548132; x=1697152932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bji6Y/iqc3Ls4HMnb/SvLNQn11BkVMYtm7umOlKP+Y=;
        b=LVj33L2UFWQMakAG3Bh/RooDyc4ptKeAgr8LVX6xm06gxXWhqKvr27XMxlnkff1j25
         y0zatUiKeEdOeq0EHCNmlEvd+yHB2hv2JBbBKaZFlM2Hx7EHw8pwC7oyySvXHdwYlc2d
         gD8GmwG2DBQlZXG7nh+3cGTzk1CZpZbtj0JWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696548132; x=1697152932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bji6Y/iqc3Ls4HMnb/SvLNQn11BkVMYtm7umOlKP+Y=;
        b=UN6ZSP0L8Ux16xwN/H6es1R2N5sYqiZ/hy9xcGhug996e22YMdDvG7deTgLQU7JYd0
         TmplT78wwy7VQA96pKFPB0NfORUsPFJ/jSF4agpxT81H9LOtNh+IC54CEAbQr298fs7k
         eowuT3iNALM18TWO+r2PSFpNCtPAWJOBy+U1p70Xhbg0Qn4ol/bCgZa9Wad3lCxRUhvE
         AQy3LkItI7ByJBybBkimeSJjfMa6bDfXL7VuzAOyylHR1l3aAqKjmbcHdxIGl4f5WNBJ
         JZwmhqtCGEW9JEBSBWWEDhwbyu/NWHjIi/iBN/dq6QKkayLeu8qsM8kyXLrTiAiAhTHA
         DTJg==
X-Gm-Message-State: AOJu0YwqbpZ5Am7dOFy+OnAzT9dHB2vV4r9zbsTUcqg+rFa7jZxBgwqS
	r013575r551qfDyEVXseTr8RnA==
X-Google-Smtp-Source: AGHT+IHcVAOVq3Ibd4ay7/n9G/MxAAd8KXHRxyv+DWM76fM8x8ZKzUr/Kz0H3QBJYudJsStbU5RLpQ==
X-Received: by 2002:a05:6a20:1596:b0:137:74f8:62ee with SMTP id h22-20020a056a20159600b0013774f862eemr7879316pzj.18.1696548132606;
        Thu, 05 Oct 2023 16:22:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m7-20020aa78a07000000b0064fd4a6b306sm129832pfa.76.2023.10.05.16.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 16:22:12 -0700 (PDT)
Date: Thu, 5 Oct 2023 16:22:10 -0700
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
Subject: Re: [PATCH] cavium/liquidio: replace deprecated strncpy with strscpy
Message-ID: <202310051621.3893B1EA4@keescook>
References: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-octeon_device-c-v1-1-9a207cef9438@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-octeon_device-c-v1-1-9a207cef9438@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 10:52:34PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `app_name` to be NUL-terminated:
> 	dev_info(&oct->pci_dev->dev,
> 		 "Running %s (%llu Hz)\n",
> 		 app_name, CVM_CAST64(cs->corefreq));
> ... and it seems NUL-padding is not required, let's opt for strscpy().
> 
> For `oct->boardinfo.name/serial_number` let's opt for strscpy() as well
> since it is expected to be NUL-terminated and does not require
> NUL-padding as `oct` is zero-initialized in octeon_device.c +707:
> |       buf = vzalloc(size);
> |       if (!buf)
> |       	return NULL;
> |
> |       oct = (struct octeon_device *)buf;
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/cavium/liquidio/octeon_device.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_device.c b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
> index 364f4f912dc2..6b6cb73482d7 100644
> --- a/drivers/net/ethernet/cavium/liquidio/octeon_device.c
> +++ b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
> @@ -1217,10 +1217,10 @@ int octeon_core_drv_init(struct octeon_recv_info *recv_info, void *buf)
>  		goto core_drv_init_err;
>  	}
>  
> -	strncpy(app_name,
> +	strscpy(app_name,
>  		get_oct_app_string(
>  		(u32)recv_pkt->rh.r_core_drv_init.app_mode),
> -		sizeof(app_name) - 1);
> +		sizeof(app_name));

Direct replacement, good.

>  	oct->app_mode = (u32)recv_pkt->rh.r_core_drv_init.app_mode;
>  	if (recv_pkt->rh.r_core_drv_init.app_mode == CVM_DRV_NIC_APP) {
>  		oct->fw_info.max_nic_ports =
> @@ -1257,9 +1257,10 @@ int octeon_core_drv_init(struct octeon_recv_info *recv_info, void *buf)
>  	memcpy(cs, get_rbd(
>  	       recv_pkt->buffer_ptr[0]) + OCT_DROQ_INFO_SIZE, sizeof(*cs));
>  
> -	strncpy(oct->boardinfo.name, cs->boardname, OCT_BOARD_NAME);
> -	strncpy(oct->boardinfo.serial_number, cs->board_serial_number,
> -		OCT_SERIAL_LEN);
> +	strscpy(oct->boardinfo.name, cs->boardname,
> +		    sizeof(oct->boardinfo.name));
> +	strscpy(oct->boardinfo.serial_number, cs->board_serial_number,
> +		    sizeof(oct->boardinfo.serial_number));

struct octeon_board_info {
        char name[OCT_BOARD_NAME];
        char serial_number[OCT_SERIAL_LEN];

Good, sizeof()s match.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

