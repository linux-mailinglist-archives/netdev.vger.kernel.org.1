Return-Path: <netdev+bounces-127981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E98D197763A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 02:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE7B1F2542D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 00:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7147E1;
	Fri, 13 Sep 2024 00:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVLPrxrc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB81FBA
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726188800; cv=none; b=ChPMNzPgp+4nmlnbYLHj7fp0WsrbEiSKgKsA8KP63p+v1iI4G79MegtSjvbUwn9yYSOY621LzDihB+9Wxr3LbxG7KNY+P9WBguqAofUt30iNW45EPT/o3ZL20bwhf7Khxd6GJiwf0TeXHkyj8E7QPdTiqYowAbxEYDH9urA/p6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726188800; c=relaxed/simple;
	bh=0n5lo3qJnp01A2lz3Vx7e5wOKVRpHlNig5LtlqZN5dg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQndyN7dLWdzt/sjOr0M/O1lMFkVs1KN5Y/WF/r5mBW6BWWztEuL5g0cgdzfpr6PqRlY/tSnj5U7GwoFJYHSLtRQ1T1yY87lQ+27tyhhghe4IGVogAfaRPcU7fVlMD6vkTQsLoipoe30u+O/CmZG+1jcTdVJHf+VUpdkZowK0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVLPrxrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C10C4CEC3;
	Fri, 13 Sep 2024 00:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726188799;
	bh=0n5lo3qJnp01A2lz3Vx7e5wOKVRpHlNig5LtlqZN5dg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pVLPrxrcMAAAOAUh3sHWXLJEqbwluMNk9PN1L6/0VjTjVwzhda51jT6UithHc8YzK
	 VcjZYg9z35q8nwEhdABCTG3gdJ/bbBPG3hmeos/08+XdQcMH2wSAb7wefAciNRtPIY
	 +rBbhSkVGmEE1cY4L8yoq2CB91u5D2liaMScWPL5xrhZe4wTj3wCrKZ973f3MT5Oqv
	 kh37HvwmOL7XKum60aExMhCFhliOAXiV8/hBRI8AmAYIFcAOWEoYuVKm0+HRI3hycv
	 Yrq0iigsODkxPbW5WjrZNL+vTlIbFbQS7ZvmKQ2OfNJPmc7hiK+ZV8wG9D+8TXXaJT
	 p8d8MVaJV5UHQ==
Date: Thu, 12 Sep 2024 17:53:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, David Ahern
 <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Alexander Duyck <alexanderduyck@fb.com>,
 <netdev@vger.kernel.org>, "Richard Cochran" <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v2 3/5] eth: fbnic: add RX packets timestamping
 support
Message-ID: <20240912175318.3d8d0b7d@kernel.org>
In-Reply-To: <20240912163123.551882-4-vadfed@meta.com>
References: <20240912163123.551882-1-vadfed@meta.com>
	<20240912163123.551882-4-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 09:31:21 -0700 Vadim Fedorenko wrote:
> Add callbacks to support timestamping configuration via ethtool.
> Add processing of RX timestamps.

drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:57: warning: No description found for return value of 'fbnic_ts40_to_ns'
-- 
pw-bot: cr

