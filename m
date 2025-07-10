Return-Path: <netdev+bounces-205912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB80B00C3D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70039560F2D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D23A2FCE39;
	Thu, 10 Jul 2025 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWljTSgU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394421DFE1
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176639; cv=none; b=Y70N8+h4YiQ6y5pzW8U47kPWX2z85oEzeo5clRCl0HPhjVcf0McKiGKH9AktUkIODVGj2QLR1o66Z93idHaFKTuwX8nOZkRG8hfJYRQ70dI5TK2uowAAfpgluVnuIsCjN+N5Z6kfVBMBL5GIJiAEUnyjHzJfsfxrWESekTaPsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176639; c=relaxed/simple;
	bh=gERDeqnEsnCJlqcybmaR+dNTjl5vgutz5DFfgzbRzEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2/c6H17WlXsCq0nlT76L31MDG8qPhByAmef5zCtGOAh9O7VnpcWLeYSCjWjkia1hGEVJWQPPu4yNZ3mu9CxjIze6g/sWrRvQjOBXnCY+uVDaaClnQV6b8usjU53zeu8sw9dQ8disCpv/QIMDSi5LoGcKUy6x/kDEplzOFi2Hlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWljTSgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE72C4CEE3;
	Thu, 10 Jul 2025 19:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752176639;
	bh=gERDeqnEsnCJlqcybmaR+dNTjl5vgutz5DFfgzbRzEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CWljTSgUF0N1EtrxM/DSFUHE3tkaxxHItJGwZ7FIJG9i3tG5NmfZUt/eQhs0KU51e
	 oEpNYJHQ6/sdnFtYdqPAxV6n7jxwGCuaYT7w7e9uGwelBfE19NB+W/5nMxrEzGb6/c
	 njuFRAYcQFdDmRZNgFSKCAdAV6y8W/sWoDqa1ey+jTuUAhgkgpWatEEjABafvCkQTd
	 cQJMUJoy0FtVP/0wGUcyOAaEu5C9Lcncx4ZPAKW4tUTOJiuzJQj9LwqO1kHEKpLE95
	 AitWtBPupmSgAR0JKSuPKFni5PiQQAYg9ki9Zf04e1VHwPhdg5vXHy8cMex0ZS9UR7
	 hYZAP99k3AMkQ==
Date: Thu, 10 Jul 2025 12:43:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org, Jason Baron
 <jbaron@akamai.com>
Subject: Re: [PATCH v1 net] netlink: Fix wraparounds of sk->sk_rmem_alloc.
Message-ID: <20250710124357.25ab8da1@kernel.org>
In-Reply-To: <9794af18-4905-46c6-b12c-365ea2f05858@samsung.com>
References: <20250704054824.1580222-1-kuniyu@google.com>
	<CGME20250710083401eucas1p1d18e23791e1f22c0c0aaf823a35526a2@eucas1p1.samsung.com>
	<9794af18-4905-46c6-b12c-365ea2f05858@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jul 2025 10:34:00 +0200 Marek Szyprowski wrote:
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: Jason Baron <jbaron@akamai.com>
> > Closes: https://lore.kernel.org/netdev/cover.1750285100.git.jbaron@akam=
ai.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com> =20
>=20
> This patch landed recently in linux-next as commit ae8f160e7eb2=20
> ("netlink: Fix wraparounds of sk->sk_rmem_alloc."). In my tests I found=20
> that it breaks wifi drivers operation on my tests boards (various ARM=20
> 32bit and 64bit ones). Reverting it on top of next-20250709 fixes this=20
> issue. Here is the log from the failure observed on the Samsung=20
> Peach-Pit Chromebook:
>=20
> # dmesg | grep wifi
> [ =C2=A0=C2=A016.174311] mwifiex_sdio mmc2:0001:1: WLAN is not the winner=
! Skip FW=20
> dnld
> [ =C2=A0=C2=A016.503969] mwifiex_sdio mmc2:0001:1: WLAN FW is active
> [ =C2=A0=C2=A016.574635] mwifiex_sdio mmc2:0001:1: host_mlme: disable, ke=
y_api: 2
> [ =C2=A0=C2=A016.586152] mwifiex_sdio mmc2:0001:1: CMD_RESP: cmd 0x242 er=
ror,=20
> result=3D0x2
> [ =C2=A0=C2=A016.641184] mwifiex_sdio mmc2:0001:1: info: MWIFIEX VERSION:=
 mwifiex=20
> 1.0 (15.68.7.p87)
> [ =C2=A0=C2=A016.649474] mwifiex_sdio mmc2:0001:1: driver_version =3D mwi=
fiex 1.0=20
> (15.68.7.p87)
> [ =C2=A0=C2=A025.953285] mwifiex_sdio mmc2:0001:1 wlan0: renamed from mla=
n0
> # ifconfig wlan0 up
> # iw wlan0 scan
> command failed: No buffer space available (-105)
> #
>=20
> Let me know if You need more information to debug this issue.

Thanks a lot for the report! I don't see any obvious bugs.
Would you be able to test this?

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 79fbaf7333ce..aeb05d99e016 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2258,11 +2258,11 @@ static int netlink_dump(struct sock *sk, bool lock_=
taken)
 	struct netlink_ext_ack extack =3D {};
 	struct netlink_callback *cb;
 	struct sk_buff *skb =3D NULL;
+	unsigned int rmem, rcvbuf;
 	size_t max_recvmsg_len;
 	struct module *module;
 	int err =3D -ENOBUFS;
 	int alloc_min_size;
-	unsigned int rmem;
 	int alloc_size;
=20
 	if (!lock_taken)
@@ -2294,8 +2294,9 @@ static int netlink_dump(struct sock *sk, bool lock_ta=
ken)
 	if (!skb)
 		goto errout_skb;
=20
+	rcvbuf =3D READ_ONCE(sk->sk_rcvbuf);
 	rmem =3D atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
-	if (rmem >=3D READ_ONCE(sk->sk_rcvbuf)) {
+	if (rmem !=3D skb->truesize && rmem >=3D rcvbuf) {
 		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 		goto errout_skb;
 	}

