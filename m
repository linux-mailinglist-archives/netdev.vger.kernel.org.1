Return-Path: <netdev+bounces-155142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC50DA013A9
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 10:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8ED1626FC
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E42C175562;
	Sat,  4 Jan 2025 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0rINUxAH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569631487E9
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735983355; cv=none; b=OGq2Fh756Et+2pvKZo5CyDkmWzvAwU+udHIplsbmIVqf18BJ7TQ1adgtejJp6OqgUmkTTAlXCgdkXeGwLQTQWLNxazBGlSNG5PjCsfjM16sqDVxZxCfymftaddrdEuJoIewiUweWIcOhHcbBkekvz7Lh71jaJb7TLb3HtAS3Wx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735983355; c=relaxed/simple;
	bh=LfX77oNgqbSpo8Uz4zxGDRt/7OcCsIQLS3BUiJYao4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aY1zJHShA59FQwFG8KGLcttDs4LX8RjvXGwIeV2SUgwGllOxy2/07E4M5F18dajGQxXDG4kxap/w0fZAcShbWNpAziqJQ5daViGiuXJiqvXlFWXg5bxY1+dP8gLZSHbADpy0eSydOLc7Tvk/aZAx5s7XlF5zQooyC4h11n7eaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=0rINUxAH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso25457283a12.0
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 01:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1735983351; x=1736588151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JIRtfYLc4NOlF7KrTibQZLCMnpb9G2HjHDpKPsmPA0=;
        b=0rINUxAHClVz2zYpZ21tBENTbfPJpd6gJS30qsBcjFOXEFlVR1J7LWhjkHHhWkz0zy
         jY3CbCahrJrgMLcXElPSVBEYwH43Ob06NwWe82YNH8QWJvYn9eIWN+zcnPTGN9O54nr1
         3u77QFnNNmzfivpOwcgI77pnY1KA3lqLiUxQjqTpzqtYOr8TloXXfhddZ0HXpi4+clBo
         +8X9qDKJqDD+2W0TKcQlutZE6olfdySqQ0H6SRA4Kyi6bd9bFIOYgmJPG+8EpFShOejI
         I2XIdq/ZbwiFGqQYY3lRdI+1zVUFmrZhLDvy27mACgjVI4rgCyU0AX+QWRwYtWBBYkIe
         bfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735983351; x=1736588151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JIRtfYLc4NOlF7KrTibQZLCMnpb9G2HjHDpKPsmPA0=;
        b=PxbmwxTI0Sn98Qox1Q/f4KwS6tsNbvMzeJoclFKLDvh/pee0buvgNVDcYM9hQ114E7
         KjYtBaKHi6yy64gA3t7i76IGkw1m2hhga9a+0H0e3JN8HUrpvtuSaE38tq61zirRG+zv
         NmggAqFunIxtMARp2tc1pFXqmCWiXtABI4dHvKSDGb9Em04E3yqibCAjIkWlpdSrHGCI
         IDLbnVcc3hgdWBEIa4UPb8exAXv0NkgfxZknw5QQmueC58ukOzecMkPb4cBaaOU1uIeb
         PM8S9ezt/MTZ1fmGzTi6Wby2tNnPH8uKKeJHv2W0pDd/J9CIv+G1dUS93UVJ4a0jk+Rn
         HjDg==
X-Forwarded-Encrypted: i=1; AJvYcCXCv7uWKeZAChNQ7mt9DR77K7OcIvcY7QFvQkMobR6GkUANj2/KlMOM3QFI7IViwqk36K+KR94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTaazZI2uf50AX0/pX/KK+ZUQntw2y/eOkxtzHp2hkc6uUTa6n
	Ec+Ns4/JYkkZ/b3v9ozYlBTfOwDsROr9jd0/01D728IuNUI1MI4u5t8gB+4KdDw=
X-Gm-Gg: ASbGncu6AOMbfKR6bJwXctZWfEGc5pYPQBmL+uXr0P/s9JhGFo5V+oHRMZSmwZDYWhD
	uEA16W8h4n2tP6eiAesymdW9A5pUlz1iNmnj/XhLX3zPPmJLF5FEJcwDizabvmZ2JlF+ttcUWmH
	8mQvKxhyByC+anS9omTLfx8yljPQydmae13IE7a5iGtf2UdX4nmfwh/CkhHOLIctvqjTyTq3L84
	zC1pjAs40DKg3GMS0ZLtv5tvCHsCkemddMyg10aGvqy2ERCs7Wz0Gc8rWzE0aAtD3itvUnRJokQ
	zSgLVRqZzAjr
X-Google-Smtp-Source: AGHT+IGqCinoycrbLVXIp1NEc60NTfZie51dGnaZMUm0mhrMIwLb3OmF2OfNiuQXwoa0JTUHX4Djpg==
X-Received: by 2002:a05:6402:540a:b0:5d1:f009:9266 with SMTP id 4fb4d7f45d1cf-5d81ddd6d22mr48235020a12.2.1735983351472;
        Sat, 04 Jan 2025 01:35:51 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a5a8sm20395053a12.13.2025.01.04.01.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 01:35:51 -0800 (PST)
Message-ID: <5237f91a-bfbb-41c5-acd8-03ac26052e50@blackwall.org>
Date: Sat, 4 Jan 2025 11:35:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] bridge: Make br_is_nd_neigh_msg() accept
 pointer to "const struct sk_buff"
To: Ted Chen <znscnchen@gmail.com>, roopa@nvidia.com
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20250104083846.71612-1-znscnchen@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250104083846.71612-1-znscnchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/25 10:38, Ted Chen wrote:
> The skb_buff struct in br_is_nd_neigh_msg() is never modified. Mark it as
> const.
> 
> Signed-off-by: Ted Chen <znscnchen@gmail.com>
> ---
> v2:
> - Rebased to net-next (Nicolay)
> - Wrapped commit message lines to be within 75 characters. (Nicolay)
> - Added net-next to patch subject. (Nicolay)
> 
> v1:
> https://lore.kernel.org/all/20250103070900.70014-1-znscnchen@gmail.com
> ---

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


