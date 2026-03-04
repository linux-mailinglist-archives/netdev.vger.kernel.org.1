Return-Path: <netdev+bounces-264094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLY2J8LFqGlaxAAAu9opvQ
	(envelope-from <netdev+bounces-264094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:52:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BBA209292
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A18C4301E9A6
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CAB370D62;
	Wed,  4 Mar 2026 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oK3evLd9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CF335F5EE
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668349; cv=none; b=agwmKdPcgH/6GGGkvLOPnKCCtYLVnvme2hmoS5HnNU+E+/EoExJJ+dM4EpwuTuhDjAH3z+ju4SBfTRFz9pZZWgR/sql9tGgKkisJSURmfk1phrBP/aLCEJU/5OeFvGmudy8myItzu7Y0GWwno0oTkb4GxF14zflo8MtWr0ujINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668349; c=relaxed/simple;
	bh=oMO2lmI6jl8bfWRtrbTzUfsP4kK3JhJ9nHuZIHroJso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMscvjBmHWoVfHzqf0wim+rgTuO6c+YoS0bHaH/nNxl1BriHJC6MF2Y+Fwr7RfBhWpo1X8UbmXF/qmjiKIJ9myPJmgAXMafFSdAAJ4M7WaknwhkEDno4SVkGlwxiy5IpDZXAeAaALYBC7ljpm56TMHMfwVarMJrm8TrZE8aUlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oK3evLd9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae523d54d2so14175ad.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772668347; x=1773273147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJXWQ/ytiNmgn7oJt5ZgR0qUZMF+nTZXMyr1U431JSU=;
        b=oK3evLd9/s19oYVpWqqUGHjQ8ssniPbGyQi0Zl+AX6le9o9dHF7wNslguOvO1ZF/rS
         9kvUXr3RrZZjqSA5O3DSykB3F15zD3zxTAeFdVqZ/Bd32UbBVwjUAzGrElTfS29xhQJl
         XkceJQcY/7aqK7zScI/QwmwxxhMLUl+3iy2Wp9bjagl9yaCltwg1s3flTXliJ7FksLJJ
         oZkODv0KpmNoWn5+t2qMlr6SSnuAePfV2sFey4ueUjCoPdP/yJ9pmN5bMs3K+O+7lZ4C
         MRqanKV8TDjxwzcYOuj7nO0mj02IAx654ZPxljymcPmdlQABjZm1MxCyKUc0DMa8NQPj
         Fccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668347; x=1773273147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJXWQ/ytiNmgn7oJt5ZgR0qUZMF+nTZXMyr1U431JSU=;
        b=otThnuR8ySaxcjOWYq2z4jJCvjyZzas0zzm2kru6qXwuURD3Ley9wu2+Jr2ZB39+H8
         3podTUePHZNMPVg4nFzZTcfb5i6AAydXdVe1+3U0zy3ogIlCynG3xApjNR/xLI8DIejx
         nb8MCSF+MaQr2UE5qAKk5DiFqurvNuugZTpKn+Y3OwdT1iRVrRFaw6KdfOGUGyAq7cSk
         FshlFefOx/Tom4TkWe8fYwAi/re5P5IZCLRhUYo6UzypjZLaXnryhPLi0SKy4T9NA4dl
         GUhOt3Ar2n+12ZZ7gxCs8ALnO7YvNWTdCD9s3mBdGi63b1dEBhq714BJUVT1Uw65P5sf
         xf8g==
X-Forwarded-Encrypted: i=1; AJvYcCVPM8w2AvwOrJ5VUmj9aupG7VBHH5t2UEVyo8K/sRZTbg8dkukjHlw7xlyyr7t34S4VMurW9k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1XAFHHPJvQSTMluJbvg6jPR9isXAkq8opPSWEWEuitqeTDOf
	7gmCORXIsLcnR8JbLPTSmwz2sk74k+bf1QoLlP/pYDWaQDQ0zhY2fN83BRElgOKnjw==
X-Gm-Gg: ATEYQzwpsplYhxJqhwGoozGA6bpPfaaQGP4P1+c/v/iptaz+fAXYXQ8Cspgj9hreWZF
	v4EF22nLLNq97ncX/hUIwNeY1qaGiTI4OFNfk5v3k2xD1QECeDVk46Gdpu+Clh0MHZWMcj2AV5Q
	a7UELlLkGlj76AIqT3VZ+naxSIu18lpZVBRSkh3bVymfbebP8lRYPyT4XPjkbtObfZjG+7Kd7wQ
	GATSFx3xXm2Dw+uqM5L9YYwrsjZRJTqDmVG7D2DJG66O7dLgRmJQG4GBMB6c3tH/cV3KBXGNh6r
	1YjsphBwHqR2h29k+rPr67114E6aN7oIPYWsp/ZY7PIsvJ+ZSLCjfouB2RKOLCT82GISBpsUvxf
	2PFaKu8Zv8vlaOBXTHo8OTN2tT4aSqjp5bpKOjnCH/bPYT7/plnl24JIRQ5DEOLHoeVUBBpE3JB
	AdxEMBRpNMrr/8Rsaa2qd1T4qHNQGOI6oKA3JslTsCWpRTGP8TYqD925AEhg==
X-Received: by 2002:a17:902:e5ce:b0:2ae:5a44:ea91 with SMTP id d9443c01a7336-2ae750e2726mr647625ad.22.1772668346686;
        Wed, 04 Mar 2026 15:52:26 -0800 (PST)
Received: from google.com (127.200.82.34.bc.googleusercontent.com. [34.82.200.127])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa8059bcsm17879218a12.18.2026.03.04.15.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:52:26 -0800 (PST)
Date: Wed, 4 Mar 2026 23:52:22 +0000
From: Jordan Rife <jrife@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	edumazet@google.com, kuba@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, willemdebruijn.kernel@gmail.com, yusuke.suzuki@isovalent.com
Subject: Re: [PATCH net-next v2 1/2] udp: Preserve UDP socket addresses on
 abort
Message-ID: <skxd6uimyxzi4x5nfmz24ez3d45qiubdnwkqawtbomjfzy5qrs@yb724ykvvkec>
References: <20260303170106.129698-2-jrife@google.com>
 <20260304212128.1943568-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304212128.1943568-1-kuniyu@google.com>
X-Rspamd-Queue-Id: 81BBA209292
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,google.com,linux.dev,fomichev.me,gmail.com,isovalent.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264094-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jrife@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 09:21:03PM +0000, Kuniyuki Iwashima wrote:
> From: Jordan Rife <jrife@google.com>
> Date: Tue,  3 Mar 2026 17:01:02 +0000
> > Currently, udp_abort() invokes __udp_disconnect() which clears out
> > socket fields like inet_daddr and inet_dport. This makes fields like
> > dst_ip4, dst_ip6, and dst_port useless inside cgroup/sock_release BPF
> > hooks following an abort on a connected UDP socket, since they'll always
> > equal zero. This differs from the behavior for TCP sockets where a
> > cgroup/sock_release hook will see the address and port that the socket
> > was connected to at the time it was aborted. This causes issues in
> > Cilium where a sock_release hook is used to perform map maintenance when
> > sockets are released, since Cilium actively destroys connected UDP
> > sockets in some cases.
> 
> Just curious why Cilium does not unregister the socket just
> after aborting it ?
> 
> At least Cilium should know the key at that moment.

Originally, socket aborts in Cilium were handled with sock_diag (and
still are on older kernels), so you'd need to do some map maintenance in
userspace directly before or after aborting the socket. I suppose it was
just cleaner to put common cleanup code in a sock_release hook.

> > 
> > Make the behavior consistent between TCP and UDP sockets by not clearing
> 
> This patch makes another inconsistency with TCP.
> 
> As you mentioned in the cover letter, before the patch, even if
> aborted, a bound socket still reserves a port, but it does not now.
> 
> This might be surprising for non-reuseaddr/port sockets.

Yeah, true. I'm curious if this behavior is something that is useful at
all or simply an accident of the current implementation? If I'm
aborting/destroying a socket, why should it hold onto bound ports until
the socket is closed? I wasn't quite sure about this.

> > out these fields in udp_abort(). Instead, just unhash the socket, mark
> > its state as TCP_CLOSE, and preserve the state of the other fields.
> > 
> > Fixes: f5836749c9c0 ("bpf: Add BPF_CGROUP_INET_SOCK_RELEASE hook")
> > Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
> > Signed-off-by: Jordan Rife <jrife@google.com>
> > ---
> >  net/ipv4/udp.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index b96e47f1c8a2..01a0a0fbcd56 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -3247,7 +3247,9 @@ int udp_abort(struct sock *sk, int err)
> >  
> >  	sk->sk_err = err;
> >  	sk_error_report(sk);
> > -	__udp_disconnect(sk, 0);
> 
> How about passing another flag and avoid unwanted init only for
> bpf iterator ?  This will need another layer of __udp_disconnect()
> like ____udp_disconnect() (I'm not good at naming), or must make
> sure the flag is never used in uAPI.

To make sure we're on the same page about what you're describing, I'm
imagining:

static int ___udp_disconnect(struct sock *sk, int flags, bool reinit)
{                                                 
	same as before, but if reinit == false then avoid reinitializing
	fields like daddr/dport while holding onto reserved ports
}

int __udp_disconnect(struct sock *sk, int flags)
{
	___udp_disconnect(sk, flags, true);
}

...

int udp_abort(struct sock *sk, int err)
{
	...
	___udp_disconnect(sk, flags, false); <--- set reinit arg to false
	...
}

This would have the same behavior with regards to reserved ports
following udp_abort() while preserving fields like daddr. I was
considering something like this initially, but it wasn't clear to me why
you'd want to hold onto reserved ports if the socket was destroyed as I
mentioned above. If it's important to maintain that aspect of the
behavior, then I'm OK with this approach.

> 
> 
> 
> > +	sk->sk_state = TCP_CLOSE;
> > +	sk->sk_prot->unhash(sk);
> > +	sk_dst_reset(sk);
> >  
> >  out:
> >  	if (!has_current_bpf_ctx())
> > -- 
> > 2.53.0.473.g4a7958ca14-goog
> > 

Thanks!

Jordan

