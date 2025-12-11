Return-Path: <netdev+bounces-244428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CBCCB70FF
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 20:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 961893066D9E
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 19:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4637531B10F;
	Thu, 11 Dec 2025 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+hYO01Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738192C0F6C
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765482535; cv=none; b=uOvFQU8vFuTVyC2zralBrvGN7+47uKz2Amr4UN5eUL4KmW8RNZnzx75jvvl7Vl+UpGiPI4tk1iuJc7pquiDktvH7jd7VV0heI5kdhtHsFOMB0boLgJJDviF4aQg8uhU+0L3LeO7gUjzMK5t4lAEY1+rs3c53X+4AQg/H08GOCEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765482535; c=relaxed/simple;
	bh=DoqhSy9A6Eif/I+lbPb30hBiG6tUkk1i1fAfzBW499E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WI9nT7QQwkunwG8Z8pt4XB2CPD5ay4zHlMdF9qfIsAVHfqrlWtFJx0Xqan0A6mRWnkZXtViheSRH69m2jI7Y1k0rO9QM7smKTujhgNnxQToEujkUt2ephWERU+1JZMo4+bAU/gwYOwYF4rTjXNO30GhvKfxY9O9RxZM0iIgFtWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+hYO01Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765482530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jv6m2YMgKN7T4jwsVlPhMquuzv61VeZD4CVTT9gh09M=;
	b=A+hYO01ZV/EYm7HHwHJRoTtUJiJJtD/w1mr2vVjUq3SpQA/lGmLiBtn2ijpb9fhdWIet9H
	v7mO8wzF6FbJosZkIWuqtZMXz3nRQ43+uVXeNU7pu6rFU1W01xqA/cfxU1LbaB4jv/o4cZ
	A6TRMw6zOlzGdgB0OPAdKre3wGfI25s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-waC6Rb6FMYa-kLKHaMNgfA-1; Thu,
 11 Dec 2025 14:48:47 -0500
X-MC-Unique: waC6Rb6FMYa-kLKHaMNgfA-1
X-Mimecast-MFC-AGG-ID: waC6Rb6FMYa-kLKHaMNgfA_1765482523
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8670B195FCF7;
	Thu, 11 Dec 2025 19:48:43 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D11691956056;
	Thu, 11 Dec 2025 19:48:34 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH RFC net-next 04/13] dpll: zl3073x: register pins with fwnode handle
Date: Thu, 11 Dec 2025 20:47:47 +0100
Message-ID: <20251211194756.234043-5-ivecera@redhat.com>
In-Reply-To: <20251211194756.234043-1-ivecera@redhat.com>
References: <20251211194756.234043-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Pass the firmware node handle to dpll_pin_get() when registering pins
in the zl3073x driver.

This allows the DPLL core to associate the created pin object with its
corresponding firmware node. Consequently, this enables consumer
drivers (such as network drivers) to locate and request this specific
pin using the fwnode_dpll_pin_find() helper.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index cf2ad3031e5d7..198cc2b703e96 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/netlink.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sprintf.h>
 
@@ -1368,7 +1369,7 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 
 	/* Create or get existing DPLL pin */
 	pin->dpll_pin = dpll_pin_get(zldpll->dev->clock_id, index, THIS_MODULE,
-				     &props->dpll_props, NULL);
+				     &props->dpll_props, props->fwnode);
 	if (IS_ERR(pin->dpll_pin)) {
 		rc = PTR_ERR(pin->dpll_pin);
 		goto err_pin_get;
-- 
2.51.2


