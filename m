Return-Path: <netdev+bounces-130099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B8298836D
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 13:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD931F22044
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2553B1898EE;
	Fri, 27 Sep 2024 11:42:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401DF1891BB
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727437343; cv=none; b=GE1i8vc6MGg/Ydq++ppU6jmGRkF7IguU198f48FFbZzjAII8yM/2gwGkTI7HoB2WU4A24ELCD2EFYs5pgbZRoqRzHTIyKFtqQ0e9TiKv/7zm5hWxGEy5MVxwhhajpDy6uECWcHVZt/TZWThfcS1tWIHq9gtVynOXe9zbic3Tmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727437343; c=relaxed/simple;
	bh=2/TM2NHM2Z6JbDF6sxIrQU/Yg2Y3AlAVhKkUXPDJ4+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLMq0qS34B4mmB6Epk4RQ6v1Z1FhACQ5pK/c6ptI5RyXWtg3XLeJXyYjExk3X02drglMyZy6n81F6STlZSD6YnVUQ5zm0EiAAA7O43WSO5HmwFHulHU15s/7Qo+lDh88SaUP7K3uPUrJEyekmhuulfopzaTTqU3gmygXljX95kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.54])
	by sina.com (10.185.250.23) with ESMTP
	id 66F69A0D000026DB; Fri, 27 Sep 2024 19:42:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6840358913239
X-SMAIL-UIID: A2F331F45F294C8C95E71D6C31C39589-20240927-194208-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] INFO: task hung in new_device_store (5)
Date: Fri, 27 Sep 2024 19:41:58 +0800
Message-Id: <20240927114158.1190-1-hdanton@sina.com>
In-Reply-To: <CANn89iLKhw-X-gzCJHgpEXe-1WuqTmSWLGOPf5oy1ZMkWyW9_w@mail.gmail.com>
References: <66f5a0ca.050a0220.46d20.0002.GAE@google.com> <CANn89iKLTNs5LAuSz6xeKB39hQ2FOEJNmffZsv1F3iNHqXe0tQ@mail.gmail.com> <20240927110422.1084-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Sep 2024 13:24:54 +0200 Eric Dumazet <edumazet@google.com>
> I suggest you look at why we have to use rtnl_trylock()
> 
> If you know better, please send patches to remove all instances.

No patch is needed before you show us deadlock. I suspect you could
spot a case where lockdep fails to report deadlock.

