Return-Path: <netdev+bounces-37110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F317C7B3ABA
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 21:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 1C48C1C2074B
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 19:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B90566DD7;
	Fri, 29 Sep 2023 19:37:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1673A66DD2
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 19:37:31 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB9D1B3
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 12:37:29 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690d2441b95so796209b3a.1
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696016248; x=1696621048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pz6XxrokHS8tD3oX5YP+XUhcoroypZl9efJWa+Ud3No=;
        b=i5UNO6IicrDU38SjFqnx8ZSKG8LC+34CX3yvrdXgpLQ/GZkqJKAHlsWIqAJJMMAK2l
         9LgOSriZcDVECFjg+6DSX14LWYALdrPyTwHCVM4Pgavlah6DsislwFVwPNboVJGsVCvI
         GN9Ojr3nO8VtQ476zOqxJFNzVuavvmxegsRGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696016248; x=1696621048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pz6XxrokHS8tD3oX5YP+XUhcoroypZl9efJWa+Ud3No=;
        b=BQ1iieSH+Ini4vQvxRW+xgZCd3ogDc/xDd90vfhlo5Vm9ExVGMPgmZEK4N6n1RiFWr
         tb0nPZIGYjVS30Xyh+lUclqcmC09QqR8Ipunr75PJyt3t9vnjB8Mfs9DMV+yj8Q5oUAz
         Zhsv9eVZ9w/vHrNvkq2EpSev9fxQvYgM22yupcShIkIrG2OY5X8WVR/KtXrGUp+DJ6UA
         eFAO3eKU15gpETk2nA0gnxX7IgnFUF1ReRAIaFb0z14cgM9xWU4SKMJ/LTopTrLQ2jz4
         XUlzsbpJaW9xW9WM6L4DrsdBVX2dULc0jUefUkPZF0zZwcYvwLdz+XrCAYw0d/YxQid6
         soCg==
X-Gm-Message-State: AOJu0Yz1gQ4VTP5vLpaRkRa6c+XUQssJ27s0dCX9wk2KkjX+mYYDiqWP
	LI2g1Rp+P7vmjWW+6VLK+wMi0bpwxCUQtf0HxM0=
X-Google-Smtp-Source: AGHT+IEnN6bxYqpGvl9ktJGtLQQ5mwKyJ3TeMFdfpa66gryjMY4jCfgv/JejeF1KEVIKsl05FW+Sew==
X-Received: by 2002:a05:6a20:4420:b0:13e:debc:3657 with SMTP id ce32-20020a056a20442000b0013edebc3657mr7894820pzb.30.1696016248658;
        Fri, 29 Sep 2023 12:37:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i17-20020aa78b51000000b0066a4e561beesm15931376pfd.173.2023.09.29.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:37:28 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Karsten Keil <isdn@linux-pingi.de>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] isdn: kcapi: replace deprecated strncpy with strscpy_pad
Date: Fri, 29 Sep 2023 12:37:25 -0700
Message-Id: <169601624548.3016093.6534786691169747871.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922-strncpy-drivers-isdn-capi-kcapi-c-v1-1-55fcf8b075fb@google.com>
References: <20230922-strncpy-drivers-isdn-capi-kcapi-c-v1-1-55fcf8b075fb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 22 Sep 2023 11:49:14 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `buf` is used in this context as a data buffer with 64 bytes of memory
> to be occupied by capi_manufakturer.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] isdn: kcapi: replace deprecated strncpy with strscpy_pad
      https://git.kernel.org/kees/c/69cee158c9b0

Take care,

-- 
Kees Cook


