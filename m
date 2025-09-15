Return-Path: <netdev+bounces-223030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E9B579BA
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5804F4E1898
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1D2FE56D;
	Mon, 15 Sep 2025 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC8+z+NF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB29029D28F
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937770; cv=none; b=K/3M72COgPgT7+T1CXkD/3aDUG4JQYP3+jbwYN5BIWAjK9E8gZquiI2zHF0C71JaF7zw0A4w5d+xDIJWMWL8Z1vBhwHzWqGEdokNlMbe3WGC0e/+5LTw1Rg8rLlAxP3O1+YkecjLgY45Mefnz8jHht/Ybff/gSi1J4Z/nY/7Wd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937770; c=relaxed/simple;
	bh=cUwrirv14DBboYnsPVskwlwITnPzhHN0hLBk26HJT4Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qMWifqbM3sk1y/Ude3YRFzVVY3g6jOKYd3gw+TOJsMcndvLE0gjoTZm6Rap3Je2v873rDhMxEkOiReulwy+oS80bL7CD1yKDJvOa93IYIxuEiCV+lZ0kJJAUuDJr5fAhcF8tywlhwOuj5UEScp/gc0yyVqvOM/BWjtbH+a6J+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC8+z+NF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so6580195e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 05:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757937766; x=1758542566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Co9ePXVYONhWQLJUpPDEvS8RJui2bsGLbg4TDMCSs/I=;
        b=WC8+z+NFdaso5wl9COsFOt2enyiDF49oL7ufXwcsEispwLHd7pNYjCtvFn21q23kxS
         LTWj5jEbsOk1VhkeOjjMLxjIRuWQDoZFA/0g3Bzv1YzJ+AhgdeA0xoXTxXxdCth6wrx9
         FoJfHmlGEZbBZen4KeEdi1GL37zszwcep6A8JP+qq9B1Kh7RLYL0DpSYlpgF7BRNBvbw
         qgKhpwNBm1JRsP2vNr0lch8lbfzVo0AgWTYPS5qvyileBmruxIze/8HIqE6KA/3P2nua
         fFliXDeNhnNH5BIIhylw54dRkOw1FtRHGQDg9KQS6zyI/Lw5Vsyf2dXmsj+4wGhuIaL9
         inFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757937766; x=1758542566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Co9ePXVYONhWQLJUpPDEvS8RJui2bsGLbg4TDMCSs/I=;
        b=fZR4RKta/nyCHAFE9QGG1O/mqSHj+UEjiaz+2ilzL9Lv56j9rdidsQBRlH5A2iH7aO
         Y8jrRAimvZ9TH59g4tq35v/IUS+w2PujDvs10UP1v3O1nxQEsREI0HovWRaqoEXEKrWJ
         j6V+BhR329xakjRBizF+dfP2fbXWd/D+Ih6XrD9JXoVRxgAw9Q5AKUiLj5vgTFYvhKJ7
         H6hrosIhPKm35RBUfc1gyeI6k2USG3MwEf59NEzHMxN1G97aotMMes0jtqr66fDrhqSz
         Y98OhCHHRu0NEsyx0DcbtD5qU8jLBNKXC3T6hFE7Icwuo6sFEcy3766nbya+EqFJjPGp
         xlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHotvmAJXClu106+jxfRcxMm2VlfSAGX6n+ZdVPMbya4CA5/R6dera6iiKKYahq6Bu905NzDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYVMIFbyJvl/aho5WkdOU3jH3ISJ97AWYBGRMjWT3mmO6+BSq
	D21B4iUd458F/QeeRkwdnV6I4GZVi4Wc4sewatVcadJYI4tUtuvJaHle
X-Gm-Gg: ASbGnctUy/GQf+f6Z6Atl+o9SErxyjklY5B6nqNPqQ0Qt2Dn05OehHIcizgNsjsp5Wq
	wB7vKQfXC+sMCpep+oOTwpDrlQmdCwKVBPr0tLfD4TlcCatkLfA3zsQldUrgeyNsIdiR32NdoIe
	paLzNwKEaYrwRwywGXTVVtW/V7NHL6EuwYQ/xo5y9hHPh9cSFKiv8XD7dE6oRWM6oBWWkmy3zZU
	TbhBQg4m7hsLXx6Vc+V22Lbhx/u+z5odaJ0zOqZHyKJh2f9FH5+0pI2qiBFU4NCSJKbaZCEx63Q
	w1WlGb01Or1mIMS0mw9+AQNmaFq7qeoBnexrqoncQcKGMKJxkg5QbiiAnvKUxlvmnwZTY2VTBbY
	h1WujQQb6Ltn9KzyT/5YvqIW/4FuBaS1VGXOYE+/P+oF0Ny5wbcdk33SRGeQB8Iu9D1yMW1YR0i
	1U/x4CrFjX1GrQ6J/ruzbWNQV7YHR1sls4z/k=
X-Google-Smtp-Source: AGHT+IEuHi+LL9mdUJP/ePM8DLlcg6AV4xdLkySUG3V1VhzJzzhIAA8SXDdJ8L1ra60yKZp61XRXWQ==
X-Received: by 2002:a05:600c:1911:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-45f211c8371mr104236825e9.3.1757937765866;
        Mon, 15 Sep 2025 05:02:45 -0700 (PDT)
Received: from VM.ger.corp.intel.com (h-158-174-22-45.NA.cust.bahnhof.se. [158.174.22.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e80da7f335sm11051443f8f.8.2025.09.15.05.02.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2025 05:02:45 -0700 (PDT)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	andrii@kernel.org
Subject: [PATCH bpf] MAINTAINERS: delete inactive maintainers from AF_XDP
Date: Mon, 15 Sep 2025 14:01:44 +0200
Message-ID: <20250915120148.2922-1-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Magnus Karlsson <magnus.karlsson@intel.com>

Delete Björn Töpel and Jonathan Lemon as maintainer and reviewer,
respectively, as they have not been contributing towards AF_XDP for
several years. I have spoken to Björn and he is ok with his removal.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 CREDITS     | 6 ++++++
 MAINTAINERS | 2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index a687c3c35c4c..e47df5e74abe 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3912,6 +3912,12 @@ S: C/ Federico Garcia Lorca 1 10-A
 S: Sevilla 41005
 S: Spain
 
+N: Björn Töpel
+E: bjorn@kernel.org
+D: AF_XDP
+S: Gothenburg
+S: Sweden
+
 N: Linus Torvalds
 E: torvalds@linux-foundation.org
 D: Original kernel hacker
diff --git a/MAINTAINERS b/MAINTAINERS
index 9b85bd818b25..dacc5b86886f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27453,10 +27453,8 @@ F:	tools/testing/selftests/bpf/*xdp*
 K:	(?:\b|_)xdp(?:\b|_)
 
 XDP SOCKETS (AF_XDP)
-M:	Björn Töpel <bjorn@kernel.org>
 M:	Magnus Karlsson <magnus.karlsson@intel.com>
 M:	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
-R:	Jonathan Lemon <jonathan.lemon@gmail.com>
 R:	Stanislav Fomichev <sdf@fomichev.me>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org

base-commit: 22f20375f5b71f30c0d6896583b93b6e4bba7279
-- 
2.45.1


