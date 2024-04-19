Return-Path: <netdev+bounces-89629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6702D8AAFA6
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 15:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210A9280C5E
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 13:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9DB12A14F;
	Fri, 19 Apr 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTAHTMSQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651212A14E
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534354; cv=none; b=X5tt1PyrDrKIEp9R2AzOdUMVkvOr4YkFIZEWh5lNxVv60LdHpOuGRcup5e7yb6Y9VVvDG6TOuvIDAHMI1tGkalFuRHg9t+NjpSwjl0hHREoYGwiYxfRwv5OAVLOd/0zKuTUhjNxcPtxpOry47FgHsDuzI0tFXls3U/jjq9/syss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534354; c=relaxed/simple;
	bh=Fwqnpsiut82QQeiKByYlo08+TfJrDsgzOvHy5Sc5bWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAbt5e5jZyTWkf1tdRUbwcBKyRjNQJOrTZAcp21hkkiFxi+tHBCJH+9epMtjKEHVOvC7nifYAfDutXT8i0ooxZBQWylaMvbBYGD6Uf3Ye+TGTXpUCipAq+YB+0gfHPn6KQyfWIqZPvkD2z+UA2hz7uBDnR9Z+Z9t0bCmumdanSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTAHTMSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D733AC072AA;
	Fri, 19 Apr 2024 13:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713534354;
	bh=Fwqnpsiut82QQeiKByYlo08+TfJrDsgzOvHy5Sc5bWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fTAHTMSQkQUSA9hIbihjwcZji6EWRyPjpSIpIfMbVySpTE18KWENhKf0FPlZZT1z3
	 hiIHrtTDkunDub8/2+yNg0xb12l+Ox2okQbbC351v34wjZTanj6jinroV84feFFcq1
	 8EKVzWlQOOGn5lb9wK1xPdmeNHiMaKdDIADHxS2tpna06g3M9ZhYUjNDssvBrFJJQf
	 +mzfMA5+1B9IKASbe7zPP9fj9WZIhVEk7mBvQJ+Ar4IEWB9jLI4vuDVZ06A1zUBvPq
	 3ypmrpZvOPq+kIfCexWqBRYtKFuEaxPXGu1IziKPQ9LrSZchwWYDGEElsaGoFbcWiX
	 eNE5LPLDAZ29g==
Date: Fri, 19 Apr 2024 06:45:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, David Ahern
 <dsahern@kernel.org>, eric.dumazet@gmail.com, Andreas Roeseler
 <andreas.a.roeseler@gmail.com>
Subject: Re: [PATCH net] icmp: prevent possible NULL dereferences from
 icmp_build_probe()
Message-ID: <20240419064552.5dbe33e6@kernel.org>
In-Reply-To: <20240419105332.2430179-1-edumazet@google.com>
References: <20240419105332.2430179-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Apr 2024 10:53:32 +0000 Eric Dumazet wrote:
> +	in6_dev =3D __in6_dev_get(dev);
> +	if (in6_dev && !list_empty(&in6_dev->addr_list))

There's got to be some conditional include somewhere because this seems
to break cut-down builds (presumably IPv6=3Dn):


net/ipv4/icmp.c: In function =E2=80=98icmp_build_probe=E2=80=99:
net/ipv4/icmp.c:1125:19: error: implicit declaration of function =E2=80=98_=
_in6_dev_get=E2=80=99; did you mean =E2=80=98in_dev_get=E2=80=99? [-Werror=
=3Dimplicit-function-declaration]
 1125 |         in6_dev =3D __in6_dev_get(dev);
      |                   ^~~~~~~~~~~~~
      |                   in_dev_get
net/ipv4/icmp.c:1125:17: error: assignment to =E2=80=98struct inet6_dev *=
=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a c=
ast [-Werror=3Dint-conversion]
 1125 |         in6_dev =3D __in6_dev_get(dev);
      |                 ^
--=20
pw-bot: cr

