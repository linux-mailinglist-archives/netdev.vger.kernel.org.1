Return-Path: <netdev+bounces-74969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F18679DE
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5865029528D
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FF712CD86;
	Mon, 26 Feb 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="QpXUQycL"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040E12C815
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960238; cv=none; b=mS2FyvlwF1ngyUGAQ2wxbHwV3mBa1dnsW3cjPGro/ZFrtujV407D080+kreCQNrUjbQLG6zXrZNy+6pH91AGAnAWGccGn+OcfIxWz9Vdr3H22+N977TYsV950YsjIMBZd2iR2mrKxdcMtW9eeUuiul/DkjQDsW4HoREnlw1FbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960238; c=relaxed/simple;
	bh=/k++mZjGgkhII1OMgJiLiNh4PK+CSD9y2N9wOfsHXTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H3fjnLE3J5AVm3UCd4BM6h4c+jXEHtHP6MYXZn0tL52weJKCRWb5tz8oKHmefQn3388N9l4XNsD1z1t7Kzl3fF77DIfh3jMC6DMruXcBedICZ84fT7AGbY1+XW/qUymU0/fd+l42E8Fj5bWB51IgBhWIrtVa4YF13V/QLK3MKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=QpXUQycL; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0BD4A87F06;
	Mon, 26 Feb 2024 16:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708960228;
	bh=Zfta2dajafM86iL+IHPIFZMeyflF+LU0hHE3imfpqzo=;
	h=From:To:Cc:Subject:Date:From;
	b=QpXUQycL2AEMm9OJv6WlQSFqRYVSLrt261M8pTZQCWb0Yx4KhAEjrq3O72zsiNgMp
	 6ePauYACnjgkT2fU+CRDIPmqN76mSLb2Id97d3UW4I1cT4BPGwcIK2QT2oO51640WZ
	 VXyTO0Ts/D4JkXoraW53FdL9rzQHS2TX0N1jRq7VX+slANH+Ckdhb9bXDlIhZKlcIS
	 IooOeb1JEXsiez92zziYp5eND4XoGTy1hJXO2LkBcQQuNf2oCy2L5PAwLAzMNHgQy6
	 kU0YFp0ntAjydpYLRFPJTuhowkfhbXE77wyIr9pKo3xHb7P3M8Ma6CCJkkTcDeTFOI
	 aLTlsoatRttNw==
From: Lukasz Majewski <lukma@denx.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	netdev@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] net: hsr: Fix typo in the hsr_forward_do() function comment
Date: Mon, 26 Feb 2024 16:09:54 +0100
Message-Id: <20240226150954.3438229-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Correct type in the hsr_forward_do() comment.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 net/hsr/hsr_forward.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 80cdc6f6b34c..2afe28712a7a 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -435,7 +435,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 			continue;
 
 		/* Don't send frame over port where it has been sent before.
-		 * Also fro SAN, this shouldn't be done.
+		 * Also for SAN, this shouldn't be done.
 		 */
 		if (!frame->is_from_san &&
 		    hsr_register_frame_out(port, frame->node_src,
-- 
2.20.1


