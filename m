Return-Path: <netdev+bounces-81060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073818859AA
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ABD7B21419
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB51884039;
	Thu, 21 Mar 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NO8O8H4G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F185474D
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026588; cv=none; b=NJxR2Tf9kALZI53rczxIFqOfi5QGa4uIA++ibags6E7Ju9zAM0ikH38jzwZer5vWWoO/gNWeQtkzEWOdDbysUryz+maBuCPkRyJUPKRnATlbu1jXa6TKBk6H/MntvZHVwHk1wfL7/a7lAEk7J8mXlR8XXQDuAoEBfJdVnb5B+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026588; c=relaxed/simple;
	bh=PbVKPsffYFmxEJA1XYvBvrzU6/dGh2IFtbUeXpnCS7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVHqKuzDeTT23KOrbIbMf8ixnP6cRaoqsZv4wKfjVYnpdntmIsl5FSs1J0uw4bmOHN6NWOfVPmGsDcTQC/nqFBEGkIAHrD5SqX9NniZ6pA9VV8UJoKVIrMLPS9N4s5CP8HNCGbknldfmHlWnKtxeyq8LI9TPJayLBmNi6WKzq5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NO8O8H4G; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513d717269fso1241862e87.0
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711026585; x=1711631385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tVqnt2+40OCgkEXDOdVpYA4SPoTMaikFQyoQIW+DZj4=;
        b=NO8O8H4GDDgHoDw+iXsSQ/4s9ynOmbReJETdkAj1QBi6pP4J3kACzbW4UWyfw9+arj
         /HCI0NVl9Yk4sgIlyRL/GLEvNiHDNDvl8o1egL1Q+DQoAXkrin4Sp7IL06bJU3c/QwP/
         5CIMSjazyjTQWkgFiWeCCjIJ9TfJKF8vmEAtH7yWChR3Q165rnbC9+Fh1VA6i9jNHCdR
         hqvoaM5epJSClc9DyMu+LSvmW+saxVRnMC21csxjz8gN0vdHMqRUY4QOqeYsamb5YB0j
         I8JOsTc0MHdw7M9LblpDnri4gUGOaMTvFT9NUvXvXKobCsoT/8x2S8WYxwD3QrfwKnzp
         q4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711026585; x=1711631385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVqnt2+40OCgkEXDOdVpYA4SPoTMaikFQyoQIW+DZj4=;
        b=ACFter9Qp9S0pNOemQ8Nl2Cn0x6jDUFT9kNJOhlTKOL0vFaZQKBWox907/OcaHYpXS
         YcyAA9WGqGnq+l6CiAReJtXaSBMH90NwxjisrClUu3W2EGWwDW3Nu8O0SikQRkdvrvrb
         f9W9ON3z9BsxQvKxUvdDPZfN3++SJrHg4scazJ4k2V1mKcjw6jebeNDNyKDg9zw7SxPf
         NPzmUdu4vmturkiseDGIztZZcHP0g86aejrvVxR8F0PESJoDFKoMD+GWqo6bkM6vuHUg
         2hG3TPtc7/uVOxX+gQhT5x8na2WarSPvt0EZliXrWDmdBRFAkEjDGKFHGVXVckQS/+uz
         d18g==
X-Forwarded-Encrypted: i=1; AJvYcCVQLY6GiK20twCyZ+73pZEFpWxU/6GmiHLp3mxDoAta9NDhl4yFr0YXTwCDW9q5PIkYFrwFlfiJ1pbED6YXxGs/wte1hc9c
X-Gm-Message-State: AOJu0YygqfbFPKQ+uACysvr3qrucyOa8AAsHcY3dL7G7cyjbrPuPKaGb
	8EVXNUlgxaMFdGw91igV/NZckSGq4O/BDTqfWPkyuCJxS6GJ+FTnIAH4c46sXE4=
X-Google-Smtp-Source: AGHT+IFoxUwogxt2jW8OyxX+Q7X84NaLZXeb02y01FrPcmFmJQwtGUA2j/OumLiUYpeVff+Zpysujw==
X-Received: by 2002:a19:3856:0:b0:515:92fe:4356 with SMTP id d22-20020a193856000000b0051592fe4356mr974126lfj.2.1711026584869;
        Thu, 21 Mar 2024 06:09:44 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id z1-20020aa7cf81000000b0056835320f76sm8107371edx.8.2024.03.21.06.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 06:09:44 -0700 (PDT)
Date: Thu, 21 Mar 2024 14:09:40 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] flow_dissector: prevent NULL pointer dereference in
 __skb_flow_dissect
Message-ID: <ZfwxlB9vkI9Y88K8@nanopsycho>
References: <Zfrmv4u0tVcYGS5n@nanopsycho>
 <20240321123446.7012-1-abelova@astralinux.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321123446.7012-1-abelova@astralinux.ru>

Thu, Mar 21, 2024 at 01:34:46PM CET, abelova@astralinux.ru wrote:
>skb is an optional parameter, so it may be NULL.
>Add check defore dereference in eth_hdr.
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
>Fixes: 690e36e726d0 ("net: Allow raw buffers to be passed into the flow dissector.")
>Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>---
> net/core/flow_dissector.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>index 272f09251343..68a8228ffae3 100644
>--- a/net/core/flow_dissector.c
>+++ b/net/core/flow_dissector.c
>@@ -1139,6 +1139,8 @@ bool __skb_flow_dissect(const struct net *net,
> 
> 	if (dissector_uses_key(flow_dissector,
> 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
>+		if (!skb)
>+			goto out_bad;

Please read my recent reply to v1.

pw-bot: cr


> 		struct ethhdr *eth = eth_hdr(skb);
> 		struct flow_dissector_key_eth_addrs *key_eth_addrs;
> 
>-- 
>2.30.2
>

