Return-Path: <netdev+bounces-30432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D12E78746D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 17:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F141C20B23
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AC1134DE;
	Thu, 24 Aug 2023 15:39:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74546100DC
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8586BC433C7;
	Thu, 24 Aug 2023 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692891547;
	bh=ccJZ7jMCkPXEoZObdfh/lq2IGmiKK2gTVM+NPOtVGVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OaKZ5s4erFUXppdehkjcTT1TeUUblS5NX0TxjzRN81PErzSB/N0HcMjIC2lLOWrMB
	 175wLpEMROv2sMoSkMkkP5ANyuQrblZ55zv31eRu3FfxBX+BuDTWIMS46ULL/7sgvN
	 IE9G2MMY0vYHlVEaGXgtJFy3lJbIdbdmHevlkCtK+6JB7aoOZkI2E5Uxdas7APoP+c
	 79md4SKZ/+TuoosX7ihss85S720C+k7k6HhJeovTshOp+CTXbXs7Tatag+dS4ebZOZ
	 96gDbNeuUuqWF1EBTzpFD5VzaHBSA4kteTuw1tETRd2SNxBpE0QHYGwEov5Z1+kSm/
	 ipR5rgR3xLb0A==
Date: Thu, 24 Aug 2023 17:39:01 +0200
From: Simon Horman <horms@kernel.org>
To: Junfeng Guo <junfeng.guo@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	qi.z.zhang@intel.com, ivecera@redhat.com,
	sridhar.samudrala@intel.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, pabeni@redhat.com
Subject: Re: [PATCH iwl-next v8 12/15] ice: add parser execution main loop
Message-ID: <20230824153901.GJ3523530@kernel.org>
References: <20230823093158.782802-1-junfeng.guo@intel.com>
 <20230824075500.1735790-1-junfeng.guo@intel.com>
 <20230824075500.1735790-13-junfeng.guo@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824075500.1735790-13-junfeng.guo@intel.com>

On Thu, Aug 24, 2023 at 03:54:57PM +0800, Junfeng Guo wrote:
> Implement function ice_parser_rt_execute which perform the main
> loop of the parser.
> 
> Also include the Parser Library files into ice Makefile.
> 
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>

...

> @@ -80,6 +107,632 @@ void ice_parser_rt_pktbuf_set(struct ice_parser_rt *rt, const u8 *pkt_buf,
>  	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho], ICE_GPR_HV_SIZE);
>  }
>  
> +static void _ice_bst_key_init(struct ice_parser_rt *rt,
> +			      struct ice_imem_item *imem)
> +{
> +	u8 tsr = (u8)rt->gpr[ICE_GPR_TSR_IDX];
> +	u16 ho = rt->gpr[ICE_GPR_HO_IDX];
> +	u8 *key = rt->bst_key;
> +	int idd, i;
> +
> +	idd = ICE_BST_TCAM_KEY_SIZE - 1;
> +	if (imem->b_kb.tsr_ctrl)
> +		key[idd] = (u8)tsr;
> +	else
> +		key[idd] = imem->b_kb.prio;
> +
> +	idd = ICE_BST_KEY_TCAM_SIZE - 1;
> +	for (i = idd; i >= 0; i--) {
> +		int j;
> +
> +		j = ho + idd - i;
> +		if (j < ICE_PARSER_MAX_PKT_LEN)
> +			key[i] = rt->pkt_buf[ho + idd - i];
> +		else
> +			key[i] = 0;
> +	}
> +
> +	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "Generated Boost TCAM Key:\n");
> +	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "%02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X\n",
> +		  key[0], key[1], key[2], key[3], key[4],
> +		  key[5], key[6], key[7], key[8], key[9],
> +		  key[10], key[11], key[12], key[13], key[14],
> +		  key[15], key[16], key[17], key[18], key[19]);

Hi Junfeng Guo,

key points to rt->bst_key which has ICE_BST_KEY_SIZE (10) elements.
But here 20 elements are accessed. This seems to be an overrun.

Flagged by Smatch.

> +	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "\n");
> +}
> +

