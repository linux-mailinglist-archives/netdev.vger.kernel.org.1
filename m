Return-Path: <netdev+bounces-39763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233007C45C2
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 01:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525361C20CDD
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065213D99E;
	Tue, 10 Oct 2023 23:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XR6IMS+g"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE93D97C
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:59:16 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE40099
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:59:13 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5cd27b1acso49752985ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696982353; x=1697587153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VqSRijF5ocWf9llqvklQyW3Wi+0XOkmzW4XQNxfluyk=;
        b=XR6IMS+gkfiwKqtsxSJF4Vcm0HKo0Y6oo38lcIgD6XeQqt7Yj559bQOm9TZEFE5Bg1
         AkhxZYp2t44sJL9y0/NvxPko2qIXPffLLjRSA77ELSzQ4ZyWnRlf+7fXTqr398ieZ9PA
         vBqvf3Knf6mPaYByYrP3BkGXk0KJavVmQ6Q+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696982353; x=1697587153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqSRijF5ocWf9llqvklQyW3Wi+0XOkmzW4XQNxfluyk=;
        b=HbTaqqZQce0dBUntkfK1Un29eXyD9gYNe3ipi4q55cyi4iNHSBgON+ConRF5Fp4X1s
         n/+EWNSvnYY9N35sd1fo4j39+6ATGuawLUiVFfq42DJgBjtIaN0ZQgcnPU3AddB5WNIy
         Z8BJyl0kGi4DnQ0F1A8zoHcDZ+V8R6O2TDx3rOgirHir1KEp+4KwWgcpMbnBTcFbwv9G
         hQokMdp1YA34h02762Vq800Q0bldgvY3z5emrcFF4r0A7zC4wXRF72OgQ2zI78yp1ZIC
         x/HyKKPwaYSfNzQXaTbM5OR1p0QZ+rIRlZ5ydHX4SZktWtLryo0bjqpm3JUWJG+XwScH
         li7w==
X-Gm-Message-State: AOJu0YzdEL+2os8nGYuL4eMwRprwk7R4IxHgKVqhTc3FaxFgMXUrfv9c
	9BhsY+S/kVekR44z+Nplg4BdEbwoAIGbjRhwh40=
X-Google-Smtp-Source: AGHT+IHsBKEhM8Jb2S10+0UBKcAaUvwNQ94/ERbNOjqhOH8T4jx/rmPG2GZ2PApSYSOqP4sqNCXXdg==
X-Received: by 2002:a17:902:7d92:b0:1c6:943:baca with SMTP id a18-20020a1709027d9200b001c60943bacamr19039967plm.28.1696982353259;
        Tue, 10 Oct 2023 16:59:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ij15-20020a170902ab4f00b001c9c47d6cb9sm940689plb.99.2023.10.10.16.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:59:12 -0700 (PDT)
Date: Tue, 10 Oct 2023 16:59:10 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Marcin Wojtas <mw@semihalf.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: mvpp2: replace deprecated strncpy with strscpy
Message-ID: <202310101658.8D498F16F@keescook>
References: <20231010-strncpy-drivers-net-ethernet-marvell-mvpp2-mvpp2_main-c-v1-1-51be96ad0324@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-marvell-mvpp2-mvpp2_main-c-v1-1-51be96ad0324@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 09:24:42PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `irqname` to be NUL-terminated based on its use with
> of_irq_get_byname() -> of_property_match_string() wherein it is used
> with a format string and a `strcmp`:
> |       pr_debug("comparing %s with %s\n", string, p);
> |       if (strcmp(string, p) == 0)
> |               return i; /* Found it; return index */
> 
> NUL-padding is not required as is evident by other assignments to
> `irqname` which do not NUL-pad:
> |       if (port->flags & MVPP2_F_DT_COMPAT)
> |               snprintf(irqname, sizeof(irqname), "tx-cpu%d", i);
> |       else
> |               snprintf(irqname, sizeof(irqname), "hif%d", i);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, direct replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

