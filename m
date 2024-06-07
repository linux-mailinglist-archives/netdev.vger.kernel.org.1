Return-Path: <netdev+bounces-101929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 225B4900A06
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 18:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BBE1F28F97
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1DA1993B5;
	Fri,  7 Jun 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0EOIb+R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311FE15ECD6
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776482; cv=none; b=cpMgASm9IvuU5/dyKLgR9vHzzJITLSsYvwvTjFlEMhQJUxIxG73LalBF8JUKvJdvmDRIh+mefm4CaUyZLroBgonYOwGlUJMLXCZuIoe1+fXnAwhYTGc6ZBKIUfJxJ6SFEMoVqdccvyv7K0fQNF1zg72ceAL0fFx+97spjJOtuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776482; c=relaxed/simple;
	bh=TxZ62lRbGYR0AmZpOp1164ij9xgmLaqHEpZwVrf2BUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxWUFjY53lQLEXF4JRj8RxTDCLS/KRHtai2YVuH054yCI8BFvp8UveiuppG7ZI/rBio9aLuquygYqv+ChG11/UowrW8VJGbC5eNyws9Zj+T0Y5eeEU95PkB+mapyZGpiX4iLaVyPPMst2ccqKo2GfgVNE+1WooJyusK6yZm8nxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0EOIb+R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717776480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EBLE9WHJdPeMtGHEriSmKop5oZrT43bTfvmN1za5maQ=;
	b=Z0EOIb+REkenkZGX9+xzTsf56dshY3ECCQz2wDKc648ulAuT/7eiHdca1sVAbC4qr7iEAk
	tUIkxGFaKQBk0Igmus9y43ukg1XwpjXvlmv9xpc0LEM20te9S9VGpUDq42nz09KE5gnKch
	HGS/rCRBRWnw2L77IkeUc2s5YapqQBU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-erl8b5bpP8--_SGjXauWhg-1; Fri, 07 Jun 2024 12:07:58 -0400
X-MC-Unique: erl8b5bpP8--_SGjXauWhg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6861bb1c0bso147581266b.3
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 09:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776477; x=1718381277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBLE9WHJdPeMtGHEriSmKop5oZrT43bTfvmN1za5maQ=;
        b=wzn6CaFGtDOLDANEd1y4LV89FWtky7u8tVMFtLgbeEzxuE8Bwl6PFtOmy1s0EctGZb
         CLaRHb4quShI1Js6SYfeSRbH2mlb9XL9MrBEnSGAX279mIYRu54zbtJ7WZiP1RPwC6iJ
         lXgznSdU1yZAYjob9xhAnoOoUXbdhzqqK2dDqNB3Gc+N2+EN2byKH8QjbQ7Imoo1fRkv
         oGKXXcGDYDmUkoRgXN5AgM35VHKZrblaHX3Q5J+PRsOcZEVTa8ZlKUKc2taH0eQvTrzs
         jfls0l/G23JlyU+48d5Wwb1dW/0dUQYQl93TjhevhKQd1OVPf35RP5wp8Eph0cWCzaIs
         pDXw==
X-Gm-Message-State: AOJu0YyyOF6ZoHBhzJeNt7fBoZ47RkC8Hv2xeJ72cksqfFvjy1UI7u8r
	+SLVoDywdBg4/NHdKOr7gtCyIzcEwJ83TPrRViqa3iemY4zlD2upWkgQZgm0G1aC8xSsVZdElU9
	9qPVgrreZXx9gqWCLK0MVhRdfAbldxzCmXdkU5DHUH6YcnXETc6Vq6Q==
X-Received: by 2002:a17:906:f582:b0:a68:6032:463c with SMTP id a640c23a62f3a-a6cd65668b5mr284287366b.18.1717776477106;
        Fri, 07 Jun 2024 09:07:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuyKEHYo5TPUfVQg5eRCpyksPsAJrknMBehGQmuprA7HQfQFCf1RnS6OHoPTC28AUzT9y7uw==
X-Received: by 2002:a17:906:f582:b0:a68:6032:463c with SMTP id a640c23a62f3a-a6cd65668b5mr284284866b.18.1717776476606;
        Fri, 07 Jun 2024 09:07:56 -0700 (PDT)
Received: from telekom.ip (adsl-dyn127.78-99-32.t-com.sk. [78.99.32.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806ebd59sm264672166b.116.2024.06.07.09.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:07:55 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options
Date: Fri,  7 Jun 2024 18:07:51 +0200
Message-ID: <20240607160753.1787105-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to improve cipso_v4_skbuff_delattr() to fully
remove the CIPSO options instead of just clearing them with NOPs.
That is implemented in the second patch, while the first patch is
a bugfix for cipso_v4_delopt() that the second patch depends on.

Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
https://src.fedoraproject.org/tests/selinux/pull-request/488

Changes in v2:
- drop the paranoid WARN_ON() usage
- reword the description of the second patch

v1: https://lore.kernel.org/linux-security-module/20240416152913.1527166-1-omosnace@redhat.com/

Ondrej Mosnacek (2):
  cipso: fix total option length computation
  cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options

 net/ipv4/cipso_ipv4.c | 75 +++++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 21 deletions(-)

-- 
2.45.1


