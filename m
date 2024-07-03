Return-Path: <netdev+bounces-108840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CAB925F22
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5341F25859
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E122A13E024;
	Wed,  3 Jul 2024 11:51:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061445945
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007497; cv=none; b=GpKbGb4iJt997/Kzj1Ha8ETz5V70WJpdWxGDgSl9PrRqibWNQj7gUr8oWqSWaiu1uOhdMsK6SXy0buAtl/NJv2rWGUgo+kt4SKic1+gNDJM2pXTFG0Ltjjar5QUh07aWQcP4FvRFOLM3NLF93s29odSV2tYid5NkEIWQxCp0qPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007497; c=relaxed/simple;
	bh=WYjyN31nvOPQorDg4MwuaO39knfNAiEVUYUmWPo3/s0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MO5FKbwpE3gfIA4oScKm5+nqn1OzW2Ow8Abl9/5TkBrQmr3ovyoQq/u7vuMYQDdHcueJvUPJjCFDbodN0SPtTucuOyvoBiTZ+OGSJWo0EwyUuWDWcmNVkAf+LZ7zNrc8+tYcELUmIrXEOb26rNGbGHpSdZPY9cKIb48Kn07sAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.67])
	by sina.com (10.185.250.23) with ESMTP
	id 66853B3B000058DB; Wed, 3 Jul 2024 19:51:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6931968913445
X-SMAIL-UIID: 4B0436BF9FEB440284964CB5AE262EC2-20240703-195125-1
From: Hillf Danton <hdanton@sina.com>
To: Tom Parkin <tparkin@katalix.com>
Cc: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	James Chapman <jchapman@katalix.com>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
Date: Wed,  3 Jul 2024 19:51:13 +0800
Message-Id: <20240703115113.2928-1-hdanton@sina.com>
In-Reply-To: <ZoU1Aa/JJ+60FZla@katalix.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 3 Jul 2024 12:24:49 +0100 Tom Parkin <tparkin@katalix.com>
> 
> [-- Attachment #1.1: Type: text/plain, Size: 379 bytes --]
> 
> On  Tue, Jun 25, 2024 at 06:25:23 -0700, syzbot wrote:
> > syzbot found the following issue on:
> > 
> > HEAD commit:    185d72112b95 net: xilinx: axienet: Enable multicast by def..
> > git tree:       net-next
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1062bd46980000
> 
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git  185d72112b95
> 
> [-- Attachment #1.2: 0001-l2tp-fix-possible-UAF-when-cleaning-up-tunnels.patch --]
> [-- Type: text/x-diff, Size: 3275 bytes --]
> 
> From 31321b7742266c4e58355076c19d8d490fa005d2 Mon Sep 17 00:00:00 2001
> From: James Chapman <jchapman@katalix.com>
> Date: Tue, 2 Jul 2024 12:49:07 +0100
> Subject: [PATCH] l2tp: fix possible UAF when cleaning up tunnels
> 
> syzbot reported a UAF caused by a race when the L2TP work queue closes a
> tunnel at the same time as a userspace thread closes a session in that
> tunnel.
> 
> Tunnel cleanup is handled by a work queue which iterates through the
> sessions contained within a tunnel, and closes them in turn.
> 
> Meanwhile, a userspace thread may arbitrarily close a session via
> either netlink command or by closing the pppox socket in the case of
> l2tp_ppp.
> 
> The race condition may occur when l2tp_tunnel_closeall walks the list
> of sessions in the tunnel and deletes each one.  Currently this is
> implemented using list_for_each_safe, but because the list spinlock is
> dropped in the loop body it's possible for other threads to manipulate
> the list during list_for_each_safe's list walk.  This can lead to the
> list iterator being corrupted, leading to list_for_each_safe spinning.
> One sequence of events which may lead to this is as follows:
> 
>  * A tunnel is created, containing two sessions A and B.
>  * A thread closes the tunnel, triggering tunnel cleanup via the work
>    queue.
>  * l2tp_tunnel_closeall runs in the context of the work queue.  It
>    removes session A from the tunnel session list, then drops the list
>    lock.  At this point the list_for_each_safe temporary variable is
>    pointing to the other session on the list, which is session B, and
>    the list can be manipulated by other threads since the list lock has
>    been released.
>  * Userspace closes session B, which removes the session from its parent
>    tunnel via l2tp_session_delete.  Since l2tp_tunnel_closeall has
>    released the tunnel list lock, l2tp_session_delete is able to call
>    list_del_init on the session B list node.
>  * Back on the work queue, l2tp_tunnel_closeall resumes execution and
>    will now spin forever on the same list entry until the underlying
>    session structure is freed, at which point UAF occurs.
> 
> The solution is to iterate over the tunnel's session list using
> list_first_entry_not_null to avoid the possibility of the list
> iterator pointing at a list item which may be removed during the walk.
> 
> ---
>  net/l2tp/l2tp_core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index 64f446f0930b..afa180b7b428 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1290,13 +1290,14 @@ static void l2tp_session_unhash(struct l2tp_session *session)
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

WTF difference could this patch make wrt closing the race above?

>  		list_del_init(&session->list);
>  		spin_unlock_bh(&tunnel->list_lock);
>  		l2tp_session_delete(session);

