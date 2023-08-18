Return-Path: <netdev+bounces-28908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A24781213
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 19:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53811C2149F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FE719BBF;
	Fri, 18 Aug 2023 17:37:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993EE19BB1
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 17:37:40 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB1C35BB
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 10:37:38 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-565f58f4db5so919025a12.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692380258; x=1692985058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3LKfiXOUv4Y78GYwccbn9eLRl2BI7RjZ4/fZETpGexM=;
        b=AwtNaCfH+hxlFLkfnuSI87gwp+VrGSgjnV1+zyCVrSwmJJC4EGOeaIRRhY9RTx6MYP
         FgApMLQbcYGXFIUxmq7WRH1DlieMuCOArB0NAHYwn8eFVczWDLMlggXkB/l7FmumT4gH
         p8dBl4LTXYAJn2srL2qSVGJh9kAj2+MdjgNnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692380258; x=1692985058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LKfiXOUv4Y78GYwccbn9eLRl2BI7RjZ4/fZETpGexM=;
        b=jiCZ1HtAAlFusegPgOC8htywQNChYbxkVUsqxbikArLUInr/PNgtUAe3WUESJZUhaQ
         CfxiYmplhbG04vkjqaH+9Nj947PYgpTyRFYVCpqVEnZjjyPfDaQ3uNvYj4G62/0OkVyn
         g/u2WD5wS0wsJpvJ7GICTy0tcr3s8Lx1OXiY3BBqrintnTCn/dx9ZyqddU8yIyAbLdCH
         1vNqnD8mU4XnD3+1hCnZUXb6ikyeoqlLuNtgHIUDDda3TZfmILzjgC6QUSD5Jv8mE+ho
         wmvK8jbGcoINNCn2bjJf5UiP8i3f1Q/nTTtlxVux3zyQBUa+qW6Ui3D+NfGEzZ7Qi0W2
         l11w==
X-Gm-Message-State: AOJu0YwdjSWYagYjL3ku40U2S3w8VMByumfHnZSvMLzY1JxcyusLaeK2
	jv9tlaDAFR1XY0SXh+lpikawVg==
X-Google-Smtp-Source: AGHT+IGJ++HaMEe6fHz/+u8LhwdAhyc4KdGymaYjDc60SFpqfaa9p36TY5f9p3+CAiEcdKVw+eWCoA==
X-Received: by 2002:a17:90b:438d:b0:26d:4346:6eb2 with SMTP id in13-20020a17090b438d00b0026d43466eb2mr2675522pjb.46.1692380258263;
        Fri, 18 Aug 2023 10:37:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ci13-20020a17090afc8d00b002684b837d88sm1828910pjb.14.2023.08.18.10.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:37:37 -0700 (PDT)
Date: Fri, 18 Aug 2023 10:37:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, linux-kernel@vger.kernel.org,
	siva.kallam@broadcom.com, prashant@broadcom.com, mchan@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, jdelvare@suse.com,
	Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Linux Regressions <regressions@lists.linux.dev>
Subject: Re: "Use slab_build_skb() instead" deprecation warning triggered by
 tg3
Message-ID: <202308181036.8F79E77@keescook>
References: <1bd4cb9c-4eb8-3bdb-3e05-8689817242d1@proxmox.com>
 <ZN9SId_KNgI3dfVI@debian.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN9SId_KNgI3dfVI@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 06:12:33PM +0700, Bagas Sanjaya wrote:
> On Fri, Aug 18, 2023 at 10:05:11AM +0200, Fiona Ebner wrote:
> > Hi,
> > we've got a user report about the WARN_ONCE introduced by ce098da1497c
> > ("skbuff: Introduce slab_build_skb()") [0]. The stack trace indicates
> > that the call comes from the tg3 module. While this is still kernel 6.2
> > and I can't verify that the issue is still there with newer kernels, I
> > don't see related changes in drivers/net/ethernet/broadcom/tg3.* after
> > ce098da1497c, so I thought I should let you know.
> > 
> 
> Thanks for the regression report. I'm adding it to regzbot:
> 
> #regzbot ^introduced: ce098da1497c6d
> #regzbot link: https://forum.proxmox.com/threads/132338/
> 
> PS: The proxmox forum link (except full dmesg log pasted there) is in
> German, so someone fluent in the language can be helpful here.

Since this doesn't cause a behavioral regression, should it be tracked
by regzbot? The WARN is serving as a reminder to the maintainer to
adjust the allocation method.

-- 
Kees Cook

