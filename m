Return-Path: <netdev+bounces-230338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCAEBE6C02
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401701A66D86
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6546A30FF01;
	Fri, 17 Oct 2025 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUpAwkPo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E479EA
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683552; cv=none; b=HYpUvyH2Wr19avgu3mQ2wsdmzlJYZfzUCELqApTEYIvdoGCD1JStsIyYSLHknwPpNOMiakV2TaB46VXnPyagedXxcZmNx1R1IqE4tFvhK8SwbmANLbmc8/eLAOu3c4VDzS3Zv0/P6d+zf3xpPeu5Zn/w/I9SevjwPt3DDvb5Pr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683552; c=relaxed/simple;
	bh=76MXJi1GEaLekMNsuMxE/KJvLVrO4E/BO/gvBM1ACzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dYrC8y7gILMgs1hNeXkTh4yF1ruaoX0TOUL3oFQQf0GzRGG+2rN/ZFqZI5Qqr/eos3Pudd8he7KBQd7ZpiM/IG11RoAXN1nf0fGZJRnBdZgQrn8rG02I2qv0wAiwbyaQ4DbFk1Qdj58UbKU2FqF4sDy4dJd/BWcRCpjydevc434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUpAwkPo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7811fa91774so1470705b3a.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760683550; x=1761288350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DTkieSjdzW2L1FZWBBhfo8N9JLViedhpHr/nKm6IjJA=;
        b=EUpAwkPoBsvUpTUsVUB1z3KQAZsjPCl7tGnqTFufa9M1lupibcqsHy+3IiqxyZr8VZ
         qjd+24YVLIJ5ScjqwfOPkD4T0E8ngBAEWdQPUDvvchJ9I21WpLy7UyydvcIBRspB3Jlo
         pCcooLJLageM8onTa87D6MGlWqIG4lr5HNOiBWFscq3EWBN4JvM6pTjuMBOVGM2BPqvx
         4x3L/W0n2C0MHkTAHC4sirqiz3BzhAS2uvamnG3mUJUvSxcJlN+DMOjhaJIg/vNUIMYk
         fjN6wM5H8mpDvvuSUFKWkJLifpQTgurzRmAqn+gTX7eOVLhWj2BlgYFsVwBNyRS2NIBb
         dO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760683550; x=1761288350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTkieSjdzW2L1FZWBBhfo8N9JLViedhpHr/nKm6IjJA=;
        b=n8kCT/Pxb+rgA6fiAGelKPChC9n+9r9eJp6QM47tHH5j8Icxa/nCjcF+9uVdISeE4l
         tfS7lMPW1GmRffZPR9609k93zbAsnGUisic0AR2E1a21iR8tF66dVI2M6tWUBYdOxyRK
         +5Gnxx4SILurUVKJuLWh8Bf7NJ6SaKUngdnI8moLMCu10xqbLnvwz+lViSAaJutRrqmW
         VX+F2vdyrJSnKD1P4KgUkfDaikCmQpPWvz5UtQdaHdud+hF+S7gFhWTefWXvLOfz50Rn
         uATtR+uDDrE0mfT8h1yE84Pp0pXYrHDKd7oqjOCfB11FsRjGiM3m63FQZM0MMwv7P7To
         A7oA==
X-Forwarded-Encrypted: i=1; AJvYcCW75ofkVQ43tRd95l5eKohORwe72eWzUnSbi7rslIQxvXOYR3gulFPeLfeMCs9vQMNGfJ4RzN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+8Oa+5CNJshXqxCPcZfWvciHv517j+n74ZzJ/VwMbncI6EPE
	xASHuvU8Ft8NcZdvs8iJDmv2Joq2j7Yfocsa2xnv+bdsLRaD8A5hrScO
X-Gm-Gg: ASbGncvYb+XgCA1aUPxHly5lx9Nd2w+ftg8QIp+/bE0CHDDCYw/MWUnreeAKh+n4Tel
	owWEO8L3F+542aqaeEXo8wf10C1qxBpoDOznztgKfdnT8ECvoMWLc46qBER8BOmxrUyFGIWVUME
	Ebu04hCYbyrCgCPeoGJQbINLCFfLQUEz+BYrs/SVNVVLHYpnbTXAqBVksjAXTQBWb2cY3dJSIjh
	99lCAjlXaVnGAdYgIzof8KSim9UnXjzcLURUlT3WIxAHlwaVf7uPDTuAPzw9cyHU/lj/peGd6o0
	pDGlHOwLIwd9GApvnqTYyKC4dndxDikBZCQbLboAXVeKPYidENQVJaFFtIv63RvRLNES48jWWad
	7/ocEAL4UuQUGR15sxjbWUIwTz6AqTmeMB3Tc3LSkwRKeidK5BgUvUN9Cl/Z6sRKqH1qime8mbc
	v7ee1KQbXsJ5UAuw==
X-Google-Smtp-Source: AGHT+IEem/fSrEehwV3DtzcYZfeezgViQv1+qknKNWni/oU4JGS8WMmMY//d2kREKtWf2xINR4Ntsw==
X-Received: by 2002:a05:6a00:130e:b0:781:15d0:8848 with SMTP id d2e1a72fcca58-7a2208eec13mr3101403b3a.13.1760683550201;
        Thu, 16 Oct 2025 23:45:50 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-799283c1a15sm5249113b3a.0.2025.10.16.23.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 23:45:49 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 265884528ADD; Fri, 17 Oct 2025 13:45:44 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	linux-hams@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andreas Koensgen <ajk@comnets.uni-bremen.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 0/2] networking docs section headings cleanup
Date: Fri, 17 Oct 2025 13:45:24 +0700
Message-ID: <20251017064525.28836-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=537; i=bagasdotme@gmail.com; h=from:subject; bh=76MXJi1GEaLekMNsuMxE/KJvLVrO4E/BO/gvBM1ACzs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkfn2wP2+n+ZsO6mh0sAWeV2pb3qzslGMZvVY9IUbfPW VrJHTWvo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABOJC2BkOH+xgGGG+Iaqxwxb S60FV9eYLNjl+vHB7kNzpCcs+sH/r5Dhny3bKkmxBR3iVqGuuVqNj7n+Sni7n5u0f02syrnv9w7 8ZQUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Just two net docs patches cleaning up section headings. The shortlog below
should be self-explanatory.

Enjoy!

Bagas Sanjaya (2):
  net: nfc: Format userspace interface subsection headings
  net: 6pack: Demote "How to turn on 6pack support" section heading

 Documentation/networking/6pack.rst | 2 +-
 Documentation/networking/nfc.rst   | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)


base-commit: 7e0d4c111369ed385ec4aaa6c9c78c46efda54d0
-- 
An old man doll... just what I always wanted! - Clara


