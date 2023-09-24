Return-Path: <netdev+bounces-36006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36E27AC67F
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 05:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 45FC728159E
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 03:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587F27E4;
	Sun, 24 Sep 2023 03:36:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C6654
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 03:36:22 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C927103
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 20:36:21 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690d2441b95so3344227b3a.1
        for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 20:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695526581; x=1696131381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fGfR3WXyetGC3RWgS0QiIbSubluI7C3Y7hWAwtVYmU=;
        b=X4Ju7pffVaUCH4vkcnwSCv722cNt87Gh9znwdVM2Mk2xM4OcBwFxl8BvYW0S/357Bf
         MhQBwmUdzc+VYZVvcDKJYMCfnaeDMVTtmC7fkegMWJk2DWnyYohZuq0/zFKcUggBzCYg
         WGKQEIEEaMq02LcmBrLNBDxVF1j6HJ2s2l9oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695526581; x=1696131381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fGfR3WXyetGC3RWgS0QiIbSubluI7C3Y7hWAwtVYmU=;
        b=aGrmfdw9pARkAqHhN1ibhnTR7XH+TFzQ5WoGqnkpKmy6c2hK9Z2dCsttf6b+KjdNEy
         0Tuf6hSEw2tBSE+aIwq3qMk3pVhCZFixcS0Ov39sA3GT7HJcLALTQJ6/YCMQCq97E9Mc
         MD4seAHE00rZZNt70VaXb6uhJzvvS45ik0LH30PduqWOt93qCBpfTN2PijH6jklVsBoe
         gcNMYjwaYbJq/mvqyvvMvzre32251G2kwjW4Y4NGsZlDSDM3KaMvthUhRWcz/UsoFjC/
         f7htBh8ktMLFdSMt0mr6AMSCvtK5++sgzhasuMZGK59e6a94H1Ro4U42U44FEKgsU3lt
         FcrA==
X-Gm-Message-State: AOJu0YyoJRO6Cn50LRueuUZmDpMztNZO5ze/RmQBcqz5T9U/eIrz+nxR
	TUUi2VDG3A0kUOu1MAFS7ZR7D+x0xitCT5UeSOo=
X-Google-Smtp-Source: AGHT+IEsbLZieOx6ZuiBto71jxQJ7MtE+cyB6NLqstbtzH888P2IAZTbf1cZ3AJUH+QeLrVqshZScQ==
X-Received: by 2002:a05:6a20:8e08:b0:13e:90aa:8c8b with SMTP id y8-20020a056a208e0800b0013e90aa8c8bmr5556857pzj.4.1695526580785;
        Sat, 23 Sep 2023 20:36:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s22-20020a62e716000000b0069023d80e63sm5545887pfh.25.2023.09.23.20.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:36:20 -0700 (PDT)
Date: Sat, 23 Sep 2023 20:36:19 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Karsten Keil <isdn@linux-pingi.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] isdn: kcapi: replace deprecated strncpy with strscpy_pad
Message-ID: <202309232034.38BC5E1C3@keescook>
References: <20230922-strncpy-drivers-isdn-capi-kcapi-c-v1-1-55fcf8b075fb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922-strncpy-drivers-isdn-capi-kcapi-c-v1-1-55fcf8b075fb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 11:49:14AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `buf` is used in this context as a data buffer with 64 bytes of memory
> to be occupied by capi_manufakturer.
> 
> We see the caller capi20_get_manufacturer() passes data.manufacturer as
> its `buf` argument which is then later passed over to user space. Due to
> this, let's keep the NUL-padding that strncpy provided by using
> strscpy_pad so as to not leak any stack data.
> | 	cdev->errcode = capi20_get_manufacturer(data.contr, data.manufacturer);
> | 	if (cdev->errcode)
> | 		return -EIO;
> |
> | 	if (copy_to_user(argp, data.manufacturer,
> | 			 sizeof(data.manufacturer)))
> | 		return -EFAULT;

Yup, strongly agreed: this needs the padding. I actually wonder if a
follow-up patch might be a good idea here, just for robustness:

 capi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
         struct capidev *cdev = file->private_data;
-       capi_ioctl_struct data;
+       capi_ioctl_struct data = { };


> 
> Perhaps this would also be a good instance to use `strtomem_pad` for but
> in my testing the compiler was not able to determine the size of `buf`
> -- even with all the hints.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

