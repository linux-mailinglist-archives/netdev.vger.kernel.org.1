Return-Path: <netdev+bounces-51516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E317FAFB4
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 02:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142171C20A8B
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A994187B;
	Tue, 28 Nov 2023 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QK3TVV4w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DECC186D
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 01:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F471C433C7;
	Tue, 28 Nov 2023 01:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701135810;
	bh=OjB6PWpGpg8K3KA9dzFB14JiNIAxrS4EH02IlqUUA5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QK3TVV4wkSnPSezrL4rIf6VykLjn/8a6HFJKVa3aiSVIKQizQexZW5NhUydMwoSYJ
	 THeU0h3A9kb0dDIyuxxa66qU6P5ztEdyFgAyueA2hbMpa9orW2caASVd1DhoXIlhX8
	 BgRuZeZUyVAPCYR/bu/uI+4nLvHzqYxboz7B1ndE7S8Gm7DSUni2jPrLtcnYcEW/ug
	 timjuitLX61XswF8ARqglcdvsvNI4CMtLDMUF9B2PZXGBYCBFwOdyYc+7rVb+RYeZP
	 oun4hEritCKFvHqu3iEy7cdWXmdVvWeOrY1reALYiboFZABd4DPfxbzp53z4g9Yb1/
	 HKu43nKLWGCKQ==
Date: Mon, 27 Nov 2023 17:43:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Zhang, Xuejun" <xuejun.zhang@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
 <anthony.l.nguyen@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <qi.z.zhang@intel.com>, Wenjun Wu <wenjun1.wu@intel.com>,
 <maxtram95@gmail.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, <pabeni@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
Message-ID: <20231127174329.6dffea07@kernel.org>
In-Reply-To: <e662dca5-84e4-4f7b-bfa3-50bce30c697c@intel.com>
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
	<20231122192201.245a0797@kernel.org>
	<e662dca5-84e4-4f7b-bfa3-50bce30c697c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 16:15:47 -0800 Zhang, Xuejun wrote:
> This is extension of ndo_set_tx_maxrate to include per queue parameters 
> of tx_minrate and burst.
> 
> devlink rate api includes tx_maxrate and tx_minrate, it is intended for 
> port rate configurations.
> 
> With regarding to tc mqprio, it is being used to configure queue group 
> per tc.
> 
> For sriov ndo ndo_set_vf_rate, that has been used for overall VF rate 
> configuration, not for queue based rate configuration.
> 
> It seems there are differences on intent of the aforementioned APIs.
> 
> Our use case here is to allow user (i.e @ uAPI) to configure tx rates of 
> max rate & min rate per VF queue.Hence we are inclined to 
> ndo_set_tx_maxrate extension.

I said:

  So since you asked for my opinion - my opinion is that step 1 is to
  create a common representation of what we already have and feed it
  to the drivers via a single interface. I could just be taking sysfs
  maxrate and feeding it to the driver via the devlink rate interface.
  If we have the right internals I give 0 cares about what uAPI you pick.

https://lore.kernel.org/all/20231118084843.70c344d9@kernel.org/

Again, the first step is creating a common kernel <> driver interface
which can be used to send to the driver the configuration from the
existing 4 interfaces.

