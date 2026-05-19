Return-Path: <netdev+bounces-289611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB+MF+zPDGrImQUAu9opvQ
	(envelope-from <netdev+bounces-289611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:02:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4567584F87
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 189FF3051D72
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D53DCD8F;
	Tue, 19 May 2026 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/T62TYB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA4E3DC4D9
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224429; cv=pass; b=OxKpTFEzWZQgngMVeWDFZY0FPVC/pp+a49oHvqIVN8Talpe6JRDBrFwm3H2PnIB/s2LAxg2j12LMw9AmBNV5pK094HYtXp2Mcy/QXYWzVicMGQ/+V1Kcw5tXOVuCAmu9qYWu/WHiWRPiAJzNxZH4MiYxksa93wCs70YssKIL10M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224429; c=relaxed/simple;
	bh=l5xX9AzWZwqtZqrp61qy13Pz2Ds+N0iybZrAmj9tWm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntQLQ/j0OdNKDH0ZRm2rbP/8sPZDa65B3sNakvQ2LARNrV+A1IKJWnPgAu6SjalqGrq7j8LkEG1Ge3ABOtq7unRNSMQFnXVLddx5c3YVClgf3WGPMEjGONr5k9YWoZY49EcOW7E62gCUdEIFHASOv/yuQKsgfm5Mq7omCB5aJVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/T62TYB; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39394e1e8f3so42503971fa.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779224426; cv=none;
        d=google.com; s=arc-20240605;
        b=E66PsPyvUDXlpZ1JG6tZZk4nw2KaVeWhI95Mo8B9RhopaZ4xQprbAIqLfRMaQ2SMDr
         5WQGI42A+sKH5xk+hmIRNSBX0OlAVc6rl9QY2BJcYNZawhGh5uuQA5yaotx7CHg6Cfm0
         3CcuH1PMZjFU5F+tlv8dAlOtKWt9Ow9+IejmSFFOGjJcNbzj6L8zkvli1tB7smz3qVeH
         Cq9XjpuZpCuT1AFxX+iDfdcMT3TTRCveOaa/bpmSLAFvI+qE+PLatvj7Anrr0Yan+Jex
         TkBCoH33LC/aeR0DgdQ4xEDe/rrNNE3MQgIBd3nTdbGjwqiPR44UT/pvMjQ6yCg4g2qf
         P+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l5xX9AzWZwqtZqrp61qy13Pz2Ds+N0iybZrAmj9tWm0=;
        fh=x1Z+XQFSC/uXRyOR7PrHUJtuqofIUZZVY+A5zckOLSA=;
        b=UXD5t2VJ/NFA2MqEFqehZv2+MWqVF+FU6VCfQFjKlmpSZS9l7yzPfxTSegG65stIHw
         SsXNyAeYSNhfAP/eV08NEc6cVmdwOobDdzrmg8n45NAYIjrLRdu1inHGVkLuTiGzJaRY
         KgpOpa4Lox9oZBIhPnejIj0FSseurayKMraNWJ0IRQ1Qkow8fjS9+siRBU4rsCzz2CEi
         omupB67Xxk2vVyuZFhUYEBZzErOKrDo4oE6QUAS99FO/BBdYrrXi3rdQuwXFJHoyZvVm
         wuRYIwVuHjY5u5xMzYIvFJnjCLrmQn9tMgcl6VhbqxwTZuoAC+udgLFroMZqp9PPwYEt
         rEwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779224426; x=1779829226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l5xX9AzWZwqtZqrp61qy13Pz2Ds+N0iybZrAmj9tWm0=;
        b=t/T62TYBGVvNW3TnJzguQXz3Fg4JukMXhPWvma4WeEL7hWY7aFRV+0sdeovJbirSqg
         aPlQirQJqHbPaFoAZUFko8NXgiiGJDerd00786MHwp6y45/CvTffxkU3lWgY6De8DDob
         DkPB3EfZZAs7OzNaGScZbrdZE9jsTop3AMcUlpPDBlFMY+i3PgBc/CgvQU2mNWrH0Ifq
         TY86Ml0liixakw20QpFo68doRB2eINQqXIKFF6MyWQjfbCY/J4T/WdroM+Lbph2kUbrZ
         U4jZmA8ohgxA0E4bXx4HxIRm7s3J4XzfSeoTrPkN6eMU9E5uo5ZhR8tiBc0HWt69zopi
         yiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779224426; x=1779829226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5xX9AzWZwqtZqrp61qy13Pz2Ds+N0iybZrAmj9tWm0=;
        b=lRBRrjsatRyaO5SRHS2mbKxDVBFdZJ3sHEt5yLmfhk8RPs6ThBfBWAZurxNM1L5yye
         Qo9Cv2/tstYHXId8LrQCHIV47Fd8NzoQ3HUlsDmT0ycoz4qyQ45NqVUkHmduUhzZ/z5m
         XVp1WFlEXcFLQpmutRpWYWuAs05D/obyA8bdgSKP8lGoHqXbK4S+FDJRYwHRgxWLluWB
         jLEdvGMW2jXbWGFYGvbn2hAp1R18p9UbVuFnHGmNtREjW6LxM0E50P0ADTEeUiWRZ35a
         R91J5KLoynDmXTSYxkdQhogjffn69wz0XdmyT5FO3psRK19u7STGtqrDwJIoQN2UAee2
         yIMw==
X-Gm-Message-State: AOJu0YyD7R0ai4OgZqsJECFSp5Vzd4qpZudhhbSqQ8KgbeqAljZIs6nF
	Ucyb9QbUbp7B0wqwtxVMfdIlIr5p6bsJ6rdY5eAX0UQpCD5BHUmy0S1QtUrzz+qEj6QqYMoJqZv
	ReSTHZqzlEYqv06NCNpnsQ778GB7Z+4i75B9NsjBo
X-Gm-Gg: Acq92OEpitFXL7OKlxlImrmRnSsFLECsJyo7YWO66Lb0lU1BYs5TCn0xdMT6Cv71t9y
	bBavcKMYVpMNqeE0ty0noRkoNc4Z54eS3VZb35YWYWk8zr5oaNk2wXZHEkBPMYrKXY5uenNrLCN
	dpaGyUJ9/8gC71GFuYhX9yYs/rbc+rL8oFrleCp1FBoC4GfleHcvpS8zMBFYo5Ja2qNLO20CrLH
	epW5U4YazE1QM2IfNEe/KuVjOLhXZZqiJW+uFBzAy/yg2XHZKqmm/Iz3pPZVhDQmVaYP7bBOivp
	rZsy2MNoca4CtKw6B5zlq0pRucaTw1rjPDZRb0IeIu0bIrpENu4VHCMnvnNVKPeYIiP9/fxeBCj
	MVKSF
X-Received: by 2002:a05:651c:1608:b0:38e:7a75:8763 with SMTP id
 38308e7fff4ca-39561d60079mr66044851fa.18.1779224425970; Tue, 19 May 2026
 14:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez2++gA+Z9GVmNOG5-+NNicjmti3nQ8xhVJuXM042WfwZg@mail.gmail.com>
In-Reply-To: <CAG48ez2++gA+Z9GVmNOG5-+NNicjmti3nQ8xhVJuXM042WfwZg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 19 May 2026 23:00:13 +0200
X-Gm-Features: AVHnY4JQiCOJUMjfX0rK9mwMWaqqgmFj_5h1OSJG4OrZMSmTfEHnd45kmHmSl9E
Message-ID: <CACT4Y+bzkW0fjrUcbG+6XfTsw9_0sGfYN+9myHtC72dZT7gvNw@mail.gmail.com>
Subject: Re: [RFC] hardening/fuzzing project idea: KASAN redzone before skb_shared_info
To: Jann Horn <jannh@google.com>
Cc: Network Development <netdev@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev <kasan-dev@googlegroups.com>, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,google.com,arm.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-289611-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dvyukov@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B4567584F87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 at 21:19, Jann Horn <jannh@google.com> wrote:
>
> The following is not something I'm planning to work on in the near
> future, but I think this would be helpful to allow fuzzers to more
> easily detect OOB access bugs in the networking subsystem - maybe
> someone else is interested in working on this?
>
> As described in https://docs.kernel.org/networking/skbuff.html , in
> the networking subsystem, SKB head buffers are stored with a "struct
> skb_shared_info" at the end. This means that out-of-bounds accesses to
> SKB data in the head buffer can't be detected by KASAN unless they go
> far enough out of bounds to go beyond the skb_shared_info.
>
> For debugging/fuzzing, it might be useful to have a KASAN redzone
> somewhere between legitimate data in an SKB and skb_shared_info
> metadata, accesses into which would cause KASAN splats. Maybe we could
> split sk_buff::end into two separate members for "end of tailroom" and
> "start of skb_shared_info" so that a redzone can be placed in between?
> Or let debug builds store the skb_shared_info in a separate memory
> allocation?
>
> (We could also try to go further and KASAN-poison the headroom and
> tailroom until they're actually used, but that might require an
> annoying amount of refactoring of existing code, so probably not great
> as an initial goal.)

Hi Jann!

There was a related issue:
https://bugzilla.kernel.org/show_bug.cgi?id=199055

Not sure if it's better to include this into the existing issue, or
create a new one here:
https://bugzilla.kernel.org/buglist.cgi?bug_status=__open__&component=Sanitizers&product=Memory%20Management

It's also list of things that nobody is actively working on atm, but
it's still to have such a list b/c people periodically ask for things
to work on.

