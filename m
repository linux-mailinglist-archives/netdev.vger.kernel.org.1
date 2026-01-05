Return-Path: <netdev+bounces-247136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 444A5CF4D60
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D7AE301F3DD
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D48A306B3B;
	Mon,  5 Jan 2026 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/uyUUYE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE430B520
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632028; cv=none; b=LyrQxWRZ69LTXRvUIvMFR0w8UdILYJ+UMLgc7p2R3CZcZoki8ERgImKpOXx+OY5FgTUbVn6a3Cee0zv63WPeJUkgzJh39qnKkotRGXTgVRGSugKEqt9ZhSNpXBm24hdf7cNktem7qZKp7QyqeBi9Q45HJquJKZWhYJc0neWRl5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632028; c=relaxed/simple;
	bh=b646dHGOv+VV6aLwAkaxZ/Wf7u+I6uBXShgZx/JBC1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udCGnvY2i5xqPFj/Lp0k+sNyDPGYsgeDZpmfc7XL3NsW9JLIO7mbc5MllW8CoO/JW6dY5zRfPxcNSRm9aQzRwFLC4DwynEi42LQ7OzBEMwEO4FYZpxtjC5mmujAJARl7UBi6wDhydTjPyL9tFe6aiGQ41t1hc8bHMD6NN5cRXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/uyUUYE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b79ea617f55so29048966b.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 08:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767632025; x=1768236825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l00UN7SRVhBQC6JXZrocYBm/aaGRNA8NKJUkQbam+Zc=;
        b=c/uyUUYEkQKqmuVfIU9H6/4shBjRqZXfEevoZ4WpVBwOlvFEFnfHEtCZeaDhZp8vfL
         SNIJdktdQheFb3ElDCeXPH1UoPDGIzHS58vCs/mmlTT52xztyOrPOENHQWK8bni8QkG6
         mH45wyHtsPKijBh42qpI4YwqO+apOZlZWhn+Y5uw40eWF2xeeaEIYeeQBRFoObLYWc3o
         xLpmabk4t73NleTzDC0XIE3JvAtGv3W07CUuVzkGm5+efgftgs8Zr22tP41uSc4AYKKs
         WMs/X/BsZaPZSXJ7ksJa6GNObo2sDB5P+bQqkGKNmq2e5R44Z98YwEJZdFWW1VvDxrKz
         2YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767632025; x=1768236825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l00UN7SRVhBQC6JXZrocYBm/aaGRNA8NKJUkQbam+Zc=;
        b=tkJ473qZ+gGFJeId8yWdU45WyEXjUetZL9oz7iJloN9TI3Qyii3u/uA8QgSOLGXLkj
         99OERxZNFYuV6P9xywlRUNZr28r1+46F5i5+XM20ky7/+ywMhZ23m7qFx5dMzoHr4AVY
         uThIAwUZ5p4l0pMO8zIrLw9vbbOc9hiKwTZLOHi+ajH7dUGX5T0nfaQnU9mTh/Y30P8Q
         IbBgbctmIOnw1pMQhgI3aBofrgs8Te6x189ElrRkphxpX+J9lVuThrqbb4idfuJA9zVR
         jKxrzK7EEYEoDbfk9eIH8qumnl7GIvcsxP36Rwvzx66hY3bxYP0+jvGacUF0EwH9mTuP
         zY2w==
X-Forwarded-Encrypted: i=1; AJvYcCUBUHIwa02ZYswao5Y2OZDKVv80+brvS6dyDThNxFHVLSevD/05irgZINo+rd2gz/2xUNX/sLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZdpX9fbW4ukBiiDJQFVBtvcn2ORgzHjErq5ADnc++rLYSFuv
	+e923PeO74SwSnFiP2hq7mxlSMTKsJ2N58ezAf8WbR6KVEfMYgpSt/Nv
X-Gm-Gg: AY/fxX7zWR9ATPFUh3ZSf/oFqYfERJThWjPO6bUvKN8akPpeR1aqZWq8WByWU/niDY+
	peI33Q3riEduGNZhZNAvb05XFg3TBz3yquk56Hq/uTeNBS0ftO7uCyfYArl0oRAEhymhf0RxRPk
	5aGuOQoBTVgkUSWs68m1JtYC2uCLOY1IoDV+4EwwIfYJzFfx85Dx4VAUZXAAVXY58zOOkjnKRI+
	ZGpSwmZm7zCYDRBuwusir8mB7y/ZJRINvPv9GVwFMgmV4WNn7/UWVGjd8BnAMpL99uacsvlYAjP
	pTDoYPKEzdqdwhZJJED0GzilToSEIKW4DUoUQGuZ4kONZ/Roicvq5FVOep1cyjYPicxldcgSCw2
	KVhcQYnwDiUZf+LADd8nlmMKhZvp8mfnoqhIM9h8UFtNmhEWITOfvUUAVa0l5TwmGAQRc8xr/AJ
	M8LgBBWiTrK8l6odiIpyOqp3WWOZPG00qJ0TU1qa741ce/feLk3+WSnEULB6NsExay
X-Google-Smtp-Source: AGHT+IF+Z26J3eqWANjwvz2aGbzwbHwj03Dvzld4yxgmdcITZPUnWCL1cmdrL77moI4imhMFx9RY5A==
X-Received: by 2002:a17:907:971a:b0:b72:c261:3ad2 with SMTP id a640c23a62f3a-b8426bfc283mr45915466b.50.1767632024349;
        Mon, 05 Jan 2026 08:53:44 -0800 (PST)
Received: from [192.168.255.3] (217-8-142-46.pool.kielnet.net. [46.142.8.217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842678bfe6sm32386166b.57.2026.01.05.08.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 08:53:44 -0800 (PST)
Message-ID: <3c774e4d-b7a6-44e3-99f3-876f5ccb1ca3@gmail.com>
Date: Mon, 5 Jan 2026 17:53:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: sfp: add SMBus I2C block support
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20260105161242.578487-1-jelonek.jonas@gmail.com>
 <aVvmu1YtiO9cXUw0@shell.armlinux.org.uk>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <aVvmu1YtiO9cXUw0@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Russell,

On 05.01.26 17:28, Russell King (Oracle) wrote:
> On Mon, Jan 05, 2026 at 04:12:42PM +0000, Jonas Jelonek wrote:
>> base-commit: c303e8b86d9dbd6868f5216272973292f7f3b7f1
>> prerequisite-patch-id: ae039dad1e17867fce9182b6b36ac3b1926b254a
> This seems to be almost useless information. While base-commit exists
> in the net-next tree, commit ae039dad1e17867fce9182b6b36ac3b1926b254a
> doesn't exist in either net-next nor net trees.
>
> My guess is you applied Maxime's patch locally, and that is the
> commit ID of that patch.

This was supposed to be the stable patch-id obtained with 
'git patch-id --stable'.

> Given that Maxime's patch is targetting the net tree (because it's
> a fix), and your patch is new development, so is for net-next, you
> either need to:
> - wait until Maxime's patch has been merged, and then the net tree
>   has been merged into net-next.
> or:
> - resend without Maxime's patch.
>
> In either case, please read https://docs.kernel.org/process/maintainer-netdev.html
> In particular, the salient points are:
> - no resends in under 24 hours (see point 1.6.7)
> - specify the tree that your patch is targetting in the subject line
>   (see point 1.6.1) E.g. [PATCH net-next v...] net: blah blah
>
> Thanks.
>

Ack. I'll fix the points you mentioned.
Thanks for your patience.


Best,
Jonas

