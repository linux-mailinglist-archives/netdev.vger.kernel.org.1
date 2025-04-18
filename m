Return-Path: <netdev+bounces-184119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A05A9363A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1D64473B5
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5A12741D1;
	Fri, 18 Apr 2025 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq0n1yP4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB12638B2
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744973998; cv=none; b=pcDfpwWcZutQmSLAhckryQ/GhDjsQ5sulG+RvxcpSuR5lk9ESb+gOQW0ppr2Q1ZEszKh3ZYUrnMlq7Mj4wp2IZT9XWxa9Dpsh7KceFCIYOcC2MPGnA9MpK2RP2WXWIBxUKMQ6a1KX4vEqN7f8Z9hEi1XcGxAS+vOqZo/h9bpDjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744973998; c=relaxed/simple;
	bh=YKKJTrTDUtM0OMviDTJW8YHqxJ7wDNkTV26gbgLyrvc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=c6GQRUlRn0XyPbYV8zyJCq9AkbOOCUGM8cLGtn8jtlWGdliAJS3CamP3ZvI5AZuivOnRK+yMWAHTR//O6vUaejQuBTVteE5oBJ+67v3+GmMBUU0RczaDGDPgi78phNZ8Cl5HzH06XX4ByOddrpfc5U10qze3ANEt9MERJEx4NaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq0n1yP4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so1089676f8f.3
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 03:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744973995; x=1745578795; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0MFopvdaIziPT+S1ZVRdGOJtd8iyjTMEgbye3ToyyA=;
        b=nq0n1yP4OxUK7IBvm7dbEXhVkLiCp3xMXIFITcJRz60okwIVeGi+jVFdb7WFehj0oX
         VWiRjnrbCNQIYf37AhTsev3dZ1GyLkzh/A7k5559tWgVENbgWnQfuR/m2Rz+PXKVeU9K
         pKZK7+oh5ch4Dp0CZ7NBBz2bAa2VDSpnVmLfQeFs5HHSh1yxPf160rYOwd0LDqmatU8P
         ByHdxpVpWQCrc2zet2RGnDDk1e6nb5pQ/66G+Pm0Iqnj0c8AWRv7QcgOUEJUjGopj3IX
         bPXzFcg8/JE9ggN/ok8yoMxgiCK8G3LPRbbjduiwT2ehs2PhNcU1q4j0p+fj8XPbRKuS
         dyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744973995; x=1745578795;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0MFopvdaIziPT+S1ZVRdGOJtd8iyjTMEgbye3ToyyA=;
        b=p0MQw8KkHTNaNjVPaD8NmSDeoRMCrMgq4jQkSI9T/xiymA1prJEgFTXJ4b6SWOBTz8
         3AmuSKaP0d5p3nw0yDfODrMu+AY/FTtXUgjJdUO0MEHt+9wuhSdpT/had9J1sriw1S8Q
         AxDV8kQ/M9FExbhzOR8TVO3am8+BnaLwbcpgRGt5spvx7wmUVvBRtvPNSa/Rsov+j9n3
         WT4UuusBBDbAZimNVyfK56oMo8wK0Qu/E7rExOXfsHLWGxd0cveOwKWOhlD9CBlEFstd
         wMG7FIwGgvQZ9g6oEV7jOl7Y1lp2YwJHE9ASztCugS4vJkIEmtgS5wUiwvA2hXvnPJp3
         NFxw==
X-Forwarded-Encrypted: i=1; AJvYcCWGXTSSSI6kXh1sfRs4rubXhUa4MO4VdQaSjfppUf2vvlQfEF9LmC9rTqyU2q7E9UaCpQQkZyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmN/R5CJcEBBo9M1T3hpCfkrBSZaWOXzJ6om6iLjAcFrPoxN7u
	rSaZV+K5Qyct0tmATiVTmCHz4GpCEnOAfkxa0AAHSHKqSKb+NtOr
X-Gm-Gg: ASbGnctG7qNduA6fAiJOvq8Lt4DjEGfeLF85QPFqM4pmW/vR1bq5Bs2VWwbn+2TT1za
	tYmC8wTRjtzPUeGrdFqK69Lec8LDZrwFygBcWxB2ujl5xaQJJ3LZumkD1M6jJBETJokDOsoUboi
	oRgbH2tXdPVIUvX60/MVxmUtC16AgcylRF+gZS+DMwQp85vYondAhZFChDkAU8X6f0wlXF/a1jG
	cFJ84C9Bu8mcaPXl2n83qdXsUdS71kA+Unn2EovFoJH/Y7bsPZ+c4PWDbOQiioZl356oEG6WPcM
	ZJTeKj56E6ogXaDRNp031tiduB0DmJZfONa/dR1xgoUFYaNgD4ngaCJFwcY=
X-Google-Smtp-Source: AGHT+IHQAb2FyesdxGHoG5jW7/nLYVAtRIdH9odsif+XXghBjHdBWMkIs/hlVMTxXfuwo/L6moMdXQ==
X-Received: by 2002:a5d:59ab:0:b0:38d:d701:419c with SMTP id ffacd0b85a97d-39efbace33fmr1583985f8f.41.1744973995193;
        Fri, 18 Apr 2025 03:59:55 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:24a3:599e:cce1:b5db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa3a1685sm2462263f8f.0.2025.04.18.03.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:59:54 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 02/12] netlink: specs: rt-link: remove the
 fixed members from attrs
In-Reply-To: <20250418021706.1967583-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 17 Apr 2025 19:16:56 -0700")
Date: Fri, 18 Apr 2025 11:27:52 +0100
Message-ID: <m25xj1kbmf.fsf@gmail.com>
References: <20250418021706.1967583-1-kuba@kernel.org>
	<20250418021706.1967583-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The purpose of the attribute list is to list the attributes
> which will be included in a given message to shrink the objects
> for families with huge attr spaces. Fixed headers are always
> present in their entirety (between netlink header and the attrs)
> so there's no point in listing their members. Current C codegen
> doesn't expect them and tries to look them up in the attribute space.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

I think my intent when I first wrote this spec was to list the fixed
header fields that are used or required by each op, not realising the
intended codegen purpose of the attributes list.

I guess we could add usage details to the doc string for each op.

> ---
>  Documentation/netlink/specs/rt-link.yaml | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
> index 726dfa083d14..cb7bacbd3d95 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -2367,7 +2367,6 @@ protonum: 0
>          request:
>            value: 16
>            attributes: &link-new-attrs
> -            - ifi-index
>              - ifname
>              - net-ns-pid
>              - net-ns-fd
> @@ -2399,7 +2398,6 @@ protonum: 0
>          request:
>            value: 17
>            attributes:
> -            - ifi-index
>              - ifname
>      -
>        name: getlink
> @@ -2410,7 +2408,6 @@ protonum: 0
>          request:
>            value: 18
>            attributes:
> -            - ifi-index
>              - ifname
>              - alt-ifname
>              - ext-mask
> @@ -2418,11 +2415,6 @@ protonum: 0
>          reply:
>            value: 16
>            attributes: &link-all-attrs
> -            - ifi-family
> -            - ifi-type
> -            - ifi-index
> -            - ifi-flags
> -            - ifi-change
>              - address
>              - broadcast
>              - ifname
> @@ -2515,14 +2507,9 @@ protonum: 0
>        do:
>          request:
>            value: 94
> -          attributes:
> -            - ifindex
>          reply:
>            value: 92
>            attributes: &link-stats-attrs
> -            - family
> -            - ifindex
> -            - filter-mask
>              - link-64
>              - link-xstats
>              - link-xstats-slave

