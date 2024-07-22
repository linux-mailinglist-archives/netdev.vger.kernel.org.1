Return-Path: <netdev+bounces-112416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98083938F3E
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 14:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526C2281CE9
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C105B16C86C;
	Mon, 22 Jul 2024 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cG+3Koxp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F0F16A38B
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652375; cv=none; b=dkrdj/TNmh250Z/TISL9SFxW/EBHSMF7d7aJ1WumYr39wObtAMJ+slVIzmTT3AOV9Yhw04Vn+KbftkMqYshsmG9dVhkSrd9uCfny/Zz8CpUVZgAuuRBBxbjyu1mQzGAvGldWNrL3mFz9+Gg6wbfEmOfBWkylAFnc9MJJzDNkehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652375; c=relaxed/simple;
	bh=08A40bbhznrlKFn2gZRVp22dL57vJ4Sag/bNSCApeS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUp66bLc71L73ojeYEQ02jGB0q1rsK/F1/dt2VQRQiCWLRVtbC/TFt27Qf5tlKqcUpEEpzjIn8oxJ+AaiSdCG49mzZv1nq/FRY5MPsz7Tgnz5djHjZeKvFNgt7bb/nnWlvrDK0QCDoXdlLnx2VWAIXn6p2yp5fGKXqkO8BR5ktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cG+3Koxp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so33946a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721652372; x=1722257172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkPk7qSJmsTXHG/tHIONPG7HUxcysTuWtB6jumYqrdM=;
        b=cG+3Koxpc/QmSBZwKbL4uPqT2dx+Elm3nQE+Zs+CZ46jGTlXOUQ/RtXwCP0momnPxp
         ua5uuhApoYuP1VbgPvoIOdPG7jh5ScOVH1OiEmydv/nibqeO8TqnoBZHSK93cRK3xTXz
         RoImxctwgV4gxMJ3MSlpJEnXmIK5R1PDhMdu/5lMj8uz4C5fnadRvvVrL7nc70Z7zjQK
         vuEVuzcM3mJKXnxzomYEAw0dvSv9tBeepjqZ7vJJsXKonL5RRPvUurzmrjAbN8HkJElG
         DqzajQ8F3vGexcwhMsqLUqVfVlbpEk83PY6dshsSd965DdtTLKslacBdqSXaOrZr47oU
         RTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721652372; x=1722257172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkPk7qSJmsTXHG/tHIONPG7HUxcysTuWtB6jumYqrdM=;
        b=MTaBCzOmSlvT4ll4zxr0iWb4AUuZc3lz6puN+Vo/FYl7P+vFGpXvHt0Iih0dXS94kZ
         xJAoIBKpKuLnyf3UMj5h4ZEGL/BJhkDjVcvbtalFp6Hmv33OKZwm/gZ4465JJN8Xwydc
         KWon9QjhJhm/BMGJk6c/5DQ0Sl+UJ/ToExE+Thicjh5+aTjb4fVuYpfOz+lZ5sQfF/Om
         vVXJnRRlE3bXiTtr90bxy+j/RePrhHRB3OqoYP8yJH6TM2reWwP3gtOO9sTWfCMeuRFs
         1SUyzfsdHU3/39urmIEJJK2SqxUNA3mwgNflAl8O57Rx3FsRDDY86HTTgQmM/xgeWVcC
         a4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjpNy9d4WzggkD9Q6Y3eiygEjgltO6smivJ8hWsufR5Tbdj7cOrt5XpfVEcDmdGX80qLp+knjDFrRZl1F9GDn+3bWglzct
X-Gm-Message-State: AOJu0YyQcR7kdXrb5pM43AcYqBN1HG1ODsouk16gRs10cvuqi2A8syjU
	W/95TeXsjkJH4PmgEO0XkO2t9S8ouOer168cIbSMp6M6mn84hmU7DpyidN4Mgt7bngZKP6MlM2x
	iIeRQoFk7avSR+WhdbPJ/gyEBbhwB2AQ+u7uA
X-Google-Smtp-Source: AGHT+IHCi62PM+KOTFc8/S9a0uMCt8sBsWfBOfvWEaTCwIQZzIuRwZy1cJ/vucoCoYuRW5CLLmMrzJQs2JS1pzid0TE=
X-Received: by 2002:a05:6402:34c9:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-5a4a842af45mr220593a12.3.1721652371314; Mon, 22 Jul 2024
 05:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36958dbc486e1f975f4d4ecdfa51ae65c2c4ced0.1720213293.git.fahimitahera@gmail.com>
In-Reply-To: <36958dbc486e1f975f4d4ecdfa51ae65c2c4ced0.1720213293.git.fahimitahera@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 22 Jul 2024 14:45:35 +0200
Message-ID: <CAG48ez3MNJ9QiULabERc-SWQLx4T80_UOvsqCVFXTi3yxeeMRg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Landlock: Add signal control
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: mic@digikod.net, gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 11:22=E2=80=AFPM Tahera Fahimi <fahimitahera@gmail.c=
om> wrote:
> Currently, a sandbox process is not restricted to send a signal
> (e.g. SIGKILL) to a process outside of the sandbox environment.
> Ability to sending a signal for a sandboxed process should be
> scoped the same way abstract unix sockets are scoped.
>
> The same way as abstract unix socket, we extend "scoped" field
> in a ruleset with "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset
> will deny sending any signal from within a sandbox process to its
> parent(i.e. any parent sandbox or non-sandboxed procsses).
>
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
[...]
> +static int hook_file_send_sigiotask(struct task_struct *tsk,
> +                                   struct fown_struct *fown, int signum)
> +{
> +       const struct task_struct *result =3D
> +               get_pid_task(fown->pid, fown->pid_type);

get_pid_task() returns a refcounted reference; you'll have to call
put_task_struct(result) to drop this reference at the end of the
function.

> +       const struct landlock_ruleset *const dom =3D
> +               landlock_get_task_domain(result);
> +       if (signal_is_scoped(dom, tsk))
> +               return 0;
> +       return EPERM;
> +}

