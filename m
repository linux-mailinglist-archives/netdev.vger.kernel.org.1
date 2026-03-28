Return-Path: <netdev+bounces-272701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNl+Ddwex2k9TQUAu9opvQ
	(envelope-from <netdev+bounces-272701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 01:20:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B5C34CA9D
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 01:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F6C5301C950
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 00:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DCA17C220;
	Sat, 28 Mar 2026 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGRJVb19"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A4175A91
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774657207; cv=pass; b=FJPdLU2NOaDRwV5khYwgGyLZ/sXBSNC4E3supzNB5+Nj0xy2CrF8s+QeUinqvuFxUPDyVz3dqDKfgCSrOQ5Yf+V2gT4sp13jTjg/bhjQvL2mMGFDbVnye8IkOaaCHFihQ4IX0iP1xLDTX/aojnvj2JNY5Te/BADfdDPlmygZyz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774657207; c=relaxed/simple;
	bh=HReTxlIHbdc+qiLiIQurLKR81uRHUpJPUOAoxd/g6HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkfMtMJeKZZuONO5Go6XNNuoITnOzv+dPrmRLPb0V8J0Lc2mDlQo1lzqvt2kNGM/m6+AF1PgI4r57PntG8aGXUkTnE8AmyR6jTq0qoJZ4+eoLimZMzYmMbNxJnMcca72YapcLGmREseaNMp+VQENiYgj/d063n8LTKdmEh1LuJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGRJVb19; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50904a8f421so27046231cf.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 17:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774657205; cv=none;
        d=google.com; s=arc-20240605;
        b=KxCGmxB+zQWbFiyYFxMrCYxbSJj6O6Bh+A+2TqyHCzn/VeMBxKdpPO+cACfqMtFIdH
         UUebQIqMHT6jcmJsqWxCe1D0EgyINl6i9cV4130fq8z6ItPWvmu1+bERT+86Zp68yCj1
         WdJvXqm1LfeEmXYQ8DcV/uxIU/riHyDU1/0tEgfmnO72dVjf/gCr6v8CXfvOabOx2i3i
         pTUU+lmEJ01WiyQKCl7cLzvN9tcxzda+IPVPI19ArIAx0IeViYkoloAMu2X8Vaf18V0d
         8edoFNiIXfs/aMzjVPDp0c0FQKt0qSlJh4UqOABRBZOouBwIdo/1BDh2fUKajvJXX2Hl
         xXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HReTxlIHbdc+qiLiIQurLKR81uRHUpJPUOAoxd/g6HE=;
        fh=fIeUYNjV7KmA/IbiAN+3frdPbHP5NzHTk0ev7cpuC78=;
        b=jmvZkawyJIa3vr+QsmSO/3Q2sSM3XdT9mxQa64W0fwLeRspcnfXUtyOH2By6MbgMnW
         dVy7V/AGdMGNBlYU3FAfjzOfmUriBWhUs0a5AyTJCfunWnamp8s1di0yVej357Nc/F7j
         x6jTWEQybTS2J4RnZ+WAKbDVXUl+OvWebLqPe6dj7fIm2fTMetIgkBPBLWuqaIvq/kM6
         6rJh2cL9Pd65Pl6b5tEwLznvzHcLoxmVUvSQycHPk02yzhK3hVaEPiKZjAyeBXB6xsOk
         lpl2ktJnQ6KiAVLqIHtMUYL/bLK3Kpl/zis8UtzepSbffgdCiKSN+XKWo+8xTijMr+//
         e+bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774657205; x=1775262005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HReTxlIHbdc+qiLiIQurLKR81uRHUpJPUOAoxd/g6HE=;
        b=EGRJVb19HQsoHgwNAeHv1seaKXNU1NYdrGBRqTr8L10SRgcp8Yl6zyxjsXLyx9SjzH
         +xHnkPLXV7CVb7cvkbrGKPJiMBtjtZfVdMXWNLVZnW9kpQoTz8Ef3dFSoOn5qktziDtG
         SD1u2n2lTsAbsaUwWJ9l4Mw/IT1ck6RfwF5kq4xtPFqnoIY1epVAOZLMekFapLuJd3id
         gSCNxUCxi7CSCLKEvjOjymjifrN7l3nz4rzq1buMEz+9NswcMhcSb7aki++Okek3Lr+m
         Eav8/xu34UJ1q2zBFMAy80s5vmvMelquO2OKbKq0leKLlCSMZ3qt5SlRSU//MXoHAsrC
         4XtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774657205; x=1775262005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HReTxlIHbdc+qiLiIQurLKR81uRHUpJPUOAoxd/g6HE=;
        b=riRYKYpXd0jWzFxAJaDews2DJV3w3/nBX1m78sVA4NiCy3fgkxMR2O1bnfJ2cp+g23
         VkuYUopsrvJknM353GMBgy1fQAm2J8JQFDM0TDSP2o77mXMf5GDQfPK6eHcr+afJfPLL
         3IU1tY1d7fGxJWISMyU52l4hknjab7QWK+c+2NfE8XVspPPA1OLKG5qh28VzO8COxyfc
         ylZpccw9OoJCPO6Do/qTM7Y5DIQWm+R3P1/GNdxgL//hx5d9Asn0Unr0rZXHfgC+Qlyp
         nVxBkyvmUdPRONW+edNpOVOzNBJ6mB4rxMdgyQx3/VlTGfZOdKiAMB1QaWaQofeOkRki
         tyXg==
X-Forwarded-Encrypted: i=1; AJvYcCXFdMwKfwWjjecaCz4YWxr5ClfM8pfuKbQBEG8rMiuINf8y8++U59FLmlGJZfX2nVJJ9UJvtOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2FCbzgc8sKFsKZEzizniYiAOWNKLKjFgFZGt3BpAVVDKAXVd9
	Nd0oM7IlXjuYqdDGrLs7pOjY3xlaiN0okS/jLQe/k7tb0AbYMn26FaTYM5ACDs3TMzncmg4WxoJ
	7Ko3yjHyo8+JQNhksT3WsZ4WJZ3WxwWf5zp7nX9yR
X-Gm-Gg: ATEYQzyG3pZcUhzocz8lhwMRPEnVVQeNBfHASbA9BuPbGu15gCHGlYisjRf+sAzLch2
	yMSGuSvXKRN7KTWLlvQcanWobiMY/gwN9iFGws6Hb+4ivfhmC1FmA07fuvpi+LKVG8Q/L/A8qdD
	a5BvL1kgnqJuA87fKIG4FheN8K+QFJ843Rl1kmxCd0pzJ1pFK1jgy85vuTlP9gOysGN7uBHwsRD
	N0Aa3j80XFRbVSzaQ9oCUQH9KmTeVAzs5QlwGV4OQMS21oY6oxKJ8GDnxvbfa8FJBkowHOTQfq4
	pGz7aToBMRj+ozBPsLRMVY8oEEMZN4JYi970xJbUc/ukfxS4
X-Received: by 2002:a05:622a:a15:b0:509:3257:c050 with SMTP id
 d75a77b69052e-50ba380077cmr69361371cf.24.1774657204950; Fri, 27 Mar 2026
 17:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327213441.3781433-1-kuniyu@google.com> <CANn89iLshTzN95t+GV0Tk97n_BCDzjAGDNTb=vSyF1rQNqwe_A@mail.gmail.com>
 <CAAVpQUB=LtWXq_bzET2DOkyw_y5qRsuUf_fNCRE+TtiVHFktZw@mail.gmail.com> <willemdebruijn.kernel.64bceda776b2@gmail.com>
In-Reply-To: <willemdebruijn.kernel.64bceda776b2@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Mar 2026 17:19:53 -0700
X-Gm-Features: AQROBzA5T4TnXQXiUlXW5u5xUHm3BPPC8rE5Ipavrw9-4on1xw54Zv21obnm-GY
Message-ID: <CANn89iL_znbKR2oqOs9kQTgAnNKv487ymr8Xx8ouHFsyAK=o6Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272701-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lunn.ch,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 37B5C34CA9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 4:16=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Kuniyuki Iwashima wrote:
> > On Fri, Mar 27, 2026 at 2:48=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Fri, Mar 27, 2026 at 2:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
> > > >
> > > > dev->type could be any value on tun due to TUNSETLINK.
> > > >
> > > > Let's not warn about it in netdev_lock_pos().
> > > >
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > >
> > > Hmmm... should we instead have a list of supported types ?
> > >
> > > And reject user space requests for unsupported ones ?
> >
> > I chose a safer way but maybe we could reuse tun_get_addr_len()
> > and define the default case there as unsupported ?
> >
> > I guess it's okay even if it breaks userspace because we can
> > just add a single line to restore the support.
>
> We shouldn't risk breaking userspace, over such a sanity check.

The thing is : this check makes sure that each type has a different
lockdep class.

>
> Presumably any truly newly added type will have a non-zero addr_len.
> While tun sets this to zero for weird inputs. Maybe just filter on
> that in the WARN_ONCE?

Then we might hit some lockdep issues...

Perhaps use lockdep_register_key() on each tun device...

