Return-Path: <netdev+bounces-129806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D229864DD
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 18:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798A5B25C89
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E150C481CE;
	Wed, 25 Sep 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tQXHdRP5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BDB3770D
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281858; cv=none; b=tpMfBao/5jw2FIGfxbLmQ/2vMM1PAu+6iZ2p4A7PqArsE1/Px4PxeWbZar2/Qgf8RIOtEigWLdgTwi3tMMWlcVUVWE19nn2FzKkmNPrfVbNVP+hvXeyV2ijGpIjFB9waQODudhWPmT4KrloSAcEvpgNcz24qIA6ng6zZliH23dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281858; c=relaxed/simple;
	bh=EAbxcK+s42kHz3mBMZKweFlRJzPZRhdYDnssi80OOXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GdTzcFntAwC1pv2hFxHJbKsVHIwRPXele/7elyIk0pj6qKNIX2kKx3w9mWVBB9XEECWDNuTHUK9B/1gYRCFsJysndNYyFR7XPJGErl4HgJObpoj2Ok/PWrUmdgX2eKPvxkGQ/oh14DXTRrz1g7m5Cnw9f5SW52ePo7ES24UPSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tQXHdRP5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2068acc8b98so68466265ad.3
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727281856; x=1727886656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kK7pukRuGPZ/J5N4BTKEwTPZ9aTZGIEZLBkRRr7miMU=;
        b=tQXHdRP5L567bozBknKxpG6CsTpMEFqecB7il2l6CBSV/TsNOriYnXZMgiwjFQ2zpl
         X41RUCpDtxdMLPTDXffMxIN/EXY4uz9MCbLz8EfiyDkrAdHmbMwtxQg6+p3c3780jrW0
         DUK3GwWX5tfknV0qKCaG9N0RJwU88E+n2kDJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281856; x=1727886656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kK7pukRuGPZ/J5N4BTKEwTPZ9aTZGIEZLBkRRr7miMU=;
        b=dGYULXnVknyVLOnsywBAhkd6AwyKiBxW/JfKUQcL0vexLeLZwS+NgvAzM8Zd1SLDko
         qnFObI5xhi5KvmzRgabunTg/bV2qmB+MMZwLOF1Dk7LqvSk6OhvQTZzCEMhTVkHJKwZe
         3Vz2FzsJg7WvPrSYGOOrF+os5mg/20lamIvMWXLMZimIjvC51pxUCuCI0MnQkfWDhZqL
         iUCOeaNPygOhdHRbfBSfJe7Z83L3VhhZLMbEY1eflAD6GouKildipDjWRk08YzE1yQ5E
         jg6az28+KzGE7Uopk+5wF7knVWsqt9qjW3r2NEhrFeX5hPOvfnUpuTKmbMkozUiljQyd
         dKFw==
X-Gm-Message-State: AOJu0YxaCpy8f7Jk6HlICFRrlsifcBhxRJZmeD90Vc5eh1LiYVJr79fW
	rKpO/QTrO2k9ENCyf4UMjZ2zRfwvfKvmgMaYI2L6fwqK+uv4lhuX5Dcoo+667WCmwiSYcFo0zFt
	Qz1eBih7DivGrEcphn8ZUWGDnDvBtpTG39DVkOt5UbAOakEv7SMC6w/fQ25PSOt/kxXe80/malG
	3hdK8huDOOQcPBN+vJm7W8Ez1JNAk4Ky+/ATQ=
X-Google-Smtp-Source: AGHT+IEHp2ua/y2JhHEUQmnJDaScDzANw0skOHs+EK5VHrFMUdYBMLnr1D2U0v2jjV1OmAT8NFCtbg==
X-Received: by 2002:a17:902:e5d1:b0:205:755c:dde6 with SMTP id d9443c01a7336-20afc4b4847mr44173255ad.30.1727281855985;
        Wed, 25 Sep 2024 09:30:55 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e0702sm26345585ad.28.2024.09.25.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:30:55 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 net-next 0/2] e1000/e1000e: Link IRQs, NAPIs, and queues
Date: Wed, 25 Sep 2024 16:29:35 +0000
Message-Id: <20240925162937.2218-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This RFC v2 follows from an RFC submission I sent [1] for e1000e. The
original RFC added netdev-genl support for e1000e, but this new RFC
includes a patch to add support for e1000, as well.

Supporting this API in these drivers is very useful as commonly used
virtualization software, like VMWare Fusion and VirtualBox, expose e1000e
and e1000 NICs to VMs.

Developers who work on user apps in VMs may find themselves in need of
access to this API to build, test, or run CI on their apps. This is
especially true for apps which use epoll based busy poll and rely on
userland mapping NAPI IDs to queues.

I plan to send this series as an official patch series next week when
net-next reopens, but wanted to give the Intel folks a head's up incase
they had any comments or feedback I could address before then.

I've tested both patches; please see the commit messages for more details.

Thanks,
Joe

[1]: https://lore.kernel.org/lkml/20240918135726.1330-1-jdamato@fastly.com/

rfcv2:
  - Added patch 2 which includes netdev-genl support for e1000


Joe Damato (2):
  e1000e: link NAPI instances to queues and IRQs
  e1000: Link IRQs and queues to NAPIs

 drivers/net/ethernet/intel/e1000/e1000_main.c |  5 +++++
 drivers/net/ethernet/intel/e1000e/netdev.c    | 11 +++++++++++
 2 files changed, 16 insertions(+)

-- 
2.34.1


