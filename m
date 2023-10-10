Return-Path: <netdev+bounces-39761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 012C57C4577
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 01:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408E9281B82
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7FE3C687;
	Tue, 10 Oct 2023 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NWvU7CML"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318832C9D
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:31:37 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D399
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:31:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso4383819b3a.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696980695; x=1697585495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUjyOBhd765L6DdntubpjwFEWCc0T7iDXxMPZLU1JCY=;
        b=NWvU7CMLLYsJpb5uFw9TyZIB1eCWO/UDWuWv2zEdcdJCByEXY0mZvGlGHZrdqP/74N
         Q2CHV/eEIRe7OhugD9qjYrmDNDYz691nZ0bVgTUftEHMqwPW7rJTQWzEcGv82jUhTTxA
         bQaqdv/sY7CEccy9ISRdlzLkDZvwWDHPJ6nBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696980695; x=1697585495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUjyOBhd765L6DdntubpjwFEWCc0T7iDXxMPZLU1JCY=;
        b=ZzovdLFO4TCBdFGMw9X8Ul5Wq7VS9mjl6jFJtSXoneZPSkFwxW4g4hA/AOtXmeJ0s3
         RUCvA6nR3OuII4Khik5iOqP3nGW2LNaHvHBF3I0qv3p3z2cdNbuX0eIv2NdaCyE0CUF3
         OVo1kYBFnCtmq7COwwuc4qZAVymU3xN6NK8zZO8VqtEyU+/DSvJxhuWrGZbBJdB2N8ml
         5HyOdjYcTFwwjSH9PcBnjkyZigjWbFLxPLHtmLezbBHdmoTbArchccj5VhclyJtW3oEB
         GiaeN5pD7a99HPvsdXyNpdBCt6Arl1H/dc0bGS1uzSlnNN1GkJMhizF0SOgW8HOoLdgo
         qCDw==
X-Gm-Message-State: AOJu0YzqAIPxm6TLCXY4NTESSJc2bdOpcPme3itq2yFa/yHuWKxKrdhV
	aTClgBuTI7r6bFd0EQhhZuQWuA==
X-Google-Smtp-Source: AGHT+IGadnp4YcxPOL/WJ85GFmKVZw/8m1cJ8MXKeIjm+wQceLO6xqiz7GHgTMTUka9eEN3b6icCIw==
X-Received: by 2002:a05:6a00:18a3:b0:690:ca4e:662f with SMTP id x35-20020a056a0018a300b00690ca4e662fmr19894283pfh.5.1696980694989;
        Tue, 10 Oct 2023 16:31:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fn6-20020a056a002fc600b0069302c3c054sm8810670pfb.207.2023.10.10.16.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:31:34 -0700 (PDT)
Date: Tue, 10 Oct 2023 16:31:32 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hardening@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] net: intel: replace deprecated strncpy uses
Message-ID: <202310101630.AB35100@keescook>
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 10:26:53PM +0000, Justin Stitt wrote:
> Hi,
> 
> This series aims to eliminate uses of strncpy() as it is a deprecated
> interface [1] with many viable replacements available.
> 
> Predominantly, strscpy() is the go-to replacement as it guarantees
> NUL-termination on the destination buffer (which strncpy does not). With
> that being said, I did not identify any buffer overread problems as the
> size arguments were carefully measured to leave room for trailing
> NUL-bytes. Nonetheless, we should favor more robust and less ambiguous
> interfaces.
> 
> Previously, each of these patches was sent individually at:
> 1) https://lore.kernel.org/all/20231009-strncpy-drivers-net-ethernet-intel-e100-c-v1-1-ca0ff96868a3@google.com/
> 2) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-e1000-e1000_main-c-v1-1-b1d64581f983@google.com/
> 3) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-fm10k-fm10k_ethtool-c-v1-1-dbdc4570c5a6@google.com/
> 4) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-i40e-i40e_ddp-c-v1-1-f01a23394eab@google.com/
> 5) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-igb-igb_main-c-v1-1-d796234a8abf@google.com/
> 6) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com/
> 7) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-v1-1-f1f507ecc476@google.com/
> 
> Consider these dead as this series is their new home :)
> 
> I found all these instances with: $ rg "strncpy\("
> 
> This series may collide in a not-so-nice way with [3]. This series can
> go in after that one with a rebase. I'll send a v2 if necessary.
> 
> [3]: https://lore.kernel.org/netdev/20231003183603.3887546-1-jesse.brandeburg@intel.com/
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Justin Stitt (7):
>       e100: replace deprecated strncpy with strscpy
>       e1000: replace deprecated strncpy with strscpy
>       fm10k: replace deprecated strncpy with strscpy
>       i40e: use scnprintf over strncpy+strncat
>       igb: replace deprecated strncpy with strscpy
>       igbvf: replace deprecated strncpy with strscpy
>       igc: replace deprecated strncpy with strscpy

These all look good to me. Thanks for the careful analysis!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook

