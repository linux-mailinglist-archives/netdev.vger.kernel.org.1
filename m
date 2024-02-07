Return-Path: <netdev+bounces-69995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6C584D345
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E72283018
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2FC1EB49;
	Wed,  7 Feb 2024 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="bIg1ImWE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FCB1EEEA
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339250; cv=none; b=pjoCRaMQQrFJJNBk+bh/l9SLS9tmwvxG/ZPwyHuSIqpIzZ+HPw9f7P2oD0OanQ8SPF4XBHacFG6TrvD2EIb3JHoJosBU0ORu8He/ONRWnlX2wfZ4hj+bjrMi1MzBrIg4rFEYtobGssFK7Kx+ktdRr1e5ANSSiIprCDnOz5tezZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339250; c=relaxed/simple;
	bh=/tHg3hE+JMwP8vcHHwSHrJo7aTggDGfw3pi9mEqHoOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cfj1M+l2g9Wef3tpLD/es6VJ3muGBHRu05RC16UjbSXDm9av/74aQ+HSj7w2zISQWzgbCToQNmbgG5WDl4CKLLjkDHgEdjkMxHnvKmfCkwsSUwpR/raQSF+9PNCFHmmOogi+vX7YP4Gmwc0y4j8+y/3eo238S6NcTqTOcVf6AzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=bIg1ImWE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da9c834646so891237b3a.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 12:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707339248; x=1707944048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3WTXOcxteMnivPm7J58sOmvqk9jfrFAh2RmYy5/6X44=;
        b=bIg1ImWER/p45vKPYjyXyvqQKpDKo4meRn0q0v6fTsRmjhvdA58QE+mE78OhwyKgmY
         9xuGDpzaFCjqL16qVQhQW9Jqig+Tv8ORDUW9tANxhCFjOD7hcLWrnMrNgq5f4rka0dA4
         xGOld5t8h5VEb1UVaoJbmt252mnPOZSjPH7hvHgkNV7THcoeZyi0+ooXPVTatmafT1Dk
         DMupea1a3BJ+DAzQa2lyBxhlaVzfLcuLI63mJ0WPhloD6errc9AfOL0zdLa0fYjxtQgc
         4XRRNOo0apB8T6TlLzJfz3kcAJucc7xQsZJWf3b0gSGki4TFN1/qA09TA8TTzi+uiCWn
         kA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707339248; x=1707944048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WTXOcxteMnivPm7J58sOmvqk9jfrFAh2RmYy5/6X44=;
        b=xJ5E8nhBGffV498eqtzaJGTBp+6PChauGJcctM32KD0cl00znAoEDXx0QnPGqn4IcF
         Y6t8arAu1tlQh5EgDX6tVmnJ2A/MFcQN5qSqkgQHOmp4d2Ud+p/VJBH2Kjy9zwBPHCQm
         hnr12v7exkSfV/hxlexHcnvkGiSzS87AbVUzk+06ewvJnV2o1hw/1jx/9w/IDDU2gw/s
         F2L/AT94IQvmwLSPdY0BB9DD+LCShVH2jFMo6qiyGICqn7E2XafIIGlyeqBE/Y2ZPIcJ
         isH9KCcV+CYv31ZMWlFbzuq36TxHycGpgQcXuas3W0XJYPwQOsR96gD14LSSW1IQ7etI
         zi/w==
X-Gm-Message-State: AOJu0YzvavTVuSHG9833mEUSik/5G7ap/ebc9Bl44/4Tz3w503zSysb3
	36RRyoaI7rW/Q3Qb8l3sCoPp+Rk+44NRNOu3dsoFrZuXq8INqpDrwvctSht3HbO7jrWO9TIpUIg
	=
X-Google-Smtp-Source: AGHT+IHQj2jcSkcFODKacFi/gr3kBRy6j/tKTUMj8G0Nx9UN0OcM5SX76gfkzlide+PqakqE6bdKAA==
X-Received: by 2002:a05:6a00:1254:b0:6de:3521:b3c2 with SMTP id u20-20020a056a00125400b006de3521b3c2mr4366175pfi.11.1707339248241;
        Wed, 07 Feb 2024 12:54:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBeWJmQWPYuWmirxuQS0FActPdBD64zJw8cLmB2pB89mUftA/CXDp8hl0Iw7Kwy8v5ax+NlAH/JSYRkTzA7VusKYMZ7tLUizkFmJRWP3+3UMLycYjOe8f5emiObzJ7j3TC5lyLFhEtqcs7KzHoxeAn3ls2nyI879OPx78/6Le3/j1Xu+tblYMJvMDq/j4iUjk0xhi6tWxXE98eGfiVPNMMD3os4xp/uIxmwZxQyA3aaGma+fDHXEHtBRGQhYnBqu4VVHadtf7Nwp8X9nNk620PtwMxlk94J28=
Received: from localhost.localdomain ([2804:7f1:e2c1:c110:4997:fa3c:54c0:a69b])
        by smtp.gmail.com with ESMTPSA id c22-20020aa78816000000b006dbda7bcf3csm2086273pfo.83.2024.02.07.12.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 12:54:07 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: kernel@mojatatu.com,
	pctammela@mojatatu.com
Subject: [PATCH net] net/sched: act_mirred: Don't zero blockid when netns is going down
Date: Wed,  7 Feb 2024 17:53:35 -0300
Message-ID: <20240207205335.1465818-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While testing tdc with parallel tests for mirred to block we caught an
intermittent bug. The blockid was being zeroed out when a parallel net
namespace was going down and, thus, giving us an incorrect blockid value(0)
whenever we tried to dump the mirred action. Since we don't increment the
block refcount in the control path (and only use the ID), we don't need to
zero the blockid field whenever the net namespace is going down.

Fixes: 42f39036cda8 ("net/sched: act_mirred: Allow mirred to block")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_mirred.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 93a96e9d8d90..6f4bb1c8ce7b 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -533,8 +533,6 @@ static int mirred_device_event(struct notifier_block *unused,
 				 * net_device are already rcu protected.
 				 */
 				RCU_INIT_POINTER(m->tcfm_dev, NULL);
-			} else if (m->tcfm_blockid) {
-				m->tcfm_blockid = 0;
 			}
 			spin_unlock_bh(&m->tcf_lock);
 		}
-- 
2.34.1


