Return-Path: <netdev+bounces-93246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5035F8BAB6A
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B31EB20D05
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 11:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA7614F9DC;
	Fri,  3 May 2024 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYVi8YDL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0EA848A
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734728; cv=none; b=C+kwhzWXVXRbQ2MOFDiKo7+GdH2gCOYL+0UXEdF3/AGG7i5mZaIANxjGsrI4R5xxWLHmuQXjX7xJkZhzZaPWT+7WTrMfegJ+Bv8wE0Qp0qe4SI1lCrV5BjgQLKpYp9J0cxvIB0hWeLUyqZUAPwN868DTlbwI8IILccIF9asOfGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734728; c=relaxed/simple;
	bh=xPKJkZgoWqClfEEc7gqpgr9JGMhSdcFuVt0dZ1KVjnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YTS5UXLLPgCL6dSfCk7JvsEQO6Icw/UEfqdE/R1K/zlwqLTVDTkrzVXZtl8Y7VspAbXD9z4jtkT+AXY2mdWH83ge5fRWR/OvVUmD6i0g9GAVcRqMekEaYK7jQtuKFfFy46dWMeSWs2D/RO2x/qHFgsGa8UMh6DaDIJrciy+gxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYVi8YDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DE6C116B1;
	Fri,  3 May 2024 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714734728;
	bh=xPKJkZgoWqClfEEc7gqpgr9JGMhSdcFuVt0dZ1KVjnI=;
	h=From:Date:Subject:To:Cc:From;
	b=DYVi8YDLkfk7pR6rR83c88FsrGNJQOPhP82dyvp29WqbVcwkLEc7lQZcXCds4PuOk
	 QJi2a3yMsmb3fsiArJkmYgJZ4CH4+jGu2yQmjuk2M60EvGrLfHOhdzZnR8WTs0xtIc
	 XEAhDxLJsJXxQ9/3igCRQv4vObQdA3tCezukYRfBXfQuYkaCgaDHSlYGfeMe1J41tO
	 hw6DjoNUvTdDsu68NJg96DXHUEYcy7Dv/ZkJIxI17Y2p/nGiQE6nAqpwvg8gy7FQ2s
	 +k505pxGfNiKHs1bFxOlKEVmohaXGBXyaQwGKsmTDDqTsJeMMoK+GNZ8q0X93H2kxb
	 KWvz9IiNM6yBg==
From: Simon Horman <horms@kernel.org>
Date: Fri, 03 May 2024 12:11:58 +0100
Subject: [PATCH net-next v2] octeontx2-pf: Treat truncation of IRQ name as
 an error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-octeon2-pf-irq_name-truncation-v2-1-91099177b942@kernel.org>
X-B4-Tracking: v=1; b=H4sIAH3GNGYC/42NUQrCMBBEryL77UoSW0S/vIcUSdNNG9RN3cRSK
 b27oSfwc3gz8xZIJIESXHYLCE0hhcglmP0O3GC5JwxdyWCUqVStNEaXKbLB0WOQ953tizDLh53
 NZYqmrbx1Wh1LGcrJKOTDvAluwJSRac7QFDKElKN8N/OkN/6vZNKosfZtd/Lnti2q64OE6XmI0
 kOzrusPTuQRyNcAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Hariprasad Kelam <hkelam@marvell.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.12.3

According to GCC, the constriction of irq_name in otx2_open()
may, theoretically, be truncated.

This patch takes the approach of treating such a situation as an error
which it detects by making use of the return value of snprintf, which is
the total number of bytes, excluding the trailing '\0', that would have
been written.

Based on the approach taken to a similar problem in
commit 54b909436ede ("rtc: fix snprintf() checking in is_rtc_hctosys()")

Flagged by gcc-13 W=1 builds as:

.../otx2_pf.c:1933:58: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
 1933 |                 snprintf(irq_name, NAME_SIZE, "%s-rxtx-%d", pf->netdev->name,
      |                                                          ^
.../otx2_pf.c:1933:17: note: 'snprintf' output between 8 and 33 bytes into a destination of size 32
 1933 |                 snprintf(irq_name, NAME_SIZE, "%s-rxtx-%d", pf->netdev->name,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1934 |                          qidx);
      |                          ~~~~~

Compile tested only.

Tested-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Simon Horman <horms@kernel.org>
---
Changes in v2:
- Update patch description to correctly describe return value of
  snprintf as excluding, rather than including, the trailing '\0'.
  Thanks to Andrew Lunn
- Collected tags from Geetha sowjanya and Andrew Lunn. Thanks!
- Link to v1: https://lore.kernel.org/r/20240501-octeon2-pf-irq_name-truncation-v1-1-5fbd7f9bb305@kernel.org
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 6a44dacff508..14bccff0ee5c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1886,9 +1886,17 @@ int otx2_open(struct net_device *netdev)
 	vec = pf->hw.nix_msixoff + NIX_LF_CINT_VEC_START;
 	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
 		irq_name = &pf->hw.irq_name[vec * NAME_SIZE];
+		int name_len;
 
-		snprintf(irq_name, NAME_SIZE, "%s-rxtx-%d", pf->netdev->name,
-			 qidx);
+		name_len = snprintf(irq_name, NAME_SIZE, "%s-rxtx-%d",
+				    pf->netdev->name, qidx);
+		if (name_len >= NAME_SIZE) {
+			dev_err(pf->dev,
+				"RVUPF%d: IRQ registration failed for CQ%d, irq name is too long\n",
+				rvu_get_pf(pf->pcifunc), qidx);
+			err = -EINVAL;
+			goto err_free_cints;
+		}
 
 		err = request_irq(pci_irq_vector(pf->pdev, vec),
 				  otx2_cq_intr_handler, 0, irq_name,


