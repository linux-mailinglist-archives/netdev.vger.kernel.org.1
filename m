Return-Path: <netdev+bounces-150776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650689EB848
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CB816388E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D4A23ED65;
	Tue, 10 Dec 2024 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e4bH90iB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6E23ED55
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851870; cv=none; b=Hp1g572DPKxtIyo2aOLMBhqOh50u0vcCo6D7eRDjnsd81bsu2ezkchOy3bUj+bnMqufhUjzK5JPUZ2xtVIB4Fp5cJG0cI6ORhnv8kvHMtIE8AX2p8lT5NMgoXBYQatBiM9ypI81Fiu7NR+sKOZaUCCDeOgHNkLERDXp17D9rXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851870; c=relaxed/simple;
	bh=zkfsnLyi/i30ANVzfBTE+XkWOuNU3VSpbOeZ9P7WJCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8ePNwBkCouOXwy/0G26kNswLzuUbDZVNbXrRDTE9bznwuXUT28P2pCY4JDS+p0H7I/A/vw60KcxgRnj6mkAkQdHYhp/qeEH31EiP0X3FQlaWUBWhjqUvZ9G14PV7DDjO40RB4W/OyFdOXn3dQWDEGZNb8hlMKV/PD6bOC8tCig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e4bH90iB; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6e9317a2aso36834485a.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733851867; x=1734456667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=log8kXEqpuK744XdboVARaUSdfYZkSA14nYsYjP8ez8=;
        b=e4bH90iBgAni5ey1RB8EZ3iD52Mj2QlQW86Rp/qBGWs+teciIiiLa+5d+QQajowicC
         4hpVBlY1kcgSAMZb/qJ8SVcMLszhpCX4jg7BWgMcNzIaSZzXjXdgJebEYmhvhGX7Pc2Y
         dblYx0XA6lCciNJaqHrJdZstErgbn104qUMII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733851867; x=1734456667;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=log8kXEqpuK744XdboVARaUSdfYZkSA14nYsYjP8ez8=;
        b=vUanRPkT+/3TFebvsXMWPpDBrwkAEmc1viyKDlcYbQScomhZDXNzs1rIg57d1zMaC6
         rEMDwfka/TWfbRXXhUad8egvjFtDy3tLZTZLNFSyEhJdhvRWUMrabtL6xMijYK7DYetJ
         ChDQcgemMD2BP2kw+Pf5Y3eielVp0EcQZici4l6/hzTdC5HbgsJ5TfN8NCwrvkq+oTV+
         rE1OZiSJeNT9/DqsY+MJvQsMQcYvFClDcZJLYG3S0EFHrfi84sGn/ucG6cxQOWxqjjFz
         n0/8NbZX7FanlcBibFmeRgLG2ZZETsSXrAeZmWqp+cBOVhHwFjUrcMw/cl+35U/bkG/3
         0s3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyO1RLD3//mZ5PkcfM703WnMiOA587COLyheU4hRQiFp5uRTev8QU/Ecq/yy4tSYKfODXZ2LA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8NZhYoQZw1ve3WUmKPbBRgw0Xrd4B4ZXj1KeZiMpw6iLfFGy1
	C6YdWSV4WmOkXHMXmHz2p4nmaEh5py8M9K3sdC7dUOHCPVBCKD+kLTwMuZkfkQ==
X-Gm-Gg: ASbGncueCwXoHZa3Cn4q6k3hysV/4klFssqoVbnQ9PWFNa9rSoSMuXGGOxHtV37UJko
	Qx/Olj5W5v20jdYnuoIHL5K/7ZqvAnXkmq/h8GsNk3i6Zpc/Hzx+BXEzGwqgwZpOFtaMnzlAmev
	x6n+sqLgIJcR1s8qN0GlKUtUkilS4EIHwCEgndl7VBUJnKkeZiItfKvkyuwAJB0rNuWrP8CG1vk
	YwJZcNucPMYnCHHzbqMjDxMsmM4Y1xOaHeuM1OzqWFUI7uR9nmTAVtuLr/Q/pI5idR6EZZSpFwS
	NKGu9lNnFbb2skciSQ==
X-Google-Smtp-Source: AGHT+IF/4xJ59ARU3WYksPUtImtmV38OpHKa3QhPpiCDikzZ3ElPZ/9NL7hnDna6l/f0hs691/ko6A==
X-Received: by 2002:a05:6214:246f:b0:6d9:318:824b with SMTP id 6a1803df08f44-6d92127f73amr68969156d6.3.1733851867206;
        Tue, 10 Dec 2024 09:31:07 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8f429a79csm44010436d6.72.2024.12.10.09.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:31:03 -0800 (PST)
Message-ID: <e92574b2-3698-4eeb-834b-fac780a6308c@broadcom.com>
Date: Tue, 10 Dec 2024 09:30:54 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/9] net: dsa: ksz: implement .support_eee()
 method
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ar__n__ __NAL <arinc.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>,
 "David S. Miller" <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
 Simon Horman <horms@kernel.org>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>
References: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
 <E1tL14Z-006cZs-6o@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <E1tL14Z-006cZs-6o@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/24 06:18, Russell King (Oracle) wrote:
> Implement the .support_eee() method by reusing the ksz_validate_eee()
> method as a template, renaming the function, changing the return type
> and values, and removing it from the ksz_set_mac_eee() and
> ksz_get_mac_eee() methods.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

