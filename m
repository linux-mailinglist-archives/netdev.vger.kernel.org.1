Return-Path: <netdev+bounces-172780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F0FA55EBD
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98203B4680
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6796193425;
	Fri,  7 Mar 2025 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVss5Ah+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0218DB39
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318587; cv=none; b=u7yfqdrefEGu+OHaVeYMwJhBeFKkCUVg//hzmF352HC02cNJF+GiI6+hgyNLkF/AwOaoiWEj8DViisibzngZaelkH8hJxVr7X06muR/mBqzJbVsj5wEZ/kT0Gywvt+81BPRyi4MIb4ViFGmyVI2BXHsdg7UKB/0d3lKmosjPreI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318587; c=relaxed/simple;
	bh=7qg14UC8Mt/nmxAUW63KzoL+dnojf835ikvCNq7EM/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st5vEEsbEiSPx2sLKnzfdCkDwSDF6WTb2hB6ggI6ztPdRSNcJSjbX6yDKY/QjeSJE/hme4I6bVVtWfClRW37hByoRj75CFh3GN47AVCVQPnM06HQF8MWjOBqbWgoO95W3Q7KEpzgtnd8q7spUDx+LEE68bMzc/q3fYcfBZk6RX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVss5Ah+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e41e17645dso12790466d6.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 19:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741318584; x=1741923384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1T3UEMiMEYHcRj/C9reo0C4GXNX+eNL685itXP04jM=;
        b=PVss5Ah+8mjNu7payzTkz3DqC0iEEwo9fgFFUxddVvKRlLrBKzEVkfBz8R/EczXqz6
         xrmQ4NoSdSzM27Tp1plzufZEdETKowRs0gLLSUzxDwwylmpg/IDZ78hbJpgTQore4AO7
         D5FleQdC3R8Upk7V145woMfTWIh7hP6cs0pL2Ig6wLkpGYSFYfGQOl3BXuKXCTV44Z4z
         NKSQdYH/sKcD0LajbHMMg1gZn5F+ld7OqJF00Q6wzeLgjF/4r2mFkgkU93ihr0gPQhG8
         rivYKSQecURI763DbPT72+aFZLaSdrefVpRp4BQKJNxov5OKyItXUtu0/bo2cXKU4Du0
         OadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741318584; x=1741923384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1T3UEMiMEYHcRj/C9reo0C4GXNX+eNL685itXP04jM=;
        b=lQSUi0T/pInCIB9nx6vsWAoywvYkrxu7Ur/tAcHMJyT4Rocso1nPaoDBLAaXv/r+QH
         AKSasL/TePZXYYdUnL37eIdEMZyUSAZDjOKyBaZcONR6SLLY/YKezs7AYKbqoUH3seXU
         0gV9kokryj4yKrJX8tOCijMp0VNNhLd4fh8qKjcP0oZnVPa4MX1s8OK+yUP5sHzwBNf5
         a+ZGS7m90EKPuPkHHb0ssaQ2Qat7UdYLxfyQs9WQIsoKF22U3YtK4tVNpwJpll3OKRrU
         KmuOF7JCcCsiRue7k5GPOpIOHBHxE6lxjFOv1C37uD4LDhGdjMz6uEDg/VHO+6l1FWVs
         czSQ==
X-Gm-Message-State: AOJu0YxSTY7ZEnBw4o4ORAy0/8vfJjTblUPswe+v+P6Upxur0LWV06aR
	d7jmQV+By5azXVv68UpLTK0cv6oV7rFxBX+fp7CqbGwW5bZn89KT+/5izg==
X-Gm-Gg: ASbGnct5jTxabjmC3rFMF/G8mPsqTl8a2/7lCL0KBbCnA77X7JFftNWS4EQV+sDvTp0
	KP9xqdD/T/AekB872XvZhzmriQ99V5zAcF/C73BTVe0CtZQxc+1+NY5EhszLpoTUJJT0sF9P7yO
	lwi0jUcqGV8sJ8uDbgOeYRECMOgJmVot172yQ2DgnHRCmIqbFcipoGjpwkP1DtI19fU2V/i5HqO
	PNqy2inzh+eCizQaqjXcI5TryXg5PoLELzxSoRwJQ1JILjPPsY4dJ3M/fjj18W328v9pCfXHuGt
	b+9DA6O+iu4qgj17SOeUd19NKSgwme0JkYbgmKSRUEANkQi6eDCxTL5kLOhYulsDnxHO3rRo1VR
	d4q/Kr2CEg14iZTMk9kCAWc0Aru2Mwwz8dXAOWI+WVCp0
X-Google-Smtp-Source: AGHT+IEAUeg1M1tyyKWtl7+YckDBhxJTt3ugiwKuXnWqieYOhZDn787vmjHRN3EdHo4aHJon84Ld0Q==
X-Received: by 2002:a05:6214:202b:b0:6e8:fee2:aadb with SMTP id 6a1803df08f44-6e900642dacmr26048976d6.27.1741318584524;
        Thu, 06 Mar 2025 19:36:24 -0800 (PST)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f71727d1sm14528946d6.117.2025.03.06.19.36.23
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
Subject: [PATCH net-next 1/3] ipv6: remove leftover ip6 cookie initializer
Date: Thu,  6 Mar 2025 22:34:08 -0500
Message-ID: <20250307033620.411611-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250307033620.411611-1-willemdebruijn.kernel@gmail.com>
References: <20250307033620.411611-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

As of the blamed commit ipc6.dontfrag is always initialized at the
start of udpv6_sendmsg, by ipcm6_init_sk, to either 0 or 1.

Later checks against -1 are no longer needed and the branches are now
dead code.

The blamed commit had removed those branches. But I had overlooked
this one case.

UDP has both a lockless fast path and a slower path for corked
requests. This branch remained in the fast path.

Fixes: 096208592b09 ("ipv6: replace ipcm6_init calls with ipcm6_init_sk")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv6/ip6_output.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index d577bf2f3053..d91da522c34e 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -2054,8 +2054,6 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 		ip6_cork_release(cork, &v6_cork);
 		return ERR_PTR(err);
 	}
-	if (ipc6->dontfrag < 0)
-		ipc6->dontfrag = inet6_test_bit(DONTFRAG, sk);
 
 	err = __ip6_append_data(sk, &queue, cork, &v6_cork,
 				&current->task_frag, getfrag, from,
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


