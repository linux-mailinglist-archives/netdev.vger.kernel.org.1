Return-Path: <netdev+bounces-224832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19FBB8ADAB
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFB17E6734
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F42253F1D;
	Fri, 19 Sep 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR1EdqpL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0D71A2392
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305194; cv=none; b=fXlGWUNMej7ZYYOq8akpVgCcdooKAk6oIm2HrWGl7IADgkqCLzN5IRO/MkiKZ0JcMMijMicyY/lFljHvpISxa7qLxmravxsXSxAemOsaF0/b6CBjLx3/G1t3RkAFt3zxgzcNaIVIi/0SSqpVsXFjp4TI/wqVrarhUIPs3pMQK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305194; c=relaxed/simple;
	bh=gDa85MneB+BAwS7qvm7CDHhrBvUCUyClipVl7dU5XkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KwcqkqyG5FqmQHMkhw6/9gBaFq5OoSc2OFzm+IKj6iT9QHZ+w3D3qRQJcQM2ct/RG9tjLytNM9xk2kKrvNKD+sFvKrP2mhRBDljc4yXmCxaxtD6zK3ugBKVuPDfP01jE7i4JFaXxbUetMYgS1Q22cFErDAiKlUix8KO8vNNStPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR1EdqpL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-330631e534eso2058602a91.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305192; x=1758909992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fq9/RhrmaJ95VHFP/mSsZ0mv4u1FmOMHDPmgSCxvyHU=;
        b=hR1EdqpLAvs+dSy38IGxoIFrouLJ3GJa+y3XrAZekHfXNiLnfK5jPiN8HgrF1bfa26
         knL0JvVuqHmdRegdJgVIdCWViy8nRqUFVE8xq+KkVOmNTSoRmQh9Qd6zvEIiSlFr4bFx
         AAR8g+zYPjDmX4p/z153dFp860K4R77dthXlTSMnuuveN0546X5iajorgihVWBs07pfj
         vX6ofpjajPUhubgsvxWw+ovKPlm5RBJfGGrKQm/gRqCsTmucJov5TwW7YjjBuv9Edy3W
         k+03Bijy2MfF/5FaFebT0Z2S8hZKihb7hw/Nm/IrvdTL/nDo32ONM0G4i8w9LL7EA9ph
         Y2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305192; x=1758909992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fq9/RhrmaJ95VHFP/mSsZ0mv4u1FmOMHDPmgSCxvyHU=;
        b=iAzVoiFMfLpsTJlI14yk+B0s3Of1Nlpx8Orr2Z/3LMB18Jjt+8jNrteseQC/ZHoJWp
         5XRv4vD6Uz1eRO7Ui8T6vQysEnrbFyTohepVht11WuUUA5wxJOf4cZwursoHrIEvIjCk
         puwgdRaRn4a3VCL2CvNsF/Z1N9BN6LF4JDp3XBdf/p8ePYlfWTVqR96DNAlN/HrfA2Fs
         HD7QHbqP95CAp7TRuQaBXlfRkRcILeTTIPX0yyN4O6uR0nlUxhemJHpE5nsviu0XSV/T
         f6zSUd4E9GUxqW7iHAcdfEFid9swDBOVNQEs4WaSy/XWKEL872k4BnCBevFxWH7FWgSr
         bwNA==
X-Gm-Message-State: AOJu0YwQWHAeBIPwX5qo1ISrKzr9wv4U12GJal34pzFLDxcbf6GMYZGB
	WJrmwVP+AUn4u2+rZGDelHh/U72EGGOUf4TXkvFVhFiNz7VyO1x58vOD
X-Gm-Gg: ASbGnct6lU7IhjumRkbQQiVErLqgzMufe/MgIlmAlEKWdiN5gZmWzW24/A9r4VkoYJI
	GFr1vJ87WYi/ahXDCcU15UjOU2V3PjHSpqO4FU1Mzk5K7OrAGyLiF47p/8eq84LYsaP88BADOTh
	VC2+9O3ja0BgowsHCoIaR95zrk10SUeBeSSK8v2holmsJKZAdM+vs5s9WrVy65C1uZ1GBhKblnm
	QWPjzuW+0RmMpEy09EvVOJSghXfaSbtit7TPrt6Tk6/JBnPamD+WTiysyYcrWwbZjKQv3gghnWK
	fHcizlVWXYwk84bPuEMZmt0PKkjD9UaOOKpJZ9bBQrJaZTxsa5CBqxnHWOlYavCXPmTDXeILdit
	Sp2oe7JV/iO7w1Xg+Iym08w57gJA=
X-Google-Smtp-Source: AGHT+IG8ZpyqLIkbcuvtqtJ+EHy3A9Tiq7R+4x7DEyt9BYgtt5t3QogZOzW/orps6pe0vIGob3Fzng==
X-Received: by 2002:a17:90b:3945:b0:329:f535:6e4b with SMTP id 98e67ed59e1d1-3309838f187mr5713725a91.37.1758305192045;
        Fri, 19 Sep 2025 11:06:32 -0700 (PDT)
Received: from gmail.com ([157.45.202.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed257bb5asm8702313a91.0.2025.09.19.11.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:06:31 -0700 (PDT)
From: hariconscious@gmail.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH net] net/core : fix KMSAN: uninit value in tipc_rcv
Date: Fri, 19 Sep 2025 23:36:01 +0530
Message-ID: <20250919180601.76152-1-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

Syzbot reported an uninit-value bug on at kmalloc_reserve for
commit 320475fbd590 ("Merge tag 'mtd/fixes-for-6.17-rc6' of
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux")'

Syzbot KMSAN reported use of uninitialized memory originating from functions
"kmalloc_reserve()", where memory allocated via "kmem_cache_alloc_node()" or
"kmalloc_node_track_caller()" was not explicitly initialized.
This can lead to undefined behavior when the allocated buffer
is later accessed.

Fix this by requesting the initialized memory using the gfp flag
appended with the option "__GFP_ZERO".

Reported-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
Fixes: 915d975b2ffa ("net: deal with integer overflows in
kmalloc_reserve()")
Tested-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---
 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..2308ebf99bbd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -573,6 +573,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	void *obj;
 
 	obj_size = SKB_HEAD_ALIGN(*size);
+	flags |= __GFP_ZERO;
 	if (obj_size <= SKB_SMALL_HEAD_CACHE_SIZE &&
 	    !(flags & KMALLOC_NOT_NORMAL_BITS)) {
 		obj = kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
-- 
2.43.0


