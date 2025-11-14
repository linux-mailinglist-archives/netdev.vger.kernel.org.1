Return-Path: <netdev+bounces-238747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB8FC5EF7F
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C14335F995
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052592DF71C;
	Fri, 14 Nov 2025 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEL+6eZl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6C2DCBF7
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146469; cv=none; b=qIvU2dqX1Yke5qDXbhe1IAbj5uMCfdF1NeHupFtOHXQWuClMJupcgu/fptEXBGpl7Xv/8ZC8vf6VXnDm53Y837X3NrmjjMwUzC4cRJQ40vEXFpsqjGKD3IEWMgDq9Ot+QitZQl697qvigawJDVHlvvLMBBZFMT4cZGNJwtN2pbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146469; c=relaxed/simple;
	bh=WupAXsUwOqm9N8aItz9IuraBGtbt6+1ogwOCXXBfEo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3wVb/FcGCDX3mw+nIrXF9AM/QJ9GsecJ3sZUiJR4iI34ErSV0RmKNaYIT9Fki0tZ8T8sq7S3yd//di8yxbsTw2g97TCxqPExS6iIm45zGtHiUILicgwV4FObYIK8FvDrl41WRmijHSHc2TmfAnf+d+wuXBRCI8sGhu0zzPgVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEL+6eZl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47774d3536dso20353955e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 10:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763146466; x=1763751266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su/3DTeyEOfiuZEhYMJ4B5Ixwohi82QW36MCAtfZ6Mw=;
        b=aEL+6eZlK4ykBqffMe3TD/VnapzlEsaQbb0yxH2J1mLnTVjO5d8Hc6pBR4rbiXLHmH
         PPQBKL54zRgwtoBoIz1mFkZhb/TdhlpVMctKC1YKQahnWZR2RAStF2MtBXtO63ztfOqt
         tu9QFdgEJ4gaZ8lDw3xeiatveZhFEEdrpOo2duE7o7Ybwz9EjXRGzU1UOz0UYExB0Qfo
         BSlR8vWJKbNFxIE3Vzw6dRL6W5YwM3iRo9IGH3aWWWzvD9QUJ1PRgXexri4LHBp7jANG
         QbRqJ2KmE0zMMjtnGGgQtz1UsCMZlcaiUOMzGUb5/pBbvpkYuxpWPycoOfySc5MxHoHE
         8L5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146466; x=1763751266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=su/3DTeyEOfiuZEhYMJ4B5Ixwohi82QW36MCAtfZ6Mw=;
        b=UsGPR5PX3hfbK8+jIjB3AtVpjZF7aFsn0NiohUTYUi5BDAfHSXOyf2VIkGIkjJsvRp
         X+6M/2BPofPizc+BIuSPFE7b0f7OwJ73Z0CZ930BZPGWPVN5X0fqTFSiyTHW+bb27r/8
         T2GPrMAcQ6G5m2D0PaXQV13afb2DDv3BKVoYVBE9D4AAgTQpfQBptGCzD4buB5nobwi3
         YOf1WyE5+IIV5KGT0HTIqdWe6FkPLBkplZRe4blPoo/D/UHWAk3eq27gSncFLwGkA4A5
         KjW0L9ZqUKFToGnFYFVkhP1+mWT3PK2X9ykkzJhjmhvJICRM/7WCHP7eMJNefFhSSY8J
         rbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/ni7ia9paFDs6z9UuxSsgA696jx6NXyYZhlv9JXiSqLEN38Ya1mHQ9IV2iANi+h529fE5lGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Pad6+2nOiHTT8XMdFUR9UhW8SoVf03oZkQ5ay83INax6JFwR
	2TzW+1FOGRozwwyKC9tgjSQUxDDfVLjOhGaNaqXoRHCDnIvu5RiqaSPE
X-Gm-Gg: ASbGnctjH8P2yvGW7qQa0liK/x/A0yAg8ADOtPKYrKviP1TnHjkEtrzatCVA0RC9o5K
	nWMNKOznPk4AYJR+qYMdQGigLPmsEK+NHvBQcbfSlcyO6rR4QpRJ8BSpCsquRjIFfYKO8RdQbRp
	kh+fBAuZKsgLwfXKgIuJNHBHTIa3HNuK7whYm6KuIDAwhUfoLXHsSi9AnTS0HBH55EljcONxwh+
	mXlxwoZnPSSOMard/jBIWN1ytY2XmWL6TlrAIj11wTn5xGCCbd91UPh1vRvQ4uTTG10Q47mydJE
	U3/3rG98qHVgtvzhzAQBxCfcW2pvMH9TWqAGu9BUV/LQFweVb1xauZfbg686YsVtVYid0BA6az2
	hm6bP2l2Qmhg77+cPF6YUA9rc8O7M7FJW/0zv1Fq+ODV1GPcS6qfsKuIMNS/9qXdmbfA3DfC095
	oJoJdDzD6RyjYAhNE6M6Uk0FdG3dkGEiGuv9veYZc2I1sxj8OaXbvzbSRt/WYn/Mw=
X-Google-Smtp-Source: AGHT+IEZk9USqhXcykeqQxv6BBqPJ+Ckp0QcbH6DW0s45+kWxw1D0bAUF1znH554QTmUBF8i4qIoUw==
X-Received: by 2002:a05:600c:6002:b0:477:8895:303c with SMTP id 5b1f17b1804b1-4778fd807f3mr32662695e9.3.1763146466154;
        Fri, 14 Nov 2025 10:54:26 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787ea39ccsm156460775e9.15.2025.11.14.10.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 10:54:25 -0800 (PST)
Date: Fri, 14 Nov 2025 18:54:24 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Sean
 Christopherson <seanjc@google.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user()
 and put_user()
Message-ID: <20251114185424.354133ae@pumpkin>
In-Reply-To: <20251113005529.2494066-1-jon@nutanix.com>
References: <20251113005529.2494066-1-jon@nutanix.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 17:55:28 -0700
Jon Kohler <jon@nutanix.com> wrote:

> vhost_get_user and vhost_put_user leverage __get_user and __put_user,
> respectively, which were both added in 2016 by commit 6b1e6cc7855b
> ("vhost: new device IOTLB API"). In a heavy UDP transmit workload on a
> vhost-net backed tap device, these functions showed up as ~11.6% of
> samples in a flamegraph of the underlying vhost worker thread.
> 
> Quoting Linus from [1]:
>     Anyway, every single __get_user() call I looked at looked like
>     historical garbage. [...] End result: I get the feeling that we
>     should just do a global search-and-replace of the __get_user/
>     __put_user users, replace them with plain get_user/put_user instead,
>     and then fix up any fallout (eg the coco code).
> 
> Switch to plain get_user/put_user in vhost, which results in a slight
> throughput speedup. get_user now about ~8.4% of samples in flamegraph.
> 
> Basic iperf3 test on a Intel 5416S CPU with Ubuntu 25.10 guest:
> TX: taskset -c 2 iperf3 -c <rx_ip> -t 60 -p 5200 -b 0 -u -i 5
> RX: taskset -c 2 iperf3 -s -p 5200 -D
> Before: 6.08 Gbits/sec
> After:  6.32 Gbits/sec
> 
> As to what drives the speedup, Sean's patch [2] explains:
> 	Use the normal, checked versions for get_user() and put_user() instead of
> 	the double-underscore versions that omit range checks, as the checked
> 	versions are actually measurably faster on modern CPUs (12%+ on Intel,
> 	25%+ on AMD).

Is there an associated access_ok() that can also be removed?

	David

