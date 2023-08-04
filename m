Return-Path: <netdev+bounces-24591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE59770BFA
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 00:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E871C20D9B
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3EAD4A;
	Fri,  4 Aug 2023 22:39:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B158FA23
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 22:39:56 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2266446B3
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:39:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bb775625e2so18127355ad.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 15:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691188794; x=1691793594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wPee1J6TpdjMsw6ipZy9FBWL3pUhaM/U7Pcka80w5kY=;
        b=kU1NJ699RieHvnZynhRR1tZDgaq8FOa9KWHMnWwOMc6nsQdpABZmSV8OBW2SdDqaf+
         YtUFXleebjAbPK9esqDMYQxYaFCfRwdRtUfqRTDxT62sI/0MUhOv6P43eURVaAtSBeR5
         Om+xtqnyhNlvLUsSwU3Xj/u9zNP9L00Cur0cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691188794; x=1691793594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPee1J6TpdjMsw6ipZy9FBWL3pUhaM/U7Pcka80w5kY=;
        b=k9WWdVF6JeLddQQV4XQXzbpKO01h5Zx6XLbp4aG0gdZBM/88CkOjB91MN4UhTyE63O
         7zO9IvsnM9/4UgX5e7Fh/oCIu0Acyvvop2qwlACp1FAfmRZ1sC6myZtxVrzEhqwt1V0Z
         6EP5pW5XWE2em6x5AaEMgMuHzPofB023fN1EFGjvs5ZlTDZ72ZzYeXbn+gB7Hq/3ag2W
         S7uAuR8EWOjfDV31NwgRPWZpleovVxFgSLwfEBwAPsiemd0Y7yJkfPMF1P3JzucevFc6
         lVzN0xAySSISQ2boadvMXWDY+JQrLjN1vVzVjsruNrceODHNA9mUXCiN4cnb9LsMSVjV
         qsUA==
X-Gm-Message-State: AOJu0YypBqnImdWnO27SS8pgNs1I+OlgVLQkvi8Uu+ID+naEVixuAw3d
	528y0mpvWgrEQT4p1yZ2fgE3/w==
X-Google-Smtp-Source: AGHT+IE9GkA47jrZXTpxd4BjO6ZlWM4VsVLbDWn4hEr0gD9DC20BTj1V4ibSytY8ZYpCblhIwgYfrA==
X-Received: by 2002:a17:902:dac1:b0:1ba:fe6a:3845 with SMTP id q1-20020a170902dac100b001bafe6a3845mr1311380plx.11.1691188794640;
        Fri, 04 Aug 2023 15:39:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001bb04755212sm2218960pls.228.2023.08.04.15.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 15:39:54 -0700 (PDT)
Date: Fri, 4 Aug 2023 15:39:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [RFC net-next 1/2] overflow: add DECLARE_FLEX() for on-stack
 allocs
Message-ID: <202308041539.888828AC3@keescook>
References: <20230801111923.118268-1-przemyslaw.kitszel@intel.com>
 <20230801111923.118268-2-przemyslaw.kitszel@intel.com>
 <202308011403.E0A8D25CE@keescook>
 <e0cb5bf2-2278-b83f-c45c-0556927787a6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0cb5bf2-2278-b83f-c45c-0556927787a6@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 03:47:48PM +0200, Przemek Kitszel wrote:
> On 8/2/23 00:31, Kees Cook wrote:
> 
> [...]
> 
> > Initially I was struggling to make __counted_by work, but it seems we can
> > use an initializer for that member, as long as we don't touch the flexible
> > array member in the initializer. So we just need to add the counted-by
> > member to the macro, and use a union to do the initialization. And if
> > we take the address of the union (and not the struct within it), the
> > compiler will see the correct object size with __builtin_object_size:
> > 
> > #define DEFINE_FLEX(type, name, flex, counter, count) \
> >      union { \
> >          u8   bytes[struct_size_t(type, flex, count)]; \
> >          type obj; \
> >      } name##_u __aligned(_Alignof(type)) = { .obj.counter = count }; \
> >      /* take address of whole union to get the correct __builtin_object_size */ \
> >      type *name = (type *)&name##_u
> > 
> > i.e. __builtin_object_size(name, 1) (as used by FORTIFY_SOURCE, etc)
> > works correctly here, but breaks (sees a zero-sized flex array member)
> > if this macro ends with:
> > 
> >      type *name = &name##_u.obj
> 
> __builtin_object_size(name, 0) works fine for both versions (with and
> without .obj at the end)

Mode 0 will be unchanged, but mode 1 is what most of FORTIFY uses for
keep the scope narrow.

> however it does not work for builds without -O2 switch, so struct_size_t()
> is rather a way to go :/

FORTIFY depends on -O2, so no worries. :)

-- 
Kees Cook

