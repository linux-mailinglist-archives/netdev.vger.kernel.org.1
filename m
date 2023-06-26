Return-Path: <netdev+bounces-14019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538FC73E695
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7BE1C2097F
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE14125D4;
	Mon, 26 Jun 2023 17:35:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47BCD520
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 17:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCB2C433C9;
	Mon, 26 Jun 2023 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687800943;
	bh=EEPs2DR/KfDaVuYAcKCmgZfrTMCbwF9L2Tr2+TY9IQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JW8nAjsJNsHMKIdCsloXuJAIWcJX3RHyNnjOy26z5Ss62OkvFeWgWU2YBSOO8vitT
	 MLsS+AZTryGwfkfN2eLWK7DVW3ETTr9RoNW51GJlizAQnLEwBEGELg/2V861GT6KbJ
	 gmT15NowpdwTq6Bzj0OR0R2dRWaetCuKesdKWP2hWP5fNAz2d+jv67MMVAf1UDl+7S
	 vCoedc2GHJEYNB6YRlLbYlRCXU5a0BnZMHb2uLKayy7IvMaRXulFBCYunPrl1EdbK3
	 wAYyRUIkulOFCQEP/bDBH7NDAiIqHZZFf8e2yZLf7BGEY/Styv6FxPM/kwwJ3MYVqb
	 EODhpYGuef/Gw==
Date: Mon, 26 Jun 2023 10:35:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, Wojciech
 Drewek <wojciech.drewek@intel.com>, jiri@resnulli.us, ivecera@redhat.com,
 simon.horman@corigine.com, Sujai Buvaneswaran
 <sujai.buvaneswaran@intel.com>, Vlad Buslov <vladbu@nvidia.com>
Subject: Re: [PATCH net-next 06/12] ice: Implement basic eswitch bridge
 setup
Message-ID: <20230626103542.68800299@kernel.org>
In-Reply-To: <ZJmgB9fUPE+nfmoh@localhost.localdomain>
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
	<20230620174423.4144938-7-anthony.l.nguyen@intel.com>
	<ZJmgB9fUPE+nfmoh@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jun 2023 16:26:15 +0200 Michal Swiatkowski wrote:
> We found out that adding VF and corresponding port representor to the
> bridge cause loop in the bridge. Packets are looping through the bridge.
> I know that it isn't valid configuration, howevere, it can happen and
> after that the server is quite unstable.
> 
> Does mellanox validate the port for this scenario? Or we should assume
> that user will add port wisely? I was looking at your code, but didn't
> find that. You are using NETDEV_PRECHANGEUPPER, do you think we should
> validate if user is trying to add VF when his PR is currently added?

Can you try to plug two ends of a veth into a bridge and see if the
same thing happens?  My instinct is that this is a classic bridge
problem and the answer is STP.

