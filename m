Return-Path: <netdev+bounces-247912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 078A6D007DF
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 01:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81409303B790
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 00:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FCD1DDC2B;
	Thu,  8 Jan 2026 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du4J1+jI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DD61A23B6
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767833008; cv=none; b=Ig7iGtifoQHCRJzHg4QQapyx7qqa+rMPqf/hfwmLGyQ7FgOr7fSlEr34wepnJQ4ooPG1xWKn+34aQ4TN7saXh9fFvAJ9iDrWLZ53Bhvv/nvtwwKN/VlchsWo6iw4Me9CVTOgPa/3VwYQJ0Dt+971/JQGjVcQ0gqvyt3LHCGj8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767833008; c=relaxed/simple;
	bh=mHd5/FDiQ86yScP8/xKWBTcg+ow54G9KDtNwccSg1Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcUk2y4hfo7HSzErRek8IPL8MXjl6p7fYa09mxya5u6otZNgNOzOHNHURCaVN8hrlcp3PatuSD9+e2iBEay9y69xzt4eOkw+SUNdDX0E6xAlRKxzasNyXlvh1zdnY4KDESuBk5gK/On0I0exwjvvn4AtO8f+LkrSFts7JOi60zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du4J1+jI; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so1736472a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 16:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767833006; x=1768437806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qykhmziqocBs83eOMsCXS+riegj3dQCRKqwsythsgqI=;
        b=du4J1+jIknx8EyqHTRi0ncr9q3iul358A+qkdtHPGmY1T87z72tODfL9wrBdHUXx3C
         6vuBhcM3Eq9jzPvkGRqLTgzj9nJR4Ck9GpH1MDShirsStyiZgjvPxqOmWWEcihXzA3ya
         G3xJOG63lFSptgDN9M3vmG9TwwEzK6LGbaIeqt8oEfUsT1qn9rSvyk4YjZuFvwM0l1Tk
         uCzU4zgb1nEaccdShko7q2gsBct0GScnzi2lYI7BnnvW2aXSSuZeNI2J16jHezg+h9hn
         aJmEPMJUo6Edq92re9YyLELdWkHL6I1Srjq5tqvpj+Xc4WAwUWl2AtktLr4QmXtrFkZ/
         hk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767833006; x=1768437806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qykhmziqocBs83eOMsCXS+riegj3dQCRKqwsythsgqI=;
        b=YLERMmb6M1xa7QM0vlxTuSSbKT96XE1KlY9kDMYwLKqaA1pwYxmwnmbvHZfO1YwlI8
         o+I+iXx/Pvwjx4jRkqmiTZHrwjy3JFFw5t1kQmFXVRO7xvK3WF4GfZIwcSxTV1PkVKzP
         Jj85mBR96gz8uDR6F4cg4mC3bSz3EUatbbukWT1LJHf9e0E6YZC/Xivh42+KTd/CR74Y
         aVzewPheLaviNkUlhKyLwU3x+wtdcGYiBZsqplvwixxwrvPmEvdOoFRDG+roDUlwT7Pn
         vFPSM6L0O5aby5RGq0L5xIQGWMoYYh/44WSvW6GbGqONhnmzboNV4EXbQ8mLEG+prTjy
         uCcQ==
X-Gm-Message-State: AOJu0YwwIHlysHzWkm+JPdblD1O8ghjnKdt3i93K4KcUiH1Ko3kqTVpG
	UxbikkhG1L0yZsjl0eHMAyyak6IQFDQCQBfT+U9UIWBVOwR1gYWCKbmMRvQARV3u
X-Gm-Gg: AY/fxX4ceebdCWOcXP+plY8B02uel3qJUE1KGgZWFhCoIC9n1g8VvhUe23RzUgKAvgC
	xwVUBls/D5Yk6DVPDWwo8fWJpK6OnzG0u9bLdXox2LJkz+cyWdHJw2rN8RDC1CJ/M3XFDm/3uL5
	9r1EgCAbX+NwLJ1m2tXSvEYoP3Jhb4SVs5vv9ZsX1eaSXBlRKelPFpQsYdlo7J3oDH+NfSKGzhb
	fAHoMqVwqA31ZypqKimj6v0vXtERfan1azzAgDDqtjvheJMy6+MITV/chuADvBIIV+nA/ZG0UVl
	avlSC7GO8qzuECmw9CTIQ07307Hx8iplzsMevd7MXxvNPPYPOTVovTIGfbAAlhH8N/gxvvPNzMs
	pjpA2gc67kL3K8ODswqBr3hoXl2hdK/cFvfuS3vZ0OWBprSiaVPQKk8VkdIhk+AHADbu3DlqkLD
	Q00Mz9zgSY+JcIFBF8DEqCJQRi22ZNdrAHMJMfKTY3MWAqtNs+wlbkBA==
X-Google-Smtp-Source: AGHT+IExI20PPQrc2gAMhaAb+xN+DaUa+vqsuFXYJDYlwqt9scGkXOXGekbyt2CGFVkragmqd33jTQ==
X-Received: by 2002:a17:903:38c8:b0:269:b6c8:4a4b with SMTP id d9443c01a7336-2a3ee41358cmr41763815ad.6.1767833005702;
        Wed, 07 Jan 2026 16:43:25 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88d8sm60198435ad.80.2026.01.07.16.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 16:43:25 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next v4 1/2] net: dsa: yt921x: Fix MIB overflow wraparound routine
Date: Thu,  8 Jan 2026 08:43:05 +0800
Message-ID: <20260108004309.4087448-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260108004309.4087448-1-mmyangfl@gmail.com>
References: <20260108004309.4087448-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by the following Smatch static checker warning:

  drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
  warn: was expecting a 64 bit value instead of '(~0)'

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountain/
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 0b3df732c0d1..5e4e8093ba16 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -682,21 +682,22 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
 		u64 *valp = &((u64 *)mib)[i];
-		u64 val = *valp;
 		u32 val0;
-		u32 val1;
+		u64 val;
 
 		res = yt921x_reg_read(priv, reg, &val0);
 		if (res)
 			break;
 
 		if (desc->size <= 1) {
-			if (val < (u32)val)
-				/* overflow */
-				val += (u64)U32_MAX + 1;
-			val &= ~U32_MAX;
-			val |= val0;
+			u64 old_val = *valp;
+
+			val = (old_val & ~(u64)U32_MAX) | val0;
+			if (val < old_val)
+				val += 1ull << 32;
 		} else {
+			u32 val1;
+
 			res = yt921x_reg_read(priv, reg + 4, &val1);
 			if (res)
 				break;
-- 
2.51.0


