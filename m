Return-Path: <netdev+bounces-258305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INMuBoSqjGlasAAAu9opvQ
	(envelope-from <netdev+bounces-258305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:12:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6978C12601A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17E19301544B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A627433AD8A;
	Wed, 11 Feb 2026 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Selyb0+b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C833A9F0
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770826369; cv=none; b=pWEbrNGB3hAqgbXC2IVfo/QXPdp4aWKUrVIk+iZwDuB0sDBeqLwdvOkot7uUJDYSrjqCO7u1E2x6f+IPA8IYFS0phqg7eswwaN1E4rAwkV/8HlZoILxgAfdFYftqI3y/Hx3LqwkB+LBRE02PaRMC5p5/3tBjkcugFTSXSA14HMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770826369; c=relaxed/simple;
	bh=YfyKlrHr9QiTgM+Mcak+HxfaI0DjSIS6AFuQXgoxPE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTZNDGFA8Tf+6dULx7QKmk5zj/PssyCmmV9eglUAvTQ6gGNMAojPbX0de0nxoGFJ3co8HSZyQEwsNcXc8g4If0GDo6+Di6nSJWgyE/jsrXTNwBo7EV65poSZVb3MHHn+8bIW5rTvF9bF+xrpOleB7JT5UQxm3yE9cl6v283osEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Selyb0+b; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7961e04355cso57217017b3.3
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 08:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770826367; x=1771431167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cioNbv23dB1H9pzfjOdfIDvh/3KlI1EV/iV1xJ+B8Ts=;
        b=Selyb0+bEefJsdvooaz20iDzr9EXYKsCg1mQhZedA/ahDFTZ40UaJoKo4y3W/L6Vka
         RQePkw1Mwn2iK1w92WXJOhUMQsPL5TOGJ24nowZY/3Nb5mGPqcdBQYNTZbV06xKA9Z4Q
         HuU2E63WrKh1PUtAJzx/mHZvicO4mgkMsewxs0mGBdxzBUeM/O6cdge/Shc4D7iBIGcs
         qf8hHvWsiWMdcubEX0hN5bcsFcI7SSnrfP/8Q0GXCxHnu2D9skn9nNaRg2CfCMLFaWLN
         rHw5pNbfJdXvMYTsgqwQ3dzY9G922XuXed55dQMP/cDljUmIN3/HMtUw3Y9GCDyEsT9E
         4KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770826367; x=1771431167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cioNbv23dB1H9pzfjOdfIDvh/3KlI1EV/iV1xJ+B8Ts=;
        b=scC2i4r+kR+mepgxk8hx2yqMpt66eHuTBGK76LPNe+H5255hyV6RA1h71MgeFcBhkA
         hTnWlDhm5HYi7UNl8mYvp72mtiu2RIrJ8CMoYt1jTgywhvtrLEYQ1a0ZpcBXZTcJziEc
         2JOQJjyp3OkY71VrSzKYFx9enQPuQ4IzCM94tKNTZKPBJfM9GyZx19AqltRiu8w9yaCd
         XDEwpnWdOWsfyHDm5hGqdP+VL01yUB76ih7MYM9DQO9UtHOzwHF5NMam9JjRGOr8ECVG
         TEe1a4oeh6QwaK8x2J/Mo6o9jwq/ygzZJOQKXIrRzdw8cljRlcn7xtEtItMp2c9jb8gm
         58WA==
X-Gm-Message-State: AOJu0YwMG8mC2NaTc9RsagBLAao0QR5ahDiL9vCOrJTAuW2HcdNcQXnL
	wI/miWUXKYSSfwmMStrdpMp1Ery6aHw8wh1cjEa3bSKrCNQFV2UJrO4p
X-Gm-Gg: AZuq6aIxUwsb85GSH15Y1Nw6oLkd+C81MjjzJu/IbO4XIXZ4onvglMfKNQU3+d2K+rC
	b77q/Z34QRl/2Bh4A/fsdQuCCrkKeh9VzfrdV0Eaj/QB2KZyNK7p4AEwh8a2p7ts+ZPc4tkI658
	WadOkZ5VFY2trHKfkceX9iLVuvpP356dOgX2ZCmKYnn7NpehDDfqOTcCxQKTaZ/nSJLqnh2tp0X
	hctx70Urs5C5Ufp/BI9JQu56VbDRY2L4m1VaFPJRZMOIa9C1VCBo7j2kv4AZ5iXUZc1GCqSw/R8
	nZFM7yVSy5aAU3pqa4+niGlVhFg1II0UzMfbjf3akHtlOk8wTthzxfkaptSwTbS6DdUHzs9BYMf
	BnkTjVnC9Q2P3WgjJs58NNMt/TPYvjoUYf3B92yePF6BakICu0YFmRTADyg85il1GBK4AyKN/ow
	7O5lVvrXd2sTgcaPbM+wlc7S3TmFIACseQiao0yLTeRP/u8Dc=
X-Received: by 2002:a05:690c:893:b0:796:4b03:73bd with SMTP id 00721157ae682-7966a9c461cmr24603477b3.31.1770826367152;
        Wed, 11 Feb 2026 08:12:47 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23e4bdsm20097507b3.32.2026.02.11.08.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 08:12:46 -0800 (PST)
Date: Wed, 11 Feb 2026 08:12:43 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>, Wei Wang <weibunny@meta.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next 2/4] selftests/net: Export Netlink class via
 lib.py
Message-ID: <aYyqe+R6EHlj7m6+@devvm11784.nha0.facebook.com>
References: <20260210200419.3555944-1-dw@davidwei.uk>
 <20260210200419.3555944-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210200419.3555944-3-dw@davidwei.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258305-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm11784.nha0.facebook.com:mid,davidwei.uk:email]
X-Rspamd-Queue-Id: 6978C12601A
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:04:17PM -0800, David Wei wrote:
> Making rtnl newlink calls requires constants defined in Netlink class in
> pyynl. Export it.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  tools/testing/selftests/drivers/net/lib/py/__init__.py | 4 ++--
>  tools/testing/selftests/net/lib/py/__init__.py         | 4 ++--
>  tools/testing/selftests/net/lib/py/ynl.py              | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
> index 8b75faa9af6d..a18e21069f7a 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
> @@ -19,7 +19,7 @@ try:
>      # Import one by one to avoid pylint false positives
>      from net.lib.py import NetNS, NetNSEnter, NetdevSimDev
>      from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
> -        NlError, RtnlFamily, DevlinkFamily, PSPFamily
> +        NlError, RtnlFamily, DevlinkFamily, PSPFamily, Netlink
>      from net.lib.py import CmdExitFailure
>      from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
>          fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
> @@ -31,7 +31,7 @@ try:
>  
>      __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
>                 "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
> -               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
> +               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "Netlink",
>                 "CmdExitFailure",
>                 "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
>                 "fd_read_timeout", "ip", "rand_port",
> diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
> index f528b67639de..fec518c2a0dc 100644
> --- a/tools/testing/selftests/net/lib/py/__init__.py
> +++ b/tools/testing/selftests/net/lib/py/__init__.py
> @@ -15,7 +15,7 @@ from .nsim import NetdevSim, NetdevSimDev
>  from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
>      bpftool, ip, ethtool, bpftrace, rand_port, wait_port_listen, wait_file, tool
>  from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
> -from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
> +from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
>  
>  __all__ = ["KSRC",
>             "KsftFailEx", "KsftSkipEx", "KsftXfailEx", "ksft_pr", "ksft_eq",
> @@ -30,4 +30,4 @@ __all__ = ["KSRC",
>             "NetdevSim", "NetdevSimDev",
>             "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
>             "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
> -           "RtnlAddrFamily"]
> +           "RtnlAddrFamily", "Netlink"]
> diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
> index 32c223e93b2c..a52b067f7589 100644
> --- a/tools/testing/selftests/net/lib/py/ynl.py
> +++ b/tools/testing/selftests/net/lib/py/ynl.py
> @@ -13,14 +13,14 @@ try:
>          SPEC_PATH = KSFT_DIR / "net/lib/specs"
>  
>          sys.path.append(tools_full_path.as_posix())
> -        from net.lib.ynl.pyynl.lib import YnlFamily, NlError
> +        from net.lib.ynl.pyynl.lib import YnlFamily, NlError, Netlink
>      else:
>          # Running in tree
>          tools_full_path = KSRC / "tools"
>          SPEC_PATH = KSRC / "Documentation/netlink/specs"
>  
>          sys.path.append(tools_full_path.as_posix())
> -        from net.ynl.pyynl.lib import YnlFamily, NlError
> +        from net.ynl.pyynl.lib import YnlFamily, NlError, Netlink
>  except ModuleNotFoundError as e:
>      ksft_pr("Failed importing `ynl` library from kernel sources")
>      ksft_pr(str(e))
> -- 
> 2.47.3
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

