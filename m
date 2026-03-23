Return-Path: <netdev+bounces-270341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CZ0EsqdwGnrJAQAu9opvQ
	(envelope-from <netdev+bounces-270341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:56:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C50FB2EBB0B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 896243029ACD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8104022689C;
	Mon, 23 Mar 2026 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTWnSGf7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C460822425B
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230884; cv=none; b=IvB1ra+1LEydpqDBCDwA4vrNglyo1+4qrXxdBSnD1KcU5nKDHNmjuW9eNsvQKyEkM0qBSgePmKAFH4q/d2Qe4PyIxHxBOT0O18qHDMSELJkA5mnPwScnHpKPwZtnep8193E/wTX5qIhJ9y+OEcebH4AsRXEcDMcD8NpuZRWwzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230884; c=relaxed/simple;
	bh=hPCCh7wVY1yv/Ut8yT6oomhgehBamoMfqj/l4kLk6Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pta9ucknFZFgud/vWUslpYFoH5nTU7NYC+VUGcbCTsnoAhkMyY8zjEnp7oF4A4sjVmHxSuLhBC91mWShpB46Zh2yKLOmZEEBMvRefA/+20mkEk5Yb/NPk1N+0/gUvncZCGQp2gJBDmFbiTVeuMzb8TtCSEpbpnOIwYRzlnXMGCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTWnSGf7; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c0e3a2605fso652834eec.0
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 18:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230882; x=1774835682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X8icAi5hW5PHcS4B3NheItH86dqdd76W8IY0AZdTSQ=;
        b=VTWnSGf71UerOR0ORdlnUklY8mLDZYkVyhF1hvFRsIpiSRgbnv0X58ocqWFWzR1OaM
         UEBodOHXlK+jo99NJyUP8Ot7gYnLmPeh7xijqhcoQ/Njlouu4sSIRA9frNjdwSkV5i3y
         xP93ajn9lna/yYGtj3EHYQK2e8UaqJhgKtw1ByLYOUQmILwYOY+HJTlZKf2UfL0w7lwK
         eqUC+EnI26ev4Jmehk5pI9WvWGIdjiPTX2iaCZCKgqIWm+O3tPi13cQ2fE7Rx5YPlO/H
         S8zVLChQTmaBkDKTo40imaxQajQe+ZzyKJR1R37bWBMN4aOcYCKIpqWHEkDZose861XR
         MUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230882; x=1774835682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7X8icAi5hW5PHcS4B3NheItH86dqdd76W8IY0AZdTSQ=;
        b=lDiXCCTqtH7M5U1QZqWkjleweLdiymD/3/Ab05Z9Gtkd/WQB4YPL8nfJcYF5aC6IOt
         +xHWYnrALefQE1eSkS8NYfM9rDW0IgkyZ6Q0NadOU1j3znF9hoz9xRbx+IzFQ4/lEAt6
         s2zRqJ5H2wl/mPiAyFeAYL9y+/lcYrIiJeEU5yTFTEK7JU01SC+qoUC1JF1Dh5oAmlVH
         yVpYPlJGWUVaJNLtCyj9eIsxB22m628Wld0Eudb4BJVG1gw6rJLt4H5uag7zR6gjdEOB
         UL8KFV3vsv0q699Y41XAxmMNNkJLP/N77r5xgNLO78L2ulZAg+V/gnORb/EInX9XS/Yy
         4CUw==
X-Gm-Message-State: AOJu0YxcI7aOvzaxfP1GNOdv7+NjFtSFHDe6qPOlP5jCPI33Ea931K7x
	lgJPIPJRhAHJ4I+lvcAibSm3tvdOBkrdcyhe//hz10MWUZmIXgjTGDcL
X-Gm-Gg: ATEYQzwgkpWfCObcpif1ZELJbcKX3g9wC2Y3gWoHAlfMk4sqvRGcBM5vGlkpBVAn94P
	K7/NSMPWTeDhUbX/Jnq9AaAhnQeq6oiT7WlBnmMb3CT+Tq41pvQaXgGrdOdD7B7XbZgLUzQPDbH
	pZP50xb9rFaHmmuzai7Z+a85KYd//MtzO9aIPT2sZw38YVcIhMLFnTp7x/YwBOxSSNxLzgivMiv
	eOWQRgA+TTvESkCYJZ6qkR/dvG8TJsa3Y8vjoz4opyFlIXPdHJATSM5MBcCtAtGLHngvzp3Q/Ux
	f6a9C7SbN3+LyAbSrJsFoS3eMqckjHrON8HYvJ4E71s5y4wkMQ3QOEYDscU74KC1VI9FfgqAote
	APLNG4cAdQH9GpQCPHPKzm6UGgKzKZhSn3Extb/lMJVeo+WvE+v8mNHgX8SQbDxFEa9j96U1oRg
	97gSKpF+TmgHry0tkPkVRYJbKtuXt0qzKYRWNELdn5J8ltHO3uCmGPqwoqxsilBOoNf/w0odfEF
	BARZgMEWThvel8=
X-Received: by 2002:a05:7300:e7ac:b0:2be:9d3:c8c5 with SMTP id 5a478bee46e88-2c109816b87mr4889998eec.34.1774230881836;
        Sun, 22 Mar 2026 18:54:41 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:41 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH 02/10] phy: core: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:20 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-2-b72eb22a1215@gmail.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
In-Reply-To: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6826
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270341-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,gmail.com,axentia.se,armlinux.org.uk,intel.com,linuxfoundation.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C50FB2EBB0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation to class_find_device_by_of_node() going away switch to
using class_find_device_by_fwnode().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/phy/phy-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 21aaf2f76e53..57bce6b63a31 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -761,7 +761,8 @@ struct phy *of_phy_simple_xlate(struct device *dev,
 {
 	struct device *target_dev;
 
-	target_dev = class_find_device_by_of_node(&phy_class, args->np);
+	target_dev = class_find_device_by_fwnode(&phy_class,
+						 of_fwnode_handle(args->np));
 	if (!target_dev)
 		return ERR_PTR(-ENODEV);
 

-- 
2.53.0.959.g497ff81fa9-goog


