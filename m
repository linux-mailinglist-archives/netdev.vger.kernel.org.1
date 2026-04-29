Return-Path: <netdev+bounces-282354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGb8KJLl8WlZlAEAu9opvQ
	(envelope-from <netdev+bounces-282354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:03:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B827B493503
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70778303CA4A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B5C3264DD;
	Wed, 29 Apr 2026 11:02:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742F42C3248;
	Wed, 29 Apr 2026 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460561; cv=none; b=asK+tO9oXH22glskekYvEvurhMuZz2xUsAXHPvdD+VlPCTT/dovHGqMWiASW77WppjnrDsraOrgvxJ5paDS5D0psmCbctiIbaIQNoInAgPcTN2FswtHAs8MJmZWGoBOhlxq9+bMpU4cz/t42eURnL7C/54zkBQ+bFS4tjLWNn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460561; c=relaxed/simple;
	bh=oEhLKJekH4gbEUFZ3JIXTDUoA60DTJ50Ve6pKGdF8vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnEPVU5CN66MckZTb/0xwTq9ZzIjguHJ49EjxHAijg6wfE5sL1yyf11nNgs3uk2sfqidNfMQOWVTxMkemjh9ihNDpybBdPiQ9E2dke8dNhamy/ppcaxJ79OJxRkfCUsb4At8GfdwlytR828ZPoXNA/A0qk79UyEWf2OBs5s3Mww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 048184C4431148;
	Wed, 29 Apr 2026 13:02:01 +0200 (CEST)
Message-ID: <558971b7-caea-471a-8fe2-73ba6cc0790a@molgen.mpg.de>
Date: Wed, 29 Apr 2026 13:02:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] i40e: Fix i40e_debug() to use struct
 i40e_hw argument
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260428181450.2622899-1-mkhalfella@purestorage.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260428181450.2622899-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B827B493503
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282354-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.894];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpg.de:email,purestorage.com:email]

Dear Mohamed,


Thank you for your patch.

Am 28.04.26 um 20:14 schrieb Mohamed Khalfella:
> i40e_debug() macro takes struct i40e_hw *h as first argument. But the
> macro body uses hw instead of h. This has been working so far because hw
> happen to be the name of the variable in the context where the marco is

marco → ma*cr*o

> expanded. Fix the macro to use the passed argument.

I’d add a Fixes: tag, but the maintainers might have more input.

> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_debug.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debug.h b/drivers/net/ethernet/intel/i40e/i40e_debug.h
> index e9871dfb32bd..01fd70db9086 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debug.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debug.h
> @@ -42,7 +42,7 @@ struct device *i40e_hw_to_dev(struct i40e_hw *hw);
>   #define i40e_debug(h, m, s, ...)				\
>   do {								\
>   	if (((m) & (h)->debug_mask))				\
> -		dev_info(i40e_hw_to_dev(hw), s, ##__VA_ARGS__);	\
> +		dev_info(i40e_hw_to_dev(h), s, ##__VA_ARGS__);	\
>   } while (0)
>   
>   #endif /* _I40E_DEBUG_H_ */

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: gemini/gemini-3.1-pro-preview embargoed it’s review until the 
evening [1].


[1]: 
https://sashiko.dev/#/patchset/20260428181450.2622899-1-mkhalfella%40purestorage.com

