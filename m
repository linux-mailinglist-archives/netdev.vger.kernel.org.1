Return-Path: <netdev+bounces-189278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0EDAB1758
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3E2520F0B
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7A221A425;
	Fri,  9 May 2025 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KW4XxckC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DCF21322B
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800861; cv=none; b=b/5cvdjt/RVE+NGJd1LZF5VQmmKCk3ukg9o0nfMQzdW3UXRdqMlYATY4Vp/FuIuBN1COXXBW+ETuyIAtgniTu5nEt6TjIINHdwSXnU+FJDhuE98KVc1yxw8R0YMDaAJmtbm7YK39Pt3WARjm1Ze5DqJwpn3uDpp9sC62xI1HMMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800861; c=relaxed/simple;
	bh=bRM7nxLBHSciJholg/sERvwWZRbKDYNFU/uHc6stu9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbHSj2qhZDaXS6tCjGtgSvy8ntmCGQQe44BaaAEBXseD3dpLqA0mbP8nsIM8b+K47gPxK2w0mEO03J6TGNyWgywYZqoC4ZcXFdkGPwdbGzMrBu6BU93iZuShfWsczTYtwb1lPU0BNkuFJBKXzWSjX/1pT0ZVCyn6pf9vgfLhTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KW4XxckC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso21909555e9.2
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1746800857; x=1747405657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2o/2RZ59TfkjFl6HDh3CDyZMrzFeBH9lqr1WZyJGmU=;
        b=KW4XxckCkyXo4xwPQBXqEjweRF42iXwyoMOpAnTCuu4Xsx4/83FwllmBlW/pHopSGD
         mScCdNxzE3xmZDs/zwtiFup+aI82dtarpxBx1IOcpidqpBd+fbdriQnCvCLhmfsyuSRi
         FWBrqohgONvPp41n5b1gFD9N/qoD/AvIGy8l49YMDBXu2fKrIOlsNf0ZHOAZ5ziqcHw0
         hyZK4AM79xzHjqQJlLpiIaAJkwpnQZme/HYOx1hDyFG3yv+9ERTzPc28dKZnqjCd3WXD
         w4gDlA9jy9pvw0wvryRHD9xSnRvsQfPxE/zNTfHwq7pD8rxzyIPNNDeY9Gizyp8YLslE
         vyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746800857; x=1747405657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2o/2RZ59TfkjFl6HDh3CDyZMrzFeBH9lqr1WZyJGmU=;
        b=JAR5GWGldnD8ITU0tiizd/5rQ3CVmirHw9F0GE0pOMOJUNkvXeQxOZtEcd+Pn/zIuQ
         n1lb+yc6GKMgOSG14gtV60AHtalGn3mTPo+cjWOYE3TGBNSEz33eo6dz9fQL1YKXcNTE
         EIyB6fYzSxhM63b/AG5JrIolqZADJGiAoulgimxEhYH+a9T5B6RI9VoTheY+NyBBLpx+
         SbcWf/2MlHI49WJvpilg2slALqjg9/AV0PWZSENww53dbY0U566tUBTuZfUag2XpFtmZ
         wPw0rfRFDE7xeaeYKj6y1dRBMSNpKimLr5Qn9rtT/ub6VEid/yCFJy2pbz/ijm05O4yL
         Vp2w==
X-Gm-Message-State: AOJu0Yx++rVZSzASekpYtAFqfx6N619dJ+rNUprEUSIoyIFdbGNKt7NB
	+yjOEL8G7TdpkbD/SS3mtI3teKifpXVyUsFPPwwS2P0oDbS3xppXcT2jvns+QO/crDCHD85UvrA
	wvecEuj4//SIfv6nRLX3ZOVQ05unnNXSsz1WNogjFXsGnoz8sQKeRB+29zydb
X-Gm-Gg: ASbGnctREkIq1Tg8M9JiQKiZ70G2bngzUSsR/IewbSkvpE3/tJQ7Zc3ChCxk4CJO91f
	QR2GaQmxshehpqt2DZJvi7Uxt8z0Xv9oiAIT0Fb7sRiKdMsiV2yndCn3oURJbagDWMbBxI9u4gI
	+9oQn0Ag6jhVr81uhkPKa0JoKLf/z+KglUOXxWQ2OrKs6LvFreYjC8quHYvufGpEsMLIkqt8Za7
	vNWi5+if075XKXOLar/mME73so+0vql7i1yBha/ptEOMr6aHQItMF4RWjchwZzJTgv/FbkVrEGC
	qXtk7O3Qrs+CORKhFPhNDmGRB9ZqNdXABXDSLIrYt3YFA54irsJ9zPArx8eYQg8=
X-Google-Smtp-Source: AGHT+IEViuxRBQwVvSMih7HatpTBUYnRusxDtBcTZ6kG0jrAK7h231N5sJgaa1KrQ0c4OhzgJegnjg==
X-Received: by 2002:a05:600c:1c9e:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-442dbc3ecc8mr5662335e9.6.1746800857194;
        Fri, 09 May 2025 07:27:37 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4ed9:2b6:f314:5109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687bdd6sm30905025e9.38.2025.05.09.07.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:27:35 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 02/10] MAINTAINERS: update git URL for ovpn
Date: Fri,  9 May 2025 16:26:12 +0200
Message-ID: <20250509142630.6947-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509142630.6947-1-antonio@openvpn.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f107479f1af1..04c58e3ee47d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18200,7 +18200,7 @@ R:	Sabrina Dubroca <sd@queasysnail.net>
 L:	openvpn-devel@lists.sourceforge.net (subscribers-only)
 L:	netdev@vger.kernel.org
 S:	Supported
-T:	git https://github.com/OpenVPN/linux-kernel-ovpn.git
+T:	git https://github.com/OpenVPN/ovpn-net-next.git
 F:	Documentation/netlink/specs/ovpn.yaml
 F:	drivers/net/ovpn/
 F:	include/uapi/linux/ovpn.h
-- 
2.49.0


