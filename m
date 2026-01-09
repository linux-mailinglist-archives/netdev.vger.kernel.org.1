Return-Path: <netdev+bounces-248612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B04D0C48D
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 22:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 229BA3009D4F
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363FC2ED846;
	Fri,  9 Jan 2026 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt0ELQxc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655F4315F
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993602; cv=none; b=VVY+u1cTzqF0Z3jOfoT8pZiqMj1/6c6VP56fOoMF5vYkN1P9i8IRFcTVT2CTjh9S+98OHsEFaYGdtSbr1zZOcz+cSYr/xLuwxFeEBEvvQe0a+zbQomC+MxrWcekI+bTsX0pqJ0lMms28M1pXT1IxIDOFsWpCP4cwALocIbJCzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993602; c=relaxed/simple;
	bh=Keh8/wLkPjuIFsQpRgZCfp4ZJyx7wqjtW0Jo9H9Wq/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dcynYI/eLM5r6iA1Wshj+hlROGIdWVWZ0nhD0Q6sxtlWs5k1IZY36ghEhrAVlgvfL3tNAVLHdVFsuwmeLR0h+FWKakmGoy/nc/fBys76b+FrHMuPh4AK8cpMyOoRotuGBAQ6aKg8sxUiU5m1Rns+a8BESs54zB+nwE9Jr3n805E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt0ELQxc; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5636f0cf5c3so441519e0c.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 13:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767993600; x=1768598400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UHTvqu+YkutNQHzeS1Yr8MBlQu521tKvbncrgZNFtME=;
        b=gt0ELQxczY99lSnLJzE6z0RPgXojdioG3214w6U+DbbPbm9G1FGv935LVbv9gkNZlN
         zxVP2ry/6V/wKzw6PRvIzudASHSOTec9VswmNPDgJwaU+gZJBnZBqMKiPXSIKIalznJ6
         1ZSpQZD7v6VHY1n/M/aIhh6JeLq591WWMWu9LQkBs/di1QQjYhpvcYQYmem1uPxxhKWz
         q3r4auCprCCUfO4J/GepWHhLa+AiXY0xDN5QKlJR+m4YTVZUTJbtW6zFJwNzqxwfRyyr
         5Ae1to2NCVJ4tiRdylFNEzIFJMo1vVYcmthYKgoBUy3zqHuz0MLvsHNCeQCOaGXSYFrR
         ZNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767993600; x=1768598400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHTvqu+YkutNQHzeS1Yr8MBlQu521tKvbncrgZNFtME=;
        b=hcyCet/n/LFAXAuSb4jRjfanrR974vXNrmTXO4Gm8iH/90YzEl9URpgkhWZEJVXdqg
         KM4U2LhlpvEItag/iO8/F22F3Kmak8tVGJyCKXPwjrsM9TW4fsG6yBVVPYM7/HDdVy0i
         qkGp14t7N+lPRNCC83Rz0o2Pm2qehdkNS82pkwZwx7UUYwwxzOx2xKsc2p4IDDlVi06o
         f0BdJuRVNba8JssRdSJ1b3h49saJohHv3lG/ekjJNwWIbF5+3fZ/wfSxSBMF+wf2srPz
         ndFQOvwdDOsTMF5gdRXIYBV4gCXBOaQ4OFdQ2ZFh0RxjYkHFAI6X0mOkJaeV8yWlIHkq
         InpA==
X-Forwarded-Encrypted: i=1; AJvYcCVzVmXbF7Lv0BHZBSf29ScfRvSqhc8swW/wsJVqqTAl9nk4ow9/K3iAhh/+x7d7BVzjXuX6E0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsLm2Jon6DRlQf8aKoNFYDT2j9qdq3B4vFLCzQgR74SRwo7NE
	g0a+8CTVnlB6QtrMByK90BOPJmhRSSZwrh0FhijRaNFDfHdfJXHFMUgI
X-Gm-Gg: AY/fxX7mjh4bEnO4ItN7f05Fw1+qYiyb7XjtFxpePsYh0Ysw/WGQsW2Ofjd64q/A/4R
	bMZXROhXUTaP6MmVrV/N/UacP2avwEr7dWpOVjq7aGU02CfafnTuuT4xmAPwH4UPaQYXPpyWlha
	5N4y19dfpI3l4y6lJzXWuFG6V/ZOBb5TsG2b2om7qK6jDotu8ZkEiEPq5y2r9yfKFJsVsjbENG9
	O70g7Ur/OBtKCQm3wFjChf9TfGkJIJuAvRfbjyJvytUNy9SyMUTvxDgzsvERdOrQBLjTP8yKMaX
	Kyhq2l62Acq2cSC39yjJCbuMYdoSY+t4+nvWlbOzYNCka3UDLmkaEiLdxoXBNvnI7yunkeP5uUz
	+zxxo8RGf4lDM8T/WTyeJhdzbwEZizeib2LHz8StAeTViDxM5v4BGnu7AFRkk6KnXfoc44EXiTl
	/X04dMcWh+3F6fHyP94P3nbRYtlgmLGpR6U5wwefkwqcHmPqrmbRixobsQRpgj6hDkqCFTOBSLs
	os6YQ==
X-Google-Smtp-Source: AGHT+IEvBK7U7IYllotOCwtJvH/1foan5XHxTgks2D780rhblSmxmqd7ZL0bY7xhJskhy2TuvTjkDQ==
X-Received: by 2002:a05:6122:322b:b0:55b:305b:4e41 with SMTP id 71dfb90a1353d-5634800fd9dmr4637269e0c.18.1767993599713;
        Fri, 09 Jan 2026 13:19:59 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a20a183sm10259956e0c.9.2026.01.09.13.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 13:19:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-01-09
Date: Fri,  9 Jan 2026 16:19:49 -0500
Message-ID: <20260109211949.236218-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 872ac785e7680dac9ec7f8c5ccd4f667f49d6997:

  ipv4: ip_tunnel: spread netdev_lockdep_set_classes() (2026-01-08 18:02:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-01-09

for you to fetch changes up to ab749bfe6a1fc233213f2d00facea5233139d509:

  Bluetooth: hci_sync: enable PA Sync Lost event (2026-01-09 16:03:57 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: enable PA Sync Lost event

----------------------------------------------------------------
Yang Li (1):
      Bluetooth: hci_sync: enable PA Sync Lost event

 net/bluetooth/hci_sync.c | 1 +
 1 file changed, 1 insertion(+)

