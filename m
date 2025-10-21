Return-Path: <netdev+bounces-231390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A831BF8B73
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C88234E47CE
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8D027F4E7;
	Tue, 21 Oct 2025 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="opeycQED"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E227B331
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761078590; cv=none; b=M0POKhDDQUJWKySOuCg0fNGxMfTjGy93WsmSXnifNkNC4d1XvRpWqWBf1MoxG/6Mnp0dnAeAVniGi3V+XT2eypzDW2O1hAk964A5UurhS3pUpKmQD8Dz+QwoT/AhSQFL81nZ8l1AY0wz4SYQ1/0/zUsad6oYowlN4AWO9f8De5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761078590; c=relaxed/simple;
	bh=3RKfiQ7HQ+Ry+dDMPsxPz4pCXEPKDhuDMhaPEPx+pCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLJnv2edYXlROrR9pu633HPepa/0LHV+iKTZ+HwE4alXRXGyV2PhPpYho1FUyAfAcNgjcMryqknocWGzoNu3r9lRQGBFIpi4t2Z9wVh4jiOr6PoYFON4RDcsyjiQqtFIkPDCbWnsoEGNhJ9xiuxAbt8+7h2nUCYi2xRrWLxGgy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=opeycQED; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-651cda151f0so2501611eaf.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761078587; x=1761683387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=poUGxYIjxDLWE9ICi3U7DjsMI96MoayyxctFhopL1GY=;
        b=opeycQEDqw8ebMrtxGHVvaXJgJbsa6ZNWnsbMCAdTB7E5MJliHrdPCWjYpQtu2+Tf+
         hV93QF4R8D7tg+q7TQuwbUmbXKyM3T9/+i0Vii2war48fKzTffVYTerY0KT3nsvJLmPB
         5+ZhQaROIzfJfEiM3klViyx2mjASIN9YT9DwgFHKObcFBDlgdmDiaTHXH+LE5/Y2C907
         IJVasz0N4JTqFIYw63GSV/Cy08peY14RboeSy4MPzqoGoylTDJn9nuZuhGf1H2z6MItT
         WllkA/6BWGkZrxCBuh4h1qt7WmJX4HXFdX1/jhgYjMdV49G7WZCLqLo+DAIrhSVt+Fso
         2ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761078587; x=1761683387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poUGxYIjxDLWE9ICi3U7DjsMI96MoayyxctFhopL1GY=;
        b=P1KQeUk2XL7YLpKSP2cvzIsXGQXPdkgU9z5Eu8g21+g+fX9CrWBJ+4z0AS6zLIjf6j
         clCwZivZ8Z5dxYUnzTDnXKRIVFQJ4Be0exWxURr/ULVSM4og9eAMZdXrva/ydZlHrIHs
         nmkXyoI0OmN2tVM2naaLvOH0xLqO0xlAsjG+Vaug2y3Mj0U1l2wdfx4sPq1pg1QVhsBq
         fgAU07QTjERM4j5EOLfdPPZFsKUgPNN32Jqjd6MIlRyySBKjM2PSnRFqJDqgCA4gxzyM
         mOX14nYO+00t4VVOeuYR9iZP5NcVCx45M7evAtVphOihU6zlngyfAMhNTi1i9O/f7Kem
         hEEw==
X-Forwarded-Encrypted: i=1; AJvYcCUb0BrUbP2LRYFIew1sGT+6afbJtEG1BrEFM1zEekthThvxdGWp+mkMnZ5LDDT7+RKG7j1rRi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzAltnfn6Lp7CFv/zxlDdDszfcmL5hhKvwFN8w0lMDOWy+PVjY
	+ooXKz8N728/HxD3isYzTUgpYWiQfL295b7hVfFNpbFSyVmJwiiBfiI6AldsT7EI7dCwoLANqH1
	hCYOp
X-Gm-Gg: ASbGncslfNbOTXljYDM5ITBTA9IORJhKOMdf4osjsPG8bahSeVoO6m9pc8tv+UJAUoP
	1BXo2W/rrdSScJ/fO0pyyGJR3urxju+bZ8X6pDhjmD7VM0vGKfrYpONiZgMtmHLvBmcxhox2Rr2
	rePxG2Bv0icafRr9fdQ6sR3/+wv7u2BirSlIKT/HbSkqqOQWfWQ8pNq5pjg0lI+OvTOusxAuKGj
	93LVU0JOoJ3zpVMPsWxe+LcOKd1eHURuIPepkbDUyyUCjgNd/FO8lRXZdCVgfShiUVXbpSmKM1j
	UPHUIM2Kcq5dfh11N1dYeDcUeYuklgYAIeHvU/5YzT23B8SjAwasp7asC7Ve1O56baPh/kjuoxZ
	FQjNDRv4DYtuH2dDVQbLCkHgMNQVX5eFrff38X1z+38MwjvUGkJl6sbmmkq6oM94AZvxOu5HU
X-Google-Smtp-Source: AGHT+IGiU7S//2XSxp1uOjSndVStRByroVEosPr96HKaMXGb4yAHc3fkXcg5pK97vhsVlnohBOrRsA==
X-Received: by 2002:a05:6808:3a19:b0:43f:1c66:bbab with SMTP id 5614622812f47-443a3153ce3mr7489170b6e.47.1761078586740;
        Tue, 21 Oct 2025 13:29:46 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:1::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-651eb5e3256sm1408738eaf.14.2025.10.21.13.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:29:46 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH 1/1] io_uring zcrx: add MAINTAINERS entry
Date: Tue, 21 Oct 2025 13:29:44 -0700
Message-ID: <20251021202944.3877502-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same as [1] but also with netdev@ as an additional mailing list.
io_uring zero copy receive is of particular interest to netdev
participants too, given its tight integration to netdev core.

With this updated entry, folks running get_maintainer.pl on patches that
touch io_uring/zcrx.* will know to send it to netdev@ as well.

Note that this doesn't mean all changes require explicit acks from
netdev; this is purely for wider visibility and for other contributors
to know where to send patches.

[1]: https://lore.kernel.org/io-uring/989528e611b51d71fb712691ebfb76d2059ba561.1755461246.git.asml.silence@gmail.com/

Signed-off-by: David Wei <dw@davidwei.uk>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e..067eebbff09b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13111,6 +13111,15 @@ F:	include/uapi/linux/io_uring.h
 F:	include/uapi/linux/io_uring/
 F:	io_uring/
 
+IO_URING ZCRX
+M:	Pavel Begunkov <asml.silence@gmail.com>
+L:	io-uring@vger.kernel.org
+L:	netdev@vger.kernel.org
+T:	git https://github.com/isilence/linux.git zcrx/for-next
+T:	git git://git.kernel.dk/linux-block
+S:	Maintained
+F:	io_uring/zcrx.*
+
 IPMI SUBSYSTEM
 M:	Corey Minyard <corey@minyard.net>
 L:	openipmi-developer@lists.sourceforge.net (moderated for non-subscribers)
-- 
2.47.3


