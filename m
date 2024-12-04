Return-Path: <netdev+bounces-149055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1483A9E401C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CDDEB38C36
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B9D20D4E0;
	Wed,  4 Dec 2024 15:55:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F418320C490;
	Wed,  4 Dec 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327755; cv=none; b=dkmH94/OJvxqjlbSk2OxkrH9v5px4hMVE5HZGw96ZdrcsjxhPd3xcJEvBSwRzVCU+78ERlpiuZ/Ythb7GHypCFsRRGPJV2KbyE3qiMUiDt0O1nQ6vwZB/PlMNIgOn6gzTSzURGLrTTDWLJfrHY9SCp5AInADpoS41WjSdR51wmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327755; c=relaxed/simple;
	bh=nvvR5F5/9JC5aUPzeR+KkgHa2iTzckODeVucOV/sQkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZY4lsJ8h4Ll0LS2pg+D+nkYi1zXkx2HqtIgupRn8ZZ0Q/MbNXtd9y2wQwsqGamIWSns+TQZAfa5+fZaYmLZIlzQxgH5/FSAKOBRqG5YZx/SCsUGllKbls3sk8ADqM5o4AN3k/CwOuygYygmvaVEp8vembwGrSd25R7iwh86LbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215b0582aaeso23625885ad.3;
        Wed, 04 Dec 2024 07:55:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327753; x=1733932553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AUR96o9qjCdgchamnRhZInSsfHOVILC2gNs+9yB2rI=;
        b=feS9A8lfLszAcoF/BDDvFOIk7mo14INaAVKOfAEGwYUrowqCKGxqyF1sK2d+b71b+m
         belsu1rLe2o+3x4g0EsQ8/SS6Vf5Igdn/TshIRiSdcoDgSIXkxgi8HLMtUNB9s6kvx5g
         fOmPiEGi1Mo9n6+ybhJ99P8Cek33BKoWMPkmS6C3XQ/ok4391NXTtgwzlGdMFj9OOeH6
         6l2H1mg4zTaf2AQsP4hQ/CLk+ZZ8DNgNa1nfhE9+qA4OV4Uav+RtrEiYOgVvb95eQCJk
         H5lTXJFQsxPPdJe2jSGijXDPofP0B3UGeuh6m39exriFibHMrdlONz+sopzCYfPGvvaw
         Dytw==
X-Forwarded-Encrypted: i=1; AJvYcCVGBTbBB+qdpsrpDuSQZJYUieeyEaT+j193cb1S67V3N30Hn36TLVUm+wIpdpgYI9Osz0X4yi9VVZU=@vger.kernel.org, AJvYcCWSgAs38FzKzw/4345TqWXgNuvjI0619gEidyyv1zYaI9yRfPPsBJB3jqs0IvFyx1leAZmTphcc8w30ivNk@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJdx7x4dN92x5L3PnbWDJA1BlGw7jWKULrmpyz3CkCaDqMHgZ
	Zwj37KDgcpCfiDw2/PXEEJmw6/In8IZF7/40E35AXibx5Ad1fa6Ub9T+O90=
X-Gm-Gg: ASbGncv/l2ZVseUbdvwPYuBYlufuaPVsN6b6ifkOjUFt+qMWhPcNqL+yXqZsbNGeDXq
	27Xhv6DIvSKprSZD+Rp5SodjzpRv6ng+wxef3TvpQ1KyZC+MRJxucmTT1myFPMV2GbsZI7iiR/W
	3KWibHg7vTw10LhIrP5/koV2kWwVuolyxi1Y/HKG7IOWjmenJ7yi0BJuRXCAJ9B3ZY+AL4FoJYy
	0+XkLDGXZBsopB8oMRN7TO4XXhad1HodSr8wxYYCDhXX0CBXg==
X-Google-Smtp-Source: AGHT+IEzWCUtKFWiFQb7a/OQwhLzEyZs8SgdXXE1LQ6+6aI7X1mElyTVAlAAL1xIOIw4rLDdb44KiQ==
X-Received: by 2002:a17:902:ce87:b0:215:acb3:3786 with SMTP id d9443c01a7336-215bd0c4deemr85301625ad.19.1733327752971;
        Wed, 04 Dec 2024 07:55:52 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152196730esm113681405ad.118.2024.12.04.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:55:52 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next v4 2/8] ynl: skip rendering attributes with header property in uapi mode
Date: Wed,  4 Dec 2024 07:55:43 -0800
Message-ID: <20241204155549.641348-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204155549.641348-1-sdf@fomichev.me>
References: <20241204155549.641348-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow omitting some of the attributes in the final generated file.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/net/ynl/ynl-gen-c.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index bfe95826ae3e..79829ce39139 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -801,6 +801,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             self.user_type = 'int'
 
         self.value_pfx = yaml.get('name-prefix', f"{family.ident_name}-{yaml['name']}-")
+        self.header = yaml.get('header', None)
         self.enum_cnt_name = yaml.get('enum-cnt-name', None)
 
         super().__init__(family, yaml)
@@ -2441,6 +2442,9 @@ _C_KW = {
         if const['type'] == 'enum' or const['type'] == 'flags':
             enum = family.consts[const['name']]
 
+            if enum.header:
+                continue
+
             if enum.has_doc():
                 if enum.has_entry_doc():
                     cw.p('/**')
-- 
2.47.0


