Return-Path: <netdev+bounces-177962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3CA733B3
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A084189D802
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0C8218584;
	Thu, 27 Mar 2025 13:57:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EBE217F30
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083834; cv=none; b=uC95rdW52Eh8hZWYWddmwl88TmxF3IZ42B1plYi+ndc2zxCwo68SryZjnpmpYTwXN776BkUTLYkiV082G4mWboobzpiaNntSxuQpN0BGBtdPJy9FsTb9PUH1NiBNQPvkZzwEDTU3b8L0vf9igfu1CiPig9a9ID7+l27zK04UmpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083834; c=relaxed/simple;
	bh=n97bsKeGNxiCQENyEnu04SJHTKTffra3u3PkxcA2ORQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWEfkn45QcHnIwChoVYQShNQtCegh8IJZS/gfhCSzDs0iKAZaNa+ROc2z6CV7t5dp+uPNM/lKYdxxL8NRo5xui4MH97yqrKRFJ3leU9rkWwGKqD9/Re3cCJYO/zQrxwsSflkEk5W0slhYjuKgMlSVyN0PywWW9VGspg0lwQJYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22435603572so19880645ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743083832; x=1743688632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SR4152Dd3dI58fOWxtoFrARZtfVG4WmmakmPAvGHxzY=;
        b=UDthSmOJmQ72WKi3N0ituJ+LFjBsVej2ZQ1PnKJlFK2U0iq7vTfb0yTr7XxOoswmRi
         piq9TIkSNSaqZfX/lMwtule59agIap0VcLoTUYot3kSpe/oHuA1Aj8r0D1aurT3o8UTV
         sPVbde+MbwdVvtc5B5IcAzcadK8yubZLjD1IU1j7lrzRJgVFDqdK2gac59j2e7gxHhwk
         7jVO5pmHLJSbr/pZ1PLZ02CMZiCpAVBZktVodnwfokmOSynoB8Au916yzIllCjJhUgz8
         W437QvPcr/XHVt4ObvH6l+Xe5QztXnAe09pzF+IdiARl/yk2sIUinD5UXYSZfJXyQbdK
         W1WQ==
X-Gm-Message-State: AOJu0YzxW6PYg9Uueh1H4W4VFQFnYnkc3V6LibPPZh/PSKnH8CzxTMSs
	JBP/tzQJGQDYLAduPhZHVLNNIUKNwhNsyHmfMd0szXRHx3gaUX7jYv9XMaX82A==
X-Gm-Gg: ASbGnctS/JtESR9wyTmSEet98HzUu8TZLalAOQ5iFJJ8slk+NOGjh7Evbe1HaHUs1Ax
	Ah5FEi7unN8TBWXO0N2YYVSS6UxOZnwW8UcSg53u/tTfWny9qK3OwjdVKYz/RsBmQtV7LoPKIBw
	y7xjf6zqQR/LswaSTJ1H55OP/Rg0ktqb+GvNUORJ+wvjz7mLm1ZXjoyT6eg5bsL/IdlCktTV6Ff
	dnzmkI+M6nk5W1YbCxz2N68qPY1l6KAtdfAGVZNlDIs9gNgxGtVwODd2GK7LDfKLkU9QSrAEnFl
	EkF0Fy/00SxsfgP8z4npE4I5qdsZ9CVoQ1kuV9n6fIfC
X-Google-Smtp-Source: AGHT+IEc4iHqjhlpsfsAK2GfYFZHsozW5jHK4BjiKatEntZDGla8YLkUWqH2xgDMq2WsMXwyxBPDDw==
X-Received: by 2002:a17:90b:2643:b0:2ee:c04a:4276 with SMTP id 98e67ed59e1d1-303a7c5e6efmr5252573a91.5.1743083831712;
        Thu, 27 Mar 2025 06:57:11 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3039f6b31fbsm2202933a91.40.2025.03.27.06.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 06:57:11 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v2 08/11] docs: net: document netdev notifier expectations
Date: Thu, 27 Mar 2025 06:56:56 -0700
Message-ID: <20250327135659.2057487-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327135659.2057487-1-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't have a consistent state yet, but document where we think
we are and where we wanna be.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index ebb868f50ac2..89337cfec36e 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -343,6 +343,24 @@ there are two sets of interfaces: ``dev_xxx`` and ``netif_xxx`` (e.g.,
 acquiring the instance lock themselves, while the ``netif_xxx`` functions
 assume that the driver has already acquired the instance lock.
 
+Notifiers and netdev instance lock
+==================================
+
+For device drivers that implement shaping or queue management APIs,
+some of the notifiers (``enum netdev_cmd``) are running under the netdev
+instance lock.
+
+Currently only the following notifiers are running under the instance lock:
+* ``NETDEV_REGISTER``
+* ``NETDEV_UP``
+* ``NETDEV_UNREGISTER``
+
+There are no clear expectations for the remaining notifiers. Notifiers not on
+the list may run with or without the instance lock, potentially even invoking
+the same notifier type with and without the lock from different code paths.
+The goal is to eventually ensure that all (or most, with a few documented
+exceptions) notifiers run under the instance lock.
+
 NETDEV_INTERNAL symbol namespace
 ================================
 
-- 
2.48.1


