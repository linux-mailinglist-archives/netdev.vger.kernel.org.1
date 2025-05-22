Return-Path: <netdev+bounces-192569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0E0AC0697
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005023B23A0
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E190E262FE6;
	Thu, 22 May 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoMu+Nxt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB9261577
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747901294; cv=none; b=JdZZAqZf6mtIRkKyuqjxqlEch3+K35QhyKSPVZu9G0aYxlAQPsVuT49WAljKAhKwQOA0KUyjJnK6+UfmtqgbcL7R9x4sKwXfQjr2eTbBGIGG3FabKZSKjZoBO+Bu3IX5VCnMib9i7nPk3BY2wKfxdwUcXYv2zcBGZ8rZa8+X/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747901294; c=relaxed/simple;
	bh=EX5kmSVBRAEXjNP2+5QT/wObVkwCn7KBTPH2XSu0cww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMTuO6abHTLAktAu7p7MclL1zGA6yX+bHbk54OZjrjFrMxjfIGnwfSG9+e91HyuLcmDGaZZxYqsdUh0nDIKttl82xJdAdX/VOrfeqnDa3M6Zax6LexoCxBoxqYQq+zFFX5xSdLThJNQVpjaVZfS7bRMMNff/+dedLQZcxf1aH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoMu+Nxt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747901291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v4Wd+YCxX35LZrCoOEx8nIlaA1xFBFeFa5Cgo0fIeyo=;
	b=MoMu+Nxt0igH4ftuPMxDzFqwHydL8oeRKOxQPx1ot2iUBLc5Gzow94zHgNsqhJreNojH50
	d38geBDugG2pQWaC8pxnzm2Mt0kEXtjRQDmUZGogVEbywj/MQGKUuwfFk7fUHaKlXy62DB
	X1atUYa5nFUJpoUea8QLkExsEyuQJVI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-UE_Ick66O4yqdr05TVU0cw-1; Thu, 22 May 2025 04:08:10 -0400
X-MC-Unique: UE_Ick66O4yqdr05TVU0cw-1
X-Mimecast-MFC-AGG-ID: UE_Ick66O4yqdr05TVU0cw_1747901289
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a3660a9096so2280709f8f.2
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 01:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747901289; x=1748506089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4Wd+YCxX35LZrCoOEx8nIlaA1xFBFeFa5Cgo0fIeyo=;
        b=qs/WaJM0HgPtW03krIcMjDaC3bRkmwnZr2aqoic7UQUJpxS8Qtiu/GZ3Y0wxN91nSK
         C3y75gOAeGT+dOpbxqUCN1cr0DxVlXiux0l8uZVv71dCwvpprGF316s+YDqLRKRAM27q
         TDdm/idYJgVkhCawsoipHgHTTdBJCk0jLb3Tb1DM5JMNaKLGb2L5+sngqXG5KCCvWPyy
         gywc/kIDMrPWl8RohbBZXluNTrADrh0lpow8lhw8P7440wnoC1Cg9PoP5Z/99PVuIxqw
         nkeH3a0KdEI22HokFx+XNT+L9o66Bou6kp6s3EsIQ008M8HiPDazVzQ3ieALTk2Y8YhB
         sJtg==
X-Forwarded-Encrypted: i=1; AJvYcCUhA9eDAQbPKKPvNgvspaQjPTx4v4lVHUqMah3vg1750vrtXw1hSnmgkLNUpWr5CyJFcp0Jr6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+W40FzKk8cIRjKXbvk2LrRhTu8ogbS5uBqePwt4mk/KkSCY/b
	sdOEBQAaPNQMYUbfsiiSNPOE9C7aQADMbh3ao9Zil/rO8hQ5Qrl9ntfl6XBRVraRMXwvtB+qaCQ
	WD8oM8i4Ylqr2AJu5S37oB59iv7S+8AS8KGFGVxQPf640w4rbmR9fvrTqhg==
X-Gm-Gg: ASbGnctivInSkts7NIpKOncF9UUIzJuReMWSgQC1Eanc75fe1X7QjTGNeU+BjcD563q
	IAPYLk6BZ51ttQlmB+VCuVEvZH+RhXfsx9o6ETMHfAn0HpwjZ7Rrx3bWz04dnFyreoSaL+mHaw9
	/rX/xQb2xvQju89qCWrxr11dXQ5g1jf56btU5ALRaMMlgFWJSM0GzvQ4X7thLT4X1Eocq1J5pEH
	ZLNzMRtoJ+gOdiitbVSbcnmHkqZ2nWgi7ToMNq973FEI6RFGKuOxUSXwVL4THzICtY8DraeaMqX
	bw4zzy2yEQcGvi4+6rz7V+LRNMlS5Ra1MJGkv52emLDGpMOQI2fvU5ub7xl0
X-Received: by 2002:a05:6000:2384:b0:3a3:6843:497f with SMTP id ffacd0b85a97d-3a368434b4emr17223466f8f.2.1747901288982;
        Thu, 22 May 2025 01:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB40eN1djVba1zLi/ieq+7/sYLnQly/oH/G63SZEMaHuLSaV/Sn473qGuURKSe2USXv485dA==
X-Received: by 2002:a05:6000:2384:b0:3a3:6843:497f with SMTP id ffacd0b85a97d-3a368434b4emr17223414f8f.2.1747901288395;
        Thu, 22 May 2025 01:08:08 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b295e7sm94333515e9.2.2025.05.22.01.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 01:08:07 -0700 (PDT)
Date: Thu, 22 May 2025 10:08:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v6 0/5] vsock: SOCK_LINGER rework
Message-ID: <kqm3bdj66qkziz27xsy6k6rnyminleqvebgqoudmufa424jlzm@khnzut7q4nqq>
References: <20250522-vsock-linger-v6-0-2ad00b0e447e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250522-vsock-linger-v6-0-2ad00b0e447e@rbox.co>

On Thu, May 22, 2025 at 01:18:20AM +0200, Michal Luczaj wrote:
>Change vsock's lingerning to wait on close() until all data is sent, i.e.
>until workers picked all the packets for processing.

Thanks for the series and the patience :-)

LGTM! There should be my R-b for all patches.

Thanks,
Stefano

>
>Changes in v6:
>- Make vsock_wait_sent() return bool, parametrize enable_so_linger() with
>  timeout, don't open code DIV_ROUND_UP [Stefano]
>- Link to v5: https://lore.kernel.org/r/20250521-vsock-linger-v5-0-94827860d1d6@rbox.co
>
>Changes in v5:
>- Move unsent_bytes fetching logic to utils.c
>- Add a helper for enabling SO_LINGER
>- Accommodate for close() taking a long time for reasons unrelated to
>  lingering
>- Separate and redo the testcase [Stefano]
>- Enrich the comment [Stefano]
>- Link to v4: https://lore.kernel.org/r/20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co
>
>Changes in v4:
>- While in virtio, stick to virtio_transport_unsent_bytes() [Stefano]
>- Squash the indentation reduction [Stefano]
>- Pull SOCK_LINGER check into vsock_linger() [Stefano]
>- Don't explicitly pass sk->sk_lingertime [Stefano]
>- Link to v3: https://lore.kernel.org/r/20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co
>
>Changes in v3:
>- Set "vsock/virtio" topic where appropriate
>- Do not claim that Hyper-V and VMCI ever lingered [Stefano]
>- Move lingering to af_vsock core [Stefano]
>- Link to v2: https://lore.kernel.org/r/20250421-vsock-linger-v2-0-fe9febd64668@rbox.co
>
>Changes in v2:
>- Comment that some transports do not implement unsent_bytes [Stefano]
>- Reduce the indentation of virtio_transport_wait_close() [Stefano]
>- Do not linger on shutdown(), expand the commit messages [Paolo]
>- Link to v1: https://lore.kernel.org/r/20250407-vsock-linger-v1-0-1458038e3492@rbox.co
>
>Changes in v1:
>- Do not assume `unsent_bytes()` is implemented by all transports [Stefano]
>- Link to v0: https://lore.kernel.org/netdev/df2d51fd-03e7-477f-8aea-938446f47864@rbox.co/
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>Michal Luczaj (5):
>      vsock/virtio: Linger on unsent data
>      vsock: Move lingering logic to af_vsock core
>      vsock/test: Introduce vsock_wait_sent() helper
>      vsock/test: Introduce enable_so_linger() helper
>      vsock/test: Add test for an unexpectedly lingering close()
>
> include/net/af_vsock.h                  |  1 +
> net/vmw_vsock/af_vsock.c                | 33 +++++++++++++
> net/vmw_vsock/virtio_transport_common.c | 21 +--------
> tools/testing/vsock/util.c              | 38 +++++++++++++++
> tools/testing/vsock/util.h              |  2 +
> tools/testing/vsock/vsock_test.c        | 83 +++++++++++++++++++++++----------
> 6 files changed, 134 insertions(+), 44 deletions(-)
>---
>base-commit: f44092606a3f153bb7e6b277006b1f4a5b914cfc
>change-id: 20250304-vsock-linger-9026e5f9986c
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>


