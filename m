Return-Path: <netdev+bounces-85939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0289CF14
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 01:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23C61C23A3C
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FAE149C70;
	Mon,  8 Apr 2024 23:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx1zUM2k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707523D0BD
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712620305; cv=none; b=tOmEeFjOL2XDkRRCqiMllWuAKNnWWJ+OzKHPS795X66w4UfGjmLKizH2VjkZZuH3n0aJdqa3yRMVuhLDSXuVjKzihoNgRi/bUWgR7HCxazFNbBnbiac2/0aRzbospM0/bBU26E1AMW4ovdOIw4X/GvNjwGfujiBAbk1hP5+0IRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712620305; c=relaxed/simple;
	bh=O82fKzGS5wZ3PgLjRAs0qgHAdV9+SmiAzLCcUMbFntQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebmmXvDdNhJrYfwWpPdJfuhvDmbwiQ+SiLWwDpM6LA6t0pfO5gEMoiI6C5DIWQG0mT20Z4SrDUaFMff2dMmDJ2DffK7q0HiUre3x6uufyG16FVheYe6jiaVYZ/UoxcxecZ53VOlpqBoHFQEMP3SPhcALj3LRmT6D8uD7f7i5YzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx1zUM2k; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b236a942dso8326616d6.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 16:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712620303; x=1713225103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgEN86IU3i/qZGIgbM455RYrVEgQFG2eVDz5OdYV0gg=;
        b=kx1zUM2kU6MjZaBcMBjuZl9rFeAPQ5rzM1LbKLpIlHveye4BJedGfXxrSVrxZaP72W
         UAKVsaq+FNCZz3GevhA2kVoBImpIfTAeRhjNT+PG4Un0//wjE1cErZ1DS50EXwVLTOgF
         p9BOY2XGtSYYfxx7+NuwViRn8rZEvgJBVgGTC9oIcR4Puw+AGajdzN/BtW4z13Gr0QvI
         o5f+vvptDjD66bJClwhjE59GYn/c2OcML0HrKK0hJ4u9wkDnZHtfGAuYY87u8sMII8qn
         cmLoc7xXGHtvnRyK5olWMRgiPRRoY+p9ZQ58EcpeJ5utQDbHw1g3dDoJN2KDgBh1UECC
         9ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712620303; x=1713225103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgEN86IU3i/qZGIgbM455RYrVEgQFG2eVDz5OdYV0gg=;
        b=HHPMk/u8g2eeFQ+Zb0ksJJXnIr1mHuATwX7AEBqWMLCTelH9wJdYXOAgduB6NAm5tL
         b89dpATexmmTsalAfaz4ADFrSYJoK54oxyAlbsns0qAmydDQ7DuXm39iLzOprWBPuUaE
         UnqkRW1ZGZB9eae0eV0j/DFSJOyaHuMZVcjMr3CtSjHNlNxSkDhdNyGlWSOCsweahUo0
         z+YRh43Z8ZqZBYbbLH5YWB02H1tB2GRs4zluN+Xl7fdkNEbvhmLXfhCy7GydqN1RWEfq
         /ZhB3hK6aFypdo5nAfkqfx5ZfdOlVPdSuq96j8K2kElnFJk2+0eIBnFob37GONicTk/v
         aAMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOMqAz2zdbGFJhqkO9z4An/XmDA+Cagi+0rgKDuRhT2NNmL1BgXal7ipHhZrxmYW0GwdWMKWETwqLMgy8Q3wnAsQk/0/c+
X-Gm-Message-State: AOJu0YxoA2RqfAqhEtNHYh+5vF3NHeRW1C+x2pkvqzD677Jsdgn8ev1K
	bsp9pYsgpHQG9fceOB5MtqF5TRxnYIwaIDFu/PCQZSHUBdaTEoGa
X-Google-Smtp-Source: AGHT+IEyNBr2cp1+zSysEv0J5atlb+XlLAbSRV0L1cIY4MVpPfCqMyeMtdWgcuTEj6IPD7Szad+rdg==
X-Received: by 2002:ad4:5bea:0:b0:69b:1c6f:45d6 with SMTP id k10-20020ad45bea000000b0069b1c6f45d6mr1956829qvc.4.1712620303274;
        Mon, 08 Apr 2024 16:51:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mn23-20020a0562145ed700b0069b23e58468sm624094qvb.43.2024.04.08.16.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 16:51:42 -0700 (PDT)
Message-ID: <e47564d3-b883-46f0-8e4b-2535afb5e2fe@gmail.com>
Date: Mon, 8 Apr 2024 16:51:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: dsa: mv88e6xxx: provide own phylink MAC
 operations
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
 <E1rtn2A-0065p6-6G@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1rtn2A-0065p6-6G@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 04:19, Russell King (Oracle) wrote:
> Convert mv88e6xxx to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


