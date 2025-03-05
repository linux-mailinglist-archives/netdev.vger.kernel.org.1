Return-Path: <netdev+bounces-172004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3CA4FD63
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A8F1885076
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 11:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864ED23717D;
	Wed,  5 Mar 2025 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNCybJIA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62001236450
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173415; cv=none; b=ByguV3jnEEaudekQqzzjh6fTQlPyhDwa1tFfZdo1WvWYgt982+x+bf9QGAVt1VtPLg+vB6qO2r0EAjpq5CGHIRtJrGKrj4tOoY8/XPp2zozisLAHlN6MvYdY0M9g2OhGejHRYA1sQT5TlKkRDFJa06ZTXPvJ4uIC7bYYLFjrxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173415; c=relaxed/simple;
	bh=oRVq7ja1cQDhTMudEgPF0YfRGOOL+P0YUtT1U0ToH38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uub2ltgD8NZrH8qX0Vo1fxCL8ziJ6DvrQZUv+LPL1ptG5MBdyynBq6+PFKYAC5w8SLnRjfvid6JEv2w1OVMuVAH8DDK4T9BQSWoo+CxBfL7oHQsRqGavewLoUMSu+TT1XQ2gUC6qHg7frSY4U0RwtGVJ+sbdU8EowNwwHWNl4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNCybJIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B626C4CEE8;
	Wed,  5 Mar 2025 11:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741173414;
	bh=oRVq7ja1cQDhTMudEgPF0YfRGOOL+P0YUtT1U0ToH38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dNCybJIAfa/bhKZvnNTeehCBG0An/V5YlRQxrXDeLNusk7SBw81eesfM24z+ZJIRT
	 +DVWc9BTdLf1gd9TSVKv28MLLTcLSiIyS8o9La8CgdYlxRdFkZnnyUSiS+FAZMrMBz
	 rzrprj9RC8KrKuC5cvSSJHd3eiLLl5Fh/nVQRbfgPBulVmp8gcg2Q0nOmMS2uF7dr8
	 X8Tobbh9TKiBW6zi4Y3cKYjERj0Z7arTq4CJWhi3Fv7yNemIKrSlRUgK7vc17LADOH
	 6xj/f74IlJHRE9iqxcvyj9QZnVvCjeymiXE3Am2Y+BmXcZUndQMHrr8nnaEDdxTm8M
	 1bNVy0TdSy49A==
Date: Wed, 5 Mar 2025 11:16:51 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, andrew@lunn.ch, pmenzel@molgen.mpg.de,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v3 3/4] ixgbe: apply different rules for setting
 FC on E610
Message-ID: <20250305111651.GL3666230@kernel.org>
References: <20250303120630.226353-1-jedrzej.jagielski@intel.com>
 <20250303120630.226353-4-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303120630.226353-4-jedrzej.jagielski@intel.com>

On Mon, Mar 03, 2025 at 01:06:29PM +0100, Jedrzej Jagielski wrote:
> E610 device doesn't support disabling FC autonegotiation.
> 
> Create dedicated E610 .set_pauseparam() implementation and assign
> it to ixgbe_ethtool_ops_e610.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


