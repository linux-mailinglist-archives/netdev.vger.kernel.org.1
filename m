Return-Path: <netdev+bounces-195915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90388AD2B22
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 03:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5459A16E7F5
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 01:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9F015A85A;
	Tue, 10 Jun 2025 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="sz3pBGEP"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFDC4A06;
	Tue, 10 Jun 2025 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749517649; cv=none; b=LMPCMwRoGV8ugaIzRVYifxxHXifoO7GhblOqsNPKN94bePNipmDy8sPA9adMA489G0YQeXjlalJI3qYhn6LIA4x03E5XbeRSgcQFM8wURTPK1D/BBoSN2Utn4AuvPMjui4EUSpuY1Y91Vz7oTfT+YxN4z00MPpT6nsNMSazNDkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749517649; c=relaxed/simple;
	bh=S4W2n44VZNjNQzVeKTirqpN4tB3suesRR4Frf/aHbwU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OQt6KAjZ7is6r/uN0wYXYapx5f7b3DDmGO1JlDSH8wbxi+rgLcuB8VDRr3rBXyJ+bIZBMvziQ2F9xwof5p+iAamB+J5sjRMq1HozMGYjhdQA7Zve/eD5pj0MdSQjdv12yGfe+34pRe0ho4//2AWmOIxZ5Neb9MRsJbaEDauPl3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=sz3pBGEP; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1749517633; bh=c9MRFQDxeQxfty8SkiULH3HLoA0rW9xJB0zfq7hF8Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sz3pBGEPU4oIuxJa4plFurdXvNsNOIiCgEnX3lbvuziHqwu9i1n5LJPqLeVkjHaUg
	 6t4cid0yz0A90ArbuUhczfb4xTR+KFGirfzUQukW8YuLc0AsLGjbw5NAOwcFrbzp5X
	 DUXBKDj16hc1BSZIsHUX1XXCtmt3LXOS3XePFy9E=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 409EE7E; Tue, 10 Jun 2025 09:01:00 +0800
X-QQ-mid: xmsmtpt1749517260tcilbvdw6
Message-ID: <tencent_F746F768976CA6D1936EE37F2964E3ACA405@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/UR/645hUHJDSdJ3g3z4WYkjn15lWkZAL0/Yn9qDE4a4e3cO8LS
	 hdQNMHs1F9MxHIYiothFiHdtaL4Bi60DAJ7dJXI4+xs+vHlFS0thIUpXKMIg/Q6dIslCUL4elK+D
	 DJFobT+aSB4EX3GV/TnBwkx1tiJe83vGPIRi+lmWblfIBgBuSUuQDQFtHpt81AI5heq3w5WhJhCN
	 nQwcB2Z86Iivw/DJlNkKkNv1bi/Jw/ypXd/UciHCDIkYkkkB1Zab1ZuOxr2mOhau3s3DyzcmhYO+
	 9EO2exKjnxKWsFMHq59Qokq4+IcmMlQBeF7RpFiBpns5X47a34doQQbpdEZ36ZeeVO9NrZNysTzY
	 X35OcpWQ/LMNi4b/sNE5Q/lfAlWgUoqtHLuta5cP10fcVAJ/7KDkVEXpke5LV/jQKizi7uO66xdA
	 hmqF1E7zoA1EXUrqOgGlEdV+rmrwSX6f/WYPs+2sCZjEdMBplJKp1SWBZqtp/SmM+ip9TM4fCLf7
	 GoUkQ5QYU6zGTwigxe/XM9FCi1Yo62gJf2wXIyVRHa62uX3SXkiDFfdRVl/NkC8v4Af6JGMbSQnd
	 i++rUrtNppksoYwuyYIE2H/x/0ilzJIA20ezA6Klj9YctDcoHK1ngY8RWuAwtvF9S1GFbuo0guVq
	 YjSrU7UTuDd4xIH2fskghadlfc351Szi6DfWzGQC9dW+KdVYaKDPVer5adpx/8LTXKiF1GfHICmL
	 JchxGr1W7WEVa/3MMJdz99lq6UaJkchCFf/49Q5W07b6SV+C7riLi5QKj8rOMYdoDxEWgPnhdqTW
	 oglhiMWz3Exs8dQyivPrZXz5v1RwdEQ3xIL3Z/8Imft+FLa19o57A4z179/PaCicy3Wra5ZDql6J
	 O4vQpNvw2rNI8YfBSlfv6/Zb9M4hwr8R6G+FJCA+b858W8crfZSjDfImMvMWCSJKBKXti7GDkl
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+eb6f218811a9d721fd53@syzkaller.appspotmail.com
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in ptp_clock_unregister
Date: Tue, 10 Jun 2025 09:01:01 +0800
X-OQ-MSGID: <20250610010100.1154477-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <68478027.050a0220.33aa0e.02e7.GAE@google.com>
References: <68478027.050a0220.33aa0e.02e7.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> syz-executor421/5891 is trying to acquire lock:
> ffff888079fcc868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: ptp_vclock_in_use drivers/ptp/ptp_private.h:103 [inline]
> ffff888079fcc868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: ptp_clock_unregister+0x21/0x250 drivers/ptp/ptp_clock.c:415
> 
> but task is already holding lock:
> ffff8880300cc868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at: n_vclocks_store+0xf1/0x6d0 drivers/ptp/ptp_sysfs.c:215
They are not the same lock.
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&ptp->n_vclocks_mux);
>   lock(&ptp->n_vclocks_mux);
> 
>  *** DEADLOCK ***


