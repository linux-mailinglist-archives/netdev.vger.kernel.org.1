Return-Path: <netdev+bounces-135985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4EA99FE50
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46219B22F43
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5094879B;
	Wed, 16 Oct 2024 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVQ4n/Rn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590AA433D9
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042343; cv=none; b=ZE4vcCWV+QdQCqwxgRlWkIOx+lJsfUWsISylWcTF6H36Uzp2hihRXXwa581FSeHg6CixV+FoSD63rF4thkFlS9GI5SRRjSUzNUqRhH4xJ8xVQjSEaZU+Q31xSJsBNORfjNLo8QUvHWYyuCmK5EV6dZ9oxk4AS0FP9fuzqAUR9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042343; c=relaxed/simple;
	bh=F4+kZIOHGDz90rPLH3tUDLhWrvicxsDAXc6JlpgLTjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlUZp1rfjS/WlUzHUeH79YOHG4plr+Gm2FzbMtjfdbqIwib0WlpqahnINie02iSXmT0SmwXb+4iqUG3zSOQ5REbYnmT3BHSJ1R8jlDdTBHSCVJfN/JwVQ9MdrPY8D/SBeNEHUzII+Q9AIGqNBokK06zJgtP2ujBEKTcCf+f8Mnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVQ4n/Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601C2C4CEC6;
	Wed, 16 Oct 2024 01:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729042342;
	bh=F4+kZIOHGDz90rPLH3tUDLhWrvicxsDAXc6JlpgLTjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KVQ4n/RnUcUQKMFSh1nQrxUXeM6QYcE3JeCks132WeZdKdBLbvemv3UWK8qR+hvR0
	 Rw7j03/G+RYOCwbQ1xMp2cotamLXEc/WiUTHOAkrAarUB6KnjEfpY/Tvj13u/kwatj
	 vmOEJ5zFZnXvKvQoLsnntw/B4NIe7GqyjW9wuq2Xs2iF67rUzZiR9pfd3bLKWoGOp8
	 u0TLUMSZaFxgNY34sDSV87xJQEkzmzjxkiYoso0yofmN3fKX21k0M98hfZr9i+w77z
	 KLOP8qlMPtsmHJ1nvl2qCZ3mcksVbZm7FNxHToQJnQWOg/Mzenola+aoBtq7izVUNw
	 foJiuDZslQ61g==
Date: Tue, 15 Oct 2024 18:32:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH net-next 22/44] tcp: accecn: AccECN option
Message-ID: <20241015183216.6e0be5f2@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20241015102940.26157-23-chia-yu.chang@nokia-bell-labs.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
	<20241015102940.26157-23-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 12:29:18 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>=20
> The Accurate ECN allows echoing back the sum of bytes for
> each IP ECN field value in the received packets using
> AccECN option. This change implements AccECN option tx & rx
> side processing without option send control related features
> that are added by a later change.
>=20
> Based on specification:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> (Some features of the spec will be added in the later changes
> rather than in this one).
>=20
> A full-length AccECN option is always attempted but if it does
> not fit, the minimum length is selected based on the counters
> that have changed since the last update. The AccECN option
> (with 24-bit fields) often ends in odd sizes so the option
> write code tries to take advantage of some nop used to pad
> the other TCP options.
>=20
> The delivered_ecn_bytes pairs with received_ecn_bytes similar
> to how delivered_ce pairs with received_ce. In contrast to
> ACE field, however, the option is not always available to update
> delivered_ecn_bytes. For ACK w/o AccECN option, the delivered
> bytes calculated based on the cumulative ACK+SACK information
> are assigned to one of the counters using an estimation
> heuristic to select the most likely ECN byte counter. Any
> estimation error is corrected when the next AccECN option
> arrives. It may occur that the heuristic gets too confused
> when there are enough different byte counter deltas between
> ACKs with the AccECN option in which case the heuristic just
> gives up on updating the counters for a while.

net/ipv4/tcp_output.c:922:5: warning: symbol 'synack_ecn_bytes' was not dec=
lared. Should it be static?

