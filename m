Return-Path: <netdev+bounces-238179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB88C5564D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 03:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6652E4E1A02
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 02:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D872DCF69;
	Thu, 13 Nov 2025 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg5RbcIU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A07299AB5;
	Thu, 13 Nov 2025 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999970; cv=none; b=ueGfy+DaQHz7Cc8Y+slZEoKmmhM/Sl7apX3RctZGrV/8pr1OKktPKUwNfJ2Nzs8VX3lPz3RdyFadWPXuPD6oVsoRoFFBI9hB4bssi3ahXrSi455ja8qlKtrqrpr19EwY9/aLvfoaMHFFBHrTLQMrkPyU406ZykbNt4xLdNlXS9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999970; c=relaxed/simple;
	bh=flGmFZhoOXR2YxO/YWjefEuhtv6mAu2jpcpOx7T+HB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ptt/mrfCsj9HtwGCf/vK1AqoO8QDBpxmyn8uelPKtGZVhGz3O5pZ6eZBPbQLIq7TEn+ITlvu6S4dJ19w8S8W2zFKxZMj7FIkYsT5L7UD1OvBybBDHxKMepvevdCIcKgGY6uplJWaMv2Ah1zjug6kV20aXhTRebCVP9nwCWj/c/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg5RbcIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DBAC116B1;
	Thu, 13 Nov 2025 02:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762999969;
	bh=flGmFZhoOXR2YxO/YWjefEuhtv6mAu2jpcpOx7T+HB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tg5RbcIUqLdNPG1DDHChGLXBZnnLyA46EYb2O5DY6H89g/ZKulLMxjLNOx7X9TEPM
	 2lhpA3gdZzij2wmcOtrec61fkOb2c78eeODzy5Y24ZEKd+7ufwa8tXvFpTGhq8uLWD
	 +Q/9Le/22xbhyVf4tCKsvqAhUiwJFhxsr/lusyPOKrelT/TWiRF1wRw+8aNeXuszoV
	 e60zbxiSbitEcT6RJnVHOe5Z7X6B/5Sn6EROHOs44Ob5BpjgV5IZTjNkPPgNVIM/0h
	 DsSKWM1bvzbr1CacfAQ5fn9Le4Uvg4gcZkjxdgL30pC8tq3q0Fp3x8UTvmkQ7P5VII
	 M9CMXkepnMZGg==
Date: Wed, 12 Nov 2025 18:12:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH net] devlink: rate: Unset parent pointer in
 devl_rate_nodes_destroy
Message-ID: <20251112181248.190415f7@kernel.org>
In-Reply-To: <1762863279-1092021-1-git-send-email-tariqt@nvidia.com>
References: <1762863279-1092021-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 14:14:39 +0200 Tariq Toukan wrote:
> The function devl_rate_nodes_destroy is documented to "Unset parent for
> all rate objects". However, it was only calling the driver-specific
> `rate_leaf_parent_set` or `rate_node_parent_set` ops and decrementing
> the parent's refcount, without actually setting the
> `devlink_rate->parent` pointer to NULL.
> 
> This leaves a dangling pointer in the `devlink_rate` struct, which is
> inconsistent with the behavior of `devlink_nl_rate_parent_node_set`,
> where the parent pointer is correctly cleared.
> 
> This patch fixes the issue by explicitly setting `devlink_rate->parent`
> to NULL after notifying the driver, thus fulfilling the function's
> documented behavior for all rate objects.

What is the _real_ issue you're solving here? If the function destroys
all nodes maybe it doesn't matter that the pointer isn't cleared.
-- 
pw-bot: cr

