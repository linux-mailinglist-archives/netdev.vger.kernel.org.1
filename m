Return-Path: <netdev+bounces-165352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B776AA31BB7
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F96167C1F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6657E107;
	Wed, 12 Feb 2025 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtJdgoBD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630027183E
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326014; cv=none; b=ouEobgamZYo1yasQk4klj18sOXFIP5vPmeiufjKlF2CrjvFCouvRv+3XLx1VDYd3GVPpMcyM1LI+n1/tC0aupmGcHh7qtF6nD6Xj3UY+o+lSEslwogd9mlOIivrP94vjCaRSHOf16bUlzI3iOf3daQn852DWcvnPzFthDAUsTpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326014; c=relaxed/simple;
	bh=QvXVMGZrjf5KOrH8VxdupCzRP4GIThZGbnLRYD6lOLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWlwbj/UdeXaSHmYcRLnWBT1XmTCTi4J+HuG1g+ws4sh8KGLHhUhjaBfkOG88tdfTUeMog8fpGb6RO8aUppLDh6WRb73SrUJDp+38ytM8Z9SFmhrkv0lKV6f2oAkHsv2aVUF+n04J5lLGTlUpzv6xs1PIweDqz5GtZNdTgZx8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtJdgoBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8854C4CEDD;
	Wed, 12 Feb 2025 02:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739326014;
	bh=QvXVMGZrjf5KOrH8VxdupCzRP4GIThZGbnLRYD6lOLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QtJdgoBDsadT9NdHvAXaxn44suycvzdG68Yq9hwzQbWwNR8Gdnu6nOs622Zp9wRAQ
	 RcAv89353SzVy+DcFr0WkN2SI/1nh9ryeMVP/G9ByW6Gu9sfPCvVsUKPS0QUauSfSN
	 IJzkMywBcw5QPFiluDkiSHHGZeKwCbzXGSFjbdabVVW6aLk/w6BQHaB3U3NtQbu/YL
	 mfjDqXN54aAyQjYmbG7qj3ZewPgld4mdIgpQ9Q5pJw7uT58xVViebwsa0xxnTIjPE6
	 sW1oOHS3+FNQ4jiUhyL8aAIq4KKSHGsQPR9GCPgyiyc0dYjrPOoiHyvTmj20D0WWJb
	 Gn/tVNx2OoS3Q==
Date: Tue, 11 Feb 2025 18:06:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next 01/11] net: hold netdev instance lock during
 ndo_open/ndo_stop
Message-ID: <20250211180653.1fdbbf02@kernel.org>
In-Reply-To: <20250210192043.439074-2-sdf@fomichev.me>
References: <20250210192043.439074-1-sdf@fomichev.me>
	<20250210192043.439074-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:20:33 -0800 Stanislav Fomichev wrote:
> +static inline bool need_netdev_ops_lock(struct net_device *dev)

nit: netdev_need_ops_lock() ?

