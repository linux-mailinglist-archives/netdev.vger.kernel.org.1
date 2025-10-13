Return-Path: <netdev+bounces-228898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27366BD5AA8
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 20:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11B784EB174
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2B42D373F;
	Mon, 13 Oct 2025 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dunCf8cx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8E22D24AB
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379317; cv=none; b=qR/LAVLHH0mxR2JfwMPwB/D09sMmt5/GwEOIg4ynha5OlQ782GkP1GSKNR10R78xGYymN0EZFlOeK9W9fYoJ5Irj+UGR56XN6EMzmUzP0BJo7jrrWIMpGtQj2amGeV0JrZYRrrACSc91pKYbsMdsb+pu1JlbmOiSOnduCLHvwrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379317; c=relaxed/simple;
	bh=NWRdMU9u7gR7m5+1dihsR8wN3vHaZ3K+2AlMbOkqqt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxvNcmtG2gNzI/It0mhWA5+vZQ28IqxhiIJntdBQSCyO8AGqk1ZRdWfYFOLN4rl42pNYwnztyCOR/NPfcPXQ1+5jSmn15nkwppeH1PeZ9dNKh5dzA5GKf2x+454TQ409s8RpavmTrTzq02MFZ0pGZxwI0nSrGYXfbDop7mbXYhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dunCf8cx; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-78115430134so3069616b3a.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 11:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379314; x=1760984114;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFxXctdJJT+BzOc0txkC/Z5lJFQXl9VPAAzfx7IcY1Q=;
        b=YC+eavtPd+62rMB8umvkOodSPKmGw67LqQJBLDDcezWAW+mrXgIrJZwaieFT6Gx1xU
         GnmbiwAdgAkYtigU/QLZVnS7byjDePowSst/2oXYvievxMtxjerzT2YzWP36Bqb0CfeK
         1AJWghyHfsPMIb4pqOzfc1nyRnkmeUeAMk2mjpOP1xbTySh0rlcSp2941KgBa7NxS972
         bHUeckKFljnhRsUNWXwZNw4fBdoPrfh7POpaK5aT7E17t4oY4B0iJx/HOnhsnvSnFLPl
         Zqm/1VDlIq6P2nKqTjNKNqFVULVyduXNAzQmpEIjnKzTu1azasI28HudLbavhKdZAZ+9
         IRNQ==
X-Gm-Message-State: AOJu0Yx6elNhgiqtP5bcVKebU7/bT4tDd+fqHXNrTapN+lJxw45y0Zpo
	NEdR6S/e+FRQMS/A2SvBeEf2RwCOg3ctPcIu48KN3cnRxZ74/fyrQ4iRYjgpK1S1bRzX4i8LOfs
	4OJbbjc/T4rbvqRr26Zo93bh0jJp2VBjZ684spm1pmiLJkN37IN5BgvaZpHSO7ukNN2Z/eOlQX6
	f1NBWwDKsMXEip6Wm9xx4ddBy35Q7koUa14NfQvH54iOYaSZjzanJUnmnWM5Rm4q7l8jICFxvMC
	dWUVbN37zoKQoTo
X-Gm-Gg: ASbGncuWMhbbh8YQhvMftrypLzSLh/4VogaYrAKTi7X4njKstpZggPLErdkUiFCpNPK
	cvzD/Ll5nbF43Ce7Hh2pDmD9GJBadS7DiU26fqUfHx/LA0EOJ8cK7IJmAVG3hJRyJwXQZ6/kkHM
	aTc0hG8LB6THSaCocoWhhcTjV+ZO9QYSHOFdMh0/6bVJuKqE0nVDcPe13F7kcQqTFevs1uYamjy
	/3mjflYfUvcHWBrKHNbLfxfT+6NpbaJZtERj8Dp90hnri7848qxgXT2l7UWrNam6TLq5FD9WS2N
	8nij1dLsblsx9s9ojc/rAxe54LNXSSC5ZhuXZhI0A/ct0Df2QxhOMOaC9pFPBeJvFf5yNDfZbp/
	gKYNDaY7eM+fT0E5iIN8k5EqmnQZq+UYnH+uPDpk4I4JvWub96qwLI6tT13jIRkyybzTHrlfc7m
	UFYnHX
X-Google-Smtp-Source: AGHT+IG3AfAfk7IBVBZ4f8TXzWQTTPe5EEwePCRTK7Ujb7irX0psX1gGqzJzWHAGxJoowvPW7Rqxunw8pSpO
X-Received: by 2002:a05:6a00:3d54:b0:781:be:277e with SMTP id d2e1a72fcca58-7938513618fmr24022120b3a.4.1760379314332;
        Mon, 13 Oct 2025 11:15:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-799337ef749sm1037319b3a.12.2025.10.13.11.15.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 11:15:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-86df46fa013so2990383285a.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760379313; x=1760984113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xFxXctdJJT+BzOc0txkC/Z5lJFQXl9VPAAzfx7IcY1Q=;
        b=dunCf8cxyOm6vV9+IPO+6HeqP1SVZv6jvpVegkda5s2ZG9DsXuzBrLd+IRPO4+4nxl
         SX1RyLx9M62KW9WRky1bvoyt5E6wbjPoIf/01d1tFbUgrU4NIUwJuCTCzg7qgLOREV+2
         P/kjqAaLFJwtB/ZRi1NpMPUYpMGRaN4gEds1Y=
X-Received: by 2002:a05:620a:4505:b0:853:61ca:9e91 with SMTP id af79cd13be357-88350f57a08mr3101496785a.38.1760379312983;
        Mon, 13 Oct 2025 11:15:12 -0700 (PDT)
X-Received: by 2002:a05:620a:4505:b0:853:61ca:9e91 with SMTP id af79cd13be357-88350f57a08mr3101491585a.38.1760379312499;
        Mon, 13 Oct 2025 11:15:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9ad8dasm1034487385a.21.2025.10.13.11.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 11:15:10 -0700 (PDT)
Message-ID: <e27dd085-c21e-4358-aaf3-d54eb1ffeea1@broadcom.com>
Date: Mon, 13 Oct 2025 11:15:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: b53: implement port isolation support
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251013152834.100169-1-jonas.gorski@gmail.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <20251013152834.100169-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/25 08:28, Jonas Gorski wrote:
> Implement port isolation support via the Protected Ports register.
> 
> Protected ports can only communicate with unprotected ports, but not
> with each other, matching the expected behaviour of isolated ports.
> 
> Tested on BCM963268BU.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

