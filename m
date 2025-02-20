Return-Path: <netdev+bounces-168278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 133A9A3E5CB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 21:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C70D7AA8FD
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F33264606;
	Thu, 20 Feb 2025 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fV+EAkEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB9F2641E3;
	Thu, 20 Feb 2025 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083047; cv=none; b=qj5eOeijkqbcg7tyLnjvfknTH+uidsfF2HIE79HEJ+5c4iyzDFmtQe5iADnLIwBhDivBBHvkCT1h2V0vtItQMSTsKpdTRmoPuKRCizRY0dy0DZiQce2ZBlsTaFeJnZceQVHG1VyXgac+05xKgvfsF6puiEiPhO9u3NtHEPz5dUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083047; c=relaxed/simple;
	bh=hZioMTK1C9JEdzSGKKIXORMnKTc4XodsPT2raETEY7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FodqKJjKJGtlqopR7G8gM5lmpMgUQR9lVtGHHpf5ZSM8LcbuyexkxOw0nqZIAr+4XvujK2OwGpt+Ax9U5hWUKzRxNu7PT9siKiInRTj1AN7HoiTggg14Dk+nLvPPyoGjRNTMiwelP6PQyQctT3oeOjjMFTgckHtFA9m9r2QCs7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fV+EAkEO; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f666c94285so12616757b3.3;
        Thu, 20 Feb 2025 12:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740083045; x=1740687845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4lq4I+gZKLpsB7xN05w6S7fraHoO+ZPbLIOXY138/pQ=;
        b=fV+EAkEOOyNCF7FDj/d2jsRD5vtzSugELAvHestChLTgsv3GrE8LXOErP5ymvPCNBy
         u9YL+6CQ6zitLmzAJN/dOXqJYZlyLw6ltFSzyFXBPdt4H0IkUkLgnVlglQv5r/L2rlxw
         7+WnIzeEjJhtgAk4OFyV9UROGLL5paSepXjEpgWYsy0vYgoFTXvlAmMn10swVFUFdILJ
         14WqpQxvUuHMJldYF2Fa61pWmHvEYj4um3OslL8TogeZ6USZDlkGclyd7jszk4FkXW5O
         aYvnf7WOxp95Cbo0uVzlJawXD5rKfFUQFKEwgSiuR5wzBhT8d4F44d0cmQF/P8jU2k4R
         gOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740083045; x=1740687845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lq4I+gZKLpsB7xN05w6S7fraHoO+ZPbLIOXY138/pQ=;
        b=B8AvenN79/YuVlgPYZKDxQpY762nSc6lJPZdzW48ntuOfkD+IRw46CGN+Pkwlu/Ykn
         3Ts7Y4B4EIVhHg3Rq56JtRqQgolpOu5x71KPQxHTQzDy1+ShVIU5rfx4uoVN11fZjyjY
         o0dHBunqdUmKlyDxnkq4RzjnFxYJopEnbMYC3qdxPrqbvu89CUKZhSgfI2PIhGQcnzMa
         5Tk19yICVvQiILyJLUTogjlDGRDYufBCma/gQ/Mg+HDGytzh+3G3UYL0Z2Gdg6W9J0uz
         5ebfx9ZBTTylo2urK9+CMscSrWKdc0NHN33AIb7Ld8l2B2nNf6rILNvRD73l9iITyB8h
         s3jg==
X-Forwarded-Encrypted: i=1; AJvYcCVUXLbxZo59yx6BEcvqeV3g3teP1Mn6FLSGspEjKnThzrgMuuamQO6RLWZYlOJXzber0DYaZ0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVcklFkk293sJ6/FbrtjkR146jjnwA9UAgi4oFn9gb6gRspO3
	hG28XboTh1tNyy6bjrekA50EbUhthAl1KFuidIdUo1fgiALY6pkZwygj/GuR
X-Gm-Gg: ASbGnct86gUVZvXqOTQWZMsfrzO5YBAXv+AFHumYQNHqg7S5E746FC7Kke4lY8LISmy
	mill8Qu66AAMUEjjkvl2BXodjNpvQX6Zw0kR8tskmFlWdU6/upWVXP1Y1sq3C56bhN7xW49jIsu
	zLwq0FgRJ4U8rtx/IJk9OpijoMprSoExrtRwwmNLm3kLAMp8ccqw1TqqMp47FVqbgVNpQHglLIa
	FVRgxX7CinXATcOHAGQgYcdh+c8arz1pztaoyM4aYCkvfJBKaCR1tH8SMxtUQ6KIuDP3k++UU7P
	a6nfWgSdndWb3EiIUbB0Kw54VwB1zkiJkSbt82Kso8rC/N88a9yFwaMdLM3RMCY=
X-Google-Smtp-Source: AGHT+IG0WBi8AQD1VFvyUbVGzNiLfhBCZoGk2j6v0lqU8P/fi2RqmBK9eBAmzXBhxGx2UslSTHtp5w==
X-Received: by 2002:a05:690c:620b:b0:6fb:a8b4:a264 with SMTP id 00721157ae682-6fbcc7ac309mr3076457b3.21.1740083045035;
        Thu, 20 Feb 2025 12:24:05 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb360a6b76sm37893867b3.63.2025.02.20.12.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:24:03 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-02-20
Date: Thu, 20 Feb 2025 15:24:02 -0500
Message-ID: <20250220202402.1986578-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit dd3188ddc4c49cb234b82439693121d2c1c69c38:

  Merge branch 'net-remove-the-single-page-frag-cache-for-good' (2025-02-20 10:53:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-02-20

for you to fetch changes up to fe476133a67a15bbe8c1357209e31b8d9a8e00c1:

  Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO (2025-02-20 13:25:13 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - btusb: Always allow SCO packets for user channel
 - L2CAP: Fix L2CAP_ECRED_CONN_RSP response
 - hci_core: Enable buffer flow control for SCO/eSCO

----------------------------------------------------------------
Hsin-chen Chuang (1):
      Bluetooth: Always allow SCO packets for user channel

Luiz Augusto von Dentz (2):
      Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
      Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO

 drivers/bluetooth/btusb.c  | 6 ++++--
 net/bluetooth/hci_core.c   | 2 ++
 net/bluetooth/l2cap_core.c | 9 +++++++--
 3 files changed, 13 insertions(+), 4 deletions(-)

