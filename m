Return-Path: <netdev+bounces-119181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ACB954849
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62082838F9
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95181A01BF;
	Fri, 16 Aug 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="S6/yC55a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2CD1AED5A
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809084; cv=none; b=Ev/AkYd3/0rwJOul9fSktJPE37yU7Pv8363urjT0LEBpmt5g0QrGcQMGycYskVVvhWsmJlaVj9hODqFJSXXQmzE4Uh3ObpBq8xxXU3M/EjG1rt+LUC47ioE7vcf7HlkyBcAtNckCHHYRUXr17wox0z2BiZUiKLhR3rMSXKosBz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809084; c=relaxed/simple;
	bh=LL2022vgq8zz9q62sp2CaDsGevnAVzpMLQ2w63/beKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BytIdQpoJZMeRGrKCjx64x6KIj/zKFhRcsrFQvYozrrsZr95uUwiLWbPzmFHDoDRZKs2JwrEZDfoBZ41kHxYbXhDTumpNomwjraaQ8pCKYnJdW61e1n73H3dFP1eEFupdSs8eqkeXogxPhZvpoYsrsebehJI1KQ/AHqVj3jUUjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=S6/yC55a; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b3so250020a12.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 04:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1723809081; x=1724413881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lK754GCTcj/koNjNrd8Tfk7S3dTbfT2VufTJv13Pygs=;
        b=S6/yC55apwnQKs6w5wp3GF0VThifFCrTwZvI825vsG4ZJZn/TIVzUWSlqQT078FX3Z
         k69koYnNr8laoC8Mbfuyzq/8e62sSnVGU4PUFm7LdAN1mRsclE4h4ClvQ0NiwkAkJi7/
         f/LtCuAi8jYz6qI3v1OvZoOidt2sIKKq9LYCNe9YMndBD7aFAmpR4nilh2PTICXMCSaM
         Dc+jnnsZ+s9UbzFjgY799+NkHajuWs/doujLxylJeOtLfFPq3bRsGyyHH4zb71yDzuIq
         CHA0S419C9VNBQih8zMXLJf4Kr1ew8TSkSxJ3iTHCVhMdxGZKWPmEGW8pYWOov/vHx82
         zXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723809081; x=1724413881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lK754GCTcj/koNjNrd8Tfk7S3dTbfT2VufTJv13Pygs=;
        b=CobA+07wWEAuK4SPBu4L+K3F/xbEGUKF6UfkpOTKHFAGnL7mmcshR18/xHHIRVsiHN
         rINmlSNCgLMOtTWakskqW9C3DkdQN0SxXfKOqhMbEw5NO0yMGXh8MMThT66/CqlCnc7G
         xVjThLC4+dTchRGkfaIzqPwIMXEJZpGL2z0sidD6Soai4E/1HM77A8DmogI2YQtXJMDt
         MSeXqIW9TUPcLaUw6XEAAiFxxvHbRn3FIc6OK1hGd5DGhKRFlOOmGzRrrvajX9n5kVrt
         FjkaRPSkPjJqrapzjI/zogOGk95Pm7/lxRZqwAm097w5kYs7VqgDZpRmB9zWMh/W+hUg
         wvFQ==
X-Gm-Message-State: AOJu0Yw2wfxvKDZbxaIszyahK/aTRoWW2dHDjiR0UR6+05Tmf4xsRR52
	7vFuwMTpqwoPCczTIR9ttnQ4w7U7MshlqA77yI8qgtWDF75oUi0Hjv/KMaba7T6loJ7ZO903pob
	R
X-Google-Smtp-Source: AGHT+IE3WO9LgSh9AVJo38ExBTocHOMo0UOuOeTPMsHqUjUGNVkSLcGRsE3o5YqFexfZlPJIdwTEew==
X-Received: by 2002:a05:6402:1d50:b0:5bb:8e11:6bf with SMTP id 4fb4d7f45d1cf-5beca8c8e88mr1921782a12.38.1723809080655;
        Fri, 16 Aug 2024 04:51:20 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde7cd4sm2152845a12.39.2024.08.16.04.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 04:51:19 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net,
	jv@jvosburgh.net,
	andy@greyhouse.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jarod@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 4/4] bonding: fix xfrm state handling when clearing active slave
Date: Fri, 16 Aug 2024 14:48:13 +0300
Message-ID: <20240816114813.326645-5-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240816114813.326645-1-razor@blackwall.org>
References: <20240816114813.326645-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the active slave is cleared manually the xfrm state is not flushed.
This leads to xfrm add/del imbalance and adding the same state multiple
times. For example when the device cannot handle anymore states we get:
 [ 1169.884811] bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
because it's filled with the same state after multiple active slave
clearings. This change also has a few nice side effects: user-space
gets a notification for the change, the old device gets its mac address
and promisc/mcast adjusted properly.

Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Please review this one more carefully. I plan to add a selftest with
netdevsim for this as well.

 drivers/net/bonding/bond_options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index bc80fb6397dc..95d59a18c022 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -936,7 +936,7 @@ static int bond_option_active_slave_set(struct bonding *bond,
 	/* check to see if we are clearing active */
 	if (!slave_dev) {
 		netdev_dbg(bond->dev, "Clearing current active slave\n");
-		RCU_INIT_POINTER(bond->curr_active_slave, NULL);
+		bond_change_active_slave(bond, NULL);
 		bond_select_active_slave(bond);
 	} else {
 		struct slave *old_active = rtnl_dereference(bond->curr_active_slave);
-- 
2.44.0


