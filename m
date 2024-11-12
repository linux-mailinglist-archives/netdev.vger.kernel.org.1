Return-Path: <netdev+bounces-143952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED3C9C4D40
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 04:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A5EB2B461
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8501F208222;
	Tue, 12 Nov 2024 03:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svfoViJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C120821D;
	Tue, 12 Nov 2024 03:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381573; cv=none; b=HAiOPB+KEd7qSwDb7hxjtXggcEXuScqTar0W8ejA/uvYxPATKMtrG6y9Hulg+kW+YsCut3c5Qr8uz9hxhWHHj27xDks848Lys5Vknoi82Wjl9BArmTYqBkv/UwYGHr5rk4H/nR48XsyJ4m6x5OnIDxiRs5nr9q27MxeuBkAI7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381573; c=relaxed/simple;
	bh=9yuWzaclr6QDV5gbBphLoP+z39ogdab4mruCBMVTZoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJCg+5+cvAiGeach+sHhQMt54MkNYlu0/gRy+4wfckpKHJkozV/bSzq5fm0ruGydPWT/liHSR1dCUanO6+vN81O7Q6ol9dW0NzEOFR2Pu0kn0T4kIC4FmlkvNAv2BUQAK5hLrzbpJMc2DUfsiNj1BxtrTYiwhpWFOFaBEJdVyTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svfoViJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5C4C4CED0;
	Tue, 12 Nov 2024 03:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731381572;
	bh=9yuWzaclr6QDV5gbBphLoP+z39ogdab4mruCBMVTZoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=svfoViJAm7VCYxZSyXieIfhm5nwTGGwgDpuUxb/Dz7qENNCCk+JZXD3L21tvANUcg
	 zENeVCLguuLoYKMSZAKtSpbE2jeZCKOxqIB0JxVZldP45Z3ktdRJZQ8r0BlxInE5C0
	 KDgdUytLqpDJIzJcbYlKmox+ZH4rPaiRWEg1IxSsCYieiExffA0gbDzhx+uWKWul+O
	 tBKC5UIzocEDC4JBgxSHIqqlbtf7gz/VsEI4Zz14Xa5ct59hQrc97pMECeFNKgkPNl
	 z619O7nFH25aCVMWicLPyYnNq4AufIiDswFwwu5kh3ysMK3lmgMrp5pEd68LNHDQPQ
	 J+wsWvz3tsZmw==
Date: Mon, 11 Nov 2024 19:19:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Sanman Pradhan
 <sanmanpradhan@meta.com>, Al Viro <viro@zeniv.linux.org.uk>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] eth: fbnic: Add devlink dev flash
 support
Message-ID: <20241111191931.284b1be4@kernel.org>
In-Reply-To: <20241111043058.1251632-3-lee@trager.us>
References: <20241111043058.1251632-1-lee@trager.us>
	<20241111043058.1251632-3-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Please drop Al Viro from the CC (!?) and CC the maintainer of the pldm
library (Jake).

On Sun, 10 Nov 2024 20:28:42 -0800 Lee Trager wrote:
> +/**
> + * fbnic_send_package_data - Send record package data to firmware
> + * @context: PLDM FW update structure
> + * @data: pointer to the package data
> + * @length: length of the package data
> + *
> + * Send a copy of the package data associated with the PLDM record matching
> + * this device to the firmware.
> + *
> + * Return: zero on success
> + *	    negative error code on failure
> + */

can we drop these kdocs please? In the bast case they just repeat 
the function name ("send package data") 3 times, in the worst case they
are misleading. This function sends absolutely nothing to the firmware.

> +static int fbnic_send_package_data(struct pldmfw *context, const u8 *data,
> +				   u16 length)
> +{
> +	struct device *dev = context->dev;
> +
> +	/* Temp placeholder required by devlink */

Do you mean that the pldm lib requires this callback to exist?
If yes then make it not require it if it's not necessary?

> +	dev_info(dev,
> +		 "Sending %u bytes of PLDM record package data to firmware\n",
> +		 length);

Please drop all the dev_*() prints. If something is important enough to
be reported it should be reported via the devlink info channel, to the
user. Not to system logs.

> +	return 0;
> +}
-- 
pw-bot: cr

