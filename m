Return-Path: <netdev+bounces-185921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE418A9C1C4
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 10:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E4C3B7220
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F8825394C;
	Fri, 25 Apr 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="islUnSNc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79402253945
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570158; cv=none; b=uPNuekOnoVzQ8bOjWW3z6HTaNWmZJI5URU8+j+rEuAspJiaqY9JEk5LesdhxKOEAWLxHA4FkGImU/BU5SIMnjPxOVWlPG8o7BAelJAByeRQn8X2MNQhn0eg+bT391+QOOz/82TlWb8DxqYmp8Xhhiu9BMLLp4PG6BREdcy+oB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570158; c=relaxed/simple;
	bh=W0OGvNpepYMtQUI2P000WddWaGAaKqDLXnohX671FZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSP1ApYQcEtHDVzBTz6RyAmAa0sQAf7vjwNQsCkJSXRoaNcWveltV0hSkdJUojgN/EvdSPIylaeykZnQM5SaXGuZ1cJsiDrVb+tQ+kPZMFeK5nWvYvG/0M4W2X2GqTXSHfDJtqw+xYRT5OPgsB4KdcDqrYGMBLFFnKTXIWzyfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=islUnSNc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745570155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIpzb0kJnabV+/Rbk1AeDaWRoPqgDoiA6nLSqcAP3Qs=;
	b=islUnSNcmoHVw1oYCIr7DD1r5DIOY0N12VIVvTP6wxn0Umm+snMczVx2tSZytw3G8VrLle
	aj1hplCxbH8ma5y+pvLvB+iiS2FFc5xBBDUX5+HfaYPD0AoKhqYp7G3RSmkt2YPgk324KL
	5C15Z7D8U1r7O7wH2j+jsuwnZQgneBs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-ircMp0uYNaCgaFhVMAUJOA-1; Fri, 25 Apr 2025 04:35:53 -0400
X-MC-Unique: ircMp0uYNaCgaFhVMAUJOA-1
X-Mimecast-MFC-AGG-ID: ircMp0uYNaCgaFhVMAUJOA_1745570152
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so8644955e9.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 01:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745570152; x=1746174952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIpzb0kJnabV+/Rbk1AeDaWRoPqgDoiA6nLSqcAP3Qs=;
        b=rttZ1x5pnVRRcx3TlaELhs5pHDJefs2H76LdrhEx25c7OhstkXpSZZ0n/BINH4J0g+
         kt1fFWg4VMIc+fEqLekp5y14yxj2cHi18+qSZy1aA2syrvJGlxg4paZxu1xD3tSShWgY
         lYOeo1lQjwpLz3OCsxWxtS/caZi3aDs83z4uyBpuM31CAXfJpy+HWnUNZ/F6+H/nTDPI
         joY1IoG5Sf5z7VZeCQBxE+4epsKOJg/ZptnnxYxrFoJjBe15r6Ka8xsGXJVvIul/nhIT
         gi/KVgd+Z/cLH/qLSJBux6WlvgBe2q0rrILjOZrEUCBxDhoCzcbB3dbSPtI/GpBvZRwI
         3Ohg==
X-Forwarded-Encrypted: i=1; AJvYcCU8g5qQp/PhM3HJpiTbomkw2RlPGfw3cQaSA5/hckX3WKvnmBJK8TVWntWLIBOfhQjduKn/Zrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHRlabTmbuoOIXxUmW3WxYYRuM+O1AI26VCMjSS7SfUx0OB+FE
	g6upRCxOFtiH8KWSo4ysd+0HFYwAkfAJMj4GmQZcQafwssoRLMRwpZ2FHEsBB/5230967mOo+DT
	aDYbsLKYQBPu61alylvKnu2iGQEITBEuwMKjKt69UZKm0WlQVcbgdyw==
X-Gm-Gg: ASbGncuGPMrLUKlZfbyNHN52BNvp2ys763UDfvPMoE4M0SlSc9CMxmwg9N01fC4ppmU
	kqrNXcYMiXFoFeKiXEmH8Hsxn7exRpkHew7TUk9/u2BCPaLhG06C1uk4kwQEGWop+cQNeM0IglK
	YHuZZRk1aGirBO+CuAn7a7y45mJi0w3fyHo7RT/hMCKan50npv10Ocw2JGWrN0P4+sdok/nzhiB
	lrWPKNqQQiNkZNIrYMeh+FPnQyrSBqxqwCy7pL7fyvcjTvQ+gtdLvWr4ZKg9x72sCNzfCYSP7bh
	gFhygw==
X-Received: by 2002:a05:600d:19:b0:43c:fabf:9146 with SMTP id 5b1f17b1804b1-440a66d9ba5mr12028295e9.17.1745570152504;
        Fri, 25 Apr 2025 01:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVwMxFD5f3mySi27LmA61xgw9SkI2YEf5bOWu+NSzAJvOJz2O8GeJpN1BaqSOng5t4z7wJTg==
X-Received: by 2002:a05:600d:19:b0:43c:fabf:9146 with SMTP id 5b1f17b1804b1-440a66d9ba5mr12027935e9.17.1745570152192;
        Fri, 25 Apr 2025 01:35:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5310a8fsm17114375e9.22.2025.04.25.01.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:35:51 -0700 (PDT)
Date: Fri, 25 Apr 2025 04:35:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v6 0/4] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250425043542-mutt-send-email-mst@kernel.org>
References: <20250425071018.36078-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425071018.36078-1-minhquangbui99@gmail.com>

On Fri, Apr 25, 2025 at 02:10:14PM +0700, Bui Quang Minh wrote:
> Hi everyone,
> 
> This only includes the selftest for virtio-net deadlock bug. The fix
> commit has been applied already.
> 
> Link: https://lore.kernel.org/virtualization/174537302875.2111809.8543884098526067319.git-patchwork-notify@kernel.org/T/

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Version 6 changes:
> - Rebase on net-next and resolve conflicts
> - Move the retry logic to xdp_helper
> 
> Version 5 changes:
> - Refactor the selftest
> 
> Version 4 changes:
> - Add force zerocopy mode to xdp_helper
> - Make virtio_net selftest use force zerocopy mode
> - Move virtio_net selftest to drivers/net/hw
> 
> Version 3 changes:
> - Patch 1: refactor to avoid code duplication
> 
> Version 2 changes:
> - Add selftest for deadlock scenario
> 
> Thanks,
> Quang Minh.
> 
> Bui Quang Minh (4):
>   selftests: net: move xdp_helper to net/lib
>   selftests: net: add flag to force zerocopy mode in xdp_helper
>   selftests: net: retry when bind returns EBUSY in xdp_helper
>   selftests: net: add a virtio_net deadlock selftest
> 
>  .../testing/selftests/drivers/net/.gitignore  |  1 -
>  tools/testing/selftests/drivers/net/Makefile  |  1 -
>  .../testing/selftests/drivers/net/hw/Makefile |  1 +
>  .../selftests/drivers/net/hw/xsk_reconfig.py  | 60 +++++++++++++++++++
>  .../selftests/drivers/net/napi_id_helper.c    |  2 +-
>  tools/testing/selftests/drivers/net/queues.py |  4 +-
>  tools/testing/selftests/net/lib/.gitignore    |  1 +
>  tools/testing/selftests/net/lib/Makefile      |  1 +
>  .../selftests/{drivers/net => net/lib}/ksft.h |  0
>  .../{drivers/net => net/lib}/xdp_helper.c     | 39 +++++++++---
>  10 files changed, 98 insertions(+), 12 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
>  rename tools/testing/selftests/{drivers/net => net/lib}/ksft.h (100%)
>  rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (78%)
> 
> -- 
> 2.43.0


