Return-Path: <netdev+bounces-55370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3606880AA9B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E503C2817CF
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F20D39854;
	Fri,  8 Dec 2023 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XvKRoBqi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1141BC5
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 09:21:53 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d0c94397c0so18096865ad.2
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702056112; x=1702660912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFy0vV+X2SwYGJQf+MCC3kNRROgyPGPpV16+DYgFvIU=;
        b=XvKRoBqiL7C5fXClblBmtpfgwi8AgMINKZiH2/vooa/uQ2n37epw//002hQDc+0xjy
         aF35qv/j4wDRbnNC4/qGYZjvpjumX+PlZBTXjWXKBpdNAWBy5VQqRHP7+dDxsTTPUYFY
         ADxX6CRTudomQURldo21Atph6Mq/UgCVCQBDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702056112; x=1702660912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFy0vV+X2SwYGJQf+MCC3kNRROgyPGPpV16+DYgFvIU=;
        b=tmbk/xf6hWEoXluNvZy7LQKJyT6NFTn4llApoAj7PGa9E/gP+SOo6lBWy68MuImFl4
         UkI4qPr3gC6t0AMPUWbjHN72YpSGewmAFcwguE9o8VtfaquBGlVtXItMKVVamRoHo0qQ
         8Lng69ph8cO5mVlCKvPogunx+xalnErQObLQ1mKnLdVUQKw/c0TlgxwkHv0AuqW1lhe9
         pKCpcuAE8Ti1nS5sIWNKNH9uG95IAoxILlEzMZ85TN8SZL2W2PlvgJxVh+YPsZ0Ush94
         ivrGWWFP4dNRqW8IhG2+ZB3AJ3d5NGsOI2sOQBsWPBGcce4Z6gLjgx1TJXaQhSXNVdFF
         NaMQ==
X-Gm-Message-State: AOJu0YxGZkmBxoROf5sG+pJ8EK9jy9znU1CzIF3KRufBhcYhz1fNDnm9
	sejbAFEFACWGYQJ98TpbP293hw==
X-Google-Smtp-Source: AGHT+IFBE3zMPa77AhEMIyR54IrCSnVfAxz3tKxrhVSOF23+vSFk1//u44z50ReWxtHlwvW+MceEOw==
X-Received: by 2002:a17:902:eb46:b0:1d0:71ab:b9b4 with SMTP id i6-20020a170902eb4600b001d071abb9b4mr338136pli.90.1702056112529;
        Fri, 08 Dec 2023 09:21:52 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001d0d3795b25sm1945089plq.172.2023.12.08.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:21:51 -0800 (PST)
Date: Fri, 8 Dec 2023 09:21:51 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] qlcnic: replace deprecated strncpy with strscpy
Message-ID: <202312080921.112091F614@keescook>
References: <20231207-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v2-1-eb1a20a91b2a@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v2-1-eb1a20a91b2a@google.com>

On Thu, Dec 07, 2023 at 09:42:22PM +0000, Justin Stitt wrote:
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
> Additionally replace size macro (QLC_FW_FILE_NAME_LEN) with
> sizeof(fw_info->fw_file_name) to more directly tie the maximum buffer
> size to the destination buffer:
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the refresh!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

