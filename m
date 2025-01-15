Return-Path: <netdev+bounces-158594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8C8A129D7
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 18:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CF53A07FF
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559A619DF5B;
	Wed, 15 Jan 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TRIUlqMJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1243ACB
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962154; cv=none; b=WMoi9lmyPweW0TdnZ8i4hmsDHIRqnal1b1BsGrG61Cb9q0gFwvx8VhxIRk+oioTGSU3GW7PHE+3vbB9IXuTaNlwxm/NGm5G3PcrMrHT1T9F0YYqXz07OZfNN+B4Xr99kC/pJDedTKkdmjsY8p5MRWZisRA1kQnzr07mukEWFy/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962154; c=relaxed/simple;
	bh=3Z1wSVgu9DX6AWGrnMgDcHJwzXFHWiHjrrJ4Z85mw/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSDepodudEPUV0VDS+iYtDxh+YYWEIWAokD8arRa1A9ZpfAOzIih2fGWFc8iM5Ge/qaMTKaCmJJFP6LYf7rWHWooAO+iYUxBHB7e4ca1eywTs0YwRNYckNAFtz4IuXsjqQAct/msDOR+1gkdh/xZ1SaLyAGzTv5dLFuC0hSOJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TRIUlqMJ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e46ebe19489so10321888276.2
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736962151; x=1737566951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ho5vWfIyGqdayu0mn5cAMk4IND86P5Ih3gYUlwO5LM=;
        b=TRIUlqMJE7d1zVK9ChVpv7d6ClUBY/2hoiK+SOVUclGH6kA5eY2bFaGIzGLXRArIpT
         iQBva0NCv/M2jM61LEsXvGZ6hA7CWda125KdpOsjXAwP2RUZh9QTTBKfEsC0nc3LTbpg
         wUlMS/B2JSLsJIKC+JVa/jOvbUBU1loq4QWabxkAuB9YdFcPH/IMsOgYCYxgfeJDTfr6
         iZHMjt7zNZJvnAKTDB4ACEmN3Nvyrx+3wQ3Ilz9qhc4qzmfLOKD2Qq6WlmzrjTJBQOm+
         mopnlxZsN6rlh97C5tQCN6QdVGpA6cL5C8lYSb9Cm+xzajIoYwv2tCQHOiXIEvis0PSj
         o5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736962151; x=1737566951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ho5vWfIyGqdayu0mn5cAMk4IND86P5Ih3gYUlwO5LM=;
        b=PZJ/5dDX7inMDo7MHQCkRrqCuI+jjh7fuIIMaOYLBCL/cJOVzIYh8A0eKAB/4Dsb6r
         wXp16U59Vz83TEuPXZOdja8UB9BafsFO/fIvqdx318VhRfWLR7Q1a/0iKVfceFk+8454
         EXzDfppHuvL70ZjiF4s6gGoGF1FVoikIXCNmJBaFdOx+jQJ7rJ9I4U3IPtqkeMAvCexK
         0Ou9ekHlME7QmiQCU/jHO9jL4904pB1/LHvElIYvnXs3GnUUs2XzoY/ex0jX5JgRGqcY
         S+Np82rbcYnerBY6JX07Y0gukGnO3B8ILP2wYuL2k3qOFOOERncPsRUy7Ddl5Y6xfJuc
         XfuA==
X-Forwarded-Encrypted: i=1; AJvYcCUX1AXcsQw7A8h00j/pA8qplgCIxiabgGj0Lw+d6Qu9C94KsxB2YxgAgCQ5obMTb9UqDQjBKxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5k1dJWf5NKOT/Lz2qzex/ORV6szL5e6CU6mfObVendYLxP2cG
	kj1typz5wmiHNKka99p5SieUKIyL9XnXkmas2PUvp7WExg+ZQ4+HwRY2mG9gypD0jkc4m8Awz+K
	rjjAOfA8DZIXSQbbulZKQuOyni6KKtByB686J
X-Gm-Gg: ASbGncvhc9JRHeqWZII02m+PKYVXRZY0o6E9hfsqzUVAvEm2cVj61+Ot3vfcBe9lgJv
	hg7ZZ/O0kav9VeuINujr0KsAveFJdXk/Ea5bl
X-Google-Smtp-Source: AGHT+IHS9tYzd/oT/05LvfCuU2hNDmtanssgntueoSZkgq3iiJ1Lv/I4SGzz67OKeocKZFDPgvn7fKFXoNeXkBKiHdY=
X-Received: by 2002:a25:200b:0:b0:e53:b023:70a7 with SMTP id
 3f1490d57ef6-e54ee17e99emr16507763276.22.1736962151420; Wed, 15 Jan 2025
 09:29:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108231554.3634987-1-tweek@google.com> <266861ab-cc0d-4a7c-9804-6bf4670868b1@6wind.com>
In-Reply-To: <266861ab-cc0d-4a7c-9804-6bf4670868b1@6wind.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Jan 2025 12:29:00 -0500
X-Gm-Features: AbW1kvYRgCbUKUHzVWUmDyI1Ip0ALStXj7NY0DVlm3abI5HxYcmUbQZx-kxTFEQ
Message-ID: <CAHC9VhTFBPG2Ai7zT80m=Ez7RRN5J+1rA+n=q4SrAjrVvs+Dpw@mail.gmail.com>
Subject: Re: [PATCH] selinux: map RTM_DELNSID to nlmsg_write
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	nicolas.dichtel@6wind.com
Cc: "David S . Miller" <davem@davemloft.net>, selinux@vger.kernel.org, 
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 4:24=E2=80=AFAM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
> Le 09/01/2025 =C3=A0 00:15, Thi=C3=A9baud Weksteen a =C3=A9crit :
> >
> > The mapping for RTM_DELNSID was added in commit 387f989a60db
> > ("selinux/nlmsg: add RTM_GETNSID"). While this message type is not
> > expected from userspace, other RTM_DEL* types are mapped to the more
> > restrictive nlmsg_write permission. Move RTM_DELNSID to nlmsg_write in
> > case the implementation is changed in the future.
>
> Frankly, I don't think this will ever change. It's not a problem of imple=
menting
> the delete command, it's conceptually no sense.
>
> I don't see why the DEL should be restricted in any way.

While the RTM_DELNSID messages are not generated from userspace, the
presence of the SELinux access control point is visible to userspace
and thus we have to worry about the backwards compatibility impact of
changing a "read" operation to a "write" operation.

We could likely have a discussion about which is a better permission
mapping for RTM_DELNSID, read or write, but ultimately I think this
should probably be treated as a read operation since the kernel is
using this simply as a notification message.  Sending, or receiving, a
RTM_DELNSID message doesn't affect the state of the netns ID, or the
netns itself; in other words, a RTM_DELNSID is not the cause of netns
state change, it is a notification artifact of such a change.  Leaving
this mapped as a "read" operation seems correct to me.

It is also worth noting that the SELinux netlink xperms support that
will ship for the first time in v6.13 will allow policy developers to
target RTM_DELNSID messages with much greater permissions granularity,
largely solving this problem for those who care about it.

Finally, looking at unhash_nsid(), the only place which seems to
generate RTM_DELNSID notification messages, an access control denial
on the netlink notification operation will have no impact on the
removal of the netns or the netns ID, only the notification itself
should be impacted.

--=20
paul-moore.com

