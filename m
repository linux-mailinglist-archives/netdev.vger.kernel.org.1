Return-Path: <netdev+bounces-34182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894037A274E
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F71C209B7
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25941A73C;
	Fri, 15 Sep 2023 19:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A336D19BDC
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 19:43:08 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A84A1FD0
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:43:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2749b003363so784261a91.2
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694806985; x=1695411785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYJud1t9lPyuPjtdwBUAsD3BvXWOOoP+siQ8uzoHdDU=;
        b=lv1AMfeEfiHIn4vWjkJMk6a+yMVmMhhtfeZJjM3put5fvaifKq7g2lhVGwER0Daw93
         ynoj6O+ATUqllHBeZro2u7NTsIzpaJVLN41BpjOzxK86MFYu8nPdhlfnc4Wpprd8egsv
         I1F+LPgHMza92k1ilz+o8T0LlusPuOj0FSAFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694806985; x=1695411785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYJud1t9lPyuPjtdwBUAsD3BvXWOOoP+siQ8uzoHdDU=;
        b=A9Y61o6/WT3ZNZYq6GE5KwtPwyHYFbitTamnticaWGm9X5eDlEwUW5bvdWRLDC7JMc
         7rn8GhAIHOIOOeX/ZCxEgro11bsLdRF7J3ndVGocVTiveba2/0BcJ4KI8yJ/XCVloZZQ
         f6aVBBqnFgDZ0iuo1dSoXG/OWPJkepYU9XKwDxb/bg6+61iU79a3tb2PbdNonEXXYn3U
         bik88spP/gr31KsPd4z+7KmwGEltJynkO2i5Di/YSWBeKU7XA9tXRnxidemjvnOV+UiS
         YghqaoMV8jCsZAzJruUcYjhh8XZwg6/7Mon760912/m5PK5MIJyBRPNaULgIDqExMess
         wNJw==
X-Gm-Message-State: AOJu0YzOK4BRD8t/WcZpngUk2bzEXYXDEuWW6voNseZ64DHfivCWdc8n
	mwmICy+3WMGmV+gqFuK5pfNk9w==
X-Google-Smtp-Source: AGHT+IFeG9K8dCFdWE7JO8su8gomrvm80dps740wxaqk3Qc6GiQQ8BQQx0l1yX49avLzT86ttQjnhw==
X-Received: by 2002:a17:90b:38ce:b0:274:96a:5007 with SMTP id nn14-20020a17090b38ce00b00274096a5007mr2503313pjb.1.1694806985660;
        Fri, 15 Sep 2023 12:43:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ft7-20020a17090b0f8700b0026309d57724sm5200947pjb.39.2023.09.15.12.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:43:05 -0700 (PDT)
Date: Fri, 15 Sep 2023 12:43:04 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tipc: Use size_add() in calls to struct_size()
Message-ID: <202309151243.647E424@keescook>
References: <ZQStiorAZPgfMMZD@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQStiorAZPgfMMZD@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 01:16:26PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: e034c6d23bc4 ("tipc: Use struct_size() helper")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

