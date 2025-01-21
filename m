Return-Path: <netdev+bounces-159887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D03A17538
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 01:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B41168BF6
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCB07462;
	Tue, 21 Jan 2025 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaKsF0xl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB8610B
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737419245; cv=none; b=cl1Q6maYZOvpWXliislNRxC7mWjfMjK9rBAPBZhpDq94mNB63PbO5ywAAWubP0SRKY4QTIM6+kuMatz5Hvt3tN1be/sZ7I7d4pRkCwR0VP26d5kV3rkjx11ZWna1YOy8jXsUqWHOTsuPXZdHpDycVpsVKd6C+thLPONIa9MrUY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737419245; c=relaxed/simple;
	bh=k230KRaXjYdYyWDiyf2tWyqR3QJe/m0Cbw8Bks/cqhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vlt/oIExbOne8n9hcuXPUkGtKdNqGFzu4ImTXKgxd0wiP80Ulluc+lQu3/gfchg2H9A1wkRmitColD531fwsE39FPlB9LIHBvu32v1sflPUo2W+YqnfKOoTQ9n0i5+UnUZwd3vW5YKpdfZl9IUKV4FpFcO8P7tm5f5yDBc795ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaKsF0xl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21628b3fe7dso87174175ad.3
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 16:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737419243; x=1738024043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gF6TcDaGu/okKK1Rk5Cgpr/ymzlh/pXmYkRvPh1k8x0=;
        b=KaKsF0xlRJHtZW/N3CbSyYMAXtOrgCFH9ng4OAVCYWyGerDrzqQ2TCi+dj9pJyzoCq
         UOf0c0IuZIk9lbZyicInGq6MKIg8FvDQtEfpi8HBGy8PTcXWtug5Cxq50Q1ErqPVQQWf
         loar9+v3sTZVjMfYfS2e9+gVzSDrnaBm3UWc3i1iLgx1b+QjUWKf8aTx8RpBguqK8Ut6
         RuvbK8rFjyl6oCgZAGvJqmxLCYk7TdjwxjeUVQAyg92/EKiqxuR5lEli3ySLArvITfx4
         W38OSy6QgWDDzvnbdyaE4VeBhdFiW8H5N5Uk/999zMPLbIn8iK4RvEN9GyeuEjw0YM2g
         k38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737419243; x=1738024043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gF6TcDaGu/okKK1Rk5Cgpr/ymzlh/pXmYkRvPh1k8x0=;
        b=DQaTgtxkrNWQVIGwlxjn1N1RxJrKH4lEgDpyXsOWYdjVYBZiAL4RGDBnXFsP9vA3bi
         QYFclJwhKEDMEXFyt6QlrW8fqkfpnRPIrVtavLYG6g9hrocKT17f5Miiw+jjZDfGd/my
         GsE+BWosTYE9b21FE5WN8FREV24qu6u/FrSugC5r0+ll9NvpvrVbyIvvsVfOSnLgw1mb
         mJqMTN2bbFi1ylepqa3fTMNhZFqI0VwCRddHkhoj1r5CHF6jFILwDD5Ea52cXB7R+r3l
         syxEA2Co+s1PUwyfJgBLT3K+Cfy2p+cOMix5GQ+U43r+Cprd+awR7s3+MwtTljHVuDBT
         YzQg==
X-Gm-Message-State: AOJu0YxKNzBURVIx1V6FrEW44EN4cvU2fdocbzMRCWfXbPVIJd96SFZ7
	MxIkBQktFhtUT0yiAX7Bkiz8JqZk1xACPPM6Rqlb5DD1jxpqtXgwheZoTA==
X-Gm-Gg: ASbGncv2v7Z906L++YqDQ+JqPwdW7vUdct4+dU1H0ZdMZg2w+b85GItcY01u4w+tyfz
	Od+HO33qkbyC8yDvb7m1trR2R3ynhmOnbWeZ+OzjUd5hUZ/v4OjxYv9Jtij+9uz8OJ5RUCU3jk8
	NoroB2k1T2G//0C4pKxh0TrxxbDe7IVH5o9Yclov568WZPuxA8bDGy1jSUedqwCCdo1q93BwC9O
	24bpxtjO1pSvH1921uU5IGXYCUkQ5EyM3D1PWMvm+E4M99oyZYNJq8k2+j3YM8ZiZQtSIUFivyi
	/qETPsok9kwlp6KJOprtCOiJq0wyeVHDLAGF
X-Google-Smtp-Source: AGHT+IElw2DSEYJH5bNPwbuojm1BOCoO9mZzdLA0caSm20P0IgQhsMRuplk/Cersit6AWgc3K2J/Pg==
X-Received: by 2002:a17:902:d590:b0:216:725c:a122 with SMTP id d9443c01a7336-21c35512745mr244601815ad.19.1737419242821;
        Mon, 20 Jan 2025 16:27:22 -0800 (PST)
Received: from dev-VirtualBox.arkhamtechnology.net ([104.6.233.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d40278dsm65323295ad.223.2025.01.20.16.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 16:27:22 -0800 (PST)
From: Nathan Tran <ntranswe@gmail.com>
To: netdev@vger.kernel.org
Cc: Nathan Tran <ntranswe@gmail.com>
Subject: [PATCH] ipxfrm: Make xfrm_selector_print() output port ranges based on port masks
Date: Mon, 20 Jan 2025 16:26:52 -0800
Message-Id: <20250121002652.1377138-1-ntranswe@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When listing policies with `ip xfrm policy list`, selector port ranges are not
displayed to the user even if sport_mask and dport_mask are not equal to 0xffff.

Here is an output example with the patch applied:

root@f2a56a327b1b:/# ip xfrm policy list
src fd00::2/128 dst fd00::10/128 proto 17 sport 40000-40031 dport 40000-40031
        dir out priority 268563
        tmpl src fd00::2 dst fd00::10
                proto esp spi 0x21900907 reqid 1 mode tunnel

Signed-off-by: Nathan Tran <ntranswe@gmail.com>
---
 ip/ipxfrm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/ip/ipxfrm.c b/ip/ipxfrm.c
index 90d25aac..3605c718 100644
--- a/ip/ipxfrm.c
+++ b/ip/ipxfrm.c
@@ -443,10 +443,20 @@ void xfrm_selector_print(struct xfrm_selector *sel, __u16 family,
 	case IPPROTO_SCTP:
 	case IPPROTO_DCCP:
 	default: /* XXX */
-		if (sel->sport_mask)
+		if (sel->sport_mask == 0xffff)
 			fprintf(fp, "sport %u ", ntohs(sel->sport));
-		if (sel->dport_mask)
+		else if (sel->sport_mask) {
+			fprintf(fp, "sport %u-%u ",
+				ntohs(sel->sport & sel->sport_mask),
+				ntohs(sel->sport | ~sel->sport_mask));
+		}
+		if (sel->dport_mask == 0xffff)
 			fprintf(fp, "dport %u ", ntohs(sel->dport));
+		else if (sel->dport_mask) {
+			fprintf(fp, "dport %u-%u ",
+				ntohs(sel->dport & sel->dport_mask),
+				ntohs(sel->dport | ~sel->dport_mask));
+		}
 		break;
 	case IPPROTO_ICMP:
 	case IPPROTO_ICMPV6:
-- 
2.25.1


