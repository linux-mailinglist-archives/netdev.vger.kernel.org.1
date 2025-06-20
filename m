Return-Path: <netdev+bounces-199777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298EBAE1C5E
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77F73A717B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90D028B4E3;
	Fri, 20 Jun 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5wNOV+i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363D628A41B;
	Fri, 20 Jun 2025 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426918; cv=none; b=eEKJqUoTyWk6N2/50zkXvp/jAz8/+LLYHWWN/xikz27HEH+p25yMZT74sCaauNCTpG5g54u2F7LhBgzmqyfYr+TgggE+BxEIyE9BQZLZTFOQaoBnrLeSVi8YP3poW3IXzQ8cRZjzR7zU0FFf1i1Q47j8DuRM2zIMjjlZG6StsgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426918; c=relaxed/simple;
	bh=8AE6Z/hip3sr8CH0JzAsKXtHGqb2sKIOd1Xe/5CbGOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDRG1YeYcYw/9jzuuSpxVhbGtnZKMAkS0aOtQlgXVaBltIx5GvgCdXiBzxt6HMcVhafod6nnYgEpWOKzvPgQWRBbAs6yFYNZuLuBAQYCbcZv/B4uuWZSYrpSYjbELyGRDZ/ZdWXeKBAe9ME9MiVFdgOdxWx9lRs2V5mJhnjlBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5wNOV+i; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234f17910d8so16999095ad.3;
        Fri, 20 Jun 2025 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750426916; x=1751031716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s6hwGj/QZwTreExBsbIh5VUbs3z8nkVNVdrhyFIURW0=;
        b=A5wNOV+iqbJoaKz7MkU/qJfeOfScgHQ8pZDZs3u+zBFBW1Yvxca6HuEjUB09//HoVH
         RptNRHaeAYo2rfajLTmuNUcnqwV81SpE0wzoo3MGRRWDdX0hNG+EWV1JSqbF3SI7tIk/
         It7nJzVANunwlchlRQbGm8fatcs3y3kDLFkr7lK7jixYaqhQG8WWB6YQf9SGWgumLTMA
         oqj9HUyiy2iOW9CO/pFlIDhnGhgMecjbgj3HM8fO/jjAhpc/HY5/eOBN9Q54qTMRCNU8
         w6tyCgRUTiCwa60Wzl+/v+r6WD5ssHeeyDR8rjf/rKxDnBGJQNJ/U7rKOhqt7YrmReuk
         osOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750426916; x=1751031716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6hwGj/QZwTreExBsbIh5VUbs3z8nkVNVdrhyFIURW0=;
        b=iLBEMo1TYmnrptEtD11TE4a9JkmkYdgo7evW++MGbjHJ6Al2nhCwH2tkqH5GFeZCBs
         d+ORgkeiSaHPJe1vGlm9rXYZG/yDBWd7LAnUiUKHzSiEB+EZ6IWxy+YyWbQnUZJPs/s6
         D92Xwmg8Kq6q+ObqUMs/zJweFS2Olp2S93sBdrVZqoT8Ib7PdL9DZMVBZmzXSrFfCbjY
         eSpWtA3utWmt5y79IdBbPHq/qRv9TmMrXtG23PhIFmm7gIziqttMZtIDqPvcj0p7rhUQ
         fRFzQd5czSFwi3fXUAiWq7lSWKkQmgy98C9I0sGT9JSS27SrZpa1haplMH7JV5wuaolY
         zj7A==
X-Forwarded-Encrypted: i=1; AJvYcCUuD1aas/QDZONp/h9XTNiJ9bZNLJQ71CGQfdCBvcvA+p1OE20zH/LHKf9bLx5kMjl4vxM+STcR@vger.kernel.org, AJvYcCWAa0JvVHorthE41aWditS4c5gCCGqXV4iHo3o4cFdjfYzAj8gNK/nNYFNoC2ykQpa+lJ5LVRGTK7kq@vger.kernel.org, AJvYcCX6p4ClaQllE5cTk9hSICn2rX4lXVB+90TzkPOXTyjyxa66UVNgv+4Y2NiGmjj0dBq1kG038mYv4NYTFwp+@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ46oEMWQO7nTrbCzWj36PMBQ6irKix14TNMYw0Nqbx+dqF4+R
	i9BqFIROZXTpMHQHUA8mhxVCFwJkLS7Ybjk34SloJg86XIL47tFfGz27
X-Gm-Gg: ASbGncvsM8YE2uhQx+vIPmTn/IpFutYUstn4HJSq7zZMFNrCubs3GPHW21a4F7sXhQG
	OxAq2uQXOicuMRNq3Bd33CKbyQqUJLcSoHoyZW76YTxCA+J1Hxb3XRVTeWbdpm7mJcqR3KQ0qlF
	yyW84HJSZXC8pLNxtzKS5OZFeMKHFAynaC0sOeuqwLHVesz3tF8rWSGYpYUPTLiyoQAReePtWEG
	+HjRzv5D4CwmChQqsS5jssPbMU5kJmrzydfl1JKWxD4b2kn52e5VmUj9V+w59ZMiAmf2iMMoGoF
	vi9Ba/5+i74ymw2fnOPg2zpM6WCzt3kO5pXnd9Fivs7PdNV6G5ykL9no26gc3wDwjN/OX8pBq83
	DZtvQcaJcQP4osnE=
X-Google-Smtp-Source: AGHT+IHxgk3vPMkfFo7cKUg+Lisn9B+iB4jqLSWpa78B9fKY4DolQbGIlGwdhgSrxd3MtQ3qv1jH5A==
X-Received: by 2002:a17:902:db11:b0:235:2e0:aa9 with SMTP id d9443c01a7336-237d97d1d84mr40842905ad.14.1750426916198;
        Fri, 20 Jun 2025 06:41:56 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d861047fsm18885505ad.134.2025.06.20.06.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:41:55 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 0/6] net: dsa: b53: mmap: Add bcm63xx EPHY power and reset control
Date: Fri, 20 Jun 2025 06:41:15 -0700
Message-ID: <20250620134132.5195-1-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some bcm63268 bootloaders hold the fast ethernet phys in reset 
causing an error when they're probed. The resets are controlled 
by a register in the gpio controller, and would need a minimal 
driver to set. However, that register also controls the 
power states of the EPHYs. I'm trying to implement both 
functionalities at the same time to make sure that they don't 
interfere with eachother. These patches allow control of the 
ephy register from the b53 switch driver. 

Is this the right place for this code, or should it be in a 
power domain? Should the resets be handled by a separate reset
controller?

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Kyle Hendry (6):
  net: dsa: b53: Add phy_enable(), phy_disable() methods
  net: dsa: b53: mmap: Add reference to bcm63xx gpio controller
  dt-bindings: net: dsa: b53: Document brcm,gpio-ctrl property
  net: dsa: b53: mmap: Add register layout for bcm63268
  net: dsa: b53: mmap: Clear resets on bcm63xx EPHYs
  net: dsa: b53: mmap: Implement bcm63xx ephy power control

 .../devicetree/bindings/net/dsa/brcm,b53.yaml |  5 +
 drivers/net/dsa/b53/b53_common.c              |  6 ++
 drivers/net/dsa/b53/b53_mmap.c                | 99 ++++++++++++++++++-
 drivers/net/dsa/b53/b53_priv.h                |  2 +
 4 files changed, 111 insertions(+), 1 deletion(-)

-- 
2.43.0


