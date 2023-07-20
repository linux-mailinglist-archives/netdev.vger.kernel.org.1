Return-Path: <netdev+bounces-19523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD57175B164
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB86D281E98
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97131801D;
	Thu, 20 Jul 2023 14:39:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81F17723
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:39:53 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF04910FC
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:39:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-54290603887so450384a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689863990; x=1690468790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v70j74SNN6clF4fKRQ8qeEGthR3IYR+KXBl2pFd5Ol0=;
        b=TJZlEZzpGYz/DZ4/wPynNqyBo86TApSLBZnm/FHB5ycsF5NNdHA3qoyYTCn3izuLlf
         SGQBUx0/KdiYApSVXDPnTAh7IafW7yyNGmsGZ9fl0TtdKY1unl139uU7/SgT9wwmnwc7
         4v4EakF2fbxg5+cDhYU9xLPYZGWdnxd6yU/H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689863990; x=1690468790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v70j74SNN6clF4fKRQ8qeEGthR3IYR+KXBl2pFd5Ol0=;
        b=Bh05YvmiwjVRlj+1CiGjPJdBpyWiKmmksfTIosHOvXS1huKT3EQ2jm1g4BAyVbbw6c
         kkj1V8+0DNNHSTpMzIDE1cxxtydh4EPU/M7vSz+45XxLqqvlG4ruy+ytE0/MPtj3HZ4C
         h6RE2dDVQVRuYjD0DC6/5XAHCz2gxGuzzVhaiJrsUeF53egKjMkJyySIBc2S0CFmYebC
         VZcbnMri1O0GkcptHRajsNaFfNK65LZ2UR0Q/K9OHfrDPnX7/3Tw+QR3lX41tPaREd/L
         dZYM1MsCtnDuIMcmCyQoigwElAD12CQAACEU05IQmRdtixNEnG8c3UalTyJZSp4PJAgO
         DSEQ==
X-Gm-Message-State: ABy/qLbt8a4B5Fl5jyn41rq+eA/XjTXJzlfiDPCndkv3oNKNQuVjS0P9
	wSu1+6pqee0rArFE5AkIkvUQhA==
X-Google-Smtp-Source: APBJJlEsFPLOmquoVflCipzXDkkPXHs8xB37uQgz6nXSQFrFOYBgjcw9m1jvGtgmOa1sEJsQMWHDBQ==
X-Received: by 2002:a17:90a:4109:b0:262:cb1c:a782 with SMTP id u9-20020a17090a410900b00262cb1ca782mr17479495pjf.37.1689863990316;
        Thu, 20 Jul 2023 07:39:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a030d00b0025bbe90d3cbsm1146168pje.44.2023.07.20.07.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:39:49 -0700 (PDT)
Date: Thu, 20 Jul 2023 07:39:48 -0700
From: Kees Cook <keescook@chromium.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v2 net 1/2] af_unix: Fix fortify_panic() in
 unix_bind_bsd().
Message-ID: <202307200726.DBC8EAD9D@keescook>
References: <20230720004410.87588-1-kuniyu@amazon.com>
 <20230720004410.87588-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720004410.87588-2-kuniyu@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 05:44:09PM -0700, Kuniyuki Iwashima wrote:
> syzkaller found a bug in unix_bind_bsd() [0].  We can reproduce it
> by bind()ing a socket on a path with length 108.
> 
> 108 is the size of sun_addr of struct sockaddr_un and is the maximum
> valid length for the pathname socket.  When calling bind(), we use
> struct sockaddr_storage as the actual buffer size, so terminating
> sun_addr[108] with null is legitimate.
> 
> However, strlen(sunaddr) for such a case causes fortify_panic() if
> CONFIG_FORTIFY_SOURCE=y.  __fortify_strlen() has no idea about the
> actual buffer size and takes 108 as overflow, although 108 still
> fits in struct sockaddr_storage.

Oh, the max size is 108, but it's allowed to be unterminated? This seems
to contradict the comment for unix_validate_addr() (which then doesn't
validate this ...) Reading "max 7 unix" seems to clear this up and
confirm that it doesn't need to be terminated. Bleh.

Regardless, see below for a simpler solution, since this doesn't need to
be arbitrarily long, just potentially unterminated.

> Let's make __fortify_strlen() recognise the actual buffer size.
> 
> [0]:
> detected buffer overflow in __fortify_strlen
> kernel BUG at lib/string_helpers.c:1031!
> Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 255 Comm: syz-executor296 Not tainted 6.5.0-rc1-00330-g60cc1f7d0605 #4
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : fortify_panic+0x1c/0x20 lib/string_helpers.c:1030
> lr : fortify_panic+0x1c/0x20 lib/string_helpers.c:1030
> sp : ffff800089817af0
> x29: ffff800089817af0 x28: ffff800089817b40 x27: 1ffff00011302f68
> x26: 000000000000006e x25: 0000000000000012 x24: ffff800087e60140
> x23: dfff800000000000 x22: ffff800089817c20 x21: ffff800089817c8e
> x20: 000000000000006c x19: ffff00000c323900 x18: ffff800086ab1630
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
> x14: 1ffff00011302eb8 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : 64a26b65474d2a00
> x8 : 64a26b65474d2a00 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff800089817438 x4 : ffff800086ac99e0 x3 : ffff800080f19e8c
> x2 : 0000000000000001 x1 : 0000000100000000 x0 : 000000000000002c
> Call trace:
>  fortify_panic+0x1c/0x20 lib/string_helpers.c:1030
>  _Z16__fortify_strlenPKcU25pass_dynamic_object_size1 include/linux/fortify-string.h:217 [inline]
>  unix_bind_bsd net/unix/af_unix.c:1212 [inline]
>  unix_bind+0xba8/0xc58 net/unix/af_unix.c:1326
>  __sys_bind+0x1ac/0x248 net/socket.c:1792
>  __do_sys_bind net/socket.c:1803 [inline]
>  __se_sys_bind net/socket.c:1801 [inline]
>  __arm64_sys_bind+0x7c/0x94 net/socket.c:1801
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
>  el0_svc_common+0x134/0x240 arch/arm64/kernel/syscall.c:139
>  do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
>  el0_svc+0x2c/0x7c arch/arm64/kernel/entry-common.c:647
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> Code: aa0003e1 d0000e80 91030000 97ffc91a (d4210000)
> 
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  net/unix/af_unix.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 123b35ddfd71..e1b1819b96d1 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -302,6 +302,18 @@ static void unix_mkname_bsd(struct sockaddr_un *sunaddr, int addr_len)
>  	((char *)sunaddr)[addr_len] = 0;
>  }
>  
> +static int unix_strlen_bsd(struct sockaddr_un *sunaddr)
> +{
> +	/* Don't pass sunaddr->sun_path to strlen().  Otherwise, the
> +	 * max valid length UNIX_PATH_MAX (108) will cause panic if
> +	 * CONFIG_FORTIFY_SOURCE=y.  Let __fortify_strlen() know that
> +	 * the actual buffer is struct sockaddr_storage and that 108
> +	 * is within __data[].  See also: unix_mkname_bsd().
> +	 */
> +	return strlen(((struct sockaddr_storage *)sunaddr)->__data) +
> +		offsetof(struct sockaddr_un, sun_path) + 1;
> +}
> +
>  static void __unix_remove_socket(struct sock *sk)
>  {
>  	sk_del_node_init(sk);
> @@ -1209,9 +1221,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
>  	int err;
>  
>  	unix_mkname_bsd(sunaddr, addr_len);
> -	addr_len = strlen(sunaddr->sun_path) +

Instead of a whole new function, I think this can just be:

		strnlen(sunaddr->sun_path, sizeof(sunaddr->sun_path)) +

> -		offsetof(struct sockaddr_un, sun_path) + 1;
> -
> +	addr_len = unix_strlen_bsd(sunaddr);
>  	addr = unix_create_addr(sunaddr, addr_len);
>  	if (!addr)
>  		return -ENOMEM;
> -- 
> 2.30.2
> 

-- 
Kees Cook

