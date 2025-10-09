Return-Path: <netdev+bounces-228361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15594BC8C86
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 13:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FD2F4FA2BA
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCAD2E5406;
	Thu,  9 Oct 2025 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwxMeBlH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3262E1F13
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009068; cv=none; b=REk8i5TCY7yJMXAWsnl82JbMP6MAAUBEegxqJ2zKMU8la5hUGhGrnt8xn/9+b1ReFwotODK6k/uXja+hP9Rkhu1sP0iHcEx8KhobQFlN/fkewvaxxQm9dRYRwhf4bNTNbc/OgSaCK4L32SJTayiITk1tCtXnb1un/c0ESnUdnHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009068; c=relaxed/simple;
	bh=oT4tl3z2KUhw2+Hd2uYG08IuzT7jBpBGLw7mqIhBV7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aU8bgR4H1vqewwbAFL65gOMhWn0tXSzcMMqXlZFwkPiiA3WTtGTQT/wk4bjrzHM4frvmMu60pDcJgQ1iFalLsZqeyYcjLkB+m1uvlzlv3KfRGVSHYK6zW0w4lQLkeVB09C+hTGZAJXQybWxQ8fEXJKKOhi7UCQHdxJZnMHGFY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwxMeBlH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760009065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=2lJGNEg2UpjFWdrk/OIO5zgtw0B+C7GNTQdtLNs5Urs=;
	b=JwxMeBlHZiymCfCC9QdRbOfiv1BSi9QGsU1kahs8HlQhEyRXbNrKmAL+trkLDOxbsLoE0n
	8m9YCHJqEU5LHE4PGZLrHeRORLTcyHPI9UAdbMsaGzpxrrlqutWWP2RYoXi13wgDh/4N5x
	JUvnD6q1KmxCK4LPBGiJaG5SLPLr2A0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-apLnGk4QPjWHYFJeuZhYrg-1; Thu, 09 Oct 2025 07:24:24 -0400
X-MC-Unique: apLnGk4QPjWHYFJeuZhYrg-1
X-Mimecast-MFC-AGG-ID: apLnGk4QPjWHYFJeuZhYrg_1760009064
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8635d475556so145440685a.0
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 04:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760009064; x=1760613864;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lJGNEg2UpjFWdrk/OIO5zgtw0B+C7GNTQdtLNs5Urs=;
        b=qbS17BXivt3C1U4dZk29MqgtbDTGXLuRDh9SKxXD+SKTHr21skQQFBQi6NMCaA7N/E
         8SUtAWNFS5oC0LpI3nopMoK5X9SkdOJUS6r+fnyaPWduvd6eMF8NAPZCkKJNfGi/v0Eu
         4oZJitJrzOptktfCPuFHiHDQGVFnSck2yCGfca2JKMo1yXp0+KcuF9GSHa0sKZ6yFbCR
         EZcTXbFsWc1IJC2IR5nppxt7BsV2bWrg/rFQcTJA6cRaL59VLprEBCA31Mi0K48RZAHV
         xk8cU2XSFLUCZqJPAreYTVwwCVAI8qo2JntJ9vFy7E0Ao9Y9UfGEVJPEEAvRQhaXnKY1
         uMQQ==
X-Gm-Message-State: AOJu0YyJiEM6j3xZhbG1FEmJumga4cO+CxF9EsKfCZoeG5uFB/qPETwJ
	7IaDJ4gz0Wi6rqTiJPVyYRfvKzGPtTLnRH3VZOV8qfBt2Je/ah7YW0YxBg4qlie7yRn8L2zM/o1
	+MW2mD+b57jHh/Gb6YKsIbm0RuqxWaj5a28eB/JK5+S2/bMXwKbdRm4XUeg==
X-Gm-Gg: ASbGncu5TmOxAgCs7UNU3PyHVFoCGoZgUv7Z2cRBSYFb4DtmuTjPI8f+DHlfgWb6Zmt
	wYiqj40108R+D/sRnuIyVCF0omP7bCKV6HFZWK4UkY1LMiFLIk1YM/QXIGc0GM7n+024xBfcquc
	yg2w4BhD7xyhWc9V0XGsRi+1588EF2IfIl83gBKPm/9f+yP5RYb0uxOYLaJ8iFCDfXqDzv0co6r
	sCjzJCOPBvWni6v4LtBsinZdXwAZW7qVd2X2BsvG3gUV5rURhy5Ger3MFBpwTThSTy8lrbD3kJi
	DhAhBBoVp75VAKt8iHADoJHLrxjCXaQ6Ym4=
X-Received: by 2002:a05:620a:a216:b0:883:b9c8:5829 with SMTP id af79cd13be357-883b9c8642cmr644632385a.77.1760009063806;
        Thu, 09 Oct 2025 04:24:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0mTtYplLadpOj/nejAdqueSbh8n+h7GZD/IgFvS6ckr5aGy+wTOd/VbqF6jWjV3J9f1dabQ==
X-Received: by 2002:a05:620a:a216:b0:883:b9c8:5829 with SMTP id af79cd13be357-883b9c8642cmr644629585a.77.1760009063306;
        Thu, 09 Oct 2025 04:24:23 -0700 (PDT)
Received: from redhat.com ([138.199.52.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a2274482sm173791885a.46.2025.10.09.04.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 04:24:23 -0700 (PDT)
Date: Thu, 9 Oct 2025 07:24:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 0/3] feature related cleanups
Message-ID: <cover.1760008797.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent


A minor cleanup around handling of feature bits: this fixes
up terminology and adds build checks.

Lightly tested.

Michael S. Tsirkin (3):
  virtio: dwords->qwords
  virtio: words->dwords
  vhost: use checked versions of VIRTIO_BIT

 drivers/vhost/net.c                    | 14 +++++------
 drivers/virtio/virtio.c                |  8 +++----
 drivers/virtio/virtio_debug.c          |  2 +-
 drivers/virtio/virtio_pci_modern_dev.c |  6 ++---
 include/linux/virtio.h                 |  2 +-
 include/linux/virtio_features.h        | 33 ++++++++++++++++----------
 include/linux/virtio_pci_modern.h      |  8 +++----
 scripts/lib/kdoc/kdoc_parser.py        |  2 +-
 8 files changed, 42 insertions(+), 33 deletions(-)

-- 
MST


