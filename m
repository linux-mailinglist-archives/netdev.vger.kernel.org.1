Return-Path: <netdev+bounces-188518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07369AAD2C7
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D305076CE
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 01:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7AA145B16;
	Wed,  7 May 2025 01:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aML28z2l"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8E313B280
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581074; cv=none; b=LvdvNId97TM+i4190yoCNc2H11zrdyxzOFeWt1OyOwYslD2Ep9v4sAYLgqIeBeBuqC8QSoYrlbF9OqfahnhjIhbhpCcMP/Aq7C3l5fGLOmtQymUyvLD9HP1hcYQq5If3pXlHW6ZIL5GHeuZiyAru1kDYPcV99Xwcd+Npuih8wY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581074; c=relaxed/simple;
	bh=xV2IIQBNovFSFUm1kmG/rEr/KiOoJL8cmCmD5yNa8IU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YXQ78vd776tOynXpdTznWMZEHROVy/lWOmLq8PXZIFRCuelS+Xhgpww+sOE7ngd7Hvk0yU3cpLkYp+wwyAytl/CmoWwHTiixVFsAV41N8/QIqevPfMVSSdQ6ROku9243Yx/b0auZY+jc8m7etxaoeyKRO+s/G8HDPy/nlu96lz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aML28z2l; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1746581070;
	bh=fSCOIBjEZ/DoR2mruy6mVzNzXxWOGILrWEgfSm9ifWc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aML28z2lu0AH1Akc8Kamgmm0/C/BmsAa7jQq1MsqVvUQPvUkbwsW06P4OBRue8xNf
	 aya8G+nDUQG68REE1yr6rrOqXgait6O7KE+p1Y90P5yhirMtM8AVKORIQPg4xU3TlG
	 pchcqiR1qcbIy3m5XfmM9W1FmjN1udeQrGRSFd0J2LAfEJ5jZe2454ROIpV4L7mIEL
	 quSKJFiFc+kztw/R9WkyToSLjdMxvsiP6mFPDa13je6xMeaLL5qAQABGWZqVRZbdqm
	 HzQ1Q/yS7jauRmn/jactMuRGyMCjrp1QNXHX9+EQOl1/coksP9DEqfkNDEXqjjNa/z
	 VVHqLBsVgG/BA==
Received: from [192.168.14.220] (unknown [159.196.94.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 25C516C00A;
	Wed,  7 May 2025 09:24:29 +0800 (AWST)
Message-ID: <84b6bdceff61d495661dcf3500fd4bf19cf4e7be.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] net: mctp: Don't access ifa_index when missing
From: Matt Johnston <matt@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, 
 syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com, 
 syzbot+1065a199625a388fce60@syzkaller.appspotmail.com
Date: Wed, 07 May 2025 09:24:29 +0800
In-Reply-To: <20250506180630.148c6ada@kernel.org>
References: <20250505-mctp-addr-dump-v1-1-a997013f99b8@codeconstruct.com.au>
	 <20250506180630.148c6ada@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-06 at 18:06 -0700, Jakub Kicinski wrote:
> On Mon, 05 May 2025 17:05:12 +0800 Matt Johnston wrote:
> > +		/* Userspace programs providing AF_MCTP must be expecting ifa_index =
filter
> > +		 * behaviour, as will those setting strict_check.
> > +		 */
> > +		if (hdr->ifa_family =3D=3D AF_MCTP || cb->strict_check)
> > +			ifindex =3D hdr->ifa_index;
>=20
> The use of cb->strict_check is a bit strange here. I could be wrong but
> I though cb->strict_check should only impact validation. Not be used
> for changing behavior.

It was following behaviour of inet_dump_addr()/inet6_dump_addr() where
filtering is applied if strict check is set.
I don't have strong opinion whether strict_check makes sense for MCTP thoug=
h
- it depends on
whether userspace expects strict_check to apply to all families, or just
inet4/inet6.

> If you have a reason to believe all user space passes a valid header -
> how about we just return an error if message is too short?
> IPv4 and IPv6 seem to return an error if message is short and
> cb->strict_check, so they are more strict. MCTP doesn't have a ton of
> legacy user space, we don't have to be lenient at all. My intuition
> would be to always act like IP acts under cb->strict_check

The problem is that programs will pass ifa_family=3DAF_UNSPEC with a short
header, no strict_check=C2=A0
(eg busybox "ip addr show").
An AF_UNSPEC request will reach mctp_dump_addrinfo(), so we don't want that
returning an error.
Maybe mctp_dump_addrinfo() should ignore AF_UNSPEC requests entirely, and
only populate
a response when ifa_family=3DAF_MCTP. That would be OK for the existing mct=
p
userspace programs=C2=A0
I know about, though there may be other users that are calling with AF_UNSP=
EC
but filtering=C2=A0
userspace-side for AF_MCTP addresses.

Matt


