Return-Path: <netdev+bounces-199097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 799EAADEED3
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108EB7A5562
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF572EAB6C;
	Wed, 18 Jun 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AH0QmUj1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A9227FB3C
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255729; cv=none; b=tn4bDn/KGkn1eSdg9enJGln2r8NQiSX2fjNjMJBj4lqaEDvUKCGZG3CZl+jeJU5uD46zv0Z26ephSKHA7j+UnVJxfwgdZTSOkO1tVK5ISRY/kZzkS7wF5snJLMjZWZLVjhHdXSpwoTEsiPGXJpZAwTRxh3/oSa3IS7Fk8EJJzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255729; c=relaxed/simple;
	bh=MLxnng5Jf0aDCerqmwZTpzWMLTu+Hro0po5Pm4ro+WM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=osU6O514G70R4PtR8Z3dkTtixYVxFYi3XJmQxMaWbWGohqc9mfBxzObM8ndGsk+tV/wJhJ/W5ZvaT7MF6uj3c3OWt0BeHiZYADTMInXgIYsh06VRXoPbQeEnxyydtw4t79RCd+rOi2sJK91T6ZfovoX6VCcuwvtzdC+k4VAjnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AH0QmUj1; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a589edc51aso158704091cf.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 07:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750255727; x=1750860527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wns4L6H99qY2dGrmoJZ5jRdmGwjc4sFfv3SszoX88MQ=;
        b=AH0QmUj1Qrkx/WhZbNKP9nEzjL1Sqph8TzPJ8QFAg4pLaV5OEyzup1R/Q+b0cQjalC
         47GeSmbmUZcPgMU3mjLJ3X16+oyWyxrbF3X/hylgIwai4TJuBD3qUEAfatGA8PrtUn9D
         46PW9leLo9rg52ece8e/+8ESpjuJ2AeN4DLjYidEpfZ14IA9w9BGIMs5iRJ0N07/vtzY
         nLJ9sfoTpw9qlqPUYFHVoFB9k1XTwNeu4MPCf8OSuOIMKx0YEIBtTkpe8mqX4/vPjFvd
         jWWkwwzL6r3gFan+zmMILil7TDqqHrldxSDZeKT3+XzeJA1IQp+P3svRguKKQVk/G5NB
         6emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750255727; x=1750860527;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wns4L6H99qY2dGrmoJZ5jRdmGwjc4sFfv3SszoX88MQ=;
        b=UNhZ3/X5u2y+8Kx1WXPfP+e3jFDWSOHMzCpEFXYrsRhTMgje/E0OuGKQP+8e6o8Rc2
         JdHQYBSVC1VBtpRnfe1ssJSMAAkTHq653mg8mD7irJLrzJJ0at374TQFxKeVQTCZOd/g
         sGDCVNKf7bMqPVkk5bTVSvEHSfi82qDLB8QLtIZe5S5s4nsoSJ/kFDGdnJD9GvhRwfIL
         m7a2Rv5Z053UuZexj3KpZdS+2TWE3x0ig3NUVjSlT1r2uKpEf/0fG2oviZWzSK33zFmM
         caVhQLRhyJHrKdanXpdhOckEpuDRlitmqJZjPLrkjZ9rmU1G3+oomhjk1+RdlO9nj2V4
         fMng==
X-Forwarded-Encrypted: i=1; AJvYcCVZEW5XWLfcvtbkkXxhzwLGJEYBuGHXNMVpbvwNynLeDPuQ3SSR5ZKTfVkUb+eK+6ujvqV0KWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/hBehL+7VycDVUieNOX0eFU/lFgRQg0RusLk/XlI47lmrzopD
	OWgGkEUlMwNIpxk9HXvkX79Xvj5UXyhDtgB22AcJum0MpbNl59dDSmjDe7tg2wvrHN/mOs7SQ94
	5QUChT+/C9kTmSg==
X-Google-Smtp-Source: AGHT+IFVZ+ChpyhUshP6CAt9rgURt9sJnp8CEUqod/8/R65YnUIXpGyDiUIaesrnIabmaCz3EzJkU6Ln9RW/iA==
X-Received: from qtbbt7.prod.google.com ([2002:ac8:6907:0:b0:49b:d9c8:8cce])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:130d:b0:49b:eb1d:18ad with SMTP id d75a77b69052e-4a73c5ad40emr272889391cf.41.1750255727100;
 Wed, 18 Jun 2025 07:08:47 -0700 (PDT)
Date: Wed, 18 Jun 2025 14:08:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250618140844.1686882-1-edumazet@google.com>
Subject: [PATCH net 0/2] net: atm: protect dev_lec[] with a mutex
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Based on an initial syzbot report.

First patch is adding lec_mutex to address the report.

Second patch protects /proc/net/atm/lec operations.

We probably should delete this driver, it seems quite broken.

Eric Dumazet (2):
  net: atm: add lec_mutex
  net: atm: fix /proc/net/atm/lec handling

 net/atm/lec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.50.0.rc2.696.g1fc2a0284f-goog


