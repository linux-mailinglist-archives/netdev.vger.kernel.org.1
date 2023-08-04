Return-Path: <netdev+bounces-24310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E5276FBFD
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD95A1C21508
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F133883A;
	Fri,  4 Aug 2023 08:27:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724932F33
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:27:46 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E73527F
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 01:27:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686b9920362so1314071b3a.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691137623; x=1691742423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUS4uE91dvG7NiA03WNNZdSwC3Poo9mFt4/nET0m0dg=;
        b=S89d4M3DnOXOCpVn6+SsXsaln+b1CDkwN+Wc8iZfQIJp/5Mg31YkipDnIpZFJ8WT22
         6KDDkE6N/Q9+Z1OSckAI2AGnB0jNWeeiAnARi+3bxQCjA0MVKMlkSTzRdpiegjDdjzs9
         alwHeWzqeeo6oSaTxIIaxPIaZMlivjqD7xdio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137623; x=1691742423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUS4uE91dvG7NiA03WNNZdSwC3Poo9mFt4/nET0m0dg=;
        b=L2BcZrqwRufhSnUWjuUe0qpiADnVmRT2kzYRy0M6k5cgSFpOib/B+LleIDuPxlLTd9
         Cf9gI9Nmg+4+3plZwHKuJ3w6U1+yC0Gw0wjCzhpkj6t4OlOiegup44MbeRaj7T1/I12L
         EmDmpZ3zdq+K1w7iobRUratG26A/x9/5eNGZvGKKik2fsOQ3yDeNEjNymkLShr5L01Kk
         292DwGZT5UrWnMOlcsIZTZjT3+h3dFG3Nox365Nn3icqb7bKDBflyt19gi+COE+dbSJO
         AwxbbZi42rw5hG3eZ9eVGy8+Qwecg+Vy7nchggeVUASQbC6j09wP8o5ej7gzcmmz/jUf
         XCRg==
X-Gm-Message-State: AOJu0YzdIrC7LJAjl7NMAH9ji+KSOzfYaqbGr13Dk2q68oye1W6phgFN
	tXJSNoDIp3fecKBBAjdCMdBw1g==
X-Google-Smtp-Source: AGHT+IEMVAqP/UVb3WrkT6mDnbU4Pw1rjYqa7tcZY9aFwv2xDvN5rJf3YMidsLXa7DBayiqLPkiTZQ==
X-Received: by 2002:a05:6a20:8f02:b0:13f:8855:d5a0 with SMTP id b2-20020a056a208f0200b0013f8855d5a0mr1071535pzk.50.1691137623268;
        Fri, 04 Aug 2023 01:27:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b0019ee045a2b3sm1138162plo.308.2023.08.04.01.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:27:02 -0700 (PDT)
Date: Fri, 4 Aug 2023 01:27:02 -0700
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
Message-ID: <202308040126.ADDA993@keescook>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728155207.10042-2-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 05:52:05PM +0200, Alexander Lobakin wrote:
> The two most problematic virtchnl structures are virtchnl_rss_key and
> virtchnl_rss_lut. Their "flex" arrays have the type of u8, thus, when
> allocating / checking, the actual size is calculated as `sizeof +
> nents - 1 byte`. But their sizeof() is not 1 byte larger than the size
> of such structure with proper flex array, it's two bytes larger due to
> the padding. That said, their size is always 1 byte larger unless
> there are no tail elements -- then it's +2 bytes.
> Add virtchnl_struct_size() macro which will handle this case (and later
> other cases as well). Make its calling conv the same as we call
> struct_size() to allow it to be drop-in, even though it's unlikely to
> become possible to switch to generic API. The macro will calculate a
> proper size of a structure with a flex array at the end, so that it
> becomes transparent for the compilers, but add the difference from the
> old values, so that the real size of sorta-ABI-messages doesn't change.
> Use it on the allocation side in IAVF and the receiving side (defined
> as static inline in virtchnl.h) for the mentioned two structures.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

This is a novel approach to solving the ABI issues for a 1-elem
conversion, but I have been convinced it's a workable approach here. :)
Thanks for doing this conversion!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

