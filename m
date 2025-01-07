Return-Path: <netdev+bounces-155704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29664A035CD
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 04:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117211631F3
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B125D2AF10;
	Tue,  7 Jan 2025 03:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnKbN6Xk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB99A31
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 03:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736219957; cv=none; b=gO6JRbpTszw4/Pn8xiE3I0GoG6drnRwGATOcM3AAViRp8Kkz9BhPW079DsBuuqtuWSFHydcwpnpIv/J2vs73YqGIsFOidehurVmBAfHp+T3hrW+5UW89xhK+qhlw8bqnyQ8Isk34goRuHTSX7H/PhB2GUM1PRWz4EmbIegjoe6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736219957; c=relaxed/simple;
	bh=/6oWaL4VinYN9kupmJYKP8VBA+nGvGQy6rJfUb5M+C4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVXSQQjHgYuL/b0Up2chRC/zsW7iJhK7rAWVonJJrpKxFgDu/6aa1oza7WsCY/AcmNusDtGtZueaHjPFSy1XS0uAJXpQWIiprlgsOusIqwlsR+FgoVPe4qGbneUxIBSX3vTjnvlFAtSo1qYRqjijrVGwlvet/5Z6HA8IkAhLmIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnKbN6Xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3816C4CEDF;
	Tue,  7 Jan 2025 03:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736219957;
	bh=/6oWaL4VinYN9kupmJYKP8VBA+nGvGQy6rJfUb5M+C4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GnKbN6XkFcz1//HbmjItKzV1sqgpkntXSmlmu1RH/YPbrUr/+FQWpkA0ThnqyR12Q
	 fJAGqdw6bas8Ivafqxtk89RPsKnyOdtLBwhNFQRpxkBHdeArYx9YxcjSqLOkVLF6RO
	 eK3hr9ee/weZXgMfgz8jV7dJVmfZF4wOfMkChYMhAdUfQ3Kal4+BGEZjcbTfTUSbdp
	 JngVukb6LlwK89QSA8tlwIoMvHt9XX5lc3/jH3w6VQANK5SpTEiWHoJtlN9m226hsn
	 AS0OYl1+7iCKP0/aRcCj4eavXzxtWp74vqQaBNIQNVNtHZ8Eg7nwW631af4IrhCS9M
	 mQApcmmu4tflg==
Date: Mon, 6 Jan 2025 19:19:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Neal Cardwell <ncardwell@google.com>
Cc: Teodor Milkov <zimage@icdsoft.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com
Subject: Re: Download throttling with kernel 6.6 (in KVM guests)
Message-ID: <20250106191916.6e26b3fd@kernel.org>
In-Reply-To: <CADVnQynBPVr0qX2pu7FNwk6Y1BaW-pGf=JReJPCAj9RP=6t9_w@mail.gmail.com>
References: <e831515a-3756-40f6-a254-0f075e19996f@icdsoft.com>
	<d1f083ee-9ad2-422c-9278-c50a9fbd8be4@icdsoft.com>
	<20250106132051.262177da@kernel.org>
	<CADVnQynBPVr0qX2pu7FNwk6Y1BaW-pGf=JReJPCAj9RP=6t9_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jan 2025 21:50:02 -0500 Neal Cardwell wrote:
> On Mon, Jan 6, 2025 at 4:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > On Mon, 6 Jan 2025 22:15:37 +0200 Teodor Milkov wrote: =20
> > > Hello,
> > >
> > > Following up on my previous email, I=E2=80=99ve found the issue occurs
> > > specifically with the |virtio-net| driver in KVM guests. Switching to
> > > the |e1000| driver resolves the slowdown entirely, with no throttling=
 in
> > > subsequent downloads.
> > >
> > > The reproducer and observations remain the same, but this detail might
> > > help narrow down the issue. =20
> >
> > Let's CC the virtio maintainers, then.
> >
> > The fact that a 300ms sleep between connections makes the problem
> > go away is a bit odd from the networking perspective.
> >
> > You may need to find a way to automate the test and try to bisect
> > it down :( This may help: https://github.com/arighi/virtme-ng =20
>=20
> IIUC, from Teodor's earlier message in the thread it sounds like he
> was able to bisect the issue; he mentioned that git bisect traced the
> regression to the commit:
>=20
>     dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")

My bad. I think I looked at it last week and couldn't figure out=20
why the sleep make any difference.

