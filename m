Return-Path: <netdev+bounces-204897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7076BAFC6EB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCF33AC8D3
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD242222CC;
	Tue,  8 Jul 2025 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgperA7C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1AE2144D2
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966445; cv=none; b=f+odY5QKkB9djAhiGByUIpbnWRh8Iyc1NG9D/qs8MYvsEPgABOmbfHBo1nsi/jCtMIwfuQ5SJ9Fs2CioMpVY4GjGKNe8Qf6mgGtUb80z406LejFmSmLW+UQ4xkUsV5RfJI11/zWgL8pZgSimjQDswZddLlXZCwRZvxwAbZE7rns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966445; c=relaxed/simple;
	bh=l1p9E+2xD7IPs8x4YgdT+UmoalDBU43AFSMeGpgmz6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSJ7PkIJmV7QfuQpN+EApxDckjJt3vXiuyVB6DGaQO2AFg7mqkfDTHZr3WRm5t6S1l+uJfnbP5ltXbPdsCq8XfqfomYpDXTcPu3b4jSZ3Hp8haxmGJPczMdYLpJVoGaGkS+sFvc/9KWATN0dSymZRAALdF/ifVkWINhgivqRopw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgperA7C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751966442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WlFrHWCBZ0GRvhfqPcMu6mVAR9pzqmTshDoLe8nyLtA=;
	b=CgperA7C9IUvRXD5rN3JRI4rRW1Au1JZ3NQ9tRVy5a+NfYs+ODh3+kcd+ZZ7lJAflVpH3z
	+VfmxpcOhZwz3Q6kdR1CQADi0kkhqzRvHallbRLxROHiuaBr/OAFWoiqn2/WdZXymxOqQx
	xA3OZB6yg2OMIrULtrXfVGL01Ep17+Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-FMjqve7mMeqDMTjzUQ0erg-1; Tue, 08 Jul 2025 05:20:41 -0400
X-MC-Unique: FMjqve7mMeqDMTjzUQ0erg-1
X-Mimecast-MFC-AGG-ID: FMjqve7mMeqDMTjzUQ0erg_1751966440
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a52bfda108so1958823f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 02:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751966440; x=1752571240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlFrHWCBZ0GRvhfqPcMu6mVAR9pzqmTshDoLe8nyLtA=;
        b=PzhbOEeDFD8danHuInLCGpiD2wCLxVObe/RlOz3morcrFrGBhDT6bC2aEO5dhcqZtR
         +UNlr8gghyH/kywJK4VXSygnGB1POaf/GyZ6qmosf/A51UjpvtMAgolHb+KbboajS9rd
         7oeaggwuq5y4qHdCtYRtgQqMAfD1ZuLuhQVZvGu1I3FWPgzH1WCfk9eiQk3yjyixnwGR
         bKZoMLJSgXLOEQ0BczBsdPrxrHBnku5Bh03OhsGk3ECOTpxAJiYZ+QQGi22o3u0Uc5wT
         Woi1Oz5AwuLiCFYpWxqH2ZP1T97iZQ1APjk2W7OsGVyBevuYpR/ry6ndeyMtfvEJ+cdW
         Fzqw==
X-Forwarded-Encrypted: i=1; AJvYcCXRXnqq8QA1Vh4LKI+UoEBbkSHPv0k1cRIALurFkFSEDT/4rFFs/hI8/CSjJ1Q6laWIKCkPzQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUTRCxcDW8qAmz40IOw+h7Os0Jd1pAEc3kc8avbOIMQrinaAu3
	cCzIiBJPYeqsl/O9dafBP1hkgeWVwCNr5BjgnWz9AbZs0zjCkk/eD8A5qzMBih2HxfZge+NQG9O
	T6DrsPSYzwGvx76cOhTQkXBj1MpsxBO6WFjLObrydghZbM/Z7fUVyK8fk7pfRUGcL1A==
X-Gm-Gg: ASbGncvhwIShbXYttN7bTIBUiG+GvqOCX3vj0Vb6HmAkdFCGnCn24QLEL6JcACHz08/
	R9klPB+RAcV7o7Vj0mDau+Dkqam4EPy8veyzY9CJjKL9sPMt2AsKrsIL+EybZ1c46yxzPwS0+Ie
	QQJ4CSE1Ucm65zNqBtfFZOglMjxTJuGC7KRdyi4BxKKoz5+pKiEPSmFDhVcoNJ3/VJf6iR8AsHz
	1+JnSyjt04n9xC6CftZyvmRVf4NZXVogsKC1y0NPx+O2WBy0JVJ0QjKo9dvIHIXOLONbPkVKORn
	8bASooGON/i+iYHyt4m916rr1HHf4q18jtGi7e4Avz9NdE+9Eh08ZkuyErzHpxWImE8IqA==
X-Received: by 2002:a05:6000:4a10:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3b5ddea1c51mr2238696f8f.53.1751966440092;
        Tue, 08 Jul 2025 02:20:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh8nD1EiPG7m0mg6QXkWYeptqjWcfmnci5Vnj6Jp422MialDVXM6maHNA8ghrBApwgmMdE1Q==
X-Received: by 2002:a05:6000:4a10:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3b5ddea1c51mr2238665f8f.53.1751966439672;
        Tue, 08 Jul 2025 02:20:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285d3c6sm12548795f8f.95.2025.07.08.02.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 02:20:39 -0700 (PDT)
Message-ID: <b676eb1b-265a-4647-b340-be88559a3561@redhat.com>
Date: Tue, 8 Jul 2025 11:20:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] allwinner: a523: Rename emac0 to gmac0
To: wens@kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>
References: <20250628054438.2864220-1-wens@kernel.org>
 <20250705083600.2916bf0c@minigeek.lan>
 <CAGb2v64My=A_Jw+CBCsqno3SsSSTtBFKXOrgLv+Nyq_z5oeYBg@mail.gmail.com>
 <e9c5949d-9ac5-4b33-810d-b716ccce5fe9@lunn.ch>
 <20250706002223.128ff760@minigeek.lan>
 <CAGb2v64vxtAVi3QK3a=mvDz2u+gKQ6XPMN-JB46eEuwfusMG2w@mail.gmail.com>
 <20250707181513.6efc6558@donnerap.manchester.arm.com>
 <CAGb2v64UTr1YSm7VXtzk5jmD_J_20ddPcWww_NPzx-e5HvaOpQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGb2v64UTr1YSm7VXtzk5jmD_J_20ddPcWww_NPzx-e5HvaOpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/7/25 7:34 PM, Chen-Yu Tsai wrote:
> On Tue, Jul 8, 2025 at 1:15 AM Andre Przywara <andre.przywara@arm.com> wrote:
>> So if you really insist on this: please go ahead and merge it, so that
>> the 6.16 release contains the new name.
> 
> I'm afraid I insist.
> 
> I think we still need an ack from the DT maintainers though, and then
> the binding change would go through the net tree?

Note that such ack could require a bit of time more, as there are a few
patches in the DT backlog.

/P


