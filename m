Return-Path: <netdev+bounces-206448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1502BB032CE
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 22:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BF43B4873
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 20:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41062230BE3;
	Sun, 13 Jul 2025 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Tz1ET2sH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41F6101DE
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752437096; cv=none; b=U9n6A8SIuLz1fPgkfvqj5cV7R3Dd4L9foJMrwbZ0yG8Ejr0wHkjm1W72d3/VaPcbFYX1nw/pjeg8ZmWidvNYfxU9hGIbo583zwZ12CqWtZKqRqTQCkDfbU/bkaeo7Tef+Nab4iDJ4sQpYHlbW6L4w8ggqNJijT0YLCLu3ZnGJH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752437096; c=relaxed/simple;
	bh=t8f0EIWannNMADLaS5jW+GytKN7GlLPMnC8lRohQwHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7ZWyJ1iAqW5lLmRPiOExQ6ZFWuAQzhpOM2kEL97Gkq8yR0lIR94bYOKPwkRxzvX6YjFQI1mdXEiogqoy/9Y3YNtqE33eVkQtoqMpShEVS6/7noFI8r0lz66jaXtYDAP/3P05MmCrxaV3b0szREAEUih3c+uTcmG08/UIYre2Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Tz1ET2sH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad572ba1347so502948066b.1
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 13:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1752437092; x=1753041892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L/wP3tSmOTUcqlICIJxr3h6obATQy/BgOO8/2ZKEM8Y=;
        b=Tz1ET2sH9dVYEhtGgBG9gcEiaSbszPNOnczpN2XlyMf1FciD9M21y+FHFK+wNYLNgE
         V62PKIfygPBb4AKOGqsxr1Fi5Y21jNL/+QRrqGytE3C8BgGeogPyZwKkPlwLLQLpjYjT
         L/0cNWek4S+S3LIrEC5jwSCyZZ0zpJlis75RCEpftA0cYcycqj+LvYkkt6pGUyK/38ul
         N3w4sujpQEJUIKWFh2iwXO2qoLi40NTqPRNNZ90aJhs6ptZE8W1jY8dHk7plHzupJoVZ
         vK+azqJH+PlYrNFLuQEF+H0NR8uLD4kIX/ujjoC4757XYJTOIpPHwrnA/+OxVGBSryUG
         KE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752437092; x=1753041892;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/wP3tSmOTUcqlICIJxr3h6obATQy/BgOO8/2ZKEM8Y=;
        b=e2er3eEr7Fi2gGIucQN7iFY6c77JJdrUa2DYcKCaVHMP2jg1G+fHhmkknhoMaRVD2c
         Al/Q5sNT4p0OJ/efpeC4KaDYMSjyWrZi0tF+y2mPvIdQLVOKwZpI3jxpUdH5EF20+Vc6
         rIhEb8IzZSPQCvcIaf99VTbiC86JvSEmhhVZe6tELTsFkRqBdxrB2yKg7sdbPLiEo2of
         tORy9jedqvwiE3+cUtq7r2ujVqu9PMppu8xUxTDeFjwcPc110+CyJQFc3fq//61PH9KC
         GGsu73ljT8J518XZ6uKwhtfeZupLojtZUerma8Z5+/4e8EUqxoPvw5HhC7lemB+h91Qh
         Z9Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUn7xQxTlEMiKwerMi1Yj20uR/hTsQgCgYoAWYZLH1iO1RgbeoZQpFCkP2ywfO7lQOoWnndA/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRh6wDSIBCCVTvOi6G009qa1pYn2Tx+0tdS1sUc9B1gicWSMHx
	mMmHbZ6TQoa3KGLIxWl0Hm0AbK0RiutBw81ETQsrmnTv0lTlKZlWG98Hi2/oP0X63WjdmfG1I8f
	0ZxJC9HB1Ps9IvRAwakIct1uyctRUquwEr8unFWZPkMUwXT1CcMk=
X-Gm-Gg: ASbGnctGladbwUXk4TqPdApZnSZm37NWa7z4SbX56wWfRXdUIwiOYFIKEToN5zEM0Gj
	vHGo5/eZEz2UEHDwzb+pz7R1XnyhUCaLTcXTzpVrYyAN0OagmafSCKOuCwTJO+3f0INTmSk2E4R
	OMMfWKOLG2FOYdt5zP2cwIEiY9EpqLqZjSianxmJLO3i0dQTO/O5sFgM+S5AkMUWzX4PNC6r08s
	US7DYSCyWubNP6+OcF4bCNRAhSyKWagJ/N/W4V+k6KRQT8ICRjXpmVByoRpCaFcCcdKj2Zkh6E7
	y/dnEhSG3PPLzTBSTHuLiN96b5wZ2pxEjTvc2KOlIf/R/50B7zku9JGr3CcsA+Bm8fbxGt6fL9Q
	yDruF3wrCLvWuL6sZQZBqNDF6Ag3rOWw/FaAukQW/LZveoy7skz1Ceq+Bm1RR
X-Google-Smtp-Source: AGHT+IGCKa8cYhd7B/SI+nla/JGhA5WuCrWuhbgjOaIfztMFKpm+2tx6vKlSPq1VIaBu50w13N4vSw==
X-Received: by 2002:a17:906:c142:b0:adb:449c:7621 with SMTP id a640c23a62f3a-ae6fca6d33bmr1100300966b.29.1752437091845;
        Sun, 13 Jul 2025 13:04:51 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:7319:4bec:e609:f53d? ([2001:67c:2fbc:1:7319:4bec:e609:f53d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91a0bsm695423866b.7.2025.07.13.13.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 13:04:51 -0700 (PDT)
Message-ID: <5bb491d4-11ff-4c63-96c4-de83074e6ae4@openvpn.net>
Date: Sun, 13 Jul 2025 22:04:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] ovpn: explicitly reject netlink attr
 PEER_LOCAL_PORT in CMD_PEER_NEW/SET
To: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Ralf Lici <ralf@mandelbit.com>
References: <20250703114513.18071-1-antonio@openvpn.net>
 <20250703114513.18071-3-antonio@openvpn.net> <aGaApy-muPmgfGtR@krikkit>
 <20250707144828.75f33945@kernel.org> <aGzw2RqUP-yMaVFh@krikkit>
 <20250708074704.5084ccb8@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250708074704.5084ccb8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jakub,

I was on vacation last week and I am processing your emails now..

On 08/07/2025 16:47, Jakub Kicinski wrote:
> In any case. I think what I suggested is slightly better than
> opencoding, even if verbose :) So I set the patches to Changes
> Requested..

So you'd want to go with what you suggested on July 7th?
I.e. using subset-of and defining 'peer-input'/'ovpn-peer-input'.
Did I get it right?

As Sabrina pointed out, I'll also define a subset for PEER_DEL/GET, 
where we only need the PEER_ID.


Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


