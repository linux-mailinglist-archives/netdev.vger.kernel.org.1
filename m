Return-Path: <netdev+bounces-231004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ECABF3B6C
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 23:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F16189FD8A
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 21:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E04033375C;
	Mon, 20 Oct 2025 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox8MuBC0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB62E2EF2
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995422; cv=none; b=EpUlkczc1e1CGmMUC317KFb0cdajEQaFvk5O/ZmxZrRwL1rSsTUqYC7YSA9Og4hNxK1A+uX6PrVTqFev22Vy0L2e+qjLRHe3uemfTABxyRfA2x5TftlBt+Qbp/AIX7iAWG3WWODvqE6dS9eCooYctp3JnKxFhe3YQEbELEFHgFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995422; c=relaxed/simple;
	bh=y5iA1ikAfECkZaM2ppLR4s9T7RFPAKZ2pa2tj+ftPvI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i+vWPNEdmPdqnqWG35g7u3bWx6uCy7hjv/Z6/XLei2GCXtWeOXkesvuRArMbveRLMGB/9Zu2cA0eku0Y2xkPQkuTpSP4qsYLf799qhFAecaYta07gMaUsUY3/EEoQrepyFLQiLmnZPq92FdZVYemvdy8jJGAyAGmkCO9ROYIMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox8MuBC0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47107a9928cso2287205e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760995419; x=1761600219; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlAkTWKCIa+XIp6VLDBKo4NPyS8c7l95XK4IrTHifyg=;
        b=Ox8MuBC0KOwcaEsNmQBD+4nEgv4AhJpoM4nmlrtl6neK04/PLZ65CIT5StgD0hpmnG
         Y4UP73CDQPMrXiWx609ODUQt3tg38M0HEA6RWmf5lGXz0iFRfe6Lw3vX2pFh6QFFFdxF
         H91G3u2Rjt40qut+r64vIpsRyYHOVN2TrVkpz8UqgfyFBJXulVshS56wVlpr3BCH/MOh
         5rkQX8s9U85r99bHefZw2jvepzxD4ijWnZ3I6MmBfdOAvQbUb6SHgJPZxP72G6PIc1hH
         mB7mHs9QJ5hzuj/C6iUwffjm7TKCLX5B/gArFQIo92F90nUGh3HfzYw6D2sF9gRt3AZe
         ofow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995419; x=1761600219;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlAkTWKCIa+XIp6VLDBKo4NPyS8c7l95XK4IrTHifyg=;
        b=a6s36DfS0IwIrqISwmtNnKiuvhkSbf4eotY0IaGiDlxqoVH+tsowbghdhkYlcniTeH
         FdNVPHa1gi9d0HI9tSgGgrMdxtKmnp0avum/xZTPfqGQm1XrnwE0Xowv19UXOwq3WzQd
         8paqA8K81k+20GjiRMhYoBF/SRoUMbaxNYSOp/a2AeYbZlVjBUjeEX0CaU6A/FFzYJ1w
         9iq/R86doeKlsyJS0j1VP55K6D/BHvesK+m/m3mrEv92aTuwtfueZXQd5Hd8PzzenDQm
         7JzkoRGoRuSM/nQ2FoXjpv/n2kaShUTcQ9JYm5yoM8pNRFkEZFtVee4yfyWVzJYau1JM
         /Gsw==
X-Forwarded-Encrypted: i=1; AJvYcCUIwFeU6wjNbP/GMj2v72s/xhikAown1yMDu7857saefJ8WfeDm8adwTUMl+hkzIfoeZWE0q3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/O62WXgns7ZukY8ai+C8myuyQomhQSruTT3C+QzE61a4ASFy
	eNdIBqelUfripdztrLv4HH/+U4zgYALVUa1rsaW3L8xEpMgR3Uv6Vk6U
X-Gm-Gg: ASbGncsFKg1lN3r8D3EIHSsQz/ywuGRYANorFktQjysCB+nDdg6t7jeELngqkv5zXnZ
	gvTEGEGrX/9875/KMkUZ72jMtFV9d3N7AEmGcdoTjBN4o6VpwIyaQ468jgP8keNWiTmjG+dm6c6
	3iPbajHhJ4tPW+ufgDH6OCvq5bHOBrWLnC6pCQ0kUJZMmBxfXoJz7G/2ertpAiEzw25NmtIte1z
	GrTYfhBsZRA52v/ulam1B1LVVSgmH5UXZhs/btw0c+Y+IZyMbB16IaDhaZV6BOvaF7QtQrSHiey
	ZaSjHBnNKxRVxTcacZGe9RD3BQ3vrh0aIuLWYDsv4LcXGJL36Aqrfhl2j1YuB2EgyoMrkPITAkl
	EayUMhCdBC1W6gyOkoM0e7xTTJDVrhIX1Rts5QOmqAfr0gVgmUOBFAjLmZdjUNlnlTDQE1mgJWw
	D3pFR0Zzl47TfYugk=
X-Google-Smtp-Source: AGHT+IG4VUh+DekCe6fz1qa1aR1wOBnEoKj+UFnhE8TaOTa2kaGZxEVHuJSeXnaK5aUGhEBMYpvZiQ==
X-Received: by 2002:a05:600c:154f:b0:46e:46de:ebdb with SMTP id 5b1f17b1804b1-474943c0ffbmr4677865e9.7.1760995419100;
        Mon, 20 Oct 2025 14:23:39 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9fdfsm16901776f8f.40.2025.10.20.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:23:37 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net 0/2] netconsole: Fix userdata race condition
Date: Mon, 20 Oct 2025 14:22:33 -0700
Message-Id: <20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABmo9mgC/x2MUQqAIBAFrxL7nWCWBV0l+jBbayE03IhAuntLf
 294zBRgzIQMY1Ug401MKQo0dQV+d3FDRaswGG1so41WES+fIqcDVaBHZedldL0N7bDYAR2IeWa
 U769OIALM7/sB3/8sumoAAAA=
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Matthew Wood <thepacketgeek@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

This series fixes a race condition in netconsole's userdata handling
where concurrent message transmission could read partially updated
userdata fields, resulting in corrupted netconsole output.

The first patch adds a selftest that reproduces the race condition by
continuously sending messages while rapidly changing userdata values,
detecting any torn reads in the output.

The second patch fixes the issue by ensuring update_userdata() holds
the target_list_lock while updating both extradata_complete and
userdata_length, preventing readers from seeing inconsistent state.

This targets net tree as it fixes a bug introduced in commit df03f830d099
("net: netconsole: cache userdata formatted string in netconsole_target").

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Gustavo Luiz Duarte (2):
      selftests: netconsole: Add race condition test for userdata corruption
      netconsole: Fix race condition in between reader and writer of userdata

 drivers/net/netconsole.c                           |  5 ++
 .../selftests/drivers/net/netcons_race_userdata.sh | 87 ++++++++++++++++++++++
 2 files changed, 92 insertions(+)
---
base-commit: ffff5c8fc2af2218a3332b3d5b97654599d50cde
change-id: 20251020-netconsole-fix-race-f465f37b57ea

Best regards,
-- 
Gustavo Luiz Duarte <gustavold@gmail.com>


