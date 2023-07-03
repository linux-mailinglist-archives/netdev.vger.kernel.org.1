Return-Path: <netdev+bounces-15193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3601D746172
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 19:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F261C209EF
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A88101F2;
	Mon,  3 Jul 2023 17:29:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905D110780
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 17:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA504C433C8;
	Mon,  3 Jul 2023 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688405398;
	bh=3UlnvLRsMVZa31MjcgvpkyohCz/JICl04SWLwyfuhKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AxcPXz/qn+TCqorNC2Arg4CIQqH0o/FQN0CAMJcVksmyQLoyoxtNz71zn23f30vj7
	 2c6mKObATGGYwgNyxiAmew7EiGkGNEHy7xP83JoI20XwmMVleUSQsvGcZa0pT/RJl3
	 pOvgACVju09tyxblKTxZvCWxUfvl7LDSwoMnHtf0ksUEsrL3PyQ1IaYcMTcgsrI1JO
	 od7+qqs+/DmWfcvpzR+jvVuBHSnKM4bBwHTgcgQt95m5Xvbekl1aM5YyVRe3i3tdQl
	 HDGiSEqQQu/v9qqC5WYNs76NUok31rRHJDyevn6Kc62yhND0z8muUFH60vOfdHwxge
	 V0emKcNyY+POg==
Message-ID: <a9d7579c-f717-bfea-89c9-cf13b9b79a86@kernel.org>
Date: Mon, 3 Jul 2023 11:29:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] tcp: Make GRO completion function inline
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Michael Chan <michael.chan@broadcom.com>, Parav Pandit <parav@nvidia.com>
Cc: aelior@marvell.com, skalluru@marvell.com, manishc@marvell.com,
 netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
References: <20230611140756.1203607-1-parav@nvidia.com>
 <CACKFLi=nD76sHPFALg8dzR6Oj2CDGsZqbjY1gS_9ZKdo-KJrHQ@mail.gmail.com>
 <f25406bd-71b5-79e4-80f7-66c345341504@intel.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <f25406bd-71b5-79e4-80f7-66c345341504@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/23 10:51 AM, Alexander Lobakin wrote:
> Why is this needed then if it gives nothing? :D

It is a question I asked. There are a fair number of trivial sk_buff
functions called in the datapath (e.g., skb_add_rx_frag is another).
Function calls are not free, so inlining them should *collectively*
provide measurable performance bumps as line rates and packet rates
increase.

