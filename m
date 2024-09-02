Return-Path: <netdev+bounces-124166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11D59685C5
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6E0280FEA
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB48184559;
	Mon,  2 Sep 2024 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsTJhAAg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7A184558
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275253; cv=none; b=g2tw6gKXCyoT0FXPPAs+P9cAEjPCnfQyj3KkvSxTSaekKsbFyJrPFjyYJKnNxT+favlhIz8jscctaNZLm8GKOpMoCQMO8GDK7AlFLv7C1pCIXRR1Oe7/NXo0ZfK/mlDfZh+O1PhI6DUTY1E8AfWbpfKg6LGPRccPeWlS6cHeQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275253; c=relaxed/simple;
	bh=JARi/mYVuOIg5UeEHlaObUQNGYz1Y5nKzr4DVVL9vrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b1ygPGrn7JHBeljTpPYZSV+suMQC1g1H+RhHOsuUdoBXroGT1XKsG5UXGTH/utxV1GZM1millBLEXaDJY7XHAZrNgRGwWHorxCWrUJJELd8GpIwt1qtD8S3vaBtPV8TLBn22i04YRlpzkSf9CHV+jt8DvIkODeraxBcNZMHeS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsTJhAAg; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7143ae1b48fso2385076b3a.1
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 04:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725275251; x=1725880051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKfohwBbvqBoxMYozMoCpaKyJaWyr2X75WN78ivIk8w=;
        b=QsTJhAAgkQS/8CUEtpA1LWHUeqSDzb+Jo/o7MjEcXiegM6YuVdqkK/AdGSHFEovv2e
         ZDP0YfClPce/8VEqJa2F1kxoWsGkYe0tNbkNjbjX7IZtekxJ/ACSffxz7x78XpBuenPe
         XOsPCzBeykt5PPCONjmaQORwEkg60SGLT1aW/KiAoQ3/5g/avd7KFGVI5VrtR5y1JBX8
         6VkxwHl632Fpc61wJ97/NRq+4uNO6WxcGd5mi8sKrNuxMK0MjraNEDOMLO2E6mMnN0kR
         GqFGa/xRKsU720CLjzdadqCz0mYzh75YibdarlJSPCXZ4GUIK58L739RDxOJAfnsA6lP
         ng6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275251; x=1725880051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKfohwBbvqBoxMYozMoCpaKyJaWyr2X75WN78ivIk8w=;
        b=oJgUv2F2Ji8sXy72sWQkJsAlZDl+uLY3J89GMyRmvZjF1Rt8dyoNVW7dt4eP1zuYcB
         DmXPV5rYOEiuSfJOOCQUwSPFnYqPRQVH60kUFEsY6sOxUUB7KL1hzhgO5Nd3MP0Dy6SS
         zdxlYd93Fk3I7hi2TJCt/QX6x8TVW+UomEWCacG5IV7BEshvCX1XILo7OO5PDVgqDLwa
         A0ec6ocmQQdz0ApNnwKmJM93HFRNDSepMryA6TCSO6u8YAaA0F6+PpGaS0iqos6sNQMf
         PsYob/c+EyiO/o70fpsL/ysG0gtWTwtetXBAusCw2tzr5svNgeWeD0ZWGHIMaZZdskMG
         mWNA==
X-Gm-Message-State: AOJu0Yy2FOa9r7IIKnD4s8/zljU4T3NerXmmXGohX4Wu9Wmy8QNqgD9f
	JYFtBg2/jKt3cdwN6+B0BpkuxwsbBhgvgV8LDIIA9HnkOdjtrTI4
X-Google-Smtp-Source: AGHT+IHjMlWWU2cAlf1/PiXY9ASqDzwp2lJa8r2xsr9kEV5dCEbPB8JupTIDSQxafQ+hEsY7vq6Rmw==
X-Received: by 2002:a05:6300:44:b0:1cc:e069:e937 with SMTP id adf61e73a8af0-1cece502344mr6631770637.16.1725275251293;
        Mon, 02 Sep 2024 04:07:31 -0700 (PDT)
Received: from localhost.localdomain (syn-104-035-026-140.res.spectrum.com. [104.35.26.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d88edd4f90sm4797144a91.26.2024.09.02.04.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:07:31 -0700 (PDT)
From: Eyal Birger <eyal.birger@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	devel@linux-ipsec.org,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH ipsec,v2 0/2] xfrm: respect ip proto rules criteria in xfrm dst lookups
Date: Mon,  2 Sep 2024 04:07:17 -0700
Message-Id: <20240902110719.502566-1-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the route lookup when done for xfrm to regard
L4 criteria specified in ip rules.

The first patch is a minor refactor to allow passing more parameters
to dst lookup functions.
The second patch actually passes L4 information to these lookup functions.

Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

---

v2: fix first patch based on reviews from Steffen Klassert and
    Simon Horman

Eyal Birger (2):
  xfrm: extract dst lookup parameters into a struct
  xfrm: respect ip protocols rules criteria when performing dst lookups

 include/net/xfrm.h      | 28 ++++++++++++-----------
 net/ipv4/xfrm4_policy.c | 40 +++++++++++++++------------------
 net/ipv6/xfrm6_policy.c | 31 +++++++++++++-------------
 net/xfrm/xfrm_device.c  | 11 ++++++---
 net/xfrm/xfrm_policy.c  | 49 +++++++++++++++++++++++++++++++----------
 5 files changed, 94 insertions(+), 65 deletions(-)

-- 
2.34.1


