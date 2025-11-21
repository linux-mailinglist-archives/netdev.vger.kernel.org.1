Return-Path: <netdev+bounces-240708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEFCC782B8
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 10:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 28C1536940
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5AF309DA1;
	Fri, 21 Nov 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wh3D+C67";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PI/AMUdh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC15302CC7
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716875; cv=none; b=gnscK6YxX4x3A3qiXouxxJNKsc6NNvYpKE0eWBl4AqtbyDdV83V44W7zIGGm0q65LBiPyZgnIPsSMUi0b0dnCfDgDyEwK4OslHTqS8cjd+nVpoFfLHghlqeQGnV3palK3tnzya/QZ2jWAhQ+jjXzSDIA0peLwFq1GiQgawd2ijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716875; c=relaxed/simple;
	bh=88bzWzZsrFl3P0XuSIsfcAZAJYQYQd2cXTWkuomn7dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbQVpEBwHa23dwPyWCRosIPxW2pkI6bg9yerRKxZmjq61iuaMyqs9XbZSiyp/kImwjYjEVA1AyzUafanMr1JP8p+iu7YCn7e8r9/sda8VnpBFS0qzSTzg2ns/sI9brKsGBpvGYFuR1XC9mPEFTAjMFnJoceQ24Jpx9SgQ52j3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wh3D+C67; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PI/AMUdh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763716872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FTcna51xyD4gkYI2wkOSx2yGaNSja9/HdHczSqaL88Y=;
	b=Wh3D+C67WNaHE2duYqLdyjWKq6DIDieRfTmdmilkk6rmXKqtdh21Snp1koWhXVdUJoiKLG
	CQHFFfVGjA681+vEdAFSprYe/VQnPsZRHFxyjXmcpjPuBYAjPYypGPhYK2oDe9scFerB7d
	Ocsf2Gw7Hh/CaED9uPfw+H7f+vGYPng=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Prg98G-PPUGsZmgJLUtAsw-1; Fri, 21 Nov 2025 04:21:11 -0500
X-MC-Unique: Prg98G-PPUGsZmgJLUtAsw-1
X-Mimecast-MFC-AGG-ID: Prg98G-PPUGsZmgJLUtAsw_1763716870
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b70b2a89c22so192767666b.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 01:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763716870; x=1764321670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FTcna51xyD4gkYI2wkOSx2yGaNSja9/HdHczSqaL88Y=;
        b=PI/AMUdhLo2uKxjDL1m2MckyXemgWbGMpT/Cxq1IKr6NfppVbZX79JBQKXCRo9i7QZ
         pnMH1jj+xlZo9tXL6Ac9HDHnWav4J2CfD1kvrhPtKY8tXhJ6MWs2QQIwrmNUn/pb069Y
         kBCW6pw2kn2CLwsh4sVPR2nPVDh54pxGaVUoKSyhhWRUDYTAUSjwoaZv76r2BgBx7EOZ
         4G9XAUwiwkHntGfRmfyuO7qrABF+IMTKp2fha8/hFGZgydvDQ0mdOUXlVfPYCTRXGsYn
         DEFvSLtD/1e1xTAeJa2JSw142MzBserrGKvBTbnOys4dt4+0pcwYY30Pe9EWpNMtqH0h
         M4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763716870; x=1764321670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTcna51xyD4gkYI2wkOSx2yGaNSja9/HdHczSqaL88Y=;
        b=h4WXhTs829Tc+j+mpBBv7gck0q1+vAVsxpoTMrNxOYeT7sKiRiLYxrYB+f6tnjb2D7
         +KCG05VeuFF2tnYj/jt1HpR/OOBJ8liU2YD3J0k5TEoEjEYQFuKyK7obCqu6eSIZ/KfH
         p0C3QQAyFqiEGRgtfJcxLFtFhCX/cgBvd0bwCj39vGf1qRv+tv5dn5kLVgO2WI2MaBJp
         RMos7LsXDZPceNHxM4N7Hq1M6it2Y3i0zQxx1ylLav5zQ7c7/1O/wOzpDd+nFSbXa0ud
         EqCk+lFfbNjAZE3ejTYE5c2QZPkavCimQJQb1KYJmBLim8OK/IBU0SShOiX1tXO5AOQc
         LOnw==
X-Forwarded-Encrypted: i=1; AJvYcCXSFndi9GfWtdBPyMfG49Hm9OJdbwW7jKNJ2IW+AErmDzzkUCEnBo2Q94Y6ZSsW+gOsRflDEyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfHBc0QyRoAjBsuUp55UC3K+o9ikfA359Ez7EX77P1YJffysPN
	lxeQNeM4MaxhAJZ79bAQOCLWpeLiJwdF94toY2U/DNAwaEJQtNq5LHfasAp0LAGNPze27Qq77Za
	GCeFziPD7UPWdI9MSm85PEN4Sc0PLEvsqD8no59ScFIytUD9camIDJKNXBA==
X-Gm-Gg: ASbGncu+aAmoyX9te4bm7eYSOOg6yfjNcSWn/Onc7zJt4xUfmW+J5RTR/ev+BVUIdbe
	PjwP2jtn592vfiHc38t5KMwp0WMHL1DMhUYgQXFpARZMP58p9iVeKHAZrHlSD/VdUMRgMK5P+fn
	yGN3lnT02rLy95mLvkVmb4rhoMO3MFdH7hNiLoC6IeyFC2LpQ9wntV4xtRJLQqNC8KacxgdBq4q
	+dwdyHJvjSP7rVT2bSpv5ueaqegllpYBvM44hN7kRLsT/hHdpzx2ksJW1wduq6duetqEd9Yxo3k
	r+pt+mInn+UZb2F45Q4UmSvWKJY25UcHLvf49L48OKoIuERVmm+DuyN2R9Aow45wpLgKzTvjNkS
	btkYRZqnJAOfN2BkWkZLaOdPvW23VbukSmE2f8p+cgADIAP002xvmKvgoP0Pg6g==
X-Received: by 2002:a17:906:d553:b0:b04:48b5:6ea5 with SMTP id a640c23a62f3a-b766ef1d27emr179098266b.17.1763716869699;
        Fri, 21 Nov 2025 01:21:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGy2fwvK+Qkff9FcCdDI2UgofRL9rFpwVTJ/zBHtBRxPZJ5JeGTjRIY7myDBG6TkqWfVfUsUQ==
X-Received: by 2002:a17:906:d553:b0:b04:48b5:6ea5 with SMTP id a640c23a62f3a-b766ef1d27emr179095566b.17.1763716869171;
        Fri, 21 Nov 2025 01:21:09 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765504828esm406198066b.64.2025.11.21.01.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 01:21:08 -0800 (PST)
Date: Fri, 21 Nov 2025 10:21:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
Message-ID: <fy3ep725gwaislzz6lyu27ckswp2iyy5gj6afw6jji6c3get3l@lqa6wpptq5ii>
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
 <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
 <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
 <rptu2o7jpqw5u5g4xt76ntyupsak3dcs7rzfhzeidn6vcwf6ku@dcd47yt6ebhu>
 <09c6de68-06aa-404d-9753-907eab61b9ab@rbox.co>
 <663yvkk2sh5lesfvdeerlca567xb64qbwih52bxjftob3umsah@eamuykmarrfr>
 <1b2255c7-0e97-4b37-b7ab-e13e90b7b0b9@rbox.co>
 <06936b55-b359-4e3d-bec0-b157ca32d237@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <06936b55-b359-4e3d-bec0-b157ca32d237@rbox.co>

On Thu, Nov 20, 2025 at 10:12:20PM +0100, Michal Luczaj wrote:
>On 11/19/25 20:52, Michal Luczaj wrote:
>> ...
>> To follow up, should I add a version of syzkaller's lockdep warning repro
>> to vsock test suite? In theory it could test this fix here as well, but in
>> practice the race window is small and hitting it (the brute way) takes
>> prohibitively long.
>
>Replying to self to add more data.
>
>After reverting
>
>f7c877e75352 ("vsock: fix lock inversion in vsock_assign_transport()")
>002541ef650b ("vsock: Ignore signal/timeout on connect() if already
>established")
>
>adding
>
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -2014,6 +2014,7 @@ static void test_stream_transport_change_client(const
>struct test_opts *opts)
>                        perror("socket");
>                        exit(EXIT_FAILURE);
>                }
>+               enable_so_linger(s, 1);
>
>                ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>                /* The connect can fail due to signals coming from the
>
>is enough for vsock_test to trigger the lockdep warning syzkaller found.
>

cool, so if it's only that, maybe is worth adding.

Thanks,
Stefano


