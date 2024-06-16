Return-Path: <netdev+bounces-103844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48653909DAF
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 15:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3AD6B20E5E
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FAA188CC0;
	Sun, 16 Jun 2024 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="D+vDsTHJ"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C11E86E
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718544216; cv=none; b=iHdM2OjfFEsi9D1+auwf81F/gxTN9lu/Es4/PoH3FDsPcDtIOVjkT9R858egudaAX1eTmGegRHf1uFJOs0lIOQSl+vnxp+HFFWFHGgAb1wDv4sOR/IUNSoCUO38nzxz5BmEh4PYDLzFR8M2+dkiSywh1j09NOa/CrSldoHXyVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718544216; c=relaxed/simple;
	bh=A2Yn9Be70Xe24ZE7ljQQm6mUKY0/vvCiGlacG+PDEkE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jpEEKcGRzSMmBj8O4jSPxZztU7ZwHlTEdxrifR2EBuWlTmrAAKv41mFyJzoyIedBhkMQnNWy1MRVyawn9PoTUmPShnv4sc+eOH0ibUlf8ju7P5cy8ExD1GgiZhndl9GcK3VTtm7tWTTlIcTMNYN1bm2EwDOGdIJZ9G39KJXQzEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=D+vDsTHJ; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718543910; bh=qIs4X5rUsFsB6YbZepT+e3Lmq72es//ofNH5obBTrKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D+vDsTHJI/E6KoKRKd/c/s/hIDVciHGkFp1Lb/15tPUPckSIffxU3I9+21O6nTjPN
	 r9KwNiBokbSqd1EvyZa7hZa5bzcg5UYTRzEavABEjE2DSdO+EEQb3t9w0vAyf+UAmu
	 0gScHsvaf61oz5o6/z6ifb1PGrMqYZRQTZ5kD8Z8=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 49A14659; Sun, 16 Jun 2024 21:18:26 +0800
X-QQ-mid: xmsmtpt1718543906tmp3d8lpl
Message-ID: <tencent_FFD6C6DB52C846598999EEF3AEC04CBFE706@qq.com>
X-QQ-XMAILINFO: NvKyM24IHTKSRwfinymltxIIIUSW4aH9kToFqNBIPZPLNLOWY2bSsAJpTCa+BV
	 5cJeRcnrwFKNReVPMsj1yG5joGJKrYR27tu9gDyqR1We/XLK587L4hqt8RK17OU2c3CpzwY4sKtH
	 9roenybAmr9TR4+1fykw4g8Fc3Bmef7rq7/cEOC/lyLkmCyjE6lnxV4YUBIy5zCSRdo9kLmVylne
	 PodrQ4bQtBL1VOpQAeAc5nEgNU7GqSYJsKjnCS3fpDy4ojphF57qVOKgv4zBhLPpJNboPNLAspsM
	 VbeXzsMysS0SjXAeHtF1O4ZLNtIDLTFynmA5q0O5h+BNyQyFyuKkXCW2wVeP+F5vRvk2AhsFNcao
	 eQ1ZdwJKa4152TTD97GzqoS92JuhW+RyoF3ctgtnsaBf6Jzw3mVyz48WzBKnbABAYN8b8AFkga1k
	 RuJXKaz0NA7Tbk0vhxVT36DlgVWIFtl1pZkbTjV6eN60aKfnyV3/dCzJKsEiVGyZCTJFXJbc5rn3
	 wYbS7enVNhtetO9PsZqL6imwbwf/Bq8EeXBur3dMxQhJcvp7sz6y3enmrXNHH0QyaqKdzxx1Ekdt
	 noW1qK6ESSotzus1Yo0yei9mG3mozLTohZcZqWhDsoCXQCMNr3SqeJashF1u3Vt2KJn2hlrSgIig
	 vkML84ve6BAONK4s1konKrO4IMyMzSwlnEYms9kapeGLb5pC18lSu7xROMuQuj/AWVL0FDzPI5sj
	 8duhbuNQBff52XMCBzdaZPvHRmHZqcNWt18lZ7yAA+6tNnhqoZY0JhK4mvl++OSWf2jvVBkTaqWK
	 2wM5dQ0ZoL7Y9rwGC9j1MY9CD0T0D/coBoHeGGKvhBucJigBbVyY6WutJYYL/i6+7OvbRN9ayGHf
	 vGoMQ83QsTbU1wtxkN4SNufjKQ68uFuCUngpi380fX231QfB02sqzGphCtlMGDh/9V50qZSsjCQf
	 k7HmC3sn0bAaMoOW8IlbU48WkJqnGXlG+dtAh1Oqo=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: paskripkin@gmail.com
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	johan.hedberg@gmail.com,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	william.xuanziyang@huawei.com
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_del
Date: Sun, 16 Jun 2024 21:18:26 +0800
X-OQ-MSGID: <20240616131825.581073-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <fcdde042-6424-46a8-9fa6-e4f4021b0717@gmail.com>
References: <fcdde042-6424-46a8-9fa6-e4f4021b0717@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 16 Jun 2024 13:37:17 +0300, Pavel Skripkin wrote:
> > hci_le_big_sync_established_evt is necessary to filter out cases where the handle
> > value is belone to ida id range, otherwise ida will be erroneously released in
> > hci_conn_cleanup.
> >
> > Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")
> > Reported-by: syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> 
> There is one more user of  `hci_conn_add` which may pass too big handle
> which is `hci_le_cis_req_evt`.
This case only affect hci_le_big_sync_established_evt.

--
Edward


