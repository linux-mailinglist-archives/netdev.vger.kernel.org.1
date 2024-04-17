Return-Path: <netdev+bounces-88815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB228A8982
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9925B285F2C
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91FD171661;
	Wed, 17 Apr 2024 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxWRb0QR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DA6171657
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373080; cv=none; b=gSJ8hMj5dsXSWJ+UHo/Oiahpul2ZErlhgCek7ptZuuzghuXOU9wiFMX9ZkXRpPr5jFMJ8m3MfcYmLwofdozSBraI0SWQmkfBdqLCfOiV6reJLAvDmOD27BMWukr6AU48+xqXG8STTgiIGwcW0Ml5Oi9+GH7v8WYMUMmfJZyRCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373080; c=relaxed/simple;
	bh=y7suL1YK3od3twvRIX/ZIugIqRFjCDPxvszDNcSw8B4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sMEKtzz8MYil7sd5qGlo22fXL8wWUtUHOcMPCm/atIneZTV6LPMoYexPHoHR2lHK9FG2c6GaIBG/cCwiUdGd05L+aAZgMxvcd17g6RIqpBfhLIV43LnZ5It+bDGp9r8MOVfJX9JOzHYyu/8BIKAZFnvQI3D0OBEsz/DzWgzcvL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cxWRb0QR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61890f3180aso78942877b3.2
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713373078; x=1713977878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sPAaR+H/YkZY/hGenagMkiG9wPIJQG+Q6rDyjTBBqfs=;
        b=cxWRb0QRqo3pRRdjEKXHC3r1jp1pDGa7hVKsd66mbRLvZzYxoNCfmmt4InrszFc+Rc
         swYvG3rinOkpeSdbg4d1fmrS/fPcgpmkD0s4SeQmsMNiSM7Qb0VFrLrCX94PSE44zcxT
         OMlj1S634DeMaPPgD0WO9c5IfP4m6RRtqNokvIC5StpMM+7DXQXXy+Hd7UO9yMtk04UX
         Kqf6r4KWyCNkvdT2nTh4oecNnxb3jV+l+kS0EY8UckjTRj2TXe2YEzYxmctbo6ZFyxTO
         Up207BT14zuls1QUhZ602MeG1HPl5PaPqhrX7DZqNHRTj3HioZChqqg0ZoMFspy+x3pn
         X9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373078; x=1713977878;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPAaR+H/YkZY/hGenagMkiG9wPIJQG+Q6rDyjTBBqfs=;
        b=AREtG7DyikV8CQLon9TN6zCYjsoDmcdJNCYWj5F5K9JLVWYhoinY6ncXQmAkN/rGe1
         YN7pP4NLyXJ6MIx3NTe1TZEHqmqJHF+EpB/ARTczQ8aGntc6IR+GteAL++Bq+ssr7FL6
         OGC+7AiPA+8XlJu4G7MBR4C9kzOmo4E+0V8gfsg7JRzeO2Jd0pfsULjWt1uumQ8x/zYv
         1bsDC7Jn6d0hxwjT+gmYXaMqKiE7Zdj2E+JQm/RgObkm+C3Z89G2er43vGGG2upNF1aT
         nWSJQBpC5IviSZeBxSoCOzELhi56MUr2M5EC/fE2AKqq8hSC41qS3OS5kXT47bbvHop7
         fu2A==
X-Gm-Message-State: AOJu0YxPa550UItjJGSQxYdRAJR+8K8Jc5+iZAoPNPmoymfXFf3QMe0k
	1go932r1AfwssIGFt1roanQeGOu6PjkU1s1ro2TP0gAn+iqg69PldyvrFqFzpMg7y2B5nk0XPu+
	uopowbEXN5A==
X-Google-Smtp-Source: AGHT+IFPdsBP0dPeqWQDvEDhDXZr7fj64zJvP/W5x6H+UmV5/BC73X9+2ViPS8KsH3cbM3tQdEGQnSEvkakY0w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4ed0:0:b0:61a:bfc8:64ce with SMTP id
 c199-20020a814ed0000000b0061abfc864cemr2717908ywb.8.1713373078303; Wed, 17
 Apr 2024 09:57:58 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:57:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417165756.2531620-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp: tcp_v4_err() changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First patch fixes a bug in tcp_v4_err().

Fixing this old bug allows us to bring back a patch
that we had to revert. Hopefully linux TCP can better
meet RFC 1122 requirements.

Eric Dumazet (2):
  tcp: conditionally call ip_icmp_error() from tcp_v4_err()
  tcp: no longer abort SYN_SENT when receiving some ICMP (II)

 net/ipv4/tcp_ipv4.c | 9 ++++++++-
 net/ipv6/tcp_ipv6.c | 9 ++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog


