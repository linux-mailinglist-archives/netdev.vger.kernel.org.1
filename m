Return-Path: <netdev+bounces-21679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D542A7642FC
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 02:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C911C214BA
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 00:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A9810EA;
	Thu, 27 Jul 2023 00:33:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FA7C
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:33:33 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31AA26A6
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 17:33:26 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63ce8bea776so2868826d6.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 17:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690418006; x=1691022806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RbFtBP3s5EoZN2IL1k6gw8UtCCG0lN7bHzqRjLPLmmw=;
        b=ZUcAn/OQFw6SUFcrZQR46N2yGO1FB+emshuk+KqIsV4o4Q5GS+/0sg84LgrrmsRirv
         AU6xdjLA+uXvV/bB7qmSyLg9pyRvCIj9BPPVvyW1jbBkYCWEppBPZBBsFGmZ9tg2j7nn
         e1FkTW+P6EYtyy06W8NCcJ4tLXC/LoYXU7DFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690418006; x=1691022806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbFtBP3s5EoZN2IL1k6gw8UtCCG0lN7bHzqRjLPLmmw=;
        b=DGc0Faz6gPHKIRP0qK2GablRQf130vWuBK4WN7w+hB8T1tpzcWGd+R4kxvb8EjqI9Z
         JgHa3Yc29/aQ01CymsvqVFsS8cYX19ukgTKvZTRkzxuB6izfcvXfBU7KjvuskDfnKnwe
         k271/FcJ61j80iXlheOe1d7LGB1q2iPnaMxp0yqDkqRxTiyqXI26Ed7znRLhR9aC3tie
         Ct8Fs4HkA4sCu1gQQPfMBf03aTVoA/N57mQ+STY+ieJRFP34TddJ3XUBYjNg7uTp7+KF
         qj8oKwxaXP+U+z9gRyqmthisUmxwCT8aStS2kIDlr1ZLEFp8UHw8bQGqGIftDkP4PTNN
         zgWg==
X-Gm-Message-State: ABy/qLaH6TaVkDcXafaz84f5yDuU3e0laLcZx2Ev6UH1iH07aA0NrgPE
	4DTr1GGUG8u251f/iIHv3l9vZg==
X-Google-Smtp-Source: APBJJlHRPzEVl93oZVeOEl8p0u79e9fcH4T7R5h+Gb8P21nnFewM9G5Q1FtXVJUQsQCQYRbnZghTsA==
X-Received: by 2002:a0c:b2c2:0:b0:63d:c37:bf86 with SMTP id d2-20020a0cb2c2000000b0063d0c37bf86mr3683119qvf.41.1690418005785;
        Wed, 26 Jul 2023 17:33:25 -0700 (PDT)
Received: from meerkat.local ([142.113.79.114])
        by smtp.gmail.com with ESMTPSA id b20-20020a0cb3d4000000b00626286e41ccsm31892qvf.77.2023.07.26.17.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 17:33:25 -0700 (PDT)
Date: Wed, 26 Jul 2023 20:33:16 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Joe Perches <joe@perches.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	workflows@vger.kernel.org, mario.limonciello@amd.com
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from using
 file paths
Message-ID: <20230726-yeah-acrobat-ba1acf@meerkat>
References: <CAHk-=whCE9cWmTXu54WFQ7x-aH8n=dhCux2h49=pYN=14ybkxg@mail.gmail.com>
 <20230726130318.099f96fc@kernel.org>
 <CAHk-=wjfC4tFnOC0Lk_GcU4buf+X-Jv965pWg+kMRkDb6hX6mw@mail.gmail.com>
 <20230726133648.54277d76@kernel.org>
 <CAHk-=whZHcergYrraQGgazmOGMbuPsDfRMBXjFLo1aEQPqH2xQ@mail.gmail.com>
 <20230726145721.52a20cb7@kernel.org>
 <20230726-june-mocha-ad6809@meerkat>
 <20230726171123.0d573f7c@kernel.org>
 <20230726-armless-ungodly-a3242f@meerkat>
 <20230726172758.3f6462f3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230726172758.3f6462f3@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 05:27:58PM -0700, Jakub Kicinski wrote:
> > Think as if instead of being Cc'd on patches, they got Bcc'd on them.
> 
> I was being crafty 'cause if the CC is present in the lore archive
> our patchwork check would see it :] 
> But cant just trust the automation and kill the check, then.

If we can get it working reliably and to everyone's satisfaction, then I think
the need for this check goes away. The submitter can then just worry about
getting *everything else* right about the patch and not worry about who to add
into Cc's.

-K

