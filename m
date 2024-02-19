Return-Path: <netdev+bounces-73055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90085ABCD
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1242285127
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA47250260;
	Mon, 19 Feb 2024 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1TqxahM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FC750256
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369994; cv=none; b=mxvpvWXNVUxzGKbWLq+Tfioe0D3tsf67JClZ7UBnO4H4oaLsnluO950xwdt7oZqSjMp+AMhfjcFBCwfcr8kfNbnXDAAF5bvOkLdcGcvQCJhOzXDRDaRtJiPtRcGDQHAO5c98ytFh0t3pm+ruoKwas5VOA80fIvXjiWJ3YGwp9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369994; c=relaxed/simple;
	bh=8aJm1GNGzht2jCtok+oBe2zSx7oNYydmpXjPdC9Mc1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4ymBuj5FoISj3HPDsUN5csUr5na0SMnqG0PdN09ykfdM74L1ljUlIM7r4KOOK7OBiL70J7kAmpWLTBik+CaBwtXPNRtD38K/RYFOO4HivvZfag2AvMzZXy5qgLDs7v7O3HdS7EFSOomDjz10WOuknqD23/PJaGzhqXQVFzaIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1TqxahM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7094FC433F1;
	Mon, 19 Feb 2024 19:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708369994;
	bh=8aJm1GNGzht2jCtok+oBe2zSx7oNYydmpXjPdC9Mc1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V1TqxahMK6ZwhnEaABkqmbaD7dXAtUlUNQzaqeQV1CMBJi4sD9EbVjZdsxWjLPUwb
	 b7QmLTRHnxvTAnHaaepJnEDhuoaadnzbK9Ve6AsgrUUz6LKgj7r4r6u6MzhMuPHnwg
	 rDH5xZt3jLr9o1Bt2io1yD8LBoULU8RpTpt66pEffpeMBdhwydb9/wNyGfKbKl6pzJ
	 9ObKP8NExhdm7f0332mby/W5gCuHX4PtQ7qGNdTG+aYqUYQIOLYyDvSeYQOTTfAXTY
	 FcirtppVotvEGbgj93KaJ8ETRyBzgRRYIT2mN/K5iup64SvuXzCKUqDfdiTbNd55q0
	 MIk3dM+YiyR+Q==
Date: Mon, 19 Feb 2024 11:13:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [RFC] netlink: check for NULL attribute in
 nla_parse_nested_deprecated
Message-ID: <20240219111313.75bcb905@kernel.org>
In-Reply-To: <20240216015257.10020-1-stephen@networkplumber.org>
References: <20240216015257.10020-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 17:52:48 -0800 Stephen Hemminger wrote:
> Lots of code in network schedulers has the pattern:
> 	if (!nla) {
> 		NL_SET_ERR_MSG_MOD(extack, "missing attributes");
> 		return -EINVAL;
> 	}
> 
> 	err = nla_parse_nested_deprecated(tb, TCA_CSUM_MAX, nla, csum_policy,
> 					  NULL);
> 	if (err < 0)
> 		return err;
> 
> The check for nla being NULL can be moved into nla_parse_nested_deprecated().
> Which simplifies lots of places.

If it's mainly TC which has this problem the fix belongs in TC,
not in the generic code.

