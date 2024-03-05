Return-Path: <netdev+bounces-77651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996858727CF
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 20:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B02828F1BB
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D461292D4;
	Tue,  5 Mar 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/fR7HmJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69D12836E
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667630; cv=none; b=E3xM7XnUj505cWchig3Y8CJFMugFgWM2UD3DCqMxblugRVMSSELpkiYQTN6nl6IyFqqDXiiwuZntfOk222uvdzjcUJ/f6AXtBvwJhx4Tz+S96CwT/kjce9W2qBjHOH7Q7uy6+5VzyGytupkOZhWlZMkn0y8uk//GBzBSz59lfNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667630; c=relaxed/simple;
	bh=A4fGldw5WQnnzIjXmo7mkssX0/UAyzV5J/znVVKeCso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuJYo97LpyodKvvF1cTAD5m4JNdRV4ElyMugjIs+xJaCZxfnMUvsEDxLhluqt7gGpx8qJP5AoeYg9ZrKqN/j1HmMCPLNDc46A1RCzrFtljqTOek2XBe/doyGWOtCs69LZM3NoWkv/1b37O67E/wWjnhqkxmRPBdhEvOkRbzp1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/fR7HmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9028AC433F1;
	Tue,  5 Mar 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709667629;
	bh=A4fGldw5WQnnzIjXmo7mkssX0/UAyzV5J/znVVKeCso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q/fR7HmJ7NbPOggv7wA+Q7aku5cETnMcE7yGUALCPj3u1TK5biPE15BOH6gZlmOyd
	 rFQhq/Kxpg48BEQMcRbgIGORPgDN2f+9hc5yKJK/vU7IMCsFugBiKQlMsyfpzElmWr
	 PYk5YESDZ8lhb2TX1JfpvbD3n6XPtYeIvqLLr7GhJXhikBa1yikOzGCc8Ya3r40fUu
	 BwtXYKPjtxCsN3OnMTYxWW56aRmHzMfoKfNK3efZ6MC7a18ra0zY4nKalHPqiVFd6D
	 RtjLxvdRz5pX06eQScy+vxGSvyFLgdS3pIUn/RbsYgTC8fXUFEqvLkhCq/FS4QIJXc
	 ot+3zXFP0q1nw==
Date: Tue, 5 Mar 2024 11:40:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 04/22] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <20240305114028.34f8c253@kernel.org>
In-Reply-To: <20240304150914.11444-5-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
	<20240304150914.11444-5-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 16:08:55 +0100 Antonio Quartulli wrote:
> +	dev = alloc_netdev(sizeof(struct ovpn_struct), name, NET_NAME_USER, ovpn_setup);
> +
> +	dev_net_set(dev, net);

the dev allocation never fails? Or the error is handles somewhere else?

