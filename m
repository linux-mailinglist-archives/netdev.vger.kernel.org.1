Return-Path: <netdev+bounces-110221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B072392B5EB
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0F61C22173
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A3F157480;
	Tue,  9 Jul 2024 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEej11Kv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA4155329;
	Tue,  9 Jul 2024 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720522347; cv=none; b=CLeN6eI93M0OZLaUmEIhqBaHmWiKD3WXxJiO1NtMUxlu3pI0q0KitgTpS0bZu8A78wQ7CYVtYc0ynOKvy8tcZaFz+o7hE0e/dHZoXGr8Gd9kPIS55Wvgd+g92oZq67+zAbXoLa7JoQGykJnx4tlF4ITADF+LL/8b/9CLE7rddsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720522347; c=relaxed/simple;
	bh=vQYiMZyY4wCIinORfN1CaFqtYJUd5P93b1oJl47srJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pMfC/O6uR0VEfLMIDMeWc3yZToTd+jX0I7ehXAMZMFCQWKE1BhISpPBKGf6iKm33yez3Wx8vXnD050d+Ph29c6EthXw8J1OsnMKqTD2vQA8QtEGxmevt30P1g0b5c9cw2KQpvJWwkaf3i+LmCdNj/r/rEaQxIuwnSNKQYQk8BVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEej11Kv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367b8a60b60so1959392f8f.2;
        Tue, 09 Jul 2024 03:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720522344; x=1721127144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7mRrmwMm1DmJw1xSNDgxQWCnqRc/CmvO9uv+arr7hQ0=;
        b=hEej11KvDNh3gNeehY36vuFOchXMpovKQjVkXI277qnLfCVmqL4/0VmdElMRbRzrPD
         JwwiU8HJOmpuihvE5DcczUItR/eoWzYt3uMAMFkCyMr/JK1fLE3WQAtp82iqCi8WyGEl
         jUy4wV6As/e6lBn+GyquYl6XQkMXl0KJ4gf5RpGEPLBYp/P3b4MB8y5xmGLyFBr0Nolh
         1Li12Q0GyaimMrx/W8JQBXx28wwMIdpevYXkDCV3fZhk+I6dFTCy8T1Zl+C4Bwx4cc3+
         EPYmYXGD/FvREN5hC5jLZ4IdlOMxkrW7SST/82XeuQ2+U/sZaKRr7VNw2BZys9CzwOdb
         Ucwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720522344; x=1721127144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mRrmwMm1DmJw1xSNDgxQWCnqRc/CmvO9uv+arr7hQ0=;
        b=u0hKTyrulvM5e6HhvQFuqvroYp2itT9OaQUgRcyHxuQViunD8x91X4x5jbTHjEVCKm
         KvppEIJUyVHUXgjAahxXcF3Vx5f1Dl4aFyWw1Ahg3VuT4pRFOMdjRFgNkjDxBHUyruVg
         6LFs5Rt19wE/+veN0YeGbCZIGaE2tphpByZ8PlspceVH6jfHXA61pPXQd8CQaycMHXe3
         XtKsC4KnkiEwY9TANY8XV7439CC6qbsrZNjN1mc9c1Iyg+lDEOmW7eGA/J9H8Uk9ujoz
         5na8/P/yiSmCYqhoKd90oVaZ7wMnfkf32pB7B2IS5ADGgOAREHiGAmTYQfH/ee/rm2eW
         h5+w==
X-Forwarded-Encrypted: i=1; AJvYcCVnbTNqUGP607mtGA7oY6D9jdF4WcfAnfWf0xF7LP4ymF5H76tnM+v7IrnMXVfnIFnRk+O8/imI8jiEPyPxhuxzlT9stUIWaj0Jl7nuKONNbAYzpDaJObpXb45Mh4H7ZbEGW5oT
X-Gm-Message-State: AOJu0YzYNJbLdav/eEAtXAv2iTkFBlpd7uzTnHdUPX5XV3v+gA3UbY7W
	iyhJGWewm4iOOuX7/JBCGHU4msjb4Iuj9Bqx+d9GeewZp91rqifu+/4WWg0K
X-Google-Smtp-Source: AGHT+IGvTztA3LGIiuYsN8gV0etV5BgW0nqdXMyjLBSWtHQbBPY48hOhZy9U/wY6scIClzpl2Ij9Cg==
X-Received: by 2002:a05:6000:e41:b0:367:992e:acc with SMTP id ffacd0b85a97d-367cea67df8mr1505425f8f.18.1720522343590;
        Tue, 09 Jul 2024 03:52:23 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab106sm2186078f8f.103.2024.07.09.03.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:52:23 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: pse-pd: pd692x0: Fix spelling mistake "availables" -> "available"
Date: Tue,  9 Jul 2024 11:52:22 +0100
Message-Id: <20240709105222.168306-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/pse-pd/pd692x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 29cc76a66c13..0af7db80b2f8 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -589,7 +589,7 @@ static int pd692x0_pi_set_pw_from_table(struct device *dev,
 
 		if (pw < pw_table->class_pw) {
 			dev_err(dev,
-				"Power limit %dmW not supported. Ranges availables: [%d-%d] or [%d-%d]\n",
+				"Power limit %dmW not supported. Ranges available: [%d-%d] or [%d-%d]\n",
 				pw,
 				(pw_table - 1)->class_pw,
 				(pw_table - 1)->class_pw + (pw_table - 1)->max_added_class_pw,
-- 
2.39.2


