Return-Path: <netdev+bounces-22447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3235767895
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC221C2126A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 22:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C6B1BB5F;
	Fri, 28 Jul 2023 22:43:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB65525C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 22:43:32 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA224498
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:43:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686efdeabaeso1817190b3a.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690584208; x=1691189008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqnEWXGBr+qgq+fw45Hld4bEOObqJbZc782zVcwCLuo=;
        b=d7wBzlZ64gFtXkNExZkAf2L2TcCyfy5/7eWx6u6tzjV0OTM9I4iTra1tb8g18fz1tm
         zjnf/3/RfFUj7Y1+OWcrLozJbIZ//yanLc+UeESbFh7sDGEufAtXK5yIIyWWJctPGV6f
         JcvWOOS6ij4NmpSmEFiFReD739b975jhkp6GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690584208; x=1691189008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqnEWXGBr+qgq+fw45Hld4bEOObqJbZc782zVcwCLuo=;
        b=YOZJCUQg3BPLhN0L28IjbhoLW33Dr/LC+cDul+OkjnM54WZA12w1ds0Ky3Q1dw8SaZ
         6oznYN/3QBVAUCka9fPsaXD5psR8BVgiC5TyLBkHgF1bnvKz2Si6hB8tKyP9FhXR9aOF
         hCyU/ad1TF5sk+Rhf4kTQJZmXE7V1/Y+So5bYvc4DeOu+vU+doNTqBrh9oekbY+cx/CI
         2edfpK6YZ/HZeIbJ0ltI2UCLgEXMeyAzYZeCibq+U/RbbQD19dPs+g7aRMI/GyVxh75Z
         54TQs6nK/ldvW7iq513TSpP5q7YIeE2ttLj+l0HENWef3bjea1IWC2tVJmjuPe+URAsC
         U2BA==
X-Gm-Message-State: ABy/qLagOu8cGV3K7CJMOwimEbK6KtXS6aaidXYzMftcVpC6F/rewQX8
	RS5JaWR9Ou1ul0CugJtYZ2DldA==
X-Google-Smtp-Source: APBJJlEFOXYQokilR8cdjkWektv3laYms1B2ykj0+cKlup9KWlpd1V1VaF3ZUmqBbDxlUB7w2HGN7A==
X-Received: by 2002:a05:6a20:3251:b0:133:bbe0:30bf with SMTP id hm17-20020a056a20325100b00133bbe030bfmr2705280pzc.13.1690584207864;
        Fri, 28 Jul 2023 15:43:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w24-20020a170902d71800b001b8052d58a0sm4053824ply.305.2023.07.28.15.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:43:27 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:43:26 -0700
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
Message-ID: <202307281537.AC1ED9CA@keescook>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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

This all looks workable, but it's a unique solution in the kernel. That
is fine, of course, but would it be easier to maintain/test if it went
with the union style solutions?

struct foo {
	...
	union {
		type legacy_padding;
		DECLARE_FLEX_ARRAY(type, member);
	};
};

Then the size doesn't change and "member" can still be used. (i.e. no
collateral changes needed.)

-Kees

-- 
Kees Cook

