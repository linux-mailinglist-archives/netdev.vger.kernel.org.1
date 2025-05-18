Return-Path: <netdev+bounces-191343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E5ABB04E
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 15:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249C0176A8E
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B366F1DE4C4;
	Sun, 18 May 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkgHhTo5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C814EC5B
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747574019; cv=none; b=HaV1F1Wwk09mn0GHYR7jUluRYK8bvk8uAcTytjNPvaveMCHVqR6SHNz/WQ0mMzgEK/jfgoD6X3h52VGL+gBRzpKPgcp9O4W7LOfL7h1SPPD2tAYb3BXYkt+Y54GPDfPOg5tZ+ZS3Q8383YPP3XCJ61ev1oCvf2STAdi74FSM3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747574019; c=relaxed/simple;
	bh=fYvhhCT8o/Z+X7oGyotYdwsdM0OSB1ES80cAbJwKu/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YBed/YpJAa+kwnVaYLOUcCoMJQU+bILLDI7sDgPdN07MEeyQ8ArYib3Fd5hMvN0iXNUsAxY0rGRqEKcpW4Pm0tbcYrHLql8Ht9sX+G4/jhb0z2W5YyR9NrM9EQ7SXqLDSYqqzrMdgWnsJHEhj3HDAeG5R2hON1ZqSKJ93b2fho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkgHhTo5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54d6f933152so5291135e87.1
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747574016; x=1748178816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6HVE995k1ojRz/eS9BWFKOo/fCYjAN88WzwwvLUK2ec=;
        b=QkgHhTo50irwNhkZZnq9B/nWpn85TcCyo0b5FSdCVRyzsmREW+/BRi9ognuBTdBk4e
         GiNylW/DI54dwJQHpJrFq1ZCVoFoObD7JkDXOiVQDTddEPEWnfhfEgVwmJR6CatVCU2S
         Xs4qHpxzHavJ1Oug1CHtY217NAwppBwTvP5nDmx6cxaz1uOgKje/wPmKfm2N6TUOSjwV
         agqMOjNMLU/nWcgZOsgIgdfH7GxTdINKA2fMzL5GedAVaz4GeyWs8aUSm1br/TO73Zwq
         G5pfbE+f5BnKdfoaJTb8QuBlCk3avV710bZwr2/unkl9qB3me5T7vTmkqu+P+gNJq2o1
         qhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747574016; x=1748178816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HVE995k1ojRz/eS9BWFKOo/fCYjAN88WzwwvLUK2ec=;
        b=cJ5zj9bpo1fUWXnTTagCLiBz0JS6hV5S/UDDPJu0F/d37c6OshDj2MykE5N2It3Hko
         cLZ8eEa3+1kpNrvranCSi4HCb4uRxpFfHyvLDoiao7tVXOXdXSbydQ2SQlk2vLYBLS/J
         6B2+T8QwThCmsbXKuXGIuo7RR3y2tSyFapnHsFC/f5pGLLCtw16CCp1zN8bZFHQmR8vF
         bpW46mx9E0CxY7yY081TLMIRiakMlvhdT3zJMANDNEhnXzUkFLUvqrG9JJSbFwX1oFa8
         TdeTL+84Edn0y/eKg76NgLZdQpA28huGzdXa75Bp3TfSpayb7OrqhL1nQeAaxYV1KKPQ
         f7bQ==
X-Gm-Message-State: AOJu0YzO/CR8Zr3u5ZU95KcY5zvpkI0dfoDeQP1lolgfche9MvEJovLs
	RMp6kpsCl4Yimboa6hXGOQB2yVX/NpRRNNItJfTvEDVSHMA7JsceXFq1
X-Gm-Gg: ASbGncskxOwepm5cnvZolUSaA2TEPReE9Q4rFn9ytjWbAZdfKdmI/ATvZdDIiL8+O+2
	Vd2swj3TfsrK6kD5C46tkniYgbuFoVJPC2Q9/E/Y7EcKpDCXMT0iy4syCTMmaFAgwtjXuQ44+e+
	qlrotfS6lItU7sJcKZ3nTbq+IJK8Olr4DLIET+YvPanpAVaBlxxEb51Kz6JHukOc0CCSxy1WtwJ
	M5/0kRojmvszO//bCxTKcU3uGvDFMOpVI7WDdiaLbNLjIC6GkW3tGQIrEs+qY49lKD1/CP9Ufw7
	y9Bzkyj5VXxu9NZ2Gb2MdoKKojUyitKE0levN+ZYViMIibdfBMUT5YRJ0bpnHlsPuayJpZxCpHx
	bFPCwjwn7y7Jsazjb9g==
X-Google-Smtp-Source: AGHT+IET9bJCYIGBjRFjTM+jCTjQJEao/eKoDaxiHJ9oSLv85vwvyS75p7D2MgKVYeri/oEP6eCGCA==
X-Received: by 2002:a05:6512:651a:b0:54b:117c:1355 with SMTP id 2adb3069b0e04-550e992d893mr1864920e87.55.1747574015778;
        Sun, 18 May 2025 06:13:35 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru. [109.252.120.31])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f164c2sm1411128e87.13.2025.05.18.06.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 06:13:35 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	AntonMoryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] ethtool: fix possible NULL dereference in main() via argp
Date: Sun, 18 May 2025 16:13:32 +0300
Message-Id: <20250518131332.970207-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AntonMoryakov <ant.v.moryakov@gmail.com>

Static analyzer (Svace) reported a possible null pointer dereference
in main(), where the pointer 'argp' is dereferenced without checking
whether it is NULL. Specifically, if 'argc' is 0 or reduced to 0 by
parsing global options, then '*argp' would cause undefined behavior.

This patch adds a NULL check for 'argp' before calling find_option().

This resolves:
DEREF_AFTER_NULL.EX.COND: ethtool.c:6391

Found by Svace static analysis tool.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index 327a2da..4601051 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6634,7 +6634,7 @@ int main(int argc, char **argp)
 	 * name to get settings for (which we don't expect to begin
 	 * with '-').
 	 */
-	if (!*argp)
+	if (!argp || !*argp)
 		exit_bad_args();
 
 	k = find_option(*argp);
-- 
2.34.1


