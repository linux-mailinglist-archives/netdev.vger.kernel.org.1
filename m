Return-Path: <netdev+bounces-34181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189D67A274C
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70E1281736
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1F519BDE;
	Fri, 15 Sep 2023 19:42:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9ED1B261
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 19:42:40 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A631FC9
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:42:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf1935f6c2so18597055ad.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694806958; x=1695411758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIj8OzGJrhv2lGM2biZWis6A17RAWnGoSZFCbIwFvuM=;
        b=WaD0aTyDH/uutpVV8adNXlYXUhfqEf+U/H86LF52FutN6nw4UgSWcRY+/j7ENhjbgB
         VZKLGelUiNKYNJF8jZ9sfR2Apk6zSj4CWlFuxMeqBbV8lWkuyrkE1LAK8gEaaraW8g5a
         YitWmqcEfS43fv1RxMxGnBWFAoFAIYXmX+Do8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694806958; x=1695411758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIj8OzGJrhv2lGM2biZWis6A17RAWnGoSZFCbIwFvuM=;
        b=pcunT4whkRI6bu0TFrPKzy/mYRoQEFRtbOUkPQLD5iAV8yyYSQd0AMQ8QARHXIq25t
         yitNLg33c4mI8pMgg0PfopTLC8CGEy1PoiVg7fbJJBVIwi+IK9p5r9H5iM9VK7wdz+Y+
         ikFBi6WA/j4KrLTjCjBa/BstRVMfTHbkDHsPFf0o+0jEUkcgYX44kGhfaS4CGf/1/tdZ
         GsRJqJK00FHt+zFEyVsBa+HSy9AzqEsJaHu36alNBoQtgOi1IbCYf0zgjDSOe7xW2bR+
         dzUNhflRQOCYB/4a627XCtc9QJrclpAjtVT0Cgr2t5H8luTTDQqu1PouVxTbQxq3nH80
         YSDg==
X-Gm-Message-State: AOJu0YyeIF6xKO/VUo6DLOzf63xYW1H+u/N4TSnKpVFZdI4+JsGCcjNg
	NPW56WwvxTLsg4JAk5+lfCjtiQ==
X-Google-Smtp-Source: AGHT+IERfok0jFzZlZtdhSIeue7UAgumLdb8qFaPg7HdEwWvabfB1YwxclxmfbPVjycC8GbPAfm1aw==
X-Received: by 2002:a17:903:110e:b0:1b8:8682:62fb with SMTP id n14-20020a170903110e00b001b8868262fbmr7918269plh.4.1694806958504;
        Fri, 15 Sep 2023 12:42:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902bd9600b001bb9f104328sm3831900pls.146.2023.09.15.12.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:42:37 -0700 (PDT)
Date: Fri, 15 Sep 2023 12:42:37 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tls: Use size_add() in call to struct_size()
Message-ID: <202309151242.BC470261F@keescook>
References: <ZQSspmE8Ww8/UNkH@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSspmE8Ww8/UNkH@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 01:12:38PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: b89fec54fd61 ("tls: rx: wrap decrypt params in a struct")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

