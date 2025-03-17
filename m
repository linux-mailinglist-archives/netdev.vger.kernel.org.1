Return-Path: <netdev+bounces-175335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF3A65429
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B2327A2CE3
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6622E245029;
	Mon, 17 Mar 2025 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcN0nLDs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3D22CBFC;
	Mon, 17 Mar 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222806; cv=none; b=ZwVBJS24b0JnUggX47t8ORF7D2tDvANH3Cnura3HsT14p+zR3cLEbxDOiIHbDnmp6okXLWOUeFpycp+qoYMKv56j/ZMvKCS6hOFe/gQy50VGmFHX5nyJ9jH2vKtEo2z0IFu4aR+eC/Bc6SrQ5iKLsFgjNKM7XGJCdfzwXuR6HwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222806; c=relaxed/simple;
	bh=KEmS1iazSZ7MW4u0s0WffWWZI/F30vXJvZhHvLypmnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abbccbcLnyw+OyvafPwypjNd4Scc3Gf3EPk8u4N3XeFW+vN6uBoFjBaJcvyxrq9fYHoAqBi04RAU2DCvnm63gOifVKgSS6uRFSWiigXq7ZqAtkmX8DzJycNH4z6QcfNqhNJVNSnjSVb5H71kaB4iR3uvTw/SH/gxjmr5UKUc/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcN0nLDs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390fdaf2897so4255071f8f.0;
        Mon, 17 Mar 2025 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742222803; x=1742827603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEE7cJguboNfIM/ImN+bEQAuxRuRsoshNhnvPdF6CRk=;
        b=HcN0nLDs4AimQH8YzhjWDKN+y9adOGi233YcpIQ1Xq4+xeojr1emNBp9inuBnrTJtF
         vSyxe9mmnq7RFJ+Qk/0xJ90TwQXAVWc40oNS7m5r8SbdAE1XnV752dVxUczzYT6vVKN+
         x1qGQHM0KXQk0pthbSIS0Adt0JfPBIh3/kNIM4EL5L1TABB0/VDj4+v0yyWOuYF9+vlL
         QLU4tSDkrj41TqjEeU9veyPiYWCtUufwwt1XVzldoz1HBpK64yXRUT8Y/b/v/R60mXWU
         4+n9rrncSnrX1fOe2xyER6coUpr2TTbTBiAbWaAi2y/yLXheuAJ5jM/t1EjV/hPG7M+f
         TTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742222803; x=1742827603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEE7cJguboNfIM/ImN+bEQAuxRuRsoshNhnvPdF6CRk=;
        b=NlfdUWAyqwhLoruDHrgJGldwtkTP+PITT/vShtid1E8fXLNZBKdSFqrpKTFU+X1he6
         +WJrbdXsr8zbCcbU06MG9EIn4uy7hjtSVZZUJBkrddn6k4WpvcuDALV61iLSH1GiURy0
         yhHAp1VXa2N79puW7uQIpTgJ+lCdeEbL3Ws/NE8EKKDzT82oUuZJfMmM9nNzJMB3N5E4
         Mmv3PaC7T1b03rDIejhlDKTD7VQnGYB9Jk/5x5dytoKqMSf2faXu/ApF3qHT76SgBj+w
         gViwprkk9zMAl0vGBOf7vf7gvT2znux5y0WnemC27uZXH2fwdNb6SeP8oB6607qTXyq1
         trFA==
X-Forwarded-Encrypted: i=1; AJvYcCVDJTGnZVPtyv4BVyGnig+glYy4hnrysSv5f51cmcUBLjXETxQNJu6sBfCbYMC9qhTJB37XNaQ4Y7ipXKc=@vger.kernel.org, AJvYcCWcPiUUF9q66ZKl92LgRZJQLKVW+JEJJ/CsoKii6KYNY186R8uuc3U4qWLEHgd3y1kjNzfL3zcW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Z/H997Dav0uWHHLSbt1HGNgcjgH/3bIQ+mKcO5gz7kEfHwLG
	Is3W6xOYiXNwcLyHDMUy+ljoArdfVErHxSxg/8160A+eNu5VVKut
X-Gm-Gg: ASbGncvQm96ZRw21QYePwTkW7DtXVQTVlxTasRnJCXnCKvs1p1/GdRMY2fVFumqw6Ng
	OS5snhzzhaS1kjIekxTiRD+q6WKfoUFJwkne0dplErl+JVsVa1+909Jb/A6NxYJrxJIsrTrUYzX
	VcMczzSBpYI8nhtIFvkFflqwhynU1EZQHs4oolWs0Vj8kjTInf7fhFjiKnMzEY8m8LD7dlloThX
	gHd4AsFoOKBjEdAGp8y4Jv+OcspZjV8exs+WgkjNHt02GvGuLfTJ6jOgX6kmbauAbDZ4yyGPQzu
	AESJTw09B36aGIxkzB/zSoM4uurSrDwZp4Y9fptLaU0K4w==
X-Google-Smtp-Source: AGHT+IFivRZ2EUR5/RimYhdOCuEzRooY6An887/W/KkgBBJttW2RvsoNsxmtBckobWqWYaquB0gK1w==
X-Received: by 2002:a05:6000:18ae:b0:391:40bd:621e with SMTP id ffacd0b85a97d-39720398fe7mr13511129f8f.44.1742222802524;
        Mon, 17 Mar 2025 07:46:42 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb7ec14bsm15130948f8f.100.2025.03.17.07.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:46:42 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ice: make const read-only array dflt_rules static
Date: Mon, 17 Mar 2025 14:46:06 +0000
Message-ID: <20250317144606.478431-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the const read-only array dflt_rules on the stack at run
time, instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/intel_memory_region.c        | 2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_memory_region.c b/drivers/gpu/drm/i915/intel_memory_region.c
index d40ee1b42110..7f4102edc75b 100644
--- a/drivers/gpu/drm/i915/intel_memory_region.c
+++ b/drivers/gpu/drm/i915/intel_memory_region.c
@@ -62,7 +62,7 @@ static int iopagetest(struct intel_memory_region *mem,
 		      resource_size_t offset,
 		      const void *caller)
 {
-	const u8 val[] = { 0x0, 0xa5, 0xc3, 0xf0 };
+	static const u8 val[] = { 0x0, 0xa5, 0xc3, 0xf0 };
 	void __iomem *va;
 	int err;
 	int i;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index 1d118171de37..aceec184e89b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -1605,7 +1605,7 @@ void ice_fdir_replay_fltrs(struct ice_pf *pf)
  */
 int ice_fdir_create_dflt_rules(struct ice_pf *pf)
 {
-	const enum ice_fltr_ptype dflt_rules[] = {
+	static const enum ice_fltr_ptype dflt_rules[] = {
 		ICE_FLTR_PTYPE_NONF_IPV4_TCP, ICE_FLTR_PTYPE_NONF_IPV4_UDP,
 		ICE_FLTR_PTYPE_NONF_IPV6_TCP, ICE_FLTR_PTYPE_NONF_IPV6_UDP,
 	};
-- 
2.47.2


