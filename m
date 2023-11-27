Return-Path: <netdev+bounces-51298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED46A7FA028
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAB41C20DB7
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3620428DC8;
	Mon, 27 Nov 2023 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpMOW/YG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4A3D53
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 04:59:22 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so29121325e9.3
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 04:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089961; x=1701694761; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRj3ngvYtPvtc5FEEk7h4ztZGX7+EQPAdDUCG9vRzv4=;
        b=LpMOW/YG2v0DljirQFL9XPD8hAAkDfl4swmY11JCDro4b+EESzXcQLEjHbdLIVQWUW
         YYmrLWmw5B31zLAPT8SeBf7t0qpKdfBarSoJkCjiL/cDR5GDt/wNuQeSE+02TQmv87MT
         cT07S2LGBTxcANBewq9T15oGbkKHvNDtdBkyJCytHcHAAHHTa3yJgs53xPdzXo6SbbEb
         0EB049zBZbfF3/cfTwC1V5e9qdhCzOycRK/ar8ooCIdnBmSf2rIDasYtPlGdKAYx+MeY
         VbDAW2GzYzyuq2cChuLKaKfAVzxwvH+XrRvAoDP1lLH+sdZvBvhN7nJEBqh8h7lxB+5H
         /n7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089961; x=1701694761;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRj3ngvYtPvtc5FEEk7h4ztZGX7+EQPAdDUCG9vRzv4=;
        b=fShxwYgJCa9vCGTE2u2DXyk0N0tyzebpGtmyDGr+FX7mAzGK/UHnbyscHxLt5xsXIb
         GakKOaAzP3Du5nTyJlk3s76gAY98jOQGiKS1VxSgP9JvFBUzb3zFFAkxg12qVWz1BO84
         Av4PggsGQ60yV+jwy9SLjqBJ9nZaHzrCJjihqek2TBRnXZ1k6jo2uP7fw11muBzbcypw
         jFeewlokLf2T3GSCM5L+SyF0uCjqcuort9F2H2x2Youp3tOtS4E+DqEq+RHpt/dJynQb
         Pg20wvPiN9WLxVRznmu1JO1dNgMsk2+T+Ydvmk+wSgXDAmttH8yn8Oou00xqt4Pp7YLX
         bh9Q==
X-Gm-Message-State: AOJu0YwMqvR2vrxzNL9H0H6AOXM9IvU4WMAymMm2nJQUNqOI/yaNDghg
	RVvjW4jYArLuFWa9nki52qyGVw==
X-Google-Smtp-Source: AGHT+IHJtodRZ08aYWurZAtbiXoTBbYnCPB2mvDlNqTf9TMmij8nAPXOfQYZ2vPvAtAt7uU8pnTz1Q==
X-Received: by 2002:a5d:5234:0:b0:332:f61a:631c with SMTP id i20-20020a5d5234000000b00332f61a631cmr3952666wra.24.1701089961198;
        Mon, 27 Nov 2023 04:59:21 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d5443000000b003140f47224csm11960469wrv.15.2023.11.27.04.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:59:20 -0800 (PST)
Date: Mon, 27 Nov 2023 15:59:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] ice: fix error code in ice_eswitch_attach()
Message-ID: <e0349ee5-76e6-4ff4-812f-4aa0d3f76ae7@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Set the "err" variable on this error path.

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 3f80e2081e5d..ca118bc37e44 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -669,8 +669,10 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 	ice_eswitch_stop_reprs(pf);
 
 	repr = ice_repr_add_vf(vf);
-	if (IS_ERR(repr))
+	if (IS_ERR(repr)) {
+		err = PTR_ERR(repr);
 		goto err_create_repr;
+	}
 
 	err = ice_eswitch_setup_repr(pf, repr);
 	if (err)
-- 
2.42.0


