Return-Path: <netdev+bounces-171914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE8A4F58F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 04:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5C21890A4A
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 03:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC0418A6D5;
	Wed,  5 Mar 2025 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UY8Ll+q5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D118DF8D
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 03:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146355; cv=none; b=EWahnDKZffZLupXkGB6HYCWc2KZV3mniz8mlWdVWA/r7aTDE77tkjfhV48s+iAqjZAxpRV3VVjGEJRJgTdg/MATTWFuZ7G34EFuqnNyw3y8q8DvoYCLEpf2wfiPPtNElmLtUxkYT8bbBlvCYXrM//Mj0GZL6G3IpjFdFHDWu/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146355; c=relaxed/simple;
	bh=0YamzzA5RVflLsgX8pDt08F7xIwbjwLAlKoIv39giGY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uamKPri2WP1HlvkJG4MXYtg36WCF0l+9sSGnaLe33b0ijLpYkOt2hEDWDmjoIPcGCtww6D78G6VgInamkuBvkoyRT0NGArlnzFsNH4ZiGTKBfbcBhrAl0MJf5drosvurI10mMRkycKgxDJsRASSGkxEIy7rw9is0F9tAwZTfSxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UY8Ll+q5; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c3b6450ed8so544525785a.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 19:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741146351; x=1741751151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MfFhlhkokAw5P9Vrv4suabn14NJBotPYrL+6L5tVXdI=;
        b=UY8Ll+q5bZMubqQX7IsgvJhsA4mScozGeOrfqRsPKF15oDI7dATMYgNmJfeylXqwBm
         iGp4c1PD/OEKsr7J/DpSvJTuLGiMUGNK743MDlTQ3IgPzYTODi0CjtOxgpvxsDoqgBz7
         +9xSflZGiIJ42U0kbf2N7B4m3h8IwIHvjk7lnevjAxLb8Nv6hKdMCTwD3993G1rG0Mu9
         2xNdGbIwV4fkS8nNlW7F/OhyPFLer1neDZj+RtdBC5Qslf2A6K2HPHBmWQSYuhkKSgJ9
         sstIAg9niLTx1z/y1ku7+gqS9PQ5HI/Dv+Wz4dBiroQ5xI/HGWQjAQUhJzYmeGAkxpG9
         WZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741146351; x=1741751151;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MfFhlhkokAw5P9Vrv4suabn14NJBotPYrL+6L5tVXdI=;
        b=Sp71CoghRcel4wnGX/k07XHf5jpgNckJSybJ4FvzoML4rDUEb9XAWJauFYmB3k+kOQ
         XAyvly1GEzWwCRY6T5Sctz0CQlexhd8jvw7f3EFuastAw6es3l0SgtHaw0GO8bwira3i
         fjCd9EoDexpotc3eGD2B2c9TX62R3mRZKrjZFGgm0b1kNEV+OXcKzoTaIRilW7vP6JL7
         LkjI5l52JXfocUfLMAQJpCbfwUMXXBkKvNTIPPdNVFvoaK+LipFzUbt3Firh4ivyp1RU
         ZsuJ4rvjtD3u7IuQoBAAVdJuchIIhJdxN9Gl5Gqsp0r30MMnBR2XNs3JuH8I04TDzTMT
         golg==
X-Forwarded-Encrypted: i=1; AJvYcCWwQdnkdO87cbppLMOUtQ6w1MB4ZlEmxRJTJ3s/70KGCOHi2OdShMU8aZ/AZ0Vm1WgK1SCFTaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR4fW5mSJGQgb3lYdqT3Ne/i1aeb1mS7gg2bexZU2CiZoRXAOP
	AsXRs26yclXbIvIoMxKhudjiB4nEGv41ZI+I0pzNYsmVrU6U9UNNRMc60Sv/aJV0/IKz03bteJJ
	c/EMCZEkT+A==
X-Google-Smtp-Source: AGHT+IFkZ39nJilHzIldYLvZriVmG3OYaIwTxlM3y58eW8CsALxG1QO90uZmkdCnoNJ7Xame0moVsjZnd6teEw==
X-Received: from qknrv10.prod.google.com ([2002:a05:620a:688a:b0:7c3:d67f:c321])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:84c4:b0:7c0:a0fd:7b2c with SMTP id af79cd13be357-7c3d8e55666mr326991185a.22.1741146351728;
 Tue, 04 Mar 2025 19:45:51 -0800 (PST)
Date: Wed,  5 Mar 2025 03:45:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250305034550.879255-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp: even faster connect() under stress
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kernelxing@tencent.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a followup on the prior series, "tcp: scale connect() under pressure"

Now spinlocks are no longer in the picture, we see a very high cost
of the inet6_ehashfn() function.

In this series (of 2), I change how lport contributes to inet6_ehashfn()
to ensure better cache locality and call inet6_ehashfn()
only once per connect() system call.

This brings an additional 229 % increase of performance
for "neper/tcp_crr -6 -T 200 -F 30000" stress test,
while greatly improving latency metrics.

Before:
  latency_min=0.014131929
  latency_max=17.895073144
  latency_mean=0.505675853
  latency_stddev=2.125164772
  num_samples=307884
  throughput=139866.80

After:
  latency_min=0.003041375
  latency_max=7.056589232
  latency_mean=0.141075048
  latency_stddev=0.526900516
  num_samples=312996
  throughput=320677.21

Eric Dumazet (2):
  inet: change lport contribution to inet_ehashfn() and inet6_ehashfn()
  inet: call inet6_ehashfn() once from inet6_hash_connect()

 include/net/inet_hashtables.h |  4 +++-
 include/net/ip.h              |  2 +-
 net/ipv4/inet_hashtables.c    | 30 ++++++++++++++++++++----------
 net/ipv6/inet6_hashtables.c   | 19 +++++++++++++------
 4 files changed, 37 insertions(+), 18 deletions(-)

-- 
2.48.1.711.g2feabab25a-goog


