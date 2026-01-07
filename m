Return-Path: <netdev+bounces-247894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B32D00500
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 23:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FF3A303932A
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 22:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8155E28B4FE;
	Wed,  7 Jan 2026 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="kRXDm2xR"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A270277CB8;
	Wed,  7 Jan 2026 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767824977; cv=none; b=mGjdgbgW/q+ZjFfmChOkq5tUVprFxqikhl+rDeprzIEx8nndf6mwMxWPUgTj8Nn6LOjMpOCZ3ouLy36V8R+8wqqjsX+Cp78L+Ifqx92flNVj2XWWPFFcqNdFqXv9qjZ6ZhgeUU34mWj9TMYCJR3Ulmo69iMMqzmza+kNBS8Isrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767824977; c=relaxed/simple;
	bh=FX5BOtEvn9cZ88R4XqQ80tigsQ3WQC+/Lk6Iehc7AVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fmnMIaJgeLEQmj4DC7i1iNIVq0bSdxzybCoSAIXhkMNC0nOxqXkVCk4hOx6sBXA0E8aFo3auKj/joCHBshtZvD2tAUTpd1LDfcsM4lU7JCssZqwqBL7jKHOJyqaF81L3bv2WMqYve33F4rE8FHcDidMC9Rfr3asRiwPNe/7240s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=kRXDm2xR; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D3DA53D84AB3;
	Wed,  7 Jan 2026 17:19:49 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id k2N2unnhSoyv; Wed,  7 Jan 2026 17:19:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1ACAD3D8517C;
	Wed,  7 Jan 2026 17:19:49 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 1ACAD3D8517C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1767824389; bh=hwV7fPPT4Vumrcd5EA84SEtjdIDKKs2BX246mO0E9IA=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=kRXDm2xR9LXR1YGRTu+W/JWDR/Oc3Te0A2cmXeEli7lJnof4iNA2Uggg/NIAL+KAL
	 Afyg/eXxcSqum/gFekC95OjwvFkz5eI6tVSJnmoN+yjQFwjcFeD/rMDH2VHSXYBAMa
	 RWZQ0MH/EtmR8mJfwcYq76uYfQKY9+XlDwaEBdq4ITLBg6VtcmLImM/i4KLYjYtGLv
	 4A7XbCIxuo8F/5uiKvxR65rhfLcb8NN7zzH97XkFxwN3HtQV4i4HkJqVtDgDOG3djc
	 ZnBUNOC09m+DrUkRwdcZ13CALkl44eQuN6NvrHEXn0s6HkWfB4sX4QDK9fDG9eCdqb
	 BkcGMB4Fi0Wrg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 9CkhaMTdnD1X; Wed,  7 Jan 2026 17:19:48 -0500 (EST)
Received: from oitua-pc.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id E25103D84AB3;
	Wed,  7 Jan 2026 17:19:48 -0500 (EST)
From: Osose Itua <osose.itua@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	jerome.oufella@savoirfairelinux.com,
	Osose Itua <osose.itua@savoirfairelinux.com>
Subject: [PATCH v3 0/2] net: phy: adin: enable configuration of the LP Termination Register
Date: Wed,  7 Jan 2026 17:16:51 -0500
Message-ID: <20260107221913.1334157-1-osose.itua@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable

Changes in v3:
- put bindings patch first in the patchset
- update commit message of the bindings patch and improve the bindings
  description to better explain why the added property is needed (as
  suggested by Nuno S=C3=A1 and Andrew Lunn)
- rework bit clearing to use phy_clear_bits_mmd() instead of
  phy_write_mmd() since only a single bit needs to be cleared (as noted
  by Subbaraya Sundeep)
- remove redundant phy_read_mmd() and error checking (as suggested by
  Nuno S=C3=A1)
- remove unnecessary C++ <cerrno> include that was causing build issues

Changes in v2:
- rework phy_read_mmd() error handling

Osose Itua (2):
  dt-bindings: net: adi,adin: document LP Termination property
  net: phy: adin: enable configuration of the LP Termination Register

 .../devicetree/bindings/net/adi,adin.yaml     | 14 +++++++++++++
 drivers/net/phy/adin.c                        | 20 +++++++++++++++++++
 2 files changed, 34 insertions(+)

