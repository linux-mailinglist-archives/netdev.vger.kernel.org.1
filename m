Return-Path: <netdev+bounces-190468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1687AB6DFC
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C9717A4F5
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EFB19CC22;
	Wed, 14 May 2025 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRhDsmJN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B36115574E
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232377; cv=none; b=TROV90ZnvkzMfh5zabPElfC+6Z18LGiDmUIo0U/bGVOqvCu1BZ1iFQ1D54ibOhEUI6/iC8CG76Q8wwUgAOCNrGYhlCOr0CqfGT9UqVJimcnFzBJ6uHuiAVFL0iey6Hzig0B8A5HxbC4mlyX0ebuz6Zj/dL0vubdnK4ZPWyTAO78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232377; c=relaxed/simple;
	bh=wHZtwYVBdWmnMUx0cwwuokgFALLF/00lQUCEl6373K4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GKtvozaJ1szfFKLjFVkjPxsrMYrDswx+QYopPmkI4ekW18HRCwN1LACsWsG1SxK/SQamR1FfoCybu4TEOa8ohnSh+Y57tF/K1zKVdZ6OncRAfv4RoPWZAhwHjrC1e7KoXyDn+w4Li0/CK53r4+BX7YIPTBHpFYNJvvpIhSJELcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRhDsmJN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747232375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uRB4qyyeZ6d2cPqOCAW0MqMh5plkjaYv5Rx4lmPx+E4=;
	b=HRhDsmJNOfJBbMQ5q3o3aX8q6LSBp6vaU5N+tLt1hlJFyKXlqoezE4zQzOHYHSJO1D030s
	ut3RHacdzdbUstnVUhcMreQ+IFsxm0QCNTDOwHyEOJ9AbY2+WToe6MnJSwQo7ce1S6/dgE
	3o+Q9pPeT5ETFUAspk/AQPWrNNLe4Hc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-w1hV922QPCaXi7ONkQK9hw-1; Wed, 14 May 2025 10:19:33 -0400
X-MC-Unique: w1hV922QPCaXi7ONkQK9hw-1
X-Mimecast-MFC-AGG-ID: w1hV922QPCaXi7ONkQK9hw_1747232373
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so42329935e9.2
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747232372; x=1747837172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRB4qyyeZ6d2cPqOCAW0MqMh5plkjaYv5Rx4lmPx+E4=;
        b=JD++pY4zVpZizhEc7dfsbihaoc83sonNe52Icvur+S7rLgOdHTGkdwxAyInRr8UeY3
         kjYBPLldanfrTetiHpfd2r/qEQSwBmVAXTqy3xAISIHEhMGFFdadfWK7TljW+lWM+pv2
         FnWGITO/1yIxJqpKfKp6LwIQRob0uxQAcmRoe32GRpEcXF4vhTHmDTAbgsm2Dw9GlY6m
         BbTP+AHU1gPw3x0tOql/fYEzH7wBXfwrBYiph4nfqUrOR9ax/6XpC8mcNLRLYb9eGp3H
         QnCsH5BrSkGsxk0S80sDXEm8ty1KCDy1NRzATEbu7KC90rZTCbyAG9A2rSJmeffeuwuC
         QhFg==
X-Gm-Message-State: AOJu0YyYeefuJK4Biv4H6JpQVwVXNKvpewf1iw8boqAdTG6HRRe8BvDo
	rWZDQgY8eNzRnyf9fMv3swVS52z3OLm9wJWDu2nKGmjKzft5s+GPt6UHkucjYH8En1Ypn4QoRZ+
	0+1lSSt804MG4oqEiWCCnqhTkYfjj8qxAXtiesGulTAXi8oVYcAe5YfTYI8mJVizTXgu1nilCFo
	L9NXYzyWv3xcJ1GYtiDDvs0QJPFLvSmOqk697BcA==
X-Gm-Gg: ASbGncumpaw1GDIn4U3ocffW/sdqkWtdJMomESE+hwWPhM5HroSo/vGP2iysm6NnuOK
	VfnwtvRUXIVnSHSD4fjZlG1qVUQZndKuPtEZqYlFLmlXqfPzEwpuUeYqLhy+YaclSyjEnjksH6c
	eAhQXUDgb1p0G7sz5o6TjoPwAeEeD1H6W25tu+nci0I9nb/ZgDodplSM75r/fNj4UPvcJxOebat
	OEI26LywG9xvP/0Ig+igKU91oiVWlHK8hH7IEMrZAD7jqoJetYyI1gNmsMCA8YTp1skspF8FjoK
	HsOyldABzixJMr3DwA==
X-Received: by 2002:a05:600c:c0c3:10b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-442f217983bmr24467845e9.31.1747232372385;
        Wed, 14 May 2025 07:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZQdAMWLppZvJZaxFmIVmRmAM7GRP6r6dCT4sSkMl77fpFp0Bh3DH3ymMTUNtVtBMPIQvRow==
X-Received: by 2002:a05:600c:c0c3:10b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-442f217983bmr24467415e9.31.1747232371811;
        Wed, 14 May 2025 07:19:31 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.203.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ec98dsm19667975f8f.25.2025.05.14.07.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 07:19:31 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] vsock/test: improve sigpipe test reliability
Date: Wed, 14 May 2025 16:19:24 +0200
Message-ID: <20250514141927.159456-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running the tests continuously I noticed that sometimes the sigpipe
test would fail due to a race between the control message of the test
and the vsock transport messages.

While I was at it I also improved the test by checking the errno we
expect.

Changelog:
v2:
- added a patch to provide timeout_usleep() and avoid issues with signals
  in timeout section
- add little sleep to avoid flooding the other peer [Paolo]
- fixed loop exit condition [Paolo]

v1: https://lore.kernel.org/netdev/20250508142005.135857-1-sgarzare@redhat.com/

Stefano Garzarella (3):
  vsock/test: add timeout_usleep() to allow sleeping in timeout sections
  vsock/test: retry send() to avoid occasional failure in sigpipe test
  vsock/test: check also expected errno on sigpipe test

 tools/testing/vsock/timeout.h    |  1 +
 tools/testing/vsock/timeout.c    | 18 +++++++++++++
 tools/testing/vsock/vsock_test.c | 46 ++++++++++++++++++++++++++------
 3 files changed, 57 insertions(+), 8 deletions(-)

-- 
2.49.0


