Return-Path: <netdev+bounces-109425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A51209286D5
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26221C21D47
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAF01448C0;
	Fri,  5 Jul 2024 10:33:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EA622313
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175591; cv=none; b=We4C0lF/3OksKjwR4Sj6bnJKL3d5BVjgkEVpmJb4C4ZqVfEVrk0R1d2fg9qFGPLiGnLzG2e37oP5tGhP5SDBeNnMC52wXmOFsHUO7WyyszNPGdqu8x3AvqiO7byvJFciS2W4tHncGtWeub0Y1FMFWYEf9kPgR4spgX+FQJbcLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175591; c=relaxed/simple;
	bh=ncjmPue+I6rZS9tquNR2En1PA0HA6QN9g4wjQ5j8Lso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMMKuEuR/rzSMrbqp4QxYdgrBwq9ZECybkdfffKBiMnxrKbMR8X39i0gAZWjDSph7wyY2+i/g94G6dU62+H+ieGFUuAy0pdyO+U7lFBL3PSIimzXlpkzdStXPop3ma0LBzcPQ9I+R0DK+p3MPRmC3LxLQg5G/ODOr3Xx1A5b1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.197])
	by sina.com (10.185.250.23) with ESMTP
	id 6687CBDA00002895; Fri, 5 Jul 2024 18:33:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2653828913354
X-SMAIL-UIID: B6E10D94F9DF49C98BA45BED31EB401B-20240705-183301-1
From: Hillf Danton <hdanton@sina.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tparkin@katalix.com,
	syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com,
	syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v2] l2tp: fix possible UAF when cleaning up tunnels
Date: Fri,  5 Jul 2024 18:32:50 +0800
Message-Id: <20240705103250.3144-1-hdanton@sina.com>
In-Reply-To: <20240704152508.1923908-1-jchapman@katalix.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  4 Jul 2024 16:25:08 +0100 James Chapman <jchapman@katalix.com>
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1290,17 +1290,20 @@ static void l2tp_session_unhash(struct l2tp_session *session)
>  static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
>  {
>  	struct l2tp_session *session;
> -	struct list_head *pos;
> -	struct list_head *tmp;
>  
>  	spin_lock_bh(&tunnel->list_lock);
>  	tunnel->acpt_newsess = false;
> -	list_for_each_safe(pos, tmp, &tunnel->session_list) {
> -		session = list_entry(pos, struct l2tp_session, list);
> +	for (;;) {
> +		session = list_first_entry_or_null(&tunnel->session_list,
> +						   struct l2tp_session, list);
> +		if (!session)
> +			break;
> +		l2tp_session_inc_refcount(session);
>  		list_del_init(&session->list);
>  		spin_unlock_bh(&tunnel->list_lock);
>  		l2tp_session_delete(session);
>  		spin_lock_bh(&tunnel->list_lock);
> +		l2tp_session_dec_refcount(session);

Bumping refcount up makes it safe for the current cpu to go thru race
after releasing lock, and if it wins the race, dropping refcount makes
the peer head on uaf.

