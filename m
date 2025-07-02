Return-Path: <netdev+bounces-203103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A4AF083F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D8A422DE4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7057F54723;
	Wed,  2 Jul 2025 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQLgq8wO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8428691
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751421883; cv=none; b=pZln2TXYJCTE+fXPWMWPs/IrDmG4tr/Zyr4Iw7Dr78AXwzkemHATU7gRj1itmKIe/5f4yWUThImEYslzn3BDpQQ1fhOx4pHAxKpzWfYem0zEklX3ca2P9d+TJF/Qz60waVpR7JEWM7w9VPRTPz1nPtmfXNmpf9vxityotunC/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751421883; c=relaxed/simple;
	bh=qSLrIV/x/CJfpHqvH/bTNdL3EGVaF8vMLrnct3B6C0Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iTGwIjFw9DEXSgoncDYYSB31y9v61IPDbdJqkMHxuQnUM9O2K+InvY4AhO+CX8f+uXuVTb4M3CK29Uy00wZV3AZHwr57biUyi04uqNMt6Kx2nMz8/109D79hj2yFMHMPkau+libJHeJNWRF29Bgq5RKAW8Sy/m+hKx2vaAruihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQLgq8wO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313c3915345so9473217a91.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 19:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751421881; x=1752026681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oIz9aa/LpkCyZsppk4TGcXPWyyj3Le1v4sCmUbqy+rE=;
        b=yQLgq8wO0kk41RhnTa4NLtaHLG0LR8M8QmVJcAi2MAgx/enqTd3+gHjK/tWsjLFUAh
         253MsTpq7RvILGjWTZlRorOETzcWGSZpyrTa2ptmCZ4J+1TmCb5h6mo5AfHvQv/MMH/7
         323VkzK6jDr5R3IAQixBuymnLkltPZJdiFc9s6kCnK/jh1e3kqmIGc8AQvshe/wSEGWw
         P68qGCP5o3kfYXAupXjSoZGxBp+0e6HF7kLEh3CPIh/XOFSlSUvrQZ7JLLJdJ9RDDqdJ
         mxwPh6V+WbxM3N/c3sUWXJsDz3CF/yxcXSCeDi+kxmOm4V0uL0hA9F54v0k3OBmn9ZMB
         fXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751421881; x=1752026681;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oIz9aa/LpkCyZsppk4TGcXPWyyj3Le1v4sCmUbqy+rE=;
        b=a+oU20o0FXy3Q0BzKUMj6icwqlD2Ack7wyLdm83Ul94kT7FgrEG3hV6JeT5FAZ6xs3
         p4Xj2bDU+WmCDDegpBq5vkAvG1HhZncB6+qdxTdnSy2MD1tQPGTy+OWtweMjXMYJDG9K
         mzBLSwDnUx+nmtL8e7awpYUHEwhXA7tVUKXhE+3onVRlAJ9e1Dv3Asjbzwzke6Sh/ico
         KIA4twxGkPQgzTX+6s6lQLIqSTNRy3CpO6ABwNB4L+J8J7fKgyUuTJwhVeOgImgNaCnX
         aRFq5gS+lhkabIyVVp4A8pL2RyzldzKv+IMxTvWJwnF04AjgUtD92/DQxnGkYezDA7pm
         VWHw==
X-Forwarded-Encrypted: i=1; AJvYcCVg409FmAl1kaP4Et7KIk1OOMbQP8lX6HQVm1fw2vXxXvtlH2/gRfYKM7n72qw9B9S08E9t3Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLs03cyr+NKabNDShozZUXNJvN9l33cRY9y535JMmhuwfXUU3t
	BeiKzfW0TTsOKxNJPWQipSs0P7+OG/jMRz3jUJRJKktvHE+qitCR2s/Sb3ZaQGiThDCX5Yy5IPs
	byRpoZA==
X-Google-Smtp-Source: AGHT+IFjCXMeI+QGbNJIoNcR+WQFLolgghbVEs7WKZfmhr2QiviL7SUYFhBZzSbN+4VzreDjYwIdneytUUo=
X-Received: from pjbpd4.prod.google.com ([2002:a17:90b:1dc4:b0:314:d44:4108])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:530c:b0:30e:8c5d:8ed
 with SMTP id 98e67ed59e1d1-31a90bcad26mr1436665a91.19.1751421881298; Tue, 01
 Jul 2025 19:04:41 -0700 (PDT)
Date: Wed,  2 Jul 2025 02:04:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702020437.703698-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/2] atm: clip: Fix infinite recursion and potential null-ptr-deref.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 fixes infinite recursive call of clip_vcc->old_push(), which
was reported by syzbot.

Patch 2 fixes racy access to atmarpd found while checking RTNL usage
in clip.c.


Kuniyuki Iwashima (2):
  atm: clip: Fix infinite recursive call of clip_push().
  atm: clip: Fix potential null-ptr-deref in to_atmarpd().

 net/atm/clip.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


