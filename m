Return-Path: <netdev+bounces-108845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB23925FC3
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFDD1C209AE
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E1171E5A;
	Wed,  3 Jul 2024 12:10:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A88173328
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008609; cv=none; b=nUjJFuuqE8TqKVXlE+TgX7zfPCX0/F3Onsb7MAW7jPB+3cU+KfFmx1JMy+sJM3EurAtZBL0lzRQW6Rdu9xIdOmrLyjvRTTLNKPYJprVhlK57xeFIoJ1Ufgc7mc++c8mldUYpO4c57UuSaSoa66jsEX8UpVJmCbbAtKZdGls2aTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008609; c=relaxed/simple;
	bh=2aCGqVBTsyNtk/3i1tyo0SCfBtdeq6gmjEv8SUq1xp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g9CNa7nhikng/WAUGvbKeejFdjv8fGyHNYZOVMJrQ0jgm41SLz3/O9eq+v8vH0A5sYBMptPuRREWtD/RV+PV6orJpfuIM7f0e3FuePx/nRA7WbMosNldlQuVy59LhDWCVlg8VWUSuUKcw8VH2JOesulJDfuWeUonkIsmtzFuY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.67])
	by sina.com (10.185.250.22) with ESMTP
	id 66853F73000021A1; Wed, 3 Jul 2024 20:09:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7016087602759
X-SMAIL-UIID: 10971053EF6F4499A16CF27989682586-20240703-200927-1
From: Hillf Danton <hdanton@sina.com>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com
Subject: Re: [PATCH nf] netfilter: nf_tables: unconditionally flush pending work before notifier
Date: Wed,  3 Jul 2024 20:09:13 +0800
Message-Id: <20240703120913.2981-1-hdanton@sina.com>
In-Reply-To: <20240703105215.GA26857@breakpoint.cc>
References: <20240702140841.3337-1-fw@strlen.de> <20240703103544.2872-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 3 Jul 2024 12:52:15 +0200 Florian Westphal <fw@strlen.de>
> Hillf Danton <hdanton@sina.com> wrote:
> > Given trans->table goes thru the lifespan of trans, your proposal is a bandaid
> > if trans outlives table.
> 
> trans must never outlive table.
> 
What is preventing trans from being freed after closing sock, given
trans is freed in workqueue?

	close sock
	queue work

