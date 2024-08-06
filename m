Return-Path: <netdev+bounces-116199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A894972F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F02A282E0F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1FD78C9D;
	Tue,  6 Aug 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cq2YwrtQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2447441A
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967055; cv=none; b=OK6Dt0Iar6GENE2FXXcmZcqne8lrnwyXi5jrY+Q1O4ZslQXbn8Qg3SThQ2QQSRp8E9ToOQqDqcWuAFfrgR3qVvwsSdtSTFtrtnYkWJPlGEhTIyCSalMCl6gPQC+MSwkoyJkBTTSPNzi6uLiLRkIbmWG7zcPopa7WU+SrtHshOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967055; c=relaxed/simple;
	bh=Y3kpDopP34wSS4aefVZmlrz8cQFzCX6exogFHU3d/Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p2f7Iuvs5IIcyfZGKCC/oipOWS6hd0nauz1X3kpb7eUMUPQmw/ozS0RDL4D1Y0W9Grhm3sYgN5kzKI8V3QP8WnvV807mTPb0DMAjGzZt12A7NbZS4JIQuV4SfdyGnnEWhV3tONXqvNbok7LzEgMINMtLGbzzWQhQmcphmNdJjrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cq2YwrtQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722967052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=PCE6y3gd/ZLdIqr+zXDfXpXA+sJAwSBPUwATht6B/14=;
	b=cq2YwrtQUSQuJy88eUgMerq+vAf1L694K8+XCQ1wrdkY7a9Td2kVc4n7HjOqk4FKIsKIkI
	F4mJwnNM41nhJH4XnjdoHnYZ8AemtrWJgAa+2aI6u29u/+oHIwVQjqxqg4j+cExDcdQ8pr
	7M8GGPKmGPCpQi7ttfaTvoC106Xm7Ro=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-gkJU0zfuPGSxvVgCgW1U8g-1; Tue, 06 Aug 2024 13:57:29 -0400
X-MC-Unique: gkJU0zfuPGSxvVgCgW1U8g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5bb35b28f82so681919a12.2
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 10:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967048; x=1723571848;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCE6y3gd/ZLdIqr+zXDfXpXA+sJAwSBPUwATht6B/14=;
        b=odU0faSdnAVOy8Mbr8zagpVST+z4l3LxqA8S8gk4BDF/uDO0+K7ltbX3S5glGpv4Ye
         C5D5efuCdcLD0Y+n74jjI96tVBdsMe4vp8/awJURCzp2O8VXq/Ay0o1UL9q2d/2GxDtR
         wn3mXT3Hd4k0jLmYhN5DMkUYk3qNx/42/NGJAkj86vy5FUMAFChiWTY/WwbRfjVfcaY9
         Fqwwfyo6dPZWq851u/NgrM7HsAwJIPkkYDKUrEXhuod/gizLmKwqzwf/06ZZEn21vZob
         GdnO9EfO3jjPUXXZFcDKnj/HX5T05eLpW2eEiInIiENapwNBbHs4t1KIq/udoaXo9fr8
         8v5A==
X-Forwarded-Encrypted: i=1; AJvYcCVCuXPse2Vjzgmih3m7plCqAsGWzBrtVE17Y7IyPLucNE1tvnS9a0YZ0+nttpUOKkkQgWSCsrUHLKMMlGd+wvdAK3jijGYr
X-Gm-Message-State: AOJu0YwXrnKTGSCIwvdZgpXBYKlXGVJQuwLrT7v/pV2oN6eMDHJitx5F
	kDDaOM2KX5jtmK9iP41R7a2oljNLS+EyR+mI67gvtdNOqRNgo96Z5BwS0pI/9ZA28Vhu0XmORnl
	w+C9YRlAIrumTbshMAPwuNgBGHzh1QuJV5flbuB/sCcfHnfmcbnO1MQ==
X-Received: by 2002:aa7:dcd9:0:b0:5a1:40d9:6a46 with SMTP id 4fb4d7f45d1cf-5b7f5dc5d68mr10453926a12.36.1722967048117;
        Tue, 06 Aug 2024 10:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9wiBpXfkiQpEvZZyARq7/ap2Ik8pTsT+kT/0l0ZHqK+AvR7K5fHmkyUYpLFX0WwVH0aYZHw==
X-Received: by 2002:aa7:dcd9:0:b0:5a1:40d9:6a46 with SMTP id 4fb4d7f45d1cf-5b7f5dc5d68mr10453907a12.36.1722967047202;
        Tue, 06 Aug 2024 10:57:27 -0700 (PDT)
Received: from redhat.com ([2.55.35.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba442ed7f1sm4421307a12.81.2024.08.06.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:57:26 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:57:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dtatulea@nvidia.com, jasowang@redhat.com, mst@redhat.com,
	stable@vger.kernel.org
Subject: [GIT PULL] virtio: bugfix
Message-ID: <20240806135722-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 6d834691da474ed1c648753d3d3a3ef8379fa1c1:

  virtio_pci_modern: remove admin queue serialization lock (2024-07-17 05:43:21 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 0823dc64586ba5ea13a7d200a5d33e4c5fa45950:

  vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler (2024-07-26 03:26:02 -0400)

----------------------------------------------------------------
virtio: bugfix

Fixes a single, long-standing issue with kick pass-through vdpa.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (1):
      vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler

 drivers/vhost/vdpa.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)


