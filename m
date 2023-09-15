Return-Path: <netdev+bounces-34180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C04A67A274B
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80361C2094C
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E7B19BDE;
	Fri, 15 Sep 2023 19:42:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6688219BBD
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 19:42:17 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1461BF2
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:42:15 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68fbb10dec7so2328100b3a.3
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694806935; x=1695411735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFE1F3+kydQTQojTUb7prmfEOCJq3WLONO+sPWEJMCo=;
        b=h38ZcxOqWwCMHk2cL65uE60F0C0YUQdFXGSjn5YM4z/sbkkqRAKpN7N8C0XpegO6cw
         c2UagfzmMXtWz3MuMZ9O3TEYaEWJfvjaI6qniL9tuqrfhXZampXd7WTX72bjb4h1LLPI
         1u4LWhkpW4LmoBf7pprnlw6+1Zq1wWhGXTfeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694806935; x=1695411735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFE1F3+kydQTQojTUb7prmfEOCJq3WLONO+sPWEJMCo=;
        b=WmZDwNYm2CNDLMPTWXN3lnwWsr3AY5pYmdGPvXFo7jJ+wcsHSID0A6EcUcFUs+BuIC
         NT6s6G5xdNCnVlft4nRoLrVwtv3VaJ/4XFRBWblSN6gbLjm8fOTMy54KgZ2eg1qm1tSJ
         J1oalPv9Fv+hl2S0F1uD0wPwLEDsY3x5jdZ55JoHqkB5qQMVdHvwkgz78LYuO0kWvwrl
         nyRAu0OVLEK1/MrkuwQ9gm8jEO6vz1sJlJ7jYmd2yP+hfdcy8Eh/aQEBFU/TXffN/bQe
         jO+lawmSHIo+JyTwasa22KdYvH7T7uxXvEOibpMoL9H37dyce86zlvOXG5vsP+ieV75/
         p5ug==
X-Gm-Message-State: AOJu0Yy4Ta3dz0IcrUlOTveoyB14rsQ2N6csCgn2ljhsjnxXUSvTVad9
	GaZbZX/h+Se9fRjjkhMyzZ9SgA==
X-Google-Smtp-Source: AGHT+IGpdxeoMFg927wqPjDXncgi6Ri3SO4sv6EPXygbD0EnqTl0JEaVe8KWeIG5/O1y9sFbXRwVKA==
X-Received: by 2002:a05:6a21:7189:b0:153:39d9:56fe with SMTP id wq9-20020a056a21718900b0015339d956femr2593392pzb.47.1694806934963;
        Fri, 15 Sep 2023 12:42:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m22-20020aa78a16000000b0068fba0f5f32sm3417615pfa.90.2023.09.15.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:42:14 -0700 (PDT)
Date: Fri, 15 Sep 2023 12:42:13 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] mlxsw: Use size_mul() in call to struct_size()
Message-ID: <202309151242.E732735FA@keescook>
References: <ZQSqA80YyLQsnd1L@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSqA80YyLQsnd1L@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 01:01:23PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound, the
> protection that `struct_size()` adds against potential integer overflows
> is defeated. Fix this by hardening call to `struct_size()` with `size_mul()`.
> 
> Fixes: 2285ec872d9d ("mlxsw: spectrum_acl_bloom_filter: use struct_size() in kzalloc()")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

