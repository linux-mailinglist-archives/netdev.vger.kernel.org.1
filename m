Return-Path: <netdev+bounces-264239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNryOVlMqWk14AAAu9opvQ
	(envelope-from <netdev+bounces-264239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:26:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D3420E5EB
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C406830459FC
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29183783C3;
	Thu,  5 Mar 2026 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UokcxGQy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F18347527
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702551; cv=none; b=F8/FbKfGhFdh0PLIOm8cZURQDurEq8uKYxBI4TgPjgPKvBHDOagTIuz5IXfmJwM7kBoJteVHjqfebN8mb+qA7Ni+O4AohqTry/y+Bimld6uD+qB41OBGm9x8sHukbFsb9z23nNMM3N3hsdBsnTQGDTtc992FHNzx2NKJZcraZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702551; c=relaxed/simple;
	bh=D15rmX5lfCdhAtsO6JBImQCGZd/Dy2YNt1Wb1sR3Xi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBnQAJRmY39I+VmrW+eKU4BfYoFh6/26lfNcZIEh7qJ1LWiyKuXy67kOLIWuhwZe7rqyqqO4GIu92+4o6oeNv8uwVNnn4S6TcdaUUlBu3DEauLXRh7i4cLlQCbsSRGU2AIxKAQGIfLCp3nSKUYcO05xnCeohxTODQLN1wO2KLjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UokcxGQy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82980945556so342491b3a.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772702549; x=1773307349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGw8YHPYJQfvE0v0vm8ntXkbcVbkWsR+ihkFDpKuKyk=;
        b=UokcxGQyVhYXcUMVaPUTmJwgG+W0jYAbVpCGQK6nz/6uIlTgg1B5QI5kehbOv/Kmrd
         uryGxefPwjvAriTrTfh76+8s4kQSrr3vN+seVjBy4VvWZVEN/8t0tAdCdqSWleAAsrFC
         dRU5iWB85lz1fpq99nVn4v1+f8S1y1/1WeHOPXEjBoqU2/GUlKY0DEI/W1COCGcttukP
         yv34ZskwqivwlSpZtv5r3WVNVLtPBTlOA58Y1guK7r8ASgtcNCJ+0ZPDE+BMDBJE44zx
         Y20j5Sy7BZv2qECd+B2vxRnlyzJk1E5RDnYiHwKFqvoECFjFjq70JdZr6cvs/5azHwZw
         LeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702549; x=1773307349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGw8YHPYJQfvE0v0vm8ntXkbcVbkWsR+ihkFDpKuKyk=;
        b=a5XaLTg6hdB5UHcFNANkzlWq8+MGLxVr8VnhBtonQIUpjW7LZUZ0Rzs963byVspzVC
         lxE+nA4h7cBAuF3g5OgJjiYHvusElY/ecbF0JAnYhpMt+RXB1qBMmuW3Liy9Z1olk5Cr
         8Ai3ZxRcpUgw6oiJZ67c+SEwn5dA6rk3Tiz4Yxfas5XO27R0yDKoTaHhBs7SY8Aooxlb
         MqbDcHOP0JQlvA5Z1etIIwVtuRHhustAU3qIuJ0nL/crC+UHtiBghDIk2lBPkzHmwtE1
         xpJ51TvuzJSOUt8tc5bQ0BtK2Yf8CayfL7/3YK7KAgBzGewocS0fMjwQkBT5+jnfm7Ge
         raGA==
X-Forwarded-Encrypted: i=1; AJvYcCWj+9NZtk0AMOgi+vNBqdbpT4sEGwwD1D65Eu2jKZW5nxvt29P6lybwEBNj93gHvFKrMcq9HAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyROJtVEgWwPI5N4wdL+336VMbZY8zjzVnrBu7wQtqIao3XWKa4
	L3zT6AAwf/GzJNryGLi6rbb94vJo/l7XIhnLuG3S6G8l3M7ftQA4QPiW
X-Gm-Gg: ATEYQzzl1xsah4wk6Dq1SUxY78mmrTksd9y/Uh4qMuRqzDEToncyTrYNJXPtGylZiLL
	Gf4smlWk/gzZIztECtP40O9+UT563+K0md8EpBeAsTqNE2fTAVDGITSgXEKxxME/FUGTIKxTnk7
	qTFW6jOGoMqP4FQjrG4MC827pVGlO/VVSghIA40iLfa245fsZ3hKq2FYD1TrYNoVOUw+sI9Slav
	+TVYZPa2dN9E3q9ZGqcA4Tx6qmNpefJ9wBcxytaFP3O+XxbDqC4qP+uzoFkax7QO4Jt6nQsX7Ih
	K8u8e0+qq6jCeiggC5j0sri+AaBp3Kg6qIolorzVk7K2UUbDo/1CsPY2KG6Qo1NQBcmABWu6Wpg
	97d6vLoZJXG4N8LITjbEkOOwgVwJmpJROi91a/q5xBwAn23cSrotGKmBS0cxNaSFSb6wYAlGVE6
	1YG4ZqwrSC6kSvf9uTDbbWZdSPKNl8vCwgWNfR7KvAADeYv5K1mlChyvKoe5g3
X-Received: by 2002:a05:6a00:909c:b0:827:3093:901b with SMTP id d2e1a72fcca58-82972d0d66dmr4186080b3a.43.1772702549140;
        Thu, 05 Mar 2026 01:22:29 -0800 (PST)
Received: from ubuntu24-04.. (120-51-71-230.tokyo.ap.gmo-isp.jp. [120.51.71.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff34fesm19718200b3a.42.2026.03.05.01.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:22:28 -0800 (PST)
From: sawara04.o@gmail.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next 0/2] smc-sysctl formatting and missing entries
Date: Thu,  5 Mar 2026 18:22:22 +0900
Message-ID: <20260305092226.27379-1-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40D3420E5EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264239-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sawara04o@gmail.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Kyoji Ogasawara <sawara04.o@gmail.com>

Hi,

this series updates SMC sysctl documentation in two small steps.

- patch 1 fixes indentation in the smcr_buf_type section
- patch 2 documents missing sysctl parameters limit_smc_hs and hs_ctrl,
  including values/defaults and hs_ctrl usage notes

No code or runtime behavior is changed.

Thanks,
Kyoji

Kyoji Ogasawara (2):
  net/smc: fix indentation in smcr_buf_type section
  net/smc: Add documentation for limit_smc_hs and hs_ctrl

 Documentation/networking/smc-sysctl.rst | 40 ++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 8 deletions(-)

-- 
2.43.0


