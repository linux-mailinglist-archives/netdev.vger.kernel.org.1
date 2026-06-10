Return-Path: <netdev+bounces-297566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a71LJ2I0KWpeSQMAu9opvQ
	(envelope-from <netdev+bounces-297566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:54:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3456680A8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:54:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ShUzBD+h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297566-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297566-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D263330604FB
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77583DFC82;
	Wed, 10 Jun 2026 09:43:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235673BE651
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:43:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084586; cv=none; b=nhoMyXdNhLn2UVzbiAgPG0EJS66JWTbk/0d8uhoQM/MFUDh73RmBbXsK1e2llHjzcS4ULh5+HyAQgPGZBgnZWNo9X8KTk0mMYXBAE+thcnrCMIkEZZT9DlmD9C1VRi7BtzqcWR/qa8XXAbYaLgHZUFcYzulwIKRDuib2hBjzVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084586; c=relaxed/simple;
	bh=2HrDNfAOvmiR19AIBup6MLWdgo7QIYe9zJcMquwk3pk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owzvgbC1cAFC1hW9q2GYMTSg25TnU1OTWikBbiMNck/JzxhW9UdwYadeQP46joz5e60ekmNyAiuB0cUYbwvHPnJjq5Dj8aPZUuYk4cq12N1s8uQuNhigej3pFrD4eGrBXoVMuh03MKsXSzPXH0rlDKkyU4K559P+Zwu1o8dYOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShUzBD+h; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso4749683f8f.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781084583; x=1781689383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2H2mzLmWGlqdMBX/pfyNle3HEyYtt+2gCJrjQNSOOk=;
        b=ShUzBD+hWLNJEaLhf3d+SbRgkV6Ov/ywQWqXtU0mruFGwjbMZFovhoU7MNBZDk2ux6
         8BQuEK+4J+ED6ZXW/tT0VW3FCA6j5rWbo+3DuTfY3u5+kJwN8wt6gzyFVxt9oF176IwK
         pNv/Fd4aDP/E/ITY+Tf0wLY1XDv8QeBQmi1EnmqFNwXt/lTAtj50smI09lEkgQur8Shw
         duRizspZ7dDqcRJ+QZRiV1TYPhlJBMqkczbv0xZvkj14+Ik0KN9OGDbvjBD+0lGsHHPo
         hTy9IbOKU6oCt1BZhUiH9UgytkD6qYsdvkzDWYHx9HvFpsWYHZ5kU3XhT3NRg4+pCkzv
         CRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781084583; x=1781689383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y2H2mzLmWGlqdMBX/pfyNle3HEyYtt+2gCJrjQNSOOk=;
        b=XdkRzRXSylsfRIWOVOqgjSQui5NBTk35REMZ4Go02s96RnaOgmkN5NCmfEXAmeVCNH
         ePSMpP8SWXuvS8pf0cIiyeDDD7JkRJeZuefOp+S/5m+OUwD+Q1d8XNIMD+Dwu6QrcQzk
         nKOpxvpqjoPuqeN3jkRuLuQfiNH5cpx6/hvHed1P8coMdPbQ2jp1fcAmf6lxJ7FSFZrR
         qlkO2LZ6d0rKyd846HMIuwS/un7JFUV+JfDg+XSqB/6x3q77R9+bgVzxsNQo49NimbE5
         tMXn/7sIE0xskkSN62V9wZGz8++DAozkYNftd4nXpMgwirdaJDiVN9pYYGK/0oSS6vEM
         /oiw==
X-Forwarded-Encrypted: i=1; AFNElJ901XGNjeRY+WmxcoKvjK8EUQu6b8Qz6w48GhcLkR8bHnen4xUcIR1O4gtaqGOSCFV9uFIrtUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfBJkjYmirP1O5qb9Rf7SvCOgLQxmaUv/YMN1qLMgNBF80CoPD
	V4yL+213CoG7/D2Hwegi8dNWMou6oy9jHeRckR57zo5wpTCqUvvDGsca
X-Gm-Gg: Acq92OHf3cmJqYamHq4evBg4KXm8P2Yp/Sd4pe17lhpnhnP3b/0Ni/LA7116PblxwYs
	DF0oEYRyupYW+kZRRiZKM/qwhPOAOzm7YwSVN6r3nOCLoCAILP86zBK/ldWNZHivK8dRPnJ8Akv
	R0Vt4pi5oB04sSOyC8YcuphDeJOmfnJC8qdD+va17q0ZbpO1YA/3NHaDILv+fvSlalYAHjuNfbM
	4pv3s0KrsJUeDMoCMmrqvz1tjT+UuJzhEPMNFW6UeLRDMi9v2sx2Kh3fATexQkfT+FdHF5c4Fbp
	Jx1qLI2IYoZ2lN9HFJ3ckI2UUU9frGuuRVFL/r39DSpm5CdFxiU643J7X2PdBn1f9HnP/MTnjWw
	WP6v6zzfZAcq2ZAbBQmoCVcWXYexelBsPj1taWdjs8W9X8Q5d1WW0I9N2BXQ/mrXWY22vSyCiNO
	+ILCohVjfXok1gOM1kxqKeFLl+BMGEqV4KH3WVUoY3j+XATHt/LmM4gMJKe3H6SJdYtTFx3WI=
X-Received: by 2002:a05:6000:46d6:b0:45e:ea46:ce13 with SMTP id ffacd0b85a97d-460304f9d74mr25172549f8f.10.1781084583400;
        Wed, 10 Jun 2026 02:43:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm75285407f8f.6.2026.06.10.02.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:43:03 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:43:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jay
 Vosburgh <jv@jvosburgh.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] drivers/net/bonding: User strscpy() to copy
 device name
Message-ID: <20260610104301.7b7cae7e@pumpkin>
In-Reply-To: <20260609175841.3ce88cf0@kernel.org>
References: <20260606202633.5018-14-david.laight.linux@gmail.com>
	<20260609175841.3ce88cf0@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-297566-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:jv@jvosburgh.net,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A3456680A8

On Tue, 9 Jun 2026 17:58:41 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sat,  6 Jun 2026 21:26:08 +0100 david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>  
> 
> Commit message is required. Please explain why you think this patch is
> needed. AFAICT it copies data between two well formed IFNAMSIZ strings.

Thinks...
I let strcpy(xx->array, "constant") through provided the array is big enough.
This gets converted to memcpy().
I could also check the array sizes for strcpy(xx->array, yy->array) and
allow provided the destination isn't shorter.
That would remove some of the 'annoying false positives'.
Unlike strscpy() this could be converted to a memcpy() (with or without
explicitly writing the terminating '\0') for short (say <= 32 byte)
lengths.

So this patch (and a few like it) can be dropped.
Some one else may want to remove strcpy() completely, but I was only
trying to remove the ones that a simple compile-time test couldn't
show were safe.

-- David

> 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> > This is one of a group of patches that remove potentially unbounded
> > strcpy() calls.
> > 
> > They are mostly replaced by strscpy() or, when strlen() has just been
> > called, with memcpy() (usually including the '\0').
> > 
> > Calls with copy string literals into arrays are left unchanged.
> > They are safe and easily detected as such.
> > 
> > The changes were made by getting the compiler to detect the calls and
> > then fixing the code by hand.
> > 
> > Note that all the changes are only compile tested.
> > 
> > Some Makefiles were changed to allow files to contain strcpy().
> > As well as 'difficult to fix' files, this included 'show' functions
> > as they really need to use sysfs_emit() or seq_printf().
> > 
> > All the patches are being sent individually to avoid very long cc lists.
> > Apologies for the terse commit messages and likely unexpected tags.
> > (There are about 100 patches in total.)
> > 
> >  drivers/net/bonding/bond_options.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> > index 7380cc4ee75a..c57b7d6af043 100644
> > --- a/drivers/net/bonding/bond_options.c
> > +++ b/drivers/net/bonding/bond_options.c
> > @@ -1525,7 +1525,7 @@ static int bond_option_primary_set(struct bonding *bond,
> >  		if (strncmp(slave->dev->name, primary, IFNAMSIZ) == 0) {
> >  			slave_dbg(bond->dev, slave->dev, "Setting as primary slave\n");
> >  			rcu_assign_pointer(bond->primary_slave, slave);
> > -			strcpy(bond->params.primary, slave->dev->name);
> > +			strscpy(bond->params.primary, slave->dev->name);
> >  			bond->force_primary = true;
> >  			bond_select_active_slave(bond);
> >  			goto out;  


