Return-Path: <netdev+bounces-160528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CDDA1A0EC
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F3B3AAB66
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2D20D4EE;
	Thu, 23 Jan 2025 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlmG5YL4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54E20C48D
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737624967; cv=none; b=ZSg7CBcUwftp6vlP/lp8R5P4+o+y3Rtl50s2kB3e3Ska9AAIBSAuIIZINgF2Wl4xYDYZMUTcA0WWjdcwVbqUYZIpEU+ysA/e4/r4ZnhJWWC9K0eRZC+fqQ8fkbbiVzr/pB8HV41g+M1OLvkdEte2uV+zo+yI9TZxyCBDPXXGTjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737624967; c=relaxed/simple;
	bh=dqawR7XNzIGe0xKiLtAeHwJKbpEBmKW8gR9cV5OZiSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJAnnx4H+9lJJW5deM5KPX7MN64zzbsFjdhI97e/eaql1xin7Irpqj1nEdqNF/PJxNdfYmu2iIHNSy+XZ5hdwzYJls5Wm2qO9bnHFytLAbhSl8K+EDi6i1DtkfLQIXE8xYFLlSbK1rt2K2qtPDiTm1E7zBN2o3nxqXDEOCDddcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlmG5YL4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737624963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnYFcRPw5BnzfejUEGROZP2MFra+jRL2jq0Ys6OTnCE=;
	b=dlmG5YL4tR6xLGi9A0mBVD7aDKfjkh32hWjQrPXE6VxLyazRH/OHa266KZ/QsRsJM7eFEH
	pKxFfEgu3FFL5E0UzuyAy1jdztlYF/MTS6FldHswzr4OSgHSiFSeN0kfCzf72XHbFJObOF
	Z0mMcpCS2T/jmV6ZM6F8NeghbB7/5K4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-yOyJ1mQqPNiwzp7fKn4vfA-1; Thu, 23 Jan 2025 04:36:01 -0500
X-MC-Unique: yOyJ1mQqPNiwzp7fKn4vfA-1
X-Mimecast-MFC-AGG-ID: yOyJ1mQqPNiwzp7fKn4vfA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43624b08181so3620585e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 01:36:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737624960; x=1738229760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnYFcRPw5BnzfejUEGROZP2MFra+jRL2jq0Ys6OTnCE=;
        b=Z/w0N3A6aRXJ1VA7F4OMeaA7/RCBZJ6f7tKg1ODG5UdVREDPJnUwlIiMDb2RkQmNRJ
         MDPlNKswJ1ou3gC2aRSr9Y/WdQ+2V1qeV2J3yKHmATVlTb7HAVtrZBVuMcwsmpGgvfsj
         YHS+JcLid3jvIsRkba5sGgn/iqmnidJ3JCD8GLJPyduOkMc/8Cucju4mMmNuLep04GtL
         9/XGf7nRJm4QWhH1p6t4QmwGBmQmLrR8A5nEfqUDiPqCetD6T4dg/yyMdVxKYmC+0UhQ
         C1bH1nC5hHylKhUzZtQS0du9XIJcVOTtchX03P6Z9LPmEiXRSF8+iy0Gqk+knxXdS+0L
         s/Ag==
X-Gm-Message-State: AOJu0Yy+FQgIcO7+wfnftdNeT1zySlIZXoy8uM+BAI8mpiBzCJbFqemF
	a/fkIvgdSOT8vmeCvOdP4wdNFW2qdqIwYHNBLXmD7gEyydvHRvJDNbheUiroW6wwsTmL7RnLARI
	x68pSiJewunOMGUFZ8Jf6aKvyafr71Z10e/CUfJDV9yvci4rU6k5hJA==
X-Gm-Gg: ASbGncuuGxEcjg0Nq7sKKld3KpR1/1X3vNA18q4VRMGjDrwsPN1oxOKjdiI/D8gnujh
	sxwmZpoH8B3g6o1F5l6D2cYPOmDLjK6rGldUwx94HzoOfe3blmq6tGH3FRDGlrAS7pPh29v0jkI
	qBHOsON/XgBoqdj2QQJMhnWlG/qHFwbgbzwUyn/g3eF2r8i9qiRfmDJlQT8aTr5Ge+7NqARbfjh
	vs9zFf8yGWlQY6k5RskkLu6xtZQWyOuhjLbETDH36lJhyMTK7IrIATHGA/r+YvEYauNUXIcRa61
	n/i425wklrRfOzcV1N21lWYH
X-Received: by 2002:a05:600c:1d0c:b0:434:f9ad:7222 with SMTP id 5b1f17b1804b1-438b885652fmr22198705e9.7.1737624960113;
        Thu, 23 Jan 2025 01:36:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEioYh+fOt8E8oEIKF32FkxJEk+epzAyprXFxCf2o/rfVP//pqtUxaTni9qOyL9m9HdyOe9YA==
X-Received: by 2002:a05:600c:1d0c:b0:434:f9ad:7222 with SMTP id 5b1f17b1804b1-438b885652fmr22198425e9.7.1737624959693;
        Thu, 23 Jan 2025 01:35:59 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31a0f47sm54375985e9.15.2025.01.23.01.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 01:35:59 -0800 (PST)
Message-ID: <a194d683-d97d-469d-b016-f11bfad5aba1@redhat.com>
Date: Thu, 23 Jan 2025 10:35:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ipv4: ip_gre: Fix set but not used warning in
 ipgre_err() if IPv4-only
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <67956320a8ee663f2582cc75f0e8047d69da5f6a.1737371364.git.geert@linux-m68k.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67956320a8ee663f2582cc75f0e8047d69da5f6a.1737371364.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/20/25 2:12 PM, Geert Uytterhoeven wrote:
> if CONFIG_NET_IPGRE is enabled, but CONFIG_IPV6 is disabled:
> 
>     net/ipv4/ip_gre.c: In function ‘ipgre_err’:
>     net/ipv4/ip_gre.c:144:22: error: variable ‘data_len’ set but not used [-Werror=unused-but-set-variable]
>       144 |         unsigned int data_len = 0;
> 	  |                      ^~~~~~~~
> 
> Fix this by moving all data_len processing inside the IPV6-only section
> that uses its result.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501121007.2GofXmh5-lkp@intel.com/
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

## Form letter - net-next-closed

The merge window for v6.14 has begun. Therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 3rd.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
---
Note: this is possibly somewhat borderline, but I prefer to avoid
exceptions unless there is something really ... exceptional ;)

/P


