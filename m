Return-Path: <netdev+bounces-259691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gArjKJ4pmGlqBwMAu9opvQ
	(envelope-from <netdev+bounces-259691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:30:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CC3166417
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E12123011068
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B3F31280C;
	Fri, 20 Feb 2026 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7AQhxMV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238A321428
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579802; cv=none; b=cDtHFg7C0k0WHr/wk/+VAwqcUA6JStlG2jMzobpBhIxBt/c3n66mxo1JZ/dqUkUyTCA9KDXi3TzJ67CMGcvogPvjZ+Lpkp5Fk5izAzKZ8e+KLDM5sE5zU90FEgKexUzlC24F8XV6+eeVv27dcXHMu3fyZr2ijX5RcPpbShjcrek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579802; c=relaxed/simple;
	bh=RCsvMjb31JDLbjRAnaKyFCwT/WBKxcagGMOsJDxeY4E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y0E6n/dgWQAC2vBNuvLolbhNEuLkBq4Puff4CoCRoRxk3vk/zywtF6rZaVucbSWPmWqqRct5Cmwjgd8oNxPoF3y17reri5MMfKstLO1ltZWzTXux8eQaVgl5FhydebRNmF/RATJsHszD1ItR4xDvCvZiSIOFPhe1c4prZHAQPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7AQhxMV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso689139a12.3
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 01:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771579800; x=1772184600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIUsSbZrqaE6zdyi4E3Dqq/ony/M6CgMmv0V8PLk2hc=;
        b=h7AQhxMVOlO//7RkgfdMkGZq4NuPE6u0XbMit2gViW4P7Ov88l4eVtNy9zCw6r75eq
         If1RU70Z0pgfFJw5wJRJdmBZFVPPOMmzDS3tc01dXYkp9m/U2VmPZFdK+fz8DORaS/by
         /DadRbkJFX31vDLUaz/Hv6fo9/1kBD1blblRADZMyGFBerYa6QSMisSrH1V/iSuXqxKx
         F8l2YYNe+l+PJqtUVFlq5DdCPAHmFOt67Yf9Ov5h7KG2WkdOMaaghDk2ojiKYo6XXk53
         O6bUV9l0e003aItLMfGfSO+z4Uu0pJw74taDfOuchnvWmg4XEOTSRvenGQUYrgQ1xEnp
         B5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771579800; x=1772184600;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VIUsSbZrqaE6zdyi4E3Dqq/ony/M6CgMmv0V8PLk2hc=;
        b=nR4fW5/PPQUM+VisL+EcB/i4vIaEqCRxH5v4sl8R1czF7Gk1UfUuT1vTqNJeBrBlp7
         NfSVBArdhFMCFOVtSfbMdeqTdkUB+cjZpRrGrOvQJHxyAcfhtyR6rYwrKOuXBHtk/QdO
         o56tzMFqmLZrnYJRvwuDi6YHjMxwbt5avXf7C2jVpqAodCVYs1aE60xfdwm/Sq2lQIAk
         y7Pd3/iaMRmzYY7b1u67U8p0QB20BWOsSWtzFcZbwYRO+fJPQfwzGoJekMHlVj3ZPf9m
         75SzuoU5gPYOJdzaUyvJEL10OL94ZE7Z2vIYNh1uSVFmiI/tSEuxOvAZAWZ9KctkerX4
         8TVA==
X-Gm-Message-State: AOJu0YzVadbRoi8K9C79ezYx/4V7tr6BsDfowpws0Bo+g4GB5uuS/Z5q
	nK6nsEGuROjerxevVDQMQU/udJYXI0yQHSCmCztHzHCSIT8A1PuFGj+Y
X-Gm-Gg: AZuq6aL23LcuLhBIZRiKZ+7zpZEhiGW/BD05jl7qZ85oi4OI+U75a80BRgTnoyTug15
	EHdtEtpZFrrPhAFAqdWSnRUL/woAvDjejUIDAg97BQoIL9g+CUTcPu9YaT+Hidb/JQdg5jKpvQZ
	YcbbSs3/OiUPhTixq7dgtIGbyL1e+PMyLyceau3ySiFDRJZbITLqHLr/ip0tSAH6SKP/8fsQQ9b
	wG5GOJmW4RBTG5XbzYP3e1uBN67FqexD/XMy1EUA2Mk5+D7aYUnXXN0zCUOrRy908aLq1XY7Sd5
	tfr/68Zyl4YgKiao2piLMbL2PTkvVhk/cCEzZ0zqdmkSkuXUuYqlSfgb3C2oNCR/GHBAnK7M693
	Ww+ClhH+jKOlA91ia0MmBW7qXdrFDkLoe4ibxQ0fWhxX8SklBdiszoLmQ2eR5NhfrIR1M8tyDqE
	XvBBXKJte0MjNZ3SvV142xmqFhu/DOGk/bGps8GzuMlg==
X-Received: by 2002:a17:903:3d06:b0:29e:9407:a8cb with SMTP id d9443c01a7336-2ad6cef0282mr12479275ad.40.1771579799534;
        Fri, 20 Feb 2026 01:29:59 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aafb972sm174668415ad.88.2026.02.20.01.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:29:59 -0800 (PST)
Date: Fri, 20 Feb 2026 18:29:55 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, Julia.Lawall@inria.fr,
	linux@treblig.org, nate.karstens@garmin.com, sd@queasysnail.net
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v2] strparser: Fix race condition in strp_done()
Message-ID: <aZgpkyTDU3aXe_V0@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259691-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21CC3166417
X-Rspamd-Action: no action

This issue was discovered during a code audit.

When strp_stop() and strp_done() are called without holding lock_sock(), 
they can race with worker-scheduling paths such as the Delayed ACK handler 
and ksoftirqd.
Specifically, after cancel_delayed_work_sync() and cancel_work_sync() are 
invoked from strp_done(), the workers may still be scheduled.
As a result, the workers may dereference freed objects.

The following is a simple race scenario:

          cpu0                      cpu1

espintcp_close()
                           espintcp_data_ready()
                             strp_data_ready()
                               if (unlikely(strp->stopped)) return;
  strp_stop()
    strp->stopped = 1;
  strp_done()
    cancel_delayed_work_sync(&strp->msg_timer_work);
                               strp_read_sock()
                                 tcp_read_sock()
                                   __tcp_read_sock()
                                     strp_recv()
                                       __strp_recv()
                                         strp_start_timer()
                                           mod_delayed_work(&strp->msg_timer_work);

To prevent these races, the cancellation APIs are replaced with 
worker-disabling APIs.

Fixes: bbb03029a899 ("strparser: Generalize strparser")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Update Fixes tag
- Incorporate Simon’s review: https://lore.kernel.org/all/aZSLHaFj7k8DPmLG@horms.kernel.org/
  - Shorten the patch subject
  - Target the net tree
  - Add the bug discovery background and the race scenario to the commit message
- v1: https://lore.kernel.org/all/aZLn2Faeg1FB7XOf@v4bel/
---
 net/strparser/strparser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index fe0e76fdd1f1..15cd9cadbd1a 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -503,8 +503,8 @@ void strp_done(struct strparser *strp)
 {
 	WARN_ON(!strp->stopped);
 
-	cancel_delayed_work_sync(&strp->msg_timer_work);
-	cancel_work_sync(&strp->work);
+	disable_delayed_work_sync(&strp->msg_timer_work);
+	disable_work_sync(&strp->work);
 
 	if (strp->skb_head) {
 		kfree_skb(strp->skb_head);
-- 
2.43.0


