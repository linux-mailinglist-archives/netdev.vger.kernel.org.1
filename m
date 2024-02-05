Return-Path: <netdev+bounces-69086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592FB849895
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8746E1C20A14
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD3418EAB;
	Mon,  5 Feb 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDxROHG3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC518E0C
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131631; cv=none; b=XB6SYbAMyqlK6zuvjRtRJXLR33gqNi5xZCpWSyzWbT4ZJPBE8B9wP6zn8JnKLo9JOJ9yQSo4Iz3ILityaiQT70Y5yiBLULbBq8TNdFjOoGzp+zpTtYoNlYAKE/TGd8K724z4EAXFwDULsScmXg6+OHV1uc2vPyvFJ7ig07vvpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131631; c=relaxed/simple;
	bh=4C6OaP/da9oAYOAJ5UNQpdN/3f2Bh3PxhZQD9fptMIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+5u3dNsdiB7nx8fJY7ibhWeihbkdl9XfClec6MBjKH+tx9Ln6Z4nk3qHnscSHNDLuO5HF6A1IF7nIn9Z3vFN6HeEtfQxfYyeiUOWnm4IjTiSqtp8eszXSq7GhUHHW9iX3xhM5420qye6yC2L3lL6nk+IkvMyYOfbcm2hSZmhFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDxROHG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF37C433F1;
	Mon,  5 Feb 2024 11:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707131630;
	bh=4C6OaP/da9oAYOAJ5UNQpdN/3f2Bh3PxhZQD9fptMIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDxROHG3q1HVAt47x/8I9P0mDDaOXFruXTQ1JghIJOh5m0mHSA6WJ6bPjEDcqCbmd
	 BVhkDU1XdodR2VfwgCwIn/6KtiQV7EZgAjpHHtPKO6ej7m39oisjSInYURFExU+FeG
	 zaUxzokuJUiZV2ywGhIo30B7o3uOrqcjfNXSvZvzXKhlqDZa0U4aHvMw/lX2Ck/Jxb
	 CQuI5tLWPq3uyQyuMcqiFp6oefg304IqcYJKR3T7+8X5vdbL36fqz1YdOODAHAQ42N
	 VZi+tp8YU3VrZR0ESBRqd6rFZYCXxa3RxHbrztIeCYcZ/VTMme8QpTglwRDL2p1NDz
	 vXq18fVnkc0JQ==
Date: Mon, 5 Feb 2024 11:13:47 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com,
	Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH iwl-net 2/2] i40e: take into account XDP Tx queues when
 stopping rings
Message-ID: <20240205111347.GI960600@kernel.org>
References: <20240201154219.607338-1-maciej.fijalkowski@intel.com>
 <20240201154219.607338-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201154219.607338-3-maciej.fijalkowski@intel.com>

On Thu, Feb 01, 2024 at 04:42:19PM +0100, Maciej Fijalkowski wrote:
> Seth reported that on his side XDP traffic can not survive a round of
> down/up against i40e interface. Dmesg output was telling us that we were
> not able to disable the very first XDP ring. That was due to the fact
> that in i40e_vsi_stop_rings() in a pre-work that is done before calling
> i40e_vsi_wait_queues_disabled(), XDP Tx queues were not taken into the
> account.
> 
> To fix this, let us distinguish between Rx and Tx queue boundaries and
> take into the account XDP queues for Tx side.
> 
> Reported-by: Seth Forshee <sforshee@kernel.org>
> Closes: https://lore.kernel.org/netdev/ZbkE7Ep1N1Ou17sA@do-x1extreme/
> Fixes: 65662a8dcdd0 ("i40e: Fix logic of disabling queues")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


