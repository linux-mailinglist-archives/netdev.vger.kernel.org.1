Return-Path: <netdev+bounces-109893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6727092A313
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F2F1C203AB
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FDD80BF5;
	Mon,  8 Jul 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnNZEtum"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A47E0F1;
	Mon,  8 Jul 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442553; cv=none; b=FajU6vvm4sTa6qTNk/4YXQ/w3w3uqx2JvsfO4PyQJgnBrtzlK8s+vjvlrbHCJyiloLv7Rc/vQ8pWLGMt9RfDg7qgmbvuCRjab7WoKnQKwfRDnD6UAP5BIsrimX6btlMvARHgxiJzGIhTGAM8wRFK2X0lJxFq42WgaUr1cwGFXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442553; c=relaxed/simple;
	bh=fKVbR/FP1XbnZ96DUlSQR8n5Q2rNwrc61LpUImOtSho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVBWX8KesYfrpLbgIz7/gZ/0QoYE3rBtYV7xU2oPmc3q1zCB7NyltjhV+J3JcnXBUKpJ2A68ELKKAhx2KHcsz99UyUwVJYk+5uoy5WpZkzS847sK0GePhKCuVzng94kfZCzMpN/pycN/EobjpJXcUoMAJTrW8egiYPF9k9JKsEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnNZEtum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5219C116B1;
	Mon,  8 Jul 2024 12:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720442553;
	bh=fKVbR/FP1XbnZ96DUlSQR8n5Q2rNwrc61LpUImOtSho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SnNZEtumS7GE5Px0dl+3NAB+RGTzHl29tMBpqYz5C6Htkku4F+SD7EgR3/38X981g
	 OwNQIYVU9Pc/8+Xipk+k/WpoeP/d6ckv2nOXQQO2yTwtCCQMHi+ZOsjM8chs5O6e+Q
	 FTic87tgopObdlFRgyjrV0DCwmbQit6URpiac6gE+vI2a+CQ6/BFt7flbTRqmKvKDW
	 6dtNMUfmRCnnRfKJk5Bph9nE8mmDzPUFPte+uFOfo9kOFuYIPVCpykd9JS4ucLBQx6
	 uJnovnz1DVHYEtkWk+5ptoJSoN29nTdEeHXKg8p68YnwOwYIy64AwET9kkApgHLbOE
	 plNfkwWW3kUdQ==
Date: Mon, 8 Jul 2024 13:42:28 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, apw@canonical.com, joe@perches.com,
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org, willemb@google.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 6/6] ice: devlink health:
 dump also skb on Tx hang
Message-ID: <20240708124228.GS1481495@kernel.org>
References: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
 <20240703125922.5625-7-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703125922.5625-7-mateusz.polchlopek@intel.com>

On Wed, Jul 03, 2024 at 08:59:22AM -0400, Mateusz Polchlopek wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Extend Tx hang devlink health reporter dump by skb content.
> 
> This commit includes much code copy-pasted from:
> - net/core/skbuff.c (function skb_dump() - modified to dump into buffer)
> - lib/hexdump.c (function print_hex_dump())
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


