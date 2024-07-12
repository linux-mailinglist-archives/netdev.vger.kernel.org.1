Return-Path: <netdev+bounces-111028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75FE92F6AD
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 10:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD811F22B4D
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60CE12FB3C;
	Fri, 12 Jul 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywzmR3pM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA012F37B
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771563; cv=none; b=ZQXXmflaNud8J6HliN9vYPtaKrIiBng3V7RJRTX+HZPxj5r49HYENPsuPwtWZuqlZh/CLFY/wt27ncoYcRD63+CFwxP/IW7ONcsJMxYcp6Z2RMMkLaZi265JZljHTwPiglwNSNMWCdEtqxW83xdpe0+h1k2ASboLJUnHmD/E8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771563; c=relaxed/simple;
	bh=n7vviI36mP6nxaBfP+nJqOCAwypxVaPTF7rt8y0p4A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VaxHVK9B8tbueLN2sc8z9+W7eT9311m7eLa4qqC5k9d/q8WOypxHqMqLQ0laYIrMLhlBBUXxYOwLMjgPBmMY0ftrG3feD+KZ76UvfBVf+cONwnWas9TotjMtIW6TA7nu+aYNQmQ4kuZ+MsPShrH82kO4Q15D1aDQ1NN7YCqH4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ywzmR3pM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso11940915e9.3
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 01:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720771559; x=1721376359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfY0TlwmiLCfard5rvsJoOmoOPvQGEncPGG+Fen4OR0=;
        b=ywzmR3pMCSP9++FFfZMohStXgtk6rls0WhGhg97ATgzuvDm3/gZJ9Em690kuQzSe6/
         DWqrQQB3PI6QOpprgNI7cjnnYXPgB0MveeqlsQR+AbWc7CXi18aMuk+B+V2fmg2qlqWD
         GyqJtuYtX+SxNR4h7vsQ9IRw8c4rMVrvWHG4ACZNwIB3hEMmURbAQUcra+KYTsjMTep4
         4spEGzeCac9XWCXGPVTJK4vdoJ61JK2+RO6eutnsc+GxdhEfIlm7llqJ/gqhU9P1qXWn
         X/gsT+eqcXr5KeGIEwxp5G1Uzy3O/wv+DI5WWBS6r0nOFfVdbJQWx3bKotvXnWieDFSx
         b8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720771559; x=1721376359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfY0TlwmiLCfard5rvsJoOmoOPvQGEncPGG+Fen4OR0=;
        b=jOlH+SbhcGMnuzJjIXhHpUh+10IPCQ5BwxDr0aqixdOR9e29B8ouKeScsOPtOYIM7L
         wpaWxTiGfMUczbAGEgI18lVlUdZd5D8dEsXm5nPHQo8csKjQWjLMY49yl2+pCereS+gE
         9rY3/pyiSzQbk4FUZGyx2MOpxm2zwdvyz/BYDRXkhe4+p3Wdhen0fAJX26zzgyX4L0vt
         UBua9GR8Wo2uAa8W2WGSBK++Ml+kTzi/yhMBI/xWUl6XXT+TAtxFjKnIbyuL2lZM8uCq
         fWV1CEPdFYvZHcXGl3DAH5yJIwscSNt0DTH2MbRIXvvAk3UzH+ZXs8K2GSaT19y1KAIL
         CKZA==
X-Forwarded-Encrypted: i=1; AJvYcCWDGDpgQzt/iHbiUUOE6dov51kkgzRSblQd8uKS3utqugoWmmZot/sqCvFzz6ohcmAFSzrUX9JkRhou0O+doHqS6BDaKir9
X-Gm-Message-State: AOJu0YwOwg4DaRHO1oPshq9JSYFdRNfX3dk1rtwBw+ZkRgtUmFz8wBjx
	/CntPMIafx1mursV7r/UvMvtXbpebbRcLdLpyrG52IlRmATMQQacZLFqQpw+Q4A=
X-Google-Smtp-Source: AGHT+IGfk8XYbf3dJihjzUp/yY597NfBnHKfKpSAf6i1wn1c0DkkGLKIJxiK/uz8d8IUUZUHeOsrTg==
X-Received: by 2002:a05:600c:33a4:b0:426:6551:3174 with SMTP id 5b1f17b1804b1-426707f7e3amr77282455e9.29.1720771559350;
        Fri, 12 Jul 2024 01:05:59 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2c1d54sm14146525e9.44.2024.07.12.01.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 01:05:58 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: [PATCH net-next] net: virtio: fix virtnet_sq_free_stats initialization
Date: Fri, 12 Jul 2024 09:03:30 +0100
Message-ID: <20240712080329.197605-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
added two new fields to struct virtnet_sq_free_stats, but commit
23c81a20b998 ("net: virtio: unify code to init stats") accidentally
removed their initialization. In the worst case this can trigger the BUG
at lib/dynamic_queue_limits.c:99 because dql_completed() receives a
random value as count. Initialize the whole structure.

Fixes: 23c81a20b998 ("net: virtio: unify code to init stats")
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Both these patches are still in next so it might be possible to fix it
up directly.
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 10d8674eec5d2..f014802522e0f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -530,7 +530,7 @@ static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 	unsigned int len;
 	void *ptr;
 
-	stats->bytes = stats->packets = 0;
+	memset(stats, 0, sizeof(*stats));
 
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		if (!is_xdp_frame(ptr)) {

base-commit: 3fe121b622825ff8cc995a1e6b026181c48188db
-- 
2.45.2


