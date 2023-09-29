Return-Path: <netdev+bounces-37112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 066E87B3AC7
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 21:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9F024282980
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 19:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9599066DDB;
	Fri, 29 Sep 2023 19:44:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283466DC9
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 19:44:50 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2CA1B2
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 12:44:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf6ea270b2so112859245ad.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696016686; x=1696621486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hlEYv1vw7tFZx186oanN6aqA/SqIi0t9DwwVB+F0Pag=;
        b=Nym0926fJeljW9l5bR36Bkz/wUSYrRxR9PKkG16zMVjYrd+4WCAz5McWTSVQEGHYrx
         tZKOO1cfhRuFtm1zS5kioBYp7KDU/2PVXtw5xZOGi1oBz2ZWsf+nacRCjYrz1nwy+SjZ
         /sfipZ2exAiNnpyi0WrekAb1dJOySJeXtRWj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696016686; x=1696621486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlEYv1vw7tFZx186oanN6aqA/SqIi0t9DwwVB+F0Pag=;
        b=SaPTu7AHjfuNJU3N0060tUN0DAzi3kUx+kwoOdFTt2hNrer+tqnChwBhlSFhmsY8E4
         2KmlzwNliQDJ5bg4PRw55fL9L+rnIwkKbvUkh7Fah9k6ugDLtKbWTFtf5QbA9RlerdAW
         elvwsKH3RkuVgEyBagWuv5OXOJ5wnpBJyT/aFpwppveeZ+z8Caj7PurxET5a0mnow2tg
         zuInW+9lp1/go0juYEJ3vVOtNZxw6YQgI2jAl5BVfSQoDjJ521+rDwUGGX0Ry5Xr4Ixn
         C73I/fD/qHaqe7tSTVwu6UhJdYEaWNxb2wOp5hcQ/RSKaGGvszFh/kQSR7LEwt9h0B47
         HBRw==
X-Gm-Message-State: AOJu0YwJv2sMLeEqBW4f3/RKK7/4j97SfKfLQOKLuXfmTIXilDiLex8f
	TAXulQvw6vM0FU9IgmxFHrRyGw==
X-Google-Smtp-Source: AGHT+IGL79pSePNuMtT3+0fzT8gZiV8QT6CLoLAdCUDg08JxvU3zZSWKZBPddJhFLKS7s3gB9vi34g==
X-Received: by 2002:a17:902:9a44:b0:1c5:cfd6:9e82 with SMTP id x4-20020a1709029a4400b001c5cfd69e82mr4213045plv.18.1696016686313;
        Fri, 29 Sep 2023 12:44:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902ed0d00b001c72d694ea5sm4690423pld.303.2023.09.29.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:44:45 -0700 (PDT)
Date: Fri, 29 Sep 2023 12:44:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/5] chelsio: Annotate structs with __counted_by
Message-ID: <202309291240.BC52203CB@keescook>
References: <20230929181042.work.990-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929181042.work.990-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 11:11:44AM -0700, Kees Cook wrote:
> Hi,
> 
> This annotates several chelsio structures with the coming __counted_by
> attribute for bounds checking of flexible arrays at run-time. For more details,
> see commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").
> 
> Thanks!
> 
> -Kees
> 
> Kees Cook (5):
>   chelsio/l2t: Annotate struct l2t_data with __counted_by
>   cxgb4: Annotate struct clip_tbl with __counted_by
>   cxgb4: Annotate struct cxgb4_tc_u32_table with __counted_by
>   cxgb4: Annotate struct sched_table with __counted_by
>   cxgb4: Annotate struct smt_data with __counted_by
> 
>  drivers/net/ethernet/chelsio/cxgb3/l2t.h                | 2 +-
>  drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h           | 2 +-
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h | 2 +-
>  drivers/net/ethernet/chelsio/cxgb4/l2t.c                | 2 +-
>  drivers/net/ethernet/chelsio/cxgb4/sched.h              | 2 +-
>  drivers/net/ethernet/chelsio/cxgb4/smt.h                | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Hm, it looks like this is not "Supported" any more? I'm getting bounces
from "Raju Rangoju <rajur@chelsio.com>" ...

CXGB4 ETHERNET DRIVER (CXGB4)
M:      Raju Rangoju <rajur@chelsio.com>
L:      netdev@vger.kernel.org
S:      Supported
W:      http://www.chelsio.com
F:      drivers/net/ethernet/chelsio/cxgb4/

-Kees

-- 
Kees Cook

