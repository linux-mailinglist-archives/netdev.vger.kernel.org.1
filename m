Return-Path: <netdev+bounces-26548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE0E778108
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 21:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88280281C83
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED822F0B;
	Thu, 10 Aug 2023 19:07:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08AA20FAC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 19:07:43 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4862D4B
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 12:07:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc83a96067so9677115ad.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691694460; x=1692299260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nmOwYu+wAsqoAkxbWGneNadnCgLM0c5R8LClfgUNH9I=;
        b=QkOkm0aFedzWAtuNszKzcm0KrHyY4YEWT0ltIriL5dNGRCGtKtfbjQGZDoRu8PHTGL
         2q19rGzd320iFiPEMeYLLVjDrO+n8xsOaMVVVB1p6UAnbmbd6CBz92szKDrxxgg9pRQn
         Rn8S9Iw75DpdEDSpYWSO36hoPOuxO4htgB28E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694460; x=1692299260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmOwYu+wAsqoAkxbWGneNadnCgLM0c5R8LClfgUNH9I=;
        b=R5e9GPZDkBLz2GxasPLIetXA8smoaRWgxPIQLinIaFpd4n35PBJpibTyJK4WUyfbtF
         apooKLCA7JpJP3Em1hs5wzL1AbSnGhMY8Gu69Bvx2smFmNCbN+BogoHpXuZzbepsDOiF
         xt0ZPRszC4wt8LCLhOqPsH5NllgmU3wV5ngP+4JCsm4j6vbjX4no8ZrPSEndFnSroTaz
         /SQhDNYOlzkOpEJfMD9IsNUQLsxg8MCdinhgjkN7eaRi9VJnObvfwUpQzUo6yhlIjt9x
         EzqLI4BRHbwcYF8XRkHEL/LTEEayXlpa55XHDyvPmJ0n2X5i4xTKHMT5qOqcS+OS4ABD
         W2OQ==
X-Gm-Message-State: AOJu0YylkL4k/gOp8WZUaxxcVhMRg/W+NalC+zdhe/Z2CGdkEy06Y/Pg
	snSPzyMX4BqKZqqdPZlgZiVRQA==
X-Google-Smtp-Source: AGHT+IEmgnGLrUOSbaCk2ycL3uzAZ+J06bwEXpv2ztZy56vch26GG8o6dUtXoEcAdUqVf+nIc0tC+A==
X-Received: by 2002:a17:902:d4c3:b0:1bb:bc6d:457 with SMTP id o3-20020a170902d4c300b001bbbc6d0457mr3391924plg.36.1691694460449;
        Thu, 10 Aug 2023 12:07:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001bbbbda70ccsm2134447pls.158.2023.08.10.12.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:07:39 -0700 (PDT)
Date: Thu, 10 Aug 2023 12:07:39 -0700
From: Kees Cook <keescook@chromium.org>
To: Jan Engelhardt <jengelh@inai.de>
Cc: Justin Stitt <justinstitt@google.com>, Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hardening@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] netfilter: ipset: refactor deprecated strncpy
Message-ID: <202308101206.35C628E5@keescook>
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
 <20230809-net-netfilter-v2-1-5847d707ec0a@google.com>
 <20230809201926.GA3325@breakpoint.cc>
 <CAFhGd8oNsGEAmSYs4H3ppm1t2DrD8Br5wwg+VuNtwfoOA_-64A@mail.gmail.com>
 <q49499n7-54p3-1soo-8s83-7p84724o08p7@vanv.qr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q49499n7-54p3-1soo-8s83-7p84724o08p7@vanv.qr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 11:54:48PM +0200, Jan Engelhardt wrote:
> 
> On Wednesday 2023-08-09 23:40, Justin Stitt wrote:
> >On Wed, Aug 9, 2023 at 1:19 PM Florian Westphal <fw@strlen.de> wrote:
> >>
> >> Justin Stitt <justinstitt@google.com> wrote:
> >> > Use `strscpy_pad` instead of `strncpy`.
> >>
> >> I don't think that any of these need zero-padding.
> >It's a more consistent change with the rest of the series and I don't
> >believe it has much different behavior to `strncpy` (other than
> >NUL-termination) as that will continue to pad to `n` as well.
> >
> >Do you think the `_pad` for 1/7, 6/7 and 7/7 should be changed back to
> >`strscpy` in a v3? I really am shooting in the dark as it is quite
> >hard to tell whether or not a buffer is expected to be NUL-padded or
> >not.
> 
> I don't recall either NF userspace or kernelspace code doing memcmp
> with name-like fields, so padding should not be strictly needed.

My only concern with padding is just to make sure any buffers copied to
userspace have been zeroed. I would need to take a close look at how
buffers are passed around here to know for sure...

-- 
Kees Cook

