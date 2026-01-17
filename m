Return-Path: <netdev+bounces-250691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9C8D38D04
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 07:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B238301DBB9
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 06:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7C830C62E;
	Sat, 17 Jan 2026 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk83zeIu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD12F39B8
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768632809; cv=none; b=Db2hsfgoPaT6auJW4GCs3zD3Cp4/vWgirQslG1L7H/FVVjW7vtfJb9vRPVK6rdYfkzetPjfoWtAKltFFPXWf+0vZoiAkA3qSqe329D5sQoyx3tbLjou0fttrkDLCfz7Sh9ZfofATS8DG8UowbtSU11GyIMTcsbAUtxkzdK5jYoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768632809; c=relaxed/simple;
	bh=wa6vuB9JRnirEiTJdbuYjUdjPSbw4Z5u3/ha86tPljk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQ9CEXtL+V6AEbLEEsXAtASLxMXZZcoNRJau/K5/bYgTjVsuka6isywsbA7s78Irn9Dk3PJww/g0jJj0jbtF0E9/42tN2SIs8t5EXiyGeyjRQ0wtniKh6k4Imod9gdMhN9nLQYyJ/YSuoioyoas0h+2tMHqOZieyAkzoQ7DwB4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk83zeIu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso948707a12.3
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 22:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768632807; x=1769237607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jl+ikO1mWiP4R9MtrTZgFyugi2SRJMPKhkoPAYsVxK0=;
        b=hk83zeIu05NT3c5oEVgCvqdb057LaSEV+iUbDtsSMbXTjA7CGPrlDccB/lafZ5ROo/
         /scNh5F4DIc8yuAyVzV0o7DzEpEPhTfRyjQ21BuVjiYytAZHhfzbuYwOC9JhfJ7ijg+j
         RUGWPTJiL+UG3n6JmV5ZG7xa6FWWLOdi2uC4LtL9/u6wK8e99mSuy6I5BWNokd6XEln+
         X1aZKZM413nPy9NNWeRIM77mcuLdQqFchmKk/ZcwMtS+ZxV2qvxk61ofpVytSpCCEQjO
         OjohvTBonhIc7oSVdHQX0O6BOADj1tT3bZzODvA170rE0wRQmbHn3La3qI2+El3dW0uF
         mYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768632807; x=1769237607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jl+ikO1mWiP4R9MtrTZgFyugi2SRJMPKhkoPAYsVxK0=;
        b=CrJ8ii/fLVszIPZ9jqzJzRgb0v/au9KSsvhJ36bmNnIP5hCP/e1Lvj/ZgJ16up+IVr
         g6QpxEQGx4rfEjnFhU79f0NbX3heveVe/kn8FG766/cmvDINfDq/2TJfaNAZ32kKgK7Z
         seBtoXGRAwlNuqXfsVpIMaHXjBln5Vwv2Usc5LC9lTXZffvIlGr3t6EsF8ZnJIonkH2g
         N0P8hnzAV8gAL/V4ekTr9qTGh0e4nGxQ+sA9/cdpXftzBJ1zeuzDXX0EbvFzaP108PBl
         wLaPei1IIwTHT2cSyxLfdT/CiJcNHKvDcq9VnazmeyQFkPE9Fzw0uSz7DEsbQhBiMvqj
         iahA==
X-Forwarded-Encrypted: i=1; AJvYcCUb5peN6ACSO+o4PwzQpTADPLMAHZjautBcGMEpzrJEu8wt8equiQo57lHrCj9luRwUeBUn2jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsfod2sjQw+eRRp58aMzCpL0ZNhiYrInWe7NMLNj00rY6Jlre+
	W99dh5jZ5NlZPTWT11VVS+ODjdMc68bLm9FmXiJ5XKlV1BpiP324Nagw
X-Gm-Gg: AY/fxX7P3VxITexOdfAywqf6ynLQWK2huJXxgGH2Rmpd+BayFLRurpp11XLOGtCCfxs
	a/t5d7vVmnuiiQXWOx4RGPpinrQtSlXTa90bIS9dQpSDerswunQgO0uH4OqQISVTDM8a+k54idR
	CZz8c2QD5XmUddbLfqwmFe5gzp0UMbm+ob3NEFkRMz4FAJxrBGs9uAgskyBBFN/Ke6ka9HEu5Cp
	1Yp52/YK2nUSA0i1zgmXQ8NW6vIwaAeFRT22zCJX3C+4z/LS9Eo97NYrFrGRbQdQ5jZV07ILQNf
	J9QNs2BPUG0mmnY2PuNLMTqCx5GOr/aFEDldtiALp/2sBGVebkWBT52l/8m+HVpM465hV6DOGYW
	R2kwnSIfbCXChvBbxpYbaH+UDeRx16n7FF8p4w6sSVj6aW3j/vS9ZpV52nv4Rhq2aVVR1zILsT2
	k1A4KmzzLEOSYZXbiV/LHrxmtvmXI7
X-Received: by 2002:a17:90b:2e08:b0:340:54a1:d703 with SMTP id 98e67ed59e1d1-3527329cef9mr4740206a91.35.1768632807329;
        Fri, 16 Jan 2026 22:53:27 -0800 (PST)
Received: from localhost.localdomain ([111.125.235.106])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf355ca7sm3711091a12.27.2026.01.16.22.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 22:53:27 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: syzbot+df52f4216bf7b4d768e7@syzkaller.appspotmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Prithvi Tambewagh <activprithvi@gmail.com>
Subject: Testing for netrom: fix KASAN slab-use-after-free in nr_dec_obs()
Date: Sat, 17 Jan 2026 12:23:13 +0530
Message-Id: <20260117065313.32506-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69694da9.050a0220.58bed.002a.GAE@google.com>
References: <69694da9.050a0220.58bed.002a.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test upstream be548645527a131a097fdc884b7fca40c8b86231

Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 net/netrom/nr_route.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index b94cb2ffbaf8..788e375537fe 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -466,7 +466,6 @@ static int nr_dec_obs(void)
 				nr_neigh = s->routes[i].neighbour;
 
 				nr_neigh->count--;
-				nr_neigh_put(nr_neigh);
 
 				if (nr_neigh->count == 0 && !nr_neigh->locked)
 					nr_remove_neigh(nr_neigh);

base-commit: be548645527a131a097fdc884b7fca40c8b86231
-- 
2.34.1


