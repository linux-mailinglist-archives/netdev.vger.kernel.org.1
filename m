Return-Path: <netdev+bounces-103363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0D0907BB1
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5684AB23DD2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E4414BFBF;
	Thu, 13 Jun 2024 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1Tf6Tpz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300CA130AC8
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304243; cv=none; b=jnhKEaCPMCXWDPXpHv+wg/QANLgJOLKf0NloAeiUX7oWJNzjENcoMzJTLFkInkjMUBWKo+PZkbLK2vgPMFxN+o8o9/zJ0rTh1BW7lPtM6P9sMBxz33ubBnP3WBt/mc+QpvFZxk0oxwh3eM0wxz1HX8K0XVs4KG1t+3FhTZCVqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304243; c=relaxed/simple;
	bh=rVZKNmYsCg7Cv0JF3bOovcM69egkCp/oEwpFfMlMSH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnvrC8eZU5+TYmImgEy8WhwBTS/Rr4VyOHTqG4ZQXc3WavWI7zw1+i7xpXqL0xCSST6MoGuoH0+AQnbSYIqCWqLjarUVfgdMEyYDHrKJFei4eqBD1j1GVmVp0uo9F2iD+SPcj0cZavMajvQqxZuaqBDWOv1Y68oywcTUecQSMqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1Tf6Tpz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718304237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6gKuRAroxdFSIn4AAkyBRetf77gKe9BhwcyD4tozv8=;
	b=I1Tf6TpzDzhZrwYrTRCL1kH8BB1HI0D3yWrV5c7hTahfqHq4hCPTbek7Em71yOk1SOhgPF
	64qIAA5XoYercsFPwDufQpU1agx8Fz/rSP/B7BcTKLIRNFsU9gVwxIIyYaF7+O/3wcjXCR
	4JZ+OO4taimatVYcgniDZND2+HcBrqU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-jUcLgAXmN1aDiXt58ssdtg-1; Thu,
 13 Jun 2024 14:43:53 -0400
X-MC-Unique: jUcLgAXmN1aDiXt58ssdtg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F43119560AF;
	Thu, 13 Jun 2024 18:43:52 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.17.127])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5D671955E87;
	Thu, 13 Jun 2024 18:43:50 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next 1/3] net/mlx4_en: Use ethtool_puts to fill priv flags strings
Date: Thu, 13 Jun 2024 14:43:31 -0400
Message-ID: <20240613184333.1126275-2-kheib@redhat.com>
In-Reply-To: <20240613184333.1126275-1-kheib@redhat.com>
References: <20240613184333.1126275-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Use the ethtool_puts helper to print the priv flags strings into the
ethtool strings interface.

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 619e1c3ef7f9..50a4a017a3f4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -536,8 +536,7 @@ static void mlx4_en_get_strings(struct net_device *dev,
 		break;
 	case ETH_SS_PRIV_FLAGS:
 		for (i = 0; i < ARRAY_SIZE(mlx4_en_priv_flags); i++)
-			strcpy(data + i * ETH_GSTRING_LEN,
-			       mlx4_en_priv_flags[i]);
+			ethtool_puts(&data, mlx4_en_priv_flags[i]);
 		break;
 
 	}
-- 
2.45.2


