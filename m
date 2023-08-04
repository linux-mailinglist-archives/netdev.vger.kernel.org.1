Return-Path: <netdev+bounces-24313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D92776FC0C
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C6B28253C
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 08:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991AB9445;
	Fri,  4 Aug 2023 08:30:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A2CA56
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:30:37 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED89846A3
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 01:30:10 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bc93523162so1567678a34.2
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691137810; x=1691742610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTW4GcsIoC0wedeu0cP1p/SdzNq7SXqwMejU+XlRg/A=;
        b=GzQT2IqnS0O9DsPcor7DwEmC2sqiMDOSQPI4yqQEhlltfGaGer/VaRPL79vkoGC3nq
         OI2mf4uB95BiiebH88szvpfhhb4hvT2F+ko6eNeOK9/E9F2QgOGqU3hBbUOJg+LFzTmB
         vd+4ynvEAgfFtLVfaLBUybVzDa6hZBiOuW8u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137810; x=1691742610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTW4GcsIoC0wedeu0cP1p/SdzNq7SXqwMejU+XlRg/A=;
        b=abpi4Bjbp4D/jAvjYfWUox1av30umVRYYet8n1HD2HIQ8UrX/28qV7EDEYTQauMj2e
         n/mFizFEcKkHLhbNJE6Rip9fESo3dUHXvV2iezDMVD5ScmINLE4uyvPTi+R4higirliJ
         rP6JL+wtxiK845KDdGvtMm9zhtzrsWSwYCBcs41wm/3D32/77kkH8S2biU8GKSg9EZSk
         pxLzilEby56uChozkE5Aimk/8twmy1Kn59kLVLhYyNKm4AGFW78D6v4A5MO+Xt/Iaq63
         EzOYBfYo2Ple0uj4P8LV12srwjIw/A4eF13Fvl+odEX+yS7xy+pSy3MFCOVsMkbBrcCk
         MVSQ==
X-Gm-Message-State: AOJu0Yy+0Xc8SOLrl15he3l8LVeCdppBVsq5e6mY5X8ueDTv92pEo6Zk
	A5WvAGcIVELBucmi/CehdZarxg==
X-Google-Smtp-Source: AGHT+IHh6wCyuLACZdpvHgsdR8UkOmQsmagdun+zvBpnhfZpwlQcNCElW7X7S0H00eHM1MYxpZV3NA==
X-Received: by 2002:a9d:67d6:0:b0:6b9:68fb:5a28 with SMTP id c22-20020a9d67d6000000b006b968fb5a28mr931396otn.27.1691137810270;
        Fri, 04 Aug 2023 01:30:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090a4b4e00b00268b439a0cbsm1057998pjl.23.2023.08.04.01.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:30:09 -0700 (PDT)
Date: Fri, 4 Aug 2023 01:30:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] virtchnl: fix fake 1-elem arrays for
 structures allocated as `nents`
Message-ID: <202308040130.E48094967E@keescook>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-4-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728155207.10042-4-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 05:52:07PM +0200, Alexander Lobakin wrote:
> Finally, fix 3 structures which are allocated technically correctly,
> i.e. the calculated size equals to the one that struct_size() would
> return, except for sizeof(). For &virtchnl_vlan_filter_list_v2, use
> the same approach when there are no enough space as taken previously
> for &virtchnl_vlan_filter_list, i.e. let the maximum size be calculated
> automatically instead of trying to guestimate it using maths.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

