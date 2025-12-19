Return-Path: <netdev+bounces-245564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37436CD21AB
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 23:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2290E3010E7E
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 22:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ACB23A9AD;
	Fri, 19 Dec 2025 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac9xJJiK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6856B28695
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766183494; cv=none; b=tyMc9vrRUWYGt+NbrU1l9ZVQBOlEzoD4VUhjvIMh8uWjoLpXFBECpT4gFAf7Ye6carAnQcV/kx7HCrPeWvEinx4ichSbj7XVJSPdyvt+RTIq1I4kDgksRuqlqz0BZ3ssCynkOZg//1GYHcPXSJSPrpTCPtrY7jrD2sPWstkdAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766183494; c=relaxed/simple;
	bh=1UaYWraTRe9a8y8aAvclysl5J2dogbQYXAa02RN83CA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOZTDschy/JyJEFSGoBtXWrb0CI3OgvMyTZS2g8yd6e8225HckTQcPfZE6gtiQXZ1q95xF8UUwt1IlCPB1aDtzctlxA4yDlp+UtSmNqY4yJSHYy2vDZo9yt9siATPVMoN/T0rqHQRULt1huJC5d553o6CqIcjVH02RCWPjdd80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ac9xJJiK; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-55b0d4b560aso2103648e0c.0
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 14:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766183492; x=1766788292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBg4Jo0t0LX4AVKe4iY/eC7z6MeN80x280fCfkMyMfQ=;
        b=Ac9xJJiKYOMy8uvQBQpYQIFbEwoaOGRVFM5F860w9R603ZZXjkdQgbnAMZc5oLrntf
         jgksbTHataP8OVFBssFGOG0rKdT0P8Mrh3VKiHfoOi0BIJTkpW4xoHiW5AtVYaDgoi9r
         C4FzCt3Z0Wtq8ug2sP02a8+MgOsmtcCi2hglZ2PDfIJTRUcXszbCMtchXgLA7DmaAN3e
         fxSeHODT1RIYJE3vWVHIIZ5OWt64KYcc3plebz4/Os2EQrtWJo2YOjccQZ7NiNlIFf1s
         yczm3iGNfu+nVLp0NWqT4ngvoRw4uDibv2Ly0tc9jf/a5QDGE8ba2g+x92WeUf5a+rIx
         DESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766183492; x=1766788292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBg4Jo0t0LX4AVKe4iY/eC7z6MeN80x280fCfkMyMfQ=;
        b=Fkpt55KUjy6fUjF8LI4FUwIf4hkx/9dridiArOeA/hWpepnz5SBASBGUIwbPgoJ3fd
         5JSq9W4p2Nw6RWBgnnVr2KnxTS37kIclI7AapqqZUbQPY+9JcuiYSLHViUQiUX3eYaYw
         tveSxsJVjlr7frktFZxt7AMFbF09M12pyis0qBEG4fzkfsuuf7e7MlLOqPa5aNHQ6oqa
         dS8T+mCLdvLCMUSUHFWYwmSRx2EhunAe5TFsAoonNdDebSy1kGB5HAfWy1sXTQzshuhp
         5tHT8AiDVClUO/1tKBTUkZLBBO15igEwfKHoKbIMcRFbuAEeHNwwVvdpthXMVrR8gbxR
         Gz1w==
X-Forwarded-Encrypted: i=1; AJvYcCWM7LAtCMeUuKs5ceuE5MJCFd34vakXTl+hDXTnsBSfLQklES/SZf5J267+9UYAKq7ZGbTZAIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyubGSln7ZoRhPGNjQTZAhL68TvLTmsZ+6Nw96ZpWCQBY2u/MEe
	Go7EspitVBpXEkT5XNYoJkAxAbdLMQXEcmPg4wDV82X80iu31MZCs11v
X-Gm-Gg: AY/fxX6TymfjG89euJJnL6gCls1J6qybGvmyN+Mk6iG4U6ESoeRfqMNcZJAl78LPAAj
	wLB+PGOh6zhOV1gIy+7ADgclA2tHGzUCUmRWigiegPhh6+HIsYj7vgBKXFeLJpnfukWbz4wgF62
	xARapnDiiufz7TpnterfBZGLrogDn0Te1lxgnUTaEozhDSewpcKrQeYncT5OCmORELk0MMRgeqZ
	JW04ssrDnKwVnir66FJbVCMUCgNduQJoMy8duKOv6RAvp4FH/2pgZq/c0hzk742Rxoc3P/Djzil
	uFeXaghWcjR8lxSwDXaVkZI31O6dPLkPsM9DTYYSjSfhdT0dD2GaT3hvmJutRZrW/IOPLf9flQ0
	doTGZIDp4aSdscS7ajpj/CT//1GNncCUlYkC+ICKJPfS1DA2jXSxeuMaUhrYz2emNlMSQo/eCAw
	pa6zMDuVof+jigKw==
X-Google-Smtp-Source: AGHT+IHBWZxpw8t2WQJWHH1dRD5Xq7a3UN0E75qZrE91/OGOTvANiZcdtymT8N4j3qduv+1WA6jqCA==
X-Received: by 2002:a05:6122:6d1b:b0:561:5755:b35d with SMTP id 71dfb90a1353d-5615755b638mr1928625e0c.10.1766183492277;
        Fri, 19 Dec 2025 14:31:32 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615cf27fe6sm1411516e0c.0.2025.12.19.14.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 14:31:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-12-19
Date: Fri, 19 Dec 2025 17:31:18 -0500
Message-ID: <20251219223118.90141-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 7b8e9264f55a9c320f398e337d215e68cca50131:

  Merge tag 'net-6.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-12-19 07:55:35 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-12-19

for you to fetch changes up to 252714f1e8bdd542025b16321c790458014d6880:

  Bluetooth: btusb: revert use of devm_kzalloc in btusb (2025-12-19 17:23:18 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - MGMT: report BIS capability flags in supported settings
 - btusb: revert use of devm_kzalloc in btusb

----------------------------------------------------------------
Pauli Virtanen (1):
      Bluetooth: MGMT: report BIS capability flags in supported settings

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: btusb: revert use of devm_kzalloc in btusb

 drivers/bluetooth/btusb.c | 12 +++++++++---
 net/bluetooth/mgmt.c      |  6 ++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

