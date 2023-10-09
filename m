Return-Path: <netdev+bounces-39289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC87BEB11
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 21:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA45281868
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3D23D3A3;
	Mon,  9 Oct 2023 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JNz0qgsY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1013CCE1
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 19:58:36 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9515EA3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 12:58:35 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3af604c3f8fso3475676b6e.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881515; x=1697486315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLuHSTvxz6vkfDxRZ/vqO8f0OQyjGiohBBwWRgjVl/4=;
        b=JNz0qgsYuK3TBnHTDPh/Cc8uro9vD0eEaeoje+InVGLUF7ebq4oIiwWPlHW3hBV6cm
         K5bjjD0d0TKKi4kyiXF6pWHhu2v34gR6/+gzFX/pBfEXU1HoIc/8oqKMyQop8Mjq+knU
         ND32KrXG51kEUrvqVOwSZmwbIrEJiBpaWMGa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881515; x=1697486315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLuHSTvxz6vkfDxRZ/vqO8f0OQyjGiohBBwWRgjVl/4=;
        b=RP6RoOCOFI9IxaGND6hevmkxDY2bf8ehB5gtrim0rPsE4nMa5MK51zsi+gwxtBIqgF
         krDQqTv2g0+F0nRsqGOIB577TI0dNRnRsIWqUnFSZAy0fg4YGuiMVr3t0B+6oJcxTSdP
         L9EnnuUJA2QH5Hv9RfKd8VsWcMpFS16vcZoO/MIbU6HeVbtrNMXEY75qrOO8meuKepuy
         GIqsKqIG0Am1nykPbkG89eXHp1oAeonh99P9BuZzn/PQUhj0YcDt48cRSeVFGnFT4u1f
         +UzNHgdjzJpF2FIx1WkJoDUh1p7RjFn0Yju0Z7SmJxsE6FDgtdUm77KmH+A/WcQlG5eM
         Gz2g==
X-Gm-Message-State: AOJu0YwiuMNgA2LCvTn2WTu2TdHoPjq5Lk6qlVmhQN7r3BzWQTRFwNYh
	rxIe+acn84xl4GrKALlExn3wbA==
X-Google-Smtp-Source: AGHT+IEYzKgq/AXneaurNLWylzPihiqK77Oe890uhQ8y3iiRMPVTe3Jvvb72QyLFVuRIES4e/xI2jw==
X-Received: by 2002:a05:6808:2d6:b0:3a7:3988:87ee with SMTP id a22-20020a05680802d600b003a7398887eemr16427801oid.58.1696881514875;
        Mon, 09 Oct 2023 12:58:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i6-20020a633c46000000b0058563287aedsm8906706pgn.72.2023.10.09.12.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:58:34 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:58:32 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] bna: replace deprecated strncpy with strscpy_pad
Message-ID: <202310091258.C4CDBBED7D@keescook>
References: <20231009-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v2-1-78e0f47985d3@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v2-1-78e0f47985d3@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 05:45:33PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> bfa_ioc_get_adapter_manufacturer() simply copies a string literal into
> `manufacturer`.
> 
> Another implementation of bfa_ioc_get_adapter_manufacturer() from
> drivers/scsi/bfa/bfa_ioc.c uses memset + strscpy:
> |	void
> |	bfa_ioc_get_adapter_manufacturer(struct bfa_ioc_s *ioc, char *manufacturer)
> |	{
> |		memset((void *)manufacturer, 0, BFA_ADAPTER_MFG_NAME_LEN);
> |			strscpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
> |	}
> 
> Let's use `strscpy_pad` to eliminate some redundant work while still
> NUL-terminating and NUL-padding the destination buffer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the update! Yeah, this looks safe to me now.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

