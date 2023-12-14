Return-Path: <netdev+bounces-57146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63270812421
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D7A1C213B8
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA1538E;
	Thu, 14 Dec 2023 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEZLLBjo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD73E0
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 16:50:26 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-28b05a2490bso381000a91.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 16:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702515026; x=1703119826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jcs652nAzIbSYKddMAMjdgD7OlZTEhEQLejf1Fi5XQw=;
        b=SEZLLBjog8gskhNzoxrxY/rnSMuE0umA422LxPihYFxCedvwPNrkk4T7VRDDm/p7gF
         I1pvsA1+DBfZ4ZDqF5xvHv5zoBhOhHlPF/SdoZ7T2dbPf9fm7pVYu35HBF98dzJtqlT6
         HU5bChUuHNsAtNVrlqSCcgo7gBsPnV2pBU0fHbgJRxP0N89dQ0XpVl0HtP62LAT7DWxi
         LF99V1jVKNUeWY/OapovXrkZnbdyHL4ozLrA/P8rm8UJ9A8q8zu0NP7GyRQ7hhLLwJEj
         xYQTllRFd6TJ03XGFlUG8sUE59lh6Oy0pTlMPLND+q6kyO5vjO/0WX9SJRISWIrrsNjL
         2S2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515026; x=1703119826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcs652nAzIbSYKddMAMjdgD7OlZTEhEQLejf1Fi5XQw=;
        b=QytMovcstmHoTka8Pg6G6e7QzN5W85y1leGttTJqS+5UIyTlj5NVUbYghVaLk4e+9r
         OcPa2V6LUqRPxXrSGdkBOfoeKF7k2p6Oa0/WV+PWM6cl1pE70Fz/2+5gSPMUzamSKOL9
         9yCxcITA3wNZ9iyTnxzgLFVmh8fCYaAw5DlLI8wieSkKekccMwcmAknouEMGlOIRhRA+
         umwHBHTfJLASLNq1fv46bHxhrDdgJ1wlsrbT34wLOriCnlRIwwqKzmV4ZFS9IJg936YR
         cHKC0AY02nOkFNOSMudCsvVyoCGLdnGS2wJa3NktEUnyfavsc6bfh3IFpJ4npBWqMNMy
         h3Kg==
X-Gm-Message-State: AOJu0Yy7meYg22s4Lw5PE7xEoCMclz4ZhU0GoKLTHBkL1QmdBYzHzSC6
	KiFmNL8+hPxRdedyM7b8yQE=
X-Google-Smtp-Source: AGHT+IGiGUThx07BkUZfBUl5aA3OoZsFMyxSeMvDWpHKgIw4GllABQQskbPO0zG5OLHnYzhPCaWg8Q==
X-Received: by 2002:a05:6a20:3942:b0:18f:97c:6163 with SMTP id r2-20020a056a20394200b0018f097c6163mr12701967pzg.96.1702515026216;
        Wed, 13 Dec 2023 16:50:26 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v15-20020aa7850f000000b006ce467a2475sm1762771pfn.181.2023.12.13.16.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 16:50:25 -0800 (PST)
Message-ID: <e5a35e28-9442-42c7-8d51-301bdbcc20c7@gmail.com>
Date: Wed, 13 Dec 2023 16:50:22 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: mscc: ocelot: fix pMAC TX RMON stats for
 bucket 256-511 and above
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>
References: <20231214000902.545625-1-vladimir.oltean@nxp.com>
 <20231214000902.545625-2-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231214000902.545625-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/23 16:09, Vladimir Oltean wrote:
> The typo from ocelot_port_rmon_stats_cb() was also carried over to
> ocelot_port_pmac_rmon_stats_cb() as well, leading to incorrect TX RMON
> stats for the pMAC too.
> 
> Fixes: ab3f97a9610a ("net: mscc: ocelot: export ethtool MAC Merge stats for Felix VSC9959")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


