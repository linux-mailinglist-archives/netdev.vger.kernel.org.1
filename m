Return-Path: <netdev+bounces-19709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D6675BCC1
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 05:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F94281049
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 03:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD6638;
	Fri, 21 Jul 2023 03:21:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFD67F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 03:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8188DC433C9;
	Fri, 21 Jul 2023 03:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689909693;
	bh=w1Cp3E/fFhoJ3GjRoiK/c7WGdFlU03uhB7BUSWdwMyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gaXU04sE9jtk39nE9jyUQRfeJGzvlCgsq4HRsFA69lpLHj5Al69giAZ/LeRymfhbq
	 5hBgX4IkdgeBZqDNG6TfzHyXu5GBsEsWPNL/LMKtB5de/9NPWwircoRXkK8vjY38zw
	 4zzK9qjpvKskRFT8cX45eQIlir+vUMDXUN6PMoAJC/ovLoalkPauWGhSDEYYhU/9hn
	 Y7dAEXnSOg52mhdtUZ1cKqAedPbeTnIqtOPCmg9kZy+hOZ3bJydO4sXhbkHR/zGpA8
	 7c+QcbxnpbNTUzoT2oQDjITQ4uufFA504HGpXxLfV9U6yuX6PZ4Ct8shWMbg4K8OOQ
	 4ggIlKQ3lFgNA==
Date: Thu, 20 Jul 2023 20:21:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
 "olteanv@gmail.com" <olteanv@gmail.com>, David Thompson
 <davthompson@nvidia.com>
Subject: Re: [PATCH net v3 1/1] mlxbf_gige: Fix kernel panic at shutdown
Message-ID: <20230720202132.268dd1fd@kernel.org>
In-Reply-To: <CH2PR12MB389598B6D2C1EFA43F7B8936D73EA@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230720205620.7019-1-asmaa@nvidia.com>
	<CH2PR12MB389598B6D2C1EFA43F7B8936D73EA@CH2PR12MB3895.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 21:11:53 +0000 Asmaa Mnebhi wrote:
> >  	.probe = mlxbf_gige_probe,
> >  	.remove = mlxbf_gige_remove,
> > -	.shutdown = mlxbf_gige_shutdown,
> > +	.shutdown = mlxbf_gige_remove,  
> 
> Actually, apologies for this commit in response to Sridhar's comment
> on v2. This will not work. Mlxbf_gige_remove() returns void while
> ".shutdown" expects to return an int. Please advise on how to
> proceed. Should I send a v4 with the same patch as v2?

You can make it work, there is a new version of remove upstream:

https://elixir.bootlin.com/linux/v6.5-rc2/source/include/linux/platform_device.h#L220

You can make them both void.
-- 
pw-bot: cr

