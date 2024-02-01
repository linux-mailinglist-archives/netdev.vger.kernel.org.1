Return-Path: <netdev+bounces-67805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32224844FE7
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 04:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9262B2254E
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 03:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4758A3A8EE;
	Thu,  1 Feb 2024 03:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XPsZdy4E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C693AC08
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 03:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759227; cv=none; b=P+k0MyeWtPUliLLAdzfYVtUBZELsB8cuIjD6fy6ymJ0ExpdwQ6lVDoOkieDkprqXQuux5sSfFPWGZ0xtOj89UCuQ8LX2iuJJi6cw1lt58hlcmwPxsvgHH4JUqdj8ozrqJ5U04puO2Yc2raFlBybfmVEt0L7pQwEsbGvXUGFaAWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759227; c=relaxed/simple;
	bh=DPLS+vxueDxhNxr4j6uaD4q/qcPdbjmx/+9OD0WPZDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ldx4uIdnOJWjNnH08ohFVtBAfnO4xr3y7CEX6wbfvNM+hb3biAzvUhY5/CoJ8eSnb47mEm0OyN+Vy2Yq7SiC4yXL/0JQ3HHGKyN/4TC+w+EqgCiAxwIGXZCWppWD2Kgjy88W3IUWnr+zEJ5p0WpFmKHHROgYX981kcdCwTNRksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XPsZdy4E; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59a802ab9fdso188665eaf.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 19:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1706759224; x=1707364024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NMDb7ND99LV0Wv9I4NH9YjTBRDRRwpAUyWuV7zmQJHY=;
        b=XPsZdy4Egf/vPZuVgSbET1N31f0M+/j9wvzV98XZ0MXW0bpDTWbo7vqDDVH9lEplB2
         0Ur8YUuvd7iRey/SdQldpvXBBUiXW7nwy8o8JAYO+yUUcPfzO4ukMB4sjkzWWPAHuEwb
         2I7ekhM5z2S3caLJfNPHtjakpKkr3KyAsFMGveTjYadolj/ZRO3xK3T1fT8kqjyzAifg
         Evuo7n7efNjWc7tX2q/rqafvl2Kf6PDz4Afc0QzFhK8wtjZzPBmEvMy5uVdXpsbw8smJ
         ETn3pxbPKd+UGaKEUChpXmGPWV+p4Ji72MDqKMtK5PXC0NwajbhrDAzuYKXSBz5GJ9EB
         MNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706759224; x=1707364024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMDb7ND99LV0Wv9I4NH9YjTBRDRRwpAUyWuV7zmQJHY=;
        b=XctmhSivWX0WW5R5EXatiFd+9TDoUPIhpDD13pTLM+h63o5B9Z99dTAhNkhh+g9W0Y
         jXdNceki2iu5bNOZ71awxnragvS2zqHCf/pOigBoSBTQlBgSURGWJH9JVMK8Cc9dowb4
         xjVCu51E3XtEOm2ttcgyKy+FU+M5ey+w5UCU9bV439oT20NY8SF/mUDKQMjXElhxP1rz
         SxhiaMru6vCBb9wzKKT/PQINfjcGalfwhDCZd2/0H/2hYb2uyAWfdRIa+lpWlXfdBovz
         uv16NE0r0rRM6sNT189pKoJYkXmuWin6m7/+Eg/lDu4XpnhCllJ9c5pf3Bvwxoy3wGC3
         v0nA==
X-Gm-Message-State: AOJu0YwAKkJn8A6lxshY6j73IhoT0rhrMeGw0ZxBPW7c5JYRsgktXqgj
	XAdIbtCQOvSV5V/O2LfrhPh/4Bp+ZAKN0ylvtE3LPg4k9TDejqUgDy1CYv79NUyfyp7moktykbI
	BCAo=
X-Google-Smtp-Source: AGHT+IGroyT9ODhYhjf/q1/8UlyJb8oD50aCkUIFwUBYO1+osp861DYABx4X9Jovm/PdIQGRW76Aqw==
X-Received: by 2002:a05:6358:441d:b0:176:7d13:d70e with SMTP id z29-20020a056358441d00b001767d13d70emr4387126rwc.16.1706759223820;
        Wed, 31 Jan 2024 19:47:03 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id hq24-20020a056a00681800b006dbdbe7f71csm11052857pfb.98.2024.01.31.19.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:47:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/3] net/sched: netem cleanups
Date: Wed, 31 Jan 2024 19:45:57 -0800
Message-ID: <20240201034653.450138-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netem needs some minor updates.

Stephen Hemminger (3):
  net/sched: netem: use extack
  net/sched: netem: get rid of unnecesary version message
  net/sched: netem: update intro comment

 net/sched/sch_netem.c | 49 ++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

-- 
2.43.0


