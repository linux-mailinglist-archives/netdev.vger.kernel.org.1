Return-Path: <netdev+bounces-179836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F00A7EB19
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704AA16FA50
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC6726A0CB;
	Mon,  7 Apr 2025 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thAmL8VY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB94255221;
	Mon,  7 Apr 2025 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049732; cv=none; b=HOpXiKTR6FxcSVGMc8ZElApJ5LmXP1N0cULhC5m2L8ZfXVnVuSjBflk0eNYs/eIck1gzuS6MaAXdhmgmPbbp4TMbpWCF1JLgIiKec69/onEx2Z834k7GuHGkxhHrfKhqW6AkLYodjIbOnYxUA7e65RlJ/uOuwONtXKXDFspWebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049732; c=relaxed/simple;
	bh=9lnZvdYWucsD43LgxrIBgPkhCQuCm3u66wDOkTVnmIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lBQxHWDvTAp7khoRc/af/285VVAxExb3npCMvsO1b/ZUN+Fp3YBygOVfdPM/nRrIDkQa5pMSmOEj3WYzuaT+u0JRHWvbNIRPRD5OTApSQXGPm9/1D9tsFSgv8LdWiiS/bH3+rAG2pQehP9S4+yx4a0qlB23oAQvcZ9/gMS+2qvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thAmL8VY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67B0C4CEEA;
	Mon,  7 Apr 2025 18:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049732;
	bh=9lnZvdYWucsD43LgxrIBgPkhCQuCm3u66wDOkTVnmIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thAmL8VY6DYY8a3gSfFzvB4C7s8tzb1EZ8zpMLNfNFsoW4tTdaGwP7THjwWtVKzfd
	 DmdabyBEfi1gHz8VYgvkPgpGWRJ77cDqskzcLGstl9hzTHV8vykSX2kzUmnD+KEZke
	 dBuxjWdeVluOLkWK4Trm2p3wuZznFGYIqMlAmrfJBoH3kc56FwvI5IvOji6F+Rt4vM
	 pcGR7Aic+MeRvqhUAVzak1cc2W+THHhw8AtqxG0QPCiCccPeYobfhVuo9df/qbtWQU
	 UeSyXle5pH0Ulpq09a0BPVJFTnsIq0jIHcChn/lkr8JesvQAgszyN3TaoqEp65OYoo
	 F74+fCPU7UBMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chenyuan Yang <chenyuan0y@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	richardcochran@gmail.com,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 7/8] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon,  7 Apr 2025 14:15:13 -0400
Message-Id: <20250407181516.3183864-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181516.3183864-1-sashal@kernel.org>
References: <20250407181516.3183864-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

From: Chenyuan Yang <chenyuan0y@gmail.com>

[ Upstream commit 8c75f3e6a433d92084ad4e78b029ae680865420f ]

The variable d->name, returned by devm_kasprintf(), could be NULL.
A pointer check is added to prevent potential NULL pointer dereference.
This is similar to the fix in commit 3027e7b15b02
("ice: Fix some null pointer dereference issues in ice_ptp.c").

This issue is found by our static analysis tool

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Link: https://lore.kernel.org/r/20250311012705.1233829-1-chenyuan0y@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index d918e8b2af3c2..c5f7123837751 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -538,6 +538,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	d->vhub = vhub;
 	d->index = idx;
 	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
+	if (!d->name)
+		return -ENOMEM;
+
 	d->regs = vhub->regs + 0x100 + 0x10 * idx;
 
 	ast_vhub_init_ep0(vhub, &d->ep0, d);
-- 
2.39.5


