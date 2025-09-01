Return-Path: <netdev+bounces-218711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A50B3E02E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 12:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0D27A3E16
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACCE13D8A4;
	Mon,  1 Sep 2025 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="OOBJeU/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E230F921
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722668; cv=none; b=WWno9m/hqUKgQQ70thxgKAOscbjjNdaEQAjb6rBgLn6OyD7bTuthxUNRGGIBmojgGaFdvL4n+cx6qdGL0Eh9usNNrBOavQqSU+bWzzy1c80A85F9oR7JQDY5unReReZ5f2W0gxwU5aqHOZXw/ec496/8//eJ1qKyjUJyePmHDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722668; c=relaxed/simple;
	bh=hWpH2tUFMzIxUSiCE6ERq9LKJUNR3bZ4105Qs5jaA0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1EbDtC8JWlvWsrj3oAgsLkGCT/0NApDbpxxOG7LnPVl89rEWhiB+P/MI1rg7t51iu32gZwDGqVH8mPCZiGKo6ASSZB6lbI0NfLQfAqAAntcAnA7fHs8nMSUxMxTRs7037gV6hCeyT8cKHHJrT3mUCgJckMs/JQWe2MgZtoJUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=OOBJeU/+; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756722663;
	bh=05AtvCc7k+4lVyxmaQERwndqLXMgTJAgkCeFIgMeQdA=;
	h=From:Subject:Date:Message-ID;
	b=OOBJeU/+lCBFSmIw4bYIJOn+nIZn88ZijI1JZWcd1Yp6/sd4DvjtCmE6l6sjIItQe
	 47WE7+YmYAhlhjxDUinS0U2fmt9j0gkDNTPL6eLx8cAn3ugcVRWJbF3wMkQ3zHS5tT
	 f6MHOMd9NmMTsxTOB88kJ6c4WJ4ho7wm9aD0G7qw=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68B575DC00003C10; Mon, 1 Sep 2025 18:30:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2021916816225
X-SMAIL-UIID: 4FFAF1C64D0E43CB996E117F18996D44-20250901-183054-1
From: Hillf Danton <hdanton@sina.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Mike Christie <michael.christie@oracle.com>,
	stefanha@redhat.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in __vhost_worker_flush
Date: Mon,  1 Sep 2025 18:30:42 +0800
Message-ID: <20250901103043.6331-1-hdanton@sina.com>
In-Reply-To: <20240816141505-mutt-send-email-mst@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Aug 2024 14:17:30 -0400 "Michael S. Tsirkin" wrote:
> 
> Must be this patchset:
> 
> https://lore.kernel.org/all/20240316004707.45557-1-michael.christie@oracle.com/
> 
> but I don't see anything obvious there to trigger it, and it's not
> reproducible yet...

Mike looks innocent as commit 3652117f8548 failed to survive the syzbot test [1]

[1] https://lore.kernel.org/lkml/68b55f67.050a0220.3db4df.01bf.GAE@google.com/

