Return-Path: <netdev+bounces-246116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BA2CDF8F4
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 12:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C810C3001BF9
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6B42F25F1;
	Sat, 27 Dec 2025 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/CEnmSU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A1312809
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766834650; cv=none; b=IfqOQvqsH7bDl6M9Fx4NtNBFqhYg/T+nkWFBoaGWiH2nyKVwYQsfGLLdI8w1mO4FNwSFHukwL0Hzyg6jBltbsnRBti7klSMWYxeJZR9WZeOAoRb+4NYluTGW0bYagXzzgKRXi6Lajw34qE0ONbcKepzX6yF/gLlUF/RzLcfhgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766834650; c=relaxed/simple;
	bh=0pLwzzdz5jBOkPBZm76gC58cg6Y6DWW8MuYHFIMkYZo=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=Ihlg6A4cJx720yKCRW6jWirMMiZHRrIqbB/Gs0xEn8LhOWkFXIXEApviIIpNsjuJ1zEwpKQVZDj32phMuVV4Hqb6HUbOssY1nYqd8Pg2r6vG6hTWyMTtPhNEJDSnO9xSkXOCh8/jRSGVkF+6XOnq6WkXfFJ8H8gktoqNloXZARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/CEnmSU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775ae77516so75391245e9.1
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 03:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766834646; x=1767439446; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0pLwzzdz5jBOkPBZm76gC58cg6Y6DWW8MuYHFIMkYZo=;
        b=e/CEnmSU3V6h39yVKI6m9k4EwhnktfS45YDzeFJ6OPuzQAjum5+k/aw4m/MUEa4V2Z
         O79qPiHc/BuRvjelHfMc39/+x5CcNxXeiJIQubEIqk0YDCn709mb/hBvATf89msdYUoV
         Kbbs/SVlXwDoI67jWSTvkDXYQjtaw0siVoCm2CnxeNKjTb185pGcfhEUOT8G6ueWXEZD
         Ghf4nw8p4u15PGPNqsW/UnXZZB1QMS9vAsLp8rCRQBzoQHrBn8jDo0tbQj1zwtk8Ei/a
         hyCD2FOhbm0+he68HQoTux5Un9uTyA5bZ83z+awMgmCXMRdPi9OrtDd4ynCZVVeqQcuv
         +mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766834646; x=1767439446;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pLwzzdz5jBOkPBZm76gC58cg6Y6DWW8MuYHFIMkYZo=;
        b=Dat+tX83wJkJqm/nvGGiBBVKanCDgxYnazZLIPKNDfOXe8UGc0sb+kPSskShg0AEHU
         bCaKGowzBc711a3AEqHOJ7Fr3MUZ+RHj+N6u5Lsb92Bs8hjtPlKDkFgbXKDa/zNwzeSI
         FjX6LlbUJS+ia4MSqg25azuvecx8vkjGeNMUQ56UU76qIs2jAuJTzuyDH4vOtxwCxbeN
         djaUrEcGCrMbsFfs/tBE23sEzLqT+HNYxwe9RvywB3BNfPW+MoOZzrDDMcv8/h8hOiCY
         Mwgc+iXj+CLXro++6WYC+o8E1+iVssFTr4mvEQnsO7prebiuD1xoeiDgpBp7eFd3mdIj
         lsrg==
X-Gm-Message-State: AOJu0Ywp6SdohaeJA8n5oD8NuK58nJODMMJJ+QL+582Mb43cdRq/5A0s
	uIJzagSdi46Mmw7U9eJVPQ3uaF+2AGItlw6fsWVtW3o3kyKaP3R57hwQl7LYoo0K
X-Gm-Gg: AY/fxX6JEoQDBb9bVOCH83UXfe9ok9jsuXqnhpuQf1AmXEe+Mj5wVFCVKCmzu1f2YzV
	rJdqU92x79NG7VTeQIMcThBZP8ai3WcL9/l8oEhojgM1uJCZLi+4HlBd+B4u8L+ngUD7/G3mx9F
	x2Cf4l1eH8W+e13c81QzhXNAr3bpG24W5FZZET2Q/tCb6m3jHMkX8t/iJXB+BruLt+GLoUWUvFh
	h59e943EBkSS+gF9une/neRGy5bZbJBZ1pqgsMF9MmDRT8GZ0KQZWF72qiGhWEFiW5ixaHTJwd9
	mNyGXlBFxCZ6CKkG6jrKGgXgRAdyqE/jjUlf3wupxlUqGyxBZM5Mh7qacrlwqZvRkwV9I9LvPU+
	ZREgOcxaTuHfzTSzCHSWnGyIstaaaivQUPptPuWo8rB6haJ0bim7OFHZNTd6AAyTfdespEeMHZK
	a5KYS1FwEd+5zpJ+pu4Pw9OptDVBuhmVDPFPBYjZ9BVRFgjDnU
X-Google-Smtp-Source: AGHT+IGH9YHSHrUZa3Rq/OqvuPwL5o1twOQ5g0Vna0aW6V6WuBFdmK1gmkQuVeUDD9d/snqlwQEfgw==
X-Received: by 2002:a05:600c:1d1d:b0:477:abea:9023 with SMTP id 5b1f17b1804b1-47d19577fb8mr281297975e9.9.1766834646143;
        Sat, 27 Dec 2025 03:24:06 -0800 (PST)
Received: from smtpclient.apple ([114.84.104.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272e46fsm479579335e9.4.2025.12.27.03.24.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Dec 2025 03:24:05 -0800 (PST)
From: laughing lucky <laughinglucky6@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: 
Message-Id: <34843FA4-B7E8-4E17-9707-5709254D631D@gmail.com>
Date: Sat, 27 Dec 2025 19:21:50 +0800
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)

Subscribe netted

