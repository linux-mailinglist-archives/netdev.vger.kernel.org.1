Return-Path: <netdev+bounces-25627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6241774F37
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76AC1C21028
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3531BB4E;
	Tue,  8 Aug 2023 23:18:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C914017
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D4FC433C7;
	Tue,  8 Aug 2023 23:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691536715;
	bh=dCP1Sczz5QNP9YMFm3vPSduI7fWsBBX66xzJTokuAZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=katUyK8xdL08Dxi5cwX9+3IO7CmDiM0dqMpN+iV5epuOhNyN3HcEl9fFsfJ6/66CQ
	 pukEP3ASLYiuVXO/BA22+f/ulKkaNRi7xrl50diRPI3PV5lM+HfYZuUjZLdBFuACAc
	 jvd3NaL9dEmRoUCFKApgMb0WNvyUAnw6KutJxdoQYSzsfu5kY+2AaEPrSgE7QERom8
	 ve2zA3JqrGKU+MMmJNxTDs0BGVs6Sy//3tWRlYbooYxMfRT3v1X4bqUV6Z5RprhkNN
	 moNv+k79379V6JfhlFzvLYhcGXm18ATlvL4090WJr5sZAY0o6bBZZOhbgiH8JDSfzV
	 uWgCjjklFvSXQ==
Date: Tue, 8 Aug 2023 16:18:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shay Drory <shayd@nvidia.com>
Cc: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
 <edumazet@google.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net] devlink: Delay health recover notification until
 devlink registered
Message-ID: <20230808161834.71d5391d@kernel.org>
In-Reply-To: <20230808133720.1402826-1-shayd@nvidia.com>
References: <20230808133720.1402826-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Aug 2023 16:37:20 +0300 Shay Drory wrote:
> Currently, invoking health recover before devlink_register() triggers
> a WARN_ON. However, it is possible for a device to have health errors
> during its probing flow, before the device driver will call to
> devlink_register(). e.g.: it is valid to invoke health recover before
> devlink_register().
> 
> Hence, apply delay notification mechanism to health reporters.

devlink_register() is dead, long live devl_register().

At the very least the commit message should enlighten us as to why 
the devlink instance can't be registered first, before the health
reporter.

