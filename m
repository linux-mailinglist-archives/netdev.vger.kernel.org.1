Return-Path: <netdev+bounces-68674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E62F84793F
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1471C203DE
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA11981744;
	Fri,  2 Feb 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdDTzvoc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504F81750
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900776; cv=none; b=PTbN6AS2FmoChbQK4EHTbvQzKHFaUfMo4Nk34hfxsfa6OCy8Ax583wknAqck4HTDeC1g1z3JSKXhVOr9q0sQex+0DGUgFQuQ08la/vYpLspgiNavjQJ4dklf0rwnqpOWsDvIEjAIWhZIrhEy6FjBLqOBB5H68GnIVzpLaKNlWDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900776; c=relaxed/simple;
	bh=tlOjrnKvgC2LOEqUt6RzgKeYWW3vfMz1hs2u+Hqkp6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrEo3wNq9fiiaFSgGgk0BzKeuGfjxEByU1ZmwEElCumI9+m741Tcu/pz+dcjIugB9ZjrsFF0HaMWVNzKIly2W+XmPaEIEX+DTjhLDVEATI5xk8wVVBBJkkEK96ueA0bw0jClxyUdyAXOMPHgqohmmNBj2EAmbg3yzMtIMqGXE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdDTzvoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F981C433C7;
	Fri,  2 Feb 2024 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900776;
	bh=tlOjrnKvgC2LOEqUt6RzgKeYWW3vfMz1hs2u+Hqkp6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tdDTzvocGW7B4avcdrx1Vg4UU0Llm4x5GqZR3bI5HHcqfUNIQWqJQ6CvH0HTtUUEW
	 a3R0G6jrvYrUo60LN8lPxcpBsdzC7nVKdFoVwqQpHHSbKQNVl8CI/LlCRVuORnKQBz
	 DGc8YN0aGiprFdnuhFHVhPoTU9PmlMb7+HuSglcHZG+snw3ZmGrZeBDS8Ol9/0wli/
	 GBhlMLGVyMP15/SUCogBz8ACTclFv6I1B8IhKUSK8hiSr6hK3Qs8PKGffodWnDLWjS
	 7+Rz/QHs8z2uKVtkgV5S1KlaTDZrnWJ3NKl3bGrxYkTIoLQVOzsYOTmNbgd0tng33M
	 rdWC3/LYhRd6w==
Date: Fri, 2 Feb 2024 11:06:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, mkubecek@suse.cz, alexander.duyck@gmail.com,
 willemdebruijn.kernel@gmail.com, gal@nvidia.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH ethtool] ethtool: add support for RSS input
 transformation
Message-ID: <20240202110614.18a0770e@kernel.org>
In-Reply-To: <20240201204104.40931-1-ahmed.zaki@intel.com>
References: <20240201204104.40931-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 13:41:04 -0700 Ahmed Zaki wrote:
> +Sets the RSS input transformation. Currently, only the
> +.B symmetric-xor
> +transformation is supported where the NIC XORs the L3 and/or L4 source and
> +destination fields (as selected by
> +.B --config-nfc rx-flow-hash
> +) before passing them to the hash algorithm. The RSS hash function will
> +then yield the same hash for the other flow direction where the source and
> +destination fields are swapped (i.e. Symmetric RSS). Switch off (default) by
> +.B xfrm none.

Wasn't there supposed to be a warning somewhere saying that it loses
entropy?

