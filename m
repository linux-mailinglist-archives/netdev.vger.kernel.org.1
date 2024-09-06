Return-Path: <netdev+bounces-125755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6F296E74D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 03:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D61F283FFA
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 01:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E831DA21;
	Fri,  6 Sep 2024 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZI6xl01"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407EDD2FF
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725586304; cv=none; b=jMNF5CFsB7HnBWhDsFFMvZ8Bvecd4fjXTL61nicm57dCvdF57wgWVjBV4GDzuo7jz0tRQEnPPVDGnT/xQtQCUdrRIeGcLTV5JcARbWaAuqhaZ1O/BohMz8shGHTgw+oY6mQoC4fOnCHuZ8Wb9t/IFvwrOmChycYxww6UmVhdij4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725586304; c=relaxed/simple;
	bh=sesYlp0Xu863dqMAb9giY680FERMAJONXVOqrATAoa4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcPyUG1YZgK4PVjR4qU1dZ0dUVzzJIYZlbFM2cuYLa1bieHJw+4g6VLSolznOLMZIT/+unk85Ot4noNN4uWyIaAbEba/LZFLa7i91SJQi0J+mzqTuOSEynoFhJ/tJqM0V5LAGmI4Amu0VFElMRvqy5Yz4pWPKp29g3W+Obms0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZI6xl01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B3EC4CEC3;
	Fri,  6 Sep 2024 01:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725586303;
	bh=sesYlp0Xu863dqMAb9giY680FERMAJONXVOqrATAoa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jZI6xl01Tc2HOo3prgg8BiiDhGWmJTbgjtyhYuxX3wgeuDRf7+uTHEADYTjMtg3MT
	 oIrBX+rg+Ay0NGKKo0GAaULHIKElAT0HaslwDowwn6Ae9RN1XpVBSlfN7abMRRKy09
	 3Day741le4YKxY97SJ+v7GU7Xydi3S4w+admVZnVot+x/C/dmdcmutCGmj9HrPGizc
	 ok3eJLBmRt+tS8/LWAOvL5YjCl8wwGvFFwd4RI20dDWmz6O6g5zBw9OT/qpHhFjTv0
	 G7yO//de4qKpSHjWI3sb/otZxKTUgy20spp/Jm1blmYuw59iPFCwh/8e7645FTgomP
	 /i7sOvkih8e2g==
Date: Thu, 5 Sep 2024 18:31:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nelson Escobar <neescoba@cisco.com>
Cc: netdev@vger.kernel.org, satishkh@cisco.com, johndale@cisco.com
Subject: Re: [PATCH net-next v2 3/4] enic: Report per queue statistics in
 ethtool
Message-ID: <20240905183142.424c1d72@kernel.org>
In-Reply-To: <20240905010900.24152-4-neescoba@cisco.com>
References: <20240905010900.24152-1-neescoba@cisco.com>
	<20240905010900.24152-4-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 18:08:59 -0700 Nelson Escobar wrote:
> Make 'ethtool -S <intf>' output show per rq/wq statistics.

> +static const struct enic_stat enic_per_wq_stats[] = {
> +	ENIC_PER_WQ_STAT(packets),
> +	ENIC_PER_WQ_STAT(stopped),

Stats for which structured APIs exist must not be added to ethtool -S
Please filter things which exist in qstat out of ethtool

please see:
https://docs.kernel.org/next/networking/statistics.html#notes-for-driver-authors
(it talks about rtnl_link_stats because only those existed at the time).

