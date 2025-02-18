Return-Path: <netdev+bounces-167539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB174A3AB7F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 23:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05201889630
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487BA1D61BC;
	Tue, 18 Feb 2025 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9LkRAZ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1501D5AD3;
	Tue, 18 Feb 2025 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739916897; cv=none; b=j/J5SuLlBrpdUW2Viy5xfvgs9OXTIIZGJJxwS2EpTKll4RgfqhKdoF/nMVG007w95vQ8to520vvm8qKDMYQ71OpzTRf6otY51f5NJ3ILnUtMwo0oh/IsHbeMTmvLVAn3sN15XhA9uyL981sLv7U2C7FhrTvSOmeIJNGHB6Ho4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739916897; c=relaxed/simple;
	bh=2HcRlkYB4SIOQsuKibLFVSOu4Gjo8DHziTSIaUTUWc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ0QJUr+fm4HtEXBev3qoLkFi3Rk0KJmORPvlMDz8FL/bTcxKO42hzCSwnmjj+RXXa7FIrlFe9s8biaXZzloLWVL56IoxQS3F+igvkdDETDypFJXTeHh1JlQUNr68gWCIovqcfEo7tnfkntinUa4GtzkS41IO4mUEuCOxisi6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9LkRAZ+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f2339dcfdso3702365ad.1;
        Tue, 18 Feb 2025 14:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739916895; x=1740521695; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RAqFeRjzJ01jsajjI3CpDOztjdZxsfucy8g5FIh8ezA=;
        b=Y9LkRAZ+YB0/ri9UdZrBnwuKmGMWh9A8hRrXnu9THPbyzqfTBluCbIFcKDQiACfHjk
         qAgFHBSvL2lEjHKv5MTmPdmx1zMXxvdoF8vvXt5ARQ9YyhedguH+hjqEdikSTEKlep0f
         tuOXOoniIOAXbP4/CeolqOrzq+NLFJV99AVGAjE7laJkvpz4tdJLjdq1XMlN/8569DQr
         P/e1XhIl+Eoombp1BJ7XEg0WW3XJfLOurcPAxAstVnkmzxj71y4ENr9WHbLthAW4AfdX
         bGU6VL8r72cNpJV3kUElCBXqHyGPK0ekjosDPjXYkjeN1Nvxxzgn5kgDo2BgLV7AWS+J
         cu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739916895; x=1740521695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAqFeRjzJ01jsajjI3CpDOztjdZxsfucy8g5FIh8ezA=;
        b=EhLioro6RnAHFIyPAwJH2DqZD0MGQ0V+Fl64kstNYac7yDJLx/TnUQbNDG9WJ854NS
         SwaOi+tkgpbTZIYJCkkvMnl8DQlFuNfa2X05CSuGOIkmirjUcyBu5vFLkesGJwSXfW/j
         +T6hFJcWTUBWqoL7IpILLZcqJz1Zm0It7DTSgqZ35Py1YoWZLsoEbTZV/cJMcldSMK9o
         ADSs5jv8/wKAeHRu9Y+Id0Ss3Ita7vFh3QUK6h/oRgWrj9Uh6vmbnJEVLAVEYG/BwYLy
         DW4aH3uvYmHFkjHNuIrEB8CRlguWCx8g3c3tzvcgGR18OogV+wM8V1N7BHHrhLAut5nW
         3uaA==
X-Forwarded-Encrypted: i=1; AJvYcCX1EBOpFnElY/HI1+Xd/vebm/wmklGVePzOyLO96byI6uBvB/k6mBoH/dOd2I14/a+2h095VINlWMd6bjg=@vger.kernel.org, AJvYcCXFucYFjTjoVl65VFGHsXEWpsV0kXOYy5Wd/waPykRn/hZ070llUSWJCivkbGCkYU8V+jVnFHE+@vger.kernel.org
X-Gm-Message-State: AOJu0YwDoz/jTJrwFhqwOgWreu+KM+So5n7TZSsMReZn0EIrJRpG2eJH
	fIJ00NN3Sxg+wJXJz2xQBUIe2VDWyKv1VtCBOj6LhCNQUwhk814=
X-Gm-Gg: ASbGncs3M4fVOm1wM31sAwRKkLYg/6YdG2FB4GXH0LuYAx8Q7PAABPqTvbnGHiO0+ew
	JvVGNJEoV/cHsOArKkQYIWpChY7WBPN75pp1gDvVRIs8uJfU0GwtKzsPlPtoEXaGg4PvI7KQMrb
	y59OJSuH+pLf8V2o+LKFFdhYr+Ks4n2oW3fwvAPJTIBrzUbBfHEiFHYMCpSEi4Yy08MwJtfxrFC
	Q8PgaH5JKvHHe/71CyyOJZDTrj3cOzXh1p2XjD25G9gN06Vr4wzdvsSzF78av26kBsiRosMT4/M
	rfNUdqzIUjEUdDI=
X-Google-Smtp-Source: AGHT+IEtKfYgpOzCR+jWn1Itj9z5zUFPH8gPoxvbR6+suOxNA38+APJ2lNHO6RRPo8+64bV16GbhKQ==
X-Received: by 2002:a17:902:eccf:b0:220:fbde:5d70 with SMTP id d9443c01a7336-2216f11132dmr24314065ad.21.1739916894920;
        Tue, 18 Feb 2025 14:14:54 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53491c9sm92845635ad.15.2025.02.18.14.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:14:54 -0800 (PST)
Date: Tue, 18 Feb 2025 14:14:53 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	ncardwell@google.com, kuniyu@amazon.com, dsahern@kernel.org,
	horms@kernel.org, willemb@google.com, kaiyuanz@google.com
Subject: Re: [PATCH net] tcp: devmem: properly export MSG_CTRUNC to userspace
Message-ID: <Z7UGXdx-Wx4-mkXK@mini-arch>
References: <20250218194056.380647-1-sdf@fomichev.me>
 <CAHS8izP7fGd+6jvT7q1dRxfmRGbVSQwhwW=pFMpc21YtGqQm4A@mail.gmail.com>
 <Z7T48iNrBvnc8TZq@mini-arch>
 <CAHS8izOu33xLNQUJZgKq971f+rfzqaj0f5CG8sQ7U3pKth_QBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOu33xLNQUJZgKq971f+rfzqaj0f5CG8sQ7U3pKth_QBA@mail.gmail.com>

On 02/18, Mina Almasry wrote:
> On Tue, Feb 18, 2025 at 1:17 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 02/18, Mina Almasry wrote:
> > > On Tue, Feb 18, 2025 at 11:40 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > >
> > > > Currently, we report -ETOOSMALL (err) only on the first iteration
> > > > (!sent). When we get put_cmsg error after a bunch of successful
> > > > put_cmsg calls, we don't signal the error at all. This might be
> > > > confusing on the userspace side which will see truncated CMSGs
> > > > but no MSG_CTRUNC signal.
> > > >
> > > > Consider the following case:
> > > > - sizeof(struct cmsghdr) = 16
> > > > - sizeof(struct dmabuf_cmsg) = 24
> > > > - total cmsg size (CMSG_LEN) = 40 (16+24)
> > > >
> > > > When calling recvmsg with msg_controllen=60, the userspace
> > > > will receive two(!) dmabuf_cmsg(s), the first one will
> > >
> > > The intended API in this scenario is that the user will receive *one*
> > > dmabuf_cmgs. The kernel will consider that data in that frag to be
> > > delivered to userspace, and subsequent recvmsg() calls will not
> > > re-deliver that data. The next recvmsg() call will deliver the data
> > > that we failed to put_cmsg() in the current call.
> > >
> > > If you receive two dmabuf_cmsgs in this scenario, that is indeed a
> > > bug. Exposing CMSG_CTRUNC could be a good fix. It may indicate to the
> > > user "ignore the last cmsg we put, because it got truncated, and
> > > you'll receive the full cmsg on the next recvmsg call". We do need to
> > > update the docs for this I think.
> > >
> > > However, I think a much much better fix is to modify put_cmsg() so
> > > that we only get one dmabuf_cmsgs in this scenario, if possible. We
> > > could add a strict flag to put_cmsg(). If (strict == true &&
> > > msg->controlllen < cmlen), we return an error instead of putting a
> > > truncated cmsg, so that the user only sees one dmabuf_cmsg in this
> > > scenario.
> > >
> > > Is this doable?
> >
> > Instead of modifying put_cmsg(), I can have an extra check before
> > calling it to make sure the full entry fits. Something like:
> >
> 
> Yes, that sounds perfect. I would add a new helper, maybe
> put_dmabuf_cmsg, that checks that we have enough space before calling
> the generic put_cmsg().
> 
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -2498,6 +2498,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
> >                                 offset += copy;
> >                                 remaining_len -= copy;
> >
> > +                               if (msg.msg_controllen < CMSG_LEN(sizeof(dmabuf_cmsg))) {
> > +                                       err = -ETOOSMALL;
> > +                                       goto out;
> > +                               }
> > +
> >                                 err = put_cmsg(msg, SOL_SOCKET,
> >                                                SO_DEVMEM_DMABUF,
> >                                                sizeof(dmabuf_cmsg),
> >
> > WDYT? I'll still probably remove '~MSG_CTRUNC' parts as well to avoid
> > confusion.
> 
> Yes, since we check there is enough space before calling put_cmsg(),
> it should now become impossible for put_cmsg() to set MSG_CTRUNC
> anyway, so the check in tcp_recvmsg_dmabuf() becomes an unnecessary
> defensive check that should be removed.
> 
> Thanks for catching this!

Perfect, thanks for a quick review!

---
pw-bot: cr

