Return-Path: <netdev+bounces-196504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F1AD50D0
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3052F177101
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2914265290;
	Wed, 11 Jun 2025 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5jUiS+x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A365264F89
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636206; cv=none; b=UFvfbw15wNtYm2jcmoN51H5t4YlaYtS+poQZAhDrE/sNNEN1XOETYqnUNXAZ62m/jOEnM/CM3O8QaH13uPjJjwshKGGUAzKhP5jz7HpuI8VlnwhV92KlklgLCpfYvlBXM8YThlnV4e+2JKUaeLz//C0TOY0vAx3Gtn1pdn/7UMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636206; c=relaxed/simple;
	bh=2jo8QWa/Ki7fu4LsMSRYrVQNMs+IQd8tPkZjlP+Mkew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HVGrLjOBtmhTz58e9NQfAEkOoZsabA0Fv/Mt0LQwGi8g5Vgh4PB38I1835OM4j4fPLZlIcCgrf7QQK+L0/35Mw/VJoublT5pVjCS6o48qEoTDC4YLtlHpMUUWeTI1Tll9aL+cY1Jo2GQetZVtvMPcn9+wKi+YTBagPBZwe5+hA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5jUiS+x; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2353a2bc210so56283215ad.2
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749636205; x=1750241005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uO0HDocWQrGpNJnG9ZFCm3Y7fIbFztwtrTDovEGEp0U=;
        b=l5jUiS+x1hL+QoOJgm3QcEgGx9OkGQMo/Jkc/MiIB7RMRqDC8HnlrRok45jeP00i78
         e4SIRuvH2Ge8RYjbHQKDOumKsXgQCaiFSFJj/tWikxBdqWU2cpBUsWns3hTfLiRz6T7R
         aFByCE7x0PJwK2048Aot2mfOSq+DORQd3nspLlSB7/LDNtd9rDM8iXil5YCJaqScUjP0
         6s0bju84YGk81eOfXil0EvNzDBU8E/I6S4lRuXvqr15UgqZKM0vW9oYCvvSMxtZLAfPE
         ZZKz45DIQ//0G1UHHlhCxbSKvjN7t+ZEDgglXuw/Jeamzr+vuRRat9AFC5GVotTiAfGm
         QwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749636205; x=1750241005;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uO0HDocWQrGpNJnG9ZFCm3Y7fIbFztwtrTDovEGEp0U=;
        b=obIQ2xenQuz1LLhycJQZYWFNiNCim2695dHx3AN0vtSpLL6ynRajhVCMI++crN40z9
         I36wkBX44nwrfxjcr85oTVTfD7r6jAwGDfoFDRah/nSFQriYoS8jbY3k+Pj08weutr3Y
         WIqqZ/mmo7DLlsS6Ab4cos5jJdiEXSCnwGv/+9eja7NTdsDWfXGsxSTWwnkGHEUJ+7zm
         aqNakI+8+AFY+e15jie+mGqbt/NOa/778jqTj2FsJ4i6j155nPRwgbdIzQ5jfJQGQqvC
         Yiyl404coA6gxC6Xtg51B7p8XTS2vCAoLdjUN0Fld8TChzkqj5ZUq9Q7i2ys3uFErMgW
         CzdA==
X-Gm-Message-State: AOJu0YysdBYH4+shqGeKJOtGzZS0Ktsw5UsAKf6TR2wDeLmeZSjMb/ff
	Uye43kNkU/mESRIYf/E3EOCQM6A7NfDAPKzTAUqAkC/+gPf93bCn0i28
X-Gm-Gg: ASbGncugeArTFuJ4Mynw4rrXVuyMZp9TqTUdqy3U7cd900SVl6X4jC7jpvXvHWjaMMg
	VWgUkVgIvgNZIvzbCo74nKms84i6KzxL0oxyOm95pjks5t4PozY8uoKhZ27dTKPtb/V279sDl7U
	UFoug4iUAaKxPXoNTdOwDqpcbWPwVld6nc2UR2QlnMcPBhdPWj1lT4gDUbjuVlgraTKnWbKVx4+
	cCw3luURijLxpHYsXy/2vLZcCGQTjM94XFjmi8LwYU6x3oZouEWxDbzswc1rRWlOKLtls7y1/4l
	eMvq4Dc5vGnG2nnBZ++puQ+K5V/sjj44g6a3L9hYoUYtZhfB5AsD5oXZXOpjUyHz3H9VZLNquum
	iAY/uek+ZFYyX
X-Google-Smtp-Source: AGHT+IHQqRyvN0tIvHjsnc5F6meBEOcVseyzjBfnN9orMbJLqXHkQJUapzuy7RpyKPSVvzzoYGjCQA==
X-Received: by 2002:a17:903:244a:b0:234:986c:66e0 with SMTP id d9443c01a7336-236425fe59cmr33239025ad.4.1749636204550;
        Wed, 11 Jun 2025 03:03:24 -0700 (PDT)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2360309266bsm84036595ad.74.2025.06.11.03.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:03:24 -0700 (PDT)
Date: Wed, 11 Jun 2025 06:03:19 -0400
From: Hyunwoo Kim <imv4bel@gmail.com>
To: vinicius.gomes@intel.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: [PATCH] net/sched: fix use-after-free in taprio_dev_notifier
Message-ID: <aElUZyKy7x66X3SD@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Since taprio’s taprio_dev_notifier() isn’t protected by an
RCU read-side critical section, a race with advance_sched()
can lead to a use-after-free.

Adding rcu_read_lock() inside taprio_dev_notifier() prevents this.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/sched/sch_taprio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 14021b812329..bd2b02d1dc63 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1320,6 +1320,7 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
 	if (event != NETDEV_UP && event != NETDEV_CHANGE)
 		return NOTIFY_DONE;
 
+	rcu_read_lock();
 	list_for_each_entry(q, &taprio_list, taprio_list) {
 		if (dev != qdisc_dev(q->root))
 			continue;
@@ -1328,16 +1329,17 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
 
 		stab = rtnl_dereference(q->root->stab);
 
-		oper = rtnl_dereference(q->oper_sched);
+		oper = rcu_dereference(q->oper_sched);
 		if (oper)
 			taprio_update_queue_max_sdu(q, oper, stab);
 
-		admin = rtnl_dereference(q->admin_sched);
+		admin = rcu_dereference(q->admin_sched);
 		if (admin)
 			taprio_update_queue_max_sdu(q, admin, stab);
 
 		break;
 	}
+	rcu_read_unlock();
 
 	return NOTIFY_DONE;
 }
-- 
2.34.1


