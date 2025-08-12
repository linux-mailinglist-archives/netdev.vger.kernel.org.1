Return-Path: <netdev+bounces-212670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A1EB219AE
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5CD420A80
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC782701B6;
	Tue, 12 Aug 2025 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="JVwbMtz5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA263596B
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754957335; cv=none; b=WNquy2fT3p+ALDjSr8PE3VplhBsiIpMZG9g28So1YyyXAFAZ6qH/LeQGDl3P7kxEWjz3rjrl4IYfkEKrNGsShRT8e1yO7evdhlQq0krP+4ZqZ6390tic4z/O5g3k5TUT36R3JdKPBVgdcLS7oQKTBAHP3ptcvwCtNYG7FK+qcHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754957335; c=relaxed/simple;
	bh=0uSSgyFAERcvMxmuhvDaQFKHG8ePM7E8bC8yCm7T21Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcPZQraCCU8aE2kpNuDJ0AVKKsIrwHq9ErxGh+as9X4VTu3NSQKasWf4b1xsP0oNALEdNBVn6QBxrfHhoPcM79wzstCM7YzZTuYytXy8galqjHvLSG3pXAS/m3SS7U/1B6OYZnbn42V4GwLQD/ZIjXaM9FtQAFqeZuA4UfgX1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=JVwbMtz5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23aeac7d77aso41499475ad.3
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754957333; x=1755562133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UJoVFj0ejQ3uX/IGEhsnvXF/6F029PsSD+iPN5zUso=;
        b=JVwbMtz55e9OlgBuhptBd2LIwhrhAP8BCBE9Ll7/981FgaDTifTa/W2NslSrW4FR+I
         Ioe6mKUjcG+wnTAd1dQAXf3I0SR3APWFOWE1ThYHUycXjjGC8gUlc8SNR0OsGXszhLWd
         ppBGBG7vFhbXxLKstJXL0IB+iL9WhINqKINYFZrcZMNNCsoFrpWmWsz4sPABBZ9IlwsZ
         +V2D1kFFWmsDJecI2mvuWppk6Q1fo6AGOB39VmEKFB1qFGQnFo82egmDLFPBBNAKOp3D
         4h9oF+Tl+lMaKtZ+rLD/wHT8smX6j2DYXxJXbDFAYy/JGw8vn4L+dmHeG790LwpyJtf6
         a2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754957333; x=1755562133;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UJoVFj0ejQ3uX/IGEhsnvXF/6F029PsSD+iPN5zUso=;
        b=u3pymfUBY/81Al5rRZYvQWiIJkCeWNIwVR9IoGqdOYaqu6AEntnYdQmJBViOW8qi7J
         G3HByKJ7iTgyHIYjAqP8AcTNtpGjswIzre/C5iY34FWuaWGqnIyr6fUcWCH35HMDWdBb
         BPJYVRAJSCP6WEN+kauCVl/XNS52gkFO9Khow7Cq/iW3Y22XcPCkSAnD6FQWGpzBJxC5
         6X7GHcdYkVC/eez/VVSEhOcyjkBW8Sf52Gta20Us4nFDqSsafMO8a30fbM+zi3QxX7IB
         85DEI7SeFmcwpdtTfvOEqDQRakq/jBQYmF6g3wtDscc42OsaM27dRlwZs8H5eHmYMnCY
         PjWA==
X-Forwarded-Encrypted: i=1; AJvYcCUeRGi+1iNmOCc/btRgHkvPseHtu9eVMRQqeq9etriO43CHpvZuBvvYjRVDz9iqqEywj2bfxFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlxi1MzL+oJSfMoLvBih66gQZ5yFkzW238/b31YFcHspSfBzcL
	j6IUXwtw3Tm/dCiM5LBFlP57JiuDZ+uFsSig+575zi3BjofEf/KcsNrHcDcRrED4r3w=
X-Gm-Gg: ASbGnct9KE2ZabHJPAAuopE0Fvk9owW5OB/CwBGLTYtFz+mE0AgwmsGaEBFIgY4nXXW
	wEgpkRfHm8RCDx0saOZQjyKQMSUw8z3RebhF71/FJE9gV4R3lEgRn6s5YZhsmFnd8A7gU95zjX5
	6BHTg28p03EUzF07Ot2v7M6OH092XocAFicyMDoBEU6kskR6LPd4KRomjtQeO/M5zWlubLpAtRv
	X3e92i7TQWnSu/qs9bH0hTLAuc8uO05VR42es/nv3WdCRjCIGgcVEnr71XPp8lTwHCQDTcSiYeD
	5LfELXq3is1r6VtivQNbrn0PHWZPCNbtHvSICikKjEgyGPmg4KNGr5ftMhLQ27vOCZTpsq/Sd66
	IvXPaoo79Yuph1hLEJLNbg6GQX+l3hKYHj91jmevAGRSItK0yHS+W1JpFjzkThQ6msqw=
X-Google-Smtp-Source: AGHT+IHKpcKLNIJaVKwMltOhMXMXlyeWwGFFHidaDoKw3udjWJkHoMZgcYXJGpncza0SxMnl/pWORQ==
X-Received: by 2002:a17:903:943:b0:240:6766:ac01 with SMTP id d9443c01a7336-242fc320833mr21315365ad.2.1754957333352;
        Mon, 11 Aug 2025 17:08:53 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242be41cc16sm98169005ad.52.2025.08.11.17.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:08:52 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:08:50 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, almasrymina@google.com,
	noren@nvidia.com, linux-kselftest@vger.kernel.org,
	ap420073@gmail.com
Subject: Re: [PATCH net-next 4/5] selftests: net: terminate bkg() commands on
 exception
Message-ID: <aJqGEvtKkIq9G2J4@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	sdf@fomichev.me, almasrymina@google.com, noren@nvidia.com,
	linux-kselftest@vger.kernel.org, ap420073@gmail.com
References: <20250811231334.561137-1-kuba@kernel.org>
 <20250811231334.561137-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811231334.561137-5-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:13:33PM -0700, Jakub Kicinski wrote:
> There is a number of:
> 
>   with bkg("socat ..LISTEN..", exit_wait=True)
> 
> uses in the tests. If whatever is supposed to send the traffic
> fails we will get stuck in the bkg(). Try to kill the process
> in case of exception, to avoid the long wait.
> 
> A specific example where this happens is the devmem Tx tests.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/lib/py/utils.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

