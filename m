Return-Path: <netdev+bounces-255479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPwjKOE+fmk6WgIAu9opvQ
	(envelope-from <netdev+bounces-255479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:41:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0166C360F
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 480D23007B0D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4981B35BDBF;
	Sat, 31 Jan 2026 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moPDA118"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344FD35BDB8
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769881307; cv=none; b=OZM5pG8AcxS69Ik31cYWckfm/HaUwN+eRax8OoOUFmH/Ehoj2tRdZueLPdCmOmXdmczLfqBsHjye5KPiK6zWeE7Xp0fln7OL9hKBRLWo/5NEyBrJ05T89LgbEO/HRpYqSlsGpD215IHoTp2iOM3zzdp8T/a84e/oeH+L46NpG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769881307; c=relaxed/simple;
	bh=U7DriEUcK86dPkxQhAKAzOz2fvIGiGMZpIz2TatGivM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LIoXAcX81AVg4WtmDSpXo2K0V7MyFHqdxtVsIF6wo3gOM8WSQzAa9h9AU8RSAKurEvt4h31OWgto2r0e4/aCEogxh9FI/dOG3YphgdJ8WtttW+MMrCnJpdG6ZAkNOIM9dshgLNrFWWKJsYZIcL/GtlnzwyUWw6PgcZM7KK7x8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moPDA118; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64970870c0dso3058564d50.0
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769881304; x=1770486104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8wf43Hct6xWw5pdPTFk6uNM8HLpNcMz3YOsh2PRxWU=;
        b=moPDA118TxQwjrn0Aev18p+r85+lymEQQTSbbZ+HfOgZe3cy51sjeQ2ejt1HUG9wHU
         zew1+nDq/sJHXhItqnNsDKmWd0C65hkaT8Jo/FaDUi71LK50TfhpokC+YZRUypQLOWnj
         YC7Vh1dTHuUW8B26binG4AMJHXqI82Sk99EGeybjAyT0LGMG5zsGBYtnQh5wqiUxGhQg
         E1D9KTvn6zYTqNCTQZRR19DzOW5Q56B1ape2aXl0WKwndHaCoFPvPmiJFRzq1IwPlK1J
         sDzY8QFtjyHrIxfXrGloAVTM0Ocq7nQlPqdeNe+c1XGHb6dlve0v1YOF0PeW/REVRZOZ
         IiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769881304; x=1770486104;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8wf43Hct6xWw5pdPTFk6uNM8HLpNcMz3YOsh2PRxWU=;
        b=WaK6AYHuhMttUQDCsULA5Ev9MGgc8aMw773Wrh/W2wlk8mabYhtCvwgCjPBMHY6joc
         y1lc/C9mQ+ZaWmJok3M7wSthGtX6denjIEvbBdjGXy1vWn1I2HfuORrHEqF3J3kDVVCH
         k7cxJDQq5JPLijWcIiaoTK7taNXgM0I0QD32zwBdXBemR+8Hi3KLwgacsASGBh/XqjN7
         Br/L3nRgr+6+67814Q65LjLEq+TuubWKSYvJWi021C7DiRB/k4a/tQFIbdJgmw5xKHRE
         JGpPj88MzM9hgogl2r9XBB+N6wfolNDtuRV+gaB4w2nmjLMmNwuHvX4IgUlZoq5LHDzN
         O7Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUOJb8sFo0xLXtnaXxn8VxmJNKMR7XmiPryqbBhC+7twV9inMKrk+9BeYq6FW0sBjY816ojSTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBif170q6z1MkyzGiGkv+VjtFBs/F/COnXLV1/skpEKqJ3ncuF
	KWveoLwDYnLu1UlH9WjhpmpWTf+h4og7IDNzeChxsFqDhPkAYyi7Ddvd
X-Gm-Gg: AZuq6aKvkwLIO+1Hza4Mn9QOphmjOPyhYEskcIdHYKFHtgxiA6KfD8UaU6fniW2etyj
	eHOgVkH3BAR51LReOdJUie/ixlS9X6FqAsS3hcfuecBmddOIhqk7RmbYkaxT8jyrJdGKQqIyENB
	eXQg88ln6fyeuRQYMhQNODAX0ps+MaPYrbgdc8YgNkvvoeTvK4636TSgxQG7iKdzcQXfMk2CyWo
	D7nWRCmPmckAoJC4LERrOKsiljkGpoofllRk4V/eeUj8QbUFvtm5c4bdXwkOLH/uXmA9PwVYG1w
	nuirV//9yC8p/tpwAm2ts4XwCKw32FSR5uh30YcmfN/KTrbHvVAAsUUoxIq63i7RA6wQkc4t1dn
	8gcErWhSPBW03Tr+yXwkXef4+qYe5cSYG15ErvujziGXgi6sR/lGAPE6OabdRvL88WvCNgYA4OH
	ymucpX6YcWj/pp39LRE/z4TEltJ2dwUS3viflLZBQk9E+lao4cqKi5Pw/k9wM=
X-Received: by 2002:a05:690e:b89:b0:641:f5bc:6950 with SMTP id 956f58d0204a3-649a8521a3cmr5252742d50.84.1769881303890;
        Sat, 31 Jan 2026 09:41:43 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79482761800sm48563027b3.4.2026.01.31.09.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 09:41:43 -0800 (PST)
Date: Sat, 31 Jan 2026 12:41:42 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 fengwei_yin@linux.alibaba.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.39472926ed88e@gmail.com>
In-Reply-To: <20260130191845.404c5e64@kernel.org>
References: <20260128070359.6762-1-fengwei_yin@linux.alibaba.com>
 <20260130191845.404c5e64@kernel.org>
Subject: Re: [PATCH] net: procfs: Fix RCU stall and soft lockup in
 ptype_seq_next()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255479-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0166C360F
X-Rspamd-Action: no action

Jakub Kicinski wrote:
> On Wed, 28 Jan 2026 15:03:59 +0800 fengwei_yin@linux.alibaba.com wrote:
> > The root cause is in ptype_seq_next(): when iterating over packet
> > types, it's possible that a packet type entry (pt) has been removed,
> > its dev set to NULL, and pt->af_packet_net is not initialized.
> > In that case, the function may return the same 'nxt' pointer indefinitely.
> > This results in an infinite loop under RCU read-side critical section,
> > causing an RCU stall and eventually a soft lockup.
> > 
> > Fix the issue by properly handling the case where 'nxt' points to
> > an empty list, ensuring forward progress in the iterator.
> 
> > @@ -247,7 +247,7 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> >  
> >  	if (pt->af_packet_net) {
> >  net_ptype_all:
> > -		if (nxt != &net->ptype_all && nxt != &net->ptype_specific)
> > +		if (!list_empty(nxt) && nxt != &net->ptype_all && nxt != &net->ptype_specific)
> >  			goto found;
> >  
> >  		if (nxt == &net->ptype_all) {
> > @@ -267,6 +267,9 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> >  			return NULL;
> >  		nxt = ptype_base[hash].next;
> >  	}
> > +
> > +	if (list_empty(nxt))
> > +		return NULL;
> >  found:
> >  	return list_entry(nxt, struct packet_type, list);
> >  }
> 
> I'm not sure this fix works, TBH, we're dealing with an RCU list here.
> The elements are not deleted with list_del_init(), so they won't
> look "empty".
> 
> If the pt entries are under RCU protection I think the issue is that
> af_packet is clearing pt->dev before waiting for the grace period to
> expire.
>
> Willem, is there a reason for that or just convenience?

That would be wrong. Do we see it doing that somewhere?

These handlers should get removed with dev_remove_pack. Or
__dev_remove_pack and observe the RCU grace period some other way.
I can review these, but was not aware of any abuses.

> -- 
> pw-bot: cr



