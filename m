Return-Path: <netdev+bounces-80649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55798880287
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804751C2316F
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A03C111B1;
	Tue, 19 Mar 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMeCt9wL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0651118E
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866359; cv=none; b=d9iOoPMixvPBVe4yVigR/9aStlf8QD6T8EJ62I2lTufV8rAdrVLdmrt3mGLzKugWEBKbDqmhikUuBXDGWrn7kxFcxZSwpUgXM9bk3+KuPW8RhtFVrEBPSiQxRKPjxUa08k8yTlbOCHdZwlh2bwv1E2AFEE4bKhAqPuoHRZfc4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866359; c=relaxed/simple;
	bh=330NRIVE/sQ5PP7NpqyWDkzyShDvSmnyzbKIj6cN7PA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TDpQw2qICfPWQSlz9dWjHR2QPW3Kq4FWAlamAB2raOWMBiG9Q9BnXgzDETfJbWhRDlTeaPT9cuwhG5GcZ37JVvigexBiYQWBzFyw81MRF2QUE0FEw90IACuWggeNuf2mVopctuYRj0HXTEb4CdTTXhmRrAw7pK1CSKKupy/1ShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMeCt9wL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41463132ab1so7686405e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710866355; x=1711471155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+WbHprAZscXVpJXyWf2zoNfjiOeMn/sHgClYdMRkYhQ=;
        b=ZMeCt9wL4TuKpHOAJI+gy7FWh6YQSzYaPf2z+1yGk2nTQO898TN+DZIc05nRXFTTGM
         q5lXFewGI03QF5f1ragsshNWyvRtiPfGQXIDVgXUV+BdG+o8P9ucXzTUL9JweXm1o+zq
         fSRukBXxtuYmlnLW46jMd+m3Y4bj6ZfY8gGxRSzILkO3MOx93AtpIR0oqkUqishbAE2q
         4EsamRKBQ2CvPIlrsRaNZb1yp3ffCiCVyTp8c/x5X9l8C4A27/UcbQCp2zVa/ECCplyq
         vlShZl90ayfzKdw0o6Q3nO79R9TUt8lf2IpKG6AcNDu9G7CeHhCdzOd/PdQWK53lH74z
         dPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866355; x=1711471155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WbHprAZscXVpJXyWf2zoNfjiOeMn/sHgClYdMRkYhQ=;
        b=UohCFrJ25GdVSVpSTVCnnGNrJtATs4nlvbjU9we7X/SVww5+VDUjWPW2iJgC9vAhZV
         IaySji25xCw/t7imzmCQZbYg9dn86DaBZezGpdR8xqUPGM7CoeD/9yN80q7DuqY+EL3c
         NNgtMnwvYJ5DlN9TPNRnfjchai4FP4nB4n9sU727MXdBhcruoOXNW/vDmiGR+u02uRbY
         hkzrkwmaQJ2YkrOitbANA60XsF4ejDtXzfN9+DGN1LDjuKhy6seqIHxqaSIqmMkIW61x
         wXHalcInGWhWIoHSxesfgbK8tLf/6B8lMxSA5apB9z16RGcK7nPreuZdz/uUcKFZJpIN
         8Gzg==
X-Gm-Message-State: AOJu0Yz+9O4Wem9OpE7BKt3sXhT3GUCQE2D2XsRVoGY9gg6JtkmnZl/8
	viUY+UYiNU8yHTgzGA4wTI82nze+m+b75eplHID1uwuIvzrompNZjDkBx25PT0Y=
X-Google-Smtp-Source: AGHT+IFBRDk28UIJhXQjCM0TEh7pquQhJyVkjqlm7yJx58tpy1VeMGM6/7z38pVcHWQdfLRhqoHDKQ==
X-Received: by 2002:a05:600c:3587:b0:414:37f:26d with SMTP id p7-20020a05600c358700b00414037f026dmr8701855wmq.10.1710866355060;
        Tue, 19 Mar 2024 09:39:15 -0700 (PDT)
Received: from bzorp2.lan ([2001:861:5870:c460:31fb:df04:125e:e8c8])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b0041408e16e6bsm11220179wmo.25.2024.03.19.09.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:39:14 -0700 (PDT)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: netdev@vger.kernel.org
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>
Subject: [PATCH net-next v2 0/2] Add IP/port information to UDP drop tracepoint
Date: Tue, 19 Mar 2024 17:39:06 +0100
Message-Id: <cover.1710866188.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In our use-case we would like to recover the properties of dropped UDP
packets. Unfortunately the current udp_fail_queue_rcv_skb tracepoint
only exposes the port number of the receiving socket.

This patch-set will add the source/dest ip/port to the tracepoint, while 
keeping the socket's local port as well for compatibility.

v2 updates:
  * Addressed review notes by Kuniyuki Iwashima <kuniyu@amazon.com>

Balazs Scheidler (2):
  net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent
  net: udp: add IP/port data to the tracepoint
    udp/udp_fail_queue_rcv_skb

 include/trace/events/net_probe_common.h | 41 ++++++++++++++++++++++
 include/trace/events/tcp.h              | 45 ++-----------------------
 include/trace/events/udp.h              | 33 +++++++++++++++---
 net/ipv4/udp.c                          |  2 +-
 net/ipv6/udp.c                          |  3 +-
 5 files changed, 75 insertions(+), 49 deletions(-)

-- 
2.40.1


