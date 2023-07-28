Return-Path: <netdev+bounces-22418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EA07676FA
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 22:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112F128266D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 20:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70001BB51;
	Fri, 28 Jul 2023 20:29:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB290EDC
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 20:29:24 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5853F422B
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 13:29:23 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76595a7b111so197498285a.2
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690576162; x=1691180962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eMyiYSraWOsfgY7mYokHSSuNHn+kD9GoiXATa0bMhbA=;
        b=CyBzgfMVag2WTWwhwboVgeQuGJ8BrCm87IB6j9uR6o6bep1JkWYRgrEgDybWowy+kJ
         YqNGl2ezH5o2/HFJPLiJ7Owzdi28zy+HpYhNpsVVxYi5pj9pTA0Yuv9d1vkm3rwLWYPm
         tvqU7DbjNhxOp4sXeS2yP2ybAXRqtiW0dZiN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690576162; x=1691180962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMyiYSraWOsfgY7mYokHSSuNHn+kD9GoiXATa0bMhbA=;
        b=gV4+PEV3udbtTk+EA1hIB4eWAIyoNSnIEGn+Ctg5dyJYzAref8xixGjO5YKNsnlEyq
         xsGKxzFTfXMpjEESXbOsvjw2HcA9ah3G8CX5X9+KupeodAN+NHC/6+3J175tJ6zsrsFk
         xYu7I+6Tfd6fU+DOcB4dM0AlOHaRjARwlNN7RGFjWjHax2wy/54x/Yu+SIi0+aLm7XXW
         mx5uJPJU6DDjnV84Y3DPxKEaIAbvFcTFg+aY8Q9CoprDv4+MVdAziAab4t24AFYhcJrs
         iIo1l2f3163ZE4vKdDqhj50Rf19mq6lL9mhpp2VeN46pLpRL49poKZOZEbynJGIkGTJj
         K3Fw==
X-Gm-Message-State: ABy/qLb0L8cnwlBXMyEqqYD9ZeoJt+z0b7wYCAi2xodoSDf+i7BY2CJz
	w6+l63r4rjQg6JMwzpaN+OSELg==
X-Google-Smtp-Source: APBJJlEH8lk5dwyzE/DgADvnA4XqnbUm4KS8L0cE5+GCBLvF3aA9Fy8KrmFx861A+YXH+5lm8F2GOw==
X-Received: by 2002:a05:620a:2ac5:b0:767:117c:f57b with SMTP id bn5-20020a05620a2ac500b00767117cf57bmr4052291qkb.8.1690576162510;
        Fri, 28 Jul 2023 13:29:22 -0700 (PDT)
Received: from meerkat.local ([142.113.79.114])
        by smtp.gmail.com with ESMTPSA id f7-20020a05620a15a700b007682634ac20sm1372246qkk.115.2023.07.28.13.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 13:29:22 -0700 (PDT)
Date: Fri, 28 Jul 2023 16:29:13 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, geert@linux-m68k.org, gregkh@linuxfoundation.org, 
	netdev@vger.kernel.org, workflows@vger.kernel.org, mario.limonciello@amd.com
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from using
 file paths
Message-ID: <20230728-egotism-icing-3d0bd0@meerkat>
References: <CAHk-=whCE9cWmTXu54WFQ7x-aH8n=dhCux2h49=pYN=14ybkxg@mail.gmail.com>
 <20230726130318.099f96fc@kernel.org>
 <CAHk-=wjfC4tFnOC0Lk_GcU4buf+X-Jv965pWg+kMRkDb6hX6mw@mail.gmail.com>
 <20230726133648.54277d76@kernel.org>
 <CAHk-=whZHcergYrraQGgazmOGMbuPsDfRMBXjFLo1aEQPqH2xQ@mail.gmail.com>
 <20230726145721.52a20cb7@kernel.org>
 <20230726-june-mocha-ad6809@meerkat>
 <20230726171123.0d573f7c@kernel.org>
 <20230726-armless-ungodly-a3242f@meerkat>
 <1b96e465-0922-4c02-b770-4b1f27bebeb8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b96e465-0922-4c02-b770-4b1f27bebeb8@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 01:00:15PM +0200, Andrew Lunn wrote:
> > Think as if instead of being Cc'd on patches, they got Bcc'd on them.
> 
> And how does reply work? I assume it would only go to those in To: or
> Cc: ? Is there enough context in the headers in a reply for the system
> to figure out who to Bcc: the reply to?

I have actually solved a similar problem already as part of a different
project (bugbot). We associate a set of additional addresses with a thread and
can send any thread updates to those addresses.

It would require a bit more effort to adapt it so we properly handle bounces,
but effectively this does what you're asking about -- replies sent to a thread
will be sent out to all addresses we've associated with that thread (via
get_maintainer.pl). In a sense, this will create a miniature pseudo-mailing
list per each thread with its own set of subscribers.

I just need to make sure this doesn't fall over once we are hitting
LKML-levels of activity.

-K

