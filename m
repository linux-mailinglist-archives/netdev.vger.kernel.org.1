Return-Path: <netdev+bounces-76142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8AF86C812
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DFB2881BD
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787107C09F;
	Thu, 29 Feb 2024 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnzamrDu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5A7AE41
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206396; cv=none; b=V0R9v+nEJaYzoQSrhA4yVFXDB2mplbgXeGwYhxB7bz6hStePvWF1/MPTp8TX648UOQ6/1jBR4EF7aqnfldfktQg9lv/2kyJ5zxaPa0y6btls+pxOwDHklzIxIbINNaBtCTE4F12vkQIeyrTikg87GDCpEhYKSZ1ATA8NCSuadDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206396; c=relaxed/simple;
	bh=EcEY2uWVmxlikgQ3wNAoycZhrnRP7aSBd+0g9digYOA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uxmDsWufkXT139wovFG80IzfsBuIxDTjMe0JAh2JLlKveBTsm7+lIC8KsuLYeOHeERX/gyR8Fix5hsHqdSjHR48BRl5ifpeXESCLadI5w7TztkwDfGP5JNd18D67bIJcZhY8nyIqES9HQMEIQWgAW9z59hvoIKwtlWj/MZNS32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnzamrDu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709206393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZIRT7DyYzV+CIB6U1Vj3ZtXi2jn1T+sGogiV8Z6xrm4=;
	b=UnzamrDuImH2PPDco8Aw3xpKVmDVPXFm1KjKjbV8xybhuMAEuQjL3hEiDEInSUYU0i8eet
	xtRwbdtxlcar0b7NzO8Cf6RDItLyx2SPMW0o40qvtnm5mebX6ZMVYwLSn7JXBob9jE6d9T
	6Gs/WeK+6Xfa+sMpYc5tt9VQ3pflND8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-j1TU6vFwOgaHyC1z0QglLA-1; Thu, 29 Feb 2024 06:33:10 -0500
X-MC-Unique: j1TU6vFwOgaHyC1z0QglLA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so1142955e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709206389; x=1709811189;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIRT7DyYzV+CIB6U1Vj3ZtXi2jn1T+sGogiV8Z6xrm4=;
        b=v5SLCur01RpgXRWBODO9quBB49XO4icGQbdXFyolsFwBgQd7CwbH8E9S73go+qnr/d
         7hYZFvVaXkl1JnZKvFcopF2yLxELI+E/gTrlLS/T8s9m+PA64hVmdwKhEmAGG8JkgkIQ
         ecXrFFe3twildZnxC+TbhBDeTHVvKS/YOAI7OzXIib97K/kx4ktlz9FUvR4j/cE3+wHD
         Y36RsQ2rRkS4n1gn7zsayCH4wdAwpehBj2kwqqFXmarvt9U1xw8K4buSU03Zh6fU0mtl
         XupGMFvD4JTIJKLJO0dAOaF2MvGPND6u4tffvndrF08eLuOO3D0j6h7yx7zR522zScXO
         0NiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWff9aU+BEzV5xPuhNnrn4MoiDDUB1UzqWQmXdAbfzkerdNenx+/FqlMA/zD12RSBj2aJsUoGp0hpjIHbPgxEMqk2lcILCS
X-Gm-Message-State: AOJu0Yy8xSOk+c1VaJLPLk8jTPRdv359Zs6xsqGCvkhxbqNsJtZoVU1g
	451CcXBISwCHd12JXTgXApo82Kw5UI5hjjr/lG6J93u+Phq53ZvJNoA8NuXYIGevEMLNhWjZcr3
	1eGHNgHm0wr+uajgUtq69cQHeynfeF8dGRtTwnzPnb3dBWv1oCk1Y6Q==
X-Received: by 2002:a05:600c:358d:b0:412:a314:a9e4 with SMTP id p13-20020a05600c358d00b00412a314a9e4mr1510324wmq.4.1709206389383;
        Thu, 29 Feb 2024 03:33:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPPhPaWD9Q+9gCmEBbpMr4rfWuI9pY4LF/OIkui1zgqQLLVPRsnnODz7KK5G8iFrkPZGHuWw==
X-Received: by 2002:a05:600c:358d:b0:412:a314:a9e4 with SMTP id p13-20020a05600c358d00b00412a314a9e4mr1510308wmq.4.1709206388996;
        Thu, 29 Feb 2024 03:33:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-250-174.dyn.eolo.it. [146.241.250.174])
        by smtp.gmail.com with ESMTPSA id jw21-20020a05600c575500b004126afe04f6sm4955237wmb.32.2024.02.29.03.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 03:33:08 -0800 (PST)
Message-ID: <00685c09d316a9dc3b57e076054ab03961ee42a4.camel@redhat.com>
Subject: Re: [PATCH net 3/3] selftests: netfilter: add bridge conntrack +
 multicast test case
From: Paolo Abeni <pabeni@redhat.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org, 
	edumazet@google.com, fw@strlen.de
Date: Thu, 29 Feb 2024 12:33:07 +0100
In-Reply-To: <20240229000135.8780-4-pablo@netfilter.org>
References: <20240229000135.8780-1-pablo@netfilter.org>
	 <20240229000135.8780-4-pablo@netfilter.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Thu, 2024-02-29 at 01:01 +0100, Pablo Neira Ayuso wrote:
> diff --git a/tools/testing/selftests/netfilter/bridge_netfilter.sh b/tool=
s/testing/selftests/netfilter/bridge_netfilter.sh
> new file mode 100644
> index 000000000000..659b3ab02c8b
> --- /dev/null
> +++ b/tools/testing/selftests/netfilter/bridge_netfilter.sh
> @@ -0,0 +1,188 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Test bridge netfilter + conntrack, a combination that doesn't really w=
ork,
> +# with multicast/broadcast packets racing for hash table insertion.
> +
> +#           eth0    br0     eth0
> +# setup is: ns1 <->,ns0 <-> ns3
> +#           ns2 <-'    `'-> ns4
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=3D4
> +ret=3D0
> +
> +sfx=3D$(mktemp -u "XXXXXXXX")
> +ns0=3D"ns0-$sfx"
> +ns1=3D"ns1-$sfx"
> +ns2=3D"ns2-$sfx"
> +ns3=3D"ns3-$sfx"
> +ns4=3D"ns4-$sfx"
> +
> +ebtables -V > /dev/null 2>&1
> +if [ $? -ne 0 ];then
> +	echo "SKIP: Could not run test without ebtables"
> +	exit $ksft_skip
> +fi
> +
> +ip -Version > /dev/null 2>&1
> +if [ $? -ne 0 ];then
> +	echo "SKIP: Could not run test without ip tool"
> +	exit $ksft_skip
> +fi
> +
> +for i in $(seq 0 4); do
> +  eval ip netns add \$ns$i

[Not intended to block this series] I thing this patch could use a
'next' follow-up to clean-up the style a bit (e.g. indentation above
and other places below...)

Also I'm wondering if in the long term we could converge to use the
same infra here and in 'net' self tests for netns setup.

> +done
> +
> +cleanup() {
> +  for i in $(seq 0 4); do eval ip netns del \$ns$i;done
> +}
> +
> +trap cleanup EXIT
> +
> +do_ping()
> +{
> +	fromns=3D"$1"
> +	dstip=3D"$2"
> +
> +	ip netns exec $fromns ping -c 1 -q $dstip > /dev/null
> +	if [ $? -ne 0 ]; then
> +		echo "ERROR: ping from $fromns to $dstip"
> +		ip netns exec ${ns0} nft list ruleset
> +		ret=3D1
> +	fi
> +}
> +
> +bcast_ping()
> +{
> +	fromns=3D"$1"
> +	dstip=3D"$2"
> +
> +	for i in $(seq 1 1000); do
> +		ip netns exec $fromns ping -q -f -b -c 1 -q $dstip > /dev/null 2>&1

[Not intended to block this series] repeated '-q' argument here

Cheers,

Paolo


