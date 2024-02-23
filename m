Return-Path: <netdev+bounces-74455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540EF8615C0
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBCA2824BA
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DCD86622;
	Fri, 23 Feb 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxIIEdX4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D0985287
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701958; cv=none; b=L+7Hf7X/IrYMVuDjzK4PXlyL9DTIqHwSZXVzbaSqQVlvMaxozL+k+kIt/tFslvMNSsc+4yPEMGiUnIPmMKenrBTTUBY3WOD656vwcffKBFYk6aGC2RNAK+VlogIIA04Cmy050lzA5+b+/dFHMtvQQc9u4vFSe478b6CR5N39VKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701958; c=relaxed/simple;
	bh=U16bzt1wwxPZlL7NJz6LuRgldZdqSORmn2YvCypZXbM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=atJK34gqUCBF7/nlfK52/3hnd1cxoIM0piPlMns8Z5Vb4LmgeIZZcP81VwYXptQWRpcKlMPZ5K4LJOddzIGCvHyV1B9Yl7TWiZDgUCAVthcqovMD0bcxvEWqcwLrS8FXy2uqDIl/i8CZfA+sZScLj74h3PYhZ2vKLOfIPMi4na8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxIIEdX4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d09cf00214so14226871fa.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708701955; x=1709306755; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U16bzt1wwxPZlL7NJz6LuRgldZdqSORmn2YvCypZXbM=;
        b=gxIIEdX4vxbEVLWx3KZXhA0NjmnpOIFgJGmQ0Ha98prSTapZOXoZ+vByXDRBuKZaAK
         ecZy+Gxp0niIj47vLYn4hof189XJp6O4jO0UDn//kHq7jt7voi92Ae+e22Zj4KTt8gYM
         fPt3InaH2XpKhA78pHe8GeBtcRftKD9A1hwa+4TNSkL7CL9ymlIoUoY50p0P1aWsble5
         1OVce1fScmEKPO9rCQE6hYVJ2gImlx+QTwB3HJCqPu2GphuwmsykSrn+v2l0WZ65OzRc
         nqvVhaOYMXQjA4WOZSRywc9tdKcXbuloCZe5+i5GoyYI4N4rs5lG8Oq5EtUiWMrLItbz
         BXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701955; x=1709306755;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U16bzt1wwxPZlL7NJz6LuRgldZdqSORmn2YvCypZXbM=;
        b=qpos2bwJ2Nb/E+OWZiWjx8ZDnggbgQxrxtB6h0oy008VK0KTwO3CpEv3Q+HCCIaCNA
         EJ4Bk6MHQcErRsNJ/LxRuSUc1ITwfEX0nq3Noebsvkii16E3LbPedGVit9889Ag3xEmd
         v0QdGafqwoJ9Ly0ogfsFuM6gHyp1QOSRsNj+pHoryXzBuCH0Hnzx5ONOGRhSfQlcPNyY
         SM/yK6qeMJ7qZO2R41azIc7RZU12cXTcrYgDVuByttFXY8xv+yEo4/wlD6z+L6YBfStX
         rVsOTQcZU1KO3bc07faTpnD2iUb1QqIPcKVQypGyLvEyu5ZWDXCTvoEq6KMHzhV2SdH2
         0viQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcj9XTXE9Zpul2BZdIh2TzGTRvlwxmfghocfcTTyuONkh2I34NliT7pwYNbpKRHNDbiFixfrZWZVZfTStG4uEliiHmhtKo
X-Gm-Message-State: AOJu0YxavSspCkrY8PCekhFJk3Nw0W3rkj/ZPADATgHFRPlXgC11aRkH
	pF5dhqQ3SrQ5ae88sDTyRizmOGB4fY4o/RrJzSVmNvVifVib9Uhn
X-Google-Smtp-Source: AGHT+IEm6E2uOYHXKC66MD8qUzikxPOzY3U39QqjqO5nW7p2SrbXz2cC9GIzaEoeSA1Czgxef5Qd2A==
X-Received: by 2002:a2e:9044:0:b0:2d2:650f:9587 with SMTP id n4-20020a2e9044000000b002d2650f9587mr141943ljg.13.1708701955302;
        Fri, 23 Feb 2024 07:25:55 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e821:660f:9482:881c])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b004128812dcb6sm2808163wmo.28.2024.02.23.07.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:25:54 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  Ido Schimmel <idosch@nvidia.com>,  Jiri Pirko
 <jiri@nvidia.com>,  eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 10/14] inet: allow ip_valid_fib_dump_req()
 to be called with RTNL or RCU
In-Reply-To: <20240222105021.1943116-11-edumazet@google.com> (Eric Dumazet's
	message of "Thu, 22 Feb 2024 10:50:17 +0000")
Date: Fri, 23 Feb 2024 15:22:35 +0000
Message-ID: <m24jdzqk78.fsf@gmail.com>
References: <20240222105021.1943116-1-edumazet@google.com>
	<20240222105021.1943116-11-edumazet@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> Add a new field into struct fib_dump_filter, to let callers
> tell if they use RTNL locking or RCU.
>
> This is used in the following patch, when inet_dump_fib()
> no longer holds RTNL.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

