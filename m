Return-Path: <netdev+bounces-109853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26292A1CA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D380E1F227DD
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08FC80617;
	Mon,  8 Jul 2024 12:00:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D696EB56
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440044; cv=none; b=VAkf0TLyP6dYZJ8Hyq0+w/dOuRhIuQuLZ9FrExZpPvRWuMzYXfL7p3ISCQ8gWZXjHC1Kq8ID7qWV+vRecr1l9FAcyFo/Xl+P4sq+6vtAlNzpSgb36cTu4W9CBGuSfz2KZIwcZ+p5SjraXZ2xU6EoOj+aZlRX1z6kLKUy3KAXMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440044; c=relaxed/simple;
	bh=x+mCV/IZ5gqmmHwzHgCB+C14nWPF8UHzhEJC2hUg1XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tTtVi8HR5LJWucOjSMzaUG4mC+4LvDowrc0S5GAXPQxQsEjgUtutwMRpLl0oyDUTEydaLAd9gtMw+helwkOnEoD00UcqXzssJqhlAPoM3927iZBKDKnTwN+aonghalUxsm/GzDUPQVyy2Ck0VPW7WJLSTOl17K6lORea2KV8RGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.123])
	by sina.com (10.185.250.22) with ESMTP
	id 668BD4B500001720; Mon, 8 Jul 2024 19:59:51 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3947187602692
X-SMAIL-UIID: D3C3304411904A3D80327BF04F8DDD7E-20240708-195951-1
From: Hillf Danton <hdanton@sina.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tparkin@katalix.com,
	syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com,
	syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v2] l2tp: fix possible UAF when cleaning up tunnels
Date: Mon,  8 Jul 2024 19:59:40 +0800
Message-Id: <20240708115940.892-1-hdanton@sina.com>
In-Reply-To: <cfee59ae-4807-f384-b525-ce47fa4135e6@katalix.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 8 Jul 2024 11:06:25 +0100 James Chapman <jchapman@katalix.com>
> On 05/07/2024 11:32, Hillf Danton wrote:
> > On Thu,  4 Jul 2024 16:25:08 +0100 James Chapman <jchapman@katalix.com>
> >> --- a/net/l2tp/l2tp_core.c
> >> +++ b/net/l2tp/l2tp_core.c
> >> @@ -1290,17 +1290,20 @@ static void l2tp_session_unhash(struct l2tp_session *session)
> >>   static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
> >>   {
> >>   	struct l2tp_session *session;
> >> -	struct list_head *pos;
> >> -	struct list_head *tmp;
> >>   
> >>   	spin_lock_bh(&tunnel->list_lock);
> >>   	tunnel->acpt_newsess = false;
> >> -	list_for_each_safe(pos, tmp, &tunnel->session_list) {
> >> -		session = list_entry(pos, struct l2tp_session, list);
> >> +	for (;;) {
> >> +		session = list_first_entry_or_null(&tunnel->session_list,
> >> +						   struct l2tp_session, list);
> >> +		if (!session)
> >> +			break;
> >> +		l2tp_session_inc_refcount(session);
> >>   		list_del_init(&session->list);
> >>   		spin_unlock_bh(&tunnel->list_lock);
> >>   		l2tp_session_delete(session);
> >>   		spin_lock_bh(&tunnel->list_lock);
> >> +		l2tp_session_dec_refcount(session);
> > 
> > Bumping refcount up makes it safe for the current cpu to go thru race
> > after releasing lock, and if it wins the race, dropping refcount makes
> > the peer head on uaf.
> 
> Thanks for reviewing this. Can you elaborate on what you mean by "makes 
> the peer head on uaf", please?
>
Given race, there are winner and loser. If the current cpu wins the race,
the loser hits uaf once winner drops refcount.

