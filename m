Return-Path: <netdev+bounces-252562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLNcDWercmkkogAAu9opvQ
	(envelope-from <netdev+bounces-252562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:57:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 846FF6E573
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA5F300B044
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6587E3994C3;
	Thu, 22 Jan 2026 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+EjnBhR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF03806DE
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769122658; cv=none; b=Z11fEZ9zvFgl+s7JdPoknF9TqcDTWES9apdfH1gr5DNV2MSNc9fAoPJZ6L2+5oUnWPM3iQl/nvU/74WsfP2a4z1OPd8LvTHs+SJKpyhihkmrS0Cp2xuYQNd4uLSs88Ex7J5VikASeIdpHVM7qdSDMpxFz77pyrp2NTjR3RWEsSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769122658; c=relaxed/simple;
	bh=AdS0pPIeKqlvi2FCQZposBDiesLZJa7Q7OkoovB3f7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=asaM3UAWV3+FOrB4M2OOLZf2ibOlCr8GePYSzLPBsw5hlMXWxNpKKeezHUKx4i6K+BVxZEU/qeTHMHHd7BbNRp7oRGnf0vyuNEbk2I0kcYm2VfHKX2KSACMkafgE88IilyD3ZBNMlhuLW8x+zx3vLkRHbqJElLRTAQn8QBYBJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+EjnBhR; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7cfcebf1725so1045022a34.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769122645; x=1769727445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJU1eocd9c215PKSFJkz/SPf5yt/fOajjiK68fvi4ic=;
        b=c+EjnBhRXipWZ9o5FYHs7Wwb+c/fnSu7f41nc9+ZD2OP6GcMSm/U4CwicB7ttfip7O
         HxJSWapxCMxRBfS+lyP3SNCtA4Lo5HTZ0dsvLb0HJQN/HKb/JelZmMTd5h8w8YGUKw39
         IjHkphO0Azxw5RLeaUeTa28STuNDSsUQk7mibB9I7nrZxQ1cxcyh06lZfi7MOcU5tI1+
         eDQEzx4nXZ62D82xpj8BOiFgtMV2bbOsJ9wcE8ZD9vAH73Qf3Fr2P/W0NbJg8QdsXEv7
         JRpAPdx/EwWZF55A2UhEOAcW4eQWt+upVEJrnkmY6aFLpUc+tFjRO+M/oKwKvIyvHB1v
         P3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769122645; x=1769727445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJU1eocd9c215PKSFJkz/SPf5yt/fOajjiK68fvi4ic=;
        b=evgXAtuo06MAOqHOdtwVItp8SypKe1aGEHNXedxabJ6pFhXCu4/bQKo0Hw2pxUhBir
         5X7YdHkLpuDW9n6hIwX+wvyOyttszpgLIhIQ3zPUIrimD5Hcy41ZGRI4H+BY714dckiT
         t5xoV0bwHeEs2FPeu+xqk1qkLAuAQEiPAvKaZf0qF9myI5EMvPYH40B6gG0coXSJ0VeH
         EBURnonG9AHYVBPoIt0qoVYuZFiIrAtZbaE0E8iq33G6kqSmwU9bgSul16Cwwtarr/Vg
         VmZ862+q+fSiYgrEY7lHikfLa6+BNlsyOGo3jxT4HGmuf0qkVM3ChaDHdjc/aO6ON/8z
         wd9w==
X-Forwarded-Encrypted: i=1; AJvYcCX0FNw4KxFTZ4C8sNfTuPsoHtKCSAFz46uIwV0WisqkAbZu9/HMAld1DSpyF6hvenfcV/aA8d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybVpM/7NvxOf2h0DDvLuA+6PnYAwJe/pBZAr68elagV8OLYd1E
	Z846RATy49L0nDm+18+zw5evXNLigwwffMAnqiYcW1/SrJ5qw/oZNXMMfYUuqXI1
X-Gm-Gg: AZuq6aIRk/vYhrb9wRDrwlWhFTis2KiLek54Ju6NiUkqQo8GaH4/seIqlujyIlutVxJ
	FPmp7E63lqNwN64FgAaNxBRXZGcdSjvNPxFOse0At6TNjXZiTn/BdeB1n0M47jK9StYt0Kke1bB
	v34UxSUBjY/gaeDefOPGnzhFGqDaVfjQJk8WUXBj93TL9VDkQnP3c9f0HAkznjuos5V/EH9rvsi
	rV/ehPCh4LampJ6KPc5BB69Nz+9MIvjhfAM+PrzbHdomtqdmKckue+ILhaaCUAHiUT9wNuQxNl8
	HUEjuzmo41b92rQS+b0CwQK84H6eHSYlMdcIqCctHjU+0FtBHkjrA93m4Dit29QQt3BT6kX0fVH
	DqXANtQED+LqzrEZ38Kma4AZPzPv6yGaZaQzH5OA7RtLMLDsM6pJ8HarB5nC7n4+GlsKiWG/nxJ
	HgNNBjTKzJ4eoCnvaSUg==
X-Received: by 2002:a05:6830:3114:b0:7c7:5d72:567b with SMTP id 46e09a7af769-7d15a62059amr657745a34.23.1769122644856;
        Thu, 22 Jan 2026 14:57:24 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b35e1b8sm467052a34.10.2026.01.22.14.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 14:57:24 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] Documentation: net: Fix typos in netdevices.rst
Date: Thu, 22 Jan 2026 14:57:23 -0800
Message-ID: <20260122225723.2368698-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-252562-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 846FF6E573
X-Rspamd-Action: no action

Fixes two minor typos. Specifically, on -> or and Devices -> Device.

Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
---
 Documentation/networking/netdevices.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 7ebb6c36482d..35704d115312 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -80,7 +80,7 @@ unregister_netdev() closes the device and waits for all users to be done
 with it. The memory of struct net_device itself may still be referenced
 by sysfs but all operations on that device will fail.
 
-free_netdev() can be called after unregister_netdev() returns on when
+free_netdev() can be called after unregister_netdev() returns or when
 register_netdev() failed.
 
 Device management under RTNL
@@ -333,7 +333,7 @@ In the future, there will be an option for individual
 drivers to opt out of using ``rtnl_lock`` and instead perform their control
 operations directly under the netdev instance lock.
 
-Devices drivers are encouraged to rely on the instance lock where possible.
+Device drivers are encouraged to rely on the instance lock where possible.
 
 For the (mostly software) drivers that need to interact with the core stack,
 there are two sets of interfaces: ``dev_xxx``/``netdev_xxx`` and ``netif_xxx``
-- 
2.47.3


