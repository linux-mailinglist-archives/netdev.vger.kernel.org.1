Return-Path: <netdev+bounces-244078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FBACAF5EE
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 10:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 478D53017F13
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7481E238C2F;
	Tue,  9 Dec 2025 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4KigoNH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2B1A0BD0
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765270814; cv=none; b=Ey4q2mJzo+WwuOawRD6166Enk2aL1qcBBKWfbtILlxDhhLC1854B7GnrKSLp9eZw8wsqqGP8reagTWUmjtTUAcAzh1D/soJo3wQQztfDCjGB1uYnCO/KY4ZbCPI5Abv488EqiCmc/Ljk/P8dsyV/7GiEK00mWsEJ9QV5iLt6IwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765270814; c=relaxed/simple;
	bh=epDzpJaC0kIlgC9TA040OsDbzt5g3cUfjj2MoVX4oOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iRP3Aeq4LGZzDbD8Mt5mbGsxLlbfd1kfDgRvqvhSLHoUofZViYQflQlWtOcAotllWusMaPyCnnF0pwTfbrFPkayBqPrT18vC4KBXDrRy1bHyD9jnCuQpk5VD9m86o3M0wSCijCflT6vCDSy8u5MOZMEmzn1SXDlUyNv2HeV/8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4KigoNH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so6068726b3a.1
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 01:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765270811; x=1765875611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HbH4EuzhAJD5LMzglUJe49YvZPtTt4GT06nkKNw9fJk=;
        b=I4KigoNHJIe+JfYMbaSer7airfyyatSFFwUyms6ubKgvZevQ3g4JtAKyRyD/tfHMQv
         amFmcJebpWfegAMvg3rq00aPNYHhvnoOGd2uZq7fzkMVXQyW25nwOL6fvEltyV/Imw+K
         xCTYQzvdSf8pX78Vme6mUC0o+sKFC01rQUKkaWt418fzrClLHuN2yedZ9VgR5jbpQY5u
         77YM4QU8Ct4oyNDWYlIArLZw23tZ/cqWjzwnBMuw/plvluDNbt5bjWijiwfGDB9cbz/t
         nRSuY4quRMHnRC4tk1d6m5VXQ7IP6fUy6tVfxq4X0HxU87KdKR7NlPKJYiTUs/5DB3oJ
         CUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765270811; x=1765875611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbH4EuzhAJD5LMzglUJe49YvZPtTt4GT06nkKNw9fJk=;
        b=XvT6FyuqtxYRMCscXAlROOcTuuJxTbmdm8rxUEiM9hgSdOztjpR0FGTpAv9OgO6/OM
         Ho2ob7vceFL+zD4UbfuayMstU2lddw0JosaIzATaNmsAX7wh88tdUazKu8KtMSttq1K1
         awkw7U2305yFasSKSLv977sfeROC39RmLial5DP7MUXQlEyOsU0382zeMkE+eRtUKyNX
         NCveOuU4CSoLjt0U8Z/NaxvesRN+7XRgoFHoYAvpS8taiHqAvBihxEi045/m6mq17uq+
         r+fzKpCjkXzEb1CjJ3XtzpJZJXQO5qrKijadE5j9Zy2iK6HjX07eo/Pg3af85bLRk9nh
         pN1A==
X-Forwarded-Encrypted: i=1; AJvYcCWmrGRfgIkDt7uvBtpEAau44cZ8IEZ1iA9I22HmbTAjACYWeV/na2725nX3+4B4njd1mdLzFig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4Y8yomsQ8NKWXDdlbeY07ct2QEQBOkXu1IaS9DyOrYinUqp+
	YrbtsD/O8ecJ67/o0QQfcteRwAiMp3QQsMWfGcvNVrRkdne2/i8CLH3o
X-Gm-Gg: ASbGncsr2B89yVW+idx7x3Fmdh9DFIK8qAKxbXrXbe3MWiiUHC+9tcjOye0EEyAxGuG
	rZ01xdOWdg1E25BHIDVeqeG09ryEiQAheqKedSgkfShgqJtoCsjZilgXLnSSI03y7lz8FMPnRoQ
	se5OoPATjg6n3rlmET+mdgkCKJhwMcyL/akDzkzLXNoSXPnDIz+pjPUDq87sdg46Lk7fYz23AKE
	lTrUHOniPiUV0OcCkiC5teuqnOKUXahpC4M8LOTH28pP7iYur1b3rsiDdbSTz2tFvCrsbwzrX8a
	N7TQaMWKxVX8KBnb809LkKj1XAN58m+tlAPIPHT4JB56fnJAll1PRNbJwHkL8giVpgxO7iVO4kE
	A90ia19RAK0K54CuhgOWnfR1whF4mEIfUo6JoNNxA9cnE9fvGfDLyW9HtHRVuOqZyMvJbSNP0RB
	c5iKP+mAXCAY0QYuw8IoKJfV3X/PBQkOj5BF7FvFlUq4AiLodNV8yR6c/xCQ==
X-Google-Smtp-Source: AGHT+IELImggGpczVDmXVc6H21DKcAc/fDQH57HKydbvBHbvUF8y0P+L1Qncty5ki2h43Lq6lJWfwA==
X-Received: by 2002:a05:6a00:18a2:b0:7e8:450c:61ce with SMTP id d2e1a72fcca58-7e8c63bbfe6mr10197623b3a.62.1765270811096;
        Tue, 09 Dec 2025 01:00:11 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ee0b3sm15529015b3a.7.2025.12.09.01.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 01:00:10 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next v1 0/2] xsk: introduce pre-allocated memory per xsk CQ
Date: Tue,  9 Dec 2025 16:59:48 +0800
Message-Id: <20251209085950.96231-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This series was made based on the previous work[1] to fix the issue
without causing too much performance impact through adding a
pre-allocated memory for each xsk.

[1]: commit 30f241fcf52a ("xsk: Fix immature cq descriptor production")

Jason Xing (2):
  xsk: introduce local_cq for each af_xdp socket
  xsk: introduce a dedicated local completion queue for each xsk

 include/net/xdp_sock.h |   8 ++
 net/xdp/xsk.c          | 202 ++++++++++++++++++++---------------------
 2 files changed, 105 insertions(+), 105 deletions(-)

-- 
2.41.3


