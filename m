Return-Path: <netdev+bounces-265212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJIeLGWzrGmgtAEAu9opvQ
	(envelope-from <netdev+bounces-265212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 00:23:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0D722DFAB
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 00:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61417300E726
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 23:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F5E18CBE1;
	Sat,  7 Mar 2026 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrCBTO8G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C63368B2
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772925794; cv=none; b=i5ZHQ8HZqfyKeIgKpmwJinxccvZFHIVyU9ZvPcT+EAKc2GPfg4ZijpwXl88sOWQlatIz3k8NFC7Rq2BMbx4ag6TFUd9l7aBRs91f0lKBF4G/Zo+AxurRGQmr10LbeUmhV4Nsq66iBDUsVUAc/g63GnWhhY9RHgkLtEEoULV0uHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772925794; c=relaxed/simple;
	bh=Mq5OhFz9ZRrRKh36BIfBx/a5tcZkJ4YyS4ra/7mJE+I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oAaxe/Zw8KiD7J7LsaTSnKTC9sx5pJTMLtFnskKW0F7rnh7bxKPTf3/elLQw7dq+nuYM83yEo46MLHOh3c5/6vjSQgWCF1PyzKXYt6rDPlpOTh9YG3yQmx69pB7A4DZG/YRyTK40dpAKIZA3ecHct76H8qw8KbWeUCk+dxBzxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrCBTO8G; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ca6595c8aso10265630d50.0
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 15:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772925792; x=1773530592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5kFWkbbk3l5gkQTI3VmBNgPljzyUkxjJcuKTPQXTwA=;
        b=CrCBTO8GgcLZBd5/IV5wNi4l+eRkadxEyC9ZrBxEHkQ2powoNJuqbA1Fhmqj/IdH0v
         ALwPL8Vk/rjV6LfmseQUp+/DoWvwsd0oeEyOpVFN4c786SvmK7UA5rgBjAZIQKoiNlcy
         Bnbil1llO5MMIZRynoMIIJOxTEGrjiAxEYQeU3N4bqqMPRUdl0QJxLlhyySueI3WWShu
         pDQQsBLuo21lFja40rtSK3aB/vIiagtCC2ZUBmM42bsDGptpt7DoWeB5Y6wruJxLLawY
         T4imJ1b+eF5zyANPSDu2+OD852v6L/cOEEtUKCC9cOI5qDLWOsT7rOqVqUlo32aXBzas
         QQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772925792; x=1773530592;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5kFWkbbk3l5gkQTI3VmBNgPljzyUkxjJcuKTPQXTwA=;
        b=nOwrnvShsbUPonFIhtDeuSwUNRLUb8YAiMmU2l9cMIazbWiqehG6ePsSk/y4lB/IRS
         HlifyzAORwvOctH+QUev9BcR/pfNQXMPfKe0hBYkN50OR6Gy8woaIEaj/z3ef54r8slh
         5fHWFlHKRqH9y1yRiwH4JaNkvC6XzmoRD9AOxV9SDDP3bArc9nh2knkb4BFkcY6eIbHq
         K/7AENnuXrqtOETFo4ITg4ba2WGqLbCLd3j+5bWuo8O1nlB2FD0A5qqegtZXDmPc3BuN
         zuaemtG3h+132ycXqxK7+Rm/MvB/BUyVaiLG88ExmSMwi+R6KsGDXjMys5L3WJZst5Am
         vVSA==
X-Forwarded-Encrypted: i=1; AJvYcCUDyx3y0P4r6hvXFgLwcj0eDy8Dp8/5yD8yjcs78fPsnkukdRbI9XW/Z+pzlHMs/RNCJjNR7Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzjwtpH76R0vhm+h+4/QBMimbgN+xo1I0fZGTWLEtP3tL8g3D
	cLmCcQczpt7kCzX0FGgYNaFQcM1NfJj+7qtKY0wh/vraKvyAOUIHrtd5
X-Gm-Gg: ATEYQzwIkNwCr99lg3wK1iRUhGw8v7+k+/dU+X/EARJoGlosR1KFPfBum5PPHl6r7bh
	PO2eQ2hPL6GbhpnekrWiNoeGUzF6q9wFwn3yJo/2duivOONYyl38WWwLUZAo9nUdcZILQvPjZdK
	khNOdskRmuFnfsOCkYYIp66QcztXk0aki0U/eSMsy28WGnQHE1IG167avzLpQGfGlXIkG0zLYBM
	lVkKgT3zN5PQ13YTwEQT+dInaeqA20QmbvIed02FKosPBgIS4Mxh/KtSuXm07aBKG0Mey9+Jqjm
	S+Z06sVAbNcSMJ52WEMgRcceI2y9PYWm6hdxMVGfP2p8A0czoXntb7rY2P4vTAHJ6re4x1+pSF9
	tBLjGd5Z+kt3ziEkCHRQvITtgKAW1WcqJWiYORQmL5uMjI2yue5GTF3tH1ufR8IptyQ3YM+BDbF
	uzDUQl4zbL4DWYQt/er6QcyFDFsvU6UUuHs+cCn8E1pjOIKfddq1SOlbIGqG+BYuSaKYESRlo=
X-Received: by 2002:a05:690e:128d:b0:64a:e781:8920 with SMTP id 956f58d0204a3-64d1436d027mr6387712d50.78.1772925792366;
        Sat, 07 Mar 2026 15:23:12 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64d175f339bsm2690199d50.9.2026.03.07.15.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 15:23:11 -0800 (PST)
Date: Sat, 07 Mar 2026 18:23:10 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alice Mikityanska <alice@isovalent.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Stanislav Fomichev <stfomichev@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, 
 netdev@vger.kernel.org, 
 Gal Pressman <gal@nvidia.com>
Message-ID: <willemdebruijn.kernel.2005cee64b1e1@gmail.com>
In-Reply-To: <CAD0BsJVgvbmk5y5TKkeFcdMLj+VuCWisX4VXv9g15uu=5ddLVA@mail.gmail.com>
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
 <20260226201600.222044-3-alice.kernel@fastmail.im>
 <willemdebruijn.kernel.346c48b49836b@gmail.com>
 <CAD0BsJVgvbmk5y5TKkeFcdMLj+VuCWisX4VXv9g15uu=5ddLVA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] udp: gso: Simplify handling length in
 GSO_PARTIAL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0B0D722DFAB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265212-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org,lunn.ch,strlen.de,vger.kernel.org,nvidia.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[isovalent.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.974];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Alice Mikityanska wrote:
> Thanks for reviewing my series!
> 
> On Fri, 6 Mar 2026 at 22:55, Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Alice Mikityanska wrote:
> > > From: Alice Mikityanska <alice@isovalent.com>
> > >
> > > Taking further the idea of commit b10b446ce7ad ("udp: gso: Use single
> > > MSS length in UDP header for GSO_PARTIAL"), simplify the implementation
> > > and fix the checksum (apparently ignored by hardware anyway).
> > >
> > > The mentioned commit started using msslen for uh->len, but still uses
> > > newlen to adjust uh->check. If the formula for check is fixed, newlen is
> > > assigned but never used before the loop, and newlen is overwritten after
> > > the loop. This makes msslen not really necessary, as we can reuse
> > > newlen, if we don't adjust mss before.
> >
> > That's a big if. Why is the udp length now set to the segment length,
> > and not to the GSO packet length, as before?
> 
> Just so that we are on the same page: the behavior of the UDP length
> field changed in Gal's commit b10b446ce7ad, not in mine. You reviewed
> that commit and approved it:
> 
> https://lore.kernel.org/netdev/willemdebruijn.kernel.218d53621fba7@gmail.com/
> 
> I'm just refactoring to simplify the code a little bit + fixing the
> checksum field that went out of sync with length after Gal's change.
> Hope that clarifies it.

Oh right. When respinning can you add this brief summary?

