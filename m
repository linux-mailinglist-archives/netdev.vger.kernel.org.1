Return-Path: <netdev+bounces-101086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2C18FD426
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92771283F60
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719BC13AA36;
	Wed,  5 Jun 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQTXPWP8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA35813A86A;
	Wed,  5 Jun 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608610; cv=none; b=K9tVw8TPJsweq97YLS/pwgripxTngYqfWe6qx62XK5bzlntUqi3bYLP74Q373O4wQESdxz0cLKiVMbS2p6ek133J4GvYKfNDCseFDrNnM0SkDOn+GCGqUkdRHWUggXjDpRMTwNxyHEBNRR+v5s149aiu3muqbdCt32q461yCPgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608610; c=relaxed/simple;
	bh=TgPRCqa1WrwYIkeTFSrIx3FttbgFYBUrYsECYP8WLWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uj5ZcWg34b8l/Pptdyjy3CdM2WjcgXFxEcrRmNuow9CD71zTpWmHCLNqb5W6GPxTd8r7g/upcYV0eLsdb6KVrGNVemWc0eAKtcWNHzpbmkVf7NVVFiBLItzNd8u3R2YLJY/rxaDUvAdtOQeSR0E35YoVzqvRlZurHbJ7iaKIYHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQTXPWP8; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c3b5c5e32cso32183a12.1;
        Wed, 05 Jun 2024 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717608608; x=1718213408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b51xKkNLJiZ1CSUfBqf69L0JrUG70vj/aLl7G7R2QSU=;
        b=RQTXPWP8eJz6p1kfb89I/QomyP1FiYE0JMc+kS/QMrAaReW0hbDLfIN2cerNn5VyGc
         JagBQTJPdZm7klNCzNnSMzVB/lwkcwtGmaqieP0Kncejf93HUusLh0va92wF+eRO/HXO
         iPP7n1KRXzfGPqKjV5Y/PLYwjV/tD1IcL6U96o2NjTTHlJcBJUam6kxOHBUD1huxorMM
         eZhvtwZZ2K707e4I0vnnwv8p2i2VvSaNo3c/XPLGmIU0ehnFPqHzbw/WFlpvbkVm77Wv
         9vHZx6qgIaBF/0rnSb6BCr7EKu/IeXjlxx6Z7oqYnUg3Ir/GO/GykqTpgiC2GdwqbUd5
         1KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608608; x=1718213408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b51xKkNLJiZ1CSUfBqf69L0JrUG70vj/aLl7G7R2QSU=;
        b=kFxiybDPDCWWDQr5XPu4a7772KjYs9JLhp9MiWZkM4gCxHPSctCDZvUXXSuM1hJoAJ
         rsALU2hRBn+Nn06ctvzp9sKY1XHc3qzhD7NLiz0ByBRNpOOd1/Xj0S8qA47LeRiNCC4R
         3Na6Sm9dpMPId/JytyVB4oIUjyBO7wyynSHCeK8+XNcPnqcSI335I2aDSKCC6Eklhph0
         pWT2u1Q0kd/dCPRC2fmlHrTtLCa5MIuyB52hEPTB7sgAbM36cs7US11PLXZV3MSp8hmn
         Vcj2kh81AMJAwnxdhXObCAknFh/t0DDQLV2JM1Qgqq6rQHUImSVDd3H42gO4R0GIl/Vc
         7aBw==
X-Forwarded-Encrypted: i=1; AJvYcCXbB/db6w5LO8/t0iavUL2FKL9n5Txndjg45NerLCB6bCb1h3F9MI6jleb76hgxg/x1em4qtwZiV/1ue9WarpHYfn4baAMHhOVH72HYlquDkUJIjjiMGth2ll58m3LbaOHlv+ctEV7QWVCa9j6szQb79JBPy8JobQzA+v3hBP43OUiAlaFlN+81uUZIgeAZhmpwcSPlemH+tRAhJ5MSNGXLe5sl
X-Gm-Message-State: AOJu0YxSPUjOinwVF2uGxXkC/cn4LnK+y0IVEIxof5HMxWfN907msKPZ
	5YzsS1N7Wt5X0CAoAylCwAn+ae04Vsn2QZc1FtLxmqQ6OCrfDu5s+AMKwaB4AHLbnqs6tegzvAJ
	MOQ0stWYXGFQJQoCDjjrsn0+10Ow=
X-Google-Smtp-Source: AGHT+IE9HyrCbwFsn9zuGO3k2O4Obewg5pVr203HIBzni+5jUKor2tYqsw9lkRRThl2ghl7DFlA0Q8qbCdhIqsgDq4s=
X-Received: by 2002:a17:90b:1018:b0:2c1:a052:d6b4 with SMTP id
 98e67ed59e1d1-2c27db1fc28mr3021809a91.27.1717608607995; Wed, 05 Jun 2024
 10:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
 <20240605-tcp_ao-tracepoints-v2-1-e91e161282ef@gmail.com> <20240605044441.GA3452034@maili.marvell.com>
In-Reply-To: <20240605044441.GA3452034@maili.marvell.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 5 Jun 2024 18:29:56 +0100
Message-ID: <CAJwJo6YT6-jpomSAjs-1kwRNRQWkAYnPHDxoZF--vQxTpg2b2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] net/tcp: Use static_branch_tcp_{md5,ao}
 to drop ifdefs
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 05:50, Ratheesh Kannoth <rkannoth@marvell.com> wrote:
>
> On 2024-06-05 at 07:50:02, Dmitry Safonov via B4 Relay (devnull+0x7f454c46.gmail.com@kernel.org) wrote:
> > From: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > It's possible to clean-up some ifdefs by hiding that
> > tcp_{md5,ao}_needed static branch is defined and compiled only
> > under related configs, since commit 4c8530dc7d7d ("net/tcp: Only produce
> > AO/MD5 logs if there are any keys").
> >
> > Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> > ---
> >  include/net/tcp.h   | 14 ++++----------
> >  net/ipv4/tcp_ipv4.c |  8 ++------
> >  2 files changed, 6 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 08c3b99501cf..f6dd035e0fa9 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2386,21 +2386,15 @@ static inline void tcp_get_current_key(const struct sock *sk,
> >
> >  static inline bool tcp_key_is_md5(const struct tcp_key *key)
> >  {
> > -#ifdef CONFIG_TCP_MD5SIG
> > -     if (static_branch_unlikely(&tcp_md5_needed.key) &&
> > -         key->type == TCP_KEY_MD5)
> > -             return true;
> > -#endif
> > +     if (static_branch_tcp_md5())
> Seems that we lost unlikely hint. Dont we add that as well-> unlikely()

Please, check the definition of static_branch_tcp_md5().
This doesn't have any functional changes but hides ifdefs in
the definition.

Thanks,
             Dmitry

