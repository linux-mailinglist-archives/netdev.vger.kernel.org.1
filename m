Return-Path: <netdev+bounces-168002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C95FA3D1D6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC527A41B4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34401E8837;
	Thu, 20 Feb 2025 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiXP+3jG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478001E5B6F;
	Thu, 20 Feb 2025 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035462; cv=none; b=J1rRsliVzHyJd1uY/JEtGNEZGh1E0W/7SdjwLzjtY+yUBGDkFmpkPk3McxpFmUBnReosvtYqXJjklvadMcBQNLngTr8AfZcvjn1g/4APFVS6RNeiR2cyk6zcKzfaUjToLTDPDgUDI6hqsmPUwjY0jy2ZZ2qVFfUusqLZlv+zOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035462; c=relaxed/simple;
	bh=XYXF8zRIP8DOqitvSbGR8LPQL/Tde+3rrDrirNd5LyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmgKGvpVrAs+7FpenZdT0HJYBkLD3UnPcDp4uYN+7cGhSyRNO3YId7KNRYSvwnlkccis7ric8+9AgSj4OD93zgEF2Mltu8/BASdCk1A8pt6oxQ8uLw/ulWiyxwPgTujCIlBW3WVc6hgHh1JtuoGfwoq1dr6q7qf/UCJI/Cy22Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiXP+3jG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22185cddbffso20798295ad.1;
        Wed, 19 Feb 2025 23:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740035460; x=1740640260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjrteS14+rIGkmlmoSem3GknyTnLu0IBn0cQP7SPAMQ=;
        b=QiXP+3jG1j4yZyWXpZ16cHGbxAMdZF7HKvRP4efgoY2AF45qCvkNoSDQU3EnyGVFQD
         mcndKzD5XbtSFIzuTSqJx8zw7eMyteEn6UcV/IFQ9z1+psEGH8duI+r0Ndoi8D+kmNkQ
         PVzWwdjOlQ4yzcL95Z1UeFWvZigsgKOJW/Tpql9bFFcSHOMQHu1RGph8nG1O5uBxnRqR
         kaYYtEfQtj69EGRL2hcM2fYLvF9N3FlOnMHN42t5/WYOreaTXi1SjiC2pUKovbvM+Fbd
         uq6zUzrfoIxi6SEtKkiqyDGGvdO+c2jOuiTdDDc57gj0dVU0/oY5tuS/O62epSf0J0I4
         XYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740035460; x=1740640260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjrteS14+rIGkmlmoSem3GknyTnLu0IBn0cQP7SPAMQ=;
        b=HCXMZ7ulclUP8j0IUXqS/i9uRD+mpQJNevvSgTZ5+1gg69GEECpYURF6hp7b6Fzyff
         5Ikoa9EWr0azCqX5ecJDcNInUmtWiObCbt0R+ifEiRXQ+lFpLNlXEthsr4Esj0deXoIo
         PfBg+AYKri1z5mV3qkOkEJjMAekAVgeK+/YeNp6lBh1MkJDmlHINWqORtAWnTkAVySmb
         LfVeCwf2MvgcS0PW8YSXR+2/4RLeLnlH+W33rpTPff47qTKekJaxqeLFlFKKiuLvLPVK
         wn7pHk8wXBxhyxELdJ+cCpN7F9QFCFzX8vz9ijjyijRD8eax4c2jnf6Dje9O7r5+A7hW
         bo3A==
X-Forwarded-Encrypted: i=1; AJvYcCUAtgWhnuyXZjuxZrxtDnLFVcYGtZ8lDy3Zb1FWTBS/dEp/O92WJ9ct611f7oEPdXGSAeHqg50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcMeC8GFZTELzuxlWC3MKzetZuG43cZbslGoQpx2J2soMVe1d4
	kyjvBYnDRLv9MQnD9ftZbPWhjJKrc+6+l4UiDgJLNmkRY0ssa2i7bL0zKnh0
X-Gm-Gg: ASbGncv0aoobScRgyWXJIHAJHOWB8BmVIqGoffcFwSH5vXL9fO0rnZKx0mQ5G5Qym5/
	wl9WYW9sTC0mbz8XVpUDh9wZEpr+71HUq/D1NJU9diWWbxh6mxVycuMHb9jjVXBSbQwPmbN9uuA
	FtqncK0bURulyJ+x2CaJzTu0cJR6iAZdiw6JF5deh7JdjFJe7T6ggn4bhwOG4JhZb8mhCl4QuJ+
	j/7tJwqVe/BJz8zm6JCRUH4bj7tozyXNHgebyrMk9yla2pCUHCQI9jKVoCYP23iA5M0s6TFtYbM
	EnnMNWGXkLnUwt8zhIcYQvv9YS9I3bxiIeGvLgf716G8DCUVC6D3TPRH7LrwexIBRPk=
X-Google-Smtp-Source: AGHT+IF/olItWHKnhk7VHLJaDwihB2R/tPG3XfOIUMtj0D3NS7sTlawx/IoM+5mlh8oTLjj4JuAQVw==
X-Received: by 2002:a05:6a20:7f8b:b0:1ee:d19c:45f9 with SMTP id adf61e73a8af0-1eee2f09d2dmr3516641637.19.1740035460239;
        Wed, 19 Feb 2025 23:11:00 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568af8sm13059672b3a.48.2025.02.19.23.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:10:59 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	arnd@arndb.de,
	jstultz@google.com,
	sboyd@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tgunders@redhat.com,
	me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: [PATCH v11 6/8] MAINTAINERS: rust: Add new sections for DELAY/SLEEP and TIMEKEEPING API
Date: Thu, 20 Feb 2025 16:06:08 +0900
Message-ID: <20250220070611.214262-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220070611.214262-1-fujita.tomonori@gmail.com>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new sections for DELAY/SLEEP and TIMEKEEPING abstractions
respectively. It was possible to include both abstractions in a single
section, but following precedent, two sections were created to
correspond with the entries for the C language APIs.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8d9e8187eb0..775ea845f011 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10355,6 +10355,13 @@ F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
 F:	tools/testing/selftests/timers/
 
+DELAY AND SLEEP API [RUST]
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+L:	rust-for-linux@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/time/delay.rs
+
 HIGH-SPEED SCC DRIVER FOR AX.25
 L:	linux-hams@vger.kernel.org
 S:	Orphan
@@ -23854,6 +23861,13 @@ F:	kernel/time/timekeeping*
 F:	kernel/time/time_test.c
 F:	tools/testing/selftests/timers/
 
+TIMEKEEPING API [RUST]
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+L:	rust-for-linux@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/time.rs
+
 TIPC NETWORK LAYER
 M:	Jon Maloy <jmaloy@redhat.com>
 L:	netdev@vger.kernel.org (core kernel code)
-- 
2.43.0


