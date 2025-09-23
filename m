Return-Path: <netdev+bounces-225710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAE5B976E2
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2750A2E37ED
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1683F28AAE6;
	Tue, 23 Sep 2025 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5X82eTK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563BE21B9E0
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657648; cv=none; b=r9fezArmDC8QXUfvR1ZUUdSLMIOmnf1RmUUDcdOCGfD6lXq64tGugXTAb/V0Wo2iYlP1UL8f1JHIQIczflcOjkVfjRTq2OcdUe8FTPvL9MVRhJ+AWdXsChLqImEh0U9FtNs2n5WoDGW+eEwG/Y4hGisorwQdwkWJRDOpYKmP3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657648; c=relaxed/simple;
	bh=yC887JdsZIuNAU3KH0iM0jpa/sF+QL795+nxAjAlvwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFYdRxdD7fFumDmiHA8FkVYQ2Kk0h+BM500cspU7L1v9ZFym2asyzTHdRgBcpJtiJnvlYR5p4sQLytTl1LREIV1We5+5D7lDsxUVg6XDgAKF9Qp/dvod6PtvV/iYd9mEr4Cxv4kxbaZ2+7umBUSjkaskjrcmRqisS7wGRwCnItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5X82eTK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-628f2102581so625222a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657645; x=1759262445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kxnKEunBUq6lbDqWLItziPs2zbuhFcil+VxDU1uLZ8=;
        b=O5X82eTK2Ic9pgW05Mpn9VtUYSRhRrD5rv8wLaoL5KvlQwIptkBt3mDTMWiU38R6wB
         v9a2MFTMc+e4hIZtXJnkHHAQXsE8IYw8QaRMHV4jeZ37YmLN5uWArwXGGSAgIxrrn3d/
         O/z36Sa2X7NOPsTnPuBKzigDBDVfFIghVVxNdi4ANvaScoOUA3S4VszsD8wNxl1dWFE/
         BDulN5aO7QCT+obG5cABp2M14IAyrJdwURTQ8JdZak6x0lflIV92fw6NykI8rouycb9P
         T3km9rpRd1jQmbiLZk+UUV86EBE23sGtvrwKJyZIFZVqRSg0ng67T8NY9AwVIMDc026Y
         vAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657645; x=1759262445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kxnKEunBUq6lbDqWLItziPs2zbuhFcil+VxDU1uLZ8=;
        b=Xi5pp5lFKMWiACTFmauB6Xy+eXlDhOXB1K4ba8QyizHa3iHEqcd8e3wXKhzab5T6Ps
         P/nm21QF2euhYJCN2ZTucIkDq/bODXXLJKe5aRizaMux2Jkzma+SDe2/m0hikZddK/QY
         Nd1FKsgPs4LXD1+Q3lzfQfCjGBIr6LulsWu8ERJpbnpLxUh2+18ASFRxmJA7/S4zpuvU
         Ix86wgcRi+Wfy5mR/8DB8TSfnvZlOW6BaRxdoC49csbK9OB9zf3CtPfO7gjI2LMU+4tC
         N7dedMJTne5bh39C4UCmi9Ddiw3Zbk1X/wySOr6VWiFi85dtshAyVCC/81yiZUvMoQ0s
         fHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfVSUXiTuzhPk7v4UceVa6d7rmQMmKaxjHeBS2pMvvveer7SxiGVel+ubaBl9QSZ/Z+19hlHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCvchu2I29+YBC6VL3hGDrH3xLX3iPSerpiAadfBLrgq12iR8U
	b9k9ClexWITupTsGpefEQRDQc7BN8HE4sX7d26in0O4oV9Pj4IP9GiOc
X-Gm-Gg: ASbGncswwlsxBUD5/5qj3sWluq/RgZUF1vTyGLyeFVl1Bdf8/u4Zeo2gwcCDj+u5giC
	O1gaDJnCM+vyrYZbLazO/pV2CVpHu9RaVdviuX9P1bEW3QuGsyk0exQyzuKP8ZD9loWabd9CwLu
	qbhoqjSvRTNdbmbT5CvYd4mg0/pDcIoTH4m6iTVG9INH7RbV/hm3P/xkagWXqzkoc4ga4HuGkkx
	fgZAS17wFAfUH8h4Pf6uJqTsSkEsJnwBO/XWIv36BOCvV2/qr9wRJYlBRyJC4aKw3kruRZ4DK3v
	pWRJr+1D/tNBfcvMJ8Pm1vAufaIfwIq9sFbvSnFzZW7Lk1VovKh7OfYbbnvYidk63aG5UqBPyJc
	zkBUIzYPKf761d882do4fmatBs92u1WAJ6QPNV9KwtAY=
X-Google-Smtp-Source: AGHT+IH0sk2UMFhq8ILkVNhalVb23fPwThZEi+o2vb0yPrbkfalsoc549TsjUa62bG1KSNKQmFvZBw==
X-Received: by 2002:a17:907:3ea1:b0:ad8:8c0c:bb3d with SMTP id a640c23a62f3a-b302745d8acmr203295566b.3.1758657644360;
        Tue, 23 Sep 2025 13:00:44 -0700 (PDT)
Received: from bhk ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ac72dbe92sm672074066b.111.2025.09.23.13.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:00:44 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	jdamato@fastly.com,
	skhawaja@google.com,
	dw@davidwei.uk,
	mkarsten@uwaterloo.ca,
	yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Cc: horms@kernel.org,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH RFC 1/4] netlink: specs: Add XDP RX queue index to XDP metadata
Date: Tue, 23 Sep 2025 22:00:12 +0100
Message-ID: <20250923210026.3870-2-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices will be able to communicate received packets
queue index with bpf_xdp_metadata_rx_queue_index().

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 Documentation/netlink/specs/netdev.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index c035dc0f64fd..25fe17ea1625 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -61,6 +61,11 @@ definitions:
         doc: |
           Device is capable of exposing receive packet VLAN tag via
           bpf_xdp_metadata_rx_vlan_tag().
+      -
+        name: queue-index
+        doc: |
+          Device is capable of exposing receive packet queue index via
+          bpf_xdp_metadata_rx_queue_index().
   -
     type: flags
     name: xsk-flags
-- 
2.51.0


