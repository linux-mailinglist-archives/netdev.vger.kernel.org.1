Return-Path: <netdev+bounces-282312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFksFYzK8Wn+kQEAu9opvQ
	(envelope-from <netdev+bounces-282312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:08:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C6D491910
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2427730CA90C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7F23BE155;
	Wed, 29 Apr 2026 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="BW2o4e6U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725E43BC69D
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453471; cv=none; b=Md3PYSTJHUFSNpKDmmZYWtRKQFHauA5/b7dtNAHkIsk8Q/dmbP2OX9ZvPqmw9iGtWkOE+bHcaBJ26byQBoVVtncvOXRbdqb/gy67OEegS5emsdjB+2dKisuxvJrB78vlA0En24S4ID2lgjUPPE2W1kRFXKRN6UMN/kzm/tQN1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453471; c=relaxed/simple;
	bh=qSb3SGcwsDkoHlK03XEymnt83+9LDsaxAxUN607t7f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8DKysEkLWoQN6RIEyvCXL0XzeZVN5Sd/P1DWaYvCS1Hn7MaaE9AYFm5VIZBKBj0FK1qvZX00X4h9Dh929HnzWDc6pPgpOJD/aobVeKODLYHxirISwNhgRTfnn4eLLZsk6eSHHlKco0U0ZVROD9RCSIPi8w+7XWc60RNiZas8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=BW2o4e6U; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d77f6092eso8557627f8f.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777453468; x=1778058268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkrOQ/G+RJZornxNRPNTMjR8gIzBGAkvbEb+2nxyTLg=;
        b=BW2o4e6UfLPAWck8gz2OITAGDUhrsdTFJBacHejebF3U6qk+YQlr05SJoNP/HvCtAn
         sqNUHxaol/shN0b//ErMfRquzqvFPKIEP/53E1OkG59rCY+lEdYfAmnTgqm47VSCJHEW
         s4mbe79bTiOFuD/cQSXMN6s+gdwh11Ly6DyQC7kow+1oHZXBFAeoiOwiiIxN2OISXSj3
         AYPJIeedXgFUM+sdDLDu9OaWNp0LeRwPNBoZNpcVzpABEEsBXCz0fO/cN14EghTHaWm9
         D0BZnT1eg5Hns0U4oxZLcgqQdmka/11q5qCiV2RwOvS0JbjijI/8B0gDz2zJ2QVUeI5Z
         vdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777453468; x=1778058268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkrOQ/G+RJZornxNRPNTMjR8gIzBGAkvbEb+2nxyTLg=;
        b=SIhigEFM2TqGBUEtzogiCLSP1qlJS3YZV5xpHMUCGkScCmKRIKaQIDP3otqFPuC4tC
         21QzkYNqRJKmADssvspCowBWbIKy3t83MXhyOtDbbCh2hHgGgS1SZHFasEDzLf4/X8x7
         sxq2uqb0A2dhbWAWcvBhIWqGn5Mu9txws0U/OY/iR37OGYAKmKS8g5ucFPb+wirp8lSg
         puzen9oSg9QxaO0aax6jvib+yBsDMfvd2CQDvMdWOMGDcvbWy7nZo1Q7L94pnOoAcabn
         sEOCPxzZZqJ9RYYm7cvOxw6O3B546kPJdpwrDoHwinWQgx5tU94CqDyEstudnhCrROPv
         wCsg==
X-Forwarded-Encrypted: i=1; AFNElJ8QNfeyqXOJw7XLYcMhK/oaatQ/Mb6gDj4nhb58TJj9pvQ/dO5/4EKz9nBU9OWkLJFwDLVwQ4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvA4k5yKTrVizfURjMis8zraXvVtz7pJwoVlJ9gJvaI8KNXcsf
	SkSTaVxWOC+eazI6rOIqrkNsUUO46xogsFTm+dhzmMd/m4h08CDLAFWVLp8Je6nl0KM=
X-Gm-Gg: AeBDievfeb2T4LAv5Sl+pa98Kdj+S8vzhO9RqcmNui4/3hdxij1Xqpk8t5zAmrL9d1F
	lp428PggPIK2xBAOufSHMib9ZJsxlsxfLiXVRDqeYFicjlqErf6bfy5CwIMdmhRBaQBV/d+2rXB
	U8x7RUTCRW7O3LP93dI6KPSdENnetIqTM1388lwxUn+rrHRt98rF6xNhDPaASEeHhtRlbr11hjw
	88kXr82n0rhItZTrjy52+niybakxLhszUseGnIFhgX4P3gv+GGMLJ+EpDigUXavJFyKIeFlCp9s
	AKtLoh6PBSuN4VuQDFd4nmzsdYfQfL3zDmEYwYzBUHK6syJck5qlvLGoig3+42JcUJ9K0LmS0BU
	6hzO8Ov4WhUivyPXjsdwH+rYhzmjy3ptM425whVZ5549BHekCh3lRQy4UoBPrKBlwmKmVmz2vfg
	G3VEfayK0tIza795kXq+9CSixjM1M0qNUfkjT757Yi50PbyBAzXmNVKSZtmgiC+mDh
X-Received: by 2002:a05:600c:4645:b0:48a:7aad:4425 with SMTP id 5b1f17b1804b1-48a7aad4537mr42583695e9.3.1777453467792;
        Wed, 29 Apr 2026 02:04:27 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2d3811sm20967725e9.3.2026.04.29.02.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:04:26 -0700 (PDT)
Message-ID: <efa4eaf9-0c5f-4cea-ad9d-dd1052ccab76@blackwall.org>
Date: Wed, 29 Apr 2026 12:04:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: net: Add tests for ARP probe and
 DAD NS handling
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260429062405.1386417-1-danieller@nvidia.com>
 <20260429062405.1386417-3-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260429062405.1386417-3-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B0C6D491910
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-282312-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,blackwall.org:email,blackwall.org:dkim,blackwall.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 29/04/2026 09:24, Danielle Ratson wrote:
> Add test cases to verify that ARP probes and DAD Neighbor Solicitations
> are handled correctly by the bridge neighbor suppression feature.
> 
> When neighbor suppression is enabled on a bridge VXLAN port, the bridge
> should reply to ARP/NS messages on behalf of remote hosts when both FDB
> and neighbor entries exist, and the answer is known. However, when
> either the FDB or the neighbor exists, ARP probes / DAD NS should be
> treated like regular ARP requests / NS and flood to VXLAN.
> 
> Add two new test functions:
> 
> neigh_suppress_arp_probe(): Tests ARP probe handling by triggering
> duplicate address detection using arping -D. Verifies that probes are
> flooded when the bridge doesn't know the answer, and suppressed when FDB
> and neighbor entries exist.
> 
> neigh_suppress_dad_ns(): Tests DAD NS handling by constructing DAD NS
> packets using mausezahn and verifies correct flooding/suppression
> behavior.
> 
> Before the previous patch:
> 
> $ ./test_bridge_neigh_suppress.sh -t "neigh_suppress_arp_probe neigh_suppress_dad_ns"
> 
> Per-port ARP probe suppression
> ------------------------------
> TEST: ARP probe suppression                                         [ OK ]
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: ARP probe suppression                                         [FAIL]
> TEST: FDB and neighbor entry installation                           [ OK ]
> TEST: arping                                                        [FAIL]
> TEST: ARP probe suppression                                         [FAIL]
> TEST: neighbor removal                                              [ OK ]
> TEST: ARP probe suppression                                         [FAIL]
> TEST: "neigh_suppress" is off                                       [ OK ]
> TEST: ARP probe suppression                                         [FAIL]
> 
> Per-port DAD NS suppression
> ---------------------------
> TEST: DAD NS suppression                                            [ OK ]
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: DAD NS suppression                                            [FAIL]
> TEST: FDB and neighbor entry installation                           [ OK ]
> TEST: DAD NS suppression                                            [FAIL]
> TEST: neighbor removal                                              [ OK ]
> TEST: DAD NS suppression                                            [FAIL]
> TEST: DAD NS proxy NA reply                                         [FAIL]
> TEST: "neigh_suppress" is off                                       [ OK ]
> TEST: DAD NS suppression                                            [FAIL]
> 
> Tests passed:   10
> Tests failed:   10
> 
> After the previous patch:
> 
> $ ./test_bridge_neigh_suppress.sh -t "neigh_suppress_arp_probe neigh_suppress_dad_ns"
> 
> Per-port ARP probe suppression
> ------------------------------
> TEST: ARP probe suppression                                         [ OK ]
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: ARP probe suppression                                         [ OK ]
> TEST: FDB and neighbor entry installation                           [ OK ]
> TEST: arping                                                        [ OK ]
> TEST: ARP probe suppression                                         [ OK ]
> TEST: neighbor removal                                              [ OK ]
> TEST: ARP probe suppression                                         [ OK ]
> TEST: "neigh_suppress" is off                                       [ OK ]
> TEST: ARP probe suppression                                         [ OK ]
> 
> Per-port DAD NS suppression
> ---------------------------
> TEST: DAD NS suppression                                            [ OK ]
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: DAD NS suppression                                            [ OK ]
> TEST: FDB and neighbor entry installation                           [ OK ]
> TEST: DAD NS suppression                                            [ OK ]
> TEST: neighbor removal                                              [ OK ]
> TEST: DAD NS suppression                                            [ OK ]
> TEST: DAD NS proxy NA reply                                         [ OK ]
> TEST: "neigh_suppress" is off                                       [ OK ]
> TEST: DAD NS suppression                                            [ OK ]
> 
> Tests passed:  20
> Tests failed:   0
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   .../net/test_bridge_neigh_suppress.sh         | 126 ++++++++++++++++++
>   1 file changed, 126 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


