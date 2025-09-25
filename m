Return-Path: <netdev+bounces-226518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF23BA167B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 22:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4932D3A6F66
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C64132128D;
	Thu, 25 Sep 2025 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1XZ+xQH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CB532126D
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833120; cv=none; b=euFe+Btk/y7g+sSQvbs8mXFJL6tos5qiSItoFgD0VwaOyXr3aoT3DRVypcRfB5JA+/A+v+OEd009tkeXMItKDGUuF4vkAJNK5tAADoasG3SjYE0VmzLcPztBAxCO6/YnEzfixSi6LCUaHxVE/YChLzWC51uODdm5rFsnfW2ThsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833120; c=relaxed/simple;
	bh=Ru0U+UR4TDnU4YEoC4bgh7/N8KX36OuOCEfHwKRdWLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEE4PpL98eGOFc+w24KDkQ0q5KYTUgT/MlmLPF5tJNig6qNa/dhm/hjzlpiwUfrt9mZ+BzfmXjGDBrC9yH0LJ/LvHRzehU1SkxbeWTD538mS8yFWXapwYBmDgoCjqNIiB0sw7C0H2RNPal4nGi70XnizkPYieBvuIiMQy/YUyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1XZ+xQH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781001e3846so1400545b3a.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758833118; x=1759437918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3eDhSQL/LKEOp5/PaHTtO2MouZaE3+HdZOo9nr4tRw8=;
        b=A1XZ+xQHdxJBef1PoAnWGxFrbUQn0d7bpnBx8nQ9EoGcG4AvVPZBheFTHlV/BG8Yal
         bU15BYAQKUqkM2ww2GWfXF3QrXMh1l47yImEzghZBB7qoBfEW8O13LrAgoHKEdb3Ict3
         Gj8PqM2ATXntQPp1nzARIjo6iHO2vX+hnXvIhDw39gVYPJbZg76gUgJdnQW40Zi7Kd7S
         MxWfT2OO6ki//xxicMX4e9zT3TXH8VTtrziUkJsAIiJ4VsNIaB1OeMT+vx9do8moxFij
         6cWUygD/zNqEho5rj9xcfruudU0PtQmeDzPhhu14UJgwoHHsln+CME2bhPTLBgexwoxh
         12sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833118; x=1759437918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eDhSQL/LKEOp5/PaHTtO2MouZaE3+HdZOo9nr4tRw8=;
        b=wo7wveeI/gBPuSz0oQfZUzsoVQAsTdxLwcUjNZlprcGLKfO2+bX9ATBoMkAx+tZWok
         f59isR361xhYDwLb7FBKX3RfuD+3f44dD8DSOkkxlRXnOqI5NZ+QVCemTaPYmorggRNt
         2+hR349W4nqbak5d3iUFe+++7IiPP0NJvF0VVYdMx/ikT2s4G0YNFcJ8afZ8s3Gahoxz
         FfnpHgIfHsVDOrGgVRlTnSjUJCCmzAdmKzUFyYXPJEgRU6VEF11ATCzfoWhFo/ClBWAI
         KShf4omsk9qHu3GbCAkP3bhCR/tIUd+Dg+1WdVT5cF10T1Xg4czppFQ0JxHK0Mum8wYl
         A2RA==
X-Gm-Message-State: AOJu0YzMc4db5uJMcXaStqud6YqdqLDTsT/FHien6dXgKuY9mEN2LI8J
	TH9Jll47g0tECNmBP6ubNJGRLGNu7nn4iGfjq6p2Y9I+FmfEijcxkaaw
X-Gm-Gg: ASbGncvlhRh8E/AAlw4hnHy3+6TJOiNc9n+dxJ3o/0XaMeNxHyRdC/QskLhdVGbeC3T
	qkQKDPKl2EwW0e45eykMq9iSZtFfrfBhYekaVK0/qUoW9PahKEJ7hwuOOgNMxS3WfAk+9hvsErZ
	pGxhVzxsSb30yo4HOVN3JKJOmF+fqu/UAMza9gnhBxu+LThCn4QZHH8l10kQd6Z4GfPVUMGyJ5s
	NObLn0GQltseYE+/wxu009uAXnL4YDZNX2/yiJrVbE2Qfl+zih7Lf+BTC+2xhsZz9nWrPqNdVcr
	LHgL+eXoQC5Y48CSIAee4b0ItugD2Zhw9umXn5EpiH+knrX0+xaI1rgyMuYv4fHXtJi+nfS3i4g
	GcRtrFJCAD3IIllLo/Br2AM44CU+p7PV/nDrMaEA=
X-Google-Smtp-Source: AGHT+IHAMz5CMMWeR4tII30EjfIdX2VnbTPNJkIYi+47i3rAuGHIXnYdncaPKHzzQmFkMUxBtAQtoQ==
X-Received: by 2002:a05:6a20:7348:b0:262:52de:c576 with SMTP id adf61e73a8af0-2e7d3db5fcdmr6163922637.29.1758833118401;
        Thu, 25 Sep 2025 13:45:18 -0700 (PDT)
Received: from cortexauth ([2401:4900:889b:7045:558:5033:2b7a:fd84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239d99dsm2675456b3a.21.2025.09.25.13.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:45:17 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pwn9uin@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Subject: [PATCH net v2] atm: Fix the cleanup on alloc_mpc failure in atm_mpoa_mpoad_attach
Date: Fri, 26 Sep 2025 02:12:51 +0530
Message-ID: <20250925204251.232473-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a warning at `add_timer`, which is called from the
`atm_mpoa_mpoad_attach` function

The reason for warning is that in the first call to the ioctl, if
there is no MPOA client created yet (mpcs is the linked list for
these MPOA clients) we do a `mpc_timer_refresh` to arm the timer.
Later on, if the `alloc_mpc` fails (which on success will also
initialize mpcs if it's first MPOA client created) and we didn't
have any MPOA client yet, we return without the timer de-armed

If the same ioctl is called again, since we don't have any MPOA
clients yet we again arm the timer, which might already be left
armed by the previous call to this ioctl in which `alloc_mpc` failed

Hence, de-arm the timer in the event that `alloc_mpc` fails and we
don't have any other MPOA client (that is, `mpcs` is NULL)

Do a `timer_delete_sync` instead of `timer_delete`, since the timer
callback can arm it back again

This does not need to be done at the early return in case of
`mpc->mpoad_vcc`, or a control channel to MPOAD already exists.
The timer should remain there to periodically process caches

Reported-by: syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=07b635b9c111c566af8b
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
---
v2:
 - Improved commit message
 - Fix the faulty condition check to disarm the timer
 - Use `timer_delete_sync` instead to avoid re-arming of timer

v1:
 - Disarm the timer using `timer_delete` in case `alloc_mpc`
   fails`

 net/atm/mpc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index f6b447bba329..4f67ad1d6bef 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -804,7 +804,7 @@ static int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg)
 		/* This lets us now how our LECs are doing */
 		err = register_netdevice_notifier(&mpoa_notifier);
 		if (err < 0) {
-			timer_delete(&mpc_timer);
+			timer_delete_sync(&mpc_timer);
 			return err;
 		}
 	}
@@ -813,8 +813,10 @@ static int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg)
 	if (mpc == NULL) {
 		dprintk("allocating new mpc for itf %d\n", arg);
 		mpc = alloc_mpc();
-		if (mpc == NULL)
+		if (!mpcs) {
+			timer_delete_sync(&mpc_timer);
 			return -ENOMEM;
+		}
 		mpc->dev_num = arg;
 		mpc->dev = find_lec_by_itfnum(arg);
 					/* NULL if there was no lec */
-- 
2.51.0


