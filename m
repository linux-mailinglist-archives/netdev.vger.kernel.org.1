Return-Path: <netdev+bounces-224493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E088B85810
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4025F189AEDB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A1E22E004;
	Thu, 18 Sep 2025 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCPvubep"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3C1F5820
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208194; cv=none; b=Frl8UJ/3L6J0B5buoB8WiU21MBrCdwKsnAC0PsD28FJKaOPIfJio4AohALcS7dOqD2CtAIlsoS5/Ht8TlKcU8VGksrHStu2mjcQRcN4e83wI+JzNjMlBpflRGIZIT3nBca92V/KE/Ul0TJbxg5/K0iB0FKAWJmmGHJnfsXNfReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208194; c=relaxed/simple;
	bh=Pw/MjLea6UioSwSASZnpZ8AAsRX5LWCOIOgzJejjR58=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b3Gd8D2v6OpoQIvptaVJL/f4wBrXqg6huTxiDdDsXtwFwYwv/xXmF+o9ISxXxY4JI0eyd4y0xr40iDZ6L9ioRprkccQcxh/R9DfWuv0qB7upI7L2qnoAPzPWRjkeYG+CHeEgHZwMISvww0TtT2bRUhvD8JsoSx0gv2vHzGUF79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCPvubep; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758208192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=OTSr1wJjkB666s7wnjnpL8189wpCEBf5U1utvv7uWvc=;
	b=YCPvubepPwflp1RMstAYR4rQRQQsUYv6UFKp4mjL1kjVOHQ7w8p17u5ESHMHAXtJES+EHo
	wtdr/xrlCboXEvxJC76ZJxrstDf58WDvGfGYIHu8I6vcZGnds8qJbGGz05Yhfk7C+kmr34
	18FwDD5Wxh8bINdqUW5dAQ7Bbi8+080=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-EVl1kTEbNgezO-mNDnltCA-1; Thu, 18 Sep 2025 11:09:51 -0400
X-MC-Unique: EVl1kTEbNgezO-mNDnltCA-1
X-Mimecast-MFC-AGG-ID: EVl1kTEbNgezO-mNDnltCA_1758208190
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso8666805e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208190; x=1758812990;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTSr1wJjkB666s7wnjnpL8189wpCEBf5U1utvv7uWvc=;
        b=o//SfIfQtmBZzXSZaFD3Wu5p8+rceVu/S8DFKR9KlqKpR3Mvv1f918LoeYwhPpCY38
         aqITydX9N4Xk4uQsE+Jgwk2YZhWyno1Q9Qp+unLbRiPUN1sDr1wgdRT0zjfMfNvLx6PX
         mFLIbTHZBe0xQYK8iUfY+Hxg4QmwVF63wxam0K6VPdqxONSpMdkLCaEYAf0XRNukJwSn
         I5ZkM5AIKVrEGnF+fRHmy0RR6GJ6l5a5DZYVHBocf2DO5C7Z3mvz7gcZYFZElCgEkKx4
         ZIyrnTbMVUQPG0mGw6Vuh3KxjtrUZYuNMibxLavj/duGz5aFAnQj7CnUNQVWK+R33YgW
         IYkw==
X-Forwarded-Encrypted: i=1; AJvYcCXvr0SLyHdSmzT+7BofvWS25TvTTWNfndiC2usfRWHFmoLlcFBIMC1BBxYqZe/E5l9pyE4s++U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOL6P2j+k+c5Odtrm1024GNtucH2TpTtVW6xcRpBatd2ofN0t+
	tMoy+m/20hJmHTGir7iJWEL5v/wGPY0dCJwbbj5BO/90JwGzIt23CHc/gku4EXCKuau/WXblRUN
	JA1ExciDmsJ8R91su/BR/PYEEBLS++Nufy34GwI+rhKelFUO58CdNeXiNXJrcysuGQQ==
X-Gm-Gg: ASbGncvJZPjBt4M+lNdizL5wwfJ0fJmualSVWjQgCl3fQD2W+JwBDU4qH0y2oSug2ZQ
	2Jmc2u0WwN0T8RbbEJZhwcEFdJPhSa+zF1XuDJrE7J29mI5M/UuZXQVpndJTcxhLARB/+WrhHpl
	OZzFUb2DqyBMN6Vb2wXGuwFNMU9CB7htTuiIXwFl5W1JVuzm5GWbWYimxXZEOKMP+rF4/MdcJS8
	UxslkgPH+Bmc2AeBuJePd4uBRqFIgPzcg76HXiu8OJ8DtTG1uPwZBNfEZj5fekMMug+liOV4SQQ
	KYXeIwDM8oPX4i5/ffWhz9Vk/O6vb/IhJ6E=
X-Received: by 2002:a05:600c:1d1d:b0:45d:d259:9a48 with SMTP id 5b1f17b1804b1-467aad147bcmr382875e9.9.1758208189541;
        Thu, 18 Sep 2025 08:09:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaJ2Mef73Q+HoINKzwUEsC1cVU7zVeFESpyDHECaEl4JHKCNZY7hJUwLmFSP/kpoOzvVa5TQ==
X-Received: by 2002:a05:600c:1d1d:b0:45d:d259:9a48 with SMTP id 5b1f17b1804b1-467aad147bcmr382485e9.9.1758208188954;
        Thu, 18 Sep 2025 08:09:48 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7478sm4120284f8f.38.2025.09.18.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:09:48 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:09:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com,
	hi@alyssa.is, maxbr@linux.ibm.com, mst@redhat.com,
	zhangjiao2@cmss.chinamobile.com
Subject: [GIT PULL v2] virtio,vhost: last minute fixes
Message-ID: <20250918110946-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

changes from v1:
drop Sean's patches as an issue was found there.

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 1cedefff4a75baba48b9e4cfba8a6832005f89fe:

  virtio_config: clarify output parameters (2025-09-18 11:05:32 -0400)

----------------------------------------------------------------
virtio,vhost: last minute fixes

More small fixes. Most notably this reverts a virtio console
change since we made it without considering compatibility
sufficiently.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alok Tiwari (1):
      vhost-scsi: fix argument order in tport allocation error message

Alyssa Ross (1):
      virtio_config: clarify output parameters

Ashwini Sahu (1):
      uapi: vduse: fix typo in comment

Michael S. Tsirkin (1):
      Revert "virtio_console: fix order of fields cols and rows"

zhang jiao (1):
      vhost: vringh: Modify the return value check

 drivers/char/virtio_console.c |  2 +-
 drivers/vhost/scsi.c          |  2 +-
 drivers/vhost/vringh.c        |  7 ++++---
 include/linux/virtio_config.h | 11 ++++++-----
 include/uapi/linux/vduse.h    |  2 +-
 5 files changed, 13 insertions(+), 11 deletions(-)


