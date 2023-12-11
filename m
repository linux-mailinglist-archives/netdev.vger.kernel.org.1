Return-Path: <netdev+bounces-55876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7375E80CA14
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1442BB20C9A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD73B7BE;
	Mon, 11 Dec 2023 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFxB93GC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D17B0
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:44:59 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2866fe08b32so3066543a91.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702298699; x=1702903499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4421QceDydkt+j0ETwthXb1fAF6qELgTth9PipyBt8=;
        b=HFxB93GCcORUhCxe8fE2vEr9HYl7hKWsdBQAoP/GFniQDRV5piwyzn5R5uaF7Z9iwG
         M3RA+xC6ZSC4u8XTz/OuLNBqkaA4EgIdvNNjM5uJa1Z4/DP77F0+VXWyNd5doMa0WEkJ
         xkj9hW4kFrd+ROT8S9iWFjJYoaLudXGeMw3Hpzp47tjwuAECsIitgW4Rz0FCHLWyygG+
         g986xT1o6bX7oDoSJltGOylcbwN/DnKBT1YYjeOQPB0OBO4Od+Em2aaRWPEHkbl1Faas
         OGphD1pWxfrtWJ1QlbefPAHS6O3DL2cP3NFLf4wbIgh+zmx6CxhOj40t74KClCGp41uE
         ekWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702298699; x=1702903499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4421QceDydkt+j0ETwthXb1fAF6qELgTth9PipyBt8=;
        b=AlsXF8qtKLz50pAwBx9Z8oFnRqMbtrLq645V0crX9SEj8+uYw+QKPDl88hBAv6TSsY
         x3RyS/HR9jCRJkDMqAaYTnIDX/H5om4GznF8BKQTtIQV7OVh5/i8dbyncpfZjrGMSq8D
         dM3sz597vDGoWL5spg/5nJQhUnT0IupXr4pRmtAYi6oM6GqqIJqNONTkP/nvDUvqNhrT
         YeZTgpHT8Mcj17CRMZXlnPBCU470hPFHG732FSoW0GTiZuAjLTJ2GSyNnzHQMULSFFYZ
         RblB2qHcEqwWlYL/oB/TmPWZTlnKsuoN5Eant6qleLSCGCSyIl1AZib8GbJdgmdZcXBD
         Y8Tg==
X-Gm-Message-State: AOJu0YxNp0JJsPazkqF3joW985AB9GKUK4HNqy2hpryPi1jgI743T3nE
	vC0BWKmmt1yNSbPEhm+kPZU=
X-Google-Smtp-Source: AGHT+IHck91Ivd5zYacA7Jx2t7g4d927PTf1SsYzEWwnOsTfURj5PD/p8Wi6mT8w+upmlw+uwyWHDw==
X-Received: by 2002:a17:90a:ba92:b0:286:4e07:11f8 with SMTP id t18-20020a17090aba9200b002864e0711f8mr1754438pjr.21.1702298698818;
        Mon, 11 Dec 2023 04:44:58 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ls12-20020a17090b350c00b00286bf87e9b6sm2893878pjb.29.2023.12.11.04.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:44:58 -0800 (PST)
Date: Mon, 11 Dec 2023 20:44:54 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Message-ID: <ZXcERjbKl2JFClEz@Laptop-X1>
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>

On Mon, Dec 11, 2023 at 01:01:06PM +0100, Petr Machata wrote:
> The commit cited below moved code from net/forwarding/lib.sh to net/lib.sh,
> and had the former source the latter. This causes issues with selftests
> from directories other than net/forwarding/, in particular drivers/net/...
> For those files, the line "source ../lib.sh" would look for lib.sh in the
> directory above the script file's one, which is incorrect. The way these
> selftests source net/forwarding/lib.sh is like this:
> 
> 	lib_dir=$(dirname $0)/../../../net/forwarding
> 	source $lib_dir/lib.sh
> 
> Reuse the variable lib_dir, if set, in net/forwarding/lib.sh to source
> net/lib.sh as well.
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 038b7d956722..0feb4e400110 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -38,7 +38,7 @@ if [[ -f $relative_path/forwarding.config ]]; then
>  	source "$relative_path/forwarding.config"
>  fi
>  
> -source ../lib.sh
> +source ${lib_dir-.}/../lib.sh
>  ##############################################################################
>  # Sanity checks

Hi Petr,

Thanks for the report. However, this doesn't fix the soft link scenario. e.g.
The bonding tests tools/testing/selftests/drivers/net/bonding add a soft link
net_forwarding_lib.sh and source it directly in dev_addr_lists.sh.

So how about something like:

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8f6ca458af9a..7f90248e05d6 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -38,7 +38,8 @@ if [[ -f $relative_path/forwarding.config ]]; then
        source "$relative_path/forwarding.config"
 fi

-source ../lib.sh
+forwarding_dir=$(dirname $(readlink -f $BASH_SOURCE))
+source ${forwarding_dir}/../lib.sh

Thanks
Hangbin

