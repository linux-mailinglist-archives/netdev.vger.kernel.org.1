Return-Path: <netdev+bounces-227359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAFBBAD169
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 15:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC767A5D64
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78080303A28;
	Tue, 30 Sep 2025 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqQh4WIK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76B21D590
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239642; cv=none; b=OcBY4maOjefCA4fQLo1Y+ts4/vtze7qFSxHqHjLGCBCGEsBQ1n2+/yl9aJqnGCzx7pJaIhrvT9WtlS/TazW6qt85SXqxdrqXdik1kkNtK0C5ZPdS3E7xxMwMGMUZ5jPILxL+L4GdTl4olTIpJ/VEsCYlvgwipKJsjyxVGlpUwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239642; c=relaxed/simple;
	bh=hb7TMarqWXO178DpdiX/rXmmKCvnKm0TOcmJL56yQh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDWqOLXJTUDsZokgZTOqA4Z8hU4Od3dWyfEcLyrEuQ4M/tR+uWrn8n4NA2qO8AKu//Bh7tksD1aduAjasSbkp7mFNawY1OWoL679qoK/X2+5bvG4WL2WgNGnRKkES7q6ScNJp6w2SsMA9lrjCPdb2RVh0B94yDQm5TuF7bAYGgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqQh4WIK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759239639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc1pUt9y2hsw8mhswnVLM/oUyK615tOMdAOq5LgQ9VE=;
	b=WqQh4WIK6AG6oMTpraTmpoiug2u3o7G4SESct+a0c9FoVOruC1aYMfzcGIaO9ubdTWbPjY
	loeBwd/Vnmp01bqtPkeP1Jx9XsgAvPUzOEe0JPp+AID4h7Uvaf+qxJxW3qtWEU56/wHehm
	25iLJ7h5RHuK+hvEOsBO4hPuKzoELe8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-EuisKrR1NjyE31SaR9WNiA-1; Tue, 30 Sep 2025 09:40:37 -0400
X-MC-Unique: EuisKrR1NjyE31SaR9WNiA-1
X-Mimecast-MFC-AGG-ID: EuisKrR1NjyE31SaR9WNiA_1759239636
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so4266823f8f.1
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 06:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759239636; x=1759844436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc1pUt9y2hsw8mhswnVLM/oUyK615tOMdAOq5LgQ9VE=;
        b=fMuJj4iSK5Nlwe6uCGeKD6KAFfryq3TQ8fQLWTY/GIjNMr7Qgb6CcTzNN5cQhqqPAS
         +biiVL6QRg0Z8T28JwAzyL/0nUFGzHL62rWFGWrdIrBqZa3VtvmaE/AIwSKL82r07xEC
         AYdg6viL8p+iUejHhbT3WzA4HnztgOh5M49PgCf8d5JE7AxMzV2nhm7VhWjL7CS42bDx
         LdXTVJnOyJ8pYyCzta1EuQUX76EwtfKbXfYEI4UeQMytkDHz53VPMP3k4hy1ToAzEaG6
         /w/zQthyxHmMwR6FnTOQA6MNvpv3qCHEsfu6r2hK4E9Igxx3pH1EmIt5ucCfRgDIOmhk
         haZg==
X-Forwarded-Encrypted: i=1; AJvYcCWQJEzBJSWTIMzH6StkX5kWmWFubQjzn44TQq7RIy7FgX1Mq+bvL7KpNRKp7TKEiyzyIOh7/P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5U6rIc0fJ29jTAcaTI6/Aww3K+lZEhj845u+Q6PNhBFgSkjV
	HA89vtTCh7hv3kirG03FxXHKZxH656F8jb/FrupoqjPJFJR2UFe7GBcAawcaD28tuNXu/XptY2w
	x5RVBXwxcOCmbHMKc9LgfmeHmWBwSUJ5MU1NQR9JauCuyyDRZ0HSsPqP1Wg==
X-Gm-Gg: ASbGnctMnfxgLdPQ9TGPH5HBwbiT7Wfqbu2ScP7AT1jXjotV3yyyI+L05QV+tg86nfA
	jxNYyLHqhySASAngImU9RMR3V85cT3+eyQp985LFG4NJ9pVm/IH/e4OloHuqFm+20dLSLzGSyNx
	AT5PObn/mvgl0YuT7JEgzQrH6THX+wH26wzOj7QXDVPoVpWwyEQkxDhTgSrr2GigY++rpx/IJyx
	tdXTEUt9+gw4DsArgduXgQ8NXF7Aj1IZhPyWFz+GhNfzJEwW8NY649cIk/0S6YyLOufjm2AWuYO
	s8j0zipaYB+7Tjskj1YKqy3a/yJWgh2wWS7hdECYdvQnjcb6k+tr4Qb3kpQNaBs91eG0Z4LXVKS
	sTucB61Q5XFboJMlZ+A==
X-Received: by 2002:a05:6000:3102:b0:3fc:54ff:edbb with SMTP id ffacd0b85a97d-42410d42821mr4360742f8f.9.1759239636223;
        Tue, 30 Sep 2025 06:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK1fIV99U75p9fIG0T9bgbW2kRrus2xjFJNs0OgF8YVoLPSJiOafXYnVsiEwLidRiRgrEggQ==
X-Received: by 2002:a05:6000:3102:b0:3fc:54ff:edbb with SMTP id ffacd0b85a97d-42410d42821mr4360711f8f.9.1759239635732;
        Tue, 30 Sep 2025 06:40:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb985e080sm22686562f8f.24.2025.09.30.06.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 06:40:35 -0700 (PDT)
Message-ID: <a0006002-32c5-4595-a66f-258d4d17d52a@redhat.com>
Date: Tue, 30 Sep 2025 15:40:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/1] Documentation: net: add flow control
 guide and document ethtool API
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 f.fainelli@gmail.com, maxime.chevallier@bootlin.com,
 kory.maincent@bootlin.com, lukma@denx.de, corbet@lwn.net,
 donald.hunter@gmail.com, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 vladimir.oltean@nxp.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux@armlinux.org.uk,
 Divya.Koppera@microchip.com, sd@queasysnail.net, sdf@fomichev.me
References: <20250924120241.724850-1-o.rempel@pengutronix.de>
 <175921920651.1883014.4986159833879484611.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <175921920651.1883014.4986159833879484611.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 9/30/25 10:00 AM, patchwork-bot+netdevbpf@kernel.org wrote:
> This patch was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
> 
> On Wed, 24 Sep 2025 14:02:41 +0200 you wrote:
>> Introduce a new document, flow_control.rst, to provide a comprehensive
>> guide on Ethernet Flow Control in Linux. The guide explains how flow
>> control works, how autonegotiation resolves pause capabilities, and how
>> to configure it using ethtool and Netlink.
>>
>> In parallel, document the pause and pause-stat attributes in the
>> ethtool.yaml netlink spec. This enables the ynl tool to generate
>> kernel-doc comments for the corresponding enums in the UAPI header,
>> making the C interface self-documenting.
>>
>> [...]

I'm sorry for the mess and confusion. This should not have been applied.
PEBKAC here. I'm reverting it.

/P


