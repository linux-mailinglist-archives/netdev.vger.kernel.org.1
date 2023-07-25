Return-Path: <netdev+bounces-20997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 176F47621C2
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD9D281357
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8236625931;
	Tue, 25 Jul 2023 18:48:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4221F927
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BD7C433C8;
	Tue, 25 Jul 2023 18:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690310884;
	bh=4EbNVw9IOKIC/szNpS/xcWO0fD2agquycCt1SKIc+uI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B6kDGrYmCku5ThZvNMw9EvJEwzVTG71wKLSERnFQAywA6XzG4wQZNUbsXrYB7vSd1
	 aW/7SFEP5bAqCHxA3zZgnFaOblBHj1C9ksg3rN1SH5AYj1yhca3vCaTtVWG8MH6F4Y
	 GiL5mxVlhdsLhDLLE46x+IVNwC6lLnblZXAUk8M4Jnx0qD6pakbi7MviZ4Ws5Anrrd
	 eVHVhz4CWBVfIM4MybTvSksbo3rJn85C61B+sAGy0u73nQv7Vk34aeN44YeVACnIvS
	 6AMqB8nxTucdGPXJ7OS2l/s59+kftl5AL11OUg7/qAewHrJrOtYe005faVh2veGwFZ
	 PXJ3iR+Kuxw3Q==
Date: Tue, 25 Jul 2023 11:48:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 11/11] devlink: extend health reporter dump
 selector by port index
Message-ID: <20230725114803.78e1ae00@kernel.org>
In-Reply-To: <20230720121829.566974-12-jiri@resnulli.us>
References: <20230720121829.566974-1-jiri@resnulli.us>
	<20230720121829.566974-12-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 14:18:29 +0200 Jiri Pirko wrote:
> Introduce a possibility for devlink object to expose attributes it
> supports for selection of dumped objects.
> 
> Use this by health reporter to indicate it supports port index based
> selection of dump objects. Implement this selection mechanism in
> devlink_nl_cmd_health_reporter_get_dump_one()

This patch is not very clean. IMHO implementing the filters by skipping
is not going to scale to reasonably complex filters. Isn't it better to
add a .filter callback which will look at the about-to-be-dumped object
and return true/false on whether it should be dumped?

