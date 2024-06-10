Return-Path: <netdev+bounces-102277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6071B902354
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4759B21063
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210B71B45;
	Mon, 10 Jun 2024 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBOtw49u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A5F78B4C;
	Mon, 10 Jun 2024 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027888; cv=none; b=GX0wp8amSgIbSLfvWKYeskc7xwtkL8Lal4DIeBHZykV8sW+EsUpVVH8Jt0J8I4ONlmrEbHFTOOZc0EC3ydtsSmosaR7y/CQLFGSyxX3yMDZJnt1trxuKypw76f5ENbclBpOHl2n7GFcFPeAcLTKCxIA0NmFftr4PdLoyy49gAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027888; c=relaxed/simple;
	bh=eM6Kxzv9gey2fJjyA0QKesIoFr7zX6fUAJ/vGkRuEPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p18BwtT5h9aUbzNdgmXR46Bm0wjgD/MslbsZ32G+g12SPiBPwnShvJxBbq3SNGpcWS7lCcYfHiIttmjxVV7ysC/RuHSpxBVS0brpdBVohAIt5Wk9VjLVEuTlknr+swkn7tYLhO6ojMh3Z3IGQHtt4K4HjkYRCvo3TsgdyqlqIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBOtw49u; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-48a3989641cso1411621137.1;
        Mon, 10 Jun 2024 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718027885; x=1718632685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=drJFdNW3k8l+o1rIbvMV2Zru9hxcakn4dwTzn7AUT6E=;
        b=ZBOtw49uVF27xvTWYwYUJQVVcucJy4Kj7hM+yobkoAT96Q4i17/wSuTnD9uY+lrAKG
         DL+xV3CSAnyjslqOokkRkDpjq7FAuW0CkKNzs5cDi1wPxup/JV/rHTaustGQnbB4QZGs
         I3v5d1cSDJKkyiuDmch7KCEVXJsoPeY/cq9k84jgSjzxfX8O5BjQLCHmAGrbM3jWAN49
         k2z5h+1ZjvN75otIS80d0/hFGecSFCOw/eDG806IsdxRKlg377y0uNFt5UfBft6ZFEBd
         V8pMWIh3N2yFTVn81akaafu3PTY2+ry+/jTK5nkBN5jPSB291vp2BcNlc2CCdWAkdVqd
         7NnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718027885; x=1718632685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drJFdNW3k8l+o1rIbvMV2Zru9hxcakn4dwTzn7AUT6E=;
        b=vbOKa6BleHeEDBx4lRP+NKPPoWx3MEvjs6i+Aa3I4zBMaz0THXnAnlZ80YgRJukoQk
         mbLXWSMlGOE2ryXasGvEC4B0XELbJhDcnD8V0jjrn/yrO6/RPVeBD/CrAcHY2UEPrxqk
         3aQ98E8NJAx2FyUXgtzcGjCQqGE5kGLVh0gTY+ZQ0iZbehkBu5SZBJ40XS5qhMK//3yt
         0Es6NEI7gzyh7I2FNdc8Pu7HL4SYPWds8Y8qUYlvoxf7AhIGZZnvxtS/pVivwkVsyDtd
         0WYiErBuadKcjYoGkkwhLX11iyOUMpX71O6dkiM6Yis+R6o4l8G8OriSCqt3L6Ip7aRd
         BVLA==
X-Forwarded-Encrypted: i=1; AJvYcCVsdIzntoWz2Re/zA6g1rZ8J6vMH6o9Ncm8A5oHviW98H2Ca+s37nAcNP2b362QpdLHyhmOG0yWiXa/q7HG2iasJ2iPwR70
X-Gm-Message-State: AOJu0YxUxa+4QZbcdH8MpfYyqLAKxWT0QvqVipCtSvxvUgmsLqlc/345
	qm+tXqqvHCI+R9xp8J4kccKju4yLCIJfTAzvWi4Fpj+1kfTZUdtb
X-Google-Smtp-Source: AGHT+IErVbKVBK13vCvqbamXizalym0DMh8fpDks6BaKywIL+act7BytxdyuPnZG5+6p/WMDWKwMDw==
X-Received: by 2002:a67:e3a5:0:b0:48c:45a8:a3b2 with SMTP id ada2fe7eead31-48c45a8ab9cmr4702187137.24.1718027885421;
        Mon, 10 Jun 2024 06:58:05 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48c1a0c33c4sm2019558137.27.2024.06.10.06.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 06:58:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-06-10
Date: Mon, 10 Jun 2024 09:58:03 -0400
Message-ID: <20240610135803.920662-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 93792130a9387b26d825aa78947e4065deb95d15:

  Merge branch 'geneve-fixes' (2024-06-10 13:18:09 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-06-10

for you to fetch changes up to c695439d198d30e10553a3b98360c5efe77b6903:

  Bluetooth: fix connection setup in l2cap_connect (2024-06-10 09:48:30 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: Fix not using correct handle
 - L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ
 - L2CAP: fix connection setup in l2cap_connect

----------------------------------------------------------------
Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix not using correct handle
      Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ

Pauli Virtanen (1):
      Bluetooth: fix connection setup in l2cap_connect

 include/net/bluetooth/hci_core.h | 36 ++++++++++++++++++++++++++++++++----
 net/bluetooth/hci_sync.c         |  2 +-
 net/bluetooth/l2cap_core.c       | 12 +++---------
 3 files changed, 36 insertions(+), 14 deletions(-)

