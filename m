Return-Path: <netdev+bounces-99423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FF18D4D57
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D52DB2378F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F9186E32;
	Thu, 30 May 2024 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UL5VAAuZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A4186E34
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077494; cv=none; b=apY+1ygXsefk4yhdsc8mNtoOdO3pvAwrDIGfan/c/35ZlEd7YzMbBtB7ngGKK8/KPYCUtACMqH2mr5SQJbuoPe6mqs6OOmYuDjyo7AlAN2+zNj67MMhkaiSwCBJJ6qcy72GRJ2qTJbFQ3zV6n4Dao+K/8h6BnXWCTod0bvUaSvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077494; c=relaxed/simple;
	bh=53UBysYzvpzZjDO72iJt9py9YONleXSWomuMbkZn3l4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dapTaNgIatx8gD9/5jsJR21CDqMvbEHyNsejznqyvtBn1M4OptgUsCdG5psh/M1Ql77V/rotg0FtUE27yzxO469rvcvfXR2OwhdM6IAr4zMUV86Z6pk+XOQHIPdI4ofpJPj8Yg3z9W9eO+X1CqsPMs015MZiD/Mrytky+7xDOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UL5VAAuZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717077492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/xYHbO4YrM2R0offrTkQuWyL8jjwsXNCg2fkqfbyEmY=;
	b=UL5VAAuZESa/wMt66YJ8kUjay0ASOYbpi+QCCnOjv5bXynaI/VL17MgCm+RUW9IPfcxkme
	IcO9vEXUY/JcB9H95Gea963yskgmfa6I+2dae/3NOYd+ot11IUFCbt1I2vpIKNs1cO4G/b
	EkI5S9UhFBLDC95n/0mAG1gZ8+Cv5UI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-_JBJQbs2NR-gAAs-32Z-bQ-1; Thu, 30 May 2024 09:58:09 -0400
X-MC-Unique: _JBJQbs2NR-gAAs-32Z-bQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42111cf8bfbso682125e9.2
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 06:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717077488; x=1717682288;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xYHbO4YrM2R0offrTkQuWyL8jjwsXNCg2fkqfbyEmY=;
        b=EkGMumf73BXX5/TYxeYZ2/v3qvUhLIgY+55XtTEWwV0KRPNlnhQe900JbcDCiQsv4r
         ZIjgwO9XsicIIEvS3GiQAMN+utCwb+zL59Aw4RORy6IeMMmw1WaQSh/emJ+KpMXFizJg
         ovCmSdH8q9xE4wqJGMClzNbcoBe0MjWReLcwz61v9Q5Dj6fHtuVz/U0Xx6Mxc4mqsXbL
         e9+gCTT8y2PdL2m/RQPvqMptLOFyTJjQd7SzaTBRgzTtrKAL39d20JArgSAiJvQijL0u
         Yuu3lfI3Eh/MrcjFGjxJSa3IhhF9PWqzE4AJP0DKInIc8/sN8fqTMWCYDd95iKpMBVv/
         hxhQ==
X-Gm-Message-State: AOJu0YwzBsy6S8re3PcXar+aEbxYLhNLHoDAYPCFi866rb5GNgDh8rLk
	kk2LdA0aJPx73i03HVPowBpsT10c5Mg7nLfRJKP1ar4hcFHGzwmDchLLVKir/7wprqmPKz3xV9N
	Jxzlv7cWjGbVfiI5rPIC7EWJ0TA+khP+VicKH+eGjS0utwv8auNDM5A==
X-Received: by 2002:a05:600c:444e:b0:421:29b4:533b with SMTP id 5b1f17b1804b1-42129b45721mr9717165e9.0.1717077488413;
        Thu, 30 May 2024 06:58:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH738BjxDlANns8EfHf0phCQBmsoUtAH/K6IVO7MTanr8w6wX6EPnwcpSPCPZIcNMTQy/37Xw==
X-Received: by 2002:a05:600c:444e:b0:421:29b4:533b with SMTP id 5b1f17b1804b1-42129b45721mr9716895e9.0.1717077487912;
        Thu, 30 May 2024 06:58:07 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42126fea343sm26406505e9.0.2024.05.30.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:58:07 -0700 (PDT)
Message-ID: <2e58d7f5c493d6f158042fb39f299d24c7b60591.camel@redhat.com>
Subject: Re: [PATCH net-next 2/2] selftests: net: tests
 net.core.{r,w}mem_{default,max} sysctls in a netns
From: Paolo Abeni <pabeni@redhat.com>
To: Breno Leitao <leitao@debian.org>, Matteo Croce <technoboy85@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Shuah Khan
 <shuah@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Thu, 30 May 2024 15:58:05 +0200
In-Reply-To: <Zlhsu+9If//CMPv+@gmail.com>
References: <20240528121139.38035-1-teknoraver@meta.com>
	 <20240528121139.38035-3-teknoraver@meta.com> <Zlhsu+9If//CMPv+@gmail.com>
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

On Thu, 2024-05-30 at 05:10 -0700, Breno Leitao wrote:
> On Tue, May 28, 2024 at 02:11:39PM +0200, Matteo Croce wrote:
> > Add a selftest which checks that the sysctl is present in a netns,
> > that the value is read from the init one, and that it's readonly.
> >=20
> > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> > ---
> >  tools/testing/selftests/net/Makefile        |  1 +
> >  tools/testing/selftests/net/netns-sysctl.sh | 15 +++++++++++++++
> >  2 files changed, 16 insertions(+)
> >  create mode 100755 tools/testing/selftests/net/netns-sysctl.sh
> >=20
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selft=
ests/net/Makefile
> > index bd01e4a0be2c..6da63d1831c1 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -53,6 +53,7 @@ TEST_PROGS +=3D bind_bhash.sh
> >  TEST_PROGS +=3D ip_local_port_range.sh
> >  TEST_PROGS +=3D rps_default_mask.sh
> >  TEST_PROGS +=3D big_tcp.sh
> > +TEST_PROGS +=3D netns-sysctl.sh
> >  TEST_PROGS_EXTENDED :=3D toeplitz_client.sh toeplitz.sh
> >  TEST_GEN_FILES =3D  socket nettest
> >  TEST_GEN_FILES +=3D psock_fanout psock_tpacket msg_zerocopy reuseport_=
addr_any
> > diff --git a/tools/testing/selftests/net/netns-sysctl.sh b/tools/testin=
g/selftests/net/netns-sysctl.sh
> > new file mode 100755
> > index 000000000000..b948ba67b13a
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/netns-sysctl.sh
> > @@ -0,0 +1,15 @@
> > +#!/bin/bash -e
>=20
> Don't you need to add the SPDX license header?

Yes, please!

Additionally, please handle explicitly the sysctl-related I/O errors so
that the script could output a human readable message in case of
failure.

Thanks!

Paolo


