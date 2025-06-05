Return-Path: <netdev+bounces-195185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B98FAACEC63
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 10:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEFA1897A1C
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 08:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABB4205AB2;
	Thu,  5 Jun 2025 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnUBl2jM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDDA201261
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749113688; cv=none; b=Dc6WgKdwlFUyem3BhK7415EhnBcbTHK9I4Vq/wlAW4IU9PDn5NWZO+yZa0qaGK59p9aT7c8wNBXSgOGKD7t6aIttT6jwSHv+nG49YVMeJ5+CNszCLUbqwPEG3ywEh/669pNdf8eYBQaHB3zS5VQK909JDTfDfRFURb/pV1DoYzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749113688; c=relaxed/simple;
	bh=CutlBU7+XyMLmKNvb0wnN0r3s8d0HV5seP8S9U9U9tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9sQ7z03BMtEsTRBDWw9m49MbZWYI5BMnetINOy6mllnZ9DOgqaXZTN4o7vk4ce+LzKChFuPaRViKnFM5mOhtEuvMsbBekmbV6jDh4qVbRw2BPEDwMUEoIdWEeCdpBDZkAWXezJ5YcoTvDgs79dNgTIMTsLyeMl/8FSrgQsvXhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QnUBl2jM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749113685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/1IdWtLBve9hm0KYciT3eHF1BQ7n8lnOyCfBkDNIA0=;
	b=QnUBl2jMyq0S9F+2AN6+ZSNoykPDlAu/hLHicr1/zROVzUkrKyEdCZozvs1/jnG2AeEyKh
	5TTG+ezSIej4lQI0NkPIs4u7MyQdeBXDIW3ps+kuqc2GHzDRnqeKLQhe7K7JmaTMUkhOOq
	N+ZdYblJEwHBeQfcV2W9r73SEACMeXQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-aqzesm_0OrC2HymshHSKbg-1; Thu, 05 Jun 2025 04:54:43 -0400
X-MC-Unique: aqzesm_0OrC2HymshHSKbg-1
X-Mimecast-MFC-AGG-ID: aqzesm_0OrC2HymshHSKbg_1749113682
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso588255f8f.0
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 01:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749113682; x=1749718482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/1IdWtLBve9hm0KYciT3eHF1BQ7n8lnOyCfBkDNIA0=;
        b=p7dg7x4BpX3FLpSwSpANUmolAgYLC3BGyGH/jmswEggC6owdRKx8iwk+pOMujgL5zb
         Kci/Q0OGMHJDhbtxwPejh4b4eiNompbvKAhimUhN+qx+rYxpfZJceI53TT1ODQx+TjfJ
         Kk3LjIZm+A9JXI2/1D8D3bPtL+EDIxqcGc1Km7Bj2JiJr2wUxuqVSUjPWGE89wlDCxJK
         FUAD/jIAwRxGP+gSmGVWZjLtSO3zv6hAio8KCw6axE4sfXkuxMXj8HUMMMthx/wyEfv5
         eYruE5ac0eQ++/cHaSFxGvDZAZfTjf6uTSmuO3ORHPdISQZfEVseGisW2piGu8hUw+kO
         bNYw==
X-Gm-Message-State: AOJu0YwDrvREeKlspcE2l4kf+oHgtCg2+tuxVABGmi/ejcsREw6rCzbD
	nOT0W1b0lyosYRLNnPyTNkZfXWcZr4dXK+YJh0CHBOct1FwJ0JeDRYv9QRa1CXOEQTzkJcVT9PR
	/FF9lLxyNPc4Q+Wgqz8ZiCbFVYSxvEsKqvscmhRpomwHJKhRfEnSFQlC79w==
X-Gm-Gg: ASbGncu0506H+t1Yo5P61RPQUHLbw9ql5NGwoqDsnsCZMJaeD92AGXRlEoTqlcFxBgu
	42pOsXhXuP46jLQ1bX/W/QC3Y+4Bp4yurN6ka99XU2ncf2Ehm0poWYafw8cUcd9FbcKsMejrLGk
	UdHe+Exwt4JlY+o1XQReSvDtYHcbrqCV4HE44swJytV0cAvUvvkcnTz1EVQmLQPGQ/nLZ9ap1um
	xejkA/tmTkje4lRMUBFGT1Ix4PMFep3ueBvkkHRlOsPJ6HGplEN9bctsCw2rgEOKhH3tN107NxK
	6oRgIop4so5qEQfE024T+FLu6GiMLg==
X-Received: by 2002:a05:6000:26d2:b0:3a4:fc37:70f5 with SMTP id ffacd0b85a97d-3a51d97663dmr4530782f8f.58.1749113682480;
        Thu, 05 Jun 2025 01:54:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIiaKoOIdST0XEVw8SQI0Y3T3+F7x/gjWPQu2MM9OBRTBKQnLlGajPNWHulbuCo2aRANA5ug==
X-Received: by 2002:a05:6000:26d2:b0:3a4:fc37:70f5 with SMTP id ffacd0b85a97d-3a51d97663dmr4530760f8f.58.1749113682057;
        Thu, 05 Jun 2025 01:54:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cced:ed10::f39? ([2a0d:3341:cced:ed10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5247363a9sm2820852f8f.24.2025.06.05.01.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 01:54:41 -0700 (PDT)
Message-ID: <efeeaa50-cf61-4b4f-a2f0-bf15a1dfbaf3@redhat.com>
Date: Thu, 5 Jun 2025 10:54:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: b53: fix untagged traffic sent via cpu
 tagged with VID 0
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250602194914.1011890-1-jonas.gorski@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250602194914.1011890-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/25 9:49 PM, Jonas Gorski wrote:
> When Linux sends out untagged traffic from a port, it will enter the CPU
> port without any VLAN tag, even if the port is a member of a vlan
> filtering bridge with a PVID egress untagged VLAN.
> 
> This makes the CPU port's PVID take effect, and the PVID's VLAN
> table entry controls if the packet will be tagged on egress.
> 
> Since commit 45e9d59d3950 ("net: dsa: b53: do not allow to configure
> VLAN 0") we remove bridged ports from VLAN 0 when joining or leaving a
> VLAN aware bridge. But we also clear the untagged bit, causing untagged
> traffic from the controller to become tagged with VID 0 (and priority
> 0).
> 
> Fix this by not touching the untagged map of VLAN 0. Additionally,
> always keep the CPU port as a member, as the untag map is only effective
> as long as there is at least one member, and we would remove it when
> bridging all ports and leaving no standalone ports.
> 
> Since Linux (and the switch) treats VLAN 0 tagged traffic like untagged,
> the actual impact of this is rather low, but this also prevented earlier
> detection of the issue.
> 
> Fixes: 45e9d59d3950 ("net: dsa: b53: do not allow to configure VLAN 0")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
> My favourite kind of fix, just deleting code :-)
> 
>  drivers/net/dsa/b53/b53_common.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 132683ed3abe..6eac09a267d0 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -2051,9 +2051,6 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
>  
>  		b53_get_vlan_entry(dev, pvid, vl);
>  		vl->members &= ~BIT(port);
> -		if (vl->members == BIT(cpu_port))
> -			vl->members &= ~BIT(cpu_port);
> -		vl->untag = vl->members;
>  		b53_set_vlan_entry(dev, pvid, vl);
>  	}
>  
> @@ -2132,8 +2129,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
>  		}
>  
>  		b53_get_vlan_entry(dev, pvid, vl);
> -		vl->members |= BIT(port) | BIT(cpu_port);
> -		vl->untag |= BIT(port) | BIT(cpu_port);
> +		vl->members |= BIT(port);
>  		b53_set_vlan_entry(dev, pvid, vl);
>  	}
>  }

Makes sense to, but it could use an explicit ack from Florian...

/P


