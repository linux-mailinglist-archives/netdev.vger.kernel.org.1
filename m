Return-Path: <netdev+bounces-115288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C29EF945BE1
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07894B21B27
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86014C5A9;
	Fri,  2 Aug 2024 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReqdFJ6q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D514B962
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594081; cv=none; b=GDQ8lY56xsHgtTdJb1oGfke7XCvyX+TnnTYtLxPJd5bGnJVFLJ7rBGvjwbm2HCjWHIkYUL/TcgfpJCQ0iqcisaCHCeJMChksCbJsCedkiPaAgFfVUfqvpH1J+R+OKv+rvgMw5PanfwpFVHo7GYMBh6qtOb4LdXa9UfP1owdmtpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594081; c=relaxed/simple;
	bh=swtOBPZq4WvScvEVGeF9w9z0uTM2T95cCrLl5Z/X43A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QMS62kvJmELmUJx8uohnD47cUr3Khk6t1fBp+M60wPOGY+pRqCeDkuqJua7HKxEVcHXR8FN5vXJ0/zKLzyn6obu4Gkb6DkOWref5j9lhPMiO3csqpu17+xLyIStiiy/YpKywgw/HiTxKciEr4ZO5yCDkVDoXCdTrzfo0/5EHmGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReqdFJ6q; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7106cf5771bso959919b3a.2
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 03:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594079; x=1723198879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RB4Srv6NKyP3H06K6N5TpRjgW6p9XL6wJIbvbVXiEvI=;
        b=ReqdFJ6qNygDhom5GyObKnKtxKlZev3Kr0kPfyB5Yw1RpCVzBoVOLUkTmQT5d+lukc
         Mbhtbghb+sY9jzeoFYovZfPUS/3wMwvKv/oTjTvBkD5TRIwLAcG2rsu/bEv7uKv/OdSS
         0pLR6vYOW6xNy5UxajwL+bSnn2Bs/WNEQ5Lxt0SFtaHJW7j5ZKJLqcrcSd8NZpxOXktE
         DWZHxmEanl6s8okFWfgzs5jK6jdSWK+XF2JlVCfZtN/fZkwva+IU0yzcH2hW+tVSOXOk
         vBo++nYTkDfAQm5uM2hh3T89JcIlWvmW85tLDiRWQVPx+jIqEVZmvUiTlumSLY/Iw21z
         h0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594079; x=1723198879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RB4Srv6NKyP3H06K6N5TpRjgW6p9XL6wJIbvbVXiEvI=;
        b=PaHmhpJSUQFZ+LYxfsWc7jK9zySyHmaPR3af7davdS4mI4UPAT/gciV24kIohlP54U
         ETd6fTTTK6TvpiTwwcIGRUZLe4GrhrYUkaKwk8rFRxIg8SpTG40QWcpfQCBzBav5D6kY
         cARhUu2BJES6Vh7TRaHiIeau5OkvJoBYbXkxKg5nL5X51dBXSDze3R7gRvwDnJQ1Xnzo
         DSH8XcotPbiCKvkqUIITfSOrDnsuxyeP0oJnKBrJ1wFr75UunjztgjU/jK9rnEwgQYen
         FLdTRg2RC3GzD2j2+T5ETTRBAh3IX6KZDnvJ89KBiL9zALV+vuziSuVMZNL98Is+pEVm
         Cp4w==
X-Gm-Message-State: AOJu0YxOWmG3mpAGiunWCLAioPbj+pwjIXxrW8NGIKSOUMWRfstBktdE
	96nfkoUUh5IRmALtYuuOsEDJ6vLedSeQ5FqlrGWAJoSz+hfbFXLQsbF3t2Dh
X-Google-Smtp-Source: AGHT+IFG/66qpRDI0g/+GQfhHJf//q1fZmlOWKPszX43WIZwK73q/jlGJ0WIwzGTF2e3yURqMM0yEQ==
X-Received: by 2002:a05:6a20:430d:b0:1c0:ebca:eaca with SMTP id adf61e73a8af0-1c699555468mr4620789637.12.1722594078960;
        Fri, 02 Aug 2024 03:21:18 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763469e79sm1109050a12.26.2024.08.02.03.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:21:18 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 0/7] tcp: completely support active reset
Date: Fri,  2 Aug 2024 18:21:05 +0800
Message-Id: <20240802102112.9199-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This time the patch series finally covers all the cases in the active
reset logic. After this, we can know the related exact reason(s).

v4
Link:
1. revise the changelog to avoid future confusion in patch [5/7] (Eric)
2. revise the changelog of patch [6/7] like above.
3. add reviewed-by tags (Eric)

v3
Link: https://lore.kernel.org/all/20240731120955.23542-1-kerneljasonxing@gmail.com/
1. introduce TCP_DISCONNECT_WITH_DATA reason (Eric)
2. use a better name 'TCP_KEEPALIVE_TIMEOUT' (Eric)
3. add three reviewed-by tags (Eric)

v2
Link: https://lore.kernel.org/all/20240730133513.99986-1-kerneljasonxing@gmail.com/
1. use RFC 9293 in the comment and changelog instead of old RFC 793
2. correct the comment and changelog in patch 5


Jason Xing (7):
  tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_CLOSE for active
    reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_LINGER for active
    reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_MEMORY for active
    reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_STATE for active reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT for
    active reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_DISCONNECT_WITH_DATA for
    active reset
  tcp: rstreason: let it work finally in tcp_send_active_reset()

 include/net/rstreason.h | 39 +++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c          | 19 +++++++++++--------
 net/ipv4/tcp_output.c   |  2 +-
 net/ipv4/tcp_timer.c    |  6 +++---
 4 files changed, 54 insertions(+), 12 deletions(-)

-- 
2.37.3


