Return-Path: <netdev+bounces-24162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088AC76F0CF
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9FC2822AA
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A5C2419A;
	Thu,  3 Aug 2023 17:43:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11341F937
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 17:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE62CC433C8;
	Thu,  3 Aug 2023 17:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691084583;
	bh=TXt73pdbEsVjNXx498XOQs5hPMVwlvDMtseT7OsCBTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIYMoE504Ia2M5zkEN+fdiA4gv4woltf3Opl2nbyoWra7Aa/MTzEvymq3lg2Puedq
	 yVW6V4wWznxVdhWnv+mtGNdRSbKyw1DONbXDh1j6BXWsfn2b300r/jAceMd9jbZmt0
	 NcMYtm5d7V/Xi1czCcdKMkLFRc5xJt5zReHDCZbzF6qcBKyFH31zHS9ob27EeR4KC4
	 pf7nHlUGKJNBi0jCOXsw6vDk2ftw7aMVv7zGAxKu5K0zJuaeA60802dmu5TKXMH5p5
	 NNf7aSNdsm8K8a1T7SOrAerdxArv27H/QbnSilSot86JWPSTcbJpcQwugTBdScjO9T
	 2QpkUgfWVBQnA==
Date: Thu, 3 Aug 2023 19:42:58 +0200
From: Simon Horman <horms@kernel.org>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
	tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/6] net/smc: support smc release version
 negotiation in clc handshake
Message-ID: <ZMvnIszqS4ZpkYHj@kernel.org>
References: <20230803132422.6280-1-guangguan.wang@linux.alibaba.com>
 <20230803132422.6280-2-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803132422.6280-2-guangguan.wang@linux.alibaba.com>

On Thu, Aug 03, 2023 at 09:24:17PM +0800, Guangguan Wang wrote:

...

Hi Guangguan Wang,

> @@ -1063,7 +1063,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>  				memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
>  			len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
>  			if (first_contact) {
> -				smc_clc_fill_fce(&fce, &len);
> +				smc_clc_fill_fce(&fce, &len, ini->release_ver);

Here ini is dereferenced...


>  				fce.v2_direct = !link->lgr->uses_gateway;
>  				memset(&gle, 0, sizeof(gle));
>  				if (ini && clc->hdr.type == SMC_CLC_CONFIRM) {

... but here it is assumed that ini may be NULL.

This seems inconsistent.

As flagged by Smatch.

...

-- 
pw-bot: changes-requested

