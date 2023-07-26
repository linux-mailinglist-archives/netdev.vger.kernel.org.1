Return-Path: <netdev+bounces-21655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE447641FC
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 00:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0547F281FA0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 22:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B6E198A6;
	Wed, 26 Jul 2023 22:15:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48361BF04
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 22:15:51 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A328271B
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:15:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686b9964ae2so278812b3a.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690409746; x=1691014546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLyeTFzE0gyDfYXR8/T5lelqrb0De+AR32Cnc4/cZdk=;
        b=hcAe2S9mFQizupyH9XxdPIPh2rjifa5bWJKj/WVUjaF710r4smRwNBOfw683gjDpbl
         NTPBJs7yQcDMHiAXUsBzufObSI1N3htTYcIDnaN9Rg0xXijofrsRf+pckWEebV44ALLv
         xYr4JypuOe7Yz1Qv3qgzxYP/pQSJ501uwMl08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690409746; x=1691014546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLyeTFzE0gyDfYXR8/T5lelqrb0De+AR32Cnc4/cZdk=;
        b=laBqn5l9DP9Kn1PqBgfIvf8NzLXmw+I37eCSDA82VHEKP/SjF9E/xCUrKQm5ZjE4He
         W/KPm52b471wJpf2M/Mt4XTX8uOSezkif2UKlkhzHsEbV1j5ZOOfgTXcaK8Fnr46B0vz
         7O40LtAm0xwuuO8pBQVeiiRyyf8mGnVavvANcuMX2D581Aa8C2j7s/jnRWsBBHFEcLyy
         GXMxyAKSfgK5qs5YWO2gjVgWG4MqYWJA2FKUIh6ShdojU2YvQD74gJ3Ru3s+4CZRdvW8
         jwr8XIQn1GKWVDwOOh1ZPnSIR4WKTvTONBycaJkc/LAIBtdTxXKBbs15+bL3dco2F5YY
         kSUQ==
X-Gm-Message-State: ABy/qLYRnxKqxbj4puRclf7GR2aRobE2wWGlE+eMFLdsRW5qFe28QxV1
	Cv1xFQz1WjTQelMXDAWo40JhObQrALDGVwWmO9s=
X-Google-Smtp-Source: APBJJlHj0+goSCaCBXGhnJOvvQ61jfiYfsSGlDCUlpRIeUuFvGzJxPnN3wK0Qd5Z7sS48Q0JSomIBw==
X-Received: by 2002:a05:6a00:1592:b0:686:24b0:5542 with SMTP id u18-20020a056a00159200b0068624b05542mr4088307pfk.11.1690409746709;
        Wed, 26 Jul 2023 15:15:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 8-20020aa79148000000b00686edbc3d90sm86264pfi.127.2023.07.26.15.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 15:15:46 -0700 (PDT)
Date: Wed, 26 Jul 2023 15:15:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v1 net] af_unix: Terminate sun_path when bind()ing
 pathname socket.
Message-ID: <202307261514.BB2AB4E3@keescook>
References: <20230726190828.47874-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726190828.47874-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 12:08:28PM -0700, Kuniyuki Iwashima wrote:
> kernel test robot reported slab-out-of-bounds access in strlen(). [0]
> 
> Commit 06d4c8a80836 ("af_unix: Fix fortify_panic() in unix_bind_bsd().")
> removed unix_mkname_bsd() call in unix_bind_bsd().
> 
> If sunaddr->sun_path is not terminated by user and we don't enable
> CONFIG_INIT_STACK_ALL_ZERO=y, strlen() will do the out-of-bounds access
> during file creation.
> 
> Let's go back to strlen()-with-sockaddr_storage way and pack all 108
> trickiness into unix_mkname_bsd() with bold comments.
> 

Okay, this does at least collapse all the scary casting into a single
function. :) Thanks for navigating this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

