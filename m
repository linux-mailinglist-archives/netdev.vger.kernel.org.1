Return-Path: <netdev+bounces-72606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA33B858CEA
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 02:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911001F25DC2
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 01:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5857B1AACC;
	Sat, 17 Feb 2024 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MND2WIbr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A7A1947E
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708134541; cv=none; b=QF6UZ9guOiXl86cEl/TjKFLJIS8TjiELraZeC8ci/0pqo3yujOuYpGyAtCMEHvvCGvGc4kDhR80S09uwr3nw9goitEsB8YlrrpPhIOugwGJhxKOGop7vnp8KSyXsmN3xqXok/SUM8xIRDSYrkUdavV52tfjqpuVb1kSAShd3JJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708134541; c=relaxed/simple;
	bh=42ofK1uHUjjjacOZUxUV3JU5eZxLidMIsg/tArBAt7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufqiRLoEIxllwTcVzgcONtSYZt7GY8WnmYTYTlgNOxS8GFEcCRqM+YSZ4Sn3+FvyrVlYjyjrEY44pQw3ab0kWmRuzCKYig4MY6B0fdb0WLvT1PyThC1T1lpkk9KcwJ/3tkO5RCNpJW1WSuD0lXICM9ezd0CirPJ25rdSsdZBZqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MND2WIbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC544C433F1;
	Sat, 17 Feb 2024 01:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708134541;
	bh=42ofK1uHUjjjacOZUxUV3JU5eZxLidMIsg/tArBAt7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MND2WIbry584Ywa5HKKKEwCjHpNhE08RAS7uNTp9GX8gyth2vE7nyBM0OYvmoirQG
	 g5kIBlFaW5La91ayWS3VeYlap6OgdbLYnzFfM1g4zfC6jWaPh6PZuwbgDRcR6LLhu4
	 Gp3TFnA2HOVm6sKIxqXtjgv/9WI2f91G1QRMtr2rmMF/jYU2CvwOvZAOFR/WOQA+He
	 1KTUZzMe9dFbtwan3jcsSFd8rItmG8Rz+X6StVhhuDNiz7iunCrLThSOE1GInOr1J1
	 7I+dr/y4tKz+45yb8zQn63yPHSUWpMmIEpsweem9yKPoSCKZdfxinvgqZuTqqQMRAQ
	 FxZqS/uIPAcsg==
Date: Fri, 16 Feb 2024 17:48:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Sabrina
 Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v11 0/3] netdevsim: link and forward skbs
 between ports
Message-ID: <20240216174859.7e65c1bf@kernel.org>
In-Reply-To: <cf9e07d6-6693-4511-93a6-e375d6f0e738@davidwei.uk>
References: <20240215194325.1364466-1-dw@davidwei.uk>
	<ea379c684c8dbab360dce3e9add3b3a33a00143f.camel@redhat.com>
	<cf9e07d6-6693-4511-93a6-e375d6f0e738@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Also looks like the new test managed to flake once while it was sitting
in patchwork ?

https://netdev-3.bots.linux.dev/vmksft-netdevsim-dbg/results/468440/13-peer-sh/stdout

