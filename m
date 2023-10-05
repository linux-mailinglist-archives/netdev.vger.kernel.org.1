Return-Path: <netdev+bounces-38436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FDF7BAEEA
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 00:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CAE4E281FBE
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 22:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426034120B;
	Thu,  5 Oct 2023 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MiifTB1O"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D371154AB
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 22:42:12 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECEBE4
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 15:42:10 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5859e22c7daso1037514a12.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696545730; x=1697150530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nz7lk7ASZyzYk8GD9c9UI0XKLO+hFISo62X4fmfBjLs=;
        b=MiifTB1OW2EQSGbn8uFBfa+BeiveCEke0uMAPHIm4aaUAjKKIcpMghHK5G2n9Rae98
         Kx/ynOtpHDU43KdyJuoA/A3Dvde3JMe/hL1NMVOFnEIAr38uZOoH41jT14cOF4IBgZo2
         mXyn0wYyaruDOfkyOGFGnL8AyLF7fOSw0FzN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696545730; x=1697150530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz7lk7ASZyzYk8GD9c9UI0XKLO+hFISo62X4fmfBjLs=;
        b=japInzfdt8YrUqlDoKFk4TNEFRSpSEYVs6HKZgoQ9MgaME8HE5O74wT79MBUAWkihw
         Fn68AtB6wEh/2iVV0id7R4JaW3mjCNFDtOKpdv4ro/NEzVvfqRNdKLX1tfFTu5J30nMa
         qpmaQ1IY+li2xsPjqrNrvllu77BFVL1ClOMwmebkUJCgFlhtqx7D4Ydpx95NBg/oae5O
         ahusTyV5bF1hZ741ZFn/TnGCfq6nKdrVeibl47M9YChxNyXQSBpQc4MnFZ8+K9h0Fl4p
         ONRfv9LJp6ySo2GQfpZVO+1BuObFjgJ2XmNr6KT33kavVnArHt7huPodAjxQaGC1zyPL
         Cp3Q==
X-Gm-Message-State: AOJu0YzybPAiCT+ybgkIENFfLNlEWcqV0qjuKg6Kz8+lPsU5CV/LdLtj
	mL/PyMIZZG53mcsBOzU6nnUj3A==
X-Google-Smtp-Source: AGHT+IEgQZTEs2BdqQ0GOWFAgas7OCDMFaKUSGv2iXW7ue7c1U+XG351TvMd1vGVOqGjStDFLsY+kA==
X-Received: by 2002:a05:6a21:819f:b0:15d:8409:8804 with SMTP id pd31-20020a056a21819f00b0015d84098804mr5926846pzb.57.1696545729755;
        Thu, 05 Oct 2023 15:42:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b001c5de06f13bsm2284923plx.226.2023.10.05.15.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 15:42:09 -0700 (PDT)
Date: Thu, 5 Oct 2023 15:42:08 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for
 lan9303_get_strings()
Message-ID: <202310051539.B2D34DB@keescook>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 06:56:50PM +0000, Justin Stitt wrote:
> This pattern of strncpy with some pointer arithmetic setting fixed-sized
> intervals with string literal data is a bit weird so let's use
> ethtool_sprintf() as this has more obvious behavior and is less-error
> prone.
> 
> Nicely, we also get to drop a usage of the now deprecated strncpy() [1].
> 
> One might consider this pattern:
> |       ethtool_sprintf(&buf, lan9303_mib[u].name);
> ... but this triggers a -Wformat-security warning.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Ah, cool ethtool_sprintf() works. Maybe some day we can fix the whole
API to actually have bounds, but yes, this is fine.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

