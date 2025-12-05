Return-Path: <netdev+bounces-243857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B687CA89CF
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 630BA30310F0
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27540358D33;
	Fri,  5 Dec 2025 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUUE5Ph3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB0358D32
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955186; cv=none; b=gC+MnszKTC4yHvaAXSFDKBip3gzPzLUikQOO/f1jKBoXer/BjVEulkdv18QGPUcD0Cgl5//Hioao3vb/luxyNtlegJOgeDWuhdiKLgPHTuexH6WngFAwcZsffxBmQxTuNH80lmFxhnBdN1JeHlJe3xo7gO5xAcmtx08RC3vTv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955186; c=relaxed/simple;
	bh=d0E31dwnA9QtATygPQhahoZBqbbpI8qHTSQotXC5BQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5A3Xc1jwKiBJ+JoFsL4cgzdysHqvMRMCRrzx9nIIsG+888VxgnH/60wo77Dl10giBnd4bu3hRdKmejqNLv9gvBFzds9TbWDvoQWi0a8AukCplvkJZn9po1zHy/wXlNWROOzx8uz2SQQbAr2UCAVo7+lJhm/MST9yieNI3h4BIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUUE5Ph3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so16472745e9.1
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764955182; x=1765559982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bk6//AWftvDURXcOHFt6xDP3ZB1s/IOhurGTZ+M7B/o=;
        b=IUUE5Ph3ccW97mNuFRDpzuu98RHxXwJyhtk5HQpCrpfXaWZQyyBWkMY/BMEoLXhxo8
         FbIF7OKlU6vglfnZ4mtMa128wB+YaOpXnasT95ag9lAcY5kxMEmo8Q+GyQQn9LZV/FWC
         CHfAqVHcAxVlmgUJXyWmbf32i9zAw3pKozHIBrgZgEF6TTJMWMzWhNww9rNQPQM8WiAc
         l0LXFptBSIC+zwI41YeEAYhmnzws00U8jDIUWMU08x405mZ4Dhx52AMymnJdCkVt4FKm
         jXEnjb5U2gkSH8IojpaYCRGq3K6Tn/360yQK9lgk2EJIa/SWJmloLB9MRPpuoLs3yvbZ
         NN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764955182; x=1765559982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bk6//AWftvDURXcOHFt6xDP3ZB1s/IOhurGTZ+M7B/o=;
        b=U0Vz44gb5303YgX4BVYd9zmyufkg5xc92dPz50mfc5znKl64YUUheze9CGWzhSYLT6
         QOvw4Yk08vlyZ2ddqq8nw5x52ztQJ8fL/WazPaOV1X3G43dFjot1Fw8f2y9RvmtarNHk
         oYle/Q2pU+OjFOCZSAvH3L+NKTnhmMv1WxT5DGDPNOFEeuB/9JObWKr+Nf9tQaR1UEgO
         a7GUhgJ/ZGwnSwBAfvtA28HTlrTdMy1a65Y+GUlQT9An+jdDgq9fnaLp/5tXYBGQ9hcr
         5hJ8J0P3SHmeP565Avgg121hVBbr2ELrVTsEuoJLQ+wVzqu3xaMaXYGBidLUJ7w0vJN0
         KPjA==
X-Forwarded-Encrypted: i=1; AJvYcCUygMKc0Ba8jHMKj4bLrGC8+ID1SR7ozLKikIgXuL2xhFXRgpJQjcIFxBczR2Tf5Eo+1s8NVlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuYKjogHq9jhwk7fMdCR8iNxxvwizT7NnoU+p/vI/oSgPbiXG8
	+A53n9qiezNSMPtN9I+OclRQw1ZP314xmxlGagAcaKgCsAHJ/ppjBFeU
X-Gm-Gg: ASbGncvQdcmsxwLtBZxI6Ofryw3bj4LEJg8QqCVFxE4xT4ZTKp9C30v/DXCTNe/JydY
	SA6XACrpvEDAgM5XaKuQF7G0H/cYpSYFC6g//QAndZZVvgvs9p7c175OmNt/p0ydOFs/rx056qj
	U8XOv3Y8Hp6ae1MS8cBrmWQ6OgOUE5oeJSCJWhX3FR8oXRKYziICU1nlBaNyFg3tNaXOrm/fQ5X
	jHb2hfW8Oq+Cruy3UKlwBApz7O5p4aw9TYf3VHkXppvQraGIrt9r+XvHvk6OKvevuBSXrVSFi1/
	edybESPv/lS5GseUOhwGy7T2HVIb/9IbkQjaaJ1FeeyXxAQmzDBgq0G+WeRkU+eMGqCCPtSDlGz
	I5Okjk+1EWIpfgrL05dvF5pOqgh0hcyLhB9KRqGcJjhsJWybS365ZFLbQwORoi+ert3iegOSpSk
	ora56d8BNga3LRob8bCtAz0jZF5bSYy1malq8Oq4xIORARCRq/myld0WmRNhLPqBzToPhEBF3cT
	w==
X-Google-Smtp-Source: AGHT+IF4STrgN3tdVC+GpuM52fvlD82EGFyqkvDMsdTeELy15hiiehyNT4p5U21o5O9SwpQf4dfgHA==
X-Received: by 2002:a05:600c:4e4f:b0:477:abea:9028 with SMTP id 5b1f17b1804b1-47939df2615mr281045e9.6.1764955182387;
        Fri, 05 Dec 2025 09:19:42 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479310ca502sm96772465e9.7.2025.12.05.09.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 09:19:41 -0800 (PST)
Message-ID: <3f391457-d43c-4bd2-bd96-a5701a08e9eb@gmail.com>
Date: Fri, 5 Dec 2025 17:19:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sfc: correct kernel-doc complaints
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-net-drivers@amd.com
References: <20251129220351.1980981-1-rdunlap@infradead.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20251129220351.1980981-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/11/2025 22:03, Randy Dunlap wrote:
> Fix kernel-doc warnings by adding 3 missing struct member descriptions
> in struct efx_ef10_nic_data and removing preprocessor directives (which
> are not handled by kernel-doc).
> 
> Fixes these 5 warnings:
> Warning: drivers/net/ethernet/sfc/nic.h:158 bad line: #ifdef CONFIG_SFC_SRIOV
> Warning: drivers/net/ethernet/sfc/nic.h:160 bad line: #endif

Does kernel-doc not complain if a member is documented but the actual
 declaration is ifdefed out?  Normal practice seems to be to move the
 doc into another comment adjacent to the declaration so it's under
 the same ifdef; is that unnecessary?

> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'port_id'
>  not described in 'efx_ef10_nic_data'
> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'vf_index'
>  not described in 'efx_ef10_nic_data'
> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'licensed_features'
>  not described in 'efx_ef10_nic_data'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Edward Cree <ecree.xilinx@gmail.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: linux-net-drivers@amd.com
> ---
>  drivers/net/ethernet/sfc/nic.h |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> --- linux-next-20251128.orig/drivers/net/ethernet/sfc/nic.h
> +++ linux-next-20251128/drivers/net/ethernet/sfc/nic.h
> @@ -156,9 +156,10 @@ enum {
>   * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
>   * @must_probe_vswitching: Flag: vswitching has yet to be setup after MC reboot
>   * @pf_index: The number for this PF, or the parent PF if this is a VF
> -#ifdef CONFIG_SFC_SRIOV
> + * @port_id: port id (Ethernet address) if !CONFIG_SFC_SRIOV;
> + *   for CONFIG_SFC_SRIOV, the VF port id

I think this is always the PF's MAC address, and is used by
 ndo_get_phys_port_id.  On EF100 that method only exists for PFs
 (the vfrep's ndo_get_port_parent_id also shows the PF's port_id),
 whereas on EF10 VFs also have a phys_port_id with the PF's MAC
 address.
I guess the best way to summarise this for the kerneldoc comment
 would be:
 * @port_id: Ethernet address of owning PF, used for phys_port_id
In our local tree we just have "@port_id: Physical port identity".

> + * @vf_index: Index of particular VF in the VF data structure

This isn't quite right; this field is the index of this VF more
 generally within the PF's set of VFs; it's provided by firmware,
 and passed back to firmware in various requests.
And when it's used as an index into the VF data structure array,
 it's the _parent PF's_ nic_data->vf that is indexed by the VF's
 nic_data->vf_index.  (The VF's nic_data->vf is %NULL afaik.)
Not really sure how to summarise this, other than just following
 the pattern of @pf_index above:
 * @vf_index: The number for this VF, or 0xFFFF if this is a VF
 which isn't greatly informative, but we could add more to @vf:

>   * @vf: Pointer to VF data structure

 * @vf: for a PF, array of VF data structures indexed by VF's
	@vf_index

> -#endif
>   * @vport_mac: The MAC address on the vport, only for PFs; VFs will be zero
>   * @vlan_list: List of VLANs added over the interface. Serialised by vlan_lock.
>   * @vlan_lock: Lock to serialize access to vlan_list.
> @@ -166,6 +167,7 @@ enum {
>   * @udp_tunnels_dirty: flag indicating a reboot occurred while pushing
>   *	@udp_tunnels to hardware and thus the push must be re-done.
>   * @udp_tunnels_lock: Serialises writes to @udp_tunnels and @udp_tunnels_dirty.
> + * @licensed_features: used to enable features if the adapter is licensed for it

In our local tree we have:
 * @licensed_features: Flags for licensed firmware features.
 which might be better as it doesn't give the impression that the
 driver can change this ('enable' things) — it's a bitmask that
 comes directly from firmware.

-ed

