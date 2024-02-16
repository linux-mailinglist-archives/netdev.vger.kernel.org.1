Return-Path: <netdev+bounces-72470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C48858407
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 18:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00855B24E95
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2033132463;
	Fri, 16 Feb 2024 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEijW6hV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DCB130ACF
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104188; cv=none; b=k0/J6N0egNTaNhQb6ZS9NHZCHu1OhcyGqA54a5PlsylKXHQRQ0OyF5UbJzYSH0R0PE+oLd6eGoD6JFrZtQBH6jgSBOLvo8E4VYmtnJGn0F69XiU+id+3oT6KvORUu7z7OIW+1j5rMABLE8WAzFv6RXuxaiI5Dx18y3NtNK8rVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104188; c=relaxed/simple;
	bh=4VNqwWcNovpQmPlGPs3gVH/X8Q0eq2Yp9WgBtx6RRIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjqmSYxqhURpT7AVmDRyZPvv138IpH1iRBFv0hJaDOFrdhor8wX97YygwYldz0yf++KIcl27toPSB/xxiwgg3QzjB0GBH8ywvlY7dAiTNtFPZnNDrwBWFbNrex0peD4YMzVj/MLPYRWHHUmuBhtK3u6mVVPlT5jfK5cy23TAl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEijW6hV; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-785db3fe7feso134740185a.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 09:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708104186; x=1708708986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2FSsMp/j/j+Tpy2oWQhYEvIjcrFM8Hp4iBY0aB1Vlg=;
        b=DEijW6hVILuQh3xArk9CnkC0ANbKjr1ACBse+zOykOgScZVj9c2uyej0nq+p2zEiPa
         +E/q9kAbNkiS/nnbvIoeHOle+pqtJXyqD0QBUsBY5dPlMGKm3enn/rqutK09OXj99GhI
         67nOkXd7RAlIbQ623cEqeb/BROc69l1Y7ef8Lyf2qoxRQCSec7HHEwFkVPX/jG+Us5If
         uWqk2XKeri0scdNPjYSn44T0ntjLzAnIgxR9FEJVdsBi4xH6Cog3OS/A49BWhcs1B3kK
         Pf48w/VDKb+yzA/KkcyHqtFoE63WM7cylfordN2/2wAcST7BNvKwptR8pT52avleEvu/
         p5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708104186; x=1708708986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2FSsMp/j/j+Tpy2oWQhYEvIjcrFM8Hp4iBY0aB1Vlg=;
        b=AWEnU+l2Tk3jtx9KcPgAzt6BgTxz+Fq5tkFqbwaN53J2qXllx7b4C9nmxV2oWRyaz/
         52/iw6C5x7Gy/XdV7oZ6K4RCa2l2u0rHK83im5u7QzQhHHr02saYyAkAKmuW77OIZXo5
         RoQ7eZGGEqhzdn7VH+grmOvnT3Pk9MnHtYvIwu6DKtf7LFyjN+1jQhrO0+1wn0tywluj
         tMA41pYRjYbOnE4GkfUwjGOUWmdInzcbN2Tviq5JCbZFpAQvWrWpxLz6HanUUShKwgSG
         dEEiCd8FSnsAgDo3RQITBiB7ykyDIUmO2MGtKicAk+1uPPaiWBNtwAPu6ybi4k7W3Jg4
         TA6A==
X-Forwarded-Encrypted: i=1; AJvYcCUGZz3lhVWU5EHw1ZpmWB+PbLHQrOEluF3FT6PNBYxSVqwgUSnOc0qzQRxI4eCKaI6RkrxfpPrVnj+nGntyWSjNVSRqHYMe
X-Gm-Message-State: AOJu0Yw1ytFeNpRsqXk+1gw6vVK9a36c3zIm5t76NTTb6xGl+JfPGYJ7
	P0nvxhkKu1/qoMI1sczoi86KJjAR5Ocyyr2qQ48CPkF5B8ZZK2pNiy6IASQhkEM=
X-Google-Smtp-Source: AGHT+IGMZoPP/WR5CuR6NmzAMH7WuIWg/feFmuX+gqgDA8omahrSi625baVAmj/oYtljpaXAwZgtvg==
X-Received: by 2002:a05:620a:983:b0:787:3786:a01f with SMTP id x3-20020a05620a098300b007873786a01fmr5429226qkx.1.1708104186029;
        Fri, 16 Feb 2024 09:23:06 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id wa23-20020a05620a4d1700b0078742e741cfsm132584qkn.61.2024.02.16.09.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 09:23:05 -0800 (PST)
Message-ID: <2308719d-1994-4cd4-a6b1-8ee3ec291caf@gmail.com>
Date: Fri, 16 Feb 2024 09:23:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VLAN "issue" on STMMAC
Content-Language: en-US
To: Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Jakub Kicinski <kuba@kernel.org>, kim.tatt.chuah@intel.com,
 "Ong, Boon Leong" <boon.leong.ong@intel.com>, vee.khee.wong@intel.com
Cc: davem@davemloft.net, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 netdev@vger.kernel.org
References: <20240130160033.685f27c9@kernel.org>
 <7cfc9562-161d-4d6c-a355-406938b3361e@foss.st.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <7cfc9562-161d-4d6c-a355-406938b3361e@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Adding original authors,

On 2/16/24 06:35, Christophe ROULLIER wrote:
> Hello,
> 
> I've a question concerning following commit:
> 
> ed64639bc1e0899d89120b82af52e74fcbeebf6a :
> 
> net: stmmac: Add support for VLAN Rx filtering
> 
> Add support for VLAN ID-based filtering by the MAC controller for MAC
> 
> drivers that support it. Only the 12-bit VID field is used.
> 
> Signed-off-by: Chuah Kim Tatt kim.tatt.chuah@intel.com
> Signed-off-by: Ong Boon Leong boon.leong.ong@intel.com
> Signed-off-by: Wong Vee Khee vee.khee.wong@intel.com
> Signed-off-by: David S. Miller davem@davemloft.net
> 
> So now with this commit is no more possible to create some VLAN than 
> previously (it depends of number of HW Tx queue) (one VLAN max)
> 
> root@stm32mp1:~# ip link add link end0 name end0.200 type vlan id 200
> [   61.207767] 8021q: 802.1Q VLAN Support v1.8
> [   61.210629] 8021q: adding VLAN 0 to HW filter on device end0
> [   61.230515] stm32-dwmac 5800a000.ethernet end0: Adding VLAN ID 0 is 
> not supported

OK, so here the VLAN module was not yet loaded, so as part of the 
operation, we get the module, load it, which triggers the 802.1q driver 
to install a VLAN ID filter for VLAN ID #0, that fails because there is 
a single VLAN supported, and this apparently means VLAN promiscuous... 
not sure why that is an error, if this means accepting all VLANs, then 
this means we need to filter in software, so it really should not be an 
error IMHO.

> root@stm32mp1:~# ip link add link end0 name end0.300 type vlan id 300
> [   71.403195] stm32-dwmac 5800a000.ethernet end0: Only single VLAN ID 
> supported
> RTNETLINK answers: Operation not permitted
> root@stm32mp1:~#
> 
> I've tried to deactivate VLAN filtering with ethtool, but not possible 
> ("fixed" value)
> 
> root@stm32mp1:~# ethtool -k end0 | grep -i vlan
> rx-vlan-offload: on [fixed]
> tx-vlan-offload: on [fixed]
> rx-vlan-filter: on [fixed]
> vlan-challenged: off [fixed]
> tx-vlan-stag-hw-insert: on [fixed]
> rx-vlan-stag-hw-parse: on [fixed]
> rx-vlan-stag-filter: on [fixed]
> root@stm32mp1:~#
> root@stm32mp1:~# ethtool -K end0 rxvlan off
> Actual changes:
> rx-vlan-hw-parse: on [requested off]
> Could not change any device features
> 
> Do you know if there are possibility to force creation of VLAN ID (may 
> be in full SW ?) and keep the rest of Ethernet Frame processing to GMAC HW.

It is not clear to me how -EPERM ended up being chosen as a return code 
here rather than -EOPNOTSUPP which would be allow for the upper layers 
to decide how to play through, not that it would matter much here,
because we sort of expect the operation not to fail.

Can you confirm that dwmac4_get_num_vlan() does return 1 single VLAN 
filter? Also, given the comment about single VLAN and VID #0 meaning 
VLAN promiscuous does this work:

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c 
b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 6b6d0de09619..e2134a5e6d7e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -492,10 +492,8 @@ static int dwmac4_add_hw_vlan_rx_fltr(struct 
net_device *dev,
         /* Single Rx VLAN Filter */
         if (hw->num_vlan == 1) {
                 /* For single VLAN filter, VID 0 means VLAN promiscuous */
-               if (vid == 0) {
-                       netdev_warn(dev, "Adding VLAN ID 0 is not 
supported\n");
-                       return -EPERM;
-               }
+               if (vid == 0)
+                       return 0;

                 if (hw->vlan_filter[0] & GMAC_VLAN_TAG_VID) {
                         netdev_err(dev, "Only single VLAN ID supported\n");

-- 
Florian


