Return-Path: <netdev+bounces-272694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDZ+DNIPx2l3SQUAu9opvQ
	(envelope-from <netdev+bounces-272694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 00:16:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E4634C3DF
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 00:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C244303DF49
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 23:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2AB33F59F;
	Fri, 27 Mar 2026 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPLe0J6A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42998611E
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774653389; cv=none; b=GU82JUxKwVIAQoe45E/gKLj+izrN3a0VdlF9cjXLjlQyMuLGF20juzHnEbiUp+Tkm4h6bsL+Ebw1cnJRrswdHoEhtyPr59DfubxWxsvQm+7JdeCUFj/Bqnwc+kbgcglmXY8jwaGsRaqlznyWHcM4zfjf4qp5cG5ozCQ0LLWgAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774653389; c=relaxed/simple;
	bh=30NFUSR5ovcInYrHdA+br3YLavF9L/Aa+60gqiD3QaQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=C28t3bqYTTmVKGQVcgOV0+pm3a1pvsB/+/0l/WJzrUz/4eMSYRY+HK45gFkcVUSjTtAUYNRxj2fh6BDmOTyCkTWJkY/2HYF+CALo5L1WediV245v9NmRMxHquxWJ2h03OpRNLC5xHTM0+gdrgMOzEEBIf+vwAK3Rycbtj1beaSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPLe0J6A; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64acd19e1dfso2601761d50.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 16:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774653387; x=1775258187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30NFUSR5ovcInYrHdA+br3YLavF9L/Aa+60gqiD3QaQ=;
        b=JPLe0J6AWNldyrPvTVhpZMfF6lqRulYl0G1MZFkkoH+w6QdjzCqnac8x0vaEnoZdeg
         JTRgN9bEZZUWWIz7MAh4GdkTrMsT69uTOsz/jyutdjkwPO0izmV1PyyURWXthOwMv722
         YApY5jmf098b+Hp/tiF42SgZJ2a1giHsTj8VZCwEhvUKlohbGrBgNFdB6j/t6D7t2H+G
         ndD25zjEantY3BgKfFPWIGePLOTOi+KdE3chHXuRrEyKvOQ/VfyA6/InCLxhHsWmtStv
         5jPTXtxbqTTv0fXPac9ANPTKw4XZuJRxK6kYH+BA2PFSVQkJLlHwEW70sV0FFE3WPWKM
         eSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774653387; x=1775258187;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=30NFUSR5ovcInYrHdA+br3YLavF9L/Aa+60gqiD3QaQ=;
        b=boUSloyBK2un/zWC+tz9P+eD0QXSWINmpS9tGYRl4iCw3aCJeaGn7MeKLtzFF1wNRj
         LIPkK9AeP4CqxFs+y55gczhPjDVycxxX2gU+VINpj3UjYG1iSn4KBQoIbP6wk+m9T+o0
         ps1tlZJzYBEhAxbRcNDq8ZYeMNZSHzx7+6Sdk8jud4TlMCrI0BejbiN0mHp9Z0lt6FDx
         uaqMMHV7jyDa3SQ7cSe0U2BEc/4EKeCmWWNDR7aXl52X8M09BfjqNhJmaipyqUJjcvDn
         vFT0Siny2TwRKDC9JFXwiAX3qMfo4jHJ6bSa4ZQezSApK8NgHtBn3jXjEYcPo6g8mdSl
         t/cA==
X-Forwarded-Encrypted: i=1; AJvYcCVL7+m1KRmnj1ns8twDyoaj9iintWeaNXRrUWaZm0OTAGubKDd4mN2jHUBDEdAl8Fsvq3ocgXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+YwH5JMYz+wiFobGUZKYr/6fGXuc1uD/UhkAGpoOWn7fjX93
	TuocJUstXbSxd3ynCjmD1gwZHhdbwsUunxjALQNR7vv0dI6dR5h/S6qy
X-Gm-Gg: ATEYQzyxQQG04nZL9gcMaI0cliwoc9WqEAixe8o6LarPyYJcsQFZpFhHjG7fxgurI7b
	MKjNqP24cdt+JTlECW73jJVzZZIaDAKDbP9UKiHOYnoKjrFV/nVEE7EyQ3LwsQRN7w4uI2s0rF8
	jeZRTFvur1eXdh8iLKWHhhaWSVo6j7y2bjTwNSmqXy5Ou1HJtdYPCvNqBCFp8y1B27WnKP3BVza
	y4MoQ8cAdjCZpe39CMtazqyjae28U35iIhi8A7FJiChWEk5pTRcILBbispPsgEwp56gNJaieDSR
	cdG7rhKW0aTqcl1OayQqC5Bw4qjFGLAoLaVwMkoAuOT8ey9BT6pCs+m5Hq1hNOYD5B1SUBnDXET
	7u10fWWtaqOp2OBXQWQ/y3XvB2pkJWiz8HoC9bqcYrHaIpMJOd16ZIS3FpcZijX4S9ZVLja1WdL
	sbUTUnBegauEGXWqdY8vOcbzOCKutK8v2xTOgO5m5Lygf3p1OSuR7Di4KD7Uvn8M7hMTW9BcY3t
	QJC
X-Received: by 2002:a05:690c:a015:b0:79c:875c:c93e with SMTP id 00721157ae682-79c875cd870mr12075077b3.10.1774653387228;
        Fri, 27 Mar 2026 16:16:27 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb7721b82sm2403667b3.15.2026.03.27.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 16:16:20 -0700 (PDT)
Date: Fri, 27 Mar 2026 19:16:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.64bceda776b2@gmail.com>
In-Reply-To: <CAAVpQUB=LtWXq_bzET2DOkyw_y5qRsuUf_fNCRE+TtiVHFktZw@mail.gmail.com>
References: <20260327213441.3781433-1-kuniyu@google.com>
 <CANn89iLshTzN95t+GV0Tk97n_BCDzjAGDNTb=vSyF1rQNqwe_A@mail.gmail.com>
 <CAAVpQUB=LtWXq_bzET2DOkyw_y5qRsuUf_fNCRE+TtiVHFktZw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272694-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0E4634C3DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Kuniyuki Iwashima wrote:
> On Fri, Mar 27, 2026 at 2:48=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> >
> > On Fri, Mar 27, 2026 at 2:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
> > >
> > > dev->type could be any value on tun due to TUNSETLINK.
> > >
> > > Let's not warn about it in netdev_lock_pos().
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > Hmmm... should we instead have a list of supported types ?
> >
> > And reject user space requests for unsupported ones ?
> =

> I chose a safer way but maybe we could reuse tun_get_addr_len()
> and define the default case there as unsupported ?
> =

> I guess it's okay even if it breaks userspace because we can
> just add a single line to restore the support.

We shouldn't risk breaking userspace, over such a sanity check.

Presumably any truly newly added type will have a non-zero addr_len.
While tun sets this to zero for weird inputs. Maybe just filter on
that in the WARN_ONCE?=

