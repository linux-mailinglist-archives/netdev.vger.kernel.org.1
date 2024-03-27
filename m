Return-Path: <netdev+bounces-82538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0937388E7E4
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03061F36D27
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D73137C58;
	Wed, 27 Mar 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRHJTnBT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54CC1EB2F
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549859; cv=none; b=q7xzLO6pnlxXXpkAsV7HKT3AhedB1ei7cYZUHmaET+FtOkqVeZKJ574/DoxDHyTuFSkQ/xJ8CB/dUtFrxV8al98JCwwJP0Qy3RDlC8UGCU1yREhhxa2Jwi1J2DX+eUQ8fBmBviZC50iuMsjK7+3sWG6KfiPNQroEHtJK+XKo1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549859; c=relaxed/simple;
	bh=X+18y+jTDxyuazgxXbHB93bDVbGAxc9AHAK3Sc5oN8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itxXM5sgfYT5wKgOc+0cvGcm4JpZsHToeb5kjtzdXqXKW9oKNRdAkWFhUGh7qIpx5DEVukeUzy0bahKz4b8d85wTlqBRsQV6d3/FXwCHp5HG99EYVUU5WSFtVL6V28v8Vjl84j00fLe5fxk3nuggwWrHNEe6x5Xi51kL5KUWRy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRHJTnBT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so10570a12.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711549856; x=1712154656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ETX7iaPgtH8f38S9O0NaDS91kf8eVM1NcRmyOiDGrI=;
        b=FRHJTnBTsHqV96eMh0XywL549WsB7QNQGSICQLQ3Ev85smMJJOkyHwCYajOB/bdxGM
         xROqeIj74HHwrNrSE2FsJARGs/K0WqCz6uRQhCcV6mMNkz6lHIACeXxtQ24AHSAhIc5U
         Lo+aQ5NaX32ckWajGIBRdpIbgx3cbIrOpn0CunbHi/TJ71rnv75gee84r7xoMbwcar7g
         qoleaonSwJaXwdXfOwY342A9er2Pfir2le3XWXz9kAtwRvifdld4SxlF7hiJqsEDwEAF
         jgE3f8OiQtNT6EsTcJrxgTENsw2QoSORIxSWtL9ZDfhwHGjqx7G9hFgCMvHikb6whQnR
         tdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711549856; x=1712154656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ETX7iaPgtH8f38S9O0NaDS91kf8eVM1NcRmyOiDGrI=;
        b=UDFUy5aZh8FyN8fZp9eZsmbDoenKcd52KygSDZ/Dg7w8LH9x0A+7c9h09fGutIYYBy
         CwcbKWMVF78SQybkc04lK4Vb8YZAtr61qAgQ+H5SskLgHhzv9RCQlxUVmYR/AiK5zUYT
         06Vm5jwy3FI1wqzBeyQOFrE3JfhBS6Ay51OQvhK2icZAyM09nMCaEqk7R5iVG/dEj7AH
         kr/8wAsgetJ7IXVI72FSjBmE1pb75HSaBGeluWwd85ZV4OWrBqYRLnSdxmVgMRchq4ne
         xZC8LTLPyaXFo+f44Mj+uGGEOo82bsF1P0z6E5x3hfcahvCVaAS7Ox8jyuc9RE1fbO3m
         b1Iw==
X-Gm-Message-State: AOJu0YzgL33QXZ3teLB6L4ckA0PhCDrXlnxwVRmYFqNBK+4qpEu9URXA
	6M+FrOWx/cpFv+f1FDQQtgsisAMJlKOvxGI/fN43kUOhzYtgjgqOqcOd6o1XIgbGIhsMTvYZE7G
	piOEq+ck5nj9JlwdGw6EgEC2ObNo55mqlmDXK
X-Google-Smtp-Source: AGHT+IEFAKXabqLW3DMZd09nZwglAvKauo5K9Q14QGhraCN+tqUZuldWnusjZjnlZvt+CXY3sjw7Bkb6n7YWWxUDRpI=
X-Received: by 2002:aa7:c391:0:b0:56c:303b:f4d4 with SMTP id
 k17-20020aa7c391000000b0056c303bf4d4mr89470edq.1.1711549855162; Wed, 27 Mar
 2024 07:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326101845.30836-1-fw@strlen.de>
In-Reply-To: <20240326101845.30836-1-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 27 Mar 2024 15:30:44 +0100
Message-ID: <CANn89iJEhQvo0tz2jfGDKijHSrxKHPPr622CU3QsnqeF6aFoiQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] inet: inet_defrag: prevent sk release while still
 in use
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netfilter-devel@vger.kernel.org, 
	xingwei lee <xrivendell7@gmail.com>, yue sun <samsun1006219@gmail.com>, 
	syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 11:19=E2=80=AFAM Florian Westphal <fw@strlen.de> wr=
ote:
>
> ip_local_out() and other functions can pass skb->sk as function argument.
>
> If the skb is a fragment and reassembly happens before such function call
> returns, the sk must not be released.
>
> This affects skb fragments reassembled via netfilter or similar
> modules, e.g. openvswitch or ct_act.c, when run as part of tx pipeline.
>
> Eric Dumazet made an initial analysis of this bug.  Quoting Eric:
>   Calling ip_defrag() in output path is also implying skb_orphan(),
>   which is buggy because output path relies on sk not disappearing.
>
>   A relevant old patch about the issue was :
>   8282f27449bf ("inet: frag: Always orphan skbs inside ip_defrag()")
>
>   [..]
>
>   net/ipv4/ip_output.c depends on skb->sk being set, and probably to an
>   inet socket, not an arbitrary one.
>
>   If we orphan the packet in ipvlan, then downstream things like FQ
>   packet scheduler will not work properly.
>
>   We need to change ip_defrag() to only use skb_orphan() when really
>   needed, ie whenever frag_list is going to be used.
>
> Eric suggested to stash sk in fragment queue and made an initial patch.
> However there is a problem with this:
>
> If skb is refragmented again right after, ip_do_fragment() will copy
> head->sk to the new fragments, and sets up destructor to sock_wfree.
> IOW, we have no choice but to fix up sk_wmem accouting to reflect the
> fully reassembled skb, else wmem will underflow.
>
> This change moves the orphan down into the core, to last possible moment.
> As ip_defrag_offset is aliased with sk_buff->sk member, we must move the
> offset into the FRAG_CB, else skb->sk gets clobbered.
>
> This allows to delay the orphaning long enough to learn if the skb has
> to be queued or if the skb is completing the reasm queue.
>
> In the former case, things work as before, skb is orphaned.  This is
> safe because skb gets queued/stolen and won't continue past reasm engine.
>
> In the latter case, we will steal the skb->sk reference, reattach it to
> the head skb, and fix up wmem accouting when inet_frag inflates truesize.
>
> Fixes: 7026b1ddb6b8 ("netfilter: Pass socket pointer down through okfn().=
")
> Diagnosed-by: Eric Dumazet <edumazet@google.com>
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Reported-by: syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com
> Signed-off-by: Florian Westphal <fw@strlen.de>

Thanks a lot Florian !

Reviewed-by: Eric Dumazet <edumazet@google.com>

