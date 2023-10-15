Return-Path: <netdev+bounces-41063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939D77C97B3
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 04:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268F2B20C50
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 02:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3A1110A;
	Sun, 15 Oct 2023 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tz2NCax2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E04A15BE
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 02:47:19 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5FDDC
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 19:47:17 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9a398f411fso3793581276.3
        for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 19:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697338036; x=1697942836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tzh+rNnWynK5ZcN3b/YWGdv8qRdOA13vGqNJM9zZRX4=;
        b=Tz2NCax2dsuUxHNeFDSuW6DbZMDKvoxQIyEpWOajwif3z2+TCBzXWzS00xPTQcTx4N
         E9prI3MY8b5kDoPLaV2pPEkXiduwv0ksr2e4LpDtEFYkWt/hQjxdW/lL7eFDZEJ5GtV9
         Hwe0IjPFDUTXaKEIn9kyg442Ti2zZQN8iofjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697338036; x=1697942836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzh+rNnWynK5ZcN3b/YWGdv8qRdOA13vGqNJM9zZRX4=;
        b=FFkT33C5Os6h1WZaZO8QI9HG3aCiyP7Tc/FMSgwYWs4Y8XlszQVXv92Nd2yu1V7ZG9
         HMouCGtuuXnhRM1MxIQwCfLj36678wTXpS3eOwbl/y7AES6o3q2VzDwlP6Vcc5yXqrK2
         OTNT+fyne2wCu1UG5MNipImne24bmwzHZES2GzdNdrWHA+y/gALFAc78bTSuEvS3+mvD
         z8aahQjAGaZj64MPyadFLcYiv9xFESb8UzZZ1irOi+p7Xr6OTBbAaOAdsdB0N5dYwTMA
         VWAduL/felcG9/8iO9HAhvo1uEAIj8v6EpfGljK8o3VOTP36GcHXU1r/otpb6Ta3CvaU
         eBww==
X-Gm-Message-State: AOJu0Yw75V0PZpvpKLq308v8ylfx+l9sJUhTx9MnwnVKDw9zhLiCspXK
	1URfQXEpROWyTBdMU/y4yOW4sjsdR4sA8KcC9Q0=
X-Google-Smtp-Source: AGHT+IGw18lqrrhduG4jTuVZKWn5myx4C+3AqkfRYUY5Awp/+CRP7b49/Hik+o4kPmm55cncaXksbw==
X-Received: by 2002:a25:4c5:0:b0:d9b:2477:b625 with SMTP id 188-20020a2504c5000000b00d9b2477b625mr5041003ybe.54.1697338036105;
        Sat, 14 Oct 2023 19:47:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a6-20020aa79706000000b00696e8215d28sm2435194pfg.20.2023.10.14.19.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 19:47:15 -0700 (PDT)
Date: Sat, 14 Oct 2023 19:47:14 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qlcnic: replace deprecated strncpy with strscpy
Message-ID: <202310141944.08A1FF6D9@keescook>
References: <20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 07:44:29PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect fw_info->fw_file_name to be NUL-terminated based on its use
> within _request_firmware_prepare() wherein `name` refers to it:
> |       if (firmware_request_builtin_buf(firmware, name, dbuf, size)) {
> |               dev_dbg(device, "using built-in %s\n", name);
> |               return 0; /* assigned */
> |       }
> ... and with firmware_request_builtin() also via `name`:
> |       if (strcmp(name, b_fw->name) == 0) {
> 
> There is no evidence that NUL-padding is required.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.

When doing the hard-coded value to sizeof(), can you include in the
commit log the rationale for it? For example:

  Additionally replace size macro (QLC_FW_FILE_NAME_LEN) with
  sizeof(fw_info->fw_file_name) to more directly tie the maximum buffer
  size to the destination buffer:

  struct qlc_83xx_fw_info {
          ...
          char    fw_file_name[QLC_FW_FILE_NAME_LEN];
  };


> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> index c95d56e56c59..b733374b4dc5 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> @@ -2092,8 +2092,8 @@ static int qlcnic_83xx_run_post(struct qlcnic_adapter *adapter)
>  		return -EINVAL;
>  	}
>  
> -	strncpy(fw_info->fw_file_name, QLC_83XX_POST_FW_FILE_NAME,
> -		QLC_FW_FILE_NAME_LEN);
> +	strscpy(fw_info->fw_file_name, QLC_83XX_POST_FW_FILE_NAME,
> +		sizeof(fw_info->fw_file_name));
>  
>  	ret = request_firmware(&fw_info->fw, fw_info->fw_file_name, dev);
>  	if (ret) {
> @@ -2396,12 +2396,12 @@ static int qlcnic_83xx_get_fw_info(struct qlcnic_adapter *adapter)
>  		switch (pdev->device) {
>  		case PCI_DEVICE_ID_QLOGIC_QLE834X:
>  		case PCI_DEVICE_ID_QLOGIC_QLE8830:
> -			strncpy(fw_info->fw_file_name, QLC_83XX_FW_FILE_NAME,
> -				QLC_FW_FILE_NAME_LEN);
> +			strscpy(fw_info->fw_file_name, QLC_83XX_FW_FILE_NAME,
> +				sizeof(fw_info->fw_file_name));
>  			break;
>  		case PCI_DEVICE_ID_QLOGIC_QLE844X:
> -			strncpy(fw_info->fw_file_name, QLC_84XX_FW_FILE_NAME,
> -				QLC_FW_FILE_NAME_LEN);
> +			strscpy(fw_info->fw_file_name, QLC_84XX_FW_FILE_NAME,
> +				sizeof(fw_info->fw_file_name));
>  			break;
>  		default:
>  			dev_err(&pdev->dev, "%s: Invalid device id\n",

But yes, this all looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

