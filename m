Return-Path: <netdev+bounces-229619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C29BDEF3F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA4804E591E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59FA2472B1;
	Wed, 15 Oct 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mX8ha89G"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81EC21D59B
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537811; cv=none; b=Iyi3+arLlwpnaAUlJKhBxhuailZO4X+Xt525TiUnxsfArq0xmX5GcProjluzh0mxwLdYyj9thPp3AtXpLEx+io75BLdix3Pim9CXGUGTJ5v1QRjOraBQWTA+3Kw6zurjsYMAaGDJw5HXIMdJ7Ud8zSZC9xfhC1QaOvP1LND1UsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537811; c=relaxed/simple;
	bh=jpYq+9Nr1ka9/2Sgn8m46/cBwMNhFx9w/QCAUCdpSTI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=lBXHRkNeK5MfpR6G0EVZ2seTXUtkKFXOJqvqh8wrNwftD65DDnwb/E2A+FFuE+PtfdA/g7wPDFtVQ6d2hoJI4uzN8u9Wkh54DcE0y2c+dHdpu1Fas4CyYtYFNAIjOVMigrhzotNhXmrDATZQNJsoQSkKTibRqlBhV8Fm/LAuKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mX8ha89G; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760537796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xaEPvMIw6bpDl3CHmKICGmDhSf+skcRB01e1cDDcMMs=;
	b=mX8ha89G8xxBV/5yVwurH4TbLNY6wq+vYQtLvMGWFX9Klr5PxeFHiQAN8r+KhjquvgBlFj
	jZen6fmgJlwOXHwiqz+dI96Nczn3G1igxsGOjYFR6TPKr+7jvKngGWWc9LmiumOtwjMMla
	Jx5O1eMqhHv3r8Ng1AjK1T1ykYdUDM4=
Date: Wed, 15 Oct 2025 14:16:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <a0a2b87119a06c5ffaa51427a0964a05534fe6f1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v1] mptcp: fix incorrect IPv4/IPv6 check
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "Mat Martineau" <martineau@kernel.org>, "Geliang Tang"
 <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Davide Caratti" <dcaratti@redhat.com>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <f046fdda-3bad-4f7f-8587-dca30d183f82@kernel.org>
References: <20251014122619.316463-1-jiayuan.chen@linux.dev>
 <f046fdda-3bad-4f7f-8587-dca30d183f82@kernel.org>
X-Migadu-Flow: FLOW_OUT

October 14, 2025 at 23:27, "Matthieu Baerts" <matttbe@kernel.org mailto:m=
atttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%=
3E > wrote:


>=20
>=20Hi Jiayuan,
>=20
>=20Thank you for sharing this patch!
>=20
>=20On 14/10/2025 14:26, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> When MPTCP falls back to normal TCP, it needs to reset proto_ops. H=
owever,
> >  for sockmap and TLS, they have their own custom proto_ops, so simply
> >  checking sk->sk_prot is insufficient.
> >=20=20
>=20>  For example, an IPv6 request might incorrectly follow the IPv4 cod=
e path,
> >  leading to kernel panic.
> >=20
>=20Did you experiment issues, or is it a supposition? If yes, do you hav=
e
> traces containing such panics (or just a WARN()?), and ideally the
> userspace code that was leading to this?
>=20


Thank=20you, Matthieu, for your suggestions. I spent some time revisiting=
 the MPTCP logic.


Now I need to describe how sockmap/skmsg works to explain its conflict wi=
th MPTCP:

1. skmsg works by replacing sk_data_ready, recvmsg, sendmsg operations an=
d implementing
fast socket-level forwarding logic

2. Users can obtain file descriptors through userspace socket()/accept() =
interfaces, then
   call BPF syscall to perform these replacements.
3. Users can also use the bpf_sock_hash_update helper (in sockops program=
s) to replace
   handlers when TCP connections enter ESTABLISHED state (BPF_SOCK_OPS_PA=
SSIVE_ESTABLISHED_CB or BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB)

For MPTCP to work with sockmap, I believe we need to address the followin=
g points
(please correct me if I have any conceptual misunderstandings about MPTCP=
):

1. From client perspective: When a user connects to a server via socket()=
, the kernel
   creates one master sk and at least two subflow sk's. Since the master =
sk doesn't participate
   in the three-way handshake, in the sockops flow we can only access the=
 subflow sk's.
   In this case, we need to replace the handlers of mptcp_subflow_ctx(sk)=
->conn rather
   than the subflow sk itself.

2. From server perspective: In BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, the s=
k is the MP_CAPABLE
   subflow sk, so similar to the client perspective, we need to replace t=
he handlers of
   mptcp_subflow_ctx(sk)->conn.

If the above description is correct, then my current patch is incorrect. =
I should focus on
handling the sockmap handler replacement flow properly instead.

Of course, this would require comprehensive selftests to validate.

Returning to the initial issue, the panic occurred on kernel 6.1, but whe=
n I tested with the
latest upstream test environment, it only triggered a WARN().
I suspect there have been significant changes in MPTCP during this period=
.

