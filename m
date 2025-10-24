Return-Path: <netdev+bounces-232593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ACAC06DDC
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1870A3AC907
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2883043CB;
	Fri, 24 Oct 2025 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8OAYW54"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71675273D84
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318297; cv=none; b=VGtsi3urS2w2VhQJlQDBW0QFJFaK6bf5fbH7xPTH/gF2fajXLBUeKXnG4oiYVL7uxq8y7nd7MhYhbCKO11rK7Z+BALEviJl3Cdj9KTGzVH/9o/r9PhR73FsNBnWNFhFkFPWXBlV+WHvA6a5qOaSkGFUAmMuox6lZz7G8Rp7RbAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318297; c=relaxed/simple;
	bh=XyviE7xJnLRrCRFKgSQYo6W7xKjYqb4oSXQ+VZ0i+9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/g2+Ar2EIdLEbrFnyHIIpJilGU9xA9ikEp5LRPSnMAz0wX5qoQY5eiHorFO3xhLKkCKA4op8KwuJCS1o0G4GOSDkMJJ21pxXaziU7I5m0N1DWnd6N/CS8KQ4slGujkfVAZlYazv7rPD1xVUSzjU0mycbAR7v4rhrJzUzoZmBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8OAYW54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B0EC4CEF1;
	Fri, 24 Oct 2025 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761318297;
	bh=XyviE7xJnLRrCRFKgSQYo6W7xKjYqb4oSXQ+VZ0i+9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m8OAYW54trxflw3ibUBkzITXTtJncxdE42yT6QQVxVSxd0yF2aMsIblQzejvIy3iw
	 IrODpUH5FQAr51/yWnjD3OaH4qwg9wurJl/cI7iKDj9VVqOcWbH82kkyHiEbo4ph5z
	 Amybv3hv/Pqo5f9NG3ShkJvVGbW1kWuMyH9rNX5LzXW8s0PbXLkEQKPB3sj9v3Iv3v
	 /hed+FxNqkq9FpIILN7ZaGYioW4wmeXEp45L25Qkp/fwbJ5eeHSRlodNYyPgaPg7HM
	 2Pb66DqI3RRjyE7dfznhPdi2T4rHjuiyPyea8iLfY+3dPqgMw41uwyDiT5S6kaChaS
	 pLaJ1dtRFjuqg==
Date: Fri, 24 Oct 2025 08:04:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, dsahern@kernel.org,
 petrm@nvidia.com, willemb@google.com, daniel@iogearbox.net, fw@strlen.de,
 ishaangandhi@gmail.com, rbonica@juniper.net, tom@herbertland.com
Subject: Re: [PATCH net-next 0/3] icmp: Add RFC 5837 support
Message-ID: <20251024080455.7a0220d2@kernel.org>
In-Reply-To: <aPuSUBv7speAmnRf@shredder>
References: <20251022065349.434123-1-idosch@nvidia.com>
	<20251022062635.007f508b@kernel.org>
	<aPjjFeSFT0hlItHf@shredder>
	<20251022081004.72b6d3cc@kernel.org>
	<aPj5u_jSFPc5xOfg@shredder>
	<20251022173843.3df955a4@kernel.org>
	<20251023184857.1c8c94f1@kernel.org>
	<aPuSUBv7speAmnRf@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Oct 2025 17:50:56 +0300 Ido Schimmel wrote:
> On Thu, Oct 23, 2025 at 06:48:57PM -0700, Jakub Kicinski wrote:
> > Current one has traceroute updated but not traceroute6
> > https://netdev-3.bots.linux.dev/vmksft-net/results/354402/27-traceroute=
-sh/stdout
> >=20
> > This doesn't sound related to the traceroute version tho:
> >=20
> > # 34.51 [+6.48] TEST: IPv4 traceroute with ICMP extensions             =
             [FAIL]
> > # 34.51 [+0.00] Unsupported sysctl value was not rejected =20
>=20
> Hmm, which sysctl version do you have?
>=20
> I have:
>=20
> $ sysctl --version
> sysctl from procps-ng 4.0.4
>=20
> I just compiled 3.3.17 and I get:

$ sysctl --version
sysctl from procps-ng 3.3.17

Amazon Linux =F0=9F=A4=B7=EF=B8=8F

> # /home/idosch/tmp/procps-v3.3.17/sysctl -wq net.ipv4.icmp_errors_extensi=
on_mask=3D0x80
> sysctl: setting key "net.ipv4.icmp_errors_extension_mask": Invalid argume=
nt
> # echo $?
> 0
>=20
> Which can explain the failure.
>=20
> Please let me know if that's the issue and if you want me to replace
> this with:
>=20
> echo 0x80 > /proc/sys/net/ipv4/icmp_errors_extension_mask

Let's go with the echo, if you don't mind.

