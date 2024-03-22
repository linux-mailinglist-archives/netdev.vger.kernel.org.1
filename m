Return-Path: <netdev+bounces-81210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E190D886917
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 10:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCD628821B
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC481BDC8;
	Fri, 22 Mar 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Pq5a4a/S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5E10A35
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099228; cv=none; b=k4myJtnXq8z90B+TX62kd2IsZacL5I1TLSNKr2+BJPcVvANn5OcGHyH1QHlBpe2wXSmZFGIS4dei57q/k/oo78zZrkMUu0YUEwItkAfwuV0a5EcGAeFcaOYL9rmA+jyUVKl75iZhK1oFVayYMilsRTdTJysARqLny158yO9Cyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099228; c=relaxed/simple;
	bh=5R5Hd/bpG5D/sYlSYBUFIhlAzdpYqVPsRjEZcZxIwpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u94SSXXM+zcS8btIA5lbR57/vy2xei7tqVuUlCYXqb6/U5kc0yYHJ70k63IAMJ+sG8AwD4ml8LGqS6he/DVfzIjViDGAnbuv4waK1V68Bhlir6JMF4DhsHS2tg0n9hYbakacXlKSjXKbiMdQhXLRMvwGOTkSMcS2xsaYdyWzzqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Pq5a4a/S; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A00A73FB74
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711099224;
	bh=5R5Hd/bpG5D/sYlSYBUFIhlAzdpYqVPsRjEZcZxIwpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=Pq5a4a/SiVAWxTJPoj+2WdJRNmK2tW8dmMZ8dvfvo6yO+1D9L1G7PER+DzPLWVvD0
	 /rqtF8B+eR25x37Hti7RKSCfKjvCDPW1WRZOTbimekJrBrjv724kvcEzqZ8w/5zDXG
	 eMrNsYGIGhY5e6w5nTPVcD+eAt2VHdORl3G6ydXA605CBlvoMJjXwKh0BBrzhRpe3v
	 BxpHLnjcu9YQdZXjac8JgXJ4+TlbfqbkNo/zXMwmUevBCHLFWayQO+4J5KZIhCkFJH
	 d9p0DJr8Io6A0pReJ6lKAE7sOkuzY/mHEJ3oW5xcdAEWodqxSoFx9bmo1JdWB5fMIW
	 TdudSNSkNZ+ZA==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29c7744a891so1245017a91.2
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 02:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711099223; x=1711704023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5R5Hd/bpG5D/sYlSYBUFIhlAzdpYqVPsRjEZcZxIwpI=;
        b=auaAEXc0zd4reGQis/ORlfHDsZ8oJtdrtUbYB4fEuUnJbor/GTpEGoJacekwY0a/Wr
         fVXrqiEkEVztmD4dSzrdc0O5zyuFtXgSI/bT20D8uRAACDv1ANuTHrYjd33yWe2Fxj4j
         s3zAPdDQoDjR1F+MjIpWvGiDuRT2kQ85sEG7T0XC2WAz2VG3OXGqLBC2q6b8fbiYnzIE
         sYz9N8VgruCClyMj9fQdE1r3DEheQUKHhtMnkwqf6TAcIW51f0q+bZUj2Z+kZjoagXU1
         D9Z3rMVkBEukwZnmMpxsBwIuI1JE9VXOHEn912JeHDpJhvA95xspI/hM9LagmlLNvpOy
         5Hcw==
X-Forwarded-Encrypted: i=1; AJvYcCVDJlKczK4ZBsxu2qz4EAKjFdtUvi0h8QDU7PP8ZAw9zypbwwiKDsNTPFI6CY/ZFjzrzAfrwNh4f7G05EqvlIeTTywSUrHu
X-Gm-Message-State: AOJu0Yzo4ERb80jflqsOWBwIBSSECw+T9Po6X+ykp101A4IqQyWuAqsM
	yOgTdWtGkfUQ6RQX0ySobqmoSyk/DOHZ75u98eIydV6Lw1xgDdfBCRhbeQpxfiGOEVyqZnLw/ug
	eP2cZ4kdFUDabos02lbAXuifVZA/FOlBMO5xrydQ4pud8I6D0xqsBh0cPLX2tY+psDNINnw==
X-Received: by 2002:a17:90a:cc0c:b0:29b:c493:5c73 with SMTP id b12-20020a17090acc0c00b0029bc4935c73mr1714681pju.25.1711099223147;
        Fri, 22 Mar 2024 02:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwVoLbtWH8pLVYIog9xok9r1jOv+2Y43kT9a7VvHfO7hbgUmk7tMw1z4XqEvaM79xdHBnLfg==
X-Received: by 2002:a17:90a:cc0c:b0:29b:c493:5c73 with SMTP id b12-20020a17090acc0c00b0029bc4935c73mr1714658pju.25.1711099222860;
        Fri, 22 Mar 2024 02:20:22 -0700 (PDT)
Received: from localhost (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with UTF8SMTPSA id nn11-20020a17090b38cb00b0029b32b85d3dsm4980671pjb.29.2024.03.22.02.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 02:20:22 -0700 (PDT)
From: pseudoc <atlas.yu@canonical.com>
To: jiri@resnulli.us
Cc: atlas.yu@canonical.com,
	davem@davemloft.net,
	edumazet@google.com,
	hau@realtek.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	pabeni@redhat.com
Subject: Sorry Jiri Pirko
Date: Fri, 22 Mar 2024 17:20:16 +0800
Message-Id: <20240322092016.52941-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <Zf1KN_YYg-LrCQLh@nanopsycho>
References: <Zf1KN_YYg-LrCQLh@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am sorry Jiri Pirko, I had sent the [PATCH v2] before I saw your reply.
I will send it as [PATCH v2 net] tomorrow with a proper name in the
"From:" and "Signed-off-by:" fields.

Bear with me, I am new to this. Sorry for the inconvenience and thanks
for your patience.

