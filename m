Return-Path: <netdev+bounces-34163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AEF7A2682
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EBE282057
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE031773F;
	Fri, 15 Sep 2023 18:47:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE6362
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:47:36 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDF42D62
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 11:44:44 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c4194f7635so13687975ad.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694803482; x=1695408282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Itsw2lvjOF4d1lcaGatZ2lrxzNTInyFHU12iNAuhsa0=;
        b=UcohAoQAIsWWDIgI7BS4TdftP8BkbFCWvYnlnqDpaUUXHCH9eMK8yVInnUisQPL/nW
         A7oQQCsvjwu+RLSIEUvthKcMWY8iucOrVF5JVTBqvllmUOvFSIvU9CIqvhLQylqUJaqx
         Yp9nPC5lhePXZuKibzmoFKXut+dIY8LbYzvMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803482; x=1695408282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Itsw2lvjOF4d1lcaGatZ2lrxzNTInyFHU12iNAuhsa0=;
        b=qhl9PhGEFYtgqEqgORTLjmI5gLGDVNvBujGN6WhjS30EAQDfWNhMGcPPCeoxsiT9Nu
         6buFqJLXOPxAIxpMxj9gjIQBtmYuxvJS0nwcwWUSxwJOZaAiFtXhD8cvqpG5SVsFhTSF
         Tmd+x9lHtoBC9I++z5UiyuXZ3el7PE5BeaoyoQOuST/ThMYUAtsNnN3jeZAaS0kddm2/
         BTvsnVRNTKzIQdgbehrj0n9EYFcibQbkLa0qQUlG/4qDfJjlmoLt3wNCQjg7Jsckxvt4
         zc+oKXX/DiTN+HBugdh0GhMd2kNSQcfOJ1yMb2V+ubkBGt3Fc+yOdxfFvgxE1lyNsP96
         f+fg==
X-Gm-Message-State: AOJu0Yw7Q/IDqQrr1iqnTlZLnMjxxBGur7XHusxWCuxuFy+iTeavj19D
	stNX0PjLCpTXJSaFWWnUgkv/ig==
X-Google-Smtp-Source: AGHT+IGM/U9TMc9dhOkJaD9Q2LSMeEhEmfp04Mj+FcHBxuLYmJmp+99UA23YpkT+qqmkIf+jiqtkCQ==
X-Received: by 2002:a17:902:c213:b0:1c3:b0c7:38bf with SMTP id 19-20020a170902c21300b001c3b0c738bfmr6342438pll.12.1694803481936;
        Fri, 15 Sep 2023 11:44:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001bb9aadfb04sm3771453plr.220.2023.09.15.11.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:44:41 -0700 (PDT)
Date: Fri, 15 Sep 2023 11:44:40 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] gve: Use size_add() in call to struct_size()
Message-ID: <202309151144.E420B9F8@keescook>
References: <ZQSfze9HgfLDkFPV@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSfze9HgfLDkFPV@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 12:17:49PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, `tx_stats_num + rx_stats_num` wraps around, the
> protection that struct_size() adds against potential integer overflows
> is defeated. Fix this by hardening call to struct_size() with size_add().
> 
> Fixes: 691f4077d560 ("gve: Replace zero-length array with flexible-array member")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, yes, this will maintain SIZE_MAX saturation if it happens.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

