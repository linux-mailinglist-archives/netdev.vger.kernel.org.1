Return-Path: <netdev+bounces-39288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8E97BEB0E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 21:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8622281D50
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091993D3A3;
	Mon,  9 Oct 2023 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="czmv9n1G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5D3D393
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 19:57:52 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E6FA3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 12:57:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf55a81eeaso32598265ad.0
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881471; x=1697486271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AAXof7FSKNUwACX7I0wsnPLfS1CDeCy30JndA2SE6NU=;
        b=czmv9n1GLsaQ19PlZ+qFzaAbhFT+G+txoq/6w5hydn8JinbUxvlIY5uj9WRoKk3Uft
         Jpzm2TQXJiTolWb3h8bJeizL6EEcTwepkWYp3PNMM9xpKesLz/I4K/wob5NJ4bVvu/Y4
         YTMj+4Qo7+jlnBfBNbhCsKCmuZGDzYbzyEn9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881471; x=1697486271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAXof7FSKNUwACX7I0wsnPLfS1CDeCy30JndA2SE6NU=;
        b=nmWPjXm8Qo9yvhSkD4r2o2lMP+nTpwn1Yi0j+3WYXGE/94JYuQVyPkWOi5YX0KYH4k
         ckUtz5sYW7HETAsl5lDxB9goFj94Q+khyyx4dy3/RHslVNTuIMRuK5If3tKoEpD9fK0f
         KwfHdSQssMBWTeSXwGAI3V6hDg0u+jsPKl6eLZHrE1DhGVFrhz6BM9b7WBLr3B8uaiIR
         GpCqXL45JNsmWdPJM8zwJLXusJ5Eib/35hssE4+dVJdNcILe9u91kt8xuU9I2fB8ZAzT
         9SSmz8Lsc3nvWKcozldNtOOVj79EVwHsvDMsgGnGKVfnRswcMj9N3Ec5xEzHyrFzPc7/
         nQnA==
X-Gm-Message-State: AOJu0YwD+VLBUIP2Nu+ideC1dVptrJ+TPWbtgzoRxjws0LBhX0wJxqUF
	TWv0YM8vmhICOeCler8vRtZCKQ==
X-Google-Smtp-Source: AGHT+IHBxbNlFq//FMZhXa79FOEGkTypYLniPMeh5CBJUalrZdiallsp7s6tfFYhROrYjIiTGBaenQ==
X-Received: by 2002:a17:902:e5cf:b0:1c6:349e:fa43 with SMTP id u15-20020a170902e5cf00b001c6349efa43mr17313830plf.67.1696881470833;
        Mon, 09 Oct 2023 12:57:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902768a00b001c631236505sm10002666pll.228.2023.10.09.12.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:57:50 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:57:49 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mac80211: Add __counted_by for struct
 ieee802_11_elems and use struct_size()
Message-ID: <202310091257.6613605D5@keescook>
References: <ZSQ/jcmTAf/PKHg/@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSQ/jcmTAf/PKHg/@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 11:59:41AM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure including, of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks correct: "scratch" isn't accessed before setting "scratch_len".

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook

