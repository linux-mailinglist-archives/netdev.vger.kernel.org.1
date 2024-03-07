Return-Path: <netdev+bounces-78398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AFB874E80
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 13:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2893CB21781
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 12:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779CE129A64;
	Thu,  7 Mar 2024 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2bdrk09"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72E26AF5
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813027; cv=none; b=abEWCjyKf4aW1Tv+fONtcvs7syDmJ+7r7fLCqxwWwSqIqN3luSzwV75p5T7UdFmRxHCADpJP97Y6AC76OLqBKtuhbvvh+Zty5YoohE9r06KyM7iMQr8LAl05lGVaD1EFksZYBbidqIRCs6/BVOuIwBwhdHjRH2uNTmZkBcjjDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813027; c=relaxed/simple;
	bh=Wr2td79B+r9s+AhPcI5SiDevpITFzQJN4De46aBnjNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZLLDG12UFcCTlTRjKI3HTmgJLEyku2KgUY4vKgVo5Z30egwhtu3P5TfKo95UlEfJxT30zoKtDa+Ph2BrS+/y52MRLwX2z6KK2NnjRIKBMY7tMqWJfVWMKrGMhsStao7AW3vz4ezs9QFCPAnmHWwt8xmlX6NO9Q7sw+JNLzkfHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2bdrk09; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709813024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6kseli0UeXdP4jDOm34hl8xXaFGMGhj85ca8VAzHhBM=;
	b=Y2bdrk09jDRZdx7rgMqI6S46sMrSa6ZXMhXOwkD5ju3H2SpMajImr4IXBw77VN/mIlgHhN
	hd8MQIyp/6XpYw7v6NQPRUs1xOym/Xr3CHuxb33M2n8eAQZZh8aRvUF4sxxAo18XzDIZHa
	+bWtGoSnxlpIMzJkVKeKaxZTqfGqTBs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-GcXLkBTDOKuO49TywOifIQ-1; Thu, 07 Mar 2024 07:03:43 -0500
X-MC-Unique: GcXLkBTDOKuO49TywOifIQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5672dba9767so811850a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 04:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813022; x=1710417822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kseli0UeXdP4jDOm34hl8xXaFGMGhj85ca8VAzHhBM=;
        b=KtuTthpDGSsANOgb6/QaWjdGjem3MHbigt9WczrLBwMUv6vNj4fBVbmF1z7WfoJvPi
         2IC77MaKlgrZJsXn5Dgw6lDM0iKnb81nRY5WjktipvZxN75zVlP/dOPOs5kuj1Ds5d0P
         Gw2whyS0R1pAZUAnyrpa4RxRxre64oY7yTOI9dmvQDwf8hNdtF2EWkNe4Ueprm7EXV7F
         xDoeTLVlJGP8XkHxfLcCp5WGY0ARnvCmQDpHEfdTf2qMLnbu+apvhZIuK47Yma8Kl7vd
         sOmWpiVVSdYsvC3hmOD+jI7M9dGT4s22rVv8/pXQfGMxYK7SG/H0bvim5DSgmPnPdohZ
         3Uuw==
X-Forwarded-Encrypted: i=1; AJvYcCX6cwBUHzoqx5YDcEWxPZ3bd4BaKLiU3OebKzOQOGWqsleILrxdu1GJfx6L0MxV6p229t+amFnrOuOnjnNyF72fBnRiv3qn
X-Gm-Message-State: AOJu0YxrBbfzzv139DyuOJUm7qp0aY+jgF2W2lGHo6jKEU7QLB0I9ItT
	PID2io3Jw9eTV1SK3UIOC58g+HTWdY6t0K9E9e1Rfg4eNc4TL3K9606TV/nzx5fgd4GBIc71jGI
	hOEWx761sO8Vi38dqWlyT312cmDJi+pP9UivKfH4jZ7t5LrXRpO71YA==
X-Received: by 2002:a50:d692:0:b0:567:dd5:7afc with SMTP id r18-20020a50d692000000b005670dd57afcmr1163071edi.8.1709813022256;
        Thu, 07 Mar 2024 04:03:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4LD66Wna51AJdYmSBOhTnuxJcp7ACwvHnR1/P4tPuT/G3opqkh15NAu2xq6UZAXAMpeRsUw==
X-Received: by 2002:a50:d692:0:b0:567:dd5:7afc with SMTP id r18-20020a50d692000000b005670dd57afcmr1163048edi.8.1709813021912;
        Thu, 07 Mar 2024 04:03:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h7-20020aa7de07000000b005664afd1185sm7965894edv.17.2024.03.07.04.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:03:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 28CC6112F376; Thu,  7 Mar 2024 13:03:41 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf v3 0/3] Fix hash bucket overflow checks for 32-bit arches
Date: Thu,  7 Mar 2024 13:03:34 +0100
Message-ID: <20240307120340.99577-1-toke@redhat.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Syzbot managed to trigger a crash by creating a DEVMAP_HASH map with a
large number of buckets because the overflow check relies on
well-defined behaviour that is only correct on 64-bit arches.

Fix the overflow checks to happen before values are rounded up in all
the affected map types.

v3:
- Keep the htab->n_buckets > U32_MAX / sizeof(struct bucket) check
- Use 1UL << 31 instead of U32_MAX / 2 + 1 as the constant to check
  against
- Add patch to fix stackmap.c
v2:
- Fix off-by-one error in overflow check
- Apply the same fix to hashtab, where the devmap_hash code was copied
  from (John)

Toke Høiland-Jørgensen (3):
  bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
  bpf: Fix hashtab overflow check on 32-bit arches
  bpf: Fix stackmap overflow check on 32-bit arches

 kernel/bpf/devmap.c   | 11 ++++++-----
 kernel/bpf/hashtab.c  | 14 +++++++++-----
 kernel/bpf/stackmap.c |  9 ++++++---
 3 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.43.2


