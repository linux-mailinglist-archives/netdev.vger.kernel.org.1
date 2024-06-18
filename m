Return-Path: <netdev+bounces-104600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29DA90D81A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3F11C23C09
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94601482C6;
	Tue, 18 Jun 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTfrTS3d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B346450
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726691; cv=none; b=A3Qe77VQ8JAbrJI7kS4h3y9IIxO6r0nORkAT3HnwghRYiJnxtGnfcSb7Fb7m4EbjaWSwy1gH5k3wpVmsEy6uvOmuyw38QmvN9q0SS8w9wPBq5TlQbZgAMNFVYc6bX8Du8dRpqi1Y7kTexEzeDsj2s6qvvlfnw708bj5dNNcmYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726691; c=relaxed/simple;
	bh=GP0uR3tvQbzcrtWs6IScgA94dZLZ1PgMYu17zBOgD/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hABKXzj0/goiURQ8FQAL/ay1fh6hVHiIBq8K/d1dyN4NnDaFnM+6ZH6HJlAPYWHy8f1dVF6BVcots2Z8OvE2cVpxAma2NXori3dmkY5i5K4xOE1J3dnrBsN4Z0PAKWsBLSVlxJO6kp2WXwPZU7GCdLzzaN3ycDBknNv948+HDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTfrTS3d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EkKajcuHyi0uetV3u4rjxeb0Qgka5tO9IJGy0qxthnw=;
	b=KTfrTS3dxtzm1gLpEssXZSGiU31ZSHBJucFMmjigFyAZ5I6yIAUzDMyXi2UAQmaHtSNjep
	kTYdXsaoGNVUyXQXQt0Hu6TuGWQwGaSxmmQGI+3Gpvl2c47mzr0VvuzIrsg5pnoADdvGlZ
	+/2IUb/CYV8+eMgLRNfA9ymwffFtsVE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-gL5KrjedPw-grVOatKz9IQ-1; Tue,
 18 Jun 2024 12:04:42 -0400
X-MC-Unique: gL5KrjedPw-grVOatKz9IQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 701BF19560BF;
	Tue, 18 Jun 2024 16:04:40 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 877C13000218;
	Tue, 18 Jun 2024 16:04:38 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,  Simon Horman <horms@kernel.org>,
  linux-kernel@vger.kernel.org,  Stefano Brivio <sbrivio@redhat.com>,  Eric
 Dumazet <edumazet@google.com>,  linux-kselftest@vger.kernel.org,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan
 <shuah@kernel.org>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next 5/7] selftests: openvswitch: Support
 implicit ipv6 arguments.
In-Reply-To: <20240617180218.1154326-6-aconole@redhat.com> (Aaron Conole's
	message of "Mon, 17 Jun 2024 14:02:16 -0400")
References: <20240617180218.1154326-1-aconole@redhat.com>
	<20240617180218.1154326-6-aconole@redhat.com>
Date: Tue, 18 Jun 2024 12:04:36 -0400
Message-ID: <f7tr0cujkyz.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Aaron Conole <aconole@redhat.com> writes:

> The current iteration of IPv6 support requires explicit fields to be set
> in addition to not properly support the actual IPv6 addresses properly.
> With this change, make it so that the ipv6() bare option is usable to
> create wildcarded flows to match broad swaths of ipv6 traffic.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 42 ++++++++++++-------
>  1 file changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 2f16df2fb16b..2062e7e6e99e 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -200,6 +200,18 @@ def convert_ipv4(data):
>  
>      return int(ipaddress.IPv4Address(ip)), int(ipaddress.IPv4Address(mask))
>  
> +def convert_ipv6(data):
> +    ip, _, mask = data.partition('/')
> +
> +    if not ip:
> +        ip = mask = 0
> +    elif not mask:
> +        mask = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
> +    elif mask.isdigit():
> +        mask = ipaddress.IPv6Network("::/" + mask).hostmask
> +
> +    return ipaddress.IPv6Address(ip).packed, ipaddress.IPv6Address(mask).packed
> +
>  def convert_int(size):
>      def convert_int_sized(data):
>          value, _, mask = data.partition('/')
> @@ -941,21 +953,21 @@ class ovskey(nla):
>                  "src",
>                  "src",
>                  lambda x: str(ipaddress.IPv6Address(x)),
> -                lambda x: int.from_bytes(x, "big"),
> -                lambda x: ipaddress.IPv6Address(x),
> +                lambda x: ipaddress.IPv6Address(x).packed if x else 0,
> +                convert_ipv6,
>              ),
>              (
>                  "dst",
>                  "dst",
>                  lambda x: str(ipaddress.IPv6Address(x)),
> -                lambda x: int.from_bytes(x, "big"),
> -                lambda x: ipaddress.IPv6Address(x),
> +                lambda x: ipaddress.IPv6Address(x).packed if x else 0,
> +                convert_ipv6,
>              ),
> -            ("label", "label", "%d", int),
> -            ("proto", "proto", "%d", int),
> -            ("tclass", "tclass", "%d", int),
> -            ("hlimit", "hlimit", "%d", int),
> -            ("frag", "frag", "%d", int),
> +            ("label", "label", "%d", lambda x: int(x) if x else 0),
> +            ("proto", "proto", "%d", lambda x: int(x) if x else 0),
> +            ("tclass", "tclass", "%d", lambda x: int(x) if x else 0),
> +            ("hlimit", "hlimit", "%d", lambda x: int(x) if x else 0),
> +            ("frag", "frag", "%d", lambda x: int(x) if x else 0),
>          )
>  
>          def __init__(
> @@ -1152,8 +1164,8 @@ class ovskey(nla):
>              (
>                  "target",
>                  "target",
> -                lambda x: str(ipaddress.IPv6Address(x)),
> -                lambda x: int.from_bytes(x, "big"),
> +                lambda x: ipaddress.IPv6Address(x).packed,

This (and the following str() calls) shouldn't have been changed.  I'll
send a v2.  Sorry about the noise.  It isn't visible in this test, but
when doing some additional ipv6 test development for a future series, I
caught it.

> +                convert_ipv6,
>              ),
>              ("sll", "sll", macstr, lambda x: int.from_bytes(x, "big")),
>              ("tll", "tll", macstr, lambda x: int.from_bytes(x, "big")),
> @@ -1237,14 +1249,14 @@ class ovskey(nla):
>              (
>                  "src",
>                  "src",
> -                lambda x: str(ipaddress.IPv6Address(x)),
> -                lambda x: int.from_bytes(x, "big", convertmac),
> +                lambda x: ipaddress.IPv6Address(x).packed,
> +                convert_ipv6,
>              ),
>              (
>                  "dst",
>                  "dst",
> -                lambda x: str(ipaddress.IPv6Address(x)),
> -                lambda x: int.from_bytes(x, "big"),
> +                lambda x: ipaddress.IPv6Address(x).packed,
> +                convert_ipv6,
>              ),
>              ("tp_src", "tp_src", "%d", int),
>              ("tp_dst", "tp_dst", "%d", int),


