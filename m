Return-Path: <netdev+bounces-17456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF4C751B74
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9231C212E5
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35079DB;
	Thu, 13 Jul 2023 08:25:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23C6120
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDD6C433BC;
	Thu, 13 Jul 2023 08:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689236704;
	bh=8p5xcaf3HE4Ic/cijtEkzbVhG0wqo8rKSFTK7zHVrMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZjsyftYoNuNsqKIj484NfJYi5IsnrY6qIF+TXNF15X+cj0hQstyIZmorNYjudJeYd
	 TwCp+vciJGMDlxJNN37xUieR3YB3E2rv5k2VC/DiBD+luVT2GMtm8YV86d/zU188SX
	 LFXerXS8lGV6scqSXTpLsWoW+RwRY0IJD+gXWH2IFddV30EH32yUACyrV48TD/CcWk
	 hOQMdLjfF0kc78iya1Tj0FY2DtSVQ6HIia/e4rVwE8E6mt4x1LFSnLyiY6K5FSOA3r
	 mz3iZy1gar147qsetUMHPRfel12HFO6ErP1w8qQQREPDJvsdVkcr0XmqFivfYoL/CZ
	 KfXNTVyJtCcug==
Message-ID: <c8ffee03-8a6b-1612-37ee-e5ec69853ab7@kernel.org>
Date: Thu, 13 Jul 2023 10:24:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] net: dwmac_socfpga: use the standard "ahb" reset
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 joabreu@synopsys.com, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowskii+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20230710211313.567761-1-dinguyen@kernel.org>
 <20230710211313.567761-2-dinguyen@kernel.org>
 <20230712170840.3d66da6a@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230712170840.3d66da6a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/07/2023 02:08, Jakub Kicinski wrote:
> On Mon, 10 Jul 2023 16:13:13 -0500 Dinh Nguyen wrote:
>> -	dwmac->stmmac_ocp_rst = devm_reset_control_get_optional(dev, "stmmaceth-ocp");
>> -	if (IS_ERR(dwmac->stmmac_ocp_rst)) {
>> -		ret = PTR_ERR(dwmac->stmmac_ocp_rst);
>> -		dev_err(dev, "error getting reset control of ocp %d\n", ret);
>> -		goto err_remove_config_dt;
>> -	}
>> -
>> -	reset_control_deassert(dwmac->stmmac_ocp_rst);
> 
> Noob question, perhaps - what's the best practice for incompatible
> device tree changes?

They are an ABI break.

> Updating the in-tree definitions is good enough?

No, because this is an ABI so we expect:
1. old DTS
2. out-of-tree DTS
to work properly with new kernel (not broken by a change).

However for ABI breaks with scope limited to only one given platform, it
is the platform's maintainer choice to allow or not allow ABI breaks.
What we, Devicetree maintainers expect, is to mention and provide
rationale for the ABI break in the commit msg.

> Seems like we could quite easily continue to support "stmmaceth-ocp"
> but no point complicating the code if not required.

Best regards,
Krzysztof


