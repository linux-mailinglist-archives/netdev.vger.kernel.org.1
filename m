Return-Path: <netdev+bounces-40182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623B07C6117
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0892823F9
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA0F2B74D;
	Wed, 11 Oct 2023 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fpQuM+QD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDB52B749
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:30:32 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A824EAF
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:30:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9d922c039so3129845ad.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697067030; x=1697671830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pc+L1c0TA8jsyBbY9tjU9uQpsWZgRUC3tgdYjXtGyo4=;
        b=fpQuM+QDwVTunnXGAuDPMDsAQDON5u5mbvw8m9SHrCt6X355eV9QiLAyrUashN2VLl
         2agRT6FQYAi89OCc2D5cEmogEvc0N89yB4TprjHTW/Wzi/vlC6KwYKLMEdw5cp+mknxu
         /zESs/N4qmvYvqfo9z/FZ+zkBiVzPbCsJsVUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697067030; x=1697671830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pc+L1c0TA8jsyBbY9tjU9uQpsWZgRUC3tgdYjXtGyo4=;
        b=dKGyGggnmto/1hiyDRJ+0IFnsALLhyuI3ZdOZC9cY21sPx+ZXDHJ0lP6MzybCrVN2V
         klU7R0Hw8tKnBlvzhtDMMfcAtoE3Y3WrDrH6wZaC7WfWMj0zOZY2g8TCH+JEhOTZUF6j
         tC818N8GMCVji9kZ9Pv6J1Vj5jKKOE3VCd00oEQDE5QHMi/k5OOxLhCot3ioF/6qP7hn
         Dhwu7wJlbzUbVGflYeXBAMT8DKkVhA/IK1vTpxOC5/c0MXv5E2CuzhcYytlxNaXNjA08
         G2UUod+/ptMOvjiqB7pGXpVXI7WzJSVrn8KWr/L83ry7ruw+e0wN/ro4OujN7NrTsWcc
         5X/Q==
X-Gm-Message-State: AOJu0Yx4hMZBFTSyifUWYvLb3ceyYahmzSuxLkQHoCiT+kzJvBeCbuBq
	XTyDG4X6WO6Yxem6eA/2aPsFWQ==
X-Google-Smtp-Source: AGHT+IGL/COvJmyF1vy5JMp/XRjDoRvPXZ0Sk5gmC14VhdhX3JwBvInAy1jn8bD+gmMT5Jd4gIdF8A==
X-Received: by 2002:a17:902:8b8c:b0:1c3:2532:ac71 with SMTP id ay12-20020a1709028b8c00b001c32532ac71mr20665887plb.31.1697067030081;
        Wed, 11 Oct 2023 16:30:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709027e8500b001c78446d65fsm429861pla.113.2023.10.11.16.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:30:29 -0700 (PDT)
Date: Wed, 11 Oct 2023 16:30:27 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ionic: replace deprecated strncpy with strscpy
Message-ID: <202310111629.4CE6D1A72@keescook>
References: <20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-v1-1-23c62a16ff58@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-v1-1-23c62a16ff58@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 09:53:44PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not needed due to `ident` being memset'd to 0 just before
> the copy.
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

Yup, looks like a direct replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

