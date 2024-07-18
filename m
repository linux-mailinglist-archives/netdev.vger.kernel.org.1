Return-Path: <netdev+bounces-112097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF84934F07
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 16:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2062834EE
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5CB13DDCE;
	Thu, 18 Jul 2024 14:21:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635BBDDB8
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721312515; cv=none; b=oLBujbzAAI/o3f5ky4Zyvtyc1cgo/+vUipEMZ9qAP8MWzl2c0ZaNdsWJJwyDlMm2UrB76hOdcF7mpj8/vWr6SLU01WdoWLvrkRWv+8B3+qywF2r4Yiyj9imxk6B6bj+lpLD1h3Nup9OWcdhdOosFRVBxfd+AVy2ZIrFPs1dgT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721312515; c=relaxed/simple;
	bh=xDF9+usCWVfPisIogbFc0/lWMf+x2Mblefuu/g/Og4s=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ZYhjftsi4htzYlXDo+A/WMXLC4IOJKII5R28i/ex67zf9tkPQEJ1P92XOGHx6uVqR3/UG+YnE0E3Fm/FVyxcGGQ7NpqkQJuiyJtTMgao5lvDLmhaooBHwdQLb/XLCLUFKX7bcBPRUYmYYmw9mXhLN5s7L/Nnv6I7mAi738geaAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [50.229.122.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 046E97D06B;
	Thu, 18 Jul 2024 14:21:49 +0000 (UTC)
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-6-chopps@chopps.org> <ZpkckAyjSjC--i6M@hog>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian Hopps
 <chopps@labn.net>, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next v5 05/17] xfrm: netlink: add
 config (netlink) options
Date: Thu, 18 Jul 2024 07:08:24 -0700
In-reply-to: <ZpkckAyjSjC--i6M@hog>
Message-ID: <m2ed7qdblv.fsf@chopps.org>
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


Sabrina Dubroca via Devel <devel@linux-ipsec.org> writes:

> 2024-07-14, 16:22:33 -0400, Christian Hopps wrote:
>> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
>> index a552cfa623ea..d42805314a2a 100644
>> --- a/net/xfrm/xfrm_user.c
>> +++ b/net/xfrm/xfrm_user.c
>> @@ -297,6 +297,16 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
>>  			NL_SET_ERR_MSG(extack, "TFC padding can only be used in tunnel mode");
>>  			goto out;
>>  		}
>> +		if ((attrs[XFRMA_IPTFS_DROP_TIME] ||
>> +		     attrs[XFRMA_IPTFS_REORDER_WINDOW] ||
>> +		     attrs[XFRMA_IPTFS_DONT_FRAG] ||
>> +		     attrs[XFRMA_IPTFS_INIT_DELAY] ||
>> +		     attrs[XFRMA_IPTFS_MAX_QSIZE] ||
>> +		     attrs[XFRMA_IPTFS_PKT_SIZE]) &&
>> +		    p->mode != XFRM_MODE_IPTFS) {
>> +			NL_SET_ERR_MSG(extack, "IP-TFS options can only be used in IP-TFS mode");
>
> AFAICT this only excludes the IPTFS options from ESP with a non-IPTFS
> mode, but not from AH, IPcomp, etc.

Ok, the change I'll make here is to only allow IPTFS mode selection for proto == IPPROTO_ESP (as that reflects reality). This handles the above issue as well as adds an additional useful check.

>
>> +			goto out;
>> +		}
>>  		break;
>>
>>  	case IPPROTO_COMP:
>> @@ -417,6 +427,18 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
>>  			goto out;
>>  		}
>>
>> +		if (attrs[XFRMA_IPTFS_DROP_TIME]) {
>> +			NL_SET_ERR_MSG(extack, "Drop time should not be set for output SA");
>
> Maybe add "IPTFS" to all those error messages, to help narrow down the
> bogus attribute.

Done.

>
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		if (attrs[XFRMA_IPTFS_REORDER_WINDOW]) {
>> +			NL_SET_ERR_MSG(extack, "Reorder window should not be set for output SA");
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +
>>  		if (attrs[XFRMA_REPLAY_VAL]) {
>>  			struct xfrm_replay_state *replay;
>>
>> @@ -454,6 +476,30 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
>>  			}
>>
>>  		}
>> +
>> +		if (attrs[XFRMA_IPTFS_DONT_FRAG]) {
>> +			NL_SET_ERR_MSG(extack, "Don't fragment should not be set for input SA");
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		if (attrs[XFRMA_IPTFS_INIT_DELAY]) {
>> +			NL_SET_ERR_MSG(extack, "Initial delay should not be set for input SA");
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		if (attrs[XFRMA_IPTFS_MAX_QSIZE]) {
>> +			NL_SET_ERR_MSG(extack, "Max queue size should not be set for input SA");
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
>> +			NL_SET_ERR_MSG(extack, "Packet size should not be set for input SA");
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>>  	}
>>
>>  out:
>> @@ -3177,6 +3223,12 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
>>  	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
>>  	[XFRMA_SA_DIR]          = NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, XFRM_SA_DIR_OUT),
>>  	[XFRMA_NAT_KEEPALIVE_INTERVAL] = { .type = NLA_U32 },
>> +	[XFRMA_IPTFS_DROP_TIME]		= { .type = NLA_U32 },
>> +	[XFRMA_IPTFS_REORDER_WINDOW]	= { .type = NLA_U16 },
>
> The corresponding sysctl is a u32, should this be NLA_U32?

While it's not unbelievable that one might want to handle more than 255 out-of-order packets, it is unbelievable that one would try and handle more than 65535. :)

So the change I'll make is to switch the sysctl handler to proc_douintvec_minmax with a max value to 65535 -- the sysctl functions work with "uint" and "ulong" there doesn't appear to be any support for "ushort"/"u16"s.

Thanks,
Chris.

>
>> +	[XFRMA_IPTFS_DONT_FRAG]		= { .type = NLA_FLAG },
>> +	[XFRMA_IPTFS_INIT_DELAY]	= { .type = NLA_U32 },
>> +	[XFRMA_IPTFS_MAX_QSIZE]		= { .type = NLA_U32 },
>> +	[XFRMA_IPTFS_PKT_SIZE]	= { .type = NLA_U32 },
>>  };
>>  EXPORT_SYMBOL_GPL(xfrma_policy);
>
> --
> Sabrina


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmaZJPwSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAl/OcP/RNFlt3hxlZbcPaCddY6yU3lmkyo0gOS
cWnUY93GYe8MLzcH6tDt5oUiDcD3Hu5hb47X0cQaq0ogva4xbM/6xrOON4RQt1OM
KHokMkDYbc3HuyGT4keLG6rICP/M724SgWdU9w5SykNKw1FxiiDA1M/vJAVs4t9S
8otPowkspabFuEfU/Mlw4/77poB9bgx6Xrk154XfQ970D/k6Ndtx5P8H2ip6kfQd
NGQgk0T1QER04w3k205XGRNg0kPA9r+OKba8ERcrx4O4WjYajrihoEU63nDZoJca
DKcifDmayOsYXEYk2PB1R8Y4Hs3gtqIgDSI7SkkghsXaeBJOLQ0S+dJh3O/muMcN
wdGqCCh458/i7/telb6p+goHC9Y/9KX7bMOjvsjFLGBmf/ADuLt3S02SaxQKFSFs
xhF2bGSQcOqXwFNpvAK+RHgfarHccMuvkOCloF36kF07Agtio3WLOix0AWrHd3Cb
/Va85aQxFhAAqNKZZbKqTwzNx8EhzmYFDS8buT2QMog5dah6n9nuGpwrKD0MFugi
rp8D94bl/SIPconxT7YPHSV/8ASdS1O1xa5rcYWduIO0DQP+8u4nmdnJV2kBBauN
gFkAsgjGp4mNj8NQDVhJd3JBQh7CHtvOd64bTPjyTUsKgYxnOEqtYlyrNhkfqxmV
CAbPoR9Cr6qa
=eDGs
-----END PGP SIGNATURE-----
--=-=-=--

