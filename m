Return-Path: <netdev+bounces-74456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C716A8615C1
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775B528346D
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1B78663C;
	Fri, 23 Feb 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMfGM/r1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8D86130
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701959; cv=none; b=bJrg59NNLAn5/I8ldP8Z/f819Wk1r0DdB3vagmqSwONgPIoIhcSlqavmjbNHidfMPAZoSgGaj/tMNpW/HxAcWm71SoBPL14cLKQRoFzppeS/a31xnVEflrob6H5wxs8/vxoB44m23FVN0N1A78RoWvwqIQrR6AvOCn/3Lc53eG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701959; c=relaxed/simple;
	bh=5gMYHWz4my9RONLjo8Fhy+cYbHUo9UWwB6eUpjGiY/s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Mn5iZrF0kJZDIVxBceQ45pkORBJNs4zALMnyfcKbMt2+bnOWLn8j2+TzA1uoSX5h5kWVKHepqIWOZ4GhcBbv8tw5NVude6HsnFpH/b5njmMVfSOYJsTKSWyD4MtLWmAs49lpi7kkxbCdLvOrW85JUTEj3w5BCCwMynhXQYJA8Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMfGM/r1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41294af9ad7so3413925e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708701956; x=1709306756; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gMYHWz4my9RONLjo8Fhy+cYbHUo9UWwB6eUpjGiY/s=;
        b=KMfGM/r1aHbnYYWRwxL2oF+W1+J2chQZO05SNNQQZwTBIBdeR2rlk6sJzt6CfYRVAY
         TckrD/9cpan5ne8j4z9+luTZOA0cE6LLNMbZyZ+j0pA5H6bh0qCrjiUSkiMl71niyGHi
         izjIdnYu/nsnVKWV6K6Q3BC6jkg92oKIDkIgq/PT89O8vzyjFuyWGZzIbIZ4MN1Y1uy6
         vGSo0SdpY29QjMnIARdP3qa7rDcYDwE4LdCNYmHk49K/dQQeZ3cAm9YWu+ZWR4UAdHiD
         6IfXilxjpPntPWTAIhL8DZ6X8vs57TnFA53fT7fKiqZjFSf5h0VigwOcx65Drxe4PAPn
         bVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701956; x=1709306756;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gMYHWz4my9RONLjo8Fhy+cYbHUo9UWwB6eUpjGiY/s=;
        b=nFuqX1N2ftJ7uCSMIyGALFh2vTau+jK8dQRsWJnOq0fzV1JUp28BAkvvkQXlRySivM
         GkBST+AEBhnJpAncFsPZBwEKNmimil1+YvCyplmLPPTGva3dWaGN8y9AYG6XdGkUtD66
         AedSZgx4Yq+/V7VRHd++vjYGuPYXVteBEttPV4Y17L8G/golK5aS//V8C+e7eyB9YtqO
         hs+kA2upFGgigRD1zRK7PQ/Ta53XT0xBmw6rhpU3UZmIAKAGDrjztd/eQAL5/2xgV1JA
         x7FN+3uFcFDUTXuw2ROD9AkmliQHFYaLOwJIs2VKr91LmSUT0Z8IERQKTP+Df0T8j+GY
         ldmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4+F80CH+6wmSe06FNRePDKbaQDPQWUSu9OZ5Lm00yHr685sSuWUGH0Hk4eff6/q7EjRaV+dSAJJU3+d1TNxzfyM0d+kDI
X-Gm-Message-State: AOJu0YxQuOsTBNwQz3hchJk/m2YT4cp3JKlCo+TJvf7tFQZH8BeyJ2o/
	18DJcsTWtCpUnTmJ1AD15J03Dv5szwxgP6hOjlaU3l/vZhZQQlO1
X-Google-Smtp-Source: AGHT+IHCdlzw4sIF5r4VqqllAjjEhWwW7+yJMoWR7cgh5djzKaX3/Qd3iTok/xCTwJCjnkwL98SGxw==
X-Received: by 2002:a05:600c:35d1:b0:412:16d8:d565 with SMTP id r17-20020a05600c35d100b0041216d8d565mr111854wmq.15.1708701956619;
        Fri, 23 Feb 2024 07:25:56 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e821:660f:9482:881c])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c510800b004128f41a13fsm2910369wms.38.2024.02.23.07.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:25:56 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  Ido Schimmel <idosch@nvidia.com>,  Jiri Pirko
 <jiri@nvidia.com>,  eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 12/14] inet: switch inet_dump_fib() to RCU
 protection
In-Reply-To: <20240222105021.1943116-13-edumazet@google.com> (Eric Dumazet's
	message of "Thu, 22 Feb 2024 10:50:19 +0000")
Date: Fri, 23 Feb 2024 15:25:22 +0000
Message-ID: <m2zfvrp5i5.fsf@gmail.com>
References: <20240222105021.1943116-1-edumazet@google.com>
	<20240222105021.1943116-13-edumazet@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> No longer hold RTNL while calling inet_dump_fib().
>
> Also change return value for a completed dump:
>
> Returning 0 instead of skb->len allows NLMSG_DONE
> to be appended to the skb. User space does not have
> to call us again to get a standalone NLMSG_DONE marker.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

