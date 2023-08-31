Return-Path: <netdev+bounces-31640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC87B78F331
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 21:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DC11C20B05
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 19:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FE019BB4;
	Thu, 31 Aug 2023 19:18:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5814A93
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 19:18:32 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BCDE65
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 12:18:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso9482415ad.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693509511; x=1694114311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GsqiH/F0uiLsgZIOirUAxv8nRkz7x6zqX7vHcWml97w=;
        b=c6Z1i7tbOl0pBGpw7EAB3G5WmSTikIg6ZqDWf/YIHaVKo8BRqj0K5M9bGo7GnBZPOZ
         F8hQGw+1tQPmhlJmajGIqg6VgSIKa3s+ETXKfrP87Fj8GaWmkQ7p/UzIQmNZEjXreHU7
         Dsly0nsqDp1M66pziR+EQCiwhCU7kVP6CBz54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693509511; x=1694114311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsqiH/F0uiLsgZIOirUAxv8nRkz7x6zqX7vHcWml97w=;
        b=fIoHXL5jeIegIdxa6ahcjKt/TA9okdx4Eb7zUcVBXNUxtQhpXUNx4BLIRFsDruD2f4
         g4Q+oWPRg/Oz9dWuk+5gJ9FdMNQ14IakMQTjEH+2oG7fRLcZddr5iTFx5qgGBH8ZCPRY
         IL3fHfynOLBzpZ7tFs/kJFy/SPX637GFzGUDwJAk3d6mInUG+A4fSx3U84B/EGaJIZcj
         Sf7rblgBhWJBdmmBCao7Y6iI3anLk8b2xe/VgF95O7NuSbiwmCxIxd+rPcK46F6JVznv
         WrgeoCHYql4+eJnKzTyP9dhXvFb5UT0BqHg6Ag2mDclEHDned9KHXLJR3a2W4H49sKTK
         jEyQ==
X-Gm-Message-State: AOJu0Yz5MHmjB+dZvnPJyoNSMgp++0PPtoE40+G9lChS1neJiEoqzHMp
	L5s1NMeYhj2J+szB8LMjBx98bQ==
X-Google-Smtp-Source: AGHT+IHAB09QJKFbJyJ6Mj/J8+vjv8IjfbkJCAe02z4bfIN2Qk8IUL2743Wr0Yrhw/3xqxR3apNxNg==
X-Received: by 2002:a17:903:26d4:b0:1c0:aa04:dc2f with SMTP id jg20-20020a17090326d400b001c0aa04dc2fmr632850plb.11.1693509510884;
        Thu, 31 Aug 2023 12:18:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jf13-20020a170903268d00b001b8b07bc600sm1573727plb.186.2023.08.31.12.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 12:18:30 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:18:29 -0700
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: kernel@quicinc.com, Kalle Valo <kvalo@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Christian Lamparter <chunkeey@googlemail.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Helmut Schaa <helmut.schaa@googlemail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mac80211: Use flexible array in struct
 ieee80211_tim_ie
Message-ID: <202308311218.D82D90A@keescook>
References: <20230831-ieee80211_tim_ie-v3-0-e10ff584ab5d@quicinc.com>
 <20230831-ieee80211_tim_ie-v3-2-e10ff584ab5d@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831-ieee80211_tim_ie-v3-2-e10ff584ab5d@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 11:22:58AM -0700, Jeff Johnson wrote:
> Currently struct ieee80211_tim_ie defines:
> 	u8 virtual_map[1];
> 
> Per the guidance in [1] change this to be a flexible array.
> 
> Per the discussion in [2] wrap the virtual_map in a union with a u8
> item in order to preserve the existing expectation that the
> virtual_map must contain at least one octet (at least when used in a
> non-S1G PPDU). This means that no driver changes are required.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> [2] https://lore.kernel.org/linux-wireless/202308301529.AC90A9EF98@keescook/
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Looks good to me! Thanks for the conversion. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

