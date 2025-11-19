Return-Path: <netdev+bounces-240181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A469C710BA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 21:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2DF434D444
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68E31D366;
	Wed, 19 Nov 2025 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="h7ZXWySL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B622576E
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763584584; cv=none; b=UF8wru4LjV+Orx2cxadrg+T2MTVhQtkipAkdQsn1yfGnOkYE7S8ZanPmscfC2oBliA4aNJVGJ7RAvy7Ig2u0EMP4jEwxbstNWyCioRZpuU/DruPdz4JsWQEyJmzcNh4v9SlR2aie9sYZEninP6Qkii/pefV0m3KOjA6hPMQgLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763584584; c=relaxed/simple;
	bh=V4EZcJWndYx4sqI/Xih3PdrHBbBP/93RfTRnu9igeps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RUoU+vHlH9yoaa/IctrWMJ+cZ/0l044tmlY8E/weUmz2jo27mGi/FcS21XFDfvMCghMO26EmY3toufoKE0TgLyNewZAkgITgf2NrP7R6f+KURPR9O85QgFE5aMBn4AegO4EY6CKzWFQIHakYDOrFDOlXDRXhh5QIT6ad0ih2qcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=h7ZXWySL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477b91680f8so985845e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1763584581; x=1764189381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cvgeiUatJKWoILJFnb4ct5ZMXpTaEnuOhcvheiYqA0Y=;
        b=h7ZXWySLqc8wCfRmAmG/kK9LIo+6GetLEdgB1rzzMp50GCN/+TTfFEl89dn06Xy3sp
         yUhLs6bZxxxfIX05O8VJvtQZN8QWpLMF8l6ZZ3Gag53OY2EBzf2Ou8vcDAOj4eY3zhRr
         l9prkgDG6AdvDcBrMpfdeP6h83tDBbEVcP2pFSL8XB2v1VhTqcWQrs+6egwSsxWpwrgv
         RJN/wHb0lBR/e/kn1RWyDi1fJk1lz4hy9in4Oh/5J2yAsRVuWK1TBS50W5KW6/ak359L
         8/5IGTGf3M7NoQ0La692Kno6vrOJYQqdU5ea/9j2cKmwToiD4WEGJxJUf8kTgbVfUweV
         5Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763584581; x=1764189381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvgeiUatJKWoILJFnb4ct5ZMXpTaEnuOhcvheiYqA0Y=;
        b=FBTiZaEFgaCzCRtS2BgO9ejy/rlaBgv4+J1ZtS0CAaewJ3M9EEUnjoQ/Xg4N94hU/4
         bltxqyNx40JRIaVhmMOH2NUDEUMR7un942VKSP2mRgoqt4G/+vnjxJGfb87HXANH1oOK
         CK69k8QQ5j61wiwwAqJgbwe5N8FqBxY7HlsQ7ssTTqq4udRIz84mSdqm4vRmMqJspZMO
         czok/Dekei6wwbbCB5Y3H1/6pnl2GYtfZIv/jfI8wYa5UzpFPB/SUGEfeVx9DXZ0gtTC
         feGDHJE9zj+xoiiZ9xu1FVv/QBTZsuWsaLcOFDOI++ZSuPyK0vHVq1nZAYfGP81Ado5K
         8U6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLUZb/ELXlnJpSHp3WQ90udMC+Z0kloxT31g9OVPL97/szx0VmKFpRNieCUAxDHbPs+LqBF0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7CAdJlQLqVkIYwKu+QRKPFkqir6znAXnk95aSeAvax99cxry
	GbSxqOo+Z+pX6eqNFOP+RruSEVeCQe2LwS7Feo7BHZXnEoTSH8yl18+J
X-Gm-Gg: ASbGnctODiqXuSXbn7Jvj6Mpr8ekkZE7BBQSQ5el2fqpyqfSRdBDk1zkfSvebmOyG4N
	REZlutsqcEB4EXJ5Zkonz5cjN24TEWIo+FPBp2NNzNZtU2+aSgiaoZaoVqkAxUH/PyotLj+lm65
	QoejqMZm+4XofFCgMAlGX1yPFDlTQMIAaUkLlrVI5sv7fZJqks/OebJheeRvURnEW0i3a8HYayf
	rValFPY+AxWYlkaC0+SJOWMSrBbWWlHjo/A/0rfzohJFndsE8GEcLMiFVtiaT6wLIl2Y9lzVP8w
	DQsO/nDAPkWwNeq2tn1pm4+0WZWBu5y1TK43lXtNesVH5KaZTjnfuy66J5RScnPCgIq3kwqDHf4
	taTavPgMz30ggeKjL9LZBY+GCD+qzt0qGSo9i4VmW2kqomofAx7MvTetLAJpoKwHroPiCuIfj3X
	Qd/B9q2v+BrHfqJzErGRkzDhQd9cdopLKO9OGvxvomEeXOLjr5yNnSzUGFG6kIXG74XRE5MgrGt
	FXapLJwSkkkTqb5n1PjXLc=
X-Google-Smtp-Source: AGHT+IFxHhfLzblZWi70YqQ4HHwzb/5pnC3TmR7XOQ4scw2ShzoVGIE0gUVPv9vT0zVuNSusDCE9SA==
X-Received: by 2002:a05:6000:2084:b0:429:b5a8:5c65 with SMTP id ffacd0b85a97d-42cb9a56083mr79312f8f.30.1763584581186;
        Wed, 19 Nov 2025 12:36:21 -0800 (PST)
Received: from tycho (p200300c1c7266600ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c726:6600:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm1067910f8f.33.2025.11.19.12.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 12:36:20 -0800 (PST)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	ast@fiberby.net,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	zahari.doychev@linux.com
Subject: [PATCH v4 0/1] Add tc filter example
Date: Wed, 19 Nov 2025 21:36:17 +0100
Message-ID: <20251119203618.263780-1-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch in this series introduces an example tool that
creates, shows and deletes flower filter with two VLAN actions.
The example inserts a dummy action at index 0 to work around the
tc actions array oddity.

---
v4: 
- Fix tc-filter-add return error codes.

v3: https://lore.kernel.org/netdev/20251117105708.133020-1-zahari.doychev@linux.com/
- Dropped the patch that ignored index zero for indexed arrays.
- Extended the example to work around tc action array indexing oddity.
- Move to the example CFLAGS to samples/Makefile.
- Enhanced attribute dumping.

v2: https://lore.kernel.org/netdev/20251106151529.453026-1-zahari.doychev@linux.com/
- extend the sampe tool to show and delete the filter
- drop fix for ynl_attr_put_str as already fixed by:
  Link: https://lore.kernel.org/netdev/20251024132438.351290-1-poros@redhat.com/
- make indexed-arrays to start from index 1.
  Link: https://lore.kernel.org/netdev/20251022182701.250897-1-ast@fiberby.net/

v1: https://lore.kernel.org/netdev/20251018151737.365485-1-zahari.doychev@linux.com/

Zahari Doychev (1):
  ynl: samples: add tc filter example

 tools/net/ynl/samples/.gitignore      |   1 +
 tools/net/ynl/samples/Makefile        |   1 +
 tools/net/ynl/samples/tc-filter-add.c | 335 ++++++++++++++++++++++++++
 3 files changed, 337 insertions(+)
 create mode 100644 tools/net/ynl/samples/tc-filter-add.c

-- 
2.51.2


