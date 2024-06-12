Return-Path: <netdev+bounces-103002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13C6905ED9
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 00:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759DD1F2242A
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 22:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F041112BEBB;
	Wed, 12 Jun 2024 22:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bOTuQkaY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDE628385
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232818; cv=none; b=OGXAdGIONpxBMsRZde63a/W/ew1QPgBQLZ1rwPGviSXiyZq2Oh+f5qOqqcFSDFU5rwEGWozNkPQaRW4BD/9m/GBQg3RHr2qQ3i+B7GoOdJqqmmINP3i0aHbinJZxmqNvA6BP57ozDNU22upY3noHZIuF32h2zQks3u+3zO2r6zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232818; c=relaxed/simple;
	bh=pszCrOuQo1Fik91J9ix5S0BpO+yhZF7qRmzWg7dMzpU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=syadRMU3pj+1OEKvJdg4QCrek455vcqRxUFV43Fy0o9rjVmj+K/QbXrqNa3GzHrCTqh/xV6dPuQiMdhERfdE/rdPlR+s1pC9NvJUaOKa1kaDD99jY+6DuXA4j/3UZmM155PhbQgiy4t2dgONku3bS7gEMhjtusE/OpUcsJB2tQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bOTuQkaY; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6ea5a4fd129so312706a12.3
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 15:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718232816; x=1718837616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfjN7rYQ+IFW4/NQWBv0A+y8SOtSIoXaKYSj1kXpulY=;
        b=bOTuQkaY2QRihUl0v79tmY45D1nhidz11ZEMao1OalpmARBVKrQI2JQApDrocHSU0K
         IeB4PjpdWMjbAS3yLq9U0CXMdTFau+qs56dRO75CpkXVzQX5NB+Ke456b2+FhlsjuVcI
         QzrWySLuAmbtLdGQyLu9AYeWHTuSUv+hR27CSf8jr1Dx5Yzd/dRXH4zk/Lh0Jkbzqewb
         SfH9v5jtwt7bjK2JFc6PL8YYXqQXU5UoA2xxQ6vKl+SL0HCEcwAFm9h8aFCrYjqQNxNm
         52L3azLqmeXBJwl2NThXHCm1NV/41deTCQYj61YnuSyZ6vWaxkUNUz3DRlaE2kqfe1+U
         zgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718232816; x=1718837616;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfjN7rYQ+IFW4/NQWBv0A+y8SOtSIoXaKYSj1kXpulY=;
        b=JpKmP3l7G50oBXnT3JMYyXajtfCYvTdFMgSrz9LiUYdPoCvBgWfI99XsA3/CWcAbYG
         bf3F6vNksrJTnvhP3RxsggnRwVDgAM1BqsbELJDACr0xy9SmsY143ShNrZSOAmuJGdRv
         g+Bhy8DPIZzlwLUwPA6THN57RDFU4yjs/46YjrnzylxaET5aWFdgkuI4EuQbt8zYxO2L
         yDldRqDDFWM2uZTJCeG/sPTeD4vPYR88iPozcUFwoBgOJel5pTbfJjahmkFQ+nEbAtBa
         rXh6jSmTESAsVE2H/hkaUetQIlqHTCDd9ow5ve+nErU4MxKnWkvdE0DQHgiuDnxpB4mN
         4iVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgR3fI7Es9kEV9h/kcs0+mSsuIeKkHRfxfTIBL9R0xiNKR0qejJHqMrAHUNnTMH52UbrJ7+zQyWpDnQAUnVxcVHt1Tkthv
X-Gm-Message-State: AOJu0YznG2Ggd86PlsihQOZXb5N9KMwHkHDVLz4RHrzaEnQ9prRxszQl
	7sY3GGrDs17XK/RuZdhshpBIdqVf5vif0snhVD4stwzk7Qz3NcVxI5yce6+aMNIbHw==
X-Google-Smtp-Source: AGHT+IF02DGIaR+GIFi1y2P81ozs1UNwFUk+gYrRQb7B31ZSsg4ekHdJy8EPVLDXr5ZJwQ8ozyOCHDE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7d51:0:b0:6f2:e267:443b with SMTP id
 41be03b00d2f7-6fae1059604mr6893a12.1.1718232816470; Wed, 12 Jun 2024 15:53:36
 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:53:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240612225334.41869-1-sdf@google.com>
Subject: [PATCH bpf-next] MAINTAINERS: mailmap: Update Stanislav's email address
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Moving to personal address for upstream work.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index efd9fa867a8e..909ed91003b5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -605,6 +605,7 @@ Simon Kelley <simon@thekelleys.org.uk>
 Sricharan Ramabadhran <quic_srichara@quicinc.com> <sricharan@codeaurora.or=
g>
 Srinivas Ramana <quic_sramana@quicinc.com> <sramana@codeaurora.org>
 Sriram R <quic_srirrama@quicinc.com> <srirrama@codeaurora.org>
+Stanislav Fomichev <sdf@fomichev.me> <sdf@google.com>
 Stefan Wahren <wahrenst@gmx.net> <stefan.wahren@i2se.com>
 St=C3=A9phane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@linux-foundatio=
n.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index cd3277a98cfe..cc38da3510ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3980,7 +3980,7 @@ R:	Song Liu <song@kernel.org>
 R:	Yonghong Song <yonghong.song@linux.dev>
 R:	John Fastabend <john.fastabend@gmail.com>
 R:	KP Singh <kpsingh@kernel.org>
-R:	Stanislav Fomichev <sdf@google.com>
+R:	Stanislav Fomichev <sdf@fomichev.me>
 R:	Hao Luo <haoluo@google.com>
 R:	Jiri Olsa <jolsa@kernel.org>
 L:	bpf@vger.kernel.org
--=20
2.45.2.505.gda0bf45e8d-goog


