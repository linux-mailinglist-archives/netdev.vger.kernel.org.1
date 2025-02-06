Return-Path: <netdev+bounces-163558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC839A2AB0B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03093AA3FF
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B2221A457;
	Thu,  6 Feb 2025 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="MO050eGm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65C1C7001
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851725; cv=none; b=jHusY83A8EhVj76nquHRpL2Up48/EhqGKyhiibLSen56/JP6m4PwuAseCChS82c9UtWVTrCUn9x8FgVEaGAxlxavWScFePGAriCld2eZJ3+qpe4qrtzSrpVRAPF4dM/FPkDoQwzfRGi0G0lSSNx3lEr7aV5DG9p7JHhcpXG2gD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851725; c=relaxed/simple;
	bh=Qaii/4wx+f4RmmjpA6Oq2TvM5/xDsmQW0adSKnoxq2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsHGLkT6r0huumcHKFp21Rtg9ThI0c20iH9fzl8+Zf74s0LGWhsw+aB2U9EhhDoxta5s4n6YSHDdT+RqTKVMPw7KiwcQGE2zDVa+b2G6mam0uvUxXmX0vtRau41qOT9r0PL+1svnWW8MYVaAgX9AeGo61NceO90B2pXym9Q2vYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=MO050eGm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de3c29ebaeso211147a12.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738851722; x=1739456522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtE/V7UyaqCUm/jEvMcWRgFAvov74MHFiHvUqv3+ay4=;
        b=MO050eGmjK/sLxg+xPlq38AlkYnYkbbKteI/rJ0aqIRCdPLKnY2rMuCebzO6HhcGzB
         D8ews4ueLmM0QiITwODmLDz/PjSwMEi076XIe9NIkH/e9AMjpSmc0Ug63G8Jj7OZ9dNn
         e3N2VbEFys4pdIpZ2TB+HwMT+6Q8ADiK5iTlWeAYlJCt+eDKrfKy2tW5B/aaWOcce0lJ
         dAzr56scpiMlO41OqLg3wuIcDOo1yku3CcVAx83AzgtTdQLRb5euOk1iVmissu8QH6oY
         iFymGu0QkWAZsBepxsRZ1gG+rmOSl//AZ2rPiasiPYLRZVyaRcOWPbo2XH/HrdgJgDbt
         IaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851722; x=1739456522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtE/V7UyaqCUm/jEvMcWRgFAvov74MHFiHvUqv3+ay4=;
        b=GIxpg544OaxLl7JfdCSlRnjE3e1pPkmyc7wkHkpThl7k/sDc8gkq+00t2l8B4UxkMv
         LPyh6yociXJe2xAvJAqTz5nQIG/8SE3YXSkXqjbuvJW8c6JoZBbJQjImiNljE0iQ15LP
         kB152fh7FiucM0DcU5QAiUDbd8dogdc2jE67KyIHDlmaHWRoDT71wEd7yPGHjJKc850t
         A00G2KMUl0RuDR+0kZA/1AKOqDBHPyJz0zyqAFByqJ10/smAVhAKvvsVTSoQ+7DYzphl
         B6h9seUJVSX8hoavCCuVpZgt1bailb5+MraHbs++OmU8xroosEzXjZ5XKtcXCsM1zzy0
         wl0Q==
X-Gm-Message-State: AOJu0YyUiWlTt+e13erFEd2dDTLeNBmGXL1eKytdRhnwgOK1r2nWFfhz
	woOlGhEs4VIiLbh3iesev5suEDJwNMii/MluwKrxNueeKsHCKhittkpzV5/rkkA=
X-Gm-Gg: ASbGnctpCL4l9OY04kn4uR8Ri7DJvt2Z42cipbNvOj6NZaCKEy35TpH0hGRpnEEECf+
	MQQNnsmnLkHwAdoiN3InfNTjsZTRBSiCbd+pWUK4aGKqmr5EfKBEQg+kdlrTn0XVnxn5bBmHpqW
	tf1e+LcmzPVfztTFGlWuUmu0cRamW/Rpaf8oTBt1JtPWgbk3dvf3tZ4bUj0LLaoZmm/aCShOmpA
	IOc/OU8JTGid5LI6muOf+KhkV0dAo8n2qRkhTN9gzJrnRoCmUE3QE0HuN+96JrP31a2hS/9YJqD
	dDnS3XSxtob3C2iGj2e14BMD+QQqHbQczQbii08qc8a9Okw=
X-Google-Smtp-Source: AGHT+IEe7WdSsNkjgnty/HyvHskjlhljY6wt44W4IMiUaDBB3MI2H2nfwFKZUIVfpj7A/eSHa7SXrA==
X-Received: by 2002:a05:6402:4486:b0:5db:f423:19b9 with SMTP id 4fb4d7f45d1cf-5dcdb72958cmr8121194a12.16.1738851721184;
        Thu, 06 Feb 2025 06:22:01 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b85a3fsm941354a12.46.2025.02.06.06.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:22:00 -0800 (PST)
Message-ID: <cd2926cf-b32b-4de7-851e-97a3ce2118af@blackwall.org>
Date: Thu, 6 Feb 2025 16:21:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 12/14] bridge: No DEV_PATH_BR_VLAN_UNTAG_HW
 for dsa foreign
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250204194921.46692-1-ericwouds@gmail.com>
 <20250204194921.46692-13-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-13-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> In network setup as below:
> 
>              fastpath bypass
>  .----------------------------------------.
> /                                          \
> |                        IP - forwarding    |
> |                       /                \  v
> |                      /                  wan ...
> |                     /
> |                     |
> |                     |
> |                   brlan.1
> |                     |
> |    +-------------------------------+
> |    |           vlan 1              |
> |    |                               |
> |    |     brlan (vlan-filtering)    |
> |    |               +---------------+
> |    |               |  DSA-SWITCH   |
> |    |    vlan 1     |               |
> |    |      to       |               |
> |    |   untagged    1     vlan 1    |
> |    +---------------+---------------+
> .         /                   \
>  ----->wlan1                 lan0
>        .                       .
>        .                       ^
>        ^                     vlan 1 tagged packets
>      untagged packets
> 
> br_vlan_fill_forward_path_mode() sets DEV_PATH_BR_VLAN_UNTAG_HW when
> filling in from brlan.1 towards wlan1. But it should be set to
> DEV_PATH_BR_VLAN_UNTAG in this case. Using BR_VLFLAG_ADDED_BY_SWITCHDEV
> is not correct. The dsa switchdev adds it as a foreign port.
> 
> The same problem for all foreignly added dsa vlans on the bridge.
> 
> First add the vlan, trying only native devices.
> If this fails, we know this may be a vlan from a foreign device.
> 
> Use BR_VLFLAG_TAGGING_BY_SWITCHDEV to make sure DEV_PATH_BR_VLAN_UNTAG_HW
> is set only when there if no foreign device involved.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  include/net/switchdev.h   |  1 +
>  net/bridge/br_private.h   | 10 ++++++++++
>  net/bridge/br_switchdev.c | 15 +++++++++++++++
>  net/bridge/br_vlan.c      |  7 ++++++-
>  net/switchdev/switchdev.c |  2 +-
>  5 files changed, 33 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


