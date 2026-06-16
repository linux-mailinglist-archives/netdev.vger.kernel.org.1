Return-Path: <netdev+bounces-299950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MiuZIkivMWqBpAUAu9opvQ
	(envelope-from <netdev+bounces-299950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:17:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83025695232
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:17:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kq38Z4FV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299950-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299950-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07C6E301519C
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64280390CB7;
	Tue, 16 Jun 2026 20:16:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119DA389110
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 20:16:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781641017; cv=none; b=j/4S8mBflRnUQgQvu/wxRQ+12kRTceaVBvE0Dff00etuNWv3i+MU+RjuGrA4Qqee7wV/mvGGHuiitg7z4xzthM6rA8orgfUWTLK4+3Kn90CuhCAmGaqrXLOdXtkuG7bc6kiexx3bfzGvrGW9BGuBImy1Uc+a2geWrOGGqi57STo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781641017; c=relaxed/simple;
	bh=NDPe7BjRqQO81lM7S/gk96lWQXHDy2NfdCGZ9cKvSfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9K+nK8TdMh5Jxjmxw7kc3ZH6xw60caPBE877o8T1JgbOVBvSz+bojw5od/p1IdcsgEkXVNbEe6TditbthWRAfJJgcROiGtSczhDsG51pX8WnLr6uk1Ma/Ar//fuXNHp8NG1avhWkmN7JiKACOTDftGE0aTMEMG8FYOeOI9z9fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq38Z4FV; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef616daf6so5712478f8f.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781641014; x=1782245814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZHhd9DZXAW4wgKJX/mXTrxz0x9KgaM+DPaZGQCTuSg=;
        b=kq38Z4FVvBxl8kKxz6uizR6o7FvFkKKgk6E+SpK5yIJGXpEhyhMgA5/L622GJAtdRl
         S25Newj6Z4vcGrtkW2GV1ynCyLuRLlBbAvjmmcHc4NgONuwhf6PVlccDDFhKnAmWaf6Y
         K8HpQq1sLAfLLKzILxEhOc4gzlN8aFDNO3iWnaT/abjZfE6HcuDpz2Ji3i/rRalZ/gei
         79c5+69HeaLgxVxgZbMTW1qIyFUKGqZwd97Hbo8pLzFPrSDwAreBX87C0IuyzN87CjGy
         b2skhi6zApUyQroxJVuPGHXhQZLw+A2pkYD6djGjdDVxEErDVVm898wSpwsiJIp8bw7h
         x0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781641014; x=1782245814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ZHhd9DZXAW4wgKJX/mXTrxz0x9KgaM+DPaZGQCTuSg=;
        b=qfqGnXZUpOjswbIhzxUL+gY8hz20hcGNoFDqErPPnySWmAegfmOl9QQHG42Y6KGAYN
         XyviVzh7nwsUng8nClfMbKetNhGWY6WqFw02jXNye5C+ErAl7AMAyLb+rZdAraBRTgnU
         eERFzm9IFLIKSBP5O7oSlPbwjHTsxCq9exJwpLVLAt7TsXQGkqDdhWJkC9kkgQk0KjmG
         gSVOrMupljeNl46VAIWK3tUmiA9iJqQRFnZqJ96+qmqPkF1/KxnUjWLDCmilfZxsWnJG
         kY/ugTAn2IUzBdlt87C2cY+huvvZs37Ukq8sbAT3qAoKxUgEhUI8xYKQyZkISJmpgkbr
         2TBw==
X-Forwarded-Encrypted: i=1; AFNElJ/O18rwSOMHZcSgVDDTiSXR5K6rrRuWgeXaD4tZu+1lgZgkCNwKaOGULTGvcCxzE6MMJxiPH/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzht56AniUKnQxLR8W2l0DbX95ztcTrNS2q7yG8dbjRldUGTr1
	3N3fL9P1oSkD1k3HEB6p3lxDVDoeNeh4Nk9XgenJxqE5CU9qzijIkJGz
X-Gm-Gg: Acq92OH8jU9L3dKV2b6z1DZOgDCUBQOWHPXPMuuAO7GEmxoicgo4qsqFby+DZKeq3Uq
	nV0wyHVMhClzpF0JyI7R+Xvo96WnfqLpTd1DD99Xg1peqfSQVwgjUzBp3NseoT8Tg3TEGrQJFA1
	cLYKAftJhl1AwKHs+lrbKj+gq2B4oc5D1EArmEzRdPAA167qE6NTr5ftntc7O+uFM5madzZ6Ydg
	MClHx+ClJkmGRXSNGswYxtsRkNUbYIBzeri4M1fhPRzXAdzaNstyhdJtZCal4qgoxWfm7Twwi7F
	hhch9CLHJSmSZDF30SCYo9NePfjPmgpfwGJMY6KGwdCjA8No1Eisc2FXArXdHIHNwvYGksuzLPp
	PJeNt9ehMcPSg+hhJjc0cga8alxfhtgEbMvPsY4SZGh28B1a60SiOlpAk24qFAUvnHjFwCLs04U
	VnGLuF2W3Dadoyd9r1waRVYIIwKF0b1Dc5aVipvECr+RqBRweSmXm7uIbnzvKg+ikg5pQAlxM=
X-Received: by 2002:a5d:4650:0:b0:461:a16c:a5f4 with SMTP id ffacd0b85a97d-462391826aemr1168139f8f.33.1781641014427;
        Tue, 16 Jun 2026 13:16:54 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619fb12edbsm10160310f8f.17.2026.06.16.13.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 13:16:53 -0700 (PDT)
Date: Tue, 16 Jun 2026 21:16:52 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net-next 2/2] udp: convert udp_lib_getsockopt to
 sockopt_t
Message-ID: <20260616211652.448d6b0e@pumpkin>
In-Reply-To: <ajF4Odi_L28LdIXC@gmail.com>
References: <20260612-getsockopt_phase2-v1-0-7b01f1f5d106@debian.org>
	<20260612-getsockopt_phase2-v1-2-7b01f1f5d106@debian.org>
	<aiy7ZR7Yz2Z4Ioyd@devvm7509.cco0.facebook.com>
	<ajF4Odi_L28LdIXC@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-299950-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:sdf.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,meta.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pumpkin:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83025695232

On Tue, 16 Jun 2026 09:22:52 -0700
Breno Leitao <leitao@debian.org> wrote:

> On Fri, Jun 12, 2026 at 07:10:15PM -0700, Stanislav Fomichev wrote:
> > On 06/12, Breno Leitao wrote:  
> 
> > >  int udp_lib_getsockopt(struct sock *sk, int level, int optname,
> > > -		       char __user *optval, int __user *optlen)
> > > +		       sockopt_t *opt)
> > >  {
> > >  	struct udp_sock *up = udp_sk(sk);
> > >  	int val, len;
> > >  
> > > -	if (get_user(len, optlen))
> > > -		return -EFAULT;  
> > 
> > [..]
> >   
> > > -	if (len < 0)
> > > -		return -EINVAL;  
> > 
> > I see this part now in sockopt_init_user, but you mention that it's a
> > transitional helper. When we drop it, will we loose this <0 check?
> > Maybe keep `if ((int)opt->optlen < 0))` here for backwards
> > compatibility?  
> 
> Good idea. I will do it and respin (once net-next reopens).

The best place for the negative length check is in the syscall wrapper code.
Pass an unsigned length through to all the protocol code.
No need to require every function to do the test.

Note that the length check was actually broken in many protocols
going way back well before git.
There has pretty much always been an unsigned min() check that converted
negative values to small(ish) positive ones before the check for it being
negative.
(That predates min() being a #define.)

The recent change to actually error optlen < 0 might actually have broken
some applications that passed uninitialised stack that was always negative!

-- David

> 
> Thanks for the review,
> --breno
> 


