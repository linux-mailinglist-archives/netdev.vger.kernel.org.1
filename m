Return-Path: <netdev+bounces-94635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800B88C0051
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B95B28AB59
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40D126F1A;
	Wed,  8 May 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="bm5BYzmS"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A5D86621;
	Wed,  8 May 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179394; cv=none; b=ieAKBv5rfT7xNiutlKzd8oXSCTsydZN4kE+RhCCell8lckKjeDZUACJJ2ISM3o02wy4MxZU8UWPgBxcBRCsydTDWsakK0Ap4F8ZFUj91v0m0IUEhkxs6goFUgshMNCAlmDSEjQBW2C+FuaAIZ+FiYBoNNFpmpoq8BmTCRGcLn7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179394; c=relaxed/simple;
	bh=4/NGqnq/P6W7DCZCCHJpFo8vOoNfYri66a2ARCZZTzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuA1ivODldT7MdN+XKsweILyePkPL7tBDJQ/pYvqnxTTEAgiPtZVp8RNrKRb0jz/0pFbLKfUo9FYqbB6hd0oX3s2oLcWh3Tpw4kQvANpmTCduJPjTK9F2bzRGYJ/QGsF/LNSSNZJHuwTs4rn0wNQ59/815rijPSTaH87Fu4oGLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=bm5BYzmS; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id B1B88600AF;
	Wed,  8 May 2024 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178867;
	bh=4/NGqnq/P6W7DCZCCHJpFo8vOoNfYri66a2ARCZZTzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bm5BYzmS0A/WGy7fjQKTkxZnk36q+rM5E7xQXmeiuGeYPpG0Aq5uTuRXOucjw8Ecc
	 PhTLoC6sM8ZgJP0mZJUdV0HrQAzW5vpjoWUbNrzg8GDpp5NentHJ4BvZYAau6rK5Jx
	 UGgCkzb+m9m9s2mGNRGxckFftU3L20pLGZZsQTcNOWc/7eOTuOrfuYSP824riQD9t3
	 /z010XmUO5CwaymCeO4cmKlRqvYdu/OJuYULAxcjXurjGM7lutIm7VFXyJy82eHdgu
	 ITcxufYOR0MuuVVbLF1gVXPfgnmDspwcrNgDHpGuRZ1/bvObWGZH2+wLQTDljt1GLK
	 OIghNMKgn644w==
Received: by x201s (Postfix, from userid 1000)
	id E4E7B2081D3; Wed, 08 May 2024 14:34:06 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 10/14] net: qede: add extack in qede_add_tc_flower_fltr()
Date: Wed,  8 May 2024 14:33:58 +0000
Message-ID: <20240508143404.95901-11-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240508143404.95901-1-ast@fiberby.net>
References: <20240508143404.95901-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define extack locally, to reduce line lengths and aid future users.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 69dbd615b653..09ffcb86924b 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1876,6 +1876,7 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 			    struct flow_cls_offload *f)
 {
+	struct netlink_ext_ack *extack = f->common.extack;
 	struct qede_arfs_fltr_node *n;
 	struct qede_arfs_tuple t;
 	int min_hlen, rc;
@@ -1903,7 +1904,7 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 	}
 
 	/* parse tc actions and get the vf_id */
-	rc = qede_parse_actions(edev, &f->rule->action, f->common.extack);
+	rc = qede_parse_actions(edev, &f->rule->action, extack);
 	if (rc)
 		goto unlock;
 
-- 
2.43.0


