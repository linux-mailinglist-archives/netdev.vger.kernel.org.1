Return-Path: <netdev+bounces-241506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D232DC84B50
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 12:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C18CD4E0F31
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8556313534;
	Tue, 25 Nov 2025 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayXqMvgH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F97283FF5
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069660; cv=none; b=ZcJRnOFXTaEew0W6rhN6UpLKTzBg3BudHnTxkzGqQDk/FB1tpOvFCmmqIhXDYruAcCgVFfhoDznUSyRJcfr1Rtv0o8s4C4vQRwSV4X4LfbMVlwsBa5QbuTR7/BqBiuGqz9bOaCcaatFVa2cPr4WpsCywxlNcP7eyoBdMSHeEy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069660; c=relaxed/simple;
	bh=+pO67/UPwXQ7TVA0BHQ+gJ/FguPg0+BMI1o/fR1dJYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNkiQtrwk2K8cVD9CYM/ooakdBQiNGucDuCC4jVHLHi28KVmhOKepPqTc+wtabV9TBDPFSjN/1OrbwaL/pVZKe+h1viIxOhU7KnDDw/JxJiqMOhkRckh8u0MwerOsu4SX9hF2hBwzryc4gLomqqy3G+uyQotSN3tlgVVunn3uOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayXqMvgH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso6250823b3a.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 03:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764069657; x=1764674457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/RQnLIjJMU46ak1BF8BcSOHNkyCH+jY3+w0jZc6nW8c=;
        b=ayXqMvgHvLecZiOpJQNr1ahvKwlyvmhUuk4ZTiQh7LkYCI+hotBlbQGv5gSK/LrNQF
         5opnnSp+cco+PRbPUnqRGWKIH7/+LpjeyuBuLfVjTe/axoZAhIG9OqumkAcn7FD0kD/u
         BsV96dvgkCZYYLPG6f51JTBfo7x0f0IGfxTouv8XKZxz4xKpRh5FPrSs7eW4RleGLK+l
         QR/Pb91OI4bBrOx4LAdSuXgV+OnAN1OcwWhB3OMIV5LnifHUj1Th7Hk2gsl2OWNQmpiU
         4MuqKY3cD3V7iXACIF/NOV6bhXktWFp3uBp4b1GUxX6ILvTrmfnd4hF8CyT90JuuZR6E
         C5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764069657; x=1764674457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RQnLIjJMU46ak1BF8BcSOHNkyCH+jY3+w0jZc6nW8c=;
        b=DWjyf/Jhl86YXvQPPHVQhPCeEyqvszDHpX1BkgF1+Wqtx0V/xU8HPDbnNK4ZcOXc3g
         dLQpwKw6j5oFRflvK3BYkivEMDm5pwhVQx0GuhF2+RzphBFd+uyPFjoixQXcQFb0kCBR
         bIRZDHUUaHeuOKsR8PogthRHlYuIRpEtyB+fxunmd4DI9TJCxoSMrctO64l97WB7rBYP
         esi6Q7aDrAPd2lC5hgF245C4QzguLMiPxGRx57aIWbW4v/i07B3+hXYI2LG/BGgrkiSE
         SXfMDQ/xDxsaoZ0EzhonqC4x9hJzg2Kd4BhuPYqW/69iHwN+OhW7XtTzHBbzgWUOBXQo
         Bpbg==
X-Gm-Message-State: AOJu0YzDaJF2csU70t2pChWEyU3+qndaWlhzFUtoYKPX6qg/7UBqmP4F
	5VCYFGIabGe8AFwBLl6CAlbh6qlqWDZc0tGne0YufFMKpfeDyJlEYIsBi2N5Boln
X-Gm-Gg: ASbGncuiVsSBLGGa6NB2iYPM2rU7eqgRc70ScL9rPEUh1Q2wXJ3YPdtyQaC3HTJF4Pf
	Qvml4CEYr3Nyvre4emIanOmiv+tr4Us/chQ5RD/1823lFgM0uWlZL1ESU/hOngO+mReUP/+QUWt
	SWqWVOd4j4+zTt50K2mzom4oQKqjktZ8OGmF+enR7vyvuZaQtQNa9opZZ+srqfxaU+lw7DD86KK
	tHhD+Bw7RIKIzLu637zQCfV24jcL65AIg55s/MdALzM9b9ofVbBlXUe8vb1y872OL2/uMxIeQtF
	vpLgceg/hhN08oKSh+uD401tlvqWaCGsxsB+8iaeVsMj7WEnegCyweoacKReZOEF8vf22JiMrOe
	DBQ3+lOXUjo/0UWiRIKh2Ic7f+yrw8joMEQ123xjrvy56BLgwUdwjIYHoIA08he8eQWiR9W1GQV
	VvygInZlFPvFo=
X-Google-Smtp-Source: AGHT+IET+tkVCovg7YGSN6XuvavDSR832SGJKewtRK0I7BbgFyJu3wVTJePhqRyPewxDr/UEVK5jfQ==
X-Received: by 2002:a05:6a00:3cc8:b0:7b8:3549:85f9 with SMTP id d2e1a72fcca58-7c58eaff12emr14897660b3a.30.1764069657410;
        Tue, 25 Nov 2025 03:20:57 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7c29asm17706343b3a.9.2025.11.25.03.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 03:20:56 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] netlink: specs: add big-endian byte-order for u32 IPv4 addresses
Date: Tue, 25 Nov 2025 11:20:48 +0000
Message-ID: <20251125112048.37631-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fix commit converted several IPv4 address attributes from binary
to u32, but forgot to specify byte-order: big-endian. Without this,
YNL tools display IPv4 addresses incorrectly due to host-endian
interpretation.

Add the missing byte-order: big-endian to all affected u32 IPv4
address fields to ensure correct parsing and display.

Fixes: 1064d521d177 ("netlink: specs: support ipv4-or-v6 for dual-stack fields")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/specs/rt-addr.yaml | 1 +
 Documentation/netlink/specs/rt-link.yaml | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index abcbaa73fa9d..163a106c41bb 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -97,6 +97,7 @@ attribute-sets:
       -
         name: broadcast
         type: u32
+        byte-order: big-endian
         display-hint: ipv4
       -
         name: anycast
diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index ca22c68ca691..6beeb6ee5adf 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1869,6 +1869,7 @@ attribute-sets:
       -
         name: remote
         type: u32
+        byte-order: big-endian
         display-hint: ipv4
       -
         name: ttl
@@ -1987,6 +1988,7 @@ attribute-sets:
       -
         name: 6rd-relay-prefix
         type: u32
+        byte-order: big-endian
         display-hint: ipv4
       -
         name: 6rd-prefixlen
-- 
2.50.1


