Return-Path: <netdev+bounces-209625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 859B4B10106
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62D81CC5460
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 06:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924F1222562;
	Thu, 24 Jul 2025 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gztozed.com header.i=@gztozed.com header.b="cbdtbgTx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m21466.qiye.163.com (mail-m21466.qiye.163.com [117.135.214.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0BF1FF5EC;
	Thu, 24 Jul 2025 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339553; cv=none; b=TanfSMIFSUcivrc0SXnW5o3bQKWRcbhvHnEX5D9mHKA2sawWAXxq61Sehnkq4vSahx+A7XJlR1KFameqAaiUva8maNOWLMihcqgTbbY4rnUAHcb0LOHY9wBranBzHpX7H9j3uUtu+VAa8Sl3eOfQvxQnZyy34EGmdrnW1ikFe8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339553; c=relaxed/simple;
	bh=58PWjPqunF3iX2dK3INwhy756h+S4hx6vClG7WT4twg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IwT3EPvFnhfStDspSDIwNNCMrqNAr6Eud412EZoQmSXNiwe0xTbYHDSsepC0uNPikaMyGB1MAMGUaBoIuxyslOFYMatx6+bkOBAEzRY0i0AdmET7XWdkhfQYizstG3+Ov0HLwYwSwiWGzD0zIJ0FYOoT9xdjPlWHyU4Yawx/dms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gztozed.com; spf=pass smtp.mailfrom=gztozed.com; dkim=pass (1024-bit key) header.d=gztozed.com header.i=@gztozed.com header.b=cbdtbgTx; arc=none smtp.client-ip=117.135.214.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gztozed.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gztozed.com
Received: from localhost.localdomain (unknown [IPV6:240e:6b0:200:4::42])
	by smtp.qiye.163.com (Hmail) with ESMTP id d90d321c;
	Thu, 24 Jul 2025 14:45:39 +0800 (GMT+08:00)
From: wangyongyong@gztozed.com
To: wangyongyong@gztozed.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] net: clear offline CPU backlog.state in dev_cpu_dead()
Date: Thu, 24 Jul 2025 14:45:39 +0800
Message-Id: <20250724064539.1279356-1-wangyongyong@gztozed.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250723083808.1220363-1-wangyongyong@gztozed.com>
References: <20250723083808.1220363-1-wangyongyong@gztozed.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSEtMVhgZT09NHktDGkxJHlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJT0seQU0ZS0FJS0tBT0FBT0lZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-HM-Tid: 0a983b2e2fed0230kunm8b8d6b2f2f47bc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQw6ARw6DjdIFzwhIwwpPk4f
	NTYKChRVSlVKTE5ISEhCTk9LT09JVTMWGhIXVQwaFRwCFBUcAhQVHDscAQ8UAR4fVRgUFkVZV1kS
	C1lBWUlPSx5BTRlLQUlLS0FPQUFPSVlXWQgBWUFKSkJLNwY+
DKIM-Signature:a=rsa-sha256;
	b=cbdtbgTxV3a/uIqWm8tEP+R4vu06zr4MnQ2uNvCVSJT6j2vZVGU4Ae6tcUz31urxxC2y6dHPSBwceBMm06FpChnKNY57AQfLH9OmUtDw1aHpdHF8UCKb9IrtUHteYSDwTFifMeBem7OmH9Sc73qlrPlevoAMHJNPd9R7Yv9CP1g=; s=default; c=relaxed/relaxed; d=gztozed.com; v=1;
	bh=CeOluBcsfmo9xZ9iNcrmhKdw4JPARKEPnOU5dPKkv0c=;
	h=date:mime-version:subject:message-id:from;

Hi all,

I apologize for missing the earlier discussion about this issue ([https://lore.kernel.org/netdev/b3ecb218932daa656a796cfa6e9e62b9.squirrel@www.codeaurora.org/]). 
While working on, I encountered what appeared to be the same problem, but I now realize the historical discussion already covers this case.
I should have researched more thoroughly before sending the patch.
I appreciate your time in reviewing my previous patch, and I'm sorry for any inconvenience caused by the duplicate submission.

Best regards.

