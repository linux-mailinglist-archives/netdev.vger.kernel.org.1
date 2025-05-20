Return-Path: <netdev+bounces-192051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F8EABE61A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 23:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D42B3BD7F6
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 21:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB45825E47E;
	Tue, 20 May 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S8qv0ptS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000424EF7B
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747776691; cv=none; b=PMMr83K5/Rymp8g6cDG84RVQnjpELzPNfIq9vqoW03wkSAn5neXfqXc6epb0EADI3vLSpue97dTt0mmE/t2VwvMMrwXiNgcQiXtYGgSwA7LnnpZfsaXqkz/aKAOW2Kg0NNVyUt/x7Xwj7b+nOZBFCc3v1PlCTSRNmzZVCFplNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747776691; c=relaxed/simple;
	bh=Rp/sSKtoxvD0xDJUL1ax9jsR8XaN1Db+UrRlq03guhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfmwZC1B2TgNlyD7SMxSB+TLjRzjd/cs1tgmoIoQ8U9dVHsAsp+aqN8/rTdU97G/H7HIBQqthIfgzKJMw0SvhiTIx2vVFwPh59kW5IooPOfoLZF1dAw/v9IzexdPYvbjXeoIkAaRsKpLKkBAUKoXMziMTUWyacWt1VimE+Blw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S8qv0ptS; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7c5d470a8bso2773437276.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747776688; x=1748381488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YexwMppYcbZe/m8aCqtTjf6L6bo5b6rZLX60EXLxJJM=;
        b=S8qv0ptS+qog4CXjQizT49B9eBq/MmCkIY1IMNxSyXdIxqlk0sxQVA1BqhkK/bwIgK
         O4S/DVWObFNCdXo44Bq1/CGkjk8OijwXVuD71UnHg36INVS81QBRvD/ZjEaOiupFg/0b
         m9VEwcA/yZzDm0AeC0g6qXNG/ZUYMSA4kAR8xObmtuWeljORdLY7BciHMBc8AoOZ9n35
         E4LRowUaRBt4Vlq7fJ6/5elJpHdlvDK0r2Rq4rdWbmkFlov2umkXFENBrWg3kSculIXX
         rPZKLrW+I17nJ8OqOlj1uxiRMcPg4k15n9QuFRfLxHNbl2PVnyIJYoH7kfZvyF5W2Mfr
         HrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747776688; x=1748381488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YexwMppYcbZe/m8aCqtTjf6L6bo5b6rZLX60EXLxJJM=;
        b=rzetHo9lrkYZQ6QCxrLBU/soY9oaH4tCsvV+sSJ/nLaIW6ZX41a/fdA8qqhVJnpF0R
         H7t96nqScngLVNHz8TYc2bEp8Mc+qLSsuysPbL2/za28tBknKe1GbGv7UNBp8oCgL7fH
         6nlchmxVbev/wrTsedXNvSHwo+Xk7fwFtQ+kMSLrcM3pynfrAqC/Rd9OU/EgUT2FD9NI
         /HH2qwwgLVxM2O/5I/ILkqkMwP09xP66kw3KclTw9as0eVe6OEegw73+ch5fc9WE4wyB
         9dcKOzYA5WJKBV2o9cmtjtqPjUlQmjKn1wEIOcdxQ/q2vC+PhkCQCVARNC/5je3enQXa
         YhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHapozBx25kZwWtCwBCkelM75SMJITCNddgag/yPPVcQK09vyBgoKQcCUpvTic9HL+gK/fql4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzogTfYxBkNMrM0uoOebpwljCJUuFBvS5Ksg3uXwPA8fB4+du/2
	xifAeESXOc+vRm9EMsx7trDTcC+UVPXF0CMZSV7U+95XcX8r/QWcYr0FbO0LMd5RdKOUHLmBJuo
	JPSU3JR9YdDQSlCn1gwxBQ8uPoQWmrnJ58Y+5KTRs
X-Gm-Gg: ASbGncuJRamcF/S86ixfXW9g/E5KwbUfHpiUAtwdgIJM1WRBPdkuqi3Mjyk65R2YKBj
	Xko+D9CtTN5bco/3Vj4xGLUe2xpUMtNtQ3RUp16B1xC3wQL3xdprCem/xYn7Y8el48U5smy51nG
	gRh0om3BXAciqiQ+5V+Uker/Uq1t+XQ16W
X-Google-Smtp-Source: AGHT+IGZ/rtogvtb9mmq771rmbik+el6dyUZ8s9kwWv9ZNx2CrYoN2T0d4tY5zplAYSZmSb/J7/BxKaHsq01XwQ2/QQ=
X-Received: by 2002:a05:6902:6c12:b0:e7d:585d:6aac with SMTP id
 3f1490d57ef6-e7d585d6f25mr2740629276.39.1747776688624; Tue, 20 May 2025
 14:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com> <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
In-Reply-To: <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 May 2025 17:31:17 -0400
X-Gm-Features: AX0GCFsKbQqPlLe-FjaU6xxZxNkDN5cHZfC1VDbTRZv-QCv_QCmlg4xFRTHqelQ
Message-ID: <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 7:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Update the security_inode_listsecurity() interface to allow
> > use of the xattr_list_one() helper and update the hook
> > implementations.
> >
> > Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.sma=
lley.work@gmail.com/
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > This patch is relative to the one linked above, which in theory is on
> > vfs.fixes but doesn't appear to have been pushed when I looked.
> >
> >  fs/nfs/nfs4proc.c             | 10 ++++++----
> >  fs/xattr.c                    | 19 +++++++------------
> >  include/linux/lsm_hook_defs.h |  4 ++--
> >  include/linux/security.h      |  5 +++--
> >  net/socket.c                  | 17 +++++++----------
> >  security/security.c           | 16 ++++++++--------
> >  security/selinux/hooks.c      | 10 +++-------
> >  security/smack/smack_lsm.c    | 13 ++++---------
> >  8 files changed, 40 insertions(+), 54 deletions(-)
>
> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
> folks I can pull this into the LSM tree.

Gentle ping for Trond, Anna, Jakub, and Casey ... can I get some ACKs
on this patch?  It's a little late for the upcoming merge window, but
I'd like to merge this via the LSM tree after the merge window closes.

Link to the patch if you can't find it in your inbox:
https://lore.kernel.org/linux-security-module/20250428195022.24587-2-stephe=
n.smalley.work@gmail.com/

--
paul-moore.com

