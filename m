Return-Path: <netdev+bounces-245737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC685CD684C
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 16:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8489300E3CD
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54AD2D3EE5;
	Mon, 22 Dec 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KyOpUdt2"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0142D41C62
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416936; cv=none; b=geVwhKTj1mMV2tDMtJRYghPWGHxdhNCHJgwJ+JWbBVuCAf4l3B3Jez3zYpTLqzQ6Fw9L2e+98Gp4iMF0YuUrXd1gj2hk1qYtIqh6nSP2A+v3qajXBdlczmYXJNrRoSCr2SfcL3F0XMp/ty15iz34PYlFJRMFmJOSq4qbi9BKzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416936; c=relaxed/simple;
	bh=rsfsZQFUXvUgzB5b7ipEisB489aciHhgsARMx8BUDXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlnJIAH0PuK+ebkA9UMxjb1bsTqbxFB0QaEEHpzCHJaH6vVlP58IffM1WtX7dlXUruGIh/FiGfF9D6AKJCiW/2uA3bvW4aXciwcATYh8e6akDGj3SlsHZbCyBs436HeJ0w4a82XKtduq8A418KJiQLfwdBrxqHEyOhp1+vvmw98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KyOpUdt2; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <059d9fbb-7383-441c-9368-1c96eafae1f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766416921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fI5w9UdO/kkIcZxLRIb64c8Q+gNUOfD8NA1o77mtVOo=;
	b=KyOpUdt2qXZAHwApTZEn+TK7+V5b2/mHxe5pCCZ6m7LYrWZtCgUSL+6Boab2kVZIsSbNst
	Av7vrU5ixPqFtXolhl6wKxLrxuHGNJaCo/wkP3TSMrAOH+tU7sXEsotNGn9lYoSROvmkJv
	d8Qm8eR0LuwXI0fMxzPXUFcPGtK1F8k=
Date: Mon, 22 Dec 2025 15:21:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] net: nfc: nci: Fix parameter validation for packet
 data
To: Michael Thalmeier <michael.thalmeier@hale.at>,
 Deepak Sharma <deepak.sharma.472935@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Michael Thalmeier <michael@thalmeier.at>, stable@vger.kernel.org
References: <20251222143143.256980-1-michael.thalmeier@hale.at>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251222143143.256980-1-michael.thalmeier@hale.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/12/2025 14:31, Michael Thalmeier wrote:
> @@ -668,6 +679,11 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
>   		}
>   	}
>   
> +	if (skb->len < (data - skb->data) + sizeof(ntf.data_exch_rf_tech_and_mode) +
> +				sizeof(ntf.data_exch_tx_bit_rate) + sizeof (ntf.data_exch_rx_bit_rate) +

extra space between sizeof and the bracket

> +				sizeof(ntf.activation_params_len))
> +		return -EINVAL;
> +
>   	ntf.data_exch_rf_tech_and_mode = *data++;
>   	ntf.data_exch_tx_bit_rate = *data++;
>   	ntf.data_exch_rx_bit_rate = *data++;

