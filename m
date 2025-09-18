Return-Path: <netdev+bounces-224515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981CB85D26
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2D47C1A35
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461AD313D79;
	Thu, 18 Sep 2025 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8u4EYsZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A530FC30
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210729; cv=none; b=W5ZFEcXUhyCKMMjKUPRf5O+vFhq53kA1IKDKUNwKucb8yHxCJuq3g7Tl3kXk+Dt3Sah+ZH0d0Nn0yD55ig3ISEA6X1R3G3UxluqcNzpgDDIop5z+S/x2jchKiOgbtrRRxnGScYfcJX2Ogo7HgUVClo/gjo6wL+ynwJR7gBkAgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210729; c=relaxed/simple;
	bh=Bbcw5ysO/p4VcTUCP7pQG4wZeTfWxZBNP2UZfmTYD2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPrW3vII49zzsEsm25zr8n0X/M59wEztJxW/VmwZROWjpmwbswpYKftukooXnrtA4FuSjgeXMppphzPVK5bLSgYP+afn53soX+DZ40C5CzsRKQ/VkQAMqr8nZW2L08bYhXQ9Hdi1om0xi7GFWQMsxAQmrgehb0qLOmBVFpVK/vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8u4EYsZ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60528734so7981587b3.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758210726; x=1758815526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HaritVDqJZVI991A36dLvBWCYOeh9jHTWN8YhtiOfm0=;
        b=C8u4EYsZbUAwNzR8TPqqeOQUU8+iFN+IYcU7mQGQ1woMOvKqenUgiD7LYbt7fSwc/p
         NMlUnlQHNS+Cb3RuzEqTmqsMsLomhzmX3ztn2cJGdWTGtsNC04Nro5bleHgefB2F6NSO
         GKW+u3b5XWyUndTtcnSjewe3Z7PiK2yJApP+ZRGTSsaEbwf/E1042u8EFkSPeSeMzsnI
         +1ptWMFSo6jj9MXRXrVVf0zDfPdhtI38gC9EE2aQmJAqNh+RffLG4AJ+6lbhs7JxmM8D
         D9OGBh+xrt0cmljIejr7mGMty7Fkn0iwGKKKbSfw7Ba9FdArQ5krcSv1GPZKHrJwPzeC
         QEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210726; x=1758815526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaritVDqJZVI991A36dLvBWCYOeh9jHTWN8YhtiOfm0=;
        b=E0ENdAPeGeZxut42bWhrgbx7YV58fPeXsCk0csdxxG6hwaGJueSimvf7X6qw3amVvz
         N4DwA1zusSIcApSFty/t0v+EtSQxhVs+dD3hRE3S8haXBJzGLAaJpOV+kgwGBgZnL/0e
         xSiSlIpTWV+R+zonOywsJkoj3faGM3lnzXZB+13ZYH50s1uyb4tsjYkIGXM/9SVYNzc5
         k/exPmqdbEOsWK9yYp/3YNFtR8ml0ZwlArWXeBxZvKzA3Wx2+vHvbMUEt/9lExvkoiu2
         4DSPYeV3mOwzPK05RZ6qjhpdBO5bsAysJ++VnPx5olhpg2r7Sw0eaolWVRBZ/8XLhAi4
         bntw==
X-Forwarded-Encrypted: i=1; AJvYcCV/I1dYEZyZrVlkKo57gJiKd1YQAVwM6VlVofge4Cda9quXTQR8D/av5FKJkOpFSLlXtWlvaNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWBA8ILeQYz9crJURxZ1qn4DfgUkXmMaI+e5hzIHI3VMCw3qzY
	g2cK6WwVijfTuenE4MhNL/ACjZ1JKA+g3eRjzoN1qOjUk4OtbGQXS7PI
X-Gm-Gg: ASbGncuF+VrcZlAaN4b8TUW+wwXxZ4dDA5O+VhZKG39GCfhF/jjhDjXDBUF88JgdKRl
	J8v07YgbLGy1heWJvsA/p91Y91cOiHDgiKj2ySASsg2OGZtAdkr9u8qtT+S/cppG2inUyq8wMXv
	yVtCDuzjpPm3GRClgAs9DDhDm3bBqgz1OjqdCHIcM40P9VGteJ0W8bR9LbeKuXL+AC1SMeGRjmD
	0oyS5ixLRvcc93TH7VNvE/lKAGlB8OkvLAJRr8iqcFSbS2WT7KxuivExQNkuYpYLJlpjCBfn+7y
	YcoSZLGe3YmPOMPHxn8AicPVLtHBNa1Au/E6FLCixoBU1tIJ3EvWleQXu65b4wd0GibkLB11VfR
	gl1ejvpT89gzDu+2ixuxsTMAp/9MrXmSvXlH1AsA=
X-Google-Smtp-Source: AGHT+IEmQ3M7xpQhHTnJIPcLTV5pu0z+w7KAOJj+eysd8LLcGoUf6qpDhJyLvkv3EpWrqezCZfwlnQ==
X-Received: by 2002:a05:690c:88:b0:732:f9d3:53e0 with SMTP id 00721157ae682-73891b83df8mr46636597b3.32.1758210726547;
        Thu, 18 Sep 2025 08:52:06 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739716bf24dsm7587547b3.7.2025.09.18.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:52:06 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/3] address miscellaneous issues with psp_sk_get_assoc_rcu()
Date: Thu, 18 Sep 2025 08:52:01 -0700
Message-ID: <20250918155205.2197603-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were a few minor issues with psp_sk_get_assoc_rcu() identified
by Eric in his review of the initial psp series. This series addresses
them.

Daniel Zahka (3):
  psp: make struct sock argument const in psp_sk_get_assoc_rcu()
  psp: fix preemptive inet_twsk() cast in psp_sk_get_assoc_rcu()
  psp: don't use flags for checking sk_state

 include/net/psp/functions.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.47.3


