Return-Path: <netdev+bounces-28206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D2377EACE
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD131C211CB
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5882F17729;
	Wed, 16 Aug 2023 20:38:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4941FD50F
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:38:04 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08202E74
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:38:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68879c7f5easo1219442b3a.1
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692218282; x=1692823082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJIlP+1/qA6fcDc2Mru+2eZCt7jBZOXqJQckio1X6xc=;
        b=IQAAyoMIMRMlYm4RH2Fzi0XDoBtqTCbmQjx89YHvHuV4+MfX7axqYeLaL+9hO0U0Ue
         v1EkYDflL9QccT+IKePO0WZ/Hqy7WO3phw96Xo2MEp8AqDkuie8yKmXorIiCu+WuNbb3
         H6g0i7Udm+oGcKdpmnwMLhRnccBHsLiaQvkI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218282; x=1692823082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJIlP+1/qA6fcDc2Mru+2eZCt7jBZOXqJQckio1X6xc=;
        b=XWIYqFVRmcMzjdDPLxzFSKUg8ZmVlEGOfc/FLk3L3xNVEZ5iLVaydXD/h/FaBt+zry
         7+4FcU0ZDTHdcYYbnP+BYhtAksLEU+fwQNj7N27TocoZ0w/++5wSXh65L//Q1NWKnX2c
         gGJuVHAMSZUdkMinM4AJnRF5N6ztstZXNbBXL+pkmTnFwWg9aMaktfGgnFlSyRlbLHy/
         7ln737F+Cal6rj2bKVgxIi182SmS9WpyV9tplwXFKiDK38n2VxBgBvh+KctSri+Ekaqb
         8+sm/hcilBy69j/+2p2s1OR3SYm2tgsJCGDTIporfaMVr2mWsJ/feUbZEpjeyTspFlEJ
         ZNhQ==
X-Gm-Message-State: AOJu0Yz4WYnhmrnQMzmc1E8rY7OVrsyIheucoTEEFdPenF2V6nZAaxdo
	r8Pkzj3lcPGj64lXLEiVs2KJdZDPNZVNZIFWg9k=
X-Google-Smtp-Source: AGHT+IGD+Plh3BsUd0TQTpVgaXEavYIMr8Q2oQgh+U/utLjGSkkg77n0HL7nHAFnesuGqd5CBWellg==
X-Received: by 2002:a05:6a00:3a03:b0:679:bc89:e5b with SMTP id fj3-20020a056a003a0300b00679bc890e5bmr2845336pfb.19.1692218282505;
        Wed, 16 Aug 2023 13:38:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 24-20020aa79218000000b00682d79199e7sm11427546pfo.200.2023.08.16.13.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:38:01 -0700 (PDT)
Date: Wed, 16 Aug 2023 13:38:01 -0700
From: Kees Cook <keescook@chromium.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org, Steven Zou <steven.zou@intel.com>
Subject: Re: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Message-ID: <202308161337.975C93F163@keescook>
References: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
 <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 10:06:17AM -0400, Przemek Kitszel wrote:
> Add DEFINE_FLEX() macro for on-stack allocations of structs with
> flexible array member.
> 
> Expose __struct_size() macro outside of fortify-string.h, as it could be
> used to read size of structs allocated by DEFINE_FLEX().
> Move __member_size() alongside it.
> -Kees
> 
> Using underlying array for on-stack storage lets us to declare
> known-at-compile-time structures without kzalloc().
> 
> Actual usage for ice driver is in following patches of the series.
> 
> Missing __has_builtin() workaround is moved up to serve also assembly
> compilation with m68k-linux-gcc, see [1].
> Error was (note the .S file extension):
> In file included from ../include/linux/linkage.h:5,
>                  from ../arch/m68k/fpsp040/skeleton.S:40:
> ../include/linux/compiler_types.h:331:5: warning: "__has_builtin" is not defined, evaluates to 0 [-Wundef]
>   331 | #if __has_builtin(__builtin_dynamic_object_size)
>       |     ^~~~~~~~~~~~~
> ../include/linux/compiler_types.h:331:18: error: missing binary operator before token "("
>   331 | #if __has_builtin(__builtin_dynamic_object_size)
>       |                  ^

Looks good to me! Thanks for working on this. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

