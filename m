Return-Path: <netdev+bounces-190685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA230AB8497
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB339E5FA9
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68B12989A5;
	Thu, 15 May 2025 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MY71Lx6U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC7298989
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307668; cv=none; b=BjF8lcIEOlpQ9HUgvycAKsfx0PwWS1RhvrptBdr0mrFMux5U0eLF6FgsYLBPfIiSj9/HPXJOrwbt6h+C3ijBoFxyr9VydBI3hSwATqIrG8kKp83S4Bd9ZLXJX2nfkmprmUkjc7ZsmC3UPVaLhXp8E4R2NN29t0cg2Ww9Dpa5R6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307668; c=relaxed/simple;
	bh=d4pnzsIi6PAKdX5DjHbtus+N3ExXAcIcgMvQQVa5qxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YT/lcsU4tHYQNn3qgoEiGIKp9nds7XHqNe3qdn4Ego/gmsBETPURYS4YMrS42x4e9BWg0FzCo3GLVVnQPyOaqiq945lKwcxdaft2UOvy1MVFLCATh83DYtEREradi7M0iiYkovisgPxANuuJXhCvTdr52Z1CuuyGdoEpRzCElOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MY71Lx6U; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so5999175e9.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747307664; x=1747912464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3OeCNjT8KYTmc0PFImKdfqYaZsBOCn6RSUwt7C5p3A=;
        b=MY71Lx6Uwzxrk2uj2XQ0r4akzMdkSakRYquhNgfnfw9vdAV2gxWqZQIkqrCNHPmANK
         96RyDvgDeplBb0UBy/GQ0/LDlKomLnChvawzrbl6jrdqq7AYMnXMi6BNdX5FONvCvouh
         VDMZtdnDDDIZruUV8zyJ+5Vbc8P3h6dYDNjWIUqYuQgs3c0Z8/nSDXemddyL/c4znBew
         bBihNEiP+Z8GK/gVxAYPYccAEu6iGT7jfugEEpkB3FPtUNmZrGdNdpCP6l72j1Ftz6B9
         WD7s92m1M4TgqPmkIQXPfEoGp7+d0nob8dMtZhEG+meLTfq/o//xU35Ed1jqSY8dgmnD
         8YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747307664; x=1747912464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3OeCNjT8KYTmc0PFImKdfqYaZsBOCn6RSUwt7C5p3A=;
        b=LHMzTXoPpu1igm2E1YvRYAGnGSe5V7z/dUDavpb1QtrT2gWBFOmYz1JmqU66HZS6+m
         6HV3PIEDbjcIlPu0ySyfmeZ5hznqG1ZpQw9A0XQYus7oiWdZOb0aOIPrG8flRqoXu7fv
         tSLR2WYlEgmknNu8mcDTN+4Q9JAyWEavyN4MSBpGxDnB8buS2y+SK2UUfC9sjnaCdsj5
         TGkVi8Ecwp4C8+yy9R5XxtVyh785gdMKJOb7CVWr8Ln4O2d1/cdTkdvRarauXIDJHWsh
         bQHHbJ1pGDkCnpN5yTu2sHUdJn6UsQrf6mHGmn7Lw59mdnkB0fpqLddGHgWp7Yzkr3A+
         YMbg==
X-Gm-Message-State: AOJu0Yz81hfozXF3kmidLqev4iJE1Kpdifugw0IGlq0PN9ytmSplIS6w
	klbIFM98PVkEZ/vMmnSOGdzv5a+6+jGKbMOvAJFPvnnbhRxWAeQ3WalpdSXNrFMzhnbwrdaWLh0
	msPSh0aBTyI45m9Z05l8uCIMxGIMpIV4aq5X+4i04Rd19qR8OEZxvK0BKYy0M5pbC
X-Gm-Gg: ASbGncsbuVXy0RrmznEhhHEVGusJ3EImr3bqh+OW6N1bO7yIwciW/uhBzCNT3NwMyRP
	nVrHsdHti620wUSMYNtixkrf9xD7DiN9WurOUdjqWjC+zyoNjx51DLXGjXtBD1aGBw2Hrb1O0H1
	GAVi2cy7x3eEBwr3pcugfyrLRcvCJDAY7ZjN/yk5i38g7bjRc+mO0oJZ0GggOFjO4929itHZyCr
	uM48TS8+XDRpSPdUEmXyzMslNoJ2wGl15tKYZ+QdDNuuIXEYxOf5myTG3L6vdbLlmdDEJaE+QQE
	UBrQw+TryRk7QknbeeMUqZES1csveoP4QTgM25MAMZ1CGNWPz4JPEEVwq8K7G5CLe6o39+Qj8BI
	=
X-Google-Smtp-Source: AGHT+IELUdXDLey7EPDztCiYrS/nV7UZQTgMzxzYonTRM2C6JlZJzJ6y5wk074KLjnrIwSCILjMeDQ==
X-Received: by 2002:a05:600c:3507:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-442f8524653mr33157725e9.15.1747307664396;
        Thu, 15 May 2025 04:14:24 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:d81f:3514:37e7:327a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8fc4557sm24321435e9.6.2025.05.15.04.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:14:22 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net
Subject: [PATCH net-next 02/10] MAINTAINERS: update git URL for ovpn
Date: Thu, 15 May 2025 13:13:47 +0200
Message-ID: <20250515111355.15327-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515111355.15327-1-antonio@openvpn.net>
References: <20250515111355.15327-1-antonio@openvpn.net>
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
index 9019bcbcd50b..4b010ecc38f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18203,7 +18203,7 @@ R:	Sabrina Dubroca <sd@queasysnail.net>
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


