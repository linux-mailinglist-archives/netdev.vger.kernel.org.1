Return-Path: <netdev+bounces-208878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B678B0D79B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2163546CEB
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FCD23A98E;
	Tue, 22 Jul 2025 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AW449Bli"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E39242D89
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182023; cv=none; b=HnP/iZixE4Y0rh1Ynu3k/+XpNZZnlAk4xaRvdpyIA/owl81wuCoCmWigDQjiiYpjucTl+EEhjiJu9Ef5XAO1xqYU9Cu3I3VdytLhcr7nZOXQ1U163b16dUeINdeix1AcSFbPOqjecS9+acx3uewTQqKWagfGTz2wI2GdFi+lL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182023; c=relaxed/simple;
	bh=5RIeji+8DfvqNNAP7ofBdXW0XJA0eaUJ7sHpDbdQk0c=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=nC3vSBzZSsVrbPK/7aJVXS+13vJeZXp5isPxzz4+HAC4OkDVS8NJKRTwcNLky4i8+WPoTWivQkwwgGOE54aul6z/88XU1EAHh06F9g8vkVa2lfgklQZE6juFTjvM+Sxt7RkrQkMfsgB9XqMXkTU3ac20zJD3oPMzKOeF+HCoDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AW449Bli; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753182019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5RIeji+8DfvqNNAP7ofBdXW0XJA0eaUJ7sHpDbdQk0c=;
	b=AW449Bli1ECJYW6KnJx0qiDzu7GWL/nMCw3JC75hmtkuZADZXGCt5rr/nYTCWhuXHxMPam
	mO59WSEit76pY6e++f463T1DcYsazGwhInzoq7ffyPaK1PaLCzpwSfMoz1nWa7+uTU7l8U
	0HJzDiny9f64EY08PX65qO9fJ/DZI3M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-508mNrxAOsitKJxmy4sl5g-1; Tue, 22 Jul 2025 07:00:18 -0400
X-MC-Unique: 508mNrxAOsitKJxmy4sl5g-1
X-Mimecast-MFC-AGG-ID: 508mNrxAOsitKJxmy4sl5g_1753182017
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so3109820f8f.2
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 04:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753182017; x=1753786817;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5RIeji+8DfvqNNAP7ofBdXW0XJA0eaUJ7sHpDbdQk0c=;
        b=Fh9DpeQGIk0ujQXbEZGpMKGAAQxw5Bb9b6CVeIC73eoEXQdkNsUaOWSao0qqWpgLDQ
         uCITvUP6WPF4tPbpOaRccKjN/EDQE1CTHigSrCbl3g0C9W3w923PAy3zDUlXGF2peZxJ
         i8NSVnmIRr0bkyk4EGSxD+ZE/D5TteJ2k7N8R/QpVkqoG0tRMAl5kEQvspL9B4Pk9aeI
         TrRD80K8dy4ZPy89AeiFjR7gnY5V/mg7xM5tBjWKhm47HxzlEDMulbhTcCOfr+w43uv/
         7gJJpwFTfm86OF38KnMHOZtYQlldFWLTLfjJS952wJHVTZosMq09iYV1qw6mZu8pgTc9
         RQDQ==
X-Gm-Message-State: AOJu0YyMN72g7AqPxDfXBR4pniwZ88bnwoF2jqqqIytDrLN8FKqzlXKL
	rqwy+NWwctXrJnzD3NzlDgOV9YCZjyA3BkfJ8xjWtT2uZ134/xfHh2KhQVxTwj4CylRNEDULcgR
	GNeiJz+xEZoUbQPU4y2nWGytg9h3rcPpzS+SfO4O61mY9BoF0F4kUuepa9Q==
X-Gm-Gg: ASbGnctRHFjOq51TTh/xTN2ytOB2KqBWrWydlH92EWXRc5JXhXP2UcwSqLRZQr0Nupt
	BB+GOCTMHwoQ7g+XdBgPo4p0cfQpyiJI0mJp6ALXDyXDfTz0bMo8B3h9o/F0AsFYR452T4OtE8B
	sC965/DBsf/7CRkwT7bsQBuBCMMudCYFUcr4Og98v3FuxN6p+Z+mw2JjPjqBgMsxfIA2l+bYrp1
	bSZA/IXPPBm0RjZccB0cYot4/0un9iaVby7qr/0cZsBdacxyyl8P17pPGyFR86AXw6/BUKmggn7
	Ph5OwKGnNlG1aFbyhWABi+KDB1DNA9L9KhggoBsLep5SPRsFHK49K14BOLNcRmalInP2bTVWfAB
	8zpuv9ssq0Gg=
X-Received: by 2002:a5d:5d12:0:b0:3b7:5cd3:fa8b with SMTP id ffacd0b85a97d-3b75cd3fad3mr5239457f8f.55.1753182016709;
        Tue, 22 Jul 2025 04:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyov2OEL5K0PV/cLFrMkpm0YxB4xGIKLC2U/Atw3K/2U/LQ1Hx9z6Y1eh7B0H8NY1EdYlkxw==
X-Received: by 2002:a5d:5d12:0:b0:3b7:5cd3:fa8b with SMTP id ffacd0b85a97d-3b75cd3fad3mr5239411f8f.55.1753182016164;
        Tue, 22 Jul 2025 04:00:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bf4bsm13021898f8f.31.2025.07.22.04.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 04:00:15 -0700 (PDT)
Message-ID: <c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com>
Date: Tue, 22 Jul 2025 13:00:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Subject: virtio_close() stuck on napi_disable_locked()
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The NIPA CI is reporting some hung-up in the stats.py test caused by the
virtio_net driver stuck at close time.

A sample splat is available here:

https://netdev-3.bots.linux.dev/vmksft-drv-hw-dbg/results/209441/4-stats-py/stderr

AFAICS the issue happens only on debug builds.

I'm wild guessing to something similar to the the issue addressed by
commit 4bc12818b363bd30f0f7348dd9ab077290a637ae, possibly for tx_napi,
but I could not spot anything obvious.

Could you please have a look?

Thanks,

Paolo


