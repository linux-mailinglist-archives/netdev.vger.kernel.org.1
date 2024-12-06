Return-Path: <netdev+bounces-149805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1B39E78D4
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8CD281244
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5865C1FFC4F;
	Fri,  6 Dec 2024 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="DqNtanWt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCC12206AC
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512909; cv=none; b=hYeas04/5NmUH6gyRstvIUgZVT6La68NO12Luk4lYOHrmCvYt+vtfPcqFxGrrqfGP7O93mbv+ENXkXCa35fB7gYMDkqfIespVeMHMRs9SFL4u59aB17J9xKhqwHfrH9OA/Km+cpxuJQSM0ckFk26D0VdHgstAwhJ/HM9mFXKzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512909; c=relaxed/simple;
	bh=0GFGArkZIeu9YFzFvIo10D81sChF5r/4lriL8Wgz9mM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lxbCWMdcefwzPxlXhOB2/YHEJIVz9EupNcjrJTbjAS+2/mRBqvxvVFfqovMQAxpvZuMfvddMzdNS9Z4I/IeWSGXbbamOPrah3whYYHUy3R47I+MDH9ZIBYULhTyDyYLrjKc1KMun9SU0y3ljnZ2FXrTB1DBCUn0Lz9X1ufrgVwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=DqNtanWt; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3003d7ca01cso3154351fa.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733512906; x=1734117706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=alKzgZIWJBJQIC3RtpQ5nlO/OOrtZ6jVpTyw98aDLPE=;
        b=DqNtanWtwkaJW+jNdggEKnNE0Y/rILIyu6YBbEz/XJZalfM78u5z1asQT3VBkCoZON
         n9phqGQLt0Tx/lkDxt3Y1Yl26xbvn9Ca3NoTbcKinHuY63Guu4qVb1IArEAa05N6qx9t
         sSnh0WuxC9OCh4psgjvPGbyoqar0LTW84+wlaZgMm4fEGDx+XhVSPxUJaYSR94TKnCF5
         ESGy4hL3/SUkKEeX8sWrounWjgPabMABp5eVVNNvJ93xBeI6XUDZQUQrxfiH/6VtFxby
         koJ5UhAhVhD5Bzbgq0muHfbYxNzdkCeJl/CWTYuUllBilSYnogGwXty0pkX/b2JDjM0H
         Dnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512906; x=1734117706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alKzgZIWJBJQIC3RtpQ5nlO/OOrtZ6jVpTyw98aDLPE=;
        b=DlqoBHpYUKKZ6Dm2Sg9ueCPfM/fvUbon2i5hoN0UP7bpbGt0ypViFcD4x676dmsv//
         53ns9Yy1QLcXRY8VP8RcRqgHBFNbPA3gKlTif/D6uPQyRgG88FAET6C0/LBUlChtLYsq
         FKMLMYlkZKTKR3yogzMz1pKPuCdBXjJZexDOyOUbk7V0Fjp5UyPltBxju1TVuCNS7jcC
         u8R2CdeCenUXvkSYdkRtugkXVWSv6SH9oAzROrBZvIsp3DQSwTXsPk7519HIpcEdoTUA
         LRpJczG+pewTh6TF0SjLN0n4JOC3HW0XDtfu2M3iLGVqpQXN1vJurFhV3VUGqxrdau92
         0iCA==
X-Gm-Message-State: AOJu0YxHYY58iPrK9OFXO27uA8diKTOfSTbnvFG4831xxV1cAPBCGOvv
	JAtMQQieMFlxzzv/I0tKKh1D4tDd5MKfgJ9ppSsb8JZfLFSx85b2DFP8z1UIcS0=
X-Gm-Gg: ASbGncszr0dpktRK9t2z5FedM6MjAo4TgJ0lPetJr+wNGOqtpoFsSLTd5uG0b34otkD
	/gWYv3Pd/7tiUO17gZw5pe/jm4MbtMGks/Pz/XiS+3O8kpWzLJfg80QVy5uyFTRvWJ/+qnuFi+P
	4QWTJc4FKSVh9HWUctzxmA7MGM9wNSJ4UUcVJDEjacZywa4ss6DpvWOSJefQEX7jkrU3Rlch18W
	11Na9Sy4Qrk2y4c1FSrY4zH3EgcKwC7SkAVMrqtVNCshJ7Hxi5D3qlB/9IYjkb0
X-Google-Smtp-Source: AGHT+IGXrMN3PorF3VW/yScaTvpLE0Z6C7mKmkFF9Kzew6G834zYw9FfFy4W2LNLgP2XaPcVO5ogvA==
X-Received: by 2002:a05:6512:2316:b0:53d:dd02:7cc5 with SMTP id 2adb3069b0e04-53e2c2b12b9mr1148864e87.7.1733512905680;
        Fri, 06 Dec 2024 11:21:45 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e22974f20sm590041e87.70.2024.12.06.11.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:21:45 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next 1/2] net: renesas: rswitch: do not deinit disabled ports
Date: Sat,  7 Dec 2024 00:21:39 +0500
Message-Id: <20241206192140.1714-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rswitch_ether_port_init_all(), only enabled ports are initialized.
Then, rswitch_ether_port_deinit_all() shall also only deinitialize
enabled ports.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 3b57abada200..cba80ccc3ce2 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1527,7 +1527,7 @@ static void rswitch_ether_port_deinit_all(struct rswitch_private *priv)
 {
 	unsigned int i;
 
-	for (i = 0; i < RSWITCH_NUM_PORTS; i++) {
+	rswitch_for_each_enabled_port(priv, i) {
 		phy_exit(priv->rdev[i]->serdes);
 		rswitch_ether_port_deinit_one(priv->rdev[i]);
 	}
-- 
2.39.5


