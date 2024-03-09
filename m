Return-Path: <netdev+bounces-78991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5B68773BA
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 20:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664171F219DA
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 19:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66B84D5B0;
	Sat,  9 Mar 2024 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="KzUWnaZY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B44A2A
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710012656; cv=none; b=Sx16Hl8XEDfzAszp8DQwqWOcaq1aUYIwx7KrauS/aiTBPTqIgDZhdTwO6tyemNbiqYh7s4WE/lZ/pIsPZ0KpLlHn/t6Lv+YVBovROSE461CmSJAcD2DPmrTctCcboPlvW9RzAnYwh8uShl4PMPeBUbfKg/fNOs+Xos5RsZmPXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710012656; c=relaxed/simple;
	bh=5Ir1S4tsZfupY4EwKy622aUG3yGIhXXlrdQwqCrp0so=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRzt+9Mp7UEP+oRtq12DkYR+M7M63fCLaIsGmzVDAgMa47LNGR7EmcZEKnkVb+45uMc4C4HELmHV7bPVyAIy0byJxWZ3mlHjqhXaO3XT8UpbuRk2hrAG74M42B9VMRUqEaC2gthS0vMPs7eqKeKi87750oCmuW5f/+8q+2b/C0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=KzUWnaZY; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5dca1efad59so2480169a12.2
        for <netdev@vger.kernel.org>; Sat, 09 Mar 2024 11:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710012654; x=1710617454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4d4gBp7B7aP2LZT2nmLhC+bvYgeTnkD+5L7NjVRGcDA=;
        b=KzUWnaZYK5wjlIwKpu+CDmyCK1DWEj1XOfTAejajati2nTLiOavP2TDJjmJiCm9BvL
         rtdfVC/Zr4L02duQWJMrcpC/4sHKsunlDt1e5pzVg30Yo6Qk5VzU+nEpKHAlUwTfU7pI
         XOCHnqgvu/ha0xKeI7GviHQHijTuDCYiqVhb5mqjppeleUaHipUwN+YvINU17vR6J/Wx
         2DDwgXWK8rLFVmaa+n1On5ptohZYxG+0LkAwTu+fXG1mD4p9yDLvJYYc/QUIFKjs80mR
         e8cpsMfXgDGZd9dYT/APwwFr5PtJJs7EhqlEdwZY1ZIxBGr/n/pTKcoADf0hS+gEjqq9
         oG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710012654; x=1710617454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4d4gBp7B7aP2LZT2nmLhC+bvYgeTnkD+5L7NjVRGcDA=;
        b=cfjIG6bp+6uEjLz1NGYwD19KEHgBgwzqynAGvHKc2b5+e6F9apdoJW5Ktnoftgb6m7
         dwx9LqlnImYpJiHRrcPk7lwOvp8d+vVzpg0N3sy0egqZmuKvHrqaLPgNbrTCFUWoKehv
         yZDdRnLlT84UzBrS1hb6ApP5A2RE1prYLkOVAeRgtZJY/Fq5QeOGu+PWxkUlfHPCnNUW
         2HowBDKYPn0QkGxhEDiA4OvDCUtEw8f7fnW9ibWFtBdBgSOE/VJN8j2E24CbG/bkQHca
         8G50mkdcoLOABX/+T7KldYFJO24fr1X1w6U7K7cv//RbxYsRudWPgKUJAXPDOwBaPhpM
         iLyA==
X-Forwarded-Encrypted: i=1; AJvYcCUw6HB2/YcHpadRvNyethkr6aT9s7hW7/wCKeuzck4wl+KXhB5a7CbfDfAXfWbIAbcRTB38JgRS94sHGYfnnFhMOEaY4dIk
X-Gm-Message-State: AOJu0YyF42Ef0S/DT3pF6QHVm/mnwsBDsdoh+gtpvr0s0BqwdkjsdBIW
	rrMIbB44JUqE+gwLov/v/TmzGmar4GOjhgjIivxGoCaIC1PmBY8WHQvIuu/4ywI=
X-Google-Smtp-Source: AGHT+IHxdihzHcq7HQj9IGiRTaZe5xFGbvyB5A8po4WhEQy/H3DFhkVVqc5AWrOG1+sEVe6EB/ANDA==
X-Received: by 2002:a05:6a20:7048:b0:19b:81be:34e4 with SMTP id i8-20020a056a20704800b0019b81be34e4mr1079235pza.50.1710012653853;
        Sat, 09 Mar 2024 11:30:53 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id az18-20020a17090b029200b0029b7e2f7e28sm2251692pjb.7.2024.03.09.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 11:30:53 -0800 (PST)
Date: Sat, 9 Mar 2024 11:30:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@kernel.org>
Cc: Denis Kirjanov <kirjanov@gmail.com>, netdev@vger.kernel.org, Denis
 Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH iproute2-next] ss: fix the compiler warning
Message-ID: <20240309113051.649f1de4@hermes.local>
In-Reply-To: <cd48d41f-b9ee-4906-a806-760284a3eeb4@kernel.org>
References: <20240307105327.2559-1-dkirjanov@suse.de>
	<cd48d41f-b9ee-4906-a806-760284a3eeb4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Mar 2024 11:22:34 -0700
David Ahern <dsahern@kernel.org> wrote:

> On 3/7/24 3:53 AM, Denis Kirjanov wrote:
> > the patch fixes the following compiler warning:
> > 
> > ss.c:1064:53: warning: format string is not a string literal [-Wformat-nonliteral]
> >         len = vsnprintf(pos, buf_chunk_avail(buffer.tail), fmt, _args);
> >                                                            ^~~
> > 1 warning generated.
> >     LINK     ss
> > 
> > Fixes: e3ecf0485 ("ss: pretty-print BPF socket-local storage")
> > Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> > ---
> >  misc/ss.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/misc/ss.c b/misc/ss.c
> > index 87008d7c..038905f3 100644
> > --- a/misc/ss.c
> > +++ b/misc/ss.c
> > @@ -1042,6 +1042,7 @@ static int buf_update(int len)
> >  }
> >  
> >  /* Append content to buffer as part of the current field */
> > +__attribute__((format(printf, 1, 0)))
> >  static void vout(const char *fmt, va_list args)
> >  {
> >  	struct column *f = current_field;  
> 
> The error message does not align with the change - and it does not fix
> the warning.

Think you need to add attribute to out_bpf_sk_storage_print_fn as well,
or better yet get rid of it since it could just be vout()

