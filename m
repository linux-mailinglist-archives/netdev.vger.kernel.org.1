Return-Path: <netdev+bounces-178483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C3DA77257
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 03:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736F93AA5C5
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 01:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D581313C67C;
	Tue,  1 Apr 2025 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvQ2mksF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08B5647
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743470983; cv=none; b=ElKW4cTs8LYNR8kkZCK4UVKrhGMfIJyi2pyqnHUOZ6lrsTFkeIPJN/S6Zw3NjA4V3DQCWdbsZ7upc5vA7knHAhq9aEdc/bxfF+ssXrjGJz6baCckgK3B5OaOKTyJIki7boYS1MIxQXMaYM37S+GzK7vGMgZmED5sFRwklz93HMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743470983; c=relaxed/simple;
	bh=ZxEmAy8fzAhxeaAlw9qp1bBL6Iu4NNeApQCMmEbWk+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHVvMTqOeMOZtF7bWSYjx5FEuQa9/laJfWUnSH7D1N8+zsHlnH3Mnctb2jyvhukS4188O9o5SpLG6G6kYwm9ZgCWj52X5F1YQTX4OYdenCXPuM3Uy5fLiZEoJLLV+b/flY0hY3WXvQOETJpVtDW8c6MCKEhQ8f9dE1wmKeeGO6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvQ2mksF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC0FC4CEE3;
	Tue,  1 Apr 2025 01:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743470983;
	bh=ZxEmAy8fzAhxeaAlw9qp1bBL6Iu4NNeApQCMmEbWk+0=;
	h=From:To:Cc:Subject:Date:From;
	b=EvQ2mksFAoLyUG4GmWT+8g2Ac0NJATQK+253eGz/eUeMUbi4mQxoBpV+Hs+zP9EVo
	 KVtlU0Tn1fWc0Dt+V+h5POZkvsUP+EGmHyiZAAHFXHNbonwxPFyUYKunri98WRI21E
	 xqaIwd7JVwVALCUouxyVZaJXAlx2scKxmgminoB1xXWS4djl5KlaeF1BJoTA41kDW2
	 MMe8zf1an1gMjl0OhMkrFPHDiXlH8KU3b2Klj5WhwRncxlar9tLYpjbuioGQ8hyRsw
	 9RGFdMsjZsJ5uIpiZ4+w1/MhWoUe6cKPylWOxw3jnD2dMQXBXHVNvusoOotJon2r89
	 2mH/xegNbE4GQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	yuyanghuang@google.com,
	jacob.e.keller@intel.com
Subject: [PATCH net] netlink: specs: fix schema of rt_addr
Date: Mon, 31 Mar 2025 18:29:39 -0700
Message-ID: <20250401012939.2116915-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spec is mis-formatted, schema validation says:

  Failed validating 'type' in schema['properties']['operations']['properties']['list']['items']['properties']['dump']['properties']['request']['properties']['value']:
    {'minimum': 0, 'type': 'integer'}

  On instance['operations']['list'][3]['dump']['request']['value']:
    '58 - ifa-family'

The ifa-family clearly wants to be part of an attribute list.

Fixes: dfb0f7d9d979 ("doc/netlink: Add spec for rt addr messages")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: yuyanghuang@google.com
CC: jacob.e.keller@intel.com
---
 Documentation/netlink/specs/rt_addr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
index 5dd5469044c7..3bc9b6f9087e 100644
--- a/Documentation/netlink/specs/rt_addr.yaml
+++ b/Documentation/netlink/specs/rt_addr.yaml
@@ -187,6 +187,7 @@ protonum: 0
       dump:
         request:
           value: 58
+          attributes:
             - ifa-family
         reply:
           value: 58
-- 
2.49.0


