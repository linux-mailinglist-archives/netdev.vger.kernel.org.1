Return-Path: <netdev+bounces-102725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FB090460C
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30126282367
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86241509A7;
	Tue, 11 Jun 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwwpB9dG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27036386;
	Tue, 11 Jun 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140006; cv=none; b=ley+6DG8ni/SiUcjhw2JDj+fqPu3rj1zVDddVM+gCSvQx4vJ9ewjwebppAAylQIsko1vjcW2hAbUyDtk2kfujcGiQKkwZP+pawJRPttXCyBw5O89T4m59As1Q30BHsPCO6070JamhFxUOnqzXNYf/70I2LrzotmhlweMYlzYJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140006; c=relaxed/simple;
	bh=Rui9AoBITRyDlF2eWQs8vZ8OuJoMhByhTlQhym14BIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WleXF/6MD+YbP9fiLFPQOd5cZXfE7+RaZ60I6u0/5F73DEKIxXYCfe1F34+YmG0YoCc4HDkLCA4qhYKhm3fXZRP3xshjCywgrLXvKAxOcfqlI0pvr99rvhoQ4ttIOnhe8bmRqKqe5Ci+AWjh98mYo+tIllgCkp6wwvbBnunlDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwwpB9dG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70421e78edcso1513196b3a.3;
        Tue, 11 Jun 2024 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718140004; x=1718744804; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F6Ifet/6ih8RgGZZ0QsdkVuw8FBoDD+UlCvt9Kx1Ys4=;
        b=KwwpB9dGAkH7GZHN4oTYbYtBLlK8BnMyihJYrLeJCSlCvU8SUMy4zdzBjCRsRvGrLn
         rSUrb0AETcDJWGph6gfSWClCfUlnGjkYl9vTo7/U9Ipy0JQGtrGD1xu6ePXSkeoQy51t
         I8rqW5IU0fKZOdhxvnb4XhRc818de1AD1NNsDWpu1HAqe5XdjS6AO8NKo3Kf9LJG1SO9
         RctzlkyUVEZOr8ZtJHe6iGhVS35271+JOcGS7rEzZpgIfbiWi9bTCv25iQIDuX4ULJTR
         raOmgnHk/Le3Ja5LnXRzuO1LD+qwmrCEWdzkO5vvN3tHpQpoedYq7K749vtrfYYlsYUo
         objQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140004; x=1718744804;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6Ifet/6ih8RgGZZ0QsdkVuw8FBoDD+UlCvt9Kx1Ys4=;
        b=TqFFv3N6JlBSq2elNup5W7wW0lBU+ygEBaIfV4iHRRtOHbZpBHmpftHQTJW5EINlHd
         AckA4AoBt9Bo+uAL7YXkrIcETBAwnx/eRfEpvd2O+HlB5Z3RG98CO1p3to/QP2YXYJH1
         zmM19d7NWMxuVy1FT/mrJbmTkY2HwcFk0QayF5er6WvZWzMXgfwQplwQJoztl7RDqQv/
         DZcYrLD5E4w4xfuCt10r+8SzpW9zho4ivHN10kAuLZIfyI+2MROYOfhqJWF279dG+1Xq
         H0rHdcA8WLU4UwRO9APs24UNLjhKxb5hLOWsoC+kPhfNaeDMx9744jK8GSdrCjkRP62+
         CRiA==
X-Forwarded-Encrypted: i=1; AJvYcCV5P2zcjYhO5i5vynITJHsiuTf8C9RtYrBDCT6k0RmlAL+LaBFT3WOa7VnZC2Gsbf7qptn5KZGCHPQ5S9fKp5y7yNj7OuNkxsFdPqvsbs6+uWCgyffIHVlhUxhoS3V/97CJbtJTgyVmVdJKBfWqLb0HrTSPSdC27v3K9V0fmodt+7Sn4hmMk08NyF7l
X-Gm-Message-State: AOJu0YwfHHRCcf4ud3zFXXz5iweySz3hFaCNQOiWO0eEf5UoXL4wCLMA
	wuuhYL1t/9wKLfd4T8SAhGEOH7ZRDJpY6EJo7M4872+BBH+c6pWf
X-Google-Smtp-Source: AGHT+IEmtVX2k5iMqX+QTQs2nsXQB9pmHFxP3TYrDQbolAgY9BCTAdR+sFm/P/GOwC4t2bikQlErXw==
X-Received: by 2002:a05:6a20:12cb:b0:1b8:391f:dfaf with SMTP id adf61e73a8af0-1b8aa068190mr139979637.52.1718140004183;
        Tue, 11 Jun 2024 14:06:44 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041aef65f2sm7117544b3a.108.2024.06.11.14.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 14:06:43 -0700 (PDT)
Date: Tue, 11 Jun 2024 15:06:41 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, outreachy@lists.linux.dev,
	netdev@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v3] landlock: Add abstract unix socket connect restriction
Message-ID: <Zmi8Ydz4Z6tYtpY1@tahera-OptiPlex-5000>
References: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
 <CAG48ez3NvVnonOqKH4oRwRqbSOLO0p9djBqgvxVwn6gtGQBPcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3NvVnonOqKH4oRwRqbSOLO0p9djBqgvxVwn6gtGQBPcw@mail.gmail.com>

On Tue, Jun 11, 2024 at 12:27:58AM +0200, Jann Horn wrote:
> Hi!
> 
> Thanks for helping with making Landlock more comprehensive!
Thanks for your feedback!

> On Fri, Jun 7, 2024 at 1:44 AM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> > Abstract unix sockets are used for local inter-process communications
> > without on a filesystem. Currently a sandboxed process can connect to a
> > socket outside of the sandboxed environment, since landlock has no
> > restriction for connecting to a unix socket in the abstract namespace.
> > Access to such sockets for a sandboxed process should be scoped the same
> > way ptrace is limited.
> 
> This reminds me - from what I remember, Landlock also doesn't restrict
> access to filesystem-based unix sockets yet... I'm I'm right about
> that, we should probably at some point add code at some point to
> restrict that as part of the path-based filesystem access rules? (But
> to be clear, I'm not saying I expect you to do that as part of your
> patch, just commenting for context.)
> 
> > Because of compatibility reasons and since landlock should be flexible,
> > we extend the user space interface by adding a new "scoped" field. This
> > field optionally contains a "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to
> > specify that the ruleset will deny any connection from within the
> > sandbox to its parents(i.e. any parent sandbox or non-sandbox processes)
> 
> You call the feature "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET", but I
> don't see anything in this code that actually restricts it to abstract
> unix sockets (as opposed to path-based ones and unnamed ones, see the
> "Three types of address are distinguished" paragraph of
> https://man7.org/linux/man-pages/man7/unix.7.html). If the feature is
> supposed to be limited to abstract unix sockets, I guess you'd maybe
> have to inspect the unix_sk(other)->addr, check that it's non-NULL,
> and then check that `unix_sk(other)->addr->name->sun_path[0] == 0`,
> similar to what unix_seq_show() does? (unix_seq_show() shows abstract
> sockets with an "@".)
Correct, I will break it into another function that checks if it is an
abstract unix socket. In this case, we can add other restrictions on
connection for pathname and unname sockets later. 

> Separately, I wonder if it would be useful to have another mode for
> forbidding access to abstract unix sockets entirely; or alternatively
> to change the semantics of LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET so
> that it also forbids access from outside the landlocked domain as was
> discussed elsewhere in the thread. If a landlocked process starts
> listening on something like "@/tmp/.X11-unix/X0", maybe X11 clients
> elsewhere on my system shouldn't be confused into connecting to that
> landlocked socket...
> 
> [...]
> > +static bool sock_is_scoped(struct sock *const other)
> > +{
> > +       bool is_scoped = true;
> > +       const struct landlock_ruleset *dom_other;
> > +       const struct cred *cred_other;
> > +
> > +       const struct landlock_ruleset *const dom =
> > +               landlock_get_current_domain();
> > +       if (!dom)
> > +               return true;
> > +
> > +       lockdep_assert_held(&unix_sk(other)->lock);
> > +       /* the credentials will not change */
> > +       cred_other = get_cred(other->sk_peer_cred);
> > +       dom_other = landlock_cred(cred_other)->domain;
> > +       is_scoped = domain_scope_le(dom, dom_other);
> > +       put_cred(cred_other);
> 
> You don't have to use get_cred()/put_cred() here; as the comment says,
> the credentials will not change, so we don't need to take another
> reference to them.
Noted. Thanks.

> > +       return is_scoped;
> > +}

