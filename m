Return-Path: <netdev+bounces-245969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48190CDC4DE
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 14:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 418E1304A2BF
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83A82F3614;
	Wed, 24 Dec 2025 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMUq+Muy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uNMtlKXN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE932E738
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581283; cv=none; b=YwA8pnTvPSUqO+y4Uzwip/8okkc76cxiUuAjeOHHbWSf0s3kloJ8SssHH8VGWqfY8a5nvTn6V4DYSY0VnlsoAuDYt6Dzm64jBt4Ts5DXtsDQavjzDpW+gxVAUmAtMGZRPB8VdtLjKidT167D1H0/G21K5w0Vs25eRKGQnjWxiVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581283; c=relaxed/simple;
	bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIQ/0Elmmv5kMumUXofScKeIb1Uk4NINp5PKSX/NxsCYyMWayZmJmkhHZy2+sH58aqh96ROWck5Tw93NRvPsNhOURjDrjc3Qa1gLAxLQVBiEs6WWT0sPVSgfEETZ0FBcEyhJaJ2YDIzSZEGR4Tn1BeTE24YbI0mKlonOCOpM5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMUq+Muy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uNMtlKXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766581280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
	b=HMUq+MuyGZHA6d99A+C6BhSX15Q8YXI7cATgLlfkJI/nIcgUowfSGjMc1wMh0OI8sfUd4G
	0VppZ/WzAyX5R8LBBguLG4ashCJhnI8TTObn+w2k4Yl05v11rku8nqth6dGnzuu7Y7wmnw
	HdlOxO7xvAgEqFY1hi7PrY3OL7dwvg4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-rtGNt1GtMnu1lNKjCw5T4g-1; Wed, 24 Dec 2025 08:01:19 -0500
X-MC-Unique: rtGNt1GtMnu1lNKjCw5T4g-1
X-Mimecast-MFC-AGG-ID: rtGNt1GtMnu1lNKjCw5T4g_1766581278
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso57717845e9.1
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 05:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766581278; x=1767186078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
        b=uNMtlKXNNG/lVwjdQjqTUwZPFSWRlFQpHTOF0uphMYaQKf/d/C7lSmZDkUCJOFAson
         9ac5Ekf5eRJRCTZmwMZ6F3EMvIxTZLrhD05Rn918KZP4A2xl4mIe4K/7PeBMYBoquE6Z
         QjspJV/d5vPuMqkA0jDsr3nR4+GJfDpflJ7IX3NWbDE/11IPowFo4UMVsW0q8jGvxLH4
         E9II5bWbrrh19qy5G5+7dC0vzeaCZ7y9SGjUrMN8fTaJ/z931MxXo1pL1NaF9Y+l1D3n
         LcSvPDkcSLvsZpkoDowQn1FNfDGmsq1hazpyMLfgyA9qEJ1w15RUlPmP7RQXRD93fT9O
         lD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581278; x=1767186078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
        b=KKx/UIxuh9A0DgUDnIS+gg2gJC1kQ/IsqyoED8ObcSyZdKdI5w9HuoFqxlyk0UfHQO
         3xYo7DAzQFTXfH32/w81pEVYv/v4/9kDQtSlCEZvqlCHVhmoEO8Uc8GDytvycRO4OU54
         WCz16ab7xGncscgVzE3bnRRpMrrZRxEeKB6DFZoPJhNgEc6an9TZOZJ8yomOywy8h7jh
         m01nn+MbSFnTYBzSr7i0vdIe+7Aouwtn4uoTmMlR7awqZv0/fVNUXBpmNtghOFsTnVNW
         mBE93u/Cn9E6+EpU5KTdj7YCw8kUIjAK057Jt3eVpEIP5ttIT5ncor1kSS6UZzmyfazT
         Wz5w==
X-Forwarded-Encrypted: i=1; AJvYcCUekGcdgOgLcOL1YmBxrSG+Agaa/ASDilNyp50sc1xbET0SmDDfcTA4eGz7z8LZUmxg8m2pHps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4NASFMJRJ/rKbB3kLGdA8eY1sfk9RkXc2JPKH0nTEkOlDXIip
	re1K/5WUx5+5QSSSVRf7XCMw4+TA1A3roz5DOMPav8ByTp/3RvHuLaZbmBRLfLLJ15g7hTfF34R
	hAsP2RfqSsgRLW7Vku4Bd371DpnR+4dsTg1KjAwMUu1MkYbiTwgMmJULcng==
X-Gm-Gg: AY/fxX7iToP8M29a/AfdsA6g3QfH5geGvvQY/jPJB0wIprSSOA4w8RJMTGaah4Xkm2f
	2ZUkdRG+0h2p57FOLlUbZguXr5XsHSsYJQmQUspPrVeaNHcR4u3sDa9d95+BBmMd7ta5hbUe/Wv
	4k8Z5N+03Z6JLaaF5rWDQOQF0AGraVrfZeVfNTD4KmXioZJbjfDqkZY8EhmfjHs5h3YPaM9vyq7
	oWFtwdGw4pA1T0DL5Aa7fdg5niqogi3MQlbymB/0NO3gH5XxL05bj7htT/KQ8zd4Yl452lMkGfw
	/s2cfStHM25haSAoAFPGj76X02SwhaaEhWRndMqdBaWwZQrKs9sf3DxSg7IGULmBDDi/TqQiTl0
	Cv5uq2Qf99WNIVAzQ
X-Received: by 2002:a05:600c:3508:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-47d18bd57bemr161759405e9.9.1766581278030;
        Wed, 24 Dec 2025 05:01:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHybeuqcZcHlfztr3bbKh1cFE8NLb3cLhTczAcvHp67h5Q0r41aRhsvZBwseTxwsTVGzvf/GQ==
X-Received: by 2002:a05:600c:3508:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-47d18bd57bemr161759125e9.9.1766581277580;
        Wed, 24 Dec 2025 05:01:17 -0800 (PST)
Received: from sgarzare-redhat ([193.207.128.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272e46fsm339791035e9.4.2025.12.24.05.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:01:16 -0800 (PST)
Date: Wed, 24 Dec 2025 14:01:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
Message-ID: <aUvjj1HyEG6_hoLR@sgarzare-redhat>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
 <aTw0F6lufR/nT7OY@devvm11784.nha0.facebook.com>
 <uidarlot7opjsuozylevyrlgdpjd32tsi7mwll2lsvce226v24@75sq4jdo5tgv>
 <aUC0Op2trtt3z405@devvm11784.nha0.facebook.com>
 <aUs0no+ni8/R8/1N@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aUs0no+ni8/R8/1N@devvm11784.nha0.facebook.com>

On Tue, Dec 23, 2025 at 04:32:30PM -0800, Bobby Eshleman wrote:
>On Mon, Dec 15, 2025 at 05:22:02PM -0800, Bobby Eshleman wrote:
>> On Mon, Dec 15, 2025 at 03:11:22PM +0100, Stefano Garzarella wrote:

[...]

>> >
>> > FYI I'll be off from Dec 25 to Jan 6, so if we want to do an RFC in the
>> > middle, I'll do my best to take a look before my time off.
>> >
>> > Thanks,
>> > Stefano
>
>Just sent this out, though I acknowledge its pretty last minute WRT
>your time off.

Thanks for that, but yeah I didn't have time to take a closer look :-(
I'll do as soon I'm back!

>
>If I don't hear from you before then, have a good holiday!

Thanks, you too if you will have the opportunity!

Thanks,
Stefano


