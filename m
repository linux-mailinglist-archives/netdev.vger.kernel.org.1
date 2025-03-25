Return-Path: <netdev+bounces-177433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276AAA70355
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AD416AC2B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3213725A62F;
	Tue, 25 Mar 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qD3BQ/Zq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082FE25A2BB;
	Tue, 25 Mar 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912017; cv=none; b=hmpK+nIHkp9eLxo/dOky+/1aBkZtKsFxTtiD4UAkfCDqlEqvae0BdVN7+G6G9/SeGcXCm/VXP9xz/EKhsfk4Roc39/bbghluJpmBvhGNfOTOsfw444tJyhjGblSRh4eGgxzc7HRNEOWNOa5e6aWYs8/NbTVMfnm51dPibLcMOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912017; c=relaxed/simple;
	bh=sBjlYfCr5b8xOzIsiH1d3ls+IexuKWJCSJv/rW+T8p8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UI8cYAiGkv72FepyB3ssZAqaIsCIsm+NZJaKdHxK50K69FDAF6niyr1GEEBDJjOW5mvAiwbD6A2cgtHgdw9HJkaDbLuQ9wu3ZxocMT9tX9HXky7bEKuZLzwrtUeR7UNyvoavkyb3um/IBelACIk8jiVI1SX1gRPbOXrY7z3S3SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qD3BQ/Zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECEFC4CEE4;
	Tue, 25 Mar 2025 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742912016;
	bh=sBjlYfCr5b8xOzIsiH1d3ls+IexuKWJCSJv/rW+T8p8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qD3BQ/Zqb7Tb4qEMvXVUFdcW4uHezvfpiiTPBs235dXJXWIR1V77yah66AYkLNCKq
	 nAK7rtG+ImjVzDSHMlb6antppPZxICoYJosZZzWCOgulHcBynKnXfGERlsDuX42yzu
	 SovttltZGFNqmzl9jY4lziQvaPFWn9XXwBtGSw9B3wrq5TG/dDEMyaSnRXoufcd+74
	 wvDNkrgd9+ickg/CIEskHwMerlNv0neDhU+lNx3sxvKAupYnE7aUvpt9m+25fugwEN
	 bc7B6JtOx1PfA6wSKdy7y0pimaRDWqom56LdC8JdjKpNREbEfDFx1RiETMzF+gGa1d
	 RAVHnLSmgvAJw==
Date: Tue, 25 Mar 2025 07:13:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danny Lin <danny@orbstack.dev>
Cc: Matteo Croce <teknoraver@meta.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] net: fully namespace net.core.{r,w}mem_{default,max}
 sysctls
Message-ID: <20250325071328.1d8e4d6a@kernel.org>
In-Reply-To: <20250325121745.8061-1-danny@orbstack.dev>
References: <20250325121745.8061-1-danny@orbstack.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 05:17:33 -0700 Danny Lin wrote:
> This builds on commit 19249c0724f2 ("net: make net.core.{r,w}mem_{default,max} namespaced")
> by adding support for writing the sysctls from within net namespaces,
> rather than only reading the values that were set in init_net. These are
> relatively commonly-used sysctls, so programs may try to set them without
> knowing that they're in a container. It can be surprising for such attempts
> to fail with EACCES.
> 
> Unlike other net sysctls that were converted to namespaced ones, many
> systems have a sysctl.conf (or other configs) that globally write to
> net.core.rmem_default on boot and expect the value to propagate to
> containers, and programs running in containers may depend on the increased
> buffer sizes in order to work properly. This means that namespacing the
> sysctls and using the kernel default values in each new netns would break
> existing workloads.
> 
> As a compromise, inherit the initial net.core.*mem_* values from the
> current process' netns when creating a new netns. This is not standard
> behavior for most netns sysctls, but it avoids breaking existing workloads.

You'll need to repost after the merge window:

https://lore.kernel.org/all/20250324075539.2b60eb42@kernel.org/
-- 
pw-bot: defer

