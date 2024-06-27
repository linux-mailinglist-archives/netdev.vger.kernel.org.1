Return-Path: <netdev+bounces-107139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB67C91A102
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE7C1C2142F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 07:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF08770E4;
	Thu, 27 Jun 2024 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHdKul8R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98799757E5
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475148; cv=none; b=YaBCmzXu/fygPmWwXZWlUiewz7zPGSOXHSTkncOIylkdRmSjB/njWe/HArAV7ecllcPZtps3GBm835aZYhQD++lhgbM0imxtMQhFTHUVZ5FUlCTvigZ8b56NVZwUCB1aSENIOLMts64IiitQIdRSVp7o4TiHN3eedoeyRsf4soY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475148; c=relaxed/simple;
	bh=xcU1eFpqgSU/Bh/CKmAiD64jwZruaevOEqyVUKJm0pM=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luC+dhI2lttFYDHBd0m0bVwlTnpKL8QNfSA+wn24gNcBu2QBIrv+qayTmHOkgod99mviMacF/xKN9h8VFdF4a72TYPXzMPI2NCowLDVsJDSUv4v8P3Mu4vc3Xf7rVVN6m8ylWQuPgI03FosE6aw1FEumM+h3QFMDAsZBfnoTKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHdKul8R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719475145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeushS7zvrpsIs8SYBcVSJVunv4P3aSomIKJ3BjOrcI=;
	b=BHdKul8RVqUMJggjIohVZ7lPxHapsHWyXp8hXyks3i3htfOD7A7VqkL5jSqcFZX8JpqY3M
	FEqrn3vJjc02LFwtBPPTXG3cGmvmH4hhn78GM2nF0A2BhIxLlTiQ6sTdVpdYs7WznUtQeU
	Q2cxDCP329GL2ojh6tcZEKyTovpa+A4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-oDaKpgm5N_y3QfXP4wM9dg-1; Thu, 27 Jun 2024 03:59:00 -0400
X-MC-Unique: oDaKpgm5N_y3QfXP4wM9dg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-70d8b7924e7so8544325a12.2
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 00:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719475139; x=1720079939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UeushS7zvrpsIs8SYBcVSJVunv4P3aSomIKJ3BjOrcI=;
        b=stLSXFyOdaRJigj84tv/MFLm7mnOE0oGotGn+g6QQffqIQROu9jGZDKW5I0Ed4ADwD
         jYpN1nT5tIX2HFtKqOQBeiWOBwa8LuwouvGpxSdrmaq00gHdo4yzLACWzUFroD23ueAD
         C3CvlX5eSszzlFeRHFD5zu2RBOjzCNsywYaWQ7zJJf2mwpi5POfboXhp/2I8I7mCxN5o
         nuXZPmTR2cnFV/l1daN31rEq6RyBLLemWRpvCLc7pgvjRPDe+ZYjxWsrb1bE1Cwpkik7
         xlyiybzCesmm5U2XFQHssClryPYlK/Q2vECUMrEEm+q5Og+hajUcDEQDa3QALTD8Y2fB
         gMsQ==
X-Gm-Message-State: AOJu0Yy4rN9VIuSSe/0F7v/yWZrqT0rLyFtUpqr7jAf+KkT9TxDKqg+V
	6b/ZMT+NmgqZE19t3QgXK5HrOJ/uMnydUyxIGj8L0PPjl6VH1tLIVs/8+UaTu4DZKTQeU9gg+y2
	N3XY9F0GpnPLmDXduHuji8JerxDaG/eJl8Sh1nFH5yst9zhmmFf4EPkUbo0ADWV7SrCErX6Xpjn
	gqz6WmCbACgJ8FD0oWJSSDNkC+m7SE
X-Received: by 2002:a05:6a20:6d18:b0:1bd:1b22:dcce with SMTP id adf61e73a8af0-1bd1b22dd3dmr6599031637.30.1719475139137;
        Thu, 27 Jun 2024 00:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEhtQavUVxjiWNx9N6Un/I/J3BmWyhnPpVIhRhfNfnMVfGkd4OTnKCID/jsmdNPWflpzAhMX/5qaCB6D6jUe0=
X-Received: by 2002:a05:6a20:6d18:b0:1bd:1b22:dcce with SMTP id
 adf61e73a8af0-1bd1b22dd3dmr6599019637.30.1719475138754; Thu, 27 Jun 2024
 00:58:58 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Jun 2024 00:58:57 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com> <20240625205204.3199050-11-amorenoz@redhat.com>
 <3395bd94-6619-4389-9f07-1964af730372@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3395bd94-6619-4389-9f07-1964af730372@ovn.org>
Date: Thu, 27 Jun 2024 00:58:57 -0700
Message-ID: <CAG=2xmNfdAm1s1bDc6TZJL5wB3p+bOe-r=OwSm-RJ5zJ_3NqkQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 10/10] selftests: openvswitch: add emit_sample test
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 01:15:21PM GMT, Ilya Maximets wrote:
> On 6/25/24 22:51, Adrian Moreno wrote:
> > Add a test to verify sampling packets via psample works.
> >
> > In order to do that, create a subcommand in ovs-dpctl.py to listen to
> > on the psample multicast group and print samples.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  .../selftests/net/openvswitch/openvswitch.sh  | 114 +++++++++++++++++-
> >  .../selftests/net/openvswitch/ovs-dpctl.py    |  73 ++++++++++-
> >  2 files changed, 181 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/t=
ools/testing/selftests/net/openvswitch/openvswitch.sh
> > index 15bca0708717..aeb9bee772be 100755
> > --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > @@ -20,7 +20,8 @@ tests=3D"
> >  	nat_related_v4				ip4-nat-related: ICMP related matches work with SNA=
T
> >  	netlink_checks				ovsnl: validate netlink attrs and settings
> >  	upcall_interfaces			ovs: test the upcall interfaces
> > -	drop_reason				drop: test drop reasons are emitted"
> > +	drop_reason				drop: test drop reasons are emitted
> > +	emit_sample 				emit_sample: Sampling packets with psample"
>
> There is an extra space character right after emit_sample word.
> This makes './openvswitch.sh emit_sample' to not run the test,
> because 'emit_sample' !=3D 'emit_sample '.
>

Wow, good catch! I'll get rid of that space.

Thanks.
Adri=C3=A1n


