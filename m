Return-Path: <netdev+bounces-170440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC3BA48BAC
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 23:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FFC16D15D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5F01B85DF;
	Thu, 27 Feb 2025 22:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4hjXFg1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E127781A;
	Thu, 27 Feb 2025 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695888; cv=none; b=YTp2jKzit6s5Iv5AOsGljSaDn93ZmuXg7AVqIV4y3l8WAiE7cK70tCxjWqZd5oAUZv3+dniaI9gqa+4RbY5k0OhOepcUw0dtfPxnEALSCqekxn40ayNNluTs8ktS39dbxON3cuJV48Nja+SyoI8tsit4aTksqwX4ZNFSR7BKM5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695888; c=relaxed/simple;
	bh=y9vuwVNs9E+ViNDzpF1Hv/2+VVfXu6gpKKa1PhJ/pfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMaTSbKbtS/zYdA4M7hKrWO9z+YcJX3qMR2PkEMk7HtIxNpxZ+BMonu6Su7TDAD38BJGxBZ5rRlhgOY0g5jbm1pdyoDdJPPnd7HquMga4AmdY6a1ZYsJc/d6+OnyMnYDsARUm1fE9DUYmD9iZvBAbzBrcygUAJipfbT8fpZQl4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4hjXFg1; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86b31db3c3bso610239241.3;
        Thu, 27 Feb 2025 14:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740695886; x=1741300686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ONmx+iqhXJxMRSV6RFJpiN+6iIp6BXYnzQmBEf4wKY=;
        b=m4hjXFg1VSx3j5ZCpg7b1Fv7HzgKQuIHTSju/anRbcjHoLNtQhKsE3Vz7rJ/PBaIqx
         DY5F09gSzyCIrbOzj1hRmvfv+AwYLts+sO0A1lMHtXqW+56KEYnKo0x7ue0TxUSdN7XH
         KAdi/m1xzQevItvDM/NgZNmjhKQbgxDDwm73tEFYlACcZ+1yhEjfzs66IYDfH4yR8mwB
         c8kcp8WKHkAj+TUIYbXn9d7KNKR+uuxNxCKlMDlESTu7K05hfm0PR78s9/K/pcwJzzXR
         QERXW4y0s4PgSzd/yNyXXzvHwC3DYHXJUUH0GPBqKKLb3P2DTUoHop2IFUv01FfdEHhg
         4T7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695886; x=1741300686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ONmx+iqhXJxMRSV6RFJpiN+6iIp6BXYnzQmBEf4wKY=;
        b=Asi6To2ZSK6uq8SVC6Y53WjzAmTzPunK8cck+h8tyneC1a6w9NqUWlHnhqF+juPCYa
         9JDsZ5B9DQhU4VMGimvnwXvrGgNiUlV3qrcQPsy9xi6wZ2/yU5mWrlSlxNqWWZ2uk5uO
         b3jDsgbAUbp9hEBFNLq4vaDSEywmEtiMA3Gl7qEfeHffl+YkBlLXDlwN464TAv9RrGm8
         OWTCRm/wEWKqF0OAUY9nO1ArFdZ+eB7VkWfL7twOPHZGrKxbxoi3/S+jrfY99vp7eS7H
         +YULTU3b1fXsNhZRToxpX4+s0t/AtTamokE9e0/HcwccPFODSMxtw/OkNptbprWk2ogk
         0ang==
X-Forwarded-Encrypted: i=1; AJvYcCUMHNhpmnW8cLn3CFMvzm9+hhsBgxq1OyNUbwmRydxzc+q7i6a68sP3iUaj3c7kmWKQnnYL9fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQdQKW2gATOCga1QJQ3O6PLeOSf0GwdbgceHq2jG0Mc9FDmFB0
	QEsm5PkyaBX9WurwrTbSpmg5Dg2WFAApPfljLFFDiFWcSYQiQBu28Hg5H7m0
X-Gm-Gg: ASbGnctrt1rh28R3eNKa2vcRBVuqSsXX1GG2F+W8V5ToXpHzIbRO/i6eSM4G1x7X9JJ
	CpvGbFwBOQUlseQttk6V1KYtMY+Cy0+jxDMBpg3lUyMldyY49CWwnmcT6qxIcb9qwmJUszOhcQK
	mw3nKlzL9mll/K89RAJOOrF55FZ7QRJz1xr/k0il15SOfSS7AXwyws+9E+zwYW/R8BIQkyp/jJI
	QpfNM8CgeWaiY23yXSyrU5R+NxpPbsSoTQfX7i+EN/H3MbkKOjM2m4NOdf5rcsannGPKdvCw1uA
	8Fa8OMELPW37fquTYyaQvETRNRDOOYJuTQm3HWiOPWjkU6bX4K1o/+qVjhwKo4peE92ialo=
X-Google-Smtp-Source: AGHT+IG8wuSS0ex55PfG/NCrDxCDLDh4fCTs8xaF7r+r+i/qKFHkRe7pXjY/Arl6IczF7cYzdwF6jg==
X-Received: by 2002:a05:6102:1512:b0:4b2:c391:7d16 with SMTP id ada2fe7eead31-4c0448b9b00mr1110964137.7.1740695886050;
        Thu, 27 Feb 2025 14:38:06 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c0345f8e1esm464890137.2.2025.02.27.14.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:38:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-02-27
Date: Thu, 27 Feb 2025 17:38:02 -0500
Message-ID: <20250227223802.3299088-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 1e15510b71c99c6e49134d756df91069f7d18141:

  Merge tag 'net-6.14-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-02-27 09:32:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-02-27

for you to fetch changes up to d8df010f72b8a32aaea393e36121738bb53ed905:

  Bluetooth: Add check for mgmt_alloc_skb() in mgmt_device_connected() (2025-02-27 16:50:30 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - mgmt: Check return of mgmt_alloc_skb
 - btusb: Initialize .owner field of force_poll_sync_fops

----------------------------------------------------------------
Haoxiang Li (2):
      Bluetooth: Add check for mgmt_alloc_skb() in mgmt_remote_name()
      Bluetooth: Add check for mgmt_alloc_skb() in mgmt_device_connected()

Salah Triki (1):
      bluetooth: btusb: Initialize .owner field of force_poll_sync_fops

 drivers/bluetooth/btusb.c | 1 +
 net/bluetooth/mgmt.c      | 5 +++++
 2 files changed, 6 insertions(+)

