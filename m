Return-Path: <netdev+bounces-227369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D443BAD2E4
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 16:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E27194060D
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC83043B3;
	Tue, 30 Sep 2025 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KydSVeP7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C8B302CC2
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242672; cv=none; b=PcL36mvm//gyTOwB9Yzd4P2cvNym4InIoiCc+hl1NA3Zx1xn4iWoo+AMXOSwpsW7sUIircxdngvzaNe3QMIyq0wectgYd1qB3YFZkRb93ZmNpvmPIx+NrVyd7wbuD79lAZ0AHmX1asfxSv3MNWdZzHO5b8I79+Br1UXl6qEbrw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242672; c=relaxed/simple;
	bh=TxtdYZk9dsFJydGVO6ymBCi05gQcE0LcJqQYcYklqBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFLxO52K1umkGUzqLBEoZ89ZNNXwkgBv6458yW3xEqc/V9kX/6S+TOvNCdjOicEbbkqmO/aMtoXgZL39ChIhHlptQpzPbSYu+QLm6LBPaUprdWKXDy6J91Qx4sGS4p9IOgqzE8v2LRNqEcANNm5EIwPjISmuc32RFYTvNysFbfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KydSVeP7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759242669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KiimNVQCGI88ieZh8p4IJZ/Sr9pCyj861BQTbYqy/Tk=;
	b=KydSVeP7FUpTz1x/TqD55RoSnvt+8dVyYU8NiXy6m3Xvpq1xuseNV2TwuPre5UVKoyHrCs
	O2xBo3PBhAULXYXrXgT+5NmMaKPICfT+dQfQl44+jB8lyfDRCktZPWz4qRk3TjBMLYWjj5
	jEEdUHkAWpUDPpPfh9yZcsFjnWUlJIQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-veI1pH4hPyyBdzuDxplyBw-1; Tue, 30 Sep 2025 10:31:07 -0400
X-MC-Unique: veI1pH4hPyyBdzuDxplyBw-1
X-Mimecast-MFC-AGG-ID: veI1pH4hPyyBdzuDxplyBw_1759242665
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e3a049abaso29875935e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 07:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242665; x=1759847465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiimNVQCGI88ieZh8p4IJZ/Sr9pCyj861BQTbYqy/Tk=;
        b=sBMdMpFgZTpVH8utQ6aJJ+TuouapWyAoC84eZknhu4WR7czUwM+XdjrV/oHmuo3FEM
         MSUtpC4uueL/NnCEyif33v8DcwDn7deWvxbEw+YXJXoKfOMkm94qBvtQ5JfAWRLfwx7q
         lx8MF3ZkVMHUYdnc6ihQmN1PIMJoDo1+ePfLGiuI4T1SgxaaKdFDUwS0N2U4eBK+aM7g
         M0NvRHP0C7KBTcHy5Fszm7ZwygY3ZADCQeGVFFKp/d6X9frxG5tbitDWB6DWBCAzpWKp
         DEy5yj/mXaJRrKDbgS99NhhRMGkX/IF/1kL/6tm2cWYfJ/OCZwlRYpp31ZJAEXpDPrHp
         zbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxlLkFBu7CaQmmZOQlQakuT/7aXCf01GfAdEmvboJGgJ6pGjNcVe+euiuuIrR+JVzWeVZQT8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpmtxuhdu6Nq+boJgnyg5+aOKeMUeVhkbseZI/4Mejde2NARut
	fpPhl2dX3x9A4lALEpmK4o0gIJsNZRkhCjxrAnOIzfpDmicNuSjtYR4XDpvzCySs1z+Y+GQothB
	EavpAq6YcviAfVUWGZtkAawsY5LeTR6gYC2yt5QBnC2JNUI9lblP/5iuhWw==
X-Gm-Gg: ASbGncte2xrcTxf35SDbWBOBFHsAnb6YLUEDlghnpAI9xm/w3jTk7dXDbcbNhYadB2j
	dYGIUqS0PlRikGzXAuviLxhatJfEFT4Q+T5fVvsEWi5qYqlysy8wUKtYooy0r2M8xhL2jwrG9ld
	HouplAKKhqnhIAVuUMxvj55+vDO8gl2P0q9JIfJGduO8KPfclye+aurJO+wGXN+3Q5YGf5FnkNV
	uP4PmBodyiiSgB795h9/Dh/k00uptiukKZNVlCeQwkDzDlZ50b7RHIWYnWe1tSorzdInFvMGINA
	KB2NGPsneVXPFckrtmt05XZEmNSNSv6T6Y7Y8kIOAW3usslcIevWGGb0T98NZpNhnjnJvO4HIZu
	SJkQM0oHN9xH9O8PPzg==
X-Received: by 2002:a05:600c:8b55:b0:46e:45ff:5bdb with SMTP id 5b1f17b1804b1-46e6120218cmr1302095e9.8.1759242664804;
        Tue, 30 Sep 2025 07:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVjdt+VONnfPWja9/VsLbNc3mnehERm9krtPABV0fyuDy+ajxw8o2r9+1p0b6nLCu4FSG8KQ==
X-Received: by 2002:a05:600c:8b55:b0:46e:45ff:5bdb with SMTP id 5b1f17b1804b1-46e6120218cmr1301575e9.8.1759242664074;
        Tue, 30 Sep 2025 07:31:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f3dc27sm68198535e9.5.2025.09.30.07.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 07:31:03 -0700 (PDT)
Message-ID: <377697dd-15bc-4a2d-be19-1d136adb351c@redhat.com>
Date: Tue, 30 Sep 2025 16:31:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] atm: Fix the cleanup on alloc_mpc failure in
 atm_mpoa_mpoad_attach
To: Deepak Sharma <deepak.sharma.472935@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, pwn9uin@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
 syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com,
 syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
References: <20250925204251.232473-1-deepak.sharma.472935@gmail.com>
 <54234daf-ace1-4369-baea-eab94fcea74b@redhat.com>
 <CABbzaOUQC_nshtuZaNJk48JiuYOY0pPxK9i3fW=SsTsFM1Sk9w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABbzaOUQC_nshtuZaNJk48JiuYOY0pPxK9i3fW=SsTsFM1Sk9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/30/25 3:33 PM, Deepak Sharma wrote:
> On Tue, Sep 30, 2025 at 2:15 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> AFAICS the mpc_timer can rearm itself, so this the above is not enough
>> and you should use timer_shutdown_sync() instead.
> 
> Hi,
> 
> As I understand it, `timer_shutdown_sync` will prevent any further
> re-arming of the timer. I think this is not what we want here; since even if
> we somehow fail to allocate our first MPOA client object on our first
> ioctl call,
> and hence end up wanting to disarm the timer, maybe on next call we can
> allocate it successfully, and we would want that caches are processed
> (which are processed for every time out). So we still want it to be
> possible that
> we can re-arm it.

Ah, I missed the goal here is just being able to rearm the timer (i.e.
there is no related UaF).

Given the above, I think you could instead simply replace add_timer()
with mod_timer().

/P


