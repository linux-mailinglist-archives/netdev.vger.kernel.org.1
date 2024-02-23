Return-Path: <netdev+bounces-74451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B2A8615BC
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9677C1C23F60
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855FC84A59;
	Fri, 23 Feb 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9iG1jYL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6584FBA
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701953; cv=none; b=srxmhMSfXUzVaynyCYAAhBT0Wbt/wOumx5x0b0VSu/VzHE9KATvnfq32fpwWuSUAtWrbvjT/V+4QiNcIX8UZ02fvpYKg9fShdIyfUJKol+zEpR5zIWAl29ulUCFBw5xkERumpnrAY5wsM/W7F5mzDbLw9hFMT1YN6rPm0+yoQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701953; c=relaxed/simple;
	bh=lXodmuSVM/xE6Ous66EMQEnG7TmmQspnTboZXFCSJfQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=SG3xM+ZkhOuEM0ht3l0Gs7h4Co45vCMYdQUZf3T8u9JYkQv6K6qi5AgCSbOM4Yu1TcyGRWJrdwhF5H8M10y0xWurw/Wo4Qix5yFNuJDjvotp4D2Xfaho3Sov6+9rpPdhQY2vgo0ttHcVpP1Eojwcp3Vamv9ya1Go5Nw8TtjH/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9iG1jYL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so15908401fa.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708701950; x=1709306750; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lXodmuSVM/xE6Ous66EMQEnG7TmmQspnTboZXFCSJfQ=;
        b=c9iG1jYLtaU2HrOjrV0TLdJKix8dHtAszME9QMT9TYBkiD4A9GJeH7VSoJ4+NhKCCe
         qJbBz/NjnpNuLhJ65FXBwGhR1e3eGV34aht0lMzxkHIQL7cnYoi6axn7cL6rIE4Jxfoh
         EBNyb7orR5kH8pXstj5Y7W9gpwhSxz10oFgKIZG2VRgwIhpjRooQSthjhysunxHtiV/O
         DCb5OD9Y9T//7ZwSYK76ZHDnuRSdDb/rWIboDK6vsIdAjv0GW23zNribJAqaKDqMMKTV
         1IqdDwg5lXqbbbIo4IJELD/AtSU23OsS88Y7bEcLqbMM7M6D4AT/oN/pzFP33OZDBT0X
         pBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701950; x=1709306750;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXodmuSVM/xE6Ous66EMQEnG7TmmQspnTboZXFCSJfQ=;
        b=EpN3+yFxDTHHrdhEA16AbZsufbsDPiQuP4+5OQQbNm9XrYuzBX/6f2LpgpZAHPtGj5
         YPAJU04pPb5D6KwB8iDGgGfUgIkECE7HwrRoPaNnWSrDbisGG4ac+onyYjaOsqpv/g19
         ajoMAKWKjVRW9Doh4ma3Y9VyUlWyULrPoib+0FY9dN2+LZzpX7f/1ezjtoS72K/NSwoc
         lCcQLWOHTSdLlDnrw8A7M4phs/z8LYnRessNJ9NZvcKiQKFJbWQxM4LXs3+6i1fH79VT
         SdCBgZeJRmKU7UKuu1SUL3l03sWqyeQtAg4M7jS8qEZ/5zHgZiEOohO4TVq5t0iNh+gy
         ObAg==
X-Forwarded-Encrypted: i=1; AJvYcCVz2bz++JcTyF1bMaDEzNJ2/PS68HLeHE11B/jDngGM8Nel1mXewmT/0QepXcbNRPWQ4aS1K2FQX/3zmLEKSO+ede1Oad/P
X-Gm-Message-State: AOJu0YzKoQxc1e/ISR3gKoG4GFUYRZvyvykeJg2KiSe8NCqPyoCu+yyZ
	D+2dCUmhQXxbmBBOlLuOPpy79g6EQXdaY0KvvjdFJrhDBwBuR9lubu3tsaazof0=
X-Google-Smtp-Source: AGHT+IHVF59+8mTiw4CcB2zNdxaGSo//m7nuEeR1htJVsTbOT8CvgkuGRvVxVBe17xikUZOtNabM4Q==
X-Received: by 2002:a05:651c:2116:b0:2d2:37c5:9947 with SMTP id a22-20020a05651c211600b002d237c59947mr131171ljq.33.1708701949907;
        Fri, 23 Feb 2024 07:25:49 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e821:660f:9482:881c])
        by smtp.gmail.com with ESMTPSA id bs2-20020a056000070200b0033db2fe4d76sm158915wrb.4.2024.02.23.07.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:25:49 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  Ido Schimmel <idosch@nvidia.com>,  Jiri Pirko
 <jiri@nvidia.com>,  eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 04/14] ipv6: use xarray iterator to
 implement inet6_dump_ifinfo()
In-Reply-To: <20240222105021.1943116-5-edumazet@google.com> (Eric Dumazet's
	message of "Thu, 22 Feb 2024 10:50:11 +0000")
Date: Fri, 23 Feb 2024 14:42:13 +0000
Message-ID: <m2msrrqm2i.fsf@gmail.com>
References: <20240222105021.1943116-1-edumazet@google.com>
	<20240222105021.1943116-5-edumazet@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> Prepare inet6_dump_ifinfo() to run with RCU protection
> instead of RTNL and use for_each_netdev_dump() interface.
>
> Also properly return 0 at the end of a dump, avoiding
> an extra recvmsg() system call and RTNL acquisition.
>
> Note that RTNL-less dumps need core changes, coming later
> in the series.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Nice to see cleaner code with for_each_netdev_dump().

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>


