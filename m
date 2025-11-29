Return-Path: <netdev+bounces-242754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4005FC9492E
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 00:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54A3F3471B5
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 23:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189B626E6E4;
	Sat, 29 Nov 2025 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sglf0lsf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE91258EFB
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764460003; cv=none; b=by4oYvEzAg2F3cHj+9U+Q/QZk0Gq/T9AZ6SXeN2AuEzdZyBtNOesFKD64gyRFKlGmZgAMUwaVonqiZUIaVbBsIn0QjJg7DWtWzjcTXDSc6Cjzpgr4NPfh3WpwS6QUrt4OzzUp7bxfZ5THGM2GbfVGPXDUeQceTn6EcUdafOMJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764460003; c=relaxed/simple;
	bh=3Q77GzV4sA5JKej1QZN72HJTq4PSRxUUmeBLAOVou+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPRgZDWySvt9W5Kaef6yOg+8umkH1HiMKfp/fvnqYkPScVLAwIsaTdbbFWm51mqv9cDBl/ZqfM0/HRCtlo+HcDpQSjbZboRZgrYw0dT4kdKGC7soqIk7XlOLAso+W/L6zlPVBgxllc90AMb2MhMRZfH1v6XMvOc7xugJIZetF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sglf0lsf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aace33b75bso2939695b3a.1
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 15:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764460001; x=1765064801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCXAC0GBbAxPWdhq7j/4nJ+adBCJDMjQOJVyf/bKFTU=;
        b=Sglf0lsfhUVN5uOEcCv/mbS2A3yybxeFo/cUrCEkSVTgu+M0sTfdOkHdMk6V+ELI/y
         IVLOJosROGDTM7jy8FtOKu4F4GGDicBl2EMGF1/05cwgYMJEVO6Qt90zQER4a823G5XI
         aohZ3q5XeTMXAU2LnDW381ldThlX9expxbrShENYlu7/Zff9iwXu5MhgrKiW/NCABPVA
         PCZjuIMkEpRyM+PXmsJ//mEoJdubF8h5wQG0Ow8U1vxZ9jdvk79i5jd6qFwkCNyu+XC0
         G1o10reIAO4iCIoNKnYwW+FaLGi04CRQklqEQGlISQlHWnLy53Hy+kKQOBMTV7OZd7P5
         /KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764460001; x=1765064801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qCXAC0GBbAxPWdhq7j/4nJ+adBCJDMjQOJVyf/bKFTU=;
        b=mzfXFsq1YtRrHFp7C5NmGfA+S/MTDECls9H54OOAm91Q8lpiukbTjmU0MWlX78Tv3z
         bh59WyWF3jOrJX8GCHqO58oyHO2U7Bpsy3MbcDHao/ebgsIzgv+ncvJ36MgbUBRXF5AX
         aMwQVRSNZ1hBuZsmwF+Dg63T2RKEub3RQsyMWk74DTZ/tKiojrYYgCo6ei4EKhFadcmV
         TPeVzKjZlJkEDSfPBE4a07QoYF7aWrgifT8PxKyP0WGoXC4kpYOx7ZYTzcyiHVK2IMSi
         3OR/uRnOY6LNxLw7ValH2z3XtSXAq96hIJ8ZmlDlrL3mW2bv9e8DG1hJxbAwVwGyWOoj
         Ec5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3EZFrX2Nw4GsGrO9j14FbskPDZObefxfpcura8IB4K0NgyjSSfaBMe99moWTtFCo367Yye0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKNTwSvf29OxvgTqi56KINMeDXsw89U1soGRYch3MuIQ1w+rh2
	kloS3NFoLSKfE1zjNdf6xJccTX2LIXDMutWiz2wmIqAKfdt4qpEKdpGa
X-Gm-Gg: ASbGncsm+mr4Ry8lYNhlxS68KY64rsRvWGUSk6uZp5mgykjaKm7R2vXJunS6opuv6jY
	SOWtxqH1XRU44n5W6/7F1iJgoLsnFrR5PGxvA0DdoOo+HYjRY8Dn5FyEuTV/lgD6zJqcCeFsGqx
	4AFV3Br8nc7Yb1HO3Jn6N2UT7gGn3xqQVeoVZMa54zs2q+BNSZcc95Po4tVxVgGQpBORI4VoSWL
	3DYW8M6hkjHVhdf5uN1Tx/InBTknKdnqbOrMztBXvpc6V0k7c/5Vtq7sORuGLUY7AsrD3+mf3xU
	0ayJSj51NRtYampFO4RhJ3Sg2Jj9faeXv1vJAYnh2kougofd2X18rCqdD/5p83WSyB5blGVe4ln
	s+AsIqCGrdYw/fFWArPE2rSuSyYShr2dfxwlgFWe+EfrTQIdslZKBt2XySxs8/jPgHR/kHbCwgo
	wzq7b/
X-Google-Smtp-Source: AGHT+IEvcsMa5l/AhUy3wA67rw2nUoJkcI0nAX7R5RA7tZwpSoC+/PEIe8H7hubTPSio4L+mBgUalw==
X-Received: by 2002:a05:6a20:3d1a:b0:34f:47f8:cca2 with SMTP id adf61e73a8af0-36150f424b2mr33755297637.58.1764460000749;
        Sat, 29 Nov 2025 15:46:40 -0800 (PST)
Received: from SC-GAME.lan ([104.28.201.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fc08bd1sm8921049b3a.63.2025.11.29.15.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 15:46:40 -0800 (PST)
From: Chen Minqiang <ptpt52@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	Chen Minqiang <ptpt52@gmail.com>
Subject: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate correct reset sequence
Date: Sun, 30 Nov 2025 07:46:03 +0800
Message-Id: <20251129234603.2544-2-ptpt52@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251129234603.2544-1-ptpt52@gmail.com>
References: <20251129234603.2544-1-ptpt52@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The MT7530/MT7531 reset pin is active-low in hardware, but the driver
historically hardcoded a high-active reset sequence by toggling the GPIO
as 0 → 1. This only worked because several DTS files incorrectly marked
the reset GPIO as active-high, making both DTS and driver wrong in the
same way.

This patch changes the driver to respect the GPIO polarity using
gpiod_is_active_low(), and generates the reset sequence as:

    assert   = drive logical active level
    deassert = drive logical inactive level

As a result, both cases now correctly produce the required
high → low → high transition on the actual reset pin.

Compatibility
-------------

This change makes the driver fully backward-compatible with older,
incorrect DTS files that marked the reset line as GPIO_ACTIVE_HIGH:

 * Old DTS marked active-high:
       is_active_low = 0
       driver drives 0 → 1
       actual levels: high → low → high  (correct)

 * New DTS marked active-low:
       is_active_low = 1
       driver drives 1 → 0
       actual levels: high → low → high  (correct)

Therefore, regardless of whether a DTS is old or new, correct or
incorrect, the driver now generates the correct electrical reset pulse.

Going forward, DTS files should use GPIO_ACTIVE_LOW to match the
hardware, but no regressions will occur with older DTS blobs.

Signed-off-by: Chen Minqiang <ptpt52@gmail.com>
---
 drivers/net/dsa/mt7530.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 548b85befbf4..615e9a5709ca 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2405,9 +2405,10 @@ mt7530_setup(struct dsa_switch *ds)
 		usleep_range(5000, 5100);
 		reset_control_deassert(priv->rstc);
 	} else {
-		gpiod_set_value_cansleep(priv->reset, 0);
+		int is_active_low = !!gpiod_is_active_low(priv->reset);
+		gpiod_set_value_cansleep(priv->reset, is_active_low);
 		usleep_range(5000, 5100);
-		gpiod_set_value_cansleep(priv->reset, 1);
+		gpiod_set_value_cansleep(priv->reset, !is_active_low);
 	}
 
 	/* Waiting for MT7530 got to stable */
@@ -2643,9 +2644,10 @@ mt7531_setup(struct dsa_switch *ds)
 		usleep_range(5000, 5100);
 		reset_control_deassert(priv->rstc);
 	} else {
-		gpiod_set_value_cansleep(priv->reset, 0);
+		int is_active_low = !!gpiod_is_active_low(priv->reset);
+		gpiod_set_value_cansleep(priv->reset, is_active_low);
 		usleep_range(5000, 5100);
-		gpiod_set_value_cansleep(priv->reset, 1);
+		gpiod_set_value_cansleep(priv->reset, !is_active_low);
 	}
 
 	/* Waiting for MT7530 got to stable */
-- 
2.17.1


