Return-Path: <netdev+bounces-26950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE007799B8
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 23:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E34A1C20A7D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C14329CB;
	Fri, 11 Aug 2023 21:42:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DDA8833
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 21:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FF3C433C7;
	Fri, 11 Aug 2023 21:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691790152;
	bh=CPsucIwwBBjXnqNKZV4L1//FqVpGGYXtJrPFCx1fC7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pgP/85m+7H9EFnjxC6w7o8c8EaPnI4vpK6UhQWDKVm9QEuXris88wVqUuWgRhdJua
	 pEiQSm241axCdz3eISA/Xgv9HPpiu8TRJsl1l6QGk117akVTteI/274GvBqCc+0wZ+
	 COkAV8IEtDYr5YJ5fNSTITqZPtZLMHp8Vg69q2jRZbAOIkHsE4Fz0tPm6pIPq+WrhW
	 EC5uqevlh2kYs5GZWAwGk/AesAvu+VL25VCaqvMf+4RRq6ZdyHrKVQkVgyhch8EgNA
	 t81XiXiRDhD2KvnnuAIk5vvj3qke9m5Iqynf2WyttzFiNlKfFnzg+GAuHWoc/5KjCN
	 WRlRDPmhClngA==
Date: Fri, 11 Aug 2023 14:42:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Shay Drory <shayd@nvidia.com>, netdev@vger.kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com, Jiri Pirko
 <jiri@nvidia.com>
Subject: Re: [PATCH net v2] devlink: Delay health recover notification until
 devlink registered
Message-ID: <20230811144231.0cea3205@kernel.org>
In-Reply-To: <ZNXrr7MspgDp8QfA@nanopsycho>
References: <20230809203521.1414444-1-shayd@nvidia.com>
	<20230810103300.186b42c8@kernel.org>
	<ZNXrr7MspgDp8QfA@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 10:05:03 +0200 Jiri Pirko wrote:
> This patch is not about user accessing it, this is about
> notification that would be tried to send before the instance is
> registered. So the lock scheme you suggest is not necessary. What helps
> is to move devl_port_health_reporter_create() call after register.

We moved to a model where the instance is registered early,
why is the driver not registering the instance early?

My first choice would be to fix the driver rather than adjust
the behavior of the core, and I'm hearing no solid reason why
that's not possible.

> We have the same issue with mlxsw where this notification may be called
> before register from mlxsw_core_health_event_work()

mlxsw? I somehow assumed this patch was for mlx5.. 
Quality commit message :|

> Limiting the creation of health reporter only when instance is
> registered does not seem like a good solution to me.
> 
> As with any other object, we postpone the notifications only after
> register is done, that sounds fine, doesn't it?

No, it doesn't. Registering health reporters on a semi-initialized
device is a major foot gun, we should not allow this unless really
necessary.

