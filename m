Return-Path: <netdev+bounces-12352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED86737318
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAF01C20C71
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE022AB5B;
	Tue, 20 Jun 2023 17:43:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE022AB3A
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 17:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0058BC433C8;
	Tue, 20 Jun 2023 17:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687283032;
	bh=3gGh6XuulfQ3mQQOEMgB6tJBXlOxKd3drxfmGpq3tA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rmqG7jYdEjPQfxBIYxitx3vUaExxLgAaSQLmWgeYxthdlZR4E5SxLpIFECLkD2TPH
	 gjUkkAmkjrDOIYjRPZxAwmTBXMFyCBOJ3NoBrmS3Y/SB3MAP6U16vl7ezrb4qSpve6
	 WbF1tcwn3CFKl42BeDQQSML/1z/qS9r3HxoifOs13IuXDrgBskkqhoqEoXkhc+8+2b
	 P/Ga1Bjw7Og+++7MJ84qlhiZEX+xSbp09mixUG82HhaHK8juPWx9f0Rqd3U/WpBpkE
	 jdVhoY6TAvopwo82/XZTH8af4F1PqhylP/NL5EmdexlBFubAs/F4cM5c1rXc28EBT9
	 0ULKcZWG17bmA==
Date: Tue, 20 Jun 2023 10:43:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 petrm@nvidia.com
Subject: Re: [RFC PATCH net-next 1/2] devlink: Hold a reference on parent
 device
Message-ID: <20230620104351.6debe7f1@kernel.org>
In-Reply-To: <ZJFPs8AiP+X6zdjC@shredder>
References: <20230619125015.1541143-1-idosch@nvidia.com>
	<20230619125015.1541143-2-idosch@nvidia.com>
	<ZJFF3gh6LNCVXPzd@nanopsycho>
	<ZJFPs8AiP+X6zdjC@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jun 2023 10:05:23 +0300 Ido Schimmel wrote:
> On Tue, Jun 20, 2023 at 08:23:26AM +0200, Jiri Pirko wrote:
> > Mon, Jun 19, 2023 at 02:50:14PM CEST, idosch@nvidia.com wrote:  
>  [...]  
> > 
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>  
> 
> Thanks, but I was hoping to get feedback on how to solve the problem
> mentioned in the commit message :p

Do we need to hold the reference on the device until release?
I think you can release it in devlink_free().
The only valid fields for an unregistered devlink instance are:
 - lock
 - refcount
 - index

And obviously unregistered devices can't be reloaded.

