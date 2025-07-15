Return-Path: <netdev+bounces-207188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDD0B0624E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60603A4A15
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFE4202C49;
	Tue, 15 Jul 2025 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV+ikO0l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744414386D
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591992; cv=none; b=iXQpnhTk5ZBqBQxOlhJ08FkdO8hTFfhUuTz9kBmiZAlH/xRWxbNTC2/3KuBNFhqDoX8okTJSwACoooEPcfp7zehH2cYn7Qj/TFEAsZhRctb29+94oMPoL/0cyuZfzd16Ay9cUGlPeNjhX942MfXgqRvCpUnyQ/yKTtOGS0XbGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591992; c=relaxed/simple;
	bh=ODnYSRvFkrnDjB+C+7nZvPpp++hFW7ePRxImq9aXiOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFiWIgFZTfFj+hpJdS9J7zyceNIVgMVGs0PQMih3inbXLuX0EjPqhckSS1V7XV34DGutquD/56VbDWvcbsbXxKAmiJZ36cBeVaR/t3wz4JU/OWKTuUupZdr8QuDQsVukazNaQCBpLvbJnj/V0eZit/GhhtAyJthvrQ+0hCv5/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV+ikO0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B21C4CEE3;
	Tue, 15 Jul 2025 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752591992;
	bh=ODnYSRvFkrnDjB+C+7nZvPpp++hFW7ePRxImq9aXiOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mV+ikO0lf3/ncrqWcBp8Zoh+HGRuLxcc19u5Y29C8nzMjTgRoN6tsgex9QVWZjj/c
	 2Yc/vcPE9bfaN1RLsYU5s33g/yX6vG6aNPpEZ2od6We5EVojuMsx2WB0wE4amWuYw6
	 XAEqNBVu6GSBRyQYTt5FOhLrIGasBPdhbgP3PHE1jjTU+zlkUUiHyMw+jxbVDuIeeI
	 2F/0tJRgkvn+5A750DJi5YIcMU2kZWo+oc1IKZI09gNNbeIs3jRAmJ286FdMZn34H0
	 LAUT2bE64NW7FYLIVYqu6U/6a0S7tSMgMNXEvYOCyJdLNTCoe1umDajIGpt9vpC0t1
	 TXjd5PGLfR2UQ==
Date: Tue, 15 Jul 2025 08:06:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Sabrina Dubroca <sd@queasysnail.net>, Donald Hunter
 <donald.hunter@gmail.com>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net 2/3] ovpn: explicitly reject netlink attr
 PEER_LOCAL_PORT in CMD_PEER_NEW/SET
Message-ID: <20250715080630.2704593e@kernel.org>
In-Reply-To: <d063c580-9e52-4f2b-ada2-7ca097cb9b85@openvpn.net>
References: <20250703114513.18071-1-antonio@openvpn.net>
	<20250703114513.18071-3-antonio@openvpn.net>
	<aGaApy-muPmgfGtR@krikkit>
	<20250707144828.75f33945@kernel.org>
	<aGzw2RqUP-yMaVFh@krikkit>
	<d063c580-9e52-4f2b-ada2-7ca097cb9b85@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 16:36:40 +0200 Antonio Quartulli wrote:
> As Jakub predicted, I am hitting a problem with PEER_GET: the 
> attribute-set is one for the entire op, therefore I can't specify two 
> different sets for request and reply.
> 
> I presume I need to leave PEER_GET on the main 'ovpn' set and then 
> opencode the restriction of having only the ID in the request.
> 
> Similarly goes for KEY_GET.
> 
> Sabrina, Jakub, does it make sense to you?

Yes :( Sorry for the mixed solution but I think using the spec to its
full capabilities is worthwhile, even if it doesn't cover all the needs.

