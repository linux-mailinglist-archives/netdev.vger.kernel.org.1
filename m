Return-Path: <netdev+bounces-299564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6iVTCRxHMGoTQwUAu9opvQ
	(envelope-from <netdev+bounces-299564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:40:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F1B6893FD
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:40:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=VJ0xOSfF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299564-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299564-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46E2E3008FDC
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AB53803EF;
	Mon, 15 Jun 2026 18:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A630D3F2
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 18:40:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548821; cv=none; b=VezeoOlK8Lbq0xzSWIxIWt+NRnO4iLOAcoe/eCMNf56V8Ultz3koamNAHXqrUyV3iQdYaGJ3KZFvDUUrhR/q2OyKeoF8QXY/x/USSyXCDADeiGgbuDmuu/Wb/p1I5jMJHxm74xuqE+9H3d6P4gdQBKyPZ+peKW2gfPeMaKKU/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548821; c=relaxed/simple;
	bh=wrKYf4GizAT5zbO+BeOEg1tb5gtXb36xfiQEtSCxNmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stTGl6W5RVLxD7vpB7c7uhyYZVrHGdbd3g9uXaTbuz5Id2kEgo/z3WAGA2QXcldSuxHn/BS48rNHZBXGjWSjgE4rMbv1mzEYioC6sKDo7La7fuBpiVkBGRPTWs83k7PUjkS7gvLq5GG2ZBTZ8nn03NZ/rr3mmFdPfqE6ejaeSO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VJ0xOSfF; arc=none smtp.client-ip=209.85.161.99
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-69ec2ebec61so2459011eaf.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 11:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781548818; x=1782153618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CiuSS1vJyn9/CuxvdyXj5bFnGfBI/sZAO1SQhPV6kw=;
        b=Lyndr/RtEtE1CfrFZlbmXNizWYSkBCmEE2P7an29dLW3toseHghq9qR3OYaxADDYzH
         012DoVrxOaEB3BevivLjjMqHQD7V2DVPwlpMqEXOMls9kRuHazAyP4sWO8DLfZYoryGg
         DvUK1DlgoQ3XMFl3BiOH1+8uv/ME4SPedXcJOn2WASCStYfTGgJ1f2NKzgnRS/biHqnP
         NZohY/NuoTYkTJJz6DowLp2H/xUm5+V6RRilcC6R5zVETgkFEULh/xx7yGuewt/O1o+6
         3DOB3vRLP7gtqsnGDuJsLTnbkL9jOjnJZnTkJaRKXTTM9CN8fGJeQTa6pHp/j/TjyWlc
         Qzeg==
X-Forwarded-Encrypted: i=1; AFNElJ91Dx35WgDNkC8kmydxqvcT9MLB9DEvSUY8U/94BaX/3/o+NZy7YhpqZmkofXxzvLLNHr7c5XI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FveTnML9D+u1cQDLRqPfbLsy0Zwut3IjolIoruhuKJY+WgYt
	298TL7cr3rpiWfzn2LzMnXWlSyoaUnd+lM/HctuuZut3NRbcqVFIu5Bf29cWmDpHFEqwZAY0LFI
	w5nyANdYGOhVjf4REfyx8VXLPVQgSh+V7yzZTz6bN8C1PLKFzlJHSDSor56sij0vRH7nJhOewoI
	b2iVQmjtib0FoipH0L28xKZkAsD+D5hs/q8xqQck0bYs5yb03EsQX1QjiTMhD3KYTllcDLwQawc
	Sjz1d0JfQ==
X-Gm-Gg: Acq92OEVkBMDfyd5gNMNGHlhJzkptxa+3p+OrCiEYodf9DZDsl1OiGk4N5fAil5jFfA
	XIJqdsbwuJfFRoyxC7v5O3aln9fknjqWC/z2kQtmQygD0VuB/2GVv+Z4DFkOE/D1hvGuIT4LuNK
	41Kxz4V7sCG2TSq+Z3zEY9M1GKSa+Iap41GEA8ku6KWhUQ8NlYt2cF9hlugsl03GYs0sa42XX1W
	dDO2u0CZo8Rhem3WkwqL68WEUgU50RYlZzPtVg+ORCV9w+ZyZoqkTDqyAQr9DfR1JSEcsjCnLiY
	iygNrad3eaK9wepPfsX2+h6124jvG4Rwu527YQuJzhtdgCuJg7kwU4YX0muS0mkIM3QJR7agZn/
	a8NrizIJCszaW0Ccep8exr3jLCX4jNrHDhOhVEo5bfG12WRAQ4FiMvI/1pzwXh596YoegUB+Cm7
	ZqiiMuF/nAB8x3jtSCwAWdeHCZ4UcxIIYeiMTI/EZ1MtrT+aPmvFwbmaCqFw==
X-Received: by 2002:a05:6820:222a:b0:69e:5d68:f5b8 with SMTP id 006d021491bc7-6a0a4358d54mr315354eaf.26.1781548817736;
        Mon, 15 Jun 2026 11:40:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69f00eff02dsm356193eaf.19.2026.06.15.11.40.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 11:40:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51949579e09so61747641cf.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 11:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781548817; x=1782153617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CiuSS1vJyn9/CuxvdyXj5bFnGfBI/sZAO1SQhPV6kw=;
        b=VJ0xOSfFEfzVSmmatn/DiSuI7zzNNoxryXKa3pVsjE7uG55R0SqXd5JX5+MSTTY1dX
         mqf3/keHIBAVF/Zsd6aJhlojaBI8rx7HNANWxlDOSxdQZsib3aPMjyqByRJJXHZtQDbj
         Xl+5NFDk7M3bevDwD02t9iC7jf7C+uAcLH6VY=
X-Forwarded-Encrypted: i=1; AFNElJ+r4jRkq63h+qcJinNFSPR1RIFTmumkYbaTmyJgPRY2lwAAqtIfgwrWRv0eYwIxw0QRjPrCUBs=@vger.kernel.org
X-Received: by 2002:ac8:7f90:0:b0:519:5680:1b5 with SMTP id d75a77b69052e-519916a7bc0mr3546571cf.21.1781548816824;
        Mon, 15 Jun 2026 11:40:16 -0700 (PDT)
X-Received: by 2002:ac8:7f90:0:b0:519:5680:1b5 with SMTP id d75a77b69052e-519916a7bc0mr3545991cf.21.1781548816380;
        Mon, 15 Jun 2026 11:40:16 -0700 (PDT)
Received: from [10.14.5.238] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5196073d7fbsm65865061cf.30.2026.06.15.11.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 11:40:15 -0700 (PDT)
Message-ID: <cd541435-bd36-4768-8ad6-809bf6e536fa@broadcom.com>
Date: Mon, 15 Jun 2026 11:40:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: bcmgenet: collapse TX priority queues
 to a single queue
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260612205915.3156127-1-nb@tipi-net.de>
 <20260612205915.3156127-2-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260612205915.3156127-2-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tipi-net.de,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ovidiu.panait.rb@renesas.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,tipi-net.de:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20F1B6893FD



On 6/12/26 1:59 PM, Nicolai Buchwitz wrote:
> The strict-priority TX queues can starve under multi-queue load and
> trip NETDEV_WATCHDOG. Justin's earlier series [1] worked around the
> symptom but kept the design.
> 
> The multi-queue design was originally used for STB use cases that are
> no longer needed, as confirmed by Justin. v1 hw_params already
> exercises a single-queue path. Point v2-v4 at the same configuration:
> ring 0 takes the full BD pool, every per-ring loop collapses to one
> iteration, and netif_set_real_num_tx_queues drops to 1 via the
> existing tx_queues + 1 arithmetic.
> 
> Tested on Raspberry Pi CM4 (BCM2711). The baseline kernel trips
> NETDEV_WATCHDOG within seconds under iperf3 UDP saturation
> (-u -b0 -P16 -t60). After the change the same test completes
> without a watchdog, and a single-stream 60 s UDP run sustains
> 956 Mbit/s with 0/4952890 datagrams lost. Single-stream TCP
> throughput is unchanged at 943 Mbit/s.
> 
> [1] https://lore.kernel.org/netdev/20260406175756.134567-1-justin.chen@broadcom.com/
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Justin Chen <justin.chen@broadcom.com>
Tested-by: Justin Chen <justin.chen@broadcom.com>


