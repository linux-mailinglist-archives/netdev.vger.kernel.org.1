Return-Path: <netdev+bounces-21653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753637641D7
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 00:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612F41C2145F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 22:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A951519880;
	Wed, 26 Jul 2023 22:02:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7819882
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 22:02:36 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D476026BB
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:02:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so2332125ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690408954; x=1691013754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gd2ZlxfHTeipJ9+dRUQjJ1QVldF3mFRmqkWFPTgpDiY=;
        b=cfsUBJB8yXH0KOBI0r+x2p6gWbwlv3GsUYGhDNUOWlKMo8WtUGbjUwjf5GP3ynSIIh
         Y43JTfuBjSq1Ad9738O63AeUGHczLO6hjlPeX58tXx0OvHOh/xscYM8ZiFc+C8Sa7mgp
         IpbNwokKMQYwCBTDzTSXlyVAUDSHvnRARWP1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408954; x=1691013754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd2ZlxfHTeipJ9+dRUQjJ1QVldF3mFRmqkWFPTgpDiY=;
        b=guLXIHG5YP9KOzSUXAKBsvbp2iHNMnBrDXDDd9H15QMjC/8DJy4lCNoQA63z4iOtSN
         tEFnzcjC01ynyXIqEh8GPO/04cGNLSFW4QuopdTKqe9qTDjTes703YHw2L+mkFYp3R4R
         zKKP7txj/8h0uydeX/ZTsvA8RdHR/OSYd0FbEFJSVbgrD48eEUnSVu7zrO+iOCrSUot1
         Sh1MyUGBlXf7qhw2wrW5bApQiKA76AM250fwWUN2Cpz2NHkAupf5bPqY2VFmoDYk9tcn
         b3s879miKKuZ/zJMF7uKYJCfWqoxyf+qKvpuRLQ5zNmfFKtmhOTtafL0lOxhTEJ5fmEu
         IYeQ==
X-Gm-Message-State: ABy/qLb5Hj5HA2ETCtSizCKnUAxrHc2LcHuZ2mMUba/PWV8YLML91RuW
	N6fWpJOao1cPDUtX0+FVwUzceQ==
X-Google-Smtp-Source: APBJJlGW/S5JZA3QRWMqYYmZE6fm7BvADT1E+Ua3SJd98Gy7Tdps3SvI+6xP8hfItTyJh98Wmby4sw==
X-Received: by 2002:a17:902:e844:b0:1bb:5d9a:9054 with SMTP id t4-20020a170902e84400b001bb5d9a9054mr4098823plg.12.1690408954312;
        Wed, 26 Jul 2023 15:02:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jw12-20020a170903278c00b001b86e17ecacsm35278plb.131.2023.07.26.15.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 15:02:33 -0700 (PDT)
Date: Wed, 26 Jul 2023 15:02:33 -0700
From: Kees Cook <keescook@chromium.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: oliver.sang@intel.com, davem@davemloft.net, edumazet@google.com,
	gustavoars@kernel.org, kuba@kernel.org, kuni1840@gmail.com,
	leitao@debian.org, lkp@intel.com, netdev@vger.kernel.org,
	oe-lkp@lists.linux.dev, pabeni@redhat.com,
	syzkaller@googlegroups.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH v3 net 1/2] af_unix: Fix fortify_panic() in
 unix_bind_bsd().
Message-ID: <202307261501.C836EED808@keescook>
References: <202307262110.659e5e8-oliver.sang@intel.com>
 <20230726161933.26778-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726161933.26778-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 09:19:33AM -0700, Kuniyuki Iwashima wrote:
> From: kernel test robot <oliver.sang@intel.com>
> Date: Wed, 26 Jul 2023 21:52:45 +0800
> > Hello,
> > 
> > kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in_strlen" on:
> > 
> > commit: 33652e138afbe3f7c814567c4ffdf57492664220 ("[PATCH v3 net 1/2] af_unix: Fix fortify_panic() in unix_bind_bsd().")
> > url: https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/af_unix-Fix-fortify_panic-in-unix_bind_bsd/20230725-053836
> > base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git 22117b3ae6e37d07225653d9ae5ae86b3a54f99c
> > patch link: https://lore.kernel.org/all/20230724213425.22920-2-kuniyu@amazon.com/
> > patch subject: [PATCH v3 net 1/2] af_unix: Fix fortify_panic() in unix_bind_bsd().
> > 
> > in testcase: boot
> > 
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > [   33.452659][   T68] ==================================================================
> > [   33.453726][   T68] BUG: KASAN: slab-out-of-bounds in strlen+0x35/0x4f
> > [   33.454515][   T68] Read of size 1 at addr ffff88812ff65577 by task udevd/68
> > [   33.455352][   T68]
> > [   33.455644][   T68] CPU: 0 PID: 68 Comm: udevd Not tainted 6.5.0-rc2-00197-g33652e138afb #1
> > [   33.456627][   T68] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [   33.457802][   T68] Call Trace:
> > [   33.458184][   T68]  <TASK>
> > [   33.458521][   T68]  print_address_description+0x4d/0x2dd
> > [   33.459259][   T68]  print_report+0x139/0x241
> > [   33.459783][   T68]  ? __phys_addr+0x91/0xa3
> > [   33.460290][   T68]  ? virt_to_folio+0x5/0x27
> > [   33.460800][   T68]  ? strlen+0x35/0x4f
> > [   33.461241][   T68]  kasan_report+0xaf/0xda
> > [   33.461756][   T68]  ? strlen+0x35/0x4f
> > [   33.462218][   T68]  strlen+0x35/0x4f
> > [   33.462657][   T68]  getname_kernel+0xe/0x234
> 
> Ok, we still need to terminate the string with unix_mkname_bsd().. so
> I perfer using strlen() here as well to warn about this situation.
> 
> I'll post a patch soon.
> 
> ---8<---
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index bbacf4c60fe3..6056c3bad54e 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1208,7 +1208,8 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
>  	struct path parent;
>  	int err;
>  
> -	addr_len = strnlen(sunaddr->sun_path, sizeof(sunaddr->sun_path))
> +	unix_mkname_bsd(sunaddr->sun_path, addr_len);
> +	addr_len = strlen(((struct sockaddr_storage *)sunaddr)->__data)
>  		+ offsetof(struct sockaddr_un, sun_path) + 1;
>  	addr = unix_create_addr(sunaddr, addr_len);
>  	if (!addr)
> ---8<---

Oh! I missed that you removed the unix_mkname_bsd() in the patch:
https://lore.kernel.org/all/20230724213425.22920-2-kuniyu@amazon.com/

If you just add that back in, you should be fine. (There is no need for
the casting here, strnlen() will still do the right thing from what I
can see.)

-Kees

-- 
Kees Cook

