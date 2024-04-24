Return-Path: <netdev+bounces-90979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E228B0D2A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82F21C24B8B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E332D15E1F5;
	Wed, 24 Apr 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btaEbQXR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD82415B99E
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970279; cv=none; b=YtnvgOdMnnryppYauiGojxfdqdNszoy/+/ztLftQPK7PyMJd8TFgUjkc9H/tTYDHFkcTu5itJr6cEZ1EoQLVGf/EoL8+R3dQyXVbZE/NUEVAxZmwyLZiwBSmEpMhjq3IWktOKhrCutZD104tSXqZuetbeK959zfBkwYOfj2ECWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970279; c=relaxed/simple;
	bh=R9Uq9p2JIakmP+rllW6ZguG84IxZVp9xvlMj9gytFIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6715rbtQ1lz5WI2eKfptFaToTzLRBQhJ84EAmqd1M/QWoAxqVBtlXdmRe5MBO4LJNRzBOO8fWDNcHx0vJVfKmVbGpy6Q6ECIPD7StlqypsE0FHmb7Kmh3nE+aBqiNb0x97ySbzpleGPjQBe0GXNvcXhcK31uso2N4TEjUnEN9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btaEbQXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7BCC113CD;
	Wed, 24 Apr 2024 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713970279;
	bh=R9Uq9p2JIakmP+rllW6ZguG84IxZVp9xvlMj9gytFIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btaEbQXRhFSTmJty3XeQKDds0SHqXzIOSxue30CEo3fLuLbFw2kwRenu72RUTZHLa
	 taF4nRO7mhSVvQrVHJ4274HyGszx504qGzJEQBvNEukfDFjVuLflT/mzEeFsuV19m5
	 vfIWq/iEpyLqSITkAIMXlbY+NLWVDyMZw85F7xU4tYI64An+8sVbWe1Y0790sVmDKN
	 3b7mpGvGcl3GTtby6TR323d7xfRaj2N2R2oFSugCRC7eJ5ZNLKKGTA7p55hx87p4LM
	 dSKyuUJBCXkHETOE8cDXM8odatpHAFnipKuxJZswD6p3it8HTJDplOBGSiFnJkAK8o
	 wiR6JQcFl7qAg==
Date: Wed, 24 Apr 2024 15:51:14 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov <green@qrator.net>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net 5/9] mlxsw: spectrum_acl_tcam: Rate limit error
 message
Message-ID: <20240424145114.GG42092@kernel.org>
References: <cover.1713797103.git.petrm@nvidia.com>
 <c510763b2ebd25e7990d80183feff91cde593145.1713797103.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c510763b2ebd25e7990d80183feff91cde593145.1713797103.git.petrm@nvidia.com>

On Mon, Apr 22, 2024 at 05:25:58PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> In the rare cases when the device resources are exhausted it is likely
> that the rehash delayed work will fail. An error message will be printed
> whenever this happens which can be overwhelming considering the fact
> that the work is per-region and that there can be hundreds of regions.
> 
> Fix by rate limiting the error message.
> 
> Fixes: e5e7962ee5c2 ("mlxsw: spectrum_acl: Implement region migration according to hints")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


