Return-Path: <netdev+bounces-69013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFD6849220
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 02:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC99C1C214AE
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 01:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9671211C;
	Mon,  5 Feb 2024 01:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3DY/57D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0AE17FD
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 01:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707095279; cv=none; b=AglLoNvzFaUz36StCEpEbeoYQ7YrfukFQHd9GPN+4AT8LELGnensoI5qTnb1B851nOpqOLhXcjB3YcbhfEm8Jsz1XXcA3PNy7sG1hnI0YBGKjQHRQTQytu4hDr4CGMEmrwHroXNs5O3FWnGwkBhtSRn8tR8j5AICxG4sgctK61w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707095279; c=relaxed/simple;
	bh=6w+PW7MNxHFbNbSMmU2M/XjT1e9IRU5ld0hu6NtAicc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjBGT1ae8GQD1jOpwXkuJeFr7jn29ncMtgLuRCv1fQSxalkr/OO5pn5F0uwUmlR7k2W4E5VAZJEc1OZalvOBxQJoonaX8yKbezwnahI9D2fgVWJ0eV9IE4CetKnFJLZKIbsoV1ozS5buD93HCKi4sVGjwB2+I7YLqJy21kfSJHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3DY/57D; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d93edfa76dso33230715ad.1
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 17:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707095278; x=1707700078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVUYgBDC/JiOzPoXntti2X/n8S19uqbjiIoVUDMx2v8=;
        b=X3DY/57D9a5hSDWEOV2yoI//PFy61EJQ/VOLieQxv1Gu6asWD/LeKsr5JpJa3uMcWJ
         ucYg4kFw7xYK27JqRgWbQ6ZHfxsDZev7x0DpUa8E3f97myBdCvoZq5cQKbDVVAesGvNP
         WNgxh7HXCe7HlRjpIvWOiHdT92tYNQ6hXIepz4IKtnkBoD9nh3FNuVhol1hmgw7xp5fk
         WdWg3bO2p4DwZ5miaVDMAVx8OQ8fvgzIkbyj92dnlINC2APNgScXsvfsEYtirnZdfMye
         Yy/zRjqjN1MRctJ5wyGd6sPujO+gnyJyGzLSljSZ8QiGJKxXttmLunoydLhotrfR40gD
         4iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707095278; x=1707700078;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVUYgBDC/JiOzPoXntti2X/n8S19uqbjiIoVUDMx2v8=;
        b=XhdJFOLb/Qy5M+mS04D6vTzmvIgPPs8ZuDN7pP/f4D2bOaOTmrQvK+QjxTmU15K0ek
         OAyjiGSsZzSfyKHUF6e1Y2s11rmzkn07FtyeQ3Wsv15PvnmJGJzhAaxDd4r5Wq+xUw5X
         sZZud/zXkEoMBgqO7Vx3KikM4ttq1ETHyddxKqVPGQXOTUvzfj2XNQCAD+s91Vr3qmr7
         1HBvk+uI1CJ4K4uyw2tYaxDw8oZqWIS1jlLf9qFJhtAFckK/qmocIvAQcjOdVGmkenNU
         sxxitxikZFMjdlO09FNlQ1IUtmVCrSF4XWB+QkDrHLcAoHy9Pslh9GX2F0MDY5EnnBcX
         nNZg==
X-Gm-Message-State: AOJu0Yy19bt8ZfN2/Px0XrKvnQS4/I6JbkAoZ1fG+Z+iZSrg0KhK105j
	gG+U7qu995c/ybeobNkT8H4ZtWoQYNA3uhy+cER3d4Py4KSvcbCc
X-Google-Smtp-Source: AGHT+IH+06fMKZWGM7wUdPE0CWEBEcVpWLDycefVscFO8uEpdhWDJBEhdAnjAkr0LE0IVSW0X8WcBQ==
X-Received: by 2002:a17:902:cec3:b0:1d9:b423:7a9 with SMTP id d3-20020a170902cec300b001d9b42307a9mr2286334plg.24.1707095277660;
        Sun, 04 Feb 2024 17:07:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWMSiksp0+4qMIXzDUWBBfYal36EasxiDduUSpxiNXu0eDW5Mgouh4FU7LBTYquoHrJIz1HfwAKKmREunY6SNoA7AKdPyeOuToSlvVTD7+ThrM9nSjinTmuwfQ13D7xcG6IaIAK3XtVn1vBhktDDdC7VGRhOsM4PsUHw5ZupoWonXLmhAkyc+mJEItQrmjNddT52c6EXx7B+NmkmylI7015/VJEFq1O9ZB8KXxbyyhz93MSLWqXdjKyzmNOJKjr7vVFmHjnuYstkXUSoLv1rnhsT3ViEd8T5t4=
Received: from ?IPV6:2600:8802:b00:ba1:a085:bec4:3fb7:b0df? ([2600:8802:b00:ba1:a085:bec4:3fb7:b0df])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902bc4200b001d8fca928fbsm4961359plz.230.2024.02.04.17.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 17:07:55 -0800 (PST)
Message-ID: <440652f1-428a-42f3-bb5e-d14d74cf5e3b@gmail.com>
Date: Sun, 4 Feb 2024 17:07:53 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mv88e6xxx: Return -ENODEV when
 C45 not supported
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Tim Menninger <tmenninger@purestorage.com>
References: <20240204-unify-c22-c45-scan-error-handling-v2-0-0273623f9c57@lunn.ch>
 <20240204-unify-c22-c45-scan-error-handling-v2-2-0273623f9c57@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240204-unify-c22-c45-scan-error-handling-v2-2-0273623f9c57@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/4/2024 3:14 PM, Andrew Lunn wrote:
> MDIO bus drivers can return -ENODEV when they know the bus does not
> have a device at the given address, e.g. because of hardware
> limitation. One such limitation is that the bus does not support C45
> at all. This is more efficient than returning 0xffff, since it
> immediately stops the probing on the given address, where as further
> reads can be made when 0xffff is returned.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

