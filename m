Return-Path: <netdev+bounces-215290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E16D2B2DEAB
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 16:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9F87A631E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1911425D535;
	Wed, 20 Aug 2025 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUZEN1Du"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953B1B0F19
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698784; cv=none; b=knLEQ8IiVvtEFt1wnL9hiG18OgXpKvKR2aeRRCOCfsGehBsIfnNA8URE0U2PnI0sib7TVpI/5N+W46t0GdpGo831P3E4EXrJwAR3t6omrZoQjbMBdGQJUqi4NS/JazFkktUwFt7RthG31oMzc/af+50RHBOi2m48qpEJLprOpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698784; c=relaxed/simple;
	bh=xxJTvJeSrtLEoYNWQ+P3z3eQ5fJLX1oQxjiWaOt14y8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocDmRrxAv72ik9Q9wZtaNq9ntg5P+T36VgYALvOwrznR35A5kjfpLkZJsZuw/8chxnLfqlFHOV6Q85JKcamHDR0YS8pqUb86bNK+w0VdWaG7kJrr0y4tt5nnMOPwBhruDdxWTcTPQ+CcgZitC5OAJXN72vWSc1yY5e5XMM/GqDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUZEN1Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF739C4CEE7;
	Wed, 20 Aug 2025 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698783;
	bh=xxJTvJeSrtLEoYNWQ+P3z3eQ5fJLX1oQxjiWaOt14y8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sUZEN1DuPyC1i/svsQDnBMVivJN+VKD1cW+B/24wLTwD56Z9/vN2pr4EY0He4Uxmu
	 cf8kjXfsWALri5do9Nngwi+t3J6wfd/QVWE/vyFDcu+sIME15Jnd51kwSB84h4B6Qc
	 +NT0j3atPvynChWxoVtV8fs8czM+w2RQdEPh6s0L0p1RjVck0B3rHpZq/BtU36Vc2h
	 S0m/qwN2yhasapk/yui4cIKnntl6wGokLKECHiEXo8hxWLQjjk2SF+hyjS/jUezn5c
	 rVnMcJW0DHtDd0ZsgjVnwzhBbZr2RhKzaORkRDJBl+djNb/7OP0FO4GC/aEmb6f5Vc
	 F3CymRBQtQgMw==
Date: Wed, 20 Aug 2025 07:06:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Leon Romanovsky <leon@kernel.org>, Boris Pismenny
 <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de
 Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7.0 00/19] add basic PSP encryption for TCP
 connections
Message-ID: <20250820070621.2f4cf7a1@kernel.org>
In-Reply-To: <20250820113120.992829-1-daniel.zahka@gmail.com>
References: <20250820113120.992829-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 04:30:58 -0700 Daniel Zahka wrote:
>  include/linux/mlx5/mlx5_ifc.h                 |  95 ++-

Tariq, Saeed, would you like to fold the mlx5_ifc.h changes
into your next mlx5-next PR? Or is it okay for those to go 
in directly?

