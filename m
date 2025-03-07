Return-Path: <netdev+bounces-172779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE87A55EC0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB78189816A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9021925BC;
	Fri,  7 Mar 2025 03:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEyqr1iA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5118E37D
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 03:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318586; cv=none; b=qo/bD+gqPHRFMnURkCx4r6tFvaYP7ixadt6TlNUjqfgsbSDlOMoMCJv0zFwzo4cesYOQCgH4dYKHFUaY+kaUlceY9qDF4Eu8WHGfrCnH5XtsZSTUC02aoFNA0COPgzWOK3Kpx9ahEnxXdSRd7+OyzKMIBqp1wPaRm5LqxqLb+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318586; c=relaxed/simple;
	bh=nEoSRHiAe9XP7+KCgD4aWBc7jIoEZ22wWYjhUDwBqjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=moExgmuNxrGOqu769eU09wXVeVpj+S0y7Ec5Sv4xAKGpF1MkjwunBOqPiX6/ZbeusofU8C2ufKmMrTIvgr868Um3NqPS6vE7tlcVfHIuWfslL/BoSKJEXq6kQGYhoAFA0GON7ihjUrqIymbTsqRGFF1Mr2tSmQYJioYoZE+WiJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEyqr1iA; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8f4503104so10777416d6.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 19:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741318584; x=1741923384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KV6qgBEVKfKxqa0B+kZcGXVjZNBvQ7VEUQma+VmEUc8=;
        b=hEyqr1iArriWVsFzyG3iv3QFj2mHgw14hE3Qv5DTPjB9kE4U938yFm/Ct9mZ4kAOkt
         ZjXuRMB7UiAF6aDB0uXIeBG5kj8tgjim/5HC5NH8BrZSvuTr3XPVOyiaxrMVryygkwBK
         YHdWonvM231xU2m5ym2wt6mN6SdO/R/KBX7HMXB+TTzMdUwF10RJSAWp0OCizAgBOscu
         kqokOsclF5QOFZ0fOY+Otq9liYbdoa4858LFa7nPdF7/fn9p16liqzVfB0fHZ7UB5fxn
         gd8CbKSIJvJUBHgOctLrRc0AaOtvZRAAr3ouO8g3xSDBr70V/T4H0NNVPqk4Laj7u9WW
         CuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741318584; x=1741923384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KV6qgBEVKfKxqa0B+kZcGXVjZNBvQ7VEUQma+VmEUc8=;
        b=rAACucu2rR7pFW5Ixo2faTK60m2DkCcDTV8FkVI6C1leKk2xxZOS8EGK5Vgybx3Anx
         JtI//H/9tS6And0Bhv7fiLQCSicz2DCoBjIpdEenDRPUwbO9jeyDXKyt1QLbJn5PPPNe
         eXYs4e8wccE1AKIw/C/nVkJe7oIAb+V8/LzxGmZb4Urw+P5S8jYPZivw2DOZ/sI0Pdnt
         mRvMhlzSUUqb85J5QF4SHk7cRH/6oCsdkKAhFvNgGnX2iMApa1UOSLv3PHFS2O290IVp
         ghJtl6mw9JGcyHJ3ESqvRK/sKdDs6v+WytC5yVi/Nw7rND79n2Pnt1NHykS5E68dwKhc
         +epQ==
X-Gm-Message-State: AOJu0YzMQ24xNkH7dBKlP3c7VVPYGE8iZgRt0jzluqC9DwKtUFwHZhvx
	8JiGNait/zAqhEYNWDQkhKtg6B01KF3y+YyOHxr7+aVrTuR1439VizF9FQ==
X-Gm-Gg: ASbGnctV7WD8Jn0rAqkEFLQzIwSphkB1RxCpakylYpLJgC0Y3xp619rYpshP8cYJClm
	Ja0J2aSI44BfnEdVUt2HeVNbJ/sR33PMOZ+uynPP4Z/XUY1pkUD49+3iLJPl9vk04bduE4vx44j
	jdq7CFPkqfisUEb7bhIcezmPpVt0bNGh8S//nbbxFEf2eTDB6bGDxF/pq6Y5GEsoN2TWMg8s7xC
	8g1L/sqzC2AMOcnj4Lp11+JmM9PWZwMdUHtO7oVzwxKctmMNAIRGT3xr+lqulB2kBa4hj67xv+i
	/QMQ16Nqjjm79j0HvpzDzWAl3l1pQXiDAAvad9wZPPFFeFB6exsWla7tU2bV8mAgzFOyqK0zINJ
	ZOLzghIn7Xa+EGjz1nG0EOufZRTMEPaoJrQXmMXHuXDCG
X-Google-Smtp-Source: AGHT+IH4Wr+erGOC9ftwr2ePXfOAhALNfmqFjlt8924GU9Ki9v4Yb1D7I650KmzCas2to6kk1PSAfQ==
X-Received: by 2002:a05:6214:226e:b0:6e8:fb92:dff4 with SMTP id 6a1803df08f44-6e9005db861mr25016606d6.11.1741318583639;
        Thu, 06 Mar 2025 19:36:23 -0800 (PST)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f71727d1sm14528946d6.117.2025.03.06.19.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:36:23 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 0/3] follow-up on deduplicate cookie logic
Date: Thu,  6 Mar 2025 22:34:07 -0500
Message-ID: <20250307033620.411611-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

1/3: I came across a leftover from cookie deduplication, due to UDP
having two code paths: lockless fast path and locked cork path.

3/3: Even though the leftover was in the fast path, this prompted me
to complete coverage to the cork path.

2/3: That uncovered a subtle API inconsistency in how dontfrag is
configured. It should not be possible to switch DF mid datagram.

Willem de Bruijn (3):
  ipv6: remove leftover ip6 cookie initializer
  ipv6: save dontfrag in cork
  selftests/net: expand cmsg_ip with MSG_MORE

 include/linux/ipv6.h                      |  1 +
 net/ipv6/ip6_output.c                     | 11 +++++------
 tools/testing/selftests/net/cmsg_ip.sh    | 11 +++++++----
 tools/testing/selftests/net/cmsg_sender.c | 24 ++++++++++++++++++-----
 4 files changed, 32 insertions(+), 15 deletions(-)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


