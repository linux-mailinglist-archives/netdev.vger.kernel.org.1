Return-Path: <netdev+bounces-28537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B8C77FC71
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228E2281FD0
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB1168D0;
	Thu, 17 Aug 2023 17:00:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D15168C0
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:00:20 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F6C2D72
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 10:00:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-688787570ccso2049666b3a.2
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692291619; x=1692896419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJhpOKYygfVTwv/muBcWLGwZoRPdxuU8yz2KMU9B00o=;
        b=BXFnBPkfR3sQEgInQUXxcixS4Rxh5w0uTrfa8bekCw4+fl6YRwyldBR2Cd6t1X9x8z
         3Uzvb4SGP3p+l/QkarFDWiXW97wF+umwHMIfTdKYKMnIlSevQoPRHpj0/Muw/v4aJDt6
         HcVyK5RXx+fRlZYdVgRmcyTrUqOulmp6cFuDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692291619; x=1692896419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJhpOKYygfVTwv/muBcWLGwZoRPdxuU8yz2KMU9B00o=;
        b=DUB0vw5nAfgAGCAG29G0kEDjwrsn2EJ3G2DMnS9BShD1Ps9QiTB6naRYnASXqELBS+
         6oWHMMaL7uzwQKFBevkUzY7LQlhfZ1fexzNtIHCVdx6SJxT7LOR26sCzKfbbokTfZkNl
         YsXEvA63Y8wzV1EFdzFkabqAvFskM5uhxSq2WeamQOPF7YETQ9alS6IdquHI3Ugb8LRD
         YPTdaZQYlnt9KrPEMbbdW2B9LcSUaPOIsxqAnC38SZ1RGZhiAFyTA0MV7676eG9NcRcp
         wa9XjkmzY8kxnDAnoV6LsXRpeFYgV3y90CE6tPvGoC1mB7P5J+keUlqzkNTGiW+hs5NT
         zB9A==
X-Gm-Message-State: AOJu0Yz3eKKv8fJSMhP+WAmSPQgqlAmc6tOzls0SsONDO2ZBWpD+6w/Y
	lb9Lqwy+YCBIfPv1uxPDJRSH6g==
X-Google-Smtp-Source: AGHT+IGfkKsLOQz6+e+EW5vzdI+McSp2GYuMvONN8EpwvhQgT4MGydmr4ZY2beFstZQdjjWOFyBPoQ==
X-Received: by 2002:a05:6a20:8421:b0:13b:a4fd:3017 with SMTP id c33-20020a056a20842100b0013ba4fd3017mr304951pzd.46.1692291618930;
        Thu, 17 Aug 2023 10:00:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t4-20020a62ea04000000b006884844dfcasm7319pfh.20.2023.08.17.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 10:00:18 -0700 (PDT)
Date: Thu, 17 Aug 2023 10:00:17 -0700
From: Kees Cook <keescook@chromium.org>
To: David Laight <David.Laight@aculab.com>
Cc: 'Przemek Kitszel' <przemyslaw.kitszel@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Steven Zou <steven.zou@intel.com>
Subject: Re: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Message-ID: <202308170957.F511E69@keescook>
References: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
 <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
 <1f9cb37f21294c31a01af62fd920f070@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f9cb37f21294c31a01af62fd920f070@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 02:35:23PM +0000, David Laight wrote:
> From: Przemek Kitszel
> > Sent: Wednesday, August 16, 2023 3:06 PM
> > 
> > Using underlying array for on-stack storage lets us to declare
> > known-at-compile-time structures without kzalloc().
> 
> Isn't DEFINE_FLEX() a bit misleading?
> One thing it isn't is 'flexible' since it has a fixed size.

It works only on flex array structs, and defines a specific instance. I
think naming is okay here.

> 
> > +#define DEFINE_FLEX(type, name, member, count)					\
> > +	union {									\
> > +		u8 bytes[struct_size_t(type, member, count)];			\
> > +		type obj;							\
> > +	} name##_u __aligned(_Alignof(type)) = {};				\
> 
> You shouldn't need the _Alignof() it is the default.

In the sense that since "type" is in the union, it's okay?

> I'm not sure you should be forcing the memset() either.

This already got discussed: better to fail safe.

> 
> > +	type *name = (type *)&name##_u
> 
> How about?
> 	type *const name = &name_##_u.obj;

This is by design (see earlier threads) so that
__builtin_object_size(name, 1) will get the correct size. Otherwise it
doesn't include the FAM elements in the size.

> 
> You might want to add:
> 	Static_assert(is_constexpr(count), "DEFINE_FLEX: non-constant count " #count);

That would be nice, though can Static_assert()s live in the middle of
variable definitions?

-Kees

-- 
Kees Cook

