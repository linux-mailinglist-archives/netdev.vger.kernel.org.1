Return-Path: <netdev+bounces-66653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F6C840154
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 10:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B662810EE
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45D054FB0;
	Mon, 29 Jan 2024 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D06slObg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001754F86
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520204; cv=none; b=Qj48993bkjv04AJfZ2OsBOUiprT+WjfoucwTT8oPAhm9stgGo7u0ItBLEG6BUsRPFtzZaoVbOIIk+ZIziakpqOZzJ2zyOXe/mFXkOST6WcM/0aoDKhCdsdus54fmI1KoP9Uqkx5oGscVwTD53gxrGoKtmYXRTTpP9dd4ZPi+arU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520204; c=relaxed/simple;
	bh=Dn2c12XIiMV/+Rvdj+OiTXeDdTdPbeUo1p6RSVs23vg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Szo8iAA32Whgmts1O1ChSKPbH68/wmgmWrqN2yk6ethtxeR5GRdden996F9oV0Pgqt7EfJxViYCDqyCufQJRbpJbiBeIB2rJpp0EsRv7fjo0zWnq3uPG4kt+WaCMGMW7yLx+kRZA77HFm6lwDZ51xZH9hH0nn1w88ezwt2S/YCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D06slObg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706520201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OlOkg8ik+RYxbLDWO73VX5eqpjOS24ltjKQhJp/x3NI=;
	b=D06slObg6eQiXqozWqABaBKZ7jB2/Ng5hGbgSVK3xQ2iAW2VYEnFRKMsIXMginIF4w8EmP
	MAE4OIipMAZgaaGj6UqXTNIhJ2fcMo6SVWqcfmA80EvSozSnyHKQH0RIpfT12Y0HfwPiv3
	FVlSHaO+uZ3ihCL+xXrhCq3CN4zddzY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-qmZZLHHKPnK8weoPAl6I7g-1; Mon, 29 Jan 2024 04:23:18 -0500
X-MC-Unique: qmZZLHHKPnK8weoPAl6I7g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40efaee41dbso185515e9.1
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 01:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706520197; x=1707124997;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlOkg8ik+RYxbLDWO73VX5eqpjOS24ltjKQhJp/x3NI=;
        b=sNUatHhjaE+L3Hrj3B2pUfbSp6uOBI9YMATa7Uypccb82CfhVthcXCjOgYIu1J0l05
         jH1CO6dEalFnJKQsZlIqAgTPgI0q4Jnuq65xadUeTa85hz/3pApfD9/HVLVda8xdMRmG
         eHPZnQr86axuVBz5lsuod2FaP1UZ34/CtUg7go8Dcg6a6YlPi79R/9KIdcSuJ0AGkQwV
         POG8P+rdZdMq+HuFZlZX+6eFh/xJUMfACyC6f3sDxi8Zz3HbJNJRdOxoAymeM33xZJoE
         mHBFMxDhcs/YasqRSf9Ihz9betlhJBhLkB76zjuY6ndC3gxOalnI5W2DrkvbYZmGGymh
         CGfA==
X-Gm-Message-State: AOJu0YyPAzv+SXkk1DFKfMZ7PtBte2E84YIwn0p1EC+ZMBXRXF+Eamul
	2dpluQawiFI7su1WNSL/bv58JCQfzlwRbQF/9kXjxwYe1u5av5ce4IpMq1WrdnSt+Az4CK3YnSf
	L8KySipEpTctVUXEWzDwolSvK8BtHcNStGH7hbDP80E1xGSfXabq96A==
X-Received: by 2002:a5d:4ec1:0:b0:33a:e381:b03e with SMTP id s1-20020a5d4ec1000000b0033ae381b03emr3475038wrv.7.1706520197517;
        Mon, 29 Jan 2024 01:23:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgOxz/yp5duraO2cactFUk3e6tk3d+xJFdgQnyNN+lPZXKEoeUXM8qcGzzXdctbUkNJvpDJQ==
X-Received: by 2002:a5d:4ec1:0:b0:33a:e381:b03e with SMTP id s1-20020a5d4ec1000000b0033ae381b03emr3475029wrv.7.1706520197169;
        Mon, 29 Jan 2024 01:23:17 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-151.dyn.eolo.it. [146.241.230.151])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4c44000000b0033aeda49732sm2180494wrt.33.2024.01.29.01.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:23:16 -0800 (PST)
Message-ID: <ef884f08937fcaab4e4020eb3fca91a938385c75.camel@redhat.com>
Subject: Re: [ANN] net-next is OPEN
From: Paolo Abeni <pabeni@redhat.com>
To: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "netdev-driver-reviewers@vger.kernel.org"
	 <netdev-driver-reviewers@vger.kernel.org>
Date: Mon, 29 Jan 2024 10:23:15 +0100
In-Reply-To: <317aa139-78f8-424b-834a-3730a4c4ad04@kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org>
	 <Za98C_rCH8iO_yaK@Laptop-X1> <20240123072010.7be8fb83@kernel.org>
	 <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
	 <20240123133925.4b8babdc@kernel.org>
	 <256ae085-bf8f-419b-bcea-8cdce1b64dce@kernel.org>
	 <7ae6317ee2797c659e2f14b336554a9e5694858e.camel@redhat.com>
	 <20240124070755.1c8ef2a4@kernel.org> <20240124081919.4c79a07e@kernel.org>
	 <aae9edba-e354-44fe-938b-57f5a9dd2718@kernel.org>
	 <20240124085919.316a48f9@kernel.org>
	 <bd985576-cc99-49c5-a2e0-09622fd6027a@kernel.org>
	 <c8420e51-691d-4dd9-8b81-0597e7593d07@kernel.org>
	 <20240126171346.14647a6f@kernel.org>
	 <317aa139-78f8-424b-834a-3730a4c4ad04@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-01-27 at 21:26 -0700, David Ahern wrote:
> On 1/26/24 6:13 PM, Jakub Kicinski wrote:
> > On Fri, 26 Jan 2024 17:56:26 -0700 David Ahern wrote:
> > > On 1/24/24 2:48 PM, David Ahern wrote:
> > > https://netdev-2.bots.linux.dev/vmksft-net-mp/results/438381/1-fcnal-=
test-sh/stdout
> > >=20
> > > still shows those 4 tests failing. since they pass on default Ubuntu
> > > 23.10, I need some information about the setup. What is the OS image =
in
> > > use and any known changes to the sysctl settings?
> > >=20
> > > Can I get `sysctl net > /tmp/sysctl.net` ? I will compare to Ubuntu a=
nd
> > > see if I can figure out the difference and get those added to the scr=
ipt.
> >=20
> > Here's a boot and run of the command (not sure how to export the file
> > form the VM so I captured all of stdout):
> >=20
> > https://netdev-2.bots.linux.dev/vmksft-net-mp/results/sysctl-for-david
> >=20
> > The OS is Amazon Linux, annoyingly.
>=20
> It's a bug in that version of iputils ping. It sets the BINDTODEVICE and
> then resets it because the source address is not set on the command line
> (it should not be required).
>=20
> There are a couple of workarounds - one which might not age well (ie.,
> amazon linux moving forward to newer packages -I <addr> -I <vrf>) and
> one that bypasses the purpose of the test (ip vrf exec)).

Could the script validate the 'ping' command WRT the bad behavior/bug
and  eventually skip the related tests?

Cheers,

Paolo


