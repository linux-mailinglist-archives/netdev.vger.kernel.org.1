Return-Path: <netdev+bounces-148142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FA99E0869
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11742178F33
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B23570826;
	Mon,  2 Dec 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqNM5ShY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A4813B5A1
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154908; cv=none; b=TqKb3nBdA/Qh9trwRVbZJUJmHnQPC8SS5Ul1/Nps3shvcuyLRfEM0ulGeLZYVYFM5Nptu3oV5q40/CtFBtRrOlOxxNPb9m6Wpz9mJeu3ffy43SAGAYa5DKBwZEcMSQFv8nzKa2Bt9TFDkkXP8Qdgu1D6S2CsJsDKXUxY+VfFL2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154908; c=relaxed/simple;
	bh=adL+2LkQ/+XNO8hCMwqPkqXMk3kCQCPZ/eITVwvvJb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4GZuGrBTp4IN6VKVcutKmqfxpWg2GxNi2/ML0LRz7fn6MHkQeYIj3yvg06GaChWVmwOrUIsKGcA8vvIehKHDZOcTs4Ww2VIhP7wLXTeKgXMYLfJvfz+zncwuEoQ85/PL77o4SaUYUvOvw4ll1QXCNPiBh0ldtdHnhKYhgnTtZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqNM5ShY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733154904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kMGz26Pd93vereCLJasLGT8lvdI6LqnhcQp8tpVjo7A=;
	b=SqNM5ShYvV6+eu1QTdo3u/T+BqF3c7YSDSqERRxWpuagGrQkDQMcPJxRaX/L/6k2+Uq//i
	6elW0VAc88cjUN1eIwzxZUkSNd2vViNW/QHjEEyZVfJx2ALaZtV58BwDXwYY1Pzp1W1DUQ
	V6y7DYb5P51nbXw3hF11DXmTPZWTKug=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-DIbKtX1aMi6byiWKrdLGWw-1; Mon, 02 Dec 2024 10:54:59 -0500
X-MC-Unique: DIbKtX1aMi6byiWKrdLGWw-1
X-Mimecast-MFC-AGG-ID: DIbKtX1aMi6byiWKrdLGWw
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d889fd0fd6so49333666d6.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 07:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154899; x=1733759699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMGz26Pd93vereCLJasLGT8lvdI6LqnhcQp8tpVjo7A=;
        b=MkZX7wLcS7O2zdpdSrR089kWicNsKoQSo+9KC9cD7ClHtRnLosE8J5WtzZWkE4F37O
         je+CzWHm32ZECTf5jHbsGvcX68R37mSPnpXrZqTtZO6PRjYPnkI4ruEk4cNE/nwXb+6m
         k0pMwEKEzMn/RUj/cc2GJHGuMzA35mr2lDeqwhsWBF8rANeaL7T5CH+t5ZLLEWF77/xD
         owPtPThQ+E+oJa0yWRyb3hQSn49m1iwu8fRMJRFZgHWP4mIDshr26+cTmGarD/iee+5I
         vuI7U87l4eoBXvbT7Th/NWmJTVFoJHP2ro2h8eu+GUAIRRDBy6HVDUQNj22OrytIftGB
         fPpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV27nKzMwygOhxFJDqSchDnreNb2gSqXN4JyAZ3198nOTpunwI7KhVhRemrN8TPSP4S9WaCS/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRXm4aoVvMV4hINf9kreZb5TaPTjcqBvhQRGiHJe1t4Sot8Tgp
	eTcHb/d4pKbEtIkqPQId37lwU2QGAmtUtO6mJRMlcRMp2g3yypHj+X2zjt68MjIf/bKqSVSuj1s
	HcG+IQkU6wdjy1GR+giXYNE9o9/PF4YOeM94oWv31n1nKaLFz2WQL5A==
X-Gm-Gg: ASbGncuP+ZQtUIb6Lo6bQ9OYM5hsExRwwHly7CFDHZXEK49b0m8kQOikh2YBaxl4m8x
	8sCsNgR9diu6QsQkQyAS+odeZTc4bnOK9RQqmGld13mD8WyWiT4274mhFSceSAcryNrjQxKTq9c
	l5udw1aKSEiDH2ktIcQw8TD4h0vyjImFFQCs2pYkJpW92xVMTShvPv+VDAZXAb/bd834+zoWoch
	TUP7ofHw+Fm98Ewxf9m8SlrLjHQgbgO7q7jZtBqexzzKlsogBm+XK3HwN0isv5EBzVgnI38khbR
	I6gxUa8j7+eOkhbuqJgk9KEWPA==
X-Received: by 2002:a05:6214:dc7:b0:6d8:88c2:af5f with SMTP id 6a1803df08f44-6d888c2b26amr293838726d6.1.1733154899431;
        Mon, 02 Dec 2024 07:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoviEDi9BXOJucZNgaChi7PR0dT2tjGFWFCa8hO2q8Ph+R9/XOCu9E7Ze6AFBWJMiaAnRaBQ==
X-Received: by 2002:a05:6214:dc7:b0:6d8:88c2:af5f with SMTP id 6a1803df08f44-6d888c2b26amr293837866d6.1.1733154898907;
        Mon, 02 Dec 2024 07:54:58 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d88b9e6a69sm35208006d6.60.2024.12.02.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:54:58 -0800 (PST)
Date: Mon, 2 Dec 2024 16:54:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v6 0/3] vsock/test: fix wrong setsockopt() parameters
Message-ID: <cskeunqjcpywlrkldqw44jpwrrkear46symgk2kucpljsx243h@m7pb7cwvu3yz>
References: <20241113143557.1000843-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241113143557.1000843-1-kshk@linux.ibm.com>

On Wed, Nov 13, 2024 at 08:35:54AM -0600, Konstantin Shkolnyy wrote:
>Parameters were created using wrong C types, which caused them to be of
>wrong size on some architectures, causing problems.
>
>The problem with SO_RCVLOWAT was found on s390 (big endian), while x86-64
>didn't show it. After the fix, all tests pass on s390.
>Then Stefano Garzarella pointed out that SO_VM_SOCKETS_* calls might have
>a similar problem, which turned out to be true, hence, the second patch.
>
>Changes for v6:
>- rework the patch #3 to avoid creating a new file for new functions,
>and exclude vsock_perf from calling the new functions.
>- add "Reviewed-by:" to the patch #2.
>Changes for v5:
>- in the patch #2 replace the introduced uint64_t with unsigned long long
>to match documentation
>- add a patch #3 that verifies every setsockopt() call.
>Changes for v4:
>- add "Reviewed-by:" to the first patch, and add a second patch fixing
>SO_VM_SOCKETS_* calls, which depends on the first one (hence, it's now
>a patch series.)
>Changes for v3:
>- fix the same problem in vsock_perf and update commit message
>Changes for v2:
>- add "Fixes:" lines to the commit message
>
>Konstantin Shkolnyy (3):
>  vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
>  vsock/test: fix parameter types in SO_VM_SOCKETS_* calls
>  vsock/test: verify socket options after setting them

Sorry, this series is marked as "Not applicable" [1] since we forgot to 
target a netdev tree (net/net-next) that we usually use for vsock tests.

Please can you send a v7 (carrying my R-b) targeting the net tree?

You need to rebase on top of net tree and use the "net" tag (e.g.  
[PATCH net]), more details here:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
Let me know if you need more help with that.

Thanks,
Stefano

[1] 
https://patchwork.kernel.org/project/netdevbpf/list/?series=909319&archive=both&state=*


