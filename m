Return-Path: <netdev+bounces-129039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5422C97D14A
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 08:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89CE1F23BA3
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 06:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7973FB1B;
	Fri, 20 Sep 2024 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QB/yFY1M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA23979C2
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814623; cv=none; b=VfYqnZgSEP4yYpMfLBDQeYadzjp0NAQNGnLthrFcLWfTuj3e9FP/nj0pIJrxfx5QFsV12u0yZHBl3sh0DOppDTTW1v1L2Sj87nHwysABCFjKqNW2bl5jmuXrxcuWs2ED/Yu4TV1lhJOcuuHa1urdwKj5DhGv+O5GEBF56aE++A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814623; c=relaxed/simple;
	bh=sOxxjmVIf9DK1JAPwTVAbAeOHGayuH0y2cxXhJoEjJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cu37r9jKn0CwQs4RqIEdXYSasLIWkz6SPqrcGBjKaM+5CsEWbThlwCUMTpC4TCRlgwXQ6bp0quKCLnFYSieY/bk4+pINHZtp5aoad1HrY69x0Qg8xRoX06B/YmDMUoB/7RtOxYgPQz3qpjjozZdhkYzxbDrRsu8WiBA2p0cEPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=QB/yFY1M; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so2019129e87.0
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 23:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726814620; x=1727419420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LLaE4A8HWomqnZxKIsBh6iXXcm0J13/3tg8Vb7IGkgU=;
        b=QB/yFY1M86Pyo+0JMY2IrcKxjNPPaV/JKUA4jYV5ZDhiKcc2IeNxoGiAfPqIuVWmju
         zA3edRbxcLfJ3H3wtl28mU9XT8YvVsz9wD36eCwHqiujbDaKuIGzdGUlvGn9TRDu+1Eg
         3SCr+3IO1nzr1er4GN3DOxQbApbRzVjyRYcXx3/Y/KBPZc/wgyv4979jgEM79oVehAUQ
         e/UDKp4/L7B1hmywYE8V6Cu5dXwqNOwv0aSxZWYKThUy0Zc1+L8JS/prv8kAixQw7t1Q
         Oyn1hoM5Ar5pc30bHM+zLzhLYBR2YAkTXMz4hzgU0mVoPxKSdeH5YAD6FkCJddhREEf4
         6m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726814620; x=1727419420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLaE4A8HWomqnZxKIsBh6iXXcm0J13/3tg8Vb7IGkgU=;
        b=rwS8jQDMrbwkTrAIC6Eg4e6SjoETxy9ZJ4pqi+jSxbQ8UA3LHvXDMPomxmAxDYIEb/
         xFBZYDlnBrHfzYkZtKgE9tsKBkGyLJUvMvmx8EOMcTQleM+W/rd6A956IGaQxltcgRT1
         8X7IFpoEBwI4ug8jTVDVkHylJ+30dP0e2TPME/rlRQgM8SFgFyYrruftQj6bIYaiq8x9
         4J1vhROSqvf77fK7WLp1H1A+FBFo7Egi2L71sQfKQc/5zYJdI0xYr5UHyADI+oUv78O6
         I/heSBf6uE+5VZRrZE97naZo/G6b9Lneso1fpSKl/oU3cXSd4VCqXR7gZPvVvDY//VvO
         YGvg==
X-Gm-Message-State: AOJu0YwJA0/W8KdgZPOyElBOkrQtgJY2XEZFbOuzstm91VZ85QL6x55l
	dHVpaatXtqyeeGBFVw17TOlRLBWkBOPZWMCG+0gCo9SrrWiTIbi0vAXsCr+2bK7yYmgaC0o3Nrp
	C6/8=
X-Google-Smtp-Source: AGHT+IFYc/zDgQiOV93CNO/o/R1jy+aordDFcbQRV8R86JE7XcZO4DTMEjkiBq8Mwj3Lv/fNs3rUBg==
X-Received: by 2002:a05:6512:39c4:b0:536:581c:9d9f with SMTP id 2adb3069b0e04-536ad16b327mr692425e87.24.1726814619733;
        Thu, 19 Sep 2024 23:43:39 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90613304dasm797860266b.197.2024.09.19.23.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 23:43:39 -0700 (PDT)
Message-ID: <8dfc3125-b4fd-4209-89c5-a5a85a1d65a6@blackwall.org>
Date: Fri, 20 Sep 2024 09:43:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] bonding: Fix unnecessary warnings and logs from
 bond_xdp_get_xmit_slave()
To: Jiwon Kim <jiwonaid0@gmail.com>, jv@jvosburgh.net, andy@greyhouse.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, joamaki@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
References: <20240918140602.18644-1-jiwonaid0@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240918140602.18644-1-jiwonaid0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2024 17:06, Jiwon Kim wrote:
> syzbot reported a WARNING in bond_xdp_get_xmit_slave. To reproduce
> this[1], one bond device (bond1) has xdpdrv, which increases
> bpf_master_redirect_enabled_key. Another bond device (bond0) which is
> unsupported by XDP but its slave (veth3) has xdpgeneric that returns
> XDP_TX. This triggers WARN_ON_ONCE() from the xdp_master_redirect().
> To reduce unnecessary warnings and improve log management, we need to
> delete the WARN_ON_ONCE() and add ratelimit to the netdev_err().
> 
> [1] Steps to reproduce:
>     # Needs tx_xdp with return XDP_TX;
>     ip l add veth0 type veth peer veth1
>     ip l add veth3 type veth peer veth4
>     ip l add bond0 type bond mode 6 # BOND_MODE_ALB, unsupported by XDP
>     ip l add bond1 type bond # BOND_MODE_ROUNDROBIN by default
>     ip l set veth0 master bond1
>     ip l set bond1 up
>     # Increases bpf_master_redirect_enabled_key
>     ip l set dev bond1 xdpdrv object tx_xdp.o section xdp_tx
>     ip l set veth3 master bond0
>     ip l set bond0 up
>     ip l set veth4 up
>     # Triggers WARN_ON_ONCE() from the xdp_master_redirect()
>     ip l set veth3 xdpgeneric object tx_xdp.o section xdp_tx
> 
> Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c187823a52ed505b2257
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
> ---
> v3: Fix subject and description
> v2: Change the patch to fix bond_xdp_get_xmit_slave
> ---
>  drivers/net/bonding/bond_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index b560644ee1b1..b1bffd8e9a95 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5610,9 +5610,9 @@ bond_xdp_get_xmit_slave(struct net_device *bond_dev, struct xdp_buff *xdp)
>  		break;
>  
>  	default:
> -		/* Should never happen. Mode guarded by bond_xdp_check() */
> -		netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n", BOND_MODE(bond));
> -		WARN_ON_ONCE(1);
> +		if (net_ratelimit())
> +			netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n",
> +				   BOND_MODE(bond));
>  		return NULL;
>  	}
>  

Looks good to me, but next time wait 1 day before reposting another version.
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>


