Return-Path: <netdev+bounces-86363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2F89E7CE
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 03:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26037283EEA
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB83623;
	Wed, 10 Apr 2024 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPqwhnyV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA8A59
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 01:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712503; cv=none; b=rrEIt3MEJ6dzOtTYeN8gH3N2PU1Ewa2b0EhidguFWKRNIkqYtqj667eUMv2h0ChI6V4QBfZkwDlxNkVtuYGFQ/D4Ztm8whw9LVZov8Ko/HBt0jt1tMxq0yP9fjbsXgIFeVkeHKd35oz12g+0VieT3TeoWt5beud+t+4Y/ORP4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712503; c=relaxed/simple;
	bh=/j349q9IGQdiUeT4ItAArHhJamBQcUqvyte5BqF71bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EibEBWwNboPUNz01JfnWiJebxeq9qEnlOMkaX13JN4ya4OdcfQLv1MWKMxdzhPGGe4KaxlJOXCxRnKP3dAKn6xlSi7WBJuKoA3L7QqEwFkrC1qWPiJKn3rX67Jn3CHN8+DGJceq4108YF7F7ANFCd0d622wWzcNRIf26+Q3/yOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPqwhnyV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-416422e2acbso18652565e9.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 18:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712712500; x=1713317300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1kWTD/vBXlnPs2YYqWSnV0Or2EDJyt+1vhrcE4lmBU=;
        b=nPqwhnyVv60Q5PhdXBHgoHBqOqRHembu1nOwY3Foj/q/4rzgK7ZMWZj/3R0fGVFe58
         LD1xo5546D0D42D5hjWaUlhT3pqNm0ac+ECvHz3B/k/qe1lsEA64TAHh62evJuG3SBI4
         7KuVcNu0ShdTjwAzRb67jBGxSQKaRR8Pn1YjINjP8t/9STIqGiLVkerirm62AFQfR/y9
         kT39QVpgh5fvbFBYSk+f0wfk5AfYdqwTRDn04CrpoDcqDTMRvVGxIzlabve9wLePEQAu
         b/sbplzlzrLWR8uWNA5JaC1zfQrHA/lk4V1FE5hXd2W0FPwoxg0+uXS4N9stv8g7JWBH
         qjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712712500; x=1713317300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1kWTD/vBXlnPs2YYqWSnV0Or2EDJyt+1vhrcE4lmBU=;
        b=SP6lsNFSCHppy6LS/1fXUG7RIYfhBcHERLjELW6I3IR0Vh/z3G4BkZnCORRo7W/D6D
         xaKgDc3R9SZiT9js8RuF4PbaHsyiLGS+kGQIsIVGRdUJFAqBBgbdqovEXP/yM3JgKyF6
         MT4uB+wvPOOuc5RoP+lZPdz9pTuaXHieRXUgsTnrKZqsseuTyO42XUZNcRhQePfO7TIe
         IN1gEIlQIOT1VcrwQhbi+wtcaOU1cuRKI7EjjHTz/GFMeNGSngbAavvXbZgkCvwmbJQv
         uJfB65u297TH5ZgsBIX7Rlqk4GvGPms2XpwLAI5IvgLyvYG5Cyq6d6hQjth6KXZ3iCgr
         4JVg==
X-Gm-Message-State: AOJu0YznzbZoIuhUp4+t7/eiqhAsQpxwEsf3AldCFMDvTtJHBOJhLzaT
	45x2B60o4LO23gc6X+nmNRL7B67biDucVHKmXbvVwSsojFlV1+13bnN6nz0W
X-Google-Smtp-Source: AGHT+IHvrLdrrcQoSifJO8n8oXDz1fcVxo9IwP8fpa/UKd7DjsRzUv1owRfOauJ7i2/GMgo2unfXVw==
X-Received: by 2002:a05:600c:1c92:b0:416:9f45:e64a with SMTP id k18-20020a05600c1c9200b004169f45e64amr2996783wms.13.1712712500428;
        Tue, 09 Apr 2024 18:28:20 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.132.24])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b00416b8da335esm659522wmo.48.2024.04.09.18.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 18:28:20 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH net-next v4 0/2] optimise local CPU skb_attempt_defer_free
Date: Wed, 10 Apr 2024 02:28:08 +0100
Message-ID: <cover.1712711977.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimise the case when an skb comes to skb_attempt_defer_free()
on the same CPU it was allocated on. The patch 1 enables skb caches
and gives frags a chance to hit the page pool's fast path.
CPU bound benchmarking with perfect skb_attempt_defer_free()
gives around 1% of extra throughput.

v4: SKB_DROP_REASON_NOT_SPECIFIED -> SKB_CONSUMED
v3: rebased, no changes otherwise
v2: pass @napi_safe=true by using __napi_kfree_skb()

Pavel Begunkov (2):
  net: cache for same cpu skb_attempt_defer_free
  net: use SKB_CONSUMED in skb_attempt_defer_free()

 net/core/skbuff.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.44.0


