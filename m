Return-Path: <netdev+bounces-94422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEFA8BF70E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0011C22822
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8F32941F;
	Wed,  8 May 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b="Z1BXXkUv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A91773D
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153426; cv=none; b=gBAoDnA6ssH3xb0jE1g/c3LQgetuxqngMdMLHuNjACBtUb6WIT1hIxJM/KiFVT5Xxq8hGT4ku+PP8nLX0KDAuyhb55E/utGwEyR2v559tMGRU5V6R4DBo8O5wN0moKaFqOnZ6Lk5sdi3da8PQZjMtxW1d2HiCqiopTKMPNpzxaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153426; c=relaxed/simple;
	bh=8MJVYb7cJIk6fOdvOULsJh7hLK4SkwmGIcOvMtTljuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ya26Iiuoc0rrA5kxGPrn4olTfDEVrrVwkvMeEIbl9FmUPHYT8ZGvxt0xemdtmuaY2Jwq95fy9pCf3OItG81NdyECsYVj3EjJhjB+YEHHTK5tBtUh6nloWxAIBUaca/1opAYDhzpqwqPvu4QWBItGg3dyQoFi6FY5bwSQJAaaVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innosonix.de; spf=pass smtp.mailfrom=innosonix.de; dkim=pass (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b=Z1BXXkUv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innosonix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innosonix.de
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a597394af62so75135966b.3
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innosonix.de; s=google; t=1715153422; x=1715758222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hJcjnRKy8xP2WS7UzmCHQ2sD43j2O7hA2lQCM9IkQBo=;
        b=Z1BXXkUvu5PLsFBqkwLeTZH29CS6RU9Hq2zWqpGQ7sqf5tpQzINqWvFi30gKGmqbSE
         WKlgLXK749euD6CooDXeFgVVfJD+oBtM5tV8Hg+smng+e4DE0pbCKqDyDNVuGx5Zq+cL
         wIVcqKuizeFifculSSpvs81komCqfrrpDsqmoFahyCdc0zx737JODVEM3G+u1v2C/rqZ
         7ISxyRxrMgaadjTSHuL1SYNrIl18bL03yqAOT/WDhquHZM9Z5xZz+9aXPEw7ld5epTJ/
         GwI9mLEmOXPGKpoO6Fuv+1GNmpxMFuGza7ZgcNxlfRg2NrMNSFDn1n+zkiD4xvWuK/Dx
         u+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715153422; x=1715758222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJcjnRKy8xP2WS7UzmCHQ2sD43j2O7hA2lQCM9IkQBo=;
        b=G6EDUgelomdHgXR4/JA2UD+0hXli7GMu7kbeoA/urqHEta749rMGFayBnIVPNG3YQi
         aBZdVCn0jOI9cbZwMKfSBHrAHGTN+nO+GmPCaVKmNYf9Ucnuy3MmKR2MpbQhBOwsPtpg
         I59Mmnqrsce04S3Ycwg02GCMtrYYRol/Sj1pgXGW0ELBNLQynshAfr16P+XhoU46PItj
         s31wwJuHGGJgAEZH687vy0cgGNJIJLGk9VZ780dE+78PS5JUMBIAYN9GEpT3CPttxqyB
         +Yex3glZC8BOsx8gYZqKIlGe5RC/ad1UqSErQcVpMDmE7NoqSB9AHe3tarMDSBa3WS0U
         I64g==
X-Forwarded-Encrypted: i=1; AJvYcCXNkuXwfITsp8od/VR4RoU6Kb0D9uvC/EE4novrzOIYWAY8nzLMSAtOJxfOUFDmmwTtywxfMNALIs2bEQzsCVyAlNXTN8Hi
X-Gm-Message-State: AOJu0Yzm9wHYnTkdEUVhOVzKn4yQUjgZUHaKeRlXQFAgCI6UB/vmrxdu
	C7HTGnUGPGRcxz9kRDENlQP+ZE71JLzMXVyGYKHykahfnVwmlFQH8I+jWemn/3vaPVW+cg2MOUM
	TqjcP4J/cQw5iCmEKNOHcYncb8oOQvATF5VSplKExMUSfib8=
X-Google-Smtp-Source: AGHT+IFXj5UdMjbqmKhl8pzs3m0JQY8AH+iKILd952YFuuAHyUqyc9kG4749y/FdV1LXFvh2+oMtUA==
X-Received: by 2002:a17:907:b9d0:b0:a59:cb29:3fa7 with SMTP id a640c23a62f3a-a59fb91fa86mr98634666b.1.1715153421963;
        Wed, 08 May 2024 00:30:21 -0700 (PDT)
Received: from localhost.localdomain ([24.134.20.169])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090648cc00b00a59a874136fsm5212358ejt.214.2024.05.08.00.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:30:21 -0700 (PDT)
From: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>
To: 
Cc: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 0/2] net: dsa: mv88e6xxx: fix marvell 6320/21 switch probing
Date: Wed,  8 May 2024 09:29:42 +0200
Message-Id: <20240508072944.54880-1-steffen@innosonix.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As of commit de5c9bf40c45 ("net: phylink: require supported_interfaces to
be filled")
Marvell 88e6320/21 switches fail to be probed:

...
mv88e6085 30be0000.ethernet-1:00: phylink: error: empty supported_interface=
s
error creating PHYLINK: -22
...

The problem stems from the use of mv88e6185_phylink_get_caps() to get
the device capabilities.=20
Since there are serdes only ports 0/1 included, create a new dedicated=20
phylink_get_caps for the 6320 and 6321 to properly support their=20
set of capabilities.

Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be fill=
ed")

Steffen B=C3=A4tz (2):
  net: dsa: mv88e6xxx: add phylink_get_caps for the mv88e6320/21 family
  net: dsa: mv88e6xxx: read cmode on mv88e6320/21 serdes only ports

 drivers/net/dsa/mv88e6xxx/chip.c | 39 +++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

Changes since v1:
- Removed unused variables.
- Collected Reviewed-by tags from Andrew and Fabio
--=20
2.34.1


--=20


*innosonix GmbH*
Hauptstr. 35
96482 Ahorn
central: +49 9561 7459980
www.innosonix.de <http://www.innosonix.de>

innosonix GmbH
Gesch=C3=A4ftsf=C3=BChrer:=20
Markus B=C3=A4tz, Steffen B=C3=A4tz
USt.-IdNr / VAT-Nr.: DE266020313
EORI-Nr.:=20
DE240121536680271
HRB 5192 Coburg
WEEE-Reg.-Nr. DE88021242

--=20


