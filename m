Return-Path: <netdev+bounces-99923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76DB8D703A
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 15:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1459E1C20B88
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543C11514DC;
	Sat,  1 Jun 2024 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rn6moEja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B3824AF
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717248808; cv=none; b=lFEBpm1Do04MZF+hGmw1ymoAg3e+qmv1a/Ppcq6r8s7Ts950lCIHg+rv9vYh6rrA4EtR9QMR3q/IqH3P3vxgHhy1/Mq8pW/WVcEVot/J4vf5xU01hyH4KIeXxLp3TKN64QQL9W/NzA7v/e1V2auwfwP0NgkqkE8iDl650W3VqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717248808; c=relaxed/simple;
	bh=O4Qcp6gTrWx719Wf7YYA47W+bVFj66fUbAcnH/Ic6rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kApyIXIsd7jL8Wy1DOdDzWKGyGeY3ol5NYiGzipYh2gxQJNcwX3nw35l3MNDoGI6E/h3UPYMi6RfN7T3R1sHZmGoiJOdqvO5No8T1BB0heFfPtp299q4JMIh+tXWClP0QSuNFx9EM3YohSYDzF2+JvaOts0sctrP5lkk2PVEZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rn6moEja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6468C116B1;
	Sat,  1 Jun 2024 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717248807;
	bh=O4Qcp6gTrWx719Wf7YYA47W+bVFj66fUbAcnH/Ic6rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rn6moEjab8RdnBKadGF2kqsBJ0EvFtK5ckeWbSj2JqulVniEgcaOp8ACO18gtEBqH
	 yREGEfhz35JBfoP8ATwZ4xtBy2V06Swn5ni1umJ5Y4cNJX+XLKnslw4OwIvQUeegKU
	 B2Anl7+Rx1Y2toWcDbDYwh07djFguBPAczwljbrhM0ga0jAdEPx+I0BoZ6QNqKHHn/
	 rk8L1H6G/f11SgiZOFUNQVeIoJf4hoSCaPls6CfNuJAwu7ojMznAkGbVpgSJ0NrcZC
	 nou0pr8c5kU7Cl52BYAgvvhdl4SS8EY59ZWFShL8/JXezV+LXyCta3eNKXhWzWKZ3j
	 90JAVc8y7PRNg==
Date: Sat, 1 Jun 2024 14:33:22 +0100
From: Simon Horman <horms@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, i.maximets@ovn.org,
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
	lucien.xin@gmail.com, marcelo.leitner@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	echaudro@redhat.com
Subject: Re: [PATCH net-next v4 1/2] flow_dissector: add support for tunnel
 control flags
Message-ID: <20240601133322.GP491852@kernel.org>
References: <cover.1717088241.git.dcaratti@redhat.com>
 <f89d9bffac091e52a30c819211358eb8d066f156.1717088241.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f89d9bffac091e52a30c819211358eb8d066f156.1717088241.git.dcaratti@redhat.com>

On Thu, May 30, 2024 at 07:08:34PM +0200, Davide Caratti wrote:
> Dissect [no]csum, [no]dontfrag, [no]oam, [no]crit flags from skb metadata.
> This is a prerequisite for matching these control flags using TC flower.
> 
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


