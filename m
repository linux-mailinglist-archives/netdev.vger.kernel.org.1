Return-Path: <netdev+bounces-224255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7516B830C7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 07:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 868A67A64AF
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 05:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E512BDC2C;
	Thu, 18 Sep 2025 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMVrQ4zk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EE9275AF6
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174838; cv=none; b=G9UKFCQxEopPrgWtiR3QY7ETKW+y46reRoWRqwaXiqqVRt5P1uD/aGR0uOrhJAAxaVW2x3TviltJcFDNvLvPbDsD9REkys3t6UMucJHD2lXHfCSDgUz0xCe1naiy8CY1x8/cbKj0GgYv7aWMTXtycKrQrVyEw+PZYOiibp5nFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174838; c=relaxed/simple;
	bh=CeT01jvK0qET2Ezep9PCclEX7ZaNh+v7TEcJCTPzJUU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NIMY6/j+j15AaT2QRgc/1rAxZvlo4orKYFiiKNQ+o5MAcLzPVl/Q9qTBjRWuUkT3ZLaQPMdZdLt6oE5nmtDuvmf2I6vXWurhXocpG7ToJG7AXXt/tOUG+je6j4KjLq5b6yd6KWzj0Wd0TMaxdvRUe/i+v3X/6Rmw/mtC+jLKn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMVrQ4zk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so4289265e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 22:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758174835; x=1758779635; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qa6HnFgwKuR72zccP2TOZkQN5VM18JOjPm74bNllulw=;
        b=BMVrQ4zkCv0bcx8CPu3z2Q6Lactjh1rVGIfuAWLv3mPQAz1VH6LZe3V5c1omJfrzSJ
         9A7Bh3RESvvYyKiGC+GvwlDg0gEyjicWQBUy0QU/8wupnSQRy7fvkfQYJOZHaxFmtWJM
         1xNnPNE1KAKS7ARvefXnE+qsmvwilbTccw/HYyDWxNQ8qnr3v7bAheMr+9Bi1u1NwvrY
         NXJOLh8x052APc/qV8KFxF1uMwpahuU8HQJ+MTI2/tlc7Sfz9bHOIGKpBn40JD3fVBkJ
         uaLWkWCyUuTIRsFVEm1puTVgu/EIfDYCs0YZTLymJDA6ZvewBEXjvKJhlWOCPYGFCxKs
         hAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174835; x=1758779635;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa6HnFgwKuR72zccP2TOZkQN5VM18JOjPm74bNllulw=;
        b=RMiw/LLw1WpnmJDutSWHDZu9sm/P5IKjARlHHZalgPKryvlsqiIPKAt0NwBFFjLqlq
         lBnkRMFuvnpRzPZ5mJkTeTOpZfG8SS0EspvqKfUBhti7FeH4RlUQ6g31CXHqTT/c+T/x
         bd0G8hDiktryaG56RpZw1kp/uvCG+8DpbFFsa2w+LtYl+zo9ly8AkZVz/S/83Ok5h9Ye
         MQ+q3prjhf90a+4/SrZKgZccqn6+9TjuK0oL27CLSc/AjPOFzrKJ10JpvLIMLuaMBuXI
         Nti9ESrQRv/NYQrremrAGEl8m5NFTCyn1QLzuW/SzdCCcL77xCg564dwWtB7YNQjxI6T
         NPEQ==
X-Gm-Message-State: AOJu0YwPZyLRk++mJsCwuAWalBi/I9c8D5Bq17NSchwzPpYs0rtG5bJH
	Wc7+s5RS5S8/wcjSUYQ8Wv2a6q/7KD0FeNB0of2CVgFlvX7vH5Rt4RM7/L0ijQ==
X-Gm-Gg: ASbGncvyDoOqUGDMr/tYYcSVAgwklp9cMee1F2hlssMeJReoSoE4szJ+31pn2XQWBQ2
	t76gAur5IqmmkPaSBY4hNhoYsfElZnkdQjL7Yq9widuDNBHBn05M9CwvegHeN5D31m+h3FiBAF5
	SNsLXMJ2c0JN98Wxj543FPY74lfwkyNq/7jyr3N5PgZoFkf6hEQWAOwZvKG/bvToAvlArPISMtf
	PYEFiGS4wdzCsAYzC1ScZUPkJ6ufb55TmD6Fe6QgelZXlJh6iMHd6wGP5pjd47E6Nh/z6OWM+6x
	QfxKr6Th3tChZhnSAmeUeem1cxoHTX0dq7ISwG62QvylQPXo7NpbnAwWM33qG/5spGdpw3iDcuc
	l0ViB/cD3IjDhR0DaY9DgrvkKHAkPG/fKk8K8S4wkHAi17SoRqhQGYVrNI4bdwVBXkUXsvOLNbg
	CeT/FKfiXzdHYIHYrRo9UMU1fQ8RcrNSBNEo8lg3iBfrwpJ5Dcfz/rjwsGTqf8PHml86cjlijYu
	anoyLsS
X-Google-Smtp-Source: AGHT+IGBr6tIVABBW4QO8uWDC9hUPVR7GmMAVtSQKK4szpYxbG5AHDf3/FEEaW9Pn+X32pUwB1T53g==
X-Received: by 2002:a05:600c:a06:b0:45d:d86b:b386 with SMTP id 5b1f17b1804b1-464fb7014d6mr18621455e9.14.1758174835117;
        Wed, 17 Sep 2025 22:53:55 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f01:5e00:64ab:23eb:a9ce:c1d2? (p200300ea8f015e0064ab23eba9cec1d2.dip0.t-ipconnect.de. [2003:ea:8f01:5e00:64ab:23eb:a9ce:c1d2])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-464eadd7e11sm25973715e9.0.2025.09.17.22.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 22:53:54 -0700 (PDT)
Message-ID: <67a3b7df-c967-4431-86b6-a836dc46a4ef@gmail.com>
Date: Thu, 18 Sep 2025 07:54:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: dsa: dsa_loop: remove duplicated definition of
 NUM_FIXED_PHYS
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove duplicated definition of NUM_FIXED_PHYS. This was a leftover from
41357bc7b94b ("net: dsa: dsa_loop: remove usage of mdio_board_info").

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/dsa/dsa_loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index 57b54f15f..31798e8bd 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -396,8 +396,6 @@ static struct mdio_driver dsa_loop_drv = {
 	.shutdown = dsa_loop_drv_shutdown,
 };
 
-#define NUM_FIXED_PHYS	(DSA_LOOP_NUM_PORTS - 2)
-
 static void dsa_loop_phydevs_unregister(void)
 {
 	for (int i = 0; i < NUM_FIXED_PHYS; i++) {
-- 
2.51.0


