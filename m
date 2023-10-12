Return-Path: <netdev+bounces-40431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259197C7635
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAE528229A
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE3F374D6;
	Thu, 12 Oct 2023 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KAubfCj1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729728E21
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:03:40 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E127BE
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:03:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c8a1541232so11967415ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697137418; x=1697742218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+UW4+U9HpV+E9ycAwBZg91gnF7Sw/DTzJeLz9wATvA=;
        b=KAubfCj1S+bG6xkRbpfls3howND2lMjegG8CiiMKTaPC8AMb+PvBdSRjPOsXLwhPSB
         fS9A82A0uL45C32+q87qYWAl3lXBX3VnIxkqFO9irHAyAS4mR6A8YaCSHSVTKa3n8ohC
         veutWPALsUI0ecF9zfAtDRJpnb7ACVCbr1pJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697137418; x=1697742218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+UW4+U9HpV+E9ycAwBZg91gnF7Sw/DTzJeLz9wATvA=;
        b=qR6sZME0pUSLvhMaOu4in9g0aOl+bTngzBpCtM/W1WbK72AacBapRVj3R5/Bw0UOH/
         T7Oeu8MlaceWlym9/tM6NMsoR6MwUDdZaxmRhD5Qe3Vl6QQ0qppgYILxTAFJ8Vj8kBhY
         0nG1kpKnDokOCfToNGcyRU/u+JkUy0tDggUgcq8H6SENoX11T+wP8IGNEv0qpRO05+zv
         RmRkL0K03B4I8cGy/QAkFQ1FuXcV55S6Ws6faGNld6h5BkwngXOuljQs8lskdr2A/IVd
         dI4Nj6YfPsgPJTt6JEva0F3ACL6QY0e7jsWBZdUlD86kiCCImyb6uxqGLk6IVC/hytcx
         X5uA==
X-Gm-Message-State: AOJu0Yw/Mkdg8lU8fLebL9teTpUSOGk9Z2ZRo1v8ZLsaUPxtg600v6l2
	EZvH2Yr0tkEwx0bI75OT+QHLaQ==
X-Google-Smtp-Source: AGHT+IHX6L/aLX9NNOcwqRVmh9iizTWqDKSZdokhOeYvlGzRhloHgIdhhspGR9BXHTu8NSRDETlQuw==
X-Received: by 2002:a17:903:120b:b0:1bf:2e5c:7367 with SMTP id l11-20020a170903120b00b001bf2e5c7367mr28527771plh.42.1697137417668;
        Thu, 12 Oct 2023 12:03:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o2-20020a1709026b0200b001c75627545csm2324737plk.135.2023.10.12.12.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:03:37 -0700 (PDT)
Date: Thu, 12 Oct 2023 12:03:32 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Ariel Elior <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] qed: replace uses of strncpy
Message-ID: <202310121203.0415E3B@keescook>
References: <20231012-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-v2-1-16d2c0162b80@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-v2-1-16d2c0162b80@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 06:35:41PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This patch eliminates three uses of strncpy():
> 
> Firstly, `dest` is expected to be NUL-terminated which is evident by the
> manual setting of a NUL-byte at size - 1. For this use specifically,
> strscpy() is a viable replacement due to the fact that it guarantees
> NUL-termination on the destination buffer.
> 
> The next two cases should simply be memcpy() as the size of the src
> string is always 3 and the destination string just wants the first 3
> bytes changed.
> 
> To be clear, there are no buffer overread bugs in the current code as
> the sizes and offsets are carefully managed such that buffers are
> NUL-terminated. However, with these changes, the code is now more robust
> and less ambiguous (and hopefully easier to read).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, this looks good to me now. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

