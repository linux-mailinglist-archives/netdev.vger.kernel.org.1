Return-Path: <netdev+bounces-200130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CF2AE343B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77B93AFEF6
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 04:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872831A08CA;
	Mon, 23 Jun 2025 04:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NYuTWVaq"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D7BA2E;
	Mon, 23 Jun 2025 04:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750652007; cv=none; b=A6P4FoHE8FSCvhPX71kafW8AHsKTRH58VlaRUBOoNerbaCuXgNeEsYgXJQ5KmHsCcmBgkEnJAYQUhnXjpLZcMXSWfBFoRKeVj68shx7hn6dyg2/jeO5XHy800hw43hzqpDMatGP66Va4eONfpSDL1wnNV6nQldiJEwBVYxAMTss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750652007; c=relaxed/simple;
	bh=asAdWluI+9/Xq+X3ViF+ZtTGeB4Vo9zmeR6SHi8r6kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qw2X3Vm6QT686rFaqQ9yWEwMnt8IJ9Te1ZAD6FvifksuI3HP2R/gkxrhVvLEoWkYiUwwMJgTe6BUoYPjmIunrIFc0vOFq80CnlqOVdGtt9RJtSzr6wtAqHx5jNBo1y132wbeA4wSD7UzPiA+mOTVfdtBDddLtcNS1Vhka0jQzOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NYuTWVaq; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750651941;
	bh=ngStluLGVfnJROcHOwDlB3PqT1zDUXJMP89h5/LPc/I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NYuTWVaqi0k5SkDmTDWiiQ0fxeygrcyKrNfov40XUwCyQwoMEzSNWSuI3XRQqlgfZ
	 M5wDBLjbQ2aGb6dQ4DjqDznu3WFSD39oDNne3tOM759ZI0EyU7PVNELU5B9YfIYuN2
	 HRYFZy77NpYDP+qmvnlgokzHN523S41Cj5YA6lpg=
X-QQ-mid: zesmtpip3t1750651882tdd706294
X-QQ-Originating-IP: 3yYvgAxViCJYyEMAnTNQRgF8U6fzr2ECS/j02QfCaOs=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Jun 2025 12:11:20 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5568288508028847520
EX-QQ-RecipientCnt: 15
From: WangYuli <wangyuli@uniontech.com>
To: louis.peens@corigine.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	chenlinxuan@uniontech.com,
	wangyuli@uniontech.com,
	viro@zeniv.linux.org.uk
Cc: oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	niecheng1@uniontech.com,
	Jun Zhan <zhanjun@uniontech.com>
Subject: [PATCH] nfp: nfp_alloc_bar: Fix double unlock
Date: Mon, 23 Jun 2025 12:11:04 +0800
Message-ID: <9EE5B02BB2EF6895+20250623041104.61044-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MMaQ6TzgLRQSAb1LvMNIxHKjfKInK5BZxLG2hNy6mUxj6w+CjZ3JngcW
	I4aYgJ1wL/EUX/GdmDUxTcb1/pcuw1yuYGnRAzCDn8UMcA3xQ/cxeYDRhF+AB+cMvM5MAOu
	DxEvNsij1bUNj7Mzrw72hziSG+C3A11oGgCb3N0yA1stPTZj2FylXdhDcH3agCpSl3clqtl
	52QaVvjGOZYUIYTRhJ8npPFRCuV0R3hKmsGb+LJnQfUxSub3QTOv7BnD3Lnksw3qoh++R8M
	Ci74kYWc0lO7LBY24F/wr+Hd+qJh0FHT0756sxl+ZnuGFofjDjRZ2F3nYLQ8FUhflojRrQ8
	6pdPe1EUhjn3cmaVh6agIEb+NNykzGLPMQurSB+tF5uBvsfR2zozv6Xz+667bayZq7oMh64
	uJBlw/16B53/2Cy+kr40/0UhBevPcnmjUguNDlGYxITsaAAbukWHe9lQWrxW4PzeU7OMuRw
	HlYuHgR1Yeie+EHwBvPhW6UtJBp3YhQq7w/rb+e/poputJyJGBjOfN40XyKZUJ9756sfW8E
	nz+uXSE8THBN+YBDs1MHqTsKBZ7KJBo6zeHGLC7KHhChVINUoucdzK5rpIeo67lyclApcAE
	fyDxdgqTKnoCnlUshHWtfCHuD6CFlvUTvFXhWEWS3Um0KeecxJ686HeoNKvYafpXrUmw8VT
	hoS5nmqTyxp/AJ6Rt+e/Ruzeuge7L+cI4BNgfSSfU+9cUVnwUd0I+TCP/kGw3n3kkDJ/HgG
	RddGOj0bQfcfwm3LFpbb4PHSZHT+WaVP+rQuTReD67bR2hovgDIjhMtSpQ4/Md/ebkv3gCI
	91VcwE0Xpq9SvfPPytGkyJFN1oF9udappqf6AEdJ7pNh5ajKvB+Eiss41+6WvbsvIWz5BTL
	2xLb8xXQGYr0Bc+PI4dH7OzGSbC3W3d0IGyltDWi5cqcOwko9hm9rUZQOG2aKldivai1OwT
	F/D2svS9FTA614fE/A8gmC+5JSwMUE9bvWScjKVkCZS+meEMLopl7E+TXUXN4DtOF1gCcNn
	v0ZvFkwDGiaDetZWEcugEz57sYYL9OpK9qRebxU2ekNUkvn+Ao
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

The lock management in the nfp_alloc_bar function is problematic:

 *1. The function acquires the lock at the beginning:
spin_lock_irqsave(&nfp->bar_lock, irqflags).

  2. When barnum < 0 and in non-blocking mode, the code jumps to
the err_nobar label. However, in this non-blocking path, if
barnum < 0, the code releases the lock and calls nfp_wait_for_bar.

  3. Inside nfp_wait_for_bar, find_unused_bar_and_lock is called,
which holds the lock upon success (indicated by the __release
annotation). Consequently, when nfp_wait_for_bar returns
successfully, the lock is still held.

  4. But at the err_nobar label, the code always executes
spin_unlock_irqrestore(&nfp->bar_lock, irqflags).

  5. The problem arises when nfp_wait_for_bar successfully finds a
BAR: the lock is still held, but if a subsequent reconfigure_bar
fails, the code will attempt to unlock it again at err_nobar,
leading to a double unlock.

Reported-by: Jun Zhan <zhanjun@uniontech.com>
Co-developed-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
index 7c2200b49ce4..a7057de87301 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
@@ -489,6 +489,7 @@ nfp_alloc_bar(struct nfp6000_pcie *nfp,
 		if (retval)
 			return retval;
 		__acquire(&nfp->bar_lock);
+		spin_lock_irqsave(&nfp->bar_lock, irqflags);
 	}
 
 	nfp_bar_get(nfp, &nfp->bar[barnum]);
-- 
2.50.0


