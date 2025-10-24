Return-Path: <netdev+bounces-232364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 249A5C049FF
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D919F35762E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD62BD5A4;
	Fri, 24 Oct 2025 07:08:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5F29B8DC;
	Fri, 24 Oct 2025 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289713; cv=none; b=maGErbpWbvePqg9mQB4gb/fuV6L2HV/iv5hOQ/3xotuDf+P6SopCjkQPgDetTNdv2DtYxBJz31sBZTTAarHv2/7bIJxX2AHV8iRDMqhU3rKhmGGLK+XUkKmB7SUXGouyfSHJNpxnbNtjiyrOwLAQzuGoxxQiCZO2VWqDxj3pV7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289713; c=relaxed/simple;
	bh=AVxqyo/AGZnVUe+KWsDWlR+1z/NFiV2fHZIKzJvqmRw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jlwZJsK+Gec9jv3aKTPxChifdNyOZQsIK81cG24mDaMK1mlrv0yYPWxLq/52Xul7x4lADsIGB7rDnxy08C/zjFMI6F1AOgL2Qx3zV0aSM5A6F+JJ8pV3lBmIh1dWqIyDqX4fqZcx7YT8mlHO+4VX3llTFScMqi4pFhtC9uoAC5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201618.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202510241508230709;
        Fri, 24 Oct 2025 15:08:23 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 Jtjnmail201618.home.langchao.com (10.100.2.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 24 Oct 2025 15:08:22 +0800
Received: from inspur.com (10.100.2.108) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 24 Oct 2025 15:08:22 +0800
Received: from localhost.localdomain.com (unknown [10.94.15.147])
	by app4 (Coremail) with SMTP id bAJkCsDwRLXlJftorCEPAA--.2809S4;
	Fri, 24 Oct 2025 15:08:22 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <cooldavid@cooldavid.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH for-next 0/1] net: jme: migrate to dma_map_phys instead of map_page
Date: Fri, 24 Oct 2025 15:07:33 +0800
Message-ID: <20251024070734.34353-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: bAJkCsDwRLXlJftorCEPAA--.2809S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY27AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aV
	CY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF
	04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?WojDjJRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KbdyrEhBQzWMICIwpeXDts+U1EucKgep+S9hdGwWjq7V15qsZVlQpxqrjDVDjDJSzk1w
	jD0rBmlD3CKXonxbhKI=
Content-Type: text/plain
tUid: 2025102415082398178519985c1340057c0c0535e4b36e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

There is no functional change.

After introduction of dma_map_phys(), there is no need to convert
    from physical address to struct page in order to map page. So let's
    use it directly

Chu Guangqing (1):
  net: jme: migrate to dma_map_phys instead of map_page

 drivers/net/ethernet/jme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.7


