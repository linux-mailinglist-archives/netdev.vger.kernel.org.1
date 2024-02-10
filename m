Return-Path: <netdev+bounces-70776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F7C8505BD
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 18:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0326286698
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC925C5E4;
	Sat, 10 Feb 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="px1gTzKP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B274D2B9C8
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707586377; cv=none; b=kQedW277v7D/qt3j9pVs+TmdEtiAtey/+MCHKefAtYw2mhw/FtwaI8wxZMa+ulYjXSfat6sIunolUytFzIUTjSAHTPAhXUBlv0LKyl6rPlJSDkobxKt1szUMsMIRfVG9TBzQ82MIiyrbMBBF9ntLQQmXeLdtxrV5DdQSkmTZ6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707586377; c=relaxed/simple;
	bh=Ft/kF1XFJG4L6tqb2cGgxOlkxE5XppO9tRl0yW6hTBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZb4Qpzj/2wr5BMHBZ8lw5CLmo+HJeN+Zke65zoTk/zCyYljbyS8gREpzNbCJfk5M9i9x8nN6AUga2IcruZnZnZD81G1fzNPgu2OR8y6oqKWLRADvlpX2G8c+LBySpyNTFy1HUqjrvzlQ0e6UMUCH0v/CHMn34rqBo/P17ebL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=px1gTzKP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7431e702dso18340395ad.1
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 09:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707586375; x=1708191175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+v86qqp0lEEksWL1ght3ykc8tuG064EdCXrDkVYK20Y=;
        b=px1gTzKPjluStu9ulHuJpolUZ/4Bqe3bGbCGI/V29OemcxaTezI8YVwLupcExqPzqn
         UOeTQTOHkHEInYoFzfSnW31fbbFPBzuxyO45ebUCJ8Pm7HCEzHaY7TP6kP7OvsB3U0Z7
         HOQEJxAkFyuNwJqhLBESv1azyaqDlgVbpIdSvoK4XaCkWZcZOckUFQ1EyxEnudnR0gQL
         SjWZkPOZtOmQQzvBhcZpFcjRw/z+qjKLwrXMDMrhcQYkmAdTlXgdNRVYM6vBXxSlcFQa
         Ki9Cqq9tNMegrELw8IAfjXCCND+PHWFtvJf0uUvVv7A6DFc4kIaDi1UCE+mzcCeNn5j2
         OBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707586375; x=1708191175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+v86qqp0lEEksWL1ght3ykc8tuG064EdCXrDkVYK20Y=;
        b=GTc/qlzJn5xjAjnBuuqcWHBKPuWa7K8dDgtRsH5cuy4iiWj8kKIIGjZ9KvHMRoRI0J
         iJ9wPg3PeVyx94eH3P5uxxoSCdmHthh7pzIje6BgJrgElPCLUfmb1Yn+2LpaX8DgV4cU
         jxjrhyM97Q0mOeq3A29nBLlPDrD2HV/19921ZgGW/EH25XOnLcEwpgqX07wISnGx4ln3
         S4Ll1iYkSKhTsK2cL3l5nMVFEmt+gwmXXq2UebP06T45N3+/mj6/BmN6/o0XsJHZ9L2j
         TvfPIDlL9eiyAeilj6ozGaq1DAuR26GIBTwyT3lqqLGFVYCYr4ZUDOQ03QMWqSBbwoRQ
         DVeg==
X-Gm-Message-State: AOJu0YwCXmYUGGKzmxw6EIKtPMPZbdgYFHI0Lf/y/7nAbaI/e2ERFyrR
	W5Lw2I05m4s8l0xSWWl4S+r0b1DHdIxU9M2uT2QJoGifsPAJDEsqwpAGZOymklONp0meqZe9Oqx
	h
X-Google-Smtp-Source: AGHT+IHtEY9dhRenZd3PvTzixE7mUA0qBhRz+JaBmNznudBPUoKrVZCgmYcMa6xTBtrpO1SqH8eiQw==
X-Received: by 2002:a17:903:44a:b0:1d9:6cb5:a812 with SMTP id iw10-20020a170903044a00b001d96cb5a812mr2335470plb.24.1707586375041;
        Sat, 10 Feb 2024 09:32:55 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d9cfb9af20sm3252357plr.70.2024.02.10.09.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:32:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next] netlink: display information from missing type extack
Date: Sat, 10 Feb 2024 09:32:31 -0800
Message-ID: <20240210173244.6681-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel will now send missing type information in error response.
Print it if present.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/libnetlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index 016482294276..e2b284e6998c 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -111,6 +111,10 @@ int nl_dump_ext_ack(const struct nlmsghdr *nlh, nl_ext_ack_fn_t errfn)
 			err_nlh = &err->msg;
 	}
 
+	if (tb[NLMSGERR_ATTR_MISS_TYPE])
+		fprintf(stderr, "Missing required attribute type %u\n",
+			mnl_attr_get_u32(tb[NLMSGERR_ATTR_MISS_TYPE]));
+
 	if (errfn)
 		return errfn(msg, off, err_nlh);
 
-- 
2.43.0


