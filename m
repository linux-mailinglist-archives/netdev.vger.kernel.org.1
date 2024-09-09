Return-Path: <netdev+bounces-126339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349D970C0F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 04:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEF31C21A63
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 02:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384D91AC886;
	Mon,  9 Sep 2024 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7rPlLAR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333014277;
	Mon,  9 Sep 2024 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725850499; cv=none; b=DGfHTILWXeIdckNAf3enBchVyLhpClyaEAT3reJLPB7Z2vT1AiCPGkAzfF/0HOonxyHcVjaH6HYbGzKsbSXHxgueLSJHCJXejuc4LABE+vxBpH+aEBty1vBu56dFWAkMO2EXyd7MLQgW63d5gFZshbtNFXfiENNWJnVng531RcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725850499; c=relaxed/simple;
	bh=+H+M3ENHF8DeJz871/hlq4SMcqVAU6b8wD4kL6PNem4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gHXPMj9MpXDeo0d05YGEyneA7t9MIlxu0nn9yOnkL1oREpQTEgNjTuGuqzj6+kJYWj3dsIXlZOHw851cbK1KxJq+M4TEckvtfBP/tKQw2dHAmQEiMLYMR+/ROsiDXyAHsLb1wCXs2Pom8oNMBdzH5TteakC0MrG3XKvlAQVh/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7rPlLAR; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c35a23b378so26905976d6.2;
        Sun, 08 Sep 2024 19:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725850496; x=1726455296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYKf2iGU8oDDbFampRKw0Ks3iwulGNXwMhS0x+IoybU=;
        b=g7rPlLARr7Msok8+hyv++dPSPRjKvSXKTAOlmSyi8l8AXJ/GjBq+v6Qdjx3zlm5D1l
         K4QYUxDL1IMTVsKXh7T9GudB8b1YT71Uya3hJxNcmOLaMg5R7yny4udIcbhl1PASOp3S
         cIppadqhQNbKMy/3NPv4XaNvHpvS5fYQl45kzo8e9ZOP4pf59qQZdhzSqCU8QdklxQmJ
         LLpk8MQfyuMkbhp4zNT6101jLj1ytGvRDz2o5Qvs5PwlBqBUvH0PcNE5cNzOGP7Zlo4e
         xOzFfjoKnQ71TJwKGCjySWEnnEJwD/b3ZLdnzR1uciFw8keLa4ghfG8z/8Tw0/9jJS/A
         X2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725850496; x=1726455296;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NYKf2iGU8oDDbFampRKw0Ks3iwulGNXwMhS0x+IoybU=;
        b=TRieahdFssuPkflZCymvIsIpId5d46W6gOuHXipx1eXoDmlCIBvm8zzu1wORf8SgGb
         LpXJv1vsILml46L9ZW8vGZ6ff85OUftLgOegfWYs4JK8hmBqkdZP5UHNgWrpJClrBtLb
         LJyJXPkLXLjVf0T3bv+xfEO/auiUU/gXMwmLGjH8c9eGTdmLmWTxo24zM+DB6q5Mjgqc
         ODI4eqID0ZxTiP7gHubHYKrQPM0sEz2B7MoKS/oChoKBQX8rUa41c9NwJsaE4JWIAuln
         +Fc3V/bFBmO1CArVgzf2DvlQ7meOm4nsle4oLOeQaZ2P3nPA16TPgkmLaMPD6oDbh+d/
         zLbA==
X-Forwarded-Encrypted: i=1; AJvYcCVHCZuTYJgr/+9n3JAIcI40/L5GmlZAOTD6bB9KGFPYCC72IMQx859qvxUZYcZ5Kog248KXnd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYN+puNCmgvrFVlP+a/fyHLohjp0cFlmmxeRxnPjvfTGvBzZ+o
	UMAnR8JMQPlx9AeK1N+sNTXgDv3Hwx1+so2DB+4ISsQ+feYY4NWWCCGlJA==
X-Google-Smtp-Source: AGHT+IEGKo8ck2j66sV3v3W/W44c657fsAdr6qsZ0cbKCZRx3mB0dBzkp332aUoXzNEMpURZoYI3oA==
X-Received: by 2002:a0c:fa88:0:b0:6c3:69be:a3e with SMTP id 6a1803df08f44-6c532b2cd39mr92696136d6.43.1725850496260;
        Sun, 08 Sep 2024 19:54:56 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5343470d3sm16731456d6.67.2024.09.08.19.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 19:54:55 -0700 (PDT)
Date: Sun, 08 Sep 2024 22:54:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 corbet@lwn.net
Cc: linux-doc@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66de637f78072_bb412948d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240909015612.3856-2-kerneljasonxing@gmail.com>
References: <20240909015612.3856-1-kerneljasonxing@gmail.com>
 <20240909015612.3856-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v6 1/2] net-timestamp: introduce
 SOF_TIMESTAMPING_OPT_RX_FILTER flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> introduce a new flag SOF_TIMESTAMPING_OPT_RX_FILTER in the receive
> path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
> out rx software timestamp report, especially after a process turns on
> netstamp_needed_key which can time stamp every incoming skb.
> 
> Previously, we found out if an application starts first which turns on
> netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SOFTWARE
> could also get rx timestamp. Now we handle this case by introducing this
> new flag without breaking users.
> 
> Quoting Willem to explain why we need the flag:
> "why a process would want to request software timestamp reporting, but
> not receive software timestamp generation. The only use I see is when
> the application does request
> SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE."
> 
> Similarly, this new flag could also be used for hardware case where we
> can set it with SOF_TIMESTAMPING_RAW_HARDWARE, then we won't receive
> hardware receive timestamp.
> 
> Another thing about errqueue in this patch I have a few words to say:
> In this case, we need to handle the egress path carefully, or else
> reporting the tx timestamp will fail. Egress path and ingress path will
> finally call sock_recv_timestamp(). We have to distinguish them.
> Errqueue is a good indicator to reflect the flow direction.
> 
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

I really only suggested making this a new flag, not the main idea of
filtering.

> ---
> v6
> Link: https://lore.kernel.org/all/20240906095640.77533-1-kerneljasonxing@gmail.com/
> 1. add the description in doc provided by Willem
> 2. align the if statements (Willem)
> 
> v5
> Link: https://lore.kernel.org/all/20240905071738.3725-1-kerneljasonxing@gmail.com/
> 1. squash the hardware case patch into this one (Willem)
> 2. update corresponding commit message and doc (Willem)
> 3. remove the limitation in sock_set_timestamping() and restore the
> simplification branches. (Willem)
> 
> v4
> Link: https://lore.kernel.org/all/20240830153751.86895-2-kerneljasonxing@gmail.com/
> 1. revise the commit message and doc (Willem)
> 2. simplify the test statement (Jakub)
> 3. add Willem's reviewed-by tag (Willem)
> 
> v3
> 1. Willem suggested this alternative way to solve the issue, so I
> added his Suggested-by tag here. Thanks!
> ---
>  Documentation/networking/timestamping.rst | 17 +++++++++++++++++
>  include/uapi/linux/net_tstamp.h           |  3 ++-
>  net/ethtool/common.c                      |  1 +
>  net/ipv4/tcp.c                            |  9 +++++++--
>  net/socket.c                              | 10 ++++++++--
>  5 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> index 9c7773271393..8199e6917671 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -267,6 +267,23 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
>    two separate messages will be looped to the socket's error queue,
>    each containing just one timestamp.
>  
> +SOF_TIMESTAMPING_OPT_RX_FILTER:
> +  Filter out spurious receive timestamps: report a receive timestamp
> +  only if the matching timestamp generation flag is enabled.
> +
> +  Receive timestamps are generated early in the ingress path, before a
> +  packet's destination socket is known. If any socket enables receive
> +  timestamps, packets for all socket will receive timestamped packets.

nit: s/packets for all socket/all sockets/

My error in my suggestion.

Not important enough to respin.

> +  Including those that request timestamp reporting with
> +  SOF_TIMESTAMPING_SOFTWARE and/or SOF_TIMESTAMPING_RAW_HARDWARE, but
> +  do not request receive timestamp generation. This can happen when
> +  requesting transmit timestamps only.

