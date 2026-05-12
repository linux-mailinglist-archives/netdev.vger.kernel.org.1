Return-Path: <netdev+bounces-287210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE8qE5M/A2ro2AEAu9opvQ
	(envelope-from <netdev+bounces-287210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:56:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F87523111
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48E9630F1DB5
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382A9356768;
	Tue, 12 May 2026 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHtJxjAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9A3451B3
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597120; cv=none; b=FIWa4f625yA3Iu9mvgNtRPieupukHPKAe/EC9hlnhj2U7CYeX12wgW5BnMvWiJYM8pfbT+U4v4+VeF5Rpxq1d5539jznX7l4q2p9cEcpHkQHrIlNwcgj5+1V1J/BM0mIJtv82xB1hWxogHasxkV131WqWr37Owhsicmk1OFGMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597120; c=relaxed/simple;
	bh=pNjPLUfYOnlL9AuWfKEjlCxudFzPIGw2EJqVl9WOMxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8TXjhbvj/t+45CLAbjbgMwRV+KJNy5ODvypyvAJC6/ZGOTEmdq8LJZN4jzANG1et+2x3x+XylE0++A9pJMSeSF7Fq07MrHwsYbqtvK6hhj41VzPt9Wpd1NS/XxtJYKKHayJpfv+xXnWRc8n48ZODuiD3HMOD9LfLuwzW5fK8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHtJxjAo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso51798505e9.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778597117; x=1779201917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sza2ZxpHlBY8pmqC5zMaFu/RPKkibTVxTiEJ6kAqjb8=;
        b=PHtJxjAosh1U0g+a1DEOfiXi0eYoCeR8VARgRkKyNwOTVNJhxAtIMoMl37QJ2m5MUx
         CRyN8WiSsk96kU6JPWTHLyaX2yhs4nGeUalx1dZgsvH8CNOdmzsH9tFY9hX9tOzF430I
         n7x0gW4XaIQDz9Xtrn2i8CDqsLfbzXhU86FAp7SUe9u0kRoBTF0cvhIJoDp/iONDV5hH
         1oal/A+UqE2FYL2YmH1I4Lb5rGpMHF+UWpElhC8m+GfumLD//U9mdtz+dLaXSSH3GRO0
         Zsfss3DulDcPsRDKyCfPqEIhnkeaRTnk5PMZ9ykCVNjuOR4miSCEppl8Z3UrOSCBvcNN
         TYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778597117; x=1779201917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sza2ZxpHlBY8pmqC5zMaFu/RPKkibTVxTiEJ6kAqjb8=;
        b=nj4M6V3w7/XcX+CRIeRyQXTxAnCWS5NN+B0+QaF2Qkjjpc34GWFtzXccC/cN2lwKY+
         dTtBvTi6/3zTS8+IJ06QIkSs3LRcA/YS5cODY+voZLIPQFj4xcBP2EvoVGFwFILuxy6G
         iLo4u2V9oBybRAw/LhDaLTQH+nawXWjOjhAvjn+vdeEx0frLelbODwEhEiVyMSZJ+12v
         sUYZyuX0VkihU8NgaGnPEkMbZKJqc94CSTRf0EycOAqrgaT4Y1p+rnO6akcWjCuU2pP3
         PAcsw2GD+dL8AgphgV3dUEDXkYIwDIObq4a5TfVYkGN9R4jDFuLcV9TEpe/gA5Yq2RND
         v8VA==
X-Forwarded-Encrypted: i=1; AFNElJ9xLAWFHclnRoVZCVP4WtpqhHjwc4ieuX1L+v6TlxZ6Tn+mkDXsByTZEO5cDsUde5KGY6F9J8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbLtY1xnpGluZN9yuM4vlDcBVyUtSQ6qEQ7j/yCNWR1Wc2fkRJ
	Lr2Ie9NTFI4yiK7dHnbnUKZgYSHvwLTxguUPxoUIffVQWgLVzDVsn+ok
X-Gm-Gg: Acq92OFp9+B3bOA2rkbTzR9S9owbeOZqKtfjdY8IOmdngI80ZHXUd2ryg4qK4frznHC
	vcVBtdcWCa7iFiVoHWCPKthG7dQaDuKcE2eLydzfhY1bwW2wrf4R6n4AA6hXg5lnqgHUoPqbeTR
	7DMGIhgKCYv064dHOuHleS0bwNd7ZMyQRv7ij/8nxCul70TWp0rwaQoQ6bKwVL3iKQcafa+3RPG
	pVdx2d9r/JJ0Ch8bezVLcgs/jTzrOK45TCx+A2P+u79MleXaS0lA5HCJeHC612EmAAVIgK2WYGh
	1OkDhur8SwEUSFbfj9LHyGa85d0IA1KhQtkHEsYiDFSonHrwRyWqV8R4FVyr0BF1ypLqSR6uAeR
	c90rCveLsCz8wJlQyKWm/xZ5WaNfHFzegt4sWIBTNDAq7qu6oFVWLolCNt/arqitIgpqw5cwZW1
	o7NwgPk5mX1UqzRkIIkJ13MuKIZyj3p55UpB7RHrC21hG/QFDsFxyQFWc2XH3kMwZp8nWdetwhl
	CCG
X-Received: by 2002:a05:600c:17d4:b0:488:c014:34da with SMTP id 5b1f17b1804b1-48e51f4cde9mr282699415e9.26.1778597116959;
        Tue, 12 May 2026 07:45:16 -0700 (PDT)
Received: from ubuntu-f6bvp (lfbn-idf1-1-304-238.w86-195.abo.wanadoo.fr. [86.195.26.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d1f669sm2563255e9.4.2026.05.12.07.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:45:16 -0700 (PDT)
From: f6bvp <bernard.f6bvp@gmail.com>
To: toke@toke.dk,
	kuba@kernel.org,
	stable@vger.kernel.org
Cc: Bernard Pidoux <bernard.f6bvp@gmail.com>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	linux-hams@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio (hamradio) subsystem
Date: Tue, 12 May 2026 16:45:10 +0200
Message-ID: <20260512144512.9960-1-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87se8mytvv.fsf@toke.dk>
References: <87se8mytvv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B6F87523111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,vger.kernel.org,redhat.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287210-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,toke.dk:email]
X-Rspamd-Action: no action

From: Bernard Pidoux <bernard.f6bvp@gmail.com>

Toke Høiland-Jørgensen <toke@toke.dk> writes:

> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>

Hello Toke, Jakub, all,

I understand the decision to move AX.25, NET/ROM, and ROSE out of tree,
and I am not opposing it. The maintenance burden caused by AI-generated
syzbot reports with no human follow-up is a legitimate reason to act.

That said, I would like to raise one specific concern: the ROSE subsystem
accumulated a number of real bugs through upstream commits that were merged
without hardware testing. I have been running ROSE on actual packet radio
equipment and was able to reproduce and fix five of these bugs, confirmed
via KASAN and netconsole.

The most severe symptom is that the ROSE module cannot be cleanly unloaded
once an AX.25 connection has been established, which makes amateur radio
applications that rely on ROSE effectively unusable until a reboot.

My five patches address:

1. rose: fix dev_put() leak in rose_loopback_timer()
   Fixes: 0453c6824595 ("net/rose: fix unbound loop in rose_loopback_timer()")

2. rose: hold loopback neighbour reference across timer callback
   Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")

3. rose: fix race between loopback timer and module removal
   Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

4. rose: clear neighbour pointer after rose_neigh_put() in state machines
   Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")

5. rose: guard rose_neigh_put() against NULL in timer expiry
   Fixes: 5de7665e0a07 ("net: rose: fix timer races against user threads")

Each patch carries the appropriate Fixes: tag and a Tested-by from me on
real hardware. They are visible on lore.kernel.org.

Since ROSE will no longer be maintained in-tree from 7.1 onward, the only
remaining users are those running current stable kernels (7.0.y and
earlier). Would it be possible to have these five patches queued for the
stable trees via Greg's stable process?

I am happy to resend them as a formal series tagged [PATCH stable] against
the current stable releases if that is preferred.

Thank you for your work on the Linux networking subsystem.

73 de Bernard Pidoux, F6BVP
<f6bvp@free.fr>

