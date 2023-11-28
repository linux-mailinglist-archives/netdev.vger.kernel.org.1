Return-Path: <netdev+bounces-51879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF457FC9DD
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 350B5B21723
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5B25027A;
	Tue, 28 Nov 2023 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="SLr7cxs2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093311990
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 14:47:12 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cbe6d514cdso5026338b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 14:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701211631; x=1701816431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd3hkm7N4zMrSZZSV9Az6JzA6RfKWL5wxF0E2CszxGM=;
        b=SLr7cxs2uGlPYoUhtmhPxszlEXATrzCaeCOMyVJ70Yv31u3vk/vfhL4QYmfR+AuKB0
         qRVDC0SAUGvWSFPDW/vE/hoHITar734V0bu9jiC8xhqytphfd+3K/cEV4j5s7L8TA1Wq
         Zmi8/SEF5Dbkiz3+iSbszfBTxKlY/PdIEuvBXyI8125X7b0+vBRkXeB0bN4RLVuJix0a
         nwfwuaB2LpFZdJ7jzOSmDpb37McvvYYVy60vy8emL78bB+CTR4dPFJEc+SxpUnOFrOmx
         ZQfaz5t/z744OZko8cHFj+Vv6lRcrzbbKJFs1WBGmv9TczXdOpuMZeufm0eC0mwdqEVB
         kxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701211631; x=1701816431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vd3hkm7N4zMrSZZSV9Az6JzA6RfKWL5wxF0E2CszxGM=;
        b=xJofrwQOs4R3sBswlgdXHV+6rw/LcHMKON5IQ0Cle2oDCs1faSzzIIxlNFVIbFx39a
         dUZdiaKpK0q5xujJbBbwIngvAOwLGdB4PVzwhOqnk0mbPXK3vcXKXkQ1r2AeobiNrTuU
         D6SDttCdI2NVsu4F3OnMlQF6ap9CRZgFOuizC/JqSm6ClfjU/FSf3IpfNOAUgxHy5UzS
         0lo0wz5fIiP2oE4hodilVnQga8nmCaTsPDD4L3HlQCw+XqJ2yXibO6EkDBpr/BSfkHDa
         UPwW1GTqQINnqdKcAwsgSQus5ZlUYtjWAqNQko6JbvIXy8ZnrGK6lUO/UbWLjbqdViVj
         EsDg==
X-Gm-Message-State: AOJu0YwKuH6CFV7Rh1R15RtZJYvFZw9Z4pzCqVJiEtasHb7nFRFOeo2K
	raYZgU8naBY1XJdu8xcyoqiTog==
X-Google-Smtp-Source: AGHT+IGQLOfw8W3oIOoJOuydcgamHILSyHU6y+vO0hdPhmqA2Ro3z9FmN9k+ZA9amC7qF71sR5bVPA==
X-Received: by 2002:a05:6a00:2909:b0:68c:69ca:2786 with SMTP id cg9-20020a056a00290900b0068c69ca2786mr16719561pfb.34.1701211631495;
        Tue, 28 Nov 2023 14:47:11 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id r10-20020aa78b8a000000b006cbb3512266sm9438024pfd.1.2023.11.28.14.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:47:11 -0800 (PST)
Date: Tue, 28 Nov 2023 14:47:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel
 <idosch@idosch.org>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa
 Prabhu <roopa@nvidia.com>, Florian Westphal <fw@strlen.de>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld
 <mmuehlfe@redhat.com>
Subject: Re: [PATCHv3 net-next 04/10] docs: bridge: Add kAPI/uAPI fields
Message-ID: <20231128144709.3c6ae4b3@hermes.local>
In-Reply-To: <20231128084943.637091-5-liuhangbin@gmail.com>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
	<20231128084943.637091-5-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 16:49:37 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

>  
> +Bridge kAPI
> +===========
> +
> +Here are some core structures of bridge code.
> +
> +.. kernel-doc:: net/bridge/br_private.h
> +   :identifiers: net_bridge_vlan

Add a reminder that kAPI is unstable, and can be changed at any time.


