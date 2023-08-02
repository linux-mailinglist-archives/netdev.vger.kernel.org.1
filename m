Return-Path: <netdev+bounces-23785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19D776D846
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3C8281D9E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C4311197;
	Wed,  2 Aug 2023 19:59:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A091078F
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:59:16 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0E22101
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 12:59:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686be28e1a8so146612b3a.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691006354; x=1691611154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/aA++90/fHCZVh7rcJAqnB4uADfByOv/2qJK2PTK8tE=;
        b=AVzmg/QvoodRNbXCaoo6UCWEOmJTDZkOPCrWOd7bjQlQCeeTdfqXGImKbUmMcbqts0
         P/zl0oxtVZrnw13aqmoicSmo+GrW8bz7RtfVM3F1J4jtovkb811JIMCaBVmWnpfSXviP
         Gw0JeczO8k98S2psQSEENSvByatX1RS6Yckh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691006354; x=1691611154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aA++90/fHCZVh7rcJAqnB4uADfByOv/2qJK2PTK8tE=;
        b=Fw3CdH3sk25ffWVAWzj9mPUuWgX9Wy/93Ehc418ToSK8kDNdTaWnVqGXfdamNwnpp1
         oNZPp8QJyxtE8Eekd9iOTynZHnV+VfWTcwCTEdHJllxCm45PZ16fuFT/4J8ElmAuSott
         kiOINvL65ZvWUbiNui1KbBwEn502aIvKnpMK3MOKIGZieJesaLfqALcYcODNajSD6hCV
         toeJq4IM/iIJ5f/aCKE5VanNBH+PvAXkdIk9re8TMuAdNVBpzgK0J4D5lzexhmtIMztm
         D8smB7hH4He2yxs0gqi8X1atVhc1QPUzSAJ/bPDiL/ptpGhltdTcGJARTimivgqMtzdo
         v+hw==
X-Gm-Message-State: ABy/qLaT7U4VcYNuvsAP9TEb0is0Nzy7bZh/E4wXjLTObYp1eC0WX80G
	bxD/KwAGqwdCAI1zM1nukUGuaw==
X-Google-Smtp-Source: APBJJlGRIRM0zaiDLPqaJbDXG+V7IHTHMlItsJinyOGJ/4TgiIKhU0mdE0RQajnU+sOFZQM9vrkuRQ==
X-Received: by 2002:a05:6a00:16c2:b0:687:570:5021 with SMTP id l2-20020a056a0016c200b0068705705021mr19158141pfc.15.1691006353941;
        Wed, 02 Aug 2023 12:59:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b9-20020aa78109000000b0064378c52398sm11403642pfi.25.2023.08.02.12.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:59:13 -0700 (PDT)
Date: Wed, 2 Aug 2023 12:59:12 -0700
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: isdn@linux-pingi.de, netdev@vger.kernel.org, samitolvanen@google.com,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] mISDN: Update parameter type of dsp_cmx_send()
Message-ID: <202308021255.9A6328D@keescook>
References: <20230802-fix-dsp_cmx_send-cfi-failure-v1-1-2f2e79b0178d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802-fix-dsp_cmx_send-cfi-failure-v1-1-2f2e79b0178d@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 10:40:29AM -0700, Nathan Chancellor wrote:
> When booting a kernel with CONFIG_MISDN_DSP=y and CONFIG_CFI_CLANG=y,
> there is a failure when dsp_cmx_send() is called indirectly from
> call_timer_fn():
> 
>   [    0.371412] CFI failure at call_timer_fn+0x2f/0x150 (target: dsp_cmx_send+0x0/0x530; expected type: 0x92ada1e9)
> 
> The function pointer prototype that call_timer_fn() expects is
> 
>   void (*fn)(struct timer_list *)
> 
> whereas dsp_cmx_send() has a parameter type of 'void *', which causes
> the control flow integrity checks to fail because the parameter types do
> not match.
> 
> Change dsp_cmx_send()'s parameter type to be 'struct timer_list' to
> match the expected prototype. The argument is unused anyways, so this
> has no functional change, aside from avoiding the CFI failure.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308020936.58787e6c-oliver.sang@intel.com
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> I am not sure if there is an appropriate fixes tag for this, I see this
> area was modified by commit e313ac12eb13 ("mISDN: Convert timers to use
> timer_setup()") but I don't think it was the original source of the
> issue. It could also be commit cf68fffb66d6 ("add support for Clang
> CFI") but I think that just exposes the problem/makes it fatal.

Oh man. I missed one! How did I miss that one? I think "Fixes:
e313ac12eb13" is the most correct. That was the patch that went through
trying to fix all the prototypes, and _did_ fix all the _other_ prototypes
in there.

Thanks for the patch!

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
> Also not sure who should take this or how soon it should go in, I'll let
> that to maintainers to figure out :)

If no one speaks up, I'll snag it, but since this got aimed at netdev, I
suspect someone may pick it up. :)

-Kees

-- 
Kees Cook

