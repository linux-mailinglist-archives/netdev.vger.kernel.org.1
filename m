Return-Path: <netdev+bounces-202648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F13EDAEE79C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75EE1BC26D9
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B232E54D7;
	Mon, 30 Jun 2025 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QaNZwgCd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0487E289833
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312204; cv=none; b=QqV7gH/+POJ3dsxdFnhNudPB+moOu0kcPySiJ+Od6GhkESPTKIGFDsHtZaqMpIft0DAw4GJF/oRMK+pKXGggVbgGXqFOYcK1eKbD9KYXW/COGuiCLFGduj5e/gCZ/F/bRR2siLKiJ4WV70kLjjqTAojaxE5gsHUhyfxlIeNRqt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312204; c=relaxed/simple;
	bh=PIZPJ7i63i8C0TC1GjtbhrzgGNXE4XRxULt5H9rtUVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PvzcUUYG7BlAlCI3ygnZTUKi2HOMl69q8ZubKHINWexqJiWgsPuzdzguwKBCvOEnDVXV27yLcXgfvyN677qJS+6q3YJ2ajl7il4fmNxWqMr50L4TfROwHZWA+bzWX/rZEiS3ISHqh/kJjbCMm5Y3cZVyGneTtKYoEcyLxHQ2YfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QaNZwgCd; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-606668f8d51so2552114eaf.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751312202; x=1751917002; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFs3jWGVmRQiCPCz55IrWTyhhJse2uDEsntELmdGZSw=;
        b=QaNZwgCd8LTUrRGOqXQg/AzG2jvyTlkvLpxZ+mvKqDxX62j4L9xJTbvtYLSkhGld0K
         Pjj4/ECsMfArbItgVOIoTW6iIZBrJzSp+DVSNVKM6bO27ASyD4bkn9J49/bbxKTs622F
         jegbtqUWdwJG8XdDuatbQnBbUSrjMClsx/5nEGRgBc81Pehz+ObYpe5u6gOhI+FVVEBP
         TRx4jqecbqbQ5C8S4+RFMU7g5TftSyL2TPI7hJI5jO431XJaRQd6e/HXQxcbF+Vk7l39
         EnZ22C8TogGRkyRxF196sflQOLXOM+6ONzJlBuHOlckX2MujDWfjIMgzmg+bISUj1nS+
         nv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751312202; x=1751917002;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFs3jWGVmRQiCPCz55IrWTyhhJse2uDEsntELmdGZSw=;
        b=GUShAsAlYyjemXOHYs/HO7sORlNcX2lux9CQ8NVut2elfrbWigMhbQNB3+5Q7QbjbZ
         kRFAKjDn2BOBVSaYW/AI8uSqOv28BFcPCNpeZ1pZGaxvqH82eH4h3ct+8JNATRLMcC1t
         uSp7QC58sp90TC7VArbz0g07FrNvnBwLbUh0ujhhRdpijoa+3qr8uz7uc+/3KJxBulWt
         Ip8J4G+sFtf9ENmC8v7ed3er9oikxZldGZ5mwoBUgDYpv5PJU6jycKBGnAYqVDPIbsf/
         nKshI8hrN/7hIIgY1fJ1U3EDRLA1uFi7LEejrdAM6gN6TjIfMV3wDzRAquz6rCvRSdAb
         JjGA==
X-Forwarded-Encrypted: i=1; AJvYcCX+1hWlPMkTmW3XgnO6D/mOjdXJZ8efRG1t8WX/z/Q/v656qbVfwWZ6VQ/lT0/bFaFz1NsVzIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImrcaihowS0FAhiAoIVXl88tZMH4uRS92vXKA6OzzhuD5wQNX
	UZ1RL+0a/kvwg1f7GHcxKwzEC3Ir7niiIdpMjo3Z6FywHBIjN2MiEdFUkm4C+MRiQrg=
X-Gm-Gg: ASbGncthayIcYM395/myU5C/mX7XqSf55Ny06vBeQ0w26zKaUsGLx8C2ILlL1Lt2lpA
	+VGXP/ApDK04FQp8y4y86TMVROGcQAtRnfn+Hbo1krPvIQ+nE1EJIjCzPyCWUKehnIf8rNQDvXd
	2ycTqrqwcRCr8wxEtNiNahka2rEyO9C27fZpxH7IzJJCHBZCUXscJ6Iu8rO5UWjYra/PImWptcp
	ivESklzVlDnQtfHC+ti5FTR+PjMWDZYrkIgv5Z2hC7szVgYWOnPQHkqTZ9SJW6bQx/FgAzfhXvV
	HutEDQ+kZl5RfjUQzFmYMtuC0FGmTR++odGzeybP11MF48RqrIFIoNASRhbt+dgSL3H5+GjQ9Ty
	csS0=
X-Google-Smtp-Source: AGHT+IHjOIaQTv70hTn6APt2/cC+UCDsl698/+NS7It4EICnrQ1NcFfOWmmAvQSJbsGHKSZ8d4JqzQ==
X-Received: by 2002:a4a:ee04:0:b0:611:3e54:8d0a with SMTP id 006d021491bc7-611f389e302mr585444eaf.1.1751312202009;
        Mon, 30 Jun 2025 12:36:42 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:49cc:1768:3819:b67])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-611b848d86bsm1176542eaf.13.2025.06.30.12.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:36:41 -0700 (PDT)
Date: Mon, 30 Jun 2025 14:36:40 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiri Pirko <jiri@resnulli.us>, Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ido Schimmel <idosch@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] lib: test_objagg: Set error message in
 check_expect_hints_stats()
Message-ID: <8548f423-2e3b-4bb7-b816-5041de2762aa@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that the error message isn't set in the caller:

    lib/test_objagg.c:923 test_hints_case2()
    error: uninitialized symbol 'errmsg'.

This static checker warning only showed up after a recent refactoring
but the bug dates back to when the code was originally added.  This
likely doesn't affect anything in real life.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202506281403.DsuyHFTZ-lkp@intel.com/
Fixes: 0a020d416d0a ("lib: introduce initial implementation of object aggregation manager")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 lib/test_objagg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/test_objagg.c b/lib/test_objagg.c
index a67b8ef5c5be..ce5c4c36a084 100644
--- a/lib/test_objagg.c
+++ b/lib/test_objagg.c
@@ -899,8 +899,10 @@ static int check_expect_hints_stats(struct objagg_hints *objagg_hints,
 	int err;
 
 	stats = objagg_hints_stats_get(objagg_hints);
-	if (IS_ERR(stats))
+	if (IS_ERR(stats)) {
+		*errmsg = "objagg_hints_stats_get() failed.";
 		return PTR_ERR(stats);
+	}
 	err = __check_expect_stats(stats, expect_stats, errmsg);
 	objagg_stats_put(stats);
 	return err;
-- 
2.47.2


