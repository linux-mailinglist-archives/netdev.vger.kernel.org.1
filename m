Return-Path: <netdev+bounces-233145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140ACC0D04C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 11:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600D93AE4BC
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D2A2F747C;
	Mon, 27 Oct 2025 10:49:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626EB2F6561
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562167; cv=none; b=cCvSq0Q+D6soZY+4vpUh1gzh9LFiEYdTsXHDlvmZDtLLAkmOuf++AcOtn6nnTKPzUNrozn29bVpV/lsb0yEVvlLRRxrcySyZFYaPcIuJxXf6Q4hLuATWTT5XIyTLFZ+M87YjC3cGCPxBcFVQdSojVP+p6rurKOxw0JqfDDIkKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562167; c=relaxed/simple;
	bh=2x4KR0G7UwcPw5kY8y2EBE8YorHPAz2+4JwfNEt525k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tq5OlqjtZc5YsnzK4Yhks4EZ2wQvx7C3k5Dn20wE08THXU4SY2GTcnvFI638DIouxHiSJEFQ2MEDHRScX0ulIQ+tvR57uG16xNjY2cJzPY5bcGz1gLCRn5u5amZNezrjSzJvUnI36cGWVsBlg2bGBxsaHvTgEG2paaUVColdW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so26903735e9.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 03:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761562163; x=1762166963;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0uT5T+CCda9NfmCDxQvE5M5FBpTxCUYhV8ShRWLIe98=;
        b=gDApFFkJ1It7+bi8ZlafPvzgcAG9RjTQhKf6i0mIOGAsAzNsnR8HOyoM9FpSUz25AU
         sQ/4t+yN/bn4MTs+0XRdaWrMq9yKtfIxzbOfzYOwk2Dn+lvI/zc8hxqcPpe83i/CW+FE
         13fu5GkRIt0dmYGFjy168DMHxey48ZwSn4tUWlWd0gVMDSP0diKI/GzCRL7Us+kiLgr7
         WQmX5sKPwd6BCXUBKLvy8xZOyVKCRDW2AmQoT2UG6EirR9YDZ5ooq0kMYDE+eT5MdJgV
         2ZKVYIknUqeuBcLizZJHkC4ER/FFbf5gASoau+BbTHcNHr85vlFV5JL2NLwegqiAS574
         +MUw==
X-Forwarded-Encrypted: i=1; AJvYcCWj/gmCibN8sWMeKM07I3lPgoF1VI5yQTi1/x7SmgyywZLkVBSgkP+EslkXvjGneRu13dW8cLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/cPq/OAgt/Cns+4qh2OetSLDWJIMFRTfnhExNaNi1hSfquTO
	FuO4iOAMBeH0FouzCYiqVSDiiR4JXINnhHGQf4eRfZQZpkg/3CGj8p36
X-Gm-Gg: ASbGncsp5eq1iUL4wdMVHQL2KtJJz1TIUOadMhh6mF/VdbEnRfT5QRwUHNayHw2q9g+
	Hyt+df2DKPvEmnYMfpoAwD57CIphHO3mjNiGA1TLy1zuZp34wDO7uhu5HbuF5HSxk0ExMicMd3C
	7pm4i7UWUTOqI/hzVYvvNwTTz0OEeAg9zv7LOzpxSaOZP6qrds4t8AWnmJVNo/Vx05jZqcTzPKf
	1wLOJTbz6RO+EwEVyo3voW/0oZRJVtj9zQQe9Hi009kDUGKLqDxbJq8uGX87q4ANVleDjUZWGMx
	6eBjKijg+Ets3BrRuQYDTw39LQT8ovzwdrdspgyEmdjiej++9o7zudbOWI4tndJ4ar2GRJRMUpK
	GrJmW5EP+RVKnG0qikqftBW/HCO4eSIkIsU6+GDQK29kiEBYMzULrobNvInD6wvGxdg4VKHuDoZ
	CZsfMc30ZMEx/aqFwTEiJD81Q8d7t+idOl9kJuh8NFPc4+GfhtcpGc9wJ1N+4enIiZ4uM97+Kw
X-Google-Smtp-Source: AGHT+IE6ocL5Th32b34BBOC0L9pFQlFvi/YH+L6cOh1wnI9WJsnVc28ef88WDuXdG9RsxeTD0U0vfQ==
X-Received: by 2002:a05:600d:634f:b0:475:d952:342f with SMTP id 5b1f17b1804b1-475d9523a1amr53410685e9.39.1761562163354;
        Mon, 27 Oct 2025 03:49:23 -0700 (PDT)
Received: from [10.148.83.128] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b43sm13830879f8f.6.2025.10.27.03.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 03:49:21 -0700 (PDT)
Message-ID: <a06ceeb57ba62aeb6df00bd49faad1bb5073321c.camel@fejes.dev>
Subject: Re: [PATCH RFC DRAFT 00/50] nstree: listns()
From: Ferenc Fejes <ferenc@fejes.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, Jeff
 Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, Mike Yuan
 <me@yhndnzj.com>,  Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?=	
 <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, Daan De
 Meyer	 <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, Amir
 Goldstein	 <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
	 <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, Alexander Viro
	 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
  Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Arnd Bergmann	 <arnd@arndb.de>
Date: Mon, 27 Oct 2025 11:49:20 +0100
In-Reply-To: <20251024-rostig-stier-0bcd991850f5@brauner>
References: 
	<20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
	 <f708a1119b2ad8cf2514b1df128a4ef7cf21c636.camel@fejes.dev>
	 <20251024-rostig-stier-0bcd991850f5@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 16:50 +0200, Christian Brauner wrote:
> > > Add a new listns() system call that allows userspace to iterate throu=
gh
> > > namespaces in the system. This provides a programmatic interface to
> > > discover and inspect namespaces, enhancing existing namespace apis.
> > >=20
> > > Currently, there is no direct way for userspace to enumerate namespac=
es
> > > in the system. Applications must resort to scanning /proc/<pid>/ns/
> > > across all processes, which is:
> > >=20
> > > 1. Inefficient - requires iterating over all processes
> > > 2. Incomplete - misses inactive namespaces that aren't attached to an=
y
> > > =C2=A0=C2=A0 running process but are kept alive by file descriptors, =
bind mounts,
> > > =C2=A0=C2=A0 or parent namespace references
> > > 3. Permission-heavy - requires access to /proc for many processes
> > > 4. No ordering or ownership.
> > > 5. No filtering per namespace type: Must always iterate and check all
> > > =C2=A0=C2=A0 namespaces.
> > >=20
> > > The list goes on. The listns() system call solves these problems by
> > > providing direct kernel-level enumeration of namespaces. It is simila=
r
> > > to listmount() but obviously tailored to namespaces.
> >=20
> > I've been waiting for such an API for years; thanks for working on it. =
I
> > mostly
> > deal with network namespaces, where points 2 and 3 are especially painf=
ul.
> >=20
> > Recently, I've used this eBPF snippet to discover (at most 1024, becaus=
e of
> > the
> > verifier's halt checking) network namespaces, even if no process is
> > attached.
> > But I can't do anything with it in userspace since it's not possible to=
 pass
> > the
> > inode number or netns cookie value to setns()...
>=20
> I've mentioned it in the cover letter and in my earlier reply to Josef:
>=20
> On v6.18+ kernels it is possible to generate and open file handles to
> namespaces. This is probably an api that people outside of fs/ proper
> aren't all that familiar with.
>=20
> In essence it allows you to refer to files - or more-general:
> kernel-object that may be referenced via files - via opaque handles
> instead of paths.
>=20
> For regular filesystem that are multi-instance (IOW, you can have
> multiple btrfs or ext4 filesystems mounted) such file handles cannot be
> used without providing a file descriptor to another object in the
> filesystem that is used to resolve the file handle...
>=20
> However, for single-instance filesystems like pidfs and nsfs that's not
> required which is why I added:
>=20
> FD_PIDFS_ROOT
> FD_NSFS_ROOT
>=20
> which means that you can open both pidfds and namespace via
> open_by_handle_at() purely based on the file handle. I call such file
> handles "exhaustive file handles" because they fully describe the object
> to be resolvable without any further information.
>=20
> They are also not subject to the capable(CAP_DAC_READ_SEARCH) permission
> check that regular file handles are and so can be used even by
> unprivileged code as long as the caller is sufficiently privileged over
> the relevant object (pid resolvable in caller's pid namespace of pidfds,
> or caller located in namespace or privileged over the owning user
> namespace of the relevant namespace for nsfs).
>=20
> File handles for namespaces have the following uapi:
>=20
> struct nsfs_file_handle {
> 	__u64 ns_id;
> 	__u32 ns_type;
> 	__u32 ns_inum;
> };
>=20
> #define NSFS_FILE_HANDLE_SIZE_VER0 16 /* sizeof first published struct */
> #define NSFS_FILE_HANDLE_SIZE_LATEST sizeof(struct nsfs_file_handle) /* s=
izeof
> latest published struct */
>=20
> and it is explicitly allowed to generate such file handles manually in
> userspace. When the kernel generates a namespace file handle via
> name_to_handle_at() till will return: ns_id, ns_type, and ns_inum but
> userspace is allowed to provide the kernel with a laxer file handle
> where only the ns_id is filled in but ns_type and ns_inum are zero - at
> least after this patch series.
>=20
> So for your case where you even know inode number, ns type, and ns id
> you can fill in a struct nsfs_file_handle and either look at my reply to
> Josef or in the (ugly) tests.
>=20
> fd =3D open_by_handle_at(FD_NSFS_ROOT, file_handle, O_RDONLY);
>=20
> and can open the namespace (provided it is still active).
>=20
> >=20
> > extern const void net_namespace_list __ksym;
> > static void list_all_netns()
> > {
> > =C2=A0=C2=A0=C2=A0 struct list_head *nslist =3D=C2=A0
> > 	bpf_core_cast(&net_namespace_list, struct list_head);
> >=20
> > =C2=A0=C2=A0=C2=A0 struct list_head *iter =3D nslist->next;
> >=20
> > =C2=A0=C2=A0=C2=A0 bpf_repeat(1024) {
>=20
> This isn't needed anymore. I've implemented it in a bpf-friendly way so
> it's possible to add kfuncs that would allow you to iterate through the
> various namespace trees (locklessly).
>=20
> If this is merged then I'll likely design that bpf part myself.

Excellent, thanks for the detailed explanation, noted! Well I guess I have =
to
keep my eyes closer on recent ns changes, I was aware of pidfs but not the
helpers you just mentioned.

>=20
> > After this merged, do you see any chance for backports? Does it rely on
> > recent
> > bits which is hard/impossible to backport? I'm not aware of backported
> > syscalls
> > but this would be really nice to see in older kernels.
>=20
> Uhm, what downstream entities, managing kernels do is not my concern but
> for upstream it's certainly not an option. There's a lot of preparatory
> work that would have to be backported.

I was curious about the upstream option, but I see this isn't feasible. Any=
way,
its great we will have this in the future, thanks for doing it!

Ferenc

