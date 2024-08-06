Return-Path: <netdev+bounces-116260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6B3949AA0
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D785B1F24630
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 22:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A246516FF27;
	Tue,  6 Aug 2024 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXafEKAl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F316F850;
	Tue,  6 Aug 2024 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981608; cv=none; b=sCcnkSCiUvXgfHjd2hrcDgEoFanB+vXXyNU2BJ9zNvUh7B+NBmfd9zbulpXjizQiEvnyO4rjo4jxfdOeD/7NG41PcGfSW5yJNp+1NS4W0mBbA49aZuK+DhjNYkS3nxBzsXyVI+rkhosAGD2odcJCOlm4eRVGUEwNOxkHzyzsAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981608; c=relaxed/simple;
	bh=OwNLSN1W0J+6Dh8h5WKA9Oa1TE84Nv+86Y1dQJADOF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZysKZfXDpvrpAFhxlg5VmG/sdA4tzwWtV4yfvH7wB1CJfQmIAx6EimG9hlQVVDAqAo0r0CjAUnmJVoCrnKxaokh7wbvIvTXJ+oKON0tSB3ZbnsLdNSXNpt1gM+0qXGBWiWQScMxsSIpbtrGlrKdfoM3kut2vdWBvsARJW/CjhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXafEKAl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd70ba6a15so9089255ad.0;
        Tue, 06 Aug 2024 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722981606; x=1723586406; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/50Kbw9qcagQY5OojgELJFLSQm6KtoCpbcMKlofWHNk=;
        b=AXafEKAlVlWmksIM88AV2AGeofTSXnIhNaFFHjWCPSNbdxqcozeNCYU+rPLT1nMt+L
         DfrHoyI87Iuu6d8770uNK1sr1syBsCiXqit0iNV0B/adCmdrDN2zOokpWKxmuFeAHyIX
         z7SulVK7mtjZRg8razn7DURoqxhTymNTmGYeYtSCNoxNCYXO7ZxoM6nYKBBugSbXVM2Y
         r4h1XRFhvsL8fqPHt773kQm0so2kJpGBccO0yky5mFKJiHITy/rfDNmyKd1Y35N0m9Ko
         nR3gz2Fh5YaAH0y4EM1svqvxdR7v3+VGG/3E9+2vHJyc2JbneT9PCWx7JpJkYMOv2HnG
         OxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722981606; x=1723586406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/50Kbw9qcagQY5OojgELJFLSQm6KtoCpbcMKlofWHNk=;
        b=Cy1sK/FtxFM5Gy0MhaTkucOTSUh0j9DpiFq+crgwiIhEYvSXLK2GZDwbjqASIhV0q8
         UE2pxr77wRtIHjt3BzHDtRBGtb9PYawR8T1WeBPDv0apfEGlEIsMn3hY8s9NHY1i4iSS
         LaMDQ7GZUvqhT9Gg4uB+IDjbXX1TjewSPLlkoZC15oN6t7358EWejF+436BATkPZQjaT
         UQRhoZH7TbJiuZEO+zGLIzpA6IWmOvkVlmtHY4yvtuWBjgmzaInYC58vrVe+8WYUgdf/
         k5iuUx8flcA2FRLwyEIC4Cd6DpvP4j16vhyzXGMrAAafPptPrDpCCuCAW9K/zY0agdX5
         zDbA==
X-Forwarded-Encrypted: i=1; AJvYcCWWbNWqpJRpTvgQ7APanVbv7eUfQAxY7Is6rzKE14ZjgOv6CyP7YEXujlqZXbWPVzqkNgnXIMIU3GJYEwFIZiDb/rV7llaeXRIrRIFD6Nh6sRUfJPFKJUfcxG1p+WIbS8Wi34TPCWAJWEAZoKcfM++VMPnS+56R8vet3N7LbKbcZ5h8VrFpxXNUtWui
X-Gm-Message-State: AOJu0YzPHUoF0hR8V5hURMtbDoUqCeUsHQPBoBsYcMFOLb6qHB6qT+dO
	mVUX034c0Q3OeaL4gqoDGFiANLWLtIP+i/DKCxbezrQsqZJ1Gj0xA5vX7M6T
X-Google-Smtp-Source: AGHT+IHXa+LRVRm/C57MqrYOQ/Vf3v239GPhpPLFEDgIDJ84hO19cKAzIjegusu4uADCXlVAQQ3Wmg==
X-Received: by 2002:a17:902:f68f:b0:1fc:6b8b:4918 with SMTP id d9443c01a7336-1ff573bfcacmr172334305ad.41.1722981606141;
        Tue, 06 Aug 2024 15:00:06 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200775d1b92sm20453155ad.77.2024.08.06.15.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:00:05 -0700 (PDT)
Date: Tue, 6 Aug 2024 16:00:02 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: outreachy@lists.linux.dev, mic@digikod.net, gnoack@google.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
Message-ID: <ZrKc4i1PhdMwA77h@tahera-OptiPlex-5000>
References: <cover.1722966592.git.fahimitahera@gmail.com>
 <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>

On Tue, Aug 06, 2024 at 08:56:15PM +0200, Jann Horn wrote:
> On Tue, Aug 6, 2024 at 8:11 PM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> > Currently, a sandbox process is not restricted to send a signal
> > (e.g. SIGKILL) to a process outside of the sandbox environment.
> > Ability to sending a signal for a sandboxed process should be
> > scoped the same way abstract unix sockets are scoped. Therefore,
> > we extend "scoped" field in a ruleset with
> > "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will deny
> > sending any signal from within a sandbox process to its
> > parent(i.e. any parent sandbox or non-sandboxed procsses).
> [...]
> > diff --git a/security/landlock/task.c b/security/landlock/task.c
> > index 7e8579ebae83..a73cff27bb91 100644
> > --- a/security/landlock/task.c
> > +++ b/security/landlock/task.c
> > @@ -261,11 +261,54 @@ static int hook_unix_may_send(struct socket *const sock,
> >         return -EPERM;
> >  }
> >
> > +static int hook_task_kill(struct task_struct *const p,
> > +                         struct kernel_siginfo *const info, const int sig,
> > +                         const struct cred *const cred)
> > +{
> > +       bool is_scoped;
> > +       const struct landlock_ruleset *target_dom;
> > +
> > +       /* rcu is already locked */
> > +       target_dom = landlock_get_task_domain(p);
> > +       if (cred)
> > +               /* dealing with USB IO */
> > +               is_scoped = domain_IPC_scope(landlock_cred(cred)->domain,
> > +                                            target_dom,
> > +                                            LANDLOCK_SCOPED_SIGNAL);
> > +       else
> > +               is_scoped = domain_IPC_scope(landlock_get_current_domain(),
> > +                                            target_dom,
> > +                                            LANDLOCK_SCOPED_SIGNAL);
> 
> This might be a bit more concise if you turn it into something like:
> 
> /* only USB IO supplies creds */
> cred = cred ?: current_cred();
> is_scoped = domain_IPC_scope(landlock_cred(cred)->domain,
>     target_dom, LANDLOCK_SCOPED_SIGNAL);
> 
> but that's just a question of style, feel free to keep it as-is
> depending on what you prefer.
Hi Jann,
Thanks for the feedback:)
> > +       if (is_scoped)
> > +               return 0;
> > +
> > +       return -EPERM;
> > +}
> > +
> > +static int hook_file_send_sigiotask(struct task_struct *tsk,
> > +                                   struct fown_struct *fown, int signum)
> > +{
> > +       bool is_scoped;
> > +       const struct landlock_ruleset *dom, *target_dom;
> > +       struct task_struct *result = get_pid_task(fown->pid, fown->pid_type);
> 
> I'm not an expert on how the fowner stuff works, but I think this will
> probably give you "result = NULL" if the file owner PID has already
> exited, and then the following landlock_get_task_domain() would
> probably crash? But I'm not entirely sure about how this works.
I considered since the file structure can always be obtained, then the
file owner PID always exist. I can check if we can use the credentials
stored in struct file instead.

> I think the intended way to use this hook would be to instead use the
> "file_set_fowner" hook to record the owning domain (though the setup
> for that is going to be kind of a pain...), see the Smack and SELinux
> definitions of that hook. Or alternatively maybe it would be even
> nicer to change the fown_struct to record a cred* instead of a uid and
> euid and then use the domain from those credentials for this hook...
> I'm not sure which of those would be easier.
Because Landlock does not use any security blob for this purpose, I am
not sure how to record the owner's doamin.
The alternative way looks nice.
> > +       /* rcu is already locked! */
> > +       dom = landlock_get_task_domain(result);
> > +       target_dom = landlock_get_task_domain(tsk);
> > +       is_scoped = domain_IPC_scope(dom, target_dom, LANDLOCK_SCOPED_SIGNAL);
> > +       put_task_struct(result);
> > +       if (is_scoped)
> > +               return 0;
> > +       return -EPERM;
> > +}

