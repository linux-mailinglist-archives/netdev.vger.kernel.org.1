Return-Path: <netdev+bounces-158656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86420A12DFA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF00E1888C66
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11121DB13B;
	Wed, 15 Jan 2025 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQKbtbOj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C614F12D
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736978162; cv=none; b=SZ+bBmhyN/KNVBCC34XiKIX1CIGOxI2HucBp1FZaYBC1pJTUodBqyU3X7tN0vXaBkZY4Tscac672bwaRBIH5fYmgRQ4X1S/ytPPOYlSBfwnYBwZBbKgrvwcgebaiTJM0FJqrnS0eQ97h5KJox0r4ZiY94VR8eMRIoD+mzPqYskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736978162; c=relaxed/simple;
	bh=C4VLBJzPBpAwYolk7n9Iw5sT6nUxlMb2oibYKArKT6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H93Ko72Oytk71QABNMxCN/S1LBGMb0wj0jSGh0UWWiCZDS4EN8JNUMiEqVeAlnY0+Ld0HHN3qN7YfvnQ5wUdiMU7ZMnm0UBo3PS5DyX27JoqlL11OqMBtjSUsCdlV8uN2JJJtqgvjLz0R7rhmYSDSr5/OaAbCLwMflTFhBJS6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQKbtbOj; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53e64f3c7d0so1954e87.0
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736978159; x=1737582959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hns+SMO/Ao9YuYT65xxYfiz6buCFo3AsAultAnKCQ1w=;
        b=BQKbtbOjQQVMhKdgwioS1ejxeo43XA01CjvxXW7/X+OfwZjvSQQeVI6eFHiahRug+1
         b9ZpcMq7rmjDglOLk5bTHwraDtEm2DqmTk3CQKuShItqTYhaUrYnlC0lXpFgX83ChDT6
         Tk7QFmkUF3lrnqTBjF3XBderihdpAQ9aFKVf8v47QB09M8pMJcCEbG1DIjJgjxO7X2d2
         tE+SLieW9wjzNyFqYRoy9BPx0EhVcBmeNkBdFzB9oxXYgG3HQopOwRlEPw8G9j1Pn1ck
         uc6z8V/w5TSodIEaRtsli8Fs5o/IPAZ1sHdmTzc7BvwMZzT+eN1d0Yn1RFJCTlmV7Pbp
         5ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736978159; x=1737582959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hns+SMO/Ao9YuYT65xxYfiz6buCFo3AsAultAnKCQ1w=;
        b=OL09+0RIvPE+XxvH7AL9z7F0FSlXack5Yd4/oJcSuea8WyjTaqCbBUb5bc9RzDP2D/
         K7su9QPGQ55HaoTxSu9I+se+KKJWyXlj1ZEPBjlFJXRVwYU1CuakgqtN0RweW44YvP9Y
         1050MC9VYpiLNOA3r/xXEWNv8P88O086Mcnm6N9wDlAPqhXkiI3qQIRszw1pGjhxPqTZ
         7LXg9l7OQ+blnzm0cetVuXCPsppKwFbG+rM6nh/OI24/h5G9uI5TIGW8Pq8kt/mZ5Ka9
         Nk9JSLvxtAzVQRt4ZugQ1oQ0Ln0lH7FBHv+jYAm7tssxxWtryCHym5qFXIal4Xn2tRfJ
         HDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx//nz09BRYwUHJpaGWogJ8lppNZ44d82NO6NZd7QQxcL7sUE2boPLmn0jUSb0mwdFHtwPYiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7gsmOubDO12Jgwj/J3qh/xNs2FTyWbw6OawWh7Vrl1nNTnCT
	5PvA6Kqqai8tKkBgZbMhACEUhSGZnMsW9Xfz4Au0T4PCgWK2IiR7ONU5KnoKUHvpjVZdyLDVUT9
	uFDdfVh/FnXn85F5vFAr/z1KENGsjO9AmcW1oAKdVlIWCrTij+T5z
X-Gm-Gg: ASbGncv1yryp2Bqi1svI8jREg8H990cHegDmUvkWOHSmoErdqvOB18RpiHcQKWQEo7K
	p1lDcaGNuEqXAm38gJHY8ra1svZU1xUp9Mvi0Lw==
X-Google-Smtp-Source: AGHT+IGTV6ubfbmZ9HdqjvdhW/BnJYZtaGRJECv23F8XKO9TCEAFvfjBcaGr8u0+8YFr43+cogVdF5PFS6ifymptHiI=
X-Received: by 2002:a05:6512:982:b0:542:7130:bad2 with SMTP id
 2adb3069b0e04-542f46b229amr10124e87.5.1736978158947; Wed, 15 Jan 2025
 13:55:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108231554.3634987-1-tweek@google.com> <266861ab-cc0d-4a7c-9804-6bf4670868b1@6wind.com>
 <CAHC9VhTFBPG2Ai7zT80m=Ez7RRN5J+1rA+n=q4SrAjrVvs+Dpw@mail.gmail.com>
In-Reply-To: <CAHC9VhTFBPG2Ai7zT80m=Ez7RRN5J+1rA+n=q4SrAjrVvs+Dpw@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 16 Jan 2025 08:55:41 +1100
X-Gm-Features: AbW1kvZE6yaIQBrluZBM2IBghqmkgTZ0CZ6JYC27IEVNIDDuS0uE4-gyyI8iJX4
Message-ID: <CA+zpnLe5X3jcjF2=A72Bgpxt7wDrSgK0Y29h42mttTDr6vk9NA@mail.gmail.com>
Subject: Re: [PATCH] selinux: map RTM_DELNSID to nlmsg_write
To: Paul Moore <paul@paul-moore.com>
Cc: nicolas.dichtel@6wind.com, "David S . Miller" <davem@davemloft.net>, selinux@vger.kernel.org, 
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 4:29=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jan 9, 2025 at 4:24=E2=80=AFAM Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
> > Le 09/01/2025 =C3=A0 00:15, Thi=C3=A9baud Weksteen a =C3=A9crit :
> > >
> > > The mapping for RTM_DELNSID was added in commit 387f989a60db
> > > ("selinux/nlmsg: add RTM_GETNSID"). While this message type is not
> > > expected from userspace, other RTM_DEL* types are mapped to the more
> > > restrictive nlmsg_write permission. Move RTM_DELNSID to nlmsg_write i=
n
> > > case the implementation is changed in the future.
> >
> > Frankly, I don't think this will ever change. It's not a problem of imp=
lementing
> > the delete command, it's conceptually no sense.
> >
> > I don't see why the DEL should be restricted in any way.
>
> While the RTM_DELNSID messages are not generated from userspace, the
> presence of the SELinux access control point is visible to userspace
> and thus we have to worry about the backwards compatibility impact of
> changing a "read" operation to a "write" operation.
>
> We could likely have a discussion about which is a better permission
> mapping for RTM_DELNSID, read or write, but ultimately I think this
> should probably be treated as a read operation since the kernel is
> using this simply as a notification message.  Sending, or receiving, a
> RTM_DELNSID message doesn't affect the state of the netns ID, or the
> netns itself; in other words, a RTM_DELNSID is not the cause of netns
> state change, it is a notification artifact of such a change.  Leaving
> this mapped as a "read" operation seems correct to me.
>
> It is also worth noting that the SELinux netlink xperms support that
> will ship for the first time in v6.13 will allow policy developers to
> target RTM_DELNSID messages with much greater permissions granularity,
> largely solving this problem for those who care about it.
>
> Finally, looking at unhash_nsid(), the only place which seems to
> generate RTM_DELNSID notification messages, an access control denial
> on the netlink notification operation will have no impact on the
> removal of the netns or the netns ID, only the notification itself
> should be impacted.

Ack. No worries. I agree with you Paul. When I was going through the
list for updating our policy, this entry stood out as the only DEL_
mapped to nlmsg_read. But as you described, it makes little sense to
move it now. Thanks for the review.

