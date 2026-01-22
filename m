Return-Path: <netdev+bounces-252527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMlsGrKDcmkrlwAAu9opvQ
	(envelope-from <netdev+bounces-252527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:08:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4726D576
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 920BC300A8F8
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF1C39CECC;
	Thu, 22 Jan 2026 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHJY1WkT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D791839CB50
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112490; cv=none; b=tWQW5Dy6vJdM2lwZivXJMo9UdzPn0HAE0LzDQ7DjwgoKnibDRCAhS13EYgmWqh5jtjskwM8Vw48hYlCWBuew7fMAL3rONMxRcLMG4kF3X8EPMd+FgYL6OEi/a0nkJgzZReCojeJVFvn4NE08uBIA0l28ln5X61BocnzPA2WKz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112490; c=relaxed/simple;
	bh=wm/RHjuswNCwmBvnkmo+iGq3fd3NCN9KTPdUzB6kpX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPbDjHthPuJ6fnolfVpwkQesChBmM7LXvwPL42rvgexAzN9Z7QfwyQzRvK+2OKb1FU7WBBDw0VVa+rUvEd+PkD64RaxbR3GEDGnZHAYJncs/9KXtywru9gYoEwlpAhk/hDwaYdDy15g+Z6bOnAQAvxViCn/9bWkpYanQGdntLLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHJY1WkT; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79273a294edso13731197b3.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769112482; x=1769717282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zP48DsrAV6yhVQzMKRTRKuibNQZ+iRXBgot6LlmaTJc=;
        b=WHJY1WkTOKsBPQdh20jfhb19N1pTQKzxgS/KvL+Y51EgbSS1uZNk2Y6gJ8lx/v92yY
         rXcij9YJD/pqOCpQx7h+Q3B0TzWJKgbq1yPe0OzKXmU1iB8P4v+g8FAsXl+4mChDczU3
         fkoTLF0V2fmwyDaB5t7/7m/4Y2g4rZP1jxp4163bKF0gxCvQ0gVV8IA3XCcjTx2uhuEL
         X+wIN3dApeJgMMknDHYyX4rJ+sX+JCg/aP2221fJoiXArsg3OOiKu+w+EIh9uejzzRmf
         5VAsJyLg/eljuz4qSF9AlipgXwCJAXP9JcZyROJn2/Vh/rK/o/hJ72hvDRLBHFgr9CYf
         sKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769112482; x=1769717282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP48DsrAV6yhVQzMKRTRKuibNQZ+iRXBgot6LlmaTJc=;
        b=UY3TilZfBlYWiIUw9cuj2HL1oYI1djkOA2YkJEzP5ukI46pdCETy7qf4BDFlIbzc+q
         jV0iT3vinqiclu9iHOqhp0slEppyuWfyzMFgMUOUcdM5d58jWlxP/6VJk3PV8soVf0Ff
         RyYAnn/Z/Usfxj8IqEyXhMQV0oMPPnVFakBDpZRiLJVnSjfE4qyC+wOb9Cd5ESje52aM
         rN4nu0kOI58tnNo1nlrx/w1na+fwtly2S4XJiz1nnB2iUssvctp8VLtauVvnrGSMMeYp
         hAD055wif6RCtRgIsbLjExm6vceDIYi0KHuREQ97ad9tqtVMQeYcEoaT44X4OJiIIahw
         nY6A==
X-Forwarded-Encrypted: i=1; AJvYcCXuaEgy//LP/1QrgkK5Fyy4T60lNXY8dsUQ/49lx2DHcNCb903cPDbxTeMxqgK2PUlvxWEK50Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZBXwiLVZKXihsSJiz+3H7Cwk7ptmAC8WMY1f58dktL1ZG1TF
	G5X8E0L+vtmcnYwYCF37PzrSjRqxXF4mwDERvXGizWfJgqHfZ2dCQqjzc9ij+mPs
X-Gm-Gg: AZuq6aKLDdjMzdtDIDMkSk5ZQzLAq56FozbuNgCXqNBibad4VoBS5Fa7HOKpmln2cgN
	GF3JwoiXCc2hiKfAN05NDjdNq3hf3wEmI62621hfwq+/2BE8gpEfqti4jXyHeu6mwkxgD8Zlj9+
	9QX7Rizj2JvkVCnVGvyaxSlHox5HtXZy7Bp7CTLwCS62qJF/d4pDe0/Nc66xy6MqlZ6MbSvTkO4
	xaCwYpW6usbg744H+YM7n4173s88uYTkF0V/W4iUeWyfdh0r4Qer7Pe/xIWBthpIQ5z47uWc0E8
	Weo16v8VYCM/VyQl/YXI94Wqiy8ladc9ydzBjb6QtSMKJfWqoWrjepsmOYqQDCu1SRy+xpIAM0W
	e8BKe563NH+pQd1SOJn9Y+GRMIDLJw2kWyWWP89341oTbwVVtLv67bxl+NUjyxTnJKv4fU/BRkF
	Am+aHPIshtPYEM6QtT2En4F2+J4JkpEBShtRO/VICzwd7LXBrNhp6wnfs62iSu74Oty2QHh8uv5
	3eTqbQ2rznCDDIC
X-Received: by 2002:a05:690c:9:b0:793:8eec:3a7a with SMTP id 00721157ae682-794398eefaamr8131917b3.29.1769112481914;
        Thu, 22 Jan 2026 12:08:01 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943af14432sm1004227b3.8.2026.01.22.12.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 12:08:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-01-22
Date: Thu, 22 Jan 2026 15:07:51 -0500
Message-ID: <20260122200751.2950279-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-252527-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D4726D576
X-Rspamd-Action: no action

The following changes since commit 4a3dba48188208e4f66822800e042686784d29d1:

  Octeontx2-af: Add proper checks for fwdata (2026-01-22 08:09:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-01-22

for you to fetch changes up to 1b9c17fd0a7fdcbe69ec5d6fe8e50bc5ed7f01f2:

  Bluetooth: MGMT: Fix memory leak in set_ssp_complete (2026-01-22 13:26:53 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_uart: fix null-ptr-deref in hci_uart_write_work
 - MGMT: Fix memory leak in set_ssp_complete

----------------------------------------------------------------
Jia-Hong Su (1):
      Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work

Jianpeng Chang (1):
      Bluetooth: MGMT: Fix memory leak in set_ssp_complete

 drivers/bluetooth/hci_ldisc.c | 4 ++--
 net/bluetooth/mgmt.c          | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

