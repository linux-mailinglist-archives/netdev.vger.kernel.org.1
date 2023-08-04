Return-Path: <netdev+bounces-24519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B32A977071C
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 19:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC1828119B
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D2B1AA8E;
	Fri,  4 Aug 2023 17:29:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C853C2CA
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 17:29:54 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350E649F5
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:29:50 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-56c685b7e91so1549884eaf.2
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691170189; x=1691774989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4vdhRUtg9vt+FoZL7q0xAtAfLYBhNs3NC9GBHaD1o4=;
        b=GLAfMARBv+SZka30ple40Vmfo4lfaiOyW30EbkESLtrDz5c/DB5IyxfU7W9i5Baf3u
         31Zzecz/CBM2SoIQz22XYxHwrIswsKL/rLLNFaG6sxF5L7cc4zJNa8kyQhJXzvYrsS8q
         dmtq6b13+1Mw4qhW3Hk3Uwt4QV5SIIeGiQ26s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691170189; x=1691774989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4vdhRUtg9vt+FoZL7q0xAtAfLYBhNs3NC9GBHaD1o4=;
        b=Z7vpLfsp2cdbNbrfb31W8gEM1bT4dBBruzvMDsKzT/K0VUVdZVpb0v13AfaxnF0Mqb
         prSMhiHGspTK65GsJaOV0otcvZHfL3F41dfc4/UjsCwt+SaTflNd2I1+ILIhq7LDpgN1
         WcixZjbLJ+7SLdPHtAYopY784JxukKnKCrIEzNgyhmNaB9uNC+wDdJ+CrM4EZ+D9JX4h
         ulK7HjGjjittaYaHqZNChSulCUXzkjY9AewRiT5cJR23071sX/K9BP4kZvK4ujzqjibH
         WDitjXt9S4Oy/rUBfTVF/vdE1sULSXMBNSJ3HZEGCBzclAP55j7lZQl2MfznLG1BIH02
         HB9w==
X-Gm-Message-State: AOJu0YzWj9QfZUuKwOFrDvseu3C6woLOihGSI9ICMChFyw8ew5WYDWDj
	IzEJotWnUkCMcagdMXvwiC9+hg==
X-Google-Smtp-Source: AGHT+IFgh5CF2i5h/8VoLtSl3dKgvdkpF8uKzXgQIOyt/Q679nwX+1DqZQk2AhGuKKxzKDbJ9mMWwg==
X-Received: by 2002:a05:6358:79c:b0:135:62de:ff7d with SMTP id n28-20020a056358079c00b0013562deff7dmr2095914rwj.8.1691170189380;
        Fri, 04 Aug 2023 10:29:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a63d649000000b0055c090df2fasm1368776pgj.93.2023.08.04.10.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 10:29:48 -0700 (PDT)
Date: Fri, 4 Aug 2023 10:29:48 -0700
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
Subject: Re: [PATCH net-next 1/3] virtchnl: fix fake 1-elem arrays in structs
 allocated as `nents + 1` - 1
Message-ID: <202308041029.74FF3CCD@keescook>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-2-aleksander.lobakin@intel.com>
 <202308040126.ADDA993@keescook>
 <49b0d7bd-2bc1-c994-7780-35554a399242@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49b0d7bd-2bc1-c994-7780-35554a399242@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 05:42:19PM +0200, Alexander Lobakin wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Fri, 4 Aug 2023 01:27:02 -0700
> 
> > On Fri, Jul 28, 2023 at 05:52:05PM +0200, Alexander Lobakin wrote:
> >> The two most problematic virtchnl structures are virtchnl_rss_key and
> >> virtchnl_rss_lut. Their "flex" arrays have the type of u8, thus, when
> >> allocating / checking, the actual size is calculated as `sizeof +
> >> nents - 1 byte`. But their sizeof() is not 1 byte larger than the size
> >> of such structure with proper flex array, it's two bytes larger due to
> >> the padding. That said, their size is always 1 byte larger unless
> >> there are no tail elements -- then it's +2 bytes.
> >> Add virtchnl_struct_size() macro which will handle this case (and later
> >> other cases as well). Make its calling conv the same as we call
> >> struct_size() to allow it to be drop-in, even though it's unlikely to
> >> become possible to switch to generic API. The macro will calculate a
> >> proper size of a structure with a flex array at the end, so that it
> >> becomes transparent for the compilers, but add the difference from the
> >> old values, so that the real size of sorta-ABI-messages doesn't change.
> >> Use it on the allocation side in IAVF and the receiving side (defined
> >> as static inline in virtchnl.h) for the mentioned two structures.
> >>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > 
> > This is a novel approach to solving the ABI issues for a 1-elem
> > conversion, but I have been convinced it's a workable approach here. :)
> > Thanks for doing this conversion!
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> 
> Thanks a lot!
> You gave Reviewed-by for patches #1 and #3, does it mean the whole
> series or something is wrong with the patch #2? :D

Hm, maybe delivery was delayed? I see it on lore:
https://lore.kernel.org/all/202308040128.667940394B@keescook/

-- 
Kees Cook

