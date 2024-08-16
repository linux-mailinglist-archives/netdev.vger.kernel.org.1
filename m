Return-Path: <netdev+bounces-119333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E42495533B
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 00:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90ECD1C2118B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 22:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB541448E0;
	Fri, 16 Aug 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="wc0Yts33"
X-Original-To: netdev@vger.kernel.org
Received: from ma-mailsvcp-mx-lapp03.apple.com (ma-mailsvcp-mx-lapp03.apple.com [17.32.222.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAFB78297
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.32.222.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723846820; cv=none; b=TQndTYBFXs2X5NliSbYKkX/ftg7CRJ2WIZNayJ+8D7yDQgWjk+OpLOSLOLEgAO/Ted8K2B0Um2Ka671PhDGyzE5pdJdJLJz0vm+MgmX4qfVmDIvkpJ31K8g8TRDsa+4S41ByZygqXosg2+rTihkwAY7p93IPNBUXzM7+8EYNBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723846820; c=relaxed/simple;
	bh=fIAIJzIE+w5YR76d5JK1JyT+qF2yTq9b9aXobNsIlcU=;
	h=Content-type:MIME-version:Subject:From:In-reply-to:Date:Cc:
	 Message-id:References:To; b=sxqhx5sFILbWlZcSUBDszdV29oVKx+eHQLngYzo5tagy7pnFp1FPPYW+gsqTMiw2+GdpPWyhdxHjgNal/xEJc0WM2RB7/XmJBGrt/ui0QsVKNb8WHRP0ez4SfOWLVFe9ui3v99gIwlMxDBndEzOvTt136x916CZ7V8NHRTTcweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=wc0Yts33; arc=none smtp.client-ip=17.32.222.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by ma-mailsvcp-mx-lapp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SIC00KYR0PIF200@ma-mailsvcp-mx-lapp03.apple.com> for
 netdev@vger.kernel.org; Fri, 16 Aug 2024 15:20:11 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_16,2024-08-16_01,2024-05-17_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=20180706;
 bh=fIAIJzIE+w5YR76d5JK1JyT+qF2yTq9b9aXobNsIlcU=;
 b=wc0Yts331mFK32sChoX0r2apkB9qnOSK2lJUIZPMGsCqTWWhuiiPPGptbeHCAWD/Z9hw
 NVexdM4+qjJuN1fX2x96cnLpU/JBuVeCqgufqeStVQ+T9SgIonPfm5ml+5XunkOJxw/R
 0ALYoxqZL5twrVbXMOp5tzjjlhLzsEJmChi3KFUhXuksEQIOGuQhFcdwMPlxaDn79ph3
 aoM6eTzHkXVjJ8s62bwb8pwWrdCNZh8/LP2EEBDLDxnP+Jfx6Cs9M/GXEQAdA9OOIXPH
 QswhIw0yqagtNAk4ILAs/yueJUlMGU1JaOeHWo2mS8p1TSXyQvtzVLbsNwJuCCNg1xck yw==
Received: from mr55p01nt-mmpp08.apple.com
 (mr55p01nt-mmpp08.apple.com [10.170.185.194])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SIC00YTR0PKNP30@rn-mailsvcp-mta-lapp02.rno.apple.com>;
 Fri, 16 Aug 2024 15:20:09 -0700 (PDT)
Received: from process_milters-daemon.mr55p01nt-mmpp08.apple.com by
 mr55p01nt-mmpp08.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SIC2CD000KMVW00@mr55p01nt-mmpp08.apple.com>; Fri,
 16 Aug 2024 22:20:08 +0000 (GMT)
X-Va-A:
X-Va-T-CD: da671353dce2cf57e116168d65bb9d70
X-Va-E-CD: ff03f9a5f60d1f628a918e6aa7c5e5be
X-Va-R-CD: 74ece9fb46034c053602db6adc649075
X-Va-ID: 8595ff7a-d18a-4771-940c-1853a3de05fe
X-Va-CD: 0
X-V-A:
X-V-T-CD: da671353dce2cf57e116168d65bb9d70
X-V-E-CD: ff03f9a5f60d1f628a918e6aa7c5e5be
X-V-R-CD: 74ece9fb46034c053602db6adc649075
X-V-ID: 5774c69a-ab45-4336-922f-4925b265c5fd
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_16,2024-08-16_01,2024-05-17_01
Received: from smtpclient.apple ([17.192.155.209])
 by mr55p01nt-mmpp08.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SIC2BH9O0PJTN00@mr55p01nt-mmpp08.apple.com>; Fri,
 16 Aug 2024 22:20:07 +0000 (GMT)
Content-type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3826.200.5\))
Subject: Re: [PATCH netnext] mpls: Reduce skb re-allocations due to skb_cow()
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to: <20240816111843.GU632411@kernel.org>
Date: Fri, 16 Aug 2024 15:20:03 -0700
Cc: netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Roopa Prabhu <roopa@nvidia.com>,
 Craig Taylor <cmtaylor@apple.com>
Content-transfer-encoding: quoted-printable
Message-id: <967C2745-1EDB-464E-9C80-46345CA91650@apple.com>
References: <20240815161201.22021-1-cpaasch@apple.com>
 <20240816111843.GU632411@kernel.org>
To: Simon Horman <horms@kernel.org>
X-Mailer: Apple Mail (2.3826.200.5)

Hello!

> On Aug 16, 2024, at 4:18=E2=80=AFAM, Simon Horman <horms@kernel.org> =
wrote:
>=20
> On Thu, Aug 15, 2024 at 09:12:01AM -0700, Christoph Paasch wrote:
>> mpls_xmit() needs to prepend the MPLS-labels to the packet. That =
implies
>> one needs to make sure there is enough space for it in the headers.
>>=20
>> Calling skb_cow() implies however that one wants to change even the
>> playload part of the packet (which is not true for MPLS). Thus, call
>> skb_cow_head() instead, which is what other tunnelling protocols do.
>>=20
>> Running a server with this comm it entirely removed the calls to
>> pskb_expand_head() from the callstack in mpls_xmit() thus having
>> significant CPU-reduction, especially at peak times.
>=20
> Hi Christoph and Craig,
>=20
> Including some performance data here would be nice.

Getting exact production performance data is going to be a major =
challenge. Not a technical challenge, but rather logistically, ...

>> Cc: Roopa Prabhu <roopa@nvidia.com>
>> Reported-by: Craig Taylor <cmtaylor@apple.com>
>> Signed-off-by: Christoph Paasch <cpaasch@apple.com>
>=20
>=20
> And one minor nit, which I do not think warrants a repost:
> netnext -> net-next.

Ugh - I was wondering why did patchwork thought it was a fix=E2=80=A6 =
that explains it.

If a respin is needed, please let me know.

> In any case, this looks good to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>


Thanks,
Christoph


