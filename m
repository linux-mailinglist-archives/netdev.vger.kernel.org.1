Return-Path: <netdev+bounces-140527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005C39B6CCC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CE828237D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 19:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8849C1CEACB;
	Wed, 30 Oct 2024 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRy1aNvv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E038C1F;
	Wed, 30 Oct 2024 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730316132; cv=none; b=C1LSGHiIZ6ZAb2KbCLccqtiLa2YKM+J9d6qIjuWhA78bycte8Rh1P5K45zAMxLxMAkWorgQX0qbiGGx7DiiTUrsjTHgD94y5jLE5pmcIbdR+TOM9keRZqueeZKbUERaUdXx4SnQe9W5HvM53GcbJjKkhGwXkVvXO6rey6FCd1x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730316132; c=relaxed/simple;
	bh=20YiWshwGqPi6EqRGa2V2wZdThZPQZc7P9R2zk6JTDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erbSu1QjZAXSMTocTeeZ5j9AJdjtHVzzJR8dcEQkm1Fu5XQvEO/g72tmQURBeklmuZeA8W5yHAa02V2T/qEvNmirXRyZI3RWzcpaO9AMC1UG1vznI2d+oD0ws8PzRZ++a4K2EgKmMA2FKrHZje1rGPOcoKZkEOsbZyuszeV1NRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRy1aNvv; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84fdb038aaaso19571241.3;
        Wed, 30 Oct 2024 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730316129; x=1730920929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7KtXB2ifDIWOa6mGWGS93FJVDdAa3M1hw2PYhtDXBHw=;
        b=RRy1aNvv/qkCvbTXTImwe0pQFgVvsEQnTZGIU/lx/yw66FtbEiimvsjBZNdjEBl0ha
         YBc/SGTpHa3cHVwrfucgVMMf2dzCXmdXlGSillkAzVid5l2nCRLAS91/VuQmMSfmT4dC
         aHntzpzk8pO35yTQNAZ1uuLvDWow3EMLVx9lfioj0eme7WsBXc5gBeWCNd3nNr1TBATG
         sI5c7JsInMtn7Cq6xB56i4r6odDHdeN9uJd5xa2sA/4SrgNIgVYyzbZaes28eR0kIslr
         Nv8DwiQR3YWOnHFrcLginC9JNKQbIVOnhUc3pSr7lne64xNmSELPHRX9NWd1V8SZFEdH
         eOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730316129; x=1730920929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KtXB2ifDIWOa6mGWGS93FJVDdAa3M1hw2PYhtDXBHw=;
        b=jL6oBLXT6vKndFvZr8US3J4STDEqiCywIEPxSRu4GxqJiHOZBdH9N466EkhAz+zHIL
         NJ1B69KujKV/LT2uheJ9lO7ub+f1fyjolRxza16vplv/8WL+YOykRAHYDZnDmWOO7hu/
         2lHl0D7yT1spFOUKSu/zyB/rBOU2tx8PY7N7gZaKkPGIJLof70XRHhpKsM4e4Y8qaIGs
         F7oLrlJ8gPggKd0AYEik+uznCcQC0aNqp/5+qhiohUmUKx1iKxhbvtyjcR779nH3ngUP
         8pyOjHIeQH4ClCW/SMO/D76vZDTGdsQzYgLdhXx/UX0E6Bpv5FPcaoaeO1W3ZNjJKyzr
         PuIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjFw+SZ/iZa7x0/LT3szftHNehYlcbG+GZmZHLgicvTbKzcVGw1293wCZ48Z/WAZPYkIQwN+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEUDD6E/7Bv6Zp5Cg7zLzJum5LtEFhrCGJ5brguxPSfRRXfBW
	gur4ZRkQttM8wYc4X8QRmSHbTC8LlVPRC5zbOifNZr+v6sNlgfWfA5mc8w==
X-Google-Smtp-Source: AGHT+IGhoT1ij29i/Qh8/RPaqQpOkqMiD6/poSiI0uDx4uJIVUeNzsAMD12RAqYQ8uKE+Co1Ewg6tQ==
X-Received: by 2002:a05:6102:dd2:b0:4a4:8287:6c34 with SMTP id ada2fe7eead31-4a8cfb681c6mr16033541137.17.1730316129462;
        Wed, 30 Oct 2024 12:22:09 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85580ab7a5asm1611661241.23.2024.10.30.12.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 12:22:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-10-30
Date: Wed, 30 Oct 2024 15:22:05 -0400
Message-ID: <20241030192205.38298-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit c05c62850a8f035a267151dd86ea3daf887e28b8:

  Merge tag 'wireless-2024-10-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2024-10-29 18:57:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-30

for you to fetch changes up to 1e67d8641813f1876a42eeb4f532487b8a7fb0a8:

  Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs (2024-10-30 14:49:09 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci: fix null-ptr-deref in hci_read_supported_codecs

----------------------------------------------------------------
Sungwoo Kim (1):
      Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs

 net/bluetooth/hci_sync.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

