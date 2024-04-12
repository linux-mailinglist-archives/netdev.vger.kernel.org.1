Return-Path: <netdev+bounces-87246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCA08A2427
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 05:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C6228677D
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 03:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13802EAE4;
	Fri, 12 Apr 2024 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzXGwuOV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E189617583
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891171; cv=none; b=X7v6MB/ICYS0bmZtJJIARyIRAZ9twp3thnex5uRZYoqWgo6yItrtVWJPru72SkUcYM/wJG/5Kvg1mmTLg7OywutKRcTV8iT1kV0oYj+NtUW7Zs7+YIt4OAFWD8RZJfRdciM7+7ULLI67f2yVWMhyKqM1ful5DAGEQbaMb+1pqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891171; c=relaxed/simple;
	bh=RtGGM5DCStDILWqsl4DInc+GwisZyMLDDjy4VqzzkNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/H5B5/l2LLAhL/cInRPqskiQVRrHmIF5QNwCEGTnNJT5tUNy9iWo8VA7eblvHJXdqTxQqTihCLVpUUlGjO/gvIG+xG6GHvdkxJ/IsPfVrnnEmh03dPjOAmQ23c0Ow5MUU0tYok9f7XNepIBKJRPCGryS6uELm1GRvqqnfi44bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzXGwuOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0961C2BBFC;
	Fri, 12 Apr 2024 03:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712891170;
	bh=RtGGM5DCStDILWqsl4DInc+GwisZyMLDDjy4VqzzkNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jzXGwuOV5tlnwu3lpbtHVy61bA3+JVpSCjUs/QYy8YN688eqPTZjX5cUDYowD/Xvl
	 fNlUiWjDV9AL0O5+jtzVxnNGp6NDL0AATRjt9Tu59EVXKGi+R09SW7vZ4Ep2khIVU7
	 M4b7fsNQJEmVM84yy/j3/v6EXEAZO0vCsM6fk3HLfAEHy37j9+f77isc3DTvpFcCY2
	 tevnxOp9t1YkpeMfNRzXMWA6zfqhHFWyjyY8vOABT6lFp1/LjwikWcYMWFvOJbul85
	 AZTK22YA/Hl/35po7BPIdASAfv9k6opOgC1hr+ikPcS1JYgsLozz2iMc/4YJU2Tz0g
	 xCZna440wIUxA==
Date: Thu, 11 Apr 2024 20:06:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Jakub Buchocki <jakubx.buchocki@intel.com>, Mateusz
 Pacuszka <mateuszx.pacuszka@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Lukasz Plachno <lukasz.plachno@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 2/4] ice: Implement 'flow-type ether' rules
Message-ID: <20240411200608.2fcf7e36@kernel.org>
In-Reply-To: <20240411173846.157007-3-anthony.l.nguyen@intel.com>
References: <20240411173846.157007-1-anthony.l.nguyen@intel.com>
	<20240411173846.157007-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 10:38:42 -0700 Tony Nguyen wrote:
> +/**
> + * ice_set_fdir_vlan_seg
> + * @seg: flow segment for programming
> + * @ext_masks: masks for additional RX flow fields
> + */

kerne-doc is not on board (note that we started using the -Wall flag
when running the script):

drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c:1285: warning: missing initial short description on line:
 * ice_set_fdir_vlan_seg
drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c:1292: warning: No description found for return value of 'ice_set_fdir_vlan_seg'

