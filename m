Return-Path: <netdev+bounces-179249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52832A7B8D2
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A489B188F4C7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 08:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0EB1990B7;
	Fri,  4 Apr 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0nabsVh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9618BBB0
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755214; cv=none; b=qwYA8nlP5bGGMTj7BI9OPg3zl4aKXMwwS0byYDXV0E54IAyF6iiPQC+KvHVHnQCV1iM/UPhICfjrk2ZFxNUHxtXSQo0JvZNUKBkI+QiECVrNpPqk0FcS2iDydwB4J+/04QUQygl5Oc2LQxxbJAPtxqV4eAeN3dBKLMBVLv7xWt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755214; c=relaxed/simple;
	bh=mxOPmaHNNmijVfz1CVwVMXGKnvkZakTcfnOKolxNCzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY5bSdtrWUnRQ7TV/uElYbIYRDZ8XqnvDxdESo8bgo8hp8/XU7281rIKsN23P8ULZLFRkd/wPXvrOVjtBm6R/rEjM1GNRmFVqtYCGoRmQ8TmaNhVB/UmDjnIhUtW24rgihn+buSUU3VUE2JnBow36OVliJNwE1LN7TlDPnC8l0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0nabsVh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743755211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3R/FwwTm36lOogPDfsrJ2NATa0Y/PG/vq80IpIZYTw=;
	b=H0nabsVhaUISUFAFrxSr7tyZp02dIqD0zbf9+pVeYc7Aeu530oppv75XuWfqdo6KqtJIXv
	4Yxwar6WNY5XonrGO0zn2x7otMWJkwJmbPjOABBvwtfuwno1lgOcbCveIvYGVsWGfe+gG0
	gVjZmICGpCsZFEtKn/ukuV9FmSG7nP8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-swKvfrO2OziINiskIwbT5A-1; Fri, 04 Apr 2025 04:26:50 -0400
X-MC-Unique: swKvfrO2OziINiskIwbT5A-1
X-Mimecast-MFC-AGG-ID: swKvfrO2OziINiskIwbT5A_1743755209
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39979ad285bso1063881f8f.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 01:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755209; x=1744360009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3R/FwwTm36lOogPDfsrJ2NATa0Y/PG/vq80IpIZYTw=;
        b=KYAuU76jfpTGI3e2mBNVxHjtNcQu38dRCu/p1QmIC7ov+V9X2WwBGD6wqR/H/vMefN
         /j/r2ilL2uxY8iVVygP6aEmNYA06NEoummlcOO3LCBSFYvSUWOd2K6RHZSAgGTCcJpFi
         fxsxYnWD1A+JaPotrStMx1CjeXeK9Oo2lyWrJw4Xo3ZRmGVLoa6oraLy3eMoHfFK32lT
         7+Kkze5vgHiPU9yOuK0fgX2e5cKh/TV3tIdY0dNRLsd0THvcRwbH5w9lrfPaCCiPdkYi
         lGEIcAVH4hFxPs1Lk+zJKo/P1mRTLpAnpj+QHxj7BcrFHsuz9xYLQspWtukTWyzGzcLf
         ++Xw==
X-Forwarded-Encrypted: i=1; AJvYcCV8mfvVzaZt5YE3ZtXYDqerbTwAkMqce9M7WWGfROOdQf1b+hAp8YngUFDsa/GGkM2qXpQrPz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzblkaSVEjDP80VCocVHkhwGtRdUzbuFfREyQgh8792FAcYWngs
	MMQHqSDRTe51MIE/IPaeP/4CG8TELVK2GtYDTESGWzY3zNOtNZ4OD8hnP7hdCDCqs4v+4YEIj68
	g3pJl0HT3Btu/xHslGawC3PYATYApj21HDgEgpylx5HMj49QM6oW9Ow==
X-Gm-Gg: ASbGncub2cMGeomyT+WftUxAZKzdv85YTV6A6cyQNO++Xnv8NctKJ54m8dIDmJZwaFq
	+H+l/MxJfTr9AxxVO7Ytfg2OygFA3kNCT7hsXuHF6jo4Gf3ep+6Gup8RApJgBhJfZsESGFQWEI2
	Uk0T3seRjc4sCRMJFAjjZAdf587/gxV7tbwhy8zCYMaaC2jWuVjQ+ASgmirFpaP5UPe9ANloK+Q
	K+BwH7SiJlZMkxBcpsDhxW7aTrgcvAtuSrLtclrNDFWU5zyQSplHv5t9x3KTMu478oY7SzX5Cb4
	W4DZKNl0LA==
X-Received: by 2002:a05:6000:1845:b0:391:3cb0:3d8d with SMTP id ffacd0b85a97d-39d0de179e8mr1425008f8f.19.1743755209062;
        Fri, 04 Apr 2025 01:26:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFry/je4DWnZKjNa0BdbFTTJdiIP/YGNaOLTb1x67wtVqnOvUq7clsozKVFoIyWoDydiJxwVQ==
X-Received: by 2002:a05:6000:1845:b0:391:3cb0:3d8d with SMTP id ffacd0b85a97d-39d0de179e8mr1424982f8f.19.1743755208677;
        Fri, 04 Apr 2025 01:26:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b8ad6sm3848446f8f.56.2025.04.04.01.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:26:48 -0700 (PDT)
Date: Fri, 4 Apr 2025 04:26:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Torsten Krah <krah.tm@gmail.com>
Cc: virtualization@lists.linux-foundation.org,
	Markus Fohrer <markus.fohrer@webked.de>, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Message-ID: <20250404041708-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <4d0c0cb9e9d513bf9ba81346ea72c9e58359ff93.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d0c0cb9e9d513bf9ba81346ea72c9e58359ff93.camel@gmail.com>

On Fri, Apr 04, 2025 at 09:59:19AM +0200, Torsten Krah wrote:
> Am Mittwoch, dem 02.04.2025 um 23:12 +0200 schrieb Markus Fohrer:
> > When running on a host system equipped with a Broadcom NetXtreme-E
> > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in the guest
> > drops to 100–200 KB/s. The same guest configuration performs normally
> > (~100 MB/s) when using kernel 6.8.0 or when the VM is moved to a host
> > with Intel NICs.
> 
> Hi,
> 
> as I am affected too, here is the link to the Ubuntu issue, just in
> case someone wants to have a look:
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2098961
> 
> We're seeing lots of those in dmesg output:
> 
> [  561.505323] net_ratelimit: 1396 callbacks suppressed
> [  561.505339] ens18: bad gso: type: 4, size: 1448
> [  561.505343] ens18: bad gso: type: 4, size: 1448
> [  561.507270] ens18: bad gso: type: 4, size: 1448
> [  561.508257] ens18: bad gso: type: 4, size: 1448
> [  561.511432] ens18: bad gso: type: 4, size: 1448
> [  561.511452] ens18: bad gso: type: 4, size: 1448
> [  561.514719] ens18: bad gso: type: 4, size: 1448
> [  561.514966] ens18: bad gso: type: 4, size: 1448
> [  561.518553] ens18: bad gso: type: 4, size: 1448
> [  561.518781] ens18: bad gso: type: 4, size: 1448
> [  566.506044] net_ratelimit: 1363 callbacks suppressed
> 
> 
> And another interesting thing we observed - at least in our environment
> - that we can trigger that regression only with IPv4 traffic (bad
> performance and lots of bad gso messages) - if we only use IPv6, it
> does work (good performance and not one bad gso message).
> 
> kind regards
> 
> Torsten


I suspect it's something weird on the ubuntu hypervisor side,
supplying wrong checksum offsets.

Can you stick a printk here:
                if (skb_transport_offset(skb) < nh_min_len)
                        return -EINVAL;

printing, on error, all of: start, off, needed, nh_min_len.


Also, what kind of device is this? QEMU? vhost-user? vhost-net?
Thanks!

-- 
MST


