Return-Path: <netdev+bounces-183216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624C3A8B69C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108DB7A99BB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CCD238C2A;
	Wed, 16 Apr 2025 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf5XKmVj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F8C238177
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798694; cv=none; b=A4IUHmTLFBgUKI6baZwEDxCwQ766z2U5NuE8cvgnIV1oHM1xzb36pZQ9LSpmpf5ktlLFk1hkpw/TRtOh+LdiD/GyLgOS4EnmIF32yLMd1K50xVtsvRWU6R5ENLmNxxQTpo0+/I62zsVgzEKRyQ81Y1dZLvquuCSJrm23b5UEQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798694; c=relaxed/simple;
	bh=A+Fzxx+sV3A3YpPWAIMdBVT2i8uhaxWDjmTAGVnTLkU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=p9yarzBImUOnQoA5LdJU8k0IK8T2Oc6QdTrUI20/zOeywOGbObHhhPOROTtgZ/aA2YujrbwderwjJ9LiYjr1P/n5j2JDDcJr/1jRTTqJPm7O5L9aZKEKca1AkTw/398IAYl7+lFk1KeBUFrl5lP+Mj5FnLjiQ/jCf3ioJHYHkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nf5XKmVj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso75634075e9.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744798690; x=1745403490; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oW39S4GKPuIOi1xUzzNNiHEUaRtO3aMLs8wBhg9erJw=;
        b=nf5XKmVjPl5i3fgsolaoGZdBjZ7JnE4gzml6YXWenRtW7+7bDmhHdXHcj5TvZfHpKx
         JqtPzjKSZidNyIG9nPuR7wMvNqfg65AlQtscaf8OYwm4mkiseZfqttb3/553+LthFK0p
         +uzGuZV/Pfxw2+liFeQsHrU9My2dIReTemF+nHR4sZtJ88xckRBakcgG+NQ3rylj2DWI
         uYN2EVVFQILOeysfdjZhUoMBEVhytHln7Nb6CNNHa1m2hsCFhGlW9y0yDfEkFSDUV8qw
         4XBWLNARDQF9hj52r1kmA0/eycZaL5xAUtSik5yYcyhgk7Y2yupjwV/z5ap7C3OMaZzQ
         M+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744798690; x=1745403490;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW39S4GKPuIOi1xUzzNNiHEUaRtO3aMLs8wBhg9erJw=;
        b=DpEaKTKO/TTViu1LjY8kSPMW18rvpHjDeH2f6le7c4/3zD9+u7Vw3VCFMz7VNrU6BT
         wXPWlb+Wc6h425zsDwQxAxEmruO8lfOJaCXQY/LUhgX6tMSBlhRrQRSF+/eCGZWpDMj+
         1CYN5S2EQx4Msld/ltQ7c3I8vB7pIWH+QNCnevD1bzRE53GtL96i69rTCU9SGPD28Zqt
         eOnF6B1LNmWHqbTin6RCQDrk97XiZb3d4ZvbLeI4ib3ZCmFKgAJF9z6dDeYAKAWTcDb6
         foXwpB0q8etQT1R2gcT7vO1Z3krrdGirpTiHPBOWjrQ57kY+xZXWWsy1zu0laiwisjjd
         LaIg==
X-Forwarded-Encrypted: i=1; AJvYcCWwEZoAVoJ8zWo8tzzRhtwVF0T0PdpjT+YWjoRknXc5jX4OJL5hnUUj0O1Awu9tDDjLCbFfYXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9IZFV7PWwTI9zD+CB5DIWV4/49eVQinEEW1/PXfah2pUNHAW
	cvrBO3J9YXxIsyXxcT2wisj/gHB5zKWqvUZVlhdwmclNSnKhRPzx
X-Gm-Gg: ASbGnctaC+eEZQxPzWtqZ9+vFvLmtzrgNmJ2PUgetWyOt9Nh12HLwgg53QnEDNIgfhE
	GCLvHlk7+mG88ZoUR9BXSrr/xkEcSaIFFFfNlp/5eSDRH5Rp3/JRG6QBBQMpx8MZ4+AdOjv3WQ2
	0/iCnpiS+C9ELB0KUxFo3CMWcPion+nMHedGQeWryHNJioBWjX1n9auKtr4O1nbXM//uMPCzmIy
	p9zMjB86eO5FYcXrz7QeKSSHUVC42wGof7ZHytd2X5TgqkLD69jKWY3s2Is7JaGYrSKBNmjOZqX
	J1mYWoTnkcHjZ5hZaV08PEUsyE4AU55hogGuejBODSYSataz6WP06Qv24Q==
X-Google-Smtp-Source: AGHT+IHrfXCkeS1r3pBgfQTPH/4p1lSvruCN5ueqRGvfSUou/79j1XPKtFvCMHxiDpiRfyko9Z6M+A==
X-Received: by 2002:a05:600c:1548:b0:43c:f81d:f with SMTP id 5b1f17b1804b1-4405d624f3bmr12729495e9.8.1744798690265;
        Wed, 16 Apr 2025 03:18:10 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e94a:d61b:162d:e77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43ccd8sm16969077f8f.72.2025.04.16.03.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:18:09 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  sdf@fomichev.me,  jacob.e.keller@intel.com
Subject: Re: [PATCH net 7/8] netlink: specs: rt-link: adjust mctp attribute
 naming
In-Reply-To: <20250414211851.602096-8-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 14 Apr 2025 14:18:50 -0700")
Date: Wed, 16 Apr 2025 11:10:53 +0100
Message-ID: <m2h62ol8lu.fsf@gmail.com>
References: <20250414211851.602096-1-kuba@kernel.org>
	<20250414211851.602096-8-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> MCTP attribute naming is inconsistent. In C we have:
>     IFLA_MCTP_NET,
>     IFLA_MCTP_PHYS_BINDING,
>          ^^^^
>
> but in YAML:
>     - mctp-net
>     - phys-binding
>       ^
>        no "mctp"
>
> It's unclear whether the "mctp" part of the name is supposed
> to be a prefix or part of attribute name. Make it a prefix,
> seems cleaner, even tho technically phys-binding was added later.
>
> Fixes: b2f63d904e72 ("doc/netlink: Add spec for rt link messages")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

