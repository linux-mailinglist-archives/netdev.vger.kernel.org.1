Return-Path: <netdev+bounces-50361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 005CE7F5701
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 04:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F984B20F23
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 03:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB1C8C02;
	Thu, 23 Nov 2023 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwA2SWor"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CAB8BEB
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF702C433C8;
	Thu, 23 Nov 2023 03:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700709723;
	bh=yAc2hE061dNOWccQc37rtV38ITS3Vn4u5CYPg8/n4Gk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OwA2SWorUNCEzk8EowGrclIWcuGhbpXO1hC2zUlxu6W/+XTqwWLCLMgU/OVEW1NPA
	 Pptk52YDyySnXpvLwsvAWmvFASfnyefyblEaiZ8xNr0FcoStAnyENB64wJDoQZrAVX
	 LJBgDsmHZsWEq/OXZJ83vvgE+Z2v9iZ/FMrNGMJNQtm3vGDsk51Zn9uMexKqCC+IvQ
	 ycPX9uWMnBpjL8bX3cIxzNwBWoxHRoURKngX2XlRYO9O0VqKtHhGj1xetg9WSw2Kbp
	 BlqE6a7r3roQi2TvOv2aY8KLijDYLIyJ5UfchwwbbUxBirXymgl5ZYHVhKhd1wCj3t
	 qXGxbLP/o9mng==
Date: Wed, 22 Nov 2023 19:22:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Zhang, Xuejun" <xuejun.zhang@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
 <anthony.l.nguyen@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <qi.z.zhang@intel.com>, Wenjun Wu <wenjun1.wu@intel.com>,
 <maxtram95@gmail.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, <pabeni@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
Message-ID: <20231122192201.245a0797@kernel.org>
In-Reply-To: <3d60fabf-7edf-47a2-9b95-29b0d9b9e236@intel.com>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
	<20230822034003.31628-1-wenjun1.wu@intel.com>
	<ZORRzEBcUDEjMniz@nanopsycho>
	<20230822081255.7a36fa4d@kernel.org>
	<ZOTVkXWCLY88YfjV@nanopsycho>
	<0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
	<ZOcBEt59zHW9qHhT@nanopsycho>
	<5aed9b87-28f8-f0b0-67c4-346e1d8f762c@intel.com>
	<bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>
	<20231118084843.70c344d9@kernel.org>
	<3d60fabf-7edf-47a2-9b95-29b0d9b9e236@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 14:19:14 -0800 Zhang, Xuejun wrote:
> The proposed API would incur net/core and driver changes as follows
> a) existing drivers with ndo_set_tx_maxrate support upgraded to use new 
> ndo_set_tx_rate
> b) net sysfs (replacing ndo_set_maxrate with ndo_set_tx_rate with 
> minrate and burst set to 0, -1 means ignore)
> c) Keep the existing /sys/class/net/ethx/queues/tx_nn/tx_maxrate as it 
> is currently
> d) Add sysfs entry as /sys/class/net/ethx/queues/tx_nn/tx_minrate & 
> /sys/class/net/ethx/queues/tx_nn/burst

You described extending the sysfs API (which the ndo you mention 
is for) and nothing about converging the other existing APIs.

