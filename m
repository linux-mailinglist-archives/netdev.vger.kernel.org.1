Return-Path: <netdev+bounces-132238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB3099110B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89447B2130B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263CB231CA4;
	Fri,  4 Oct 2024 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaB+0pOK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD0231C87;
	Fri,  4 Oct 2024 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075691; cv=none; b=athSAm0fIZr1UmvMX4QwvKnzrZRXCHyZ+jhvGNVEmYIov4PmepDv0lVXJoCoFQTtRlbdsfP3OR9odplAFMAf7Flt1QKnSFcRxIQW0KYRWSOAEPn1iKHjjRLx+8yTF6N3s9ieeXxgmd7+wbzyCva3Ws6AyeOYiUyPfW21nlfFfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075691; c=relaxed/simple;
	bh=IiXT8R+PZu6D57wZCq1PVL4exdlKrRgjlOaFLW93W4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6oaOE+E8xttyPfP/iP/u/38QF8wdKjXnN1I75zqjqoaWXZOUsBi5yloUx4k7jyyCCRlTzogISTSxAcfMVKdX/pbMVyLbRBC5/IO/1m9DPRgX7ZlcoN+npwAUQEBxAw/y4eh+DA5VraZ0Z+PNLMSLJRlrymXBbZvFPsQ9wrMtk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaB+0pOK; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4a3c6bc4cecso710511137.0;
        Fri, 04 Oct 2024 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728075688; x=1728680488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eCAwr3wWq1gW9iEkujpHE5/UksXg5caVVj+cmaQRza8=;
        b=PaB+0pOKJbjwhFwrEnp8lfE8/rrWxoJSwfvN33G5d/1kxVNd/hAFekZdjcLVqheX1k
         ayZGyJRBNX12PgJtbSOmeXr/+kTQejlZOpme8NMEBqo4Cp+52rFYXGr2rGy8zauM0Md7
         az2iCM/rc8KRQL4urmZoOssauIYceIJixpHfrKO+NloOOBxPAKF1xqaMlGDIGOEypeRf
         /v+3h0eZnh7sf2NBbsDVr0oVIH6RSV2cQ9JUYSF2CAASw3U/2Epso/tNe0P3cLXwfpKY
         HCJBLcKLAjWmimeJ5p7wPNVUZSrC2TPiNyupm16HGeHYe9/orRhGtGCvUsxX2NHYplFM
         ZSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728075688; x=1728680488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCAwr3wWq1gW9iEkujpHE5/UksXg5caVVj+cmaQRza8=;
        b=b3wHpnHTHs/Om3jGwgN6rd9gnthtYo6tV6h4YhatGfyvV2et6yXGEVMtEUtsl4yhO0
         ROFOhWcoiRIhHcVfUDC515wT/EIGm5E5xhZLfm5l01fjtkJ7YhpJuvq5u3YeQKgdJyNc
         gqIsBYfjzKW5DNibE+uQtHH4WPaD4tkQu1hu3DL629VYmb6nDXU9y8Hxw+viNp/oKhJu
         KKsNySTB5kHb5dtV8GMCb8zBVdjV2CtewMVnmHWBlbqKK/vUzLJA2T91g0n9Z/vuSGLv
         bhTmAdUjbjcffSXJdXjxMcySsGB2yJiqJKY9WqyP7jxL6IPS1JMXBmy8YgpIgpw4QfAP
         bmUA==
X-Forwarded-Encrypted: i=1; AJvYcCXR8Yc1R/af0Jql9Ze3DqzjjDZEgkd0AQ+kLni8+Qj98HObDaTZk8yteLirisPd+4AN1u27l5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvPVsKeh8vXwlD72z1WTJt+RCX2Ldb/KlLs965LsSf9cgl/MV
	9PUOZ0Zcs6//GK801KFuSswd2UsKU68VSEodwz04v37H33gP9l0qwNE7Dg==
X-Google-Smtp-Source: AGHT+IFDgQXt6BE0vslO+PL31Pp1JZlQ3KT8WG2EfLa77Km88t5+msWn4a4Tfn5M1LU67rcOYuWgVw==
X-Received: by 2002:a05:6102:290e:b0:4a3:cb2b:9748 with SMTP id ada2fe7eead31-4a4058ee453mr3181653137.24.1728075688450;
        Fri, 04 Oct 2024 14:01:28 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84f5c78c78csm103860241.13.2024.10.04.14.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 14:01:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-10-04
Date: Fri,  4 Oct 2024 17:01:24 -0400
Message-ID: <20241004210124.4010321-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 500257db81d067c1ad5a202501a085a8ffea10f1:

  Merge branch 'ibmvnic-fix-for-send-scrq-direct' (2024-10-04 12:04:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-04

for you to fetch changes up to 610712298b11b2914be00b35abe9326b5dbb62c8:

  Bluetooth: btusb: Don't fail external suspend requests (2024-10-04 16:54:25 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
 - hci_conn: Fix UAF in hci_enhanced_setup_sync
 - btusb: Don't fail external suspend requests

----------------------------------------------------------------
Luiz Augusto von Dentz (3):
      Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
      Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync
      Bluetooth: btusb: Don't fail external suspend requests

 drivers/bluetooth/btusb.c   | 20 ++++++++++++++++++--
 net/bluetooth/hci_conn.c    |  3 +++
 net/bluetooth/rfcomm/sock.c |  2 --
 3 files changed, 21 insertions(+), 4 deletions(-)

