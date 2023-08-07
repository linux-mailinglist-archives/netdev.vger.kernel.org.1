Return-Path: <netdev+bounces-24817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66CB771C6D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30E41C209F2
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760B64426;
	Mon,  7 Aug 2023 08:40:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D63D79
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 08:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18376C433C7;
	Mon,  7 Aug 2023 08:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691397639;
	bh=lY3AhzLehSM9XmaWfdlkVqeIlo+2AgKdiuMGe+Kh2wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4QSMN+0J4JnHx8SYLkYm2TNcjZZ7GVaX4phXYBknWiwb0pb8vRoQf2O2wJ3m+zTQ
	 SaBX3KSDimh+Z+4vrKvXvCsDuhj8PhcHtRkNNo2z0e/EtGbPZxujfyD/5Dl4QIEP3c
	 RUXEnWSgChvjFLTqYFnsDckfI2SmMlU4MzIppZWje4uy+bUsXwjkcD/rAI2oKKyAC6
	 GqmqvvbpIRHaL+rUMiVtL5GnO0CHjUaUoGBDFKTMRK/76tsPuduKo8vHEb1lyZyGaI
	 hZH6NDUbavWXI6fHAMqa1bBs4Ck2zD0EcosaoaWclKbo9pwAVdHgIPkoTB7j2A2eU4
	 lgV0SYr3g+DfA==
Date: Mon, 7 Aug 2023 10:40:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Rheinsberg <david@readahead.eu>
Cc: netdev@vger.kernel.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	"David S . Miller" <davem@davemloft.net>,
	Stanislav Fomichev <sdf@google.com>,
	Luca Boccassi <bluca@debian.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] net/unix: use consistent error code in SO_PEERPIDFD
Message-ID: <20230807-schnupfen-pechschwarz-5d81026b1c4a@brauner>
References: <20230807081225.816199-1-david@readahead.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807081225.816199-1-david@readahead.eu>

On Mon, Aug 07, 2023 at 10:12:25AM +0200, David Rheinsberg wrote:
> Change the new (unreleased) SO_PEERPIDFD sockopt to return ENODATA
> rather than ESRCH if a socket type does not support remote peer-PID
> queries.
> 
> Currently, SO_PEERPIDFD returns ESRCH when the socket in question is
> not an AF_UNIX socket. This is quite unexpected, given that one would
> assume ESRCH means the peer process already exited and thus cannot be
> found. However, in that case the sockopt actually returns EINVAL (via
> pidfd_prepare()). This is rather inconsistent with other syscalls, which
> usually return ESRCH if a given PID refers to a non-existant process.
> 
> This changes SO_PEERPIDFD to return ENODATA instead. This is also what
> SO_PEERGROUPS returns, and thus keeps a consistent behavior across
> sockopts.
> 
> Note that this code is returned in 2 cases: First, if the socket type is
> not AF_UNIX, and secondly if the socket was not yet connected. In both
> cases ENODATA seems suitable.
> 
> Signed-off-by: David Rheinsberg <david@readahead.eu>
> ---
> Hi!
> 
> The SO_PEERPIDFD sockopt has been queued for 6.5, so hopefully we can
> get that in before the release?

Shouldn't be an issue afaict.

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

