Return-Path: <netdev+bounces-21675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D20227642EC
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 02:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941B4282019
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 00:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AB17EA;
	Thu, 27 Jul 2023 00:24:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC319C
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:24:17 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790D7E73
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 17:24:16 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76af2cb7404so33778685a.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 17:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690417455; x=1691022255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=51TmouK3bQfcqf7zaNKCd8MK7cCyJry2iObUP3bhEHw=;
        b=DccICbdEIa2wnCVWIBRU2/Mo1iCa2JZQ/5JsPGF49XmuicqrP3cORW9krtbhIX415l
         9J4H7IRv9bUbJfHrQLzKr95BHNlhjutJxADDiBjy45Fvh0gvMB8TWbLMhszjsOVt8Uaa
         66wR0tLanO2w0wSxy0h2cYeZYBp+8ca9idrx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690417455; x=1691022255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51TmouK3bQfcqf7zaNKCd8MK7cCyJry2iObUP3bhEHw=;
        b=BwPxetfD353ubrkSdYoMk0YWAAraNRraInJq8H8ldHd5KAqyYMEGYpssxsKVjbv12p
         jDcAIyG0aMdsLhgGpvUmmi4YHiXLVhQGuDUT2kT4HUEo7sRaSBLz2nndnE2az0GN7YIq
         5c3I2XN+aTOdODBhGPKuRng8g0E+EF5mYSIEtupwUmttVVxZk0ZUcsHLjcpJc5OGVHxR
         FFkBdaORnWK8t1kBQQdloVqI7GqVFHdBqr+PEsimjpWuxl7jZZV9N673PexEW3x6lLZJ
         /Z2Thx9tEbg/3C052NTo3u6JfdSJkI31aq2aCXLqUsGE03UeOd0h7Tka780WfI30W6bn
         nMLA==
X-Gm-Message-State: ABy/qLbwf+rlbOYO8zdtkBQ9hvAMLEKkdADk1aFgKZBJwGPewLYEk7C1
	wYklwWZKhGpwBb/uBbvPxYlGuBIlM9Wewx47/M4=
X-Google-Smtp-Source: APBJJlFPrVeNK+Esuyd1CMyM2UVHXHOda0pZ6g4OHeYqaPavDA42Fy8/kwdMdFZW76JN+dfkYqf/bQ==
X-Received: by 2002:a05:620a:44c3:b0:75b:23a1:832f with SMTP id y3-20020a05620a44c300b0075b23a1832fmr5009797qkp.42.1690417455662;
        Wed, 26 Jul 2023 17:24:15 -0700 (PDT)
Received: from meerkat.local ([142.113.79.114])
        by smtp.gmail.com with ESMTPSA id o12-20020a05620a15cc00b0076af430d902sm29638qkm.63.2023.07.26.17.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 17:24:15 -0700 (PDT)
Date: Wed, 26 Jul 2023 20:24:06 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Joe Perches <joe@perches.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	workflows@vger.kernel.org, mario.limonciello@amd.com
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from using
 file paths
Message-ID: <20230726-armless-ungodly-a3242f@meerkat>
References: <CAHk-=wiuR7_A=PbN8jhmqGPJQHypUHR+W4-UuSVhOVWvYXs1Tg@mail.gmail.com>
 <CAHk-=wh4pbrNZGqfV9u1urZr3Xjci=UV-MP+KneB6a5yo7-VOQ@mail.gmail.com>
 <CAHk-=whCE9cWmTXu54WFQ7x-aH8n=dhCux2h49=pYN=14ybkxg@mail.gmail.com>
 <20230726130318.099f96fc@kernel.org>
 <CAHk-=wjfC4tFnOC0Lk_GcU4buf+X-Jv965pWg+kMRkDb6hX6mw@mail.gmail.com>
 <20230726133648.54277d76@kernel.org>
 <CAHk-=whZHcergYrraQGgazmOGMbuPsDfRMBXjFLo1aEQPqH2xQ@mail.gmail.com>
 <20230726145721.52a20cb7@kernel.org>
 <20230726-june-mocha-ad6809@meerkat>
 <20230726171123.0d573f7c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230726171123.0d573f7c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 05:11:23PM -0700, Jakub Kicinski wrote:
> Hm, hm. I wasn't thrilled by the idea of sending people a notification
> that "you weren't CCed on this patch, here's a link". But depending on
> your definition of "hitting the feed" it sounds like we may be able to
> insert the CC into the actual email before it hits lore? That'd be
> very cool! At least for the lists already migrated from vger to korg?

No, inserting their addresses into message headers would invalidate DKIM,
which is not what we want to do. However, the idea is that they would receive
the actual patches in the same way they would receive them if they were
subscribed to a mailing list.

Think as if instead of being Cc'd on patches, they got Bcc'd on them.

-K

