Return-Path: <netdev+bounces-192474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5573AC0047
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA03AACBB
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3B123958A;
	Wed, 21 May 2025 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="OWHWMPz6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D002376E4
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868557; cv=none; b=A4iT9w788DvAYCx7GafC3VZ9i/g4N1bZEJnOtz5AyFj5GATngxuG5lw6PymWjJprEXWq0m/nkPJ3trdiNOFXeCo7GxiGCbLclgNoZJ9ilawZuWV7Sth04AIWonPfqIUodoRts1DFIpsYmadciXKXSGf+lIVWln+APL+at8xxE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868557; c=relaxed/simple;
	bh=CZYyj01bADr0LlDDpRAwyMGVyE8GMm0G5qJ5HCakroI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnX3rs8dWdScnYOMPlHP1N7RxR0E6FBr0GlslXh7XaJDAfK6IyrmJ7tVAo/xosiH3EJwMeRSa+nhWieA3Vokxis4/SuNt96e0lOw7sKNzrJDeYEm/z5625kN85WESSGOKf0sA1/wmDRp1BeOpuk9f4UzLWHW3se7ud5WPiTuF1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=OWHWMPz6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-49b3b0191f2so2965381cf.3
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747868554; x=1748473354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zLwug4uI+PE02xat/Kemu8WKBjO4HhVajXJFphtRoKQ=;
        b=OWHWMPz64ST7pZRLZ8pTU0GNT0eHTzoaF543VpVgHqdppoM4uTKKlR/tn9pCwK2Z1+
         Ox8YzbHUjy4bRVefggulXJAEz0t1I3Vi9amvcMdj8wlihY/QBRVKAa70lFKf9g2ZFHh/
         QISli1BCtffhxZMbHU2uJic8i6oblQdb6mqd7aoMNj6Ln+8Ng3Iy61BqA6a8btMg7LwU
         QjjXBo2o7tC+1lCx8T9fRSM12hYwAFqnELZKvNASZF/xnlrZMP/3CHBU5YXB6ixV6C4m
         Ked8ldeKpn6tigrtIEb7hrNo6767afwQ7urtirNHGkmrf3VDiAA2pSIqdw308N4LfEvE
         sLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747868554; x=1748473354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLwug4uI+PE02xat/Kemu8WKBjO4HhVajXJFphtRoKQ=;
        b=JMj18w6guw/uTiYY2KK4l6IA/RF4zXu9HBt1/0q1Kh191XbAuYZJNWSFaJET9RGXmS
         w2pKTlPeRwg0rOICcZ3sAbhe6zxDPbXvTCRT79xWdXuPjISS2K4lwe+AjgAYxdOtnLJW
         B96i3iDkz6SkWz+x2p/54a9Qz3EcqE2XBdDk9dcNefwIfm/RIM6S867FxTDvbUoRRhX6
         PkAjUzROq8E2RTU+RpcgmbYeD9xIiM3DBCm6XXsJGHGujy0BbpDmnT8yhevCvW81s1PA
         nJ1qrCqW+DESGa7pj/hirft7fX/C1a58HnXHeUAr4nRRLO4MZhkLXhW7BTqvteQXlqjX
         CYQw==
X-Forwarded-Encrypted: i=1; AJvYcCVX9pC2bwvf5NOnSDQapnXGyS4SUm+uAiHzq0T7ATEkhVy9PWe2vEo0fRcx5tNAhPgOHK1jrJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrb/U7P4dO0c08p0flh4vyN8FMT5Kl7rGyIF+Laor7sTEmVIMH
	3OaU4217YzWalXu3dR6ZQkYsEkA5aO/Iz4asz7XmRQgpcZPhmILcV5Ya46qFQ2KMLwdvRl5eK0Y
	CXaQvGX0=
X-Gm-Gg: ASbGncup+UhSzpghSl4JVAAE8368lNV2CXmhp+b4sASwlxLGH9uLnr4kcWOYJQ1r5be
	CD3ECac9xY0g5iwURDoysnZzp3kXQYo0sTEZL8A19E5ozk+mlSTReoQlZGe/xkoYMpdOtijspCA
	Zjo6Gz5UrW0MdzTSs3QH71pLhNRhXi8oQ2HCYeXbqCGDF23nxVjplaZOPNjij6SuQMXtzp6Fgpx
	WQEiyAjmsizOUIu3A1oBA8bb3h+Flg4I3b1KGLqxbvsXBBN9FTDIYuDMb1fwfMpJQyz/iTsv+ls
	QCeZChKN8W0XOY5Esl9Vmasakm8SesmUZ9gkdAjIvKlpzYfF
X-Google-Smtp-Source: AGHT+IGaVwRAlXksUBzIk0Uq2tvI+7fx3TLZlTGz5dWWXGV+yRwnuSWsBjlGfnOWXaUlWhJkurLG8w==
X-Received: by 2002:a05:6214:f0c:b0:6e4:501d:4129 with SMTP id 6a1803df08f44-6f8b09398f4mr124884716d6.11.1747868553932;
        Wed, 21 May 2025 16:02:33 -0700 (PDT)
Received: from t14 ([2607:fb91:1be5:f4d8:99e5:a661:f426:884c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b47e38fcsm85993426d6.56.2025.05.21.16.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 16:02:33 -0700 (PDT)
Date: Wed, 21 May 2025 16:02:19 -0700
From: Jordan Rife <jordan@jrife.io>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RESEND PATCH v1 wireguard-tools] ipc: linux: Support
 incremental allowed ips updates
Message-ID: <vq4hbaffjqdgdvzszf5j56mikssy2v2qtqn2s5vxap3q5gi4kz@ydrbhsdfeocr>
References: <20250517192955.594735-1-jordan@jrife.io>
 <aCzirk7xt3K-5_ql@zx2c4.com>
 <aCzvxmD5eHRTIoAF@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCzvxmD5eHRTIoAF@zx2c4.com>

> > Merged here:
> > https://git.zx2c4.com/wireguard-tools/commit/?id=0788f90810efde88cfa07ed96e7eca77c7f2eedd
> > 
> > With a followup here:
> > https://git.zx2c4.com/wireguard-tools/commit/?id=dce8ac6e2fa30f8b07e84859f244f81b3c6b2353
> 
> Also,
> https://git.zx2c4.com/wireguard-go/commit/?id=256bcbd70d5b4eaae2a9f21a9889498c0f89041c

Nice, cool to see this extended to wireguard-go as well. As a follow up,
I was planning to also create a patch for golang.zx2c4.com/wireguard/wgctrl
so the feature can be used from there too.

Jordan

