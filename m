Return-Path: <netdev+bounces-117512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F313D94E255
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8982810A0
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983361537DB;
	Sun, 11 Aug 2024 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="gBK3QFi4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9714A4CC
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723394708; cv=none; b=bWiE4CYCV26greBid4iuL6DpyQx3BjaXJUfJXzRgbWnoPxrIaUB2wnQYLMSWReQYfXA43s1CVP+9WPJSiUy6mwBf9v8LHTfiWU1YWU+8InCQTCFy4ZE78T2xFx6mBnIarE4SfXB+iKpfEBBcbONfnI1wVZN7q+2+vB05opibN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723394708; c=relaxed/simple;
	bh=DWIPkrbuaRp0xl07Fuq519gwbuX+C4OO6dmju4iB2oY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLkjhmDzoOBErI2ZsxRyyhdTdHWJEe8z+11BHXry0ZwQCx4ZP9kz1HZi0v6MAB3LjxcyDXR/e86rQ+O2wSFDuiUeGUlTzcXOm4BamuFxevgusVOt4EjrNKDjIEixA/SO4tgKR1OPGp9c6NOKStjWlgC2YJWBtP+16eGoYQ5DiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=gBK3QFi4; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7b80afeb099so2195921a12.2
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 09:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1723394706; x=1723999506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SPTP0gdyR7xKR6JEwEzAPEMoTHhOvNnDKjEEtsG1NrY=;
        b=gBK3QFi4FuTvZbXDRhV2x82kYUxmA8md3DKix3VVPkvZYKUEFcEKDHYzHbkaB9CjK1
         gKMZmIx8WXkx0mfkCey2zbg+y53tf59FwTjPmqKl469MJSJHcSYk3UnOZG0obM0+Ba29
         7EBcGXIPxY1JmN2zz9PMjKzAg0Vm6FIsTVht3A9piDTlsPGs/nz9S3otOSd6DEJSRxvK
         7SILDi9utOPv2Ieao+vR1md8FdUcOYRK8jZXZEazUnCgnEHe3sG3TXLdn+t9J6sPKRYb
         eFi+/KcBYkLTqpBx3o8aeMWy/1UzA31RFCBBQRE8znHbYP0rlq+kND4MZDwOaupT8xYo
         Cvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723394706; x=1723999506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPTP0gdyR7xKR6JEwEzAPEMoTHhOvNnDKjEEtsG1NrY=;
        b=KJdqD0cCovJAW3A6aVIEDDSSCmCZa0e3t0VuXM2iaHNjUvTmCW+uih3CrqKU9TouI5
         uMIDKrsOglrg0N8CM2DcZaHNvSeGKPEcv7nhGpD5SN2rBCTdCzkFK68u9/CFkxNNp4T2
         tS0dOe2BTLMeNaZ6HNqhYoU0+2sBDlrAjZHUCw0icVUqDdpOJbbsZUsFjJJURAmlfHHk
         9nZ4egtTUiaeHEi0A4YGKl557YfNAabHYuGqwK14rmw6hI81vEX3HX6Y4m/gXjejD242
         +cIi7EsgVJ0B5FVwAWRbDGAIzaHBrMLCfINBcxJYdiJ25gpujBNqwXQKc2Nci/4KDaYs
         l4PA==
X-Gm-Message-State: AOJu0YwDUYw92GTO9AP243V8eFjmENRSlJQP3l/qTGI3JTETB4n8wW1c
	NJItREYvPKDIweaJFazrn5TxbM8emrrnASgYmrd1B+SPUtrzmwPE4A+epNuQsUFffepLZr7AKCH
	D
X-Google-Smtp-Source: AGHT+IE3BTzbuul8QDZLZoAdVlLXR3fMOrKjAToErVeiyQ0zftJobrztuZ82FsgWCBEM3nwnYuPlZw==
X-Received: by 2002:a17:90b:390f:b0:2c9:9b16:e004 with SMTP id 98e67ed59e1d1-2d1e80799d2mr4804120a91.43.1723394705917;
        Sun, 11 Aug 2024 09:45:05 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9dc8997sm6545252a91.50.2024.08.11.09.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 09:45:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	leonro@nvidia.com
Subject: [PATCH iproute] man/ip-xfrm: fix dangling quote
Date: Sun, 11 Aug 2024 09:44:46 -0700
Message-ID: <20240811164455.5984-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The man page had a dangling quote character in the usage.

Fixes: bdd19b1edec4 ("xfrm: prepare state offload logic to set mode")
Cc: leonro@nvidia.com
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/ip-xfrm.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/ip-xfrm.8 b/man/man8/ip-xfrm.8
index 960779dd..3efd6172 100644
--- a/man/man8/ip-xfrm.8
+++ b/man/man8/ip-xfrm.8
@@ -71,7 +71,7 @@ ip-xfrm \- transform configuration
 .RB "[ " offload
 .RB "[ " crypto | packet " ]"
 .RB dev
-.IR DEV "
+.I DEV
 .RB dir
 .IR DIR " ]"
 .RB "[ " tfcpad
-- 
2.43.0


