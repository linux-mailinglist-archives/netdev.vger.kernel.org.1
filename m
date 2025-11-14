Return-Path: <netdev+bounces-238725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922C8C5E3CC
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6733A9EF8
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3AC26E6EB;
	Fri, 14 Nov 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8Awmdgx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64162285C8D
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137415; cv=none; b=CHn24mGhYsdlhmn86DnftWO4n2dBpF8PREviD6ECOTkKAibqbcmBR2/fSnRmVsfmj8fiXPUKIyoEQYbLvTBFA98C9h74oc/8lZbYt4jSiuIhj09JANlK35NXjkcfGUQTGsMY18aYkorRoXpK4o4Ky9h+8n5V4rzlGhFD9lpKI1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137415; c=relaxed/simple;
	bh=08UMhVekfnzODHg258j6v7alIEul93sizWVdqDK755I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pewS3i7JQnMf8GlXJCjtTUPduRzAjNZ58RUivkNzxJ8UdEGy96S69N96Q7dchcQSn8g3AcylmBk1Q7MotLs2/CQKoETmmWAO3wRSd8GI21qpbs25lu/3fQ6K7SxfjhztzTHEi+B2kGaB3Q+YI/ttPF2xEJjTWtSpK5/mFxbvmYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8Awmdgx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3434700be69so2747452a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763137414; x=1763742214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/YlbrZzTl/MWfTO6W+9TMn8CctXsku7j8hxAqkLvD38=;
        b=f8AwmdgxSj9eznwehU65Xpfe113Vl494Cehacz8/OilpO2fZMb2QgIDXwhZ9GuJsMf
         NBtqlAHbhwf5XKXHxS+IEP5l9hEi4uhe8Hx6pjm3IkcITB4AY0c2AHaV26VO+CKyeMtU
         3D826JKSqgye5b8aizBshN1NhDziQBDyucTefC57YgG6za3U1DoWhqTvve8jp8avessN
         b7n1zVS2bX82OZzusK3r7Zdjp1TQsNbrOl6rIAyBWlIRofEieprgk3JouLKYjeMXJxe/
         TxlZXNRE7KYPJtW5nQE6DwTipfdB7KPozN7Y3M4xKLCI5ic7VmYvaR7ME0AmmwGgEjs+
         S5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763137414; x=1763742214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YlbrZzTl/MWfTO6W+9TMn8CctXsku7j8hxAqkLvD38=;
        b=H/XVTCOAejklXgpka4yZwzaGWVyqMTkvj8WbVG/o2h/SxYkOFXFlzb3A3yu84aUJyw
         GfnhRs49Wgu7vflGOISTSaA1YJ/03lf+wTWsiTzoa5cW7QB6eibyyo+Z01iZmVRWtXDo
         CPCjIMZDS6mG9YP88N/jnmaMJME+jzJuKqDd9SSanMHiqaOAfT680DeGRTaoJD/DEjoR
         8pMgjr/J5mAC0Zg3D06cVAjNf0XzIkXrTAevmwWyyBh9SjjPckWm3XO/rmdW4ASl42gU
         +j+kB0UE8adwumg2uMZVCu1WrV0o9x+TRGSc0/MhoNM9WiihweKhztUkb9aqvCJgvIb7
         9qOg==
X-Forwarded-Encrypted: i=1; AJvYcCWlEDV6lPCNsMPGJ+/owUoHggwSMGs1B0B8LnPV/X7B2v+g7IwTGmP4yuD6mKEhM95zEhdaNBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL04+APbAEmy4TJJPKGIzoZ2CuyOHUWDN3iRAdlrsJsX6UWhCK
	gZmwzo6bS2iBSX2blt4gz+ZJilqL7hWZksfmeH0sO+SdPbUFtOUIMexWMeIk
X-Gm-Gg: ASbGncuaAf/G+1bIVeO9VvFB/SAg6h55ToWSt248U55TIBlCNV+iDyZF1yY/LG5H/ox
	GEegZ68QPo7aFD0AwxF0RDNqS8/Ok3Kn+swps+OEO4asqbg5kHEL1ABRoibGs70RsOmLspOzEEn
	gZbFF1/00f5hGnBZln+RYankTjCS3Wh6GdXhcyXn62GCa00ul3TCqakbasmasdmbByIh/udApj4
	1aCwuPXCunnYUs1NaQjIkym7dcHqyE9lOxt5ZukbQ3XAqA3uWR83JBzVsqu45GFuJ8M9n04u7Jc
	6kwybnzMCRPPLMv2nD1O/3GZSZuBTMrwxCDL8y7gY2MdXaY1l5esn3Le/CxQyAtcqWP+pbaeZ9d
	S0lhbA7rzClk1qzTuaGdpqVaNzw+U8IMFMbJ2yxQhinQgduEUS/ISo3D33lveBLRJfIv1aSP2A6
	ieWb566e8aHzhmrB0cCJBPHYUVual+Ixs1e8z6Ie5pgCHjPAh1KfDC+WeDAEb/K79XXMpOJ0AfZ
	k/twhJIs8C60y6h7K8ox/xNZKsDtmuXjAgVbB6v7V9O9MsyREOrRoJHrsIZV55gZIg6tXPXR2vp
	wg==
X-Google-Smtp-Source: AGHT+IGmHmCEt7ubcY4pkEZLszbXZLk6Ci4T9fQqgSf5JbWXKIXcZ0Pqm/APxGewYx9HSHzcYBRGmQ==
X-Received: by 2002:a17:90b:2dca:b0:340:c179:3657 with SMTP id 98e67ed59e1d1-343fa7569femr4452805a91.33.1763137413401;
        Fri, 14 Nov 2025 08:23:33 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456511fa6fsm949975a91.1.2025.11.14.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 08:23:33 -0800 (PST)
Date: Fri, 14 Nov 2025 08:23:32 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, ast@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: xdp: make the XDP qstats
 tests less flaky
Message-ID: <aRdXhE0a-P3Ep1YE@mini-arch>
References: <20251113152703.3819756-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113152703.3819756-1-kuba@kernel.org>

On 11/13, Jakub Kicinski wrote:
> The XDP qstats tests send 2k packets over a single socket.
> Looks like when netdev CI is busy running those tests in QEMU
> occasionally flakes. The target doesn't get to run at all
> before all 2000 packets are sent.
> 
> Lower the number of packets to 1000 and reopen the socket
> every 50 packets, to give RSS a chance to spread the packets
> to multiple queues.
> 
> For the netdev CI testing either lowering the count or using
> multiple sockets is enough, but let's do both for extra resiliency.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: ast@kernel.org
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: sdf@fomichev.me
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/xdp.py | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
> index a148004e1c36..834a37ae7d0d 100755
> --- a/tools/testing/selftests/drivers/net/xdp.py
> +++ b/tools/testing/selftests/drivers/net/xdp.py
> @@ -687,9 +687,12 @@ from lib.py import ip, bpftool, defer
>          "/dev/null"
>      # Listener runs on "remote" in case of XDP_TX
>      rx_host = cfg.remote if act == XDPAction.TX else None
> -    # We want to spew 2000 packets quickly, bash seems to do a good enough job
> -    tx_udp =  f"exec 5<>/dev/udp/{cfg.addr}/{port}; " \
> -        "for i in `seq 2000`; do echo a >&5; done; exec 5>&-"
> +    # We want to spew 1000 packets quickly, bash seems to do a good enough job
> +    # Each reopening of the socket gives us a differenot local port (for RSS)
> +    tx_udp = "for _ in `seq 20`; do " \
> +        f"exec 5<>/dev/udp/{cfg.addr}/{port}; " \
> +        "for i in `seq 50`; do echo a >&5; done; " \
> +        "exec 5>&-; done"

TIL about bash's /dev/udp, interesting..

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

