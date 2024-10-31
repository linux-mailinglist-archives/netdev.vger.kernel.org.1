Return-Path: <netdev+bounces-140830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060F69B865A
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 23:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C059D282F2C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D43F1EE036;
	Thu, 31 Oct 2024 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HwhAHJM3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462AE1D0DE6
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415232; cv=none; b=jX/yBVfXceCkk+xPcO7iy/X2CSyzUJgkwrvJDAWhGA0JQ9gFZBZyWWC8nANUrDXKljRHAWKnRVv9j4hvtdYGkkuIjQs7XwkgLu5IjqokUdIXBU/FyQSp85/SW0qDD/l+U0ZekSn0FTbQ/NPpKwYJOvPq4GpqXVpjMTjOLGnkcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415232; c=relaxed/simple;
	bh=d+KWwf0GkCHU+dO7dz7Ix9366JgUxkGbxc68is0rego=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=cxM7Ysj8iLxY/9MXjcXXfJEytKtw7ATvnyDl0Y4/xzeRijjdOSTVB0eQSPmbL3RIWic31eznr1pBJq38DJk7IPVZrXY96B+grTEDQ+Wo2SiMxrgjtAgiCzHNIcuvmABu/Gz5TRTPJKUbEE8AyONeq0ot2SKbnqBDghclH3e20CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HwhAHJM3; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b14077ec5aso232555585a.1
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 15:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730415219; x=1731020019; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/1IevD7DLvIM994VGktPASZhi2RFBUm322v1qsmqeM=;
        b=HwhAHJM3tGqQd5r1l+ZE2Yf79wCAK3bP28oxsvotyurrRNEy46/9sjDN7Nb/tCOQLZ
         Hhb5QsdiXXy2BEMFk6Lw+t2y2JtNJCnArD//sJ8UCnrxT72AcDqYtpcyBDI6RN8dK+mH
         zoxp99b8QxPVllEDJA8BJTPTkD8q5gkl+qUsrgR9dWZaZxQ92Zu/YBzYenTxTk/8vMbW
         B0gzbjS9nnoepjR2aOd+BJtxlyLZH0ykx9Jq/6JPkBcEs6SBSVwK5b9xRw5oD0hqAACd
         /JYdkye1PvTHRqxEbVRUiAPQLszfIdxMuenem/A7QL0ywJOytU7XaS9PGtP5Lr70d4kO
         +N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730415219; x=1731020019;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N/1IevD7DLvIM994VGktPASZhi2RFBUm322v1qsmqeM=;
        b=vF0qSIYY8PqE9MR5MLBEqKdcaPUh9tXP4y7Or2qnOEF6Et8tr57Wj2YPRB5IUAgpmz
         +NI4Z5/VqKE8BqarTQ3swOYtzfa/nTaIhT1hTUdtiZOaPeFmFVs+CghbwPVkjhp+uYZe
         ZQ3Yry+T3H4pSvziZzcBDrTa0zd0zDybwcSEvOw0iiTUe8QwA8goWozgxKB5mNyH87rf
         JepWtfKsofTR2UFRbCbZWsITDygQX9JJSrumpE2E4PKCH+bIehObliUIEtRz+fcW2BrF
         +CsZx1ZEz56uRxlg6Sa11xZXfALskgqSpK1/i9VMiuI4UrNmheSzk5kd0dh/05xWaiQf
         JeBA==
X-Forwarded-Encrypted: i=1; AJvYcCWHHlxXdRQH5NfFL7VZ57xpX9IDBMyfMkLJ4cq1nQ/aVJU3uaEqnMtKLrhwOK2K/61+hanDh8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmNl+OdWQnpTLVSSSiNc+NsZqw8ApALngWVYM0tUmRVmtQXrVi
	T5cP5sBNmDkwulWMhGQQFyo4xTG2wMT7u4bZ/1RwMjyGWo27ve3xKx353umznw==
X-Google-Smtp-Source: AGHT+IHejnUcO00gdkp6GIPiLQ9d5ZeTLg4Tg4eKKtHh64s2L4WuXTwedaEARJS6sJEf6l71xF95Rw==
X-Received: by 2002:a05:620a:248:b0:7a9:9f44:3f8 with SMTP id af79cd13be357-7b2f3cd68f1mr599328885a.5.1730415219210;
        Thu, 31 Oct 2024 15:53:39 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f820dsm115059585a.32.2024.10.31.15.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:53:38 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:53:38 -0400
Message-ID: <68a956fa44249434dedf7d13cd949b35@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241031_1534/pstg-lib:20241031_1459/pstg-pwork:20241031_1534
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, netdev@vger.kernel.org, audit@vger.kernel.org, netfilter-devel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v3 2/5] LSM: Replace context+len with lsm_context
References: <20241023212158.18718-3-casey@schaufler-ca.com>
In-Reply-To: <20241023212158.18718-3-casey@schaufler-ca.com>

On Oct 23, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the (secctx,seclen) pointer pair with a single
> lsm_context pointer to allow return of the LSM identifier
> along with the context and context length. This allows
> security_release_secctx() to know how to release the
> context. Callers have been modified to use or save the
> returned data from the new structure.
> 
> security_secid_to_secctx() and security_lsmproc_to_secctx()
> will now return the length value on success instead of 0.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: netdev@vger.kernel.org
> Cc: audit@vger.kernel.org
> Cc: netfilter-devel@vger.kernel.org
> Cc: Todd Kjos <tkjos@google.com>
> ---
>  drivers/android/binder.c                |  5 ++-
>  include/linux/lsm_hook_defs.h           |  5 ++-
>  include/linux/security.h                |  9 +++---
>  include/net/scm.h                       |  5 ++-
>  kernel/audit.c                          |  9 +++---
>  kernel/auditsc.c                        | 16 ++++------
>  net/ipv4/ip_sockglue.c                  |  4 +--
>  net/netfilter/nf_conntrack_netlink.c    |  8 ++---
>  net/netfilter/nf_conntrack_standalone.c |  4 +--
>  net/netfilter/nfnetlink_queue.c         | 27 +++++++---------
>  net/netlabel/netlabel_unlabeled.c       | 14 +++------
>  net/netlabel/netlabel_user.c            |  3 +-
>  security/apparmor/include/secid.h       |  5 ++-
>  security/apparmor/secid.c               | 26 +++++++--------
>  security/security.c                     | 34 +++++++++-----------
>  security/selinux/hooks.c                | 23 +++++++++++---
>  security/smack/smack_lsm.c              | 42 +++++++++++++++----------
>  17 files changed, 118 insertions(+), 121 deletions(-)

See my note on patch 1/5, merging into lsm/dev.

--
paul-moore.com

