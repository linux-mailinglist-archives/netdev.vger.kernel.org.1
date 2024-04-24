Return-Path: <netdev+bounces-90724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF248AFD6B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D7BB22C6A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BDD4405;
	Wed, 24 Apr 2024 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmzk0++Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828FC6FB8
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713919494; cv=none; b=tYa9VB1MWmm1LcTCtlkBIRQqVvDMSOPDTH+T9HQQzMrNu7HAnCNJueZmv1WnjyFWnZ2EjPDTrHWIo5PWcssO/gdQ3Ghciy+ruY5Jdh+E99qf2ih0xx93RK9Sm9IGDxU2FHIgBlx8U36QeDMpABjWTCJ1bh9URh4WFZM/A2TgI5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713919494; c=relaxed/simple;
	bh=iNzBbO1Wfri7KPcfrcOfgCehA4a+93hC7JKqVMFmiDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjWohR7sy5K2AhSdiLEKAD5rB+vO9dNyHfjNPXq9vGHR3xC7TsGvrYFkMI5RUYKxzuzArNotlZfEqWhNvsS51qb+0+K62gDXGeQRbuwkOXos3IooChFHI9kHITEJMrGJJ3I2XRV+oCHNrMqcXDmUyQLx5D4IP14r8AfwlbC1Szw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmzk0++Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7F5C116B1;
	Wed, 24 Apr 2024 00:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713919494;
	bh=iNzBbO1Wfri7KPcfrcOfgCehA4a+93hC7JKqVMFmiDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pmzk0++YnnlvvrSgsNSSnPD7r75P0Mo5t6RAE6Yu2OBizPSbqD9ULRZ5UGWr0FC9y
	 kTNHoWsQgX2v+CnKVHh+liL6jRNRJRoxfnd+5SqSOXBCsoMYYK5KKibAn2I9z6Ko5l
	 m4dSYyURdZgQI+V8sgrpdzDKWF7ArKXCpW8L+PZiiEA4FJW884rOxOYTTDO8Gc5qPf
	 H476jBleRq//L7I7Hx1cPMfkgFdiKuNuhc2fQWRKg0A9bYMvPs6nt8cI28EEEIPKel
	 QahBbaLLLKZU10A9Yr3h8LVJyvPAHWk6zYiANuN29IdXALa9UBUZkCZFI1oEWwdvdy
	 XdcSs0nQH2Skg==
Date: Tue, 23 Apr 2024 17:44:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, laforge@osmocom.org, pespin@sysmocom.de,
 osmith@sysmocom.de
Subject: Re: [PATCH net-next 05/12] gtp: use IPv6 address /64 prefix for
 UE/MS
Message-ID: <20240423174453.3d4bcf15@kernel.org>
In-Reply-To: <20240423223919.3385493-6-pablo@netfilter.org>
References: <20240423223919.3385493-1-pablo@netfilter.org>
	<20240423223919.3385493-6-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 00:39:12 +0200 Pablo Neira Ayuso wrote:
>  drivers/net/gtp.c | 48 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 10 deletions(-)

Some endian unhappiness here:

drivers/net/gtp.c:139:43: warning: incorrect type in argument 1 (different base types)
drivers/net/gtp.c:139:43:    expected unsigned int [usertype] a
drivers/net/gtp.c:139:43:    got restricted __be32 const
drivers/net/gtp.c:139:62: warning: incorrect type in argument 2 (different base types)
drivers/net/gtp.c:139:62:    expected unsigned int [usertype] b
drivers/net/gtp.c:139:62:    got restricted __be32 const
drivers/net/gtp.c:139:43: warning: incorrect type in argument 1 (different base types)
drivers/net/gtp.c:139:43:    expected unsigned int [usertype] a
drivers/net/gtp.c:139:43:    got restricted __be32 const
drivers/net/gtp.c:139:62: warning: incorrect type in argument 2 (different base types)
drivers/net/gtp.c:139:62:    expected unsigned int [usertype] b
drivers/net/gtp.c:139:62:    got restricted __be32 const
-- 
pw-bot: cr

