Return-Path: <netdev+bounces-106971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F99F9184E6
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508DF1C22B81
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE88C185E7F;
	Wed, 26 Jun 2024 14:52:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6C5185E5F
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413568; cv=none; b=UI4iV2T8V4g7xvrlgDXSLvDHuDCxvzI4BDCS+2+GvKKZic9kNvLxH9vnWNmIp54G7v/hlsKQriaKSP3oWRdcvJGovp+lfv/Y4y162lB1zY+8lBd3RyM9akqpq1/GNRBnbUIKi0Eqh4seAy183gUDkPFX2HJWW8XX6h5FGgx3qyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413568; c=relaxed/simple;
	bh=pNLo9dXnp4p74SX2p9JJSQE44/XATiWG8qjJTFunBCo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=HA1QL0Q0O/ChWEV84EwlHA7AX2yxogL9ZMXXQnApwdxqbiXOyLzkwiUWagZnaEjiJkF1jFQ6/8umJ2Dqk3g+sdBF1amkXDvdyiNlbuXNDY/GIkIsi+ZwtAbTYhPVXZ8sVgdkRzvqM0CKOB89y854VejsK8+uvfd+RZgx2zBHy5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 2A0557D052;
	Wed, 26 Jun 2024 14:52:44 +0000 (UTC)
References: <20240617205316.939774-1-chopps@chopps.org>
 <20240617205316.939774-9-chopps@chopps.org>
 <2fa05695-faf9-45ce-95de-f49a6749b828@quicinc.com>
User-agent: mu4e 1.8.14; emacs 28.3
From: Christian Hopps <chopps@chopps.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v4 08/18] xfrm: iptfs: add new iptfs xfrm
 mode impl
Date: Wed, 26 Jun 2024 10:52:33 -0400
In-reply-to: <2fa05695-faf9-45ce-95de-f49a6749b828@quicinc.com>
Message-ID: <m2frszah8k.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 6/17/24 13:53, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
>> This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
>> functionality. This functionality can be used to increase bandwidth
>> utilization through small packet aggregation, as well as help solve PMTU
>> issues through it's efficient use of fragmentation.
>>    Link: https://www.rfc-editor.org/rfc/rfc9347.txt
>> Multiple commits follow to build the functionality into xfrm_iptfs.c
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>   net/xfrm/Makefile     |   1 +
>>   net/xfrm/xfrm_iptfs.c | 225 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 226 insertions(+)
>>   create mode 100644 net/xfrm/xfrm_iptfs.c
>> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
>> index 547cec77ba03..cd6520d4d777 100644
>> --- a/net/xfrm/Makefile
>> +++ b/net/xfrm/Makefile
>> @@ -20,5 +20,6 @@ obj-$(CONFIG_XFRM_USER) += xfrm_user.o
>>   obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
>>   obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
>>   obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
>> +obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
>>   obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
>>   obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
>> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
>> new file mode 100644
>> index 000000000000..e7b5546e1f6a
>> --- /dev/null
>> +++ b/net/xfrm/xfrm_iptfs.c
>> @@ -0,0 +1,225 @@
>> +// SPDX-License-Identifier: GPL-2.0
> ...
>
>> +module_init(xfrm_iptfs_init);
>> +module_exit(xfrm_iptfs_fini);
>> +MODULE_LICENSE("GPL");
>
> missing MODULE_DESCRIPTION() which will cause a warning with make W=1

Added.

Thanks,
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmZ8KzsSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAl+PwQAIs19u/CKDPGujHKfT8pW/dJ8wiObNF2
X3ifXVlVszXC9RMES2HTVz3aEH6yP0CcFav/Cqxu6L1+yfasAZMz30j1sh95bG5W
Lp4HZYDEpF128Y2XmxNvw97lCUhIsOQ5tq67g9xXMUfqthsCa9LkySYDWjLK0cmk
bbqRnhncnOujT3Q8i03/BKYWaGZm3kIaS/TsECeRevrIKTvulT9FMVY/TOrHuyTH
uYSCJbUH2QZkWvrIYzCkPSd7oKqz5BJl1y/rWw4JIHgGtZk8rx97Mpj/SGofiUYW
B2nqHop0pMoek4eoiSvBSbv/PTuSejtrEyWvj590dvtEGNIH2G6DGHc91f/uRa+p
g921Mh7lOUmhuP4JcR3vr4i9dzMebOdgEHjO1QW1Ylk+WpNLZ6vF7YVjVH4XxL2d
hQTnCSn3NTr4CQ/1IQ7ymjxOck3Wh2zD6p5fXozdSbJDzecCTP5rYzu976vN+Mza
fOYe9GPZt6Ud2v+IQYlD0iM90Zvujd09WYZCXweIBMDF7xF0HXsFxncTgsDoOf3n
p5Eqf7EVcCUoIjjB3H7I+7jzuRmE6JlayJTDKOFabOBYVhO3zqdJsR+3pySn+iCk
V8kAF/DQ6YP6M9UhQvdAM6ZUgvMwes3A2Ieh1KBG1FWk02xGIpw8zIY6EfDsGmyv
UICw7Ooay2fR
=t/Nq
-----END PGP SIGNATURE-----
--=-=-=--

