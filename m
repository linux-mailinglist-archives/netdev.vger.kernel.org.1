Return-Path: <netdev+bounces-39760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A83C7C4570
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 01:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1301C20B3C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4BF32C99;
	Tue, 10 Oct 2023 23:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="motvlJD/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC74315B3
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:28:20 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A51793
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:28:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c5ff5f858dso43068295ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696980498; x=1697585298; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ffyVmDvObFUQGm01LEbnK2a/NNSPjFeJ8aUijmhJtI=;
        b=motvlJD/CCSca8DU/gmwa6KBCkG7scvSfW8COtt2JmDGZqFL+7hZg8Ncynmys9Oa9D
         QQiwZTGU3Cs7Lm9/NT+Rkj/DIR3yW8sL27MMSnqPUt3lN1uHBtViBlGnuHimFrBSyA9E
         ITN9X5IRqBHIRf7381IoB+AOJNBElQkcQjKgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696980498; x=1697585298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ffyVmDvObFUQGm01LEbnK2a/NNSPjFeJ8aUijmhJtI=;
        b=offTLWibQ+rMbhrrzNKDByQjteKGt5P4riWtaSbTbjEWhOq6HTB4I241tXelCYpimu
         EJkctnthyxv34GdZ60YIB+XJNkmJK0I8XiMPJxDRAk2IMtfy6zOU7EfnLFwZz+c9h218
         CxLCI4SNWEFQOIl8YKp7jGNVCWuXuJszhYrXITrupGHb6S3pHYwbWh6/v2R436TyVOjq
         8NH1wnxuqv1WyAZeO4C/OhYhd/b/WMsCZLxJ21LnyahmS56PRfYesDopI/QH3PAPYWOr
         TD0l1HI99ZdbW1J/OdT1FJMbRDe8jgCSdQKZpUvOZDHfJB1psf+3rnRzsREneIhdRbW2
         bWfg==
X-Gm-Message-State: AOJu0Yznjiaaclc7toRayXdtPRh2R7L7gJS91Zx9vUjiwKC3sx4ZrqQv
	Yr8QJIvFna+APHL5FDTs8AX9bQ==
X-Google-Smtp-Source: AGHT+IEiG6MkiUeUM4CjFtvjNc39SCT6bmkPmjD94V4ggCDiykYfKvAabgK71CDQRK5wtqaWRWjRvw==
X-Received: by 2002:a17:90a:ab87:b0:27b:258f:2843 with SMTP id n7-20020a17090aab8700b0027b258f2843mr12673716pjq.7.1696980498575;
        Tue, 10 Oct 2023 16:28:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a5d0f00b00263cca08d95sm12446269pji.55.2023.10.10.16.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:28:17 -0700 (PDT)
Date: Tue, 10 Oct 2023 16:28:14 -0700
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
Message-ID: <202310101625.175D43E7@keescook>
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
 <d84f2d4d-40d7-af15-0049-f8e1efed1eba@intel.com>
 <CAFhGd8pR4EdjVzHLKwxtH=OHNO1rLsuWAs=ZHX7hWohhE8Kcjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8pR4EdjVzHLKwxtH=OHNO1rLsuWAs=ZHX7hWohhE8Kcjg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 04:22:44PM -0700, Justin Stitt wrote:
> On Tue, Oct 10, 2023 at 4:19 PM Jesse Brandeburg
> <jesse.brandeburg@intel.com> wrote:
> >
> > On 10/10/2023 3:26 PM, Justin Stitt wrote:
> > > Hi,
> > >
> > > This series aims to eliminate uses of strncpy() as it is a deprecated
> > > interface [1] with many viable replacements available.
> > >
> > > Predominantly, strscpy() is the go-to replacement as it guarantees
> > > NUL-termination on the destination buffer (which strncpy does not). With
> > > that being said, I did not identify any buffer overread problems as the
> > > size arguments were carefully measured to leave room for trailing
> > > NUL-bytes. Nonetheless, we should favor more robust and less ambiguous
> > > interfaces.
> > >
> > > Previously, each of these patches was sent individually at:
> > > 1) https://lore.kernel.org/all/20231009-strncpy-drivers-net-ethernet-intel-e100-c-v1-1-ca0ff96868a3@google.com/
> > > 2) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-e1000-e1000_main-c-v1-1-b1d64581f983@google.com/
> > > 3) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-fm10k-fm10k_ethtool-c-v1-1-dbdc4570c5a6@google.com/
> > > 4) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-i40e-i40e_ddp-c-v1-1-f01a23394eab@google.com/
> > > 5) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-igb-igb_main-c-v1-1-d796234a8abf@google.com/
> > > 6) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com/
> > > 7) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-v1-1-f1f507ecc476@google.com/
> > >
> > > Consider these dead as this series is their new home :)
> > >
> > > I found all these instances with: $ rg "strncpy\("
> > >
> > > This series may collide in a not-so-nice way with [3]. This series can
> > > go in after that one with a rebase. I'll send a v2 if necessary.
> > >
> > > [3]: https://lore.kernel.org/netdev/20231003183603.3887546-1-jesse.brandeburg@intel.com/
> > >
> > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> >
> > Thanks Justin for fixing all these!
> >
> > For the series:
> > Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> >
> > PS: have you considered adding a script to scripts/coccinelle/api which
> > might catch and try to fix future (ab)users of strncpy?
> 
> There is a checkpatch routine for it. Also, the docs are littered with
> aversions to strncpy. With that being said, I would not be opposed
> to adding more checks, though.
> 
> Once I'm more caught up on all the outstanding strncpy uses,
> I'll look into adding some coccinelle support.

Coccinelle for strncpy is difficult since each set of callers tends to
need careful examination. But the good news here is that at the current
rate, the kernel may be strncpy-free pretty soon. :)

-- 
Kees Cook

