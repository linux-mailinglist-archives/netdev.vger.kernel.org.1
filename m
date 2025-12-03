Return-Path: <netdev+bounces-243449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A423CA182B
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 21:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A2E03008D69
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 20:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A2D2980A8;
	Wed,  3 Dec 2025 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gua5w8vu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357329C347
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764792122; cv=none; b=JZt3NQcwaJp84kdc793Kmq2671zOOkaf/nJTEHq6uraPUyLnz+tTgQC3Vayu3//Jt3BUBJvzD7dkr4sMg6+zjHPxbrDwF7otAibSD0UhjvxQN9mlNykKHcXTosJeHl0uIXI9xl17WZCa76uaxzhOFr64m+amjZGkNxGvbtzj7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764792122; c=relaxed/simple;
	bh=hbRxPzrFs0+hdOQNG7cizB6rmMqCryN13XBu971WWrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vESu7/L4lVd4NMb84Uyn5hCXRTwrgvJ+ZWPtx0gSI+Zh8sHI+nL3Hy3X71UGw2D+QQTcxt1+Q0M5ONrTTdDnvuKkaKF82V4rnMcnvU9Bpndzq0E/ghtrmvdIGsm4AFQIUWOXxJ7tt0/R/I3tbGnzyYzJyPH2B8vLjIbPbbJblNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gua5w8vu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2981f9ce15cso2107765ad.1
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 12:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764792116; x=1765396916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWaqHaC4GF2GSiscDP1QV02fWUrsKcrNYOyAr5e3bj4=;
        b=Gua5w8vuNJ0CIFuzPH5VMXH+Unqz3dxMkoqGogUFBB+/hM9CqQmuyIED5ze48QVDC7
         F6xjoTrULY5M7EqT+AJZD0hvqAMNJ+PRrlr6Inntq3kBJ++u/tLReaA3IV1lS0zOemH2
         b98G4f/j+wrWww+ymeJ+M9jZJuFujJi2Tl+6K8JwPFpHPssQKU0/P5lu18EXGIWaXATB
         PSH2hLh2kN6uZUfSCgb3MtXCNtgVXfbIPyMVI7dOhDuHYJZig8JspbUyPrEoE7Hexahz
         pKg0AU3P0vZH0gGCXzCJosTJIMSFqKCpf1JnHfZyKwIgNEpRufT8Jeldhz1ihTYtv/QT
         dB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764792116; x=1765396916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lWaqHaC4GF2GSiscDP1QV02fWUrsKcrNYOyAr5e3bj4=;
        b=lML9iwYA8AmsUXueh3ExVPWiOOCP4DEGqhbD0O9r9uMCMraaBpZGp6SsAlaX7d8BkS
         HtrXWGFxuHy7WDpl4vx+oSSkG+3SihUGG4OG5UlhqlPSb/B8uhs7/T10Jj+o9g3pVXv/
         7jeFTg7YgqORM7lVVmPO3mZemnxfs0wq+XRjCQbyUlT6nZbELkTsg8Ezi8LDDPJPbXyl
         atoEvWfZz6COUHFFfRTjV3FihtBnH24H0JIiWn9btfqtXoWv0rF7oYC39Ve4ZWrUlPha
         6Eh0c+d6Oh8b4N/lSNxu28G4alreQYyckWt6fFydqdpV+JkTs1TZIqBGejWgM2QY+gAr
         efZw==
X-Forwarded-Encrypted: i=1; AJvYcCXx7GFkFp/2rbIj+dVwqv14pQEXI9rue+FD6arZKvQDz/hqY0AIXXRfRNpMdLBBG+yb3B+tejc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFltq7lwYtW5Fz8ItKJBJ2qHdflTy3P44CTvRtqzp8aQjVIsiM
	CLodlN6S4WGh4+ACsOHn/MfekMoJn46V4bTJ+ar4IsejghcNknFUi3NnlPr57WhbdbSl8wx4gPm
	VlNwpBlCO69TRGkDJOg4IQf6rKz/nx0Q=
X-Gm-Gg: ASbGnctnZsjGh0OYORHDoSiSqrYSxM4PZGJpwEAgMSUzdO75Q2vn7SqOnX/7+1sZUZw
	prztrvWs4cFc9Pw4FFsdlrcS7QlmngiZFiZNphS7rttGihTzVDl288oFYdWvQpNLRRSKhZZnvc1
	ChzgGnwPKXP2j0ujT2nxiAAUtM2ajedF5D4U3pEitQbovE+Ich/Pa+y2Xo4Cx43fBlU9qmntP0B
	eNX4pe4KDLL4hxiPNOJU3iX6eywJ51dDsi7rOkl6PLGobrbI8mbotvCyrcW5ZN47VSQebs=
X-Google-Smtp-Source: AGHT+IFMW2zvGnUfsXUU0ZfhpGZCjO/uFcPG/fkXmof4XTwIGBBP8YMgombNXaZ4eGJxAoBe7L60wBZMW3zl1igUF10=
X-Received: by 2002:a17:903:1aec:b0:298:485d:556b with SMTP id
 d9443c01a7336-29d6833a74fmr38470125ad.5.1764792116164; Wed, 03 Dec 2025
 12:01:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
 <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com>
 <6797b694-6c40-4806-9541-05ce6a0b07fc@oracle.com> <CAHC9VhQsK_XpJ-bbt6AXM4fk30huhrPvvMSEuHHTPb=eJZwoUA@mail.gmail.com>
 <CAHC9VhQnR6TKzzzpE9XQqiFivV0ECbVx7GH+1fQmz917-MAhsw@mail.gmail.com>
 <CAEjxPJ7_7_Uru3dwXzNLSj5GdBTzdPDQr5RwXtdjvDv9GjmVAQ@mail.gmail.com>
 <CAHC9VhQDHTNkrB4YuNoafM0bhAav=CP5Ux6ZZGY9+WF0+0_9ww@mail.gmail.com> <CAEjxPJ6e8z__=MP5NfdUxkOMQ=EnUFSjWFofP4YPwHqK=Ki5nw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6e8z__=MP5NfdUxkOMQ=EnUFSjWFofP4YPwHqK=Ki5nw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 3 Dec 2025 15:01:45 -0500
X-Gm-Features: AWmQ_bmK8IWF69Ya7Il-q1NU_c222p9dRgleuYlQl2p8kptbZYlJgZKkfKVtZaM
Message-ID: <CAEjxPJ4T4srp91xsfbVd357Fhwb6Mx_3RGxCHT8Tnk_zk38m+g@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Paul Moore <paul@paul-moore.com>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 1:08=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Dec 3, 2025 at 10:55=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Wed, Dec 3, 2025 at 10:35=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, Jul 23, 2025 at 10:10=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > On Thu, Jun 19, 2025 at 5:18=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > > On Tue, May 27, 2025 at 5:03=E2=80=AFPM Anna Schumaker
> > > > > <anna.schumaker@oracle.com> wrote:
> > > > > > On 5/20/25 5:31 PM, Paul Moore wrote:
> > > > > > > On Tue, Apr 29, 2025 at 7:34=E2=80=AFPM Paul Moore <paul@paul=
-moore.com> wrote:
> > > > > > >> On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> > > > > > >> <stephen.smalley.work@gmail.com> wrote:
> > > > > > >>>
> > > > > > >>> Update the security_inode_listsecurity() interface to allow
> > > > > > >>> use of the xattr_list_one() helper and update the hook
> > > > > > >>> implementations.
> > > > > > >>>
> > > > > > >>> Link: https://lore.kernel.org/selinux/20250424152822.2719-1=
-stephen.smalley.work@gmail.com/
> > > > > > >>>
> > > > > > >>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.=
com>
> > > > > > >>> ---
> > > > > > >>> This patch is relative to the one linked above, which in th=
eory is on
> > > > > > >>> vfs.fixes but doesn't appear to have been pushed when I loo=
ked.
> > > > > > >>>
> > > > > > >>>  fs/nfs/nfs4proc.c             | 10 ++++++----
> > > > > > >>>  fs/xattr.c                    | 19 +++++++------------
> > > > > > >>>  include/linux/lsm_hook_defs.h |  4 ++--
> > > > > > >>>  include/linux/security.h      |  5 +++--
> > > > > > >>>  net/socket.c                  | 17 +++++++----------
> > > > > > >>>  security/security.c           | 16 ++++++++--------
> > > > > > >>>  security/selinux/hooks.c      | 10 +++-------
> > > > > > >>>  security/smack/smack_lsm.c    | 13 ++++---------
> > > > > > >>>  8 files changed, 40 insertions(+), 54 deletions(-)
> > > > > > >>
> > > > > > >> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and =
Smack
> > > > > > >> folks I can pull this into the LSM tree.
> > > > > > >
> > > > > > > Gentle ping for Trond, Anna, Jakub, and Casey ... can I get s=
ome ACKs
> > > > > > > on this patch?  It's a little late for the upcoming merge win=
dow, but
> > > > > > > I'd like to merge this via the LSM tree after the merge windo=
w closes.
> > > > > >
> > > > > > For the NFS change:
> > > > > >     Acked-by: Anna Schumaker <anna.schumaker@oracle.com>
> > > > >
> > > > > Hi Anna,
> > > > >
> > > > > Thanks for reviewing the patch.  Unfortunately when merging the p=
atch
> > > > > today and fixing up some merge conflicts I bumped into an odd cas=
e in
> > > > > the NFS space and I wanted to check with you on how you would lik=
e to
> > > > > resolve it.
> > > > >
> > > > > Commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
> > > > > security label")[1] adds a direct call to
> > > > > security_inode_listsecurity() in nfs4_listxattr(), despite the
> > > > > existing nfs4_listxattr_nfs4_label() call which calls into the sa=
me
> > > > > LSM hook, although that call is conditional on the server support=
ing
> > > > > NFS_CAP_SECURITY_LABEL.  Based on a quick search, it appears the =
only
> > > > > caller for nfs4_listxattr_nfs4_label() is nfs4_listxattr() so I'm
> > > > > wondering if there isn't some room for improvement here.
> > > > >
> > > > > I think there are two obvious options, and I'm curious about your
> > > > > thoughts on which of these you would prefer, or if there is anoth=
er
> > > > > third option that you would like to see merged.
> > > > >
> > > > > Option #1:
> > > > > Essentially back out commit 243fea134633, removing the direct LSM=
 call
> > > > > in nfs4_listxattr() and relying on the nfs4_listxattr_nfs4_label(=
) for
> > > > > the LSM/SELinux xattrs.  I think we would want to remove the
> > > > > NFS_CAP_SECURITY_LABEL check and build nfs4_listxattr_nfs4_label(=
)
> > > > > regardless of CONFIG_NFS_V4_SECURITY_LABEL.
> > > > >
> > > > > Option #2:
> > > > > Remove nfs4_listxattr_nfs4_label() entirely and keep the direct L=
SM
> > > > > call in nfs4_listxattr(), with the required changes for this patc=
h.
> > > > >
> > > > > Thoughts?
> > > > >
> > > > > [1] https://lore.kernel.org/all/20250425180921.86702-1-okorniev@r=
edhat.com/
> > > >
> > > > A gentle ping on the question above for the NFS folks.  If I don't
> > > > hear anything I'll hack up something and send it out for review, bu=
t I
> > > > thought it would nice if we could sort out the proper fix first.
> > >
> > > Raising this thread back up again to see if the NFS folks have a
> > > preference on option #1 or #2 above, or
> > > something else altogether. Should returning of the security.selinux
> > > xattr name from listxattr() be dependent on
> > > NFS_CAP_SECURITY_LABEL being set by the server and should it be
> > > dependent on CONFIG_NFS_V4_SECURITY_LABEL?
> >
> > Thanks for bringing this back up Stephen, it would be good to get this =
resolved.
>
> On second look, I realized that commit 243fea134633 ("NFSv4.2: fix
> listxattr to return selinux security label") was likely motivated by
> the same issue as commit 8b0ba61df5a1c44e2b3cf6 ("fs/xattr.c: fix
> simple_xattr_list to always include security.* xattrs"), i.e. the
> coreutils change that switched ls -Z from unconditionally calling
> getxattr("security.selinux") (via libselinux getfilecon(3)) to only
> doing so if listxattr() returns the "security.selinux" xattr name.
> Hence, we want the call to security_inode_listsecurity() to be
> unconditional, which favors option #2. My only residual question
> though is that commit 243fea134633 put the call _after_ fetching the
> user.* xattr names, whereas the nfs4_listxattr_nfs4_label() returns it
> _before_ any user.* xattrs are appended. I'd be inclined to move up
> the security_inode_listsecurity() call to replace the
> nfs4_listxattr_nfs4_label() call along with option #2.

I've made an attempt to unify the two security_inode_listsecurity()
hook calls in the nfs4 code into a single, unconditional call from
nfs4_listxattr(), which can be found here:
https://lore.kernel.org/selinux/20251203195728.8592-1-stephen.smalley.work@=
gmail.com/T/#u

If this is deemed acceptable by the NFS folks, then I can re-base this
patch on top of that one.

