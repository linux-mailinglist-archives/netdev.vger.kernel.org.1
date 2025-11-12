Return-Path: <netdev+bounces-238065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4915AC53AE1
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 18:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F0E507721
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A6E33BBB5;
	Wed, 12 Nov 2025 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu9uKmqB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0062BF00B
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965160; cv=none; b=VMG1q1uaidLOvfOVBkH7+lj9FQJeEFM61DCUr8TGjwkDDlhIV5Hkfwpoj+ife9+Zy+vj7rV859e3DuSv4jk+rHBjpENmi/e1VBQfngzopZ7Kidbmw9yi7+CFVBDEqFtpDr2KG33tAZn7tTZ0pTW0EjtaMGuLT/+h6xUpdJqzXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965160; c=relaxed/simple;
	bh=c1QrvIRwprlUcKJLB3uc4wKdSKcMusSWC4zjgxF/IHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C6kZ/o2jz1MaxntD9kQXwfqe9cDktHv0M9oHd6+YnKCLTC0xXjaMtYdoqsCOTfB4Jy1ymhxNaRNorpS8SUguC+BavlQCduOjIozHNFei6iwdjTY5K88BOAWRPitlIM3e+Q85rD9byggpvUwkM8DG0AQ/UT2LZLESizPpc/t2K3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qu9uKmqB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b55517e74e3so974620a12.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 08:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762965158; x=1763569958; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B8FAT13muYHU2l7KuPkAgXskDVFmueBFnB0vVejWGok=;
        b=Qu9uKmqBPIo/+l+oDw1LScPofUv8miQ8QtCBpd0sCpiY9qv+r38AAnRTBtU/oDJ76B
         2fErEaBFsUgt8NYnpIafy3hxU6h/AX73myu+YLSvekC6+lU4IBGgpR8Le/ak1jEnzIfP
         bI5NuedhqYVpUOEzbnrH14UhzCeV5NA5wqpL7c0JJ14yjImWV8KAXReByt+fqvZhHl7H
         rjU8ef4N+OvR/+/AVQZC8bN9ajKK3AKXa4HCSuGfTAiqTnaGM56WIcA7IiK3nyd2wkRJ
         9ClfJ5VPjODmRMPn7ZzDwGE4IcGM14lOYOKfti7TfKXta4CQ2zoqFqWK1tFYO+lSe7NM
         Nq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965158; x=1763569958;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8FAT13muYHU2l7KuPkAgXskDVFmueBFnB0vVejWGok=;
        b=g6FnSzv2z8Z4jtuFFBCa+Y5vTK1p7F2+qYgI/MOnFl5ZzLyvnqp3IdcXWPJPo3fENV
         dfUezQf5+ciKTuBn37wOm8pmDOYdhvGQ0m+J5FvhMyNt0xz9+e9kfwDema7+AMtyYto7
         j8TbBuzregyjAsO8TO0O5Ih4s1NAvvvSZrAFHj/ASQshcmR21+5hjEIaM/Ou3mVavnPY
         X4vewjtPxiwIhOMCxNDnASHgWW0XXwaEPVsuTAzowFjMHCFUlkl2MANOFhnSDLsV6yW5
         ofK539+5t9T7zwGmxQ+LnNjpYVW9oe/i7/2b8gTCLYRKx+HIOdA4XlRXpKl+K9Lmn/jd
         RiYQ==
X-Gm-Message-State: AOJu0YyBsZw0THihC9XhX4xBZaPjzhUtZr8q6dWoiY87yLiRM7g5AUmT
	34BXwMfGI7tbGTNzyrmBBwf5+gg0/xtVhxtK+/p6VBkFv8hgYLS52nCP
X-Gm-Gg: ASbGncvosPLHMJSWBUvu8hqZMMQ6qTGmCGFaVuyzAxX3Rb/t+CkVTv5pPnXT+yLEDKK
	4SNY+0a1Mp4KHK2b8wzZ+r9zJrFEvvQs25Ab2FBV3k+YPbcGALCMSxVoYm/n/d3yrskmQX9RtOf
	qNo+wSqWQd0MdnGFB+4IeTHYkqgWSmslhHFHhrb1LnbBQXkld2F08Brec21T83iw8WAcI0vEvt9
	+fVGOuXjHZJl60jH7lgRIrX2B64+IK4FkvKaO3o9yvcD0xqQA8Q2RI9qGkkZh3xSqlk01fYHRYt
	a7zCkgLjE12EdinU0IBp3XDbsA9qisaKQ4kOUlp1yPUjJPTcpX3O9sAq+YKupV/2LBEfyD+jtqV
	pDZQ7CW7WzIeaJzDIkmulNw0+QFuaiJt3NEhG7YoYc6t8FaRemsk+aMDCuvSi8BK2yn/aDsE7dv
	4gWDIZmYONCKs+uGDCjJeLFtmca9/Yv3fQgYaHj7E0JcDkc++o1kQ1dZRcytmDcDlWkw==
X-Google-Smtp-Source: AGHT+IGASxaIXHRq6J4yMOz+LG6YdpDJPlE+XhjnpnzYhJ0OTSMjlf4w7B/HbJv8QfkLz2INP4aDMg==
X-Received: by 2002:a17:902:ec89:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-2984ed4720dmr44862225ad.19.1762965157975;
        Wed, 12 Nov 2025 08:32:37 -0800 (PST)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2984db00ff4sm36676155ad.0.2025.11.12.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:32:37 -0800 (PST)
Message-ID: <9446c349e725cf97021e8f205333d825d48de362.camel@gmail.com>
Subject: Re: [net-next PATCH v3 02/10] net: phy: Rename MDIO_CTRL1_SPEED for
 2.5G and 5G to reflect PMA values
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com, 
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, pabeni@redhat.com, 
	davem@davemloft.net
Date: Wed, 12 Nov 2025 08:32:36 -0800
In-Reply-To: <aRRkfg6zKW5gAOz6@shell.armlinux.org.uk>
References: 
	<176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
	 <176279047080.2130772.6017646787024578804.stgit@ahduyck-xeon-server.home.arpa>
	 <aRRkfg6zKW5gAOz6@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-12 at 10:42 +0000, Russell King (Oracle) wrote:
> On Mon, Nov 10, 2025 at 08:01:10AM -0800, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >=20
> > The 2.5G and 5G values are not consistent between the PCS CTRL1 and PMA
> > CTRL1 values. In order to avoid confusion between the two I am updating=
 the
> > values to include "PMA" in the name similar to values used in similar
> > places.
>=20
> As this us UAPI, please _add_ new values with _PCS_ and _PMA_ infixes
> rather than renaming existing definitionsi.
>=20
> Thanks.

Sorry about that. I had overlooked that this was UAPI.

Would something like the following add-on work, or would you prefer I
just don't touch the existing defines?

diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index 75ed41fc46c6..e80bcad1b278 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -116,6 +116,14 @@
 #define MDIO_CTRL1_SPEED10G            (MDIO_CTRL1_SPEEDSELEXT | 0x00)
 /* 10PASS-TS/2BASE-TL */
 #define MDIO_CTRL1_SPEED10P2B          (MDIO_CTRL1_SPEEDSELEXT | 0x04)
+/* The MDIO_CTRL1_SPEED_XXX values for everything past 10PASS-TS/2BASE-TL =
do
+ * not match between the PCS and PMA values. For this reason any additions=
 past
+ * this point should be PMA or PCS specific. The following 2 defines are
+ * workarounds for values added before this was caught. They should be
+ * considered deprecated.
+ */
+#define MDIO_CTRL1_SPEED2_5G           MDIO_PMA_CTRL1_SPEED2_5G
+#define MDIO_CTRL1_SPEED5G             MDIO_PMA_CTRL1_SPEED5G
 /* 100 Gb/s */
 #define MDIO_PMA_CTRL1_SPEED100G       (MDIO_CTRL1_SPEEDSELEXT | 0x0c)
 /* 25 Gb/s */

