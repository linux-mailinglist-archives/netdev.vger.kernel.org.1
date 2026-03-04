Return-Path: <netdev+bounces-264091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJjNE4nCqGkIxAAAu9opvQ
	(envelope-from <netdev+bounces-264091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:38:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D98209000
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 548A33046DAE
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019A635C1AA;
	Wed,  4 Mar 2026 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF6oBn6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DDD32AAD1
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667524; cv=none; b=lUJJBEaoqD595sfzLC3ANG1HXAyg/OnPZWLx2iRsNyzjrXmkJingK3IWBUZ4zfuZWdBF9dhSNIQdzclWtK495sVeVcH2x1PjspyWA4hI6Mdk3DNzYh3vfh67tLpq5JG8stTAWZI49P/RDM0nzO+odCBdj/qIvo/6ysNRbHkWLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667524; c=relaxed/simple;
	bh=cFGv1sL9pqbx153vxBCwRyGdMfivYi5rRpVeeKWxw90=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WDVsI4IZHVs4fnuNCrK8M4Gz8z96s+gb8sKFQMFc6aOtKv8Zdspc6LStcXzVV+nHSR6ehmjRvyWVlKRGdijpyzMYsTsOf4jns5DanNVbJIb3XmZ9bmnhAaVideT0D4eVZVv6ksssKPVxTGlucf2lniVp7oxROuHflEF6nJk97YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF6oBn6p; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64c9ebd1369so6842852d50.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772667523; x=1773272323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwEg//kb8UGbW1G0PCmmnpwtxLnHg+DSaYUVRtKA4rU=;
        b=JF6oBn6pDxkd/WmNriovCLV9t9gYk9qFKYX3NAL5bL9rpHqTtgZj9jA7k7EaGbOjdV
         zGA/ziOLqro2qlFhasPRaIkcNnddpba6wtAqGIfzVeV/Q3DjE/jSxKkpW6SIr4mcOLcD
         20yb3ZZMUZTOXvFw2Aka+vD91aRPl3dfLEbgm6wJTc9kc4tN12q8DlXCvW55Jrp80jTM
         lTOFVvpGJb6Vzz+DGrMolWfxgYuDlfva4fzbsfSIUztk6C1n0kZ5Tv8Z1XSdPcodRHUc
         MOkiHoM5pAVZ0J0k06Fk//P9V48sHaCGRdfzuWP3xIBI985SaPI6j5LODZ+tLO5Vnr+q
         cHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772667523; x=1773272323;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwEg//kb8UGbW1G0PCmmnpwtxLnHg+DSaYUVRtKA4rU=;
        b=KQGic7z57JwcipdkHxYFKI9ukeQVRXGfNMi1viJWW9mNIEa77MZElTB8fdFFTcoQuM
         FqLWiCr1WNE5NLf4qisIDpYftNvAitPXnAX++4xq8WU69Mz8JWhQkV5D64612L/GidQT
         Bwgq+ETLEDSxxZi0SmJ7mnkAZotFu3qJDLTJzUYSaTihmMA7S8jq+qPxoQW9BdbH8quq
         LQk+RN9P+4053Kgf4CQbvhv7ciyIyBSz6umON2tF/xJIBvmD217W1KklAl3JymgZ59iB
         YXVhznHrDmHXj8UZttwbmq27HsUf638hCmEM9nIhMMwthXD3p7jxpKyZeW60pkeLngVp
         ZpPg==
X-Forwarded-Encrypted: i=1; AJvYcCVLXHtpeKkRopY9B52zNtZqIfBn7pm4G9Pc+e6jpEubrGpSiOi273KjkHFF+bmAgc2KrZQlSAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCj8xXdfn20jPXnWcPh/qQiPlMw+Z8iSZzGQidvZwV/DZKNw5w
	taK/PqTuXLQw37ulvtZpExI1ZCwawbQWpjEnup8ndfCIsgidQlEMmAbg
X-Gm-Gg: ATEYQzyGutb8wRBAg0B6iIJTm+gY7O6vwRsCrjMTOurBoTRP5TI0RWKtF5R1IxI6+MS
	lhZHXKCKhNIyqKbDVafoU9zzQo41sWqvItFKIabXmAjum22dSJ/jcDmYLAF5Y6vE0l0PS8+LdHn
	tahLut5M+CndtzIdr7gz/gwhamAElyWv3UzRNfWUXg0T0BzN+CjK2n8C5yWmerb673Klvdmjs+m
	OIgZyVz5vQ0aDlg7eZm0DsBsdZEwwmMm0+bnhHhP42/km/qgy9Flawj3hm+CY7ayCxDO23fmJnm
	wAGR+Teq08q1hBSRRGhvtJBzGZynp9cPzI/eWox3PTmi/78bEOPGs/cMtouRb9hk30DPlvD1adH
	KJ/wGbTsOanNTsMkbLXAyP502MQDmDof/svBoUbCFYTb1lFKOrZirFKdW2eEOcNnkL5GQ/S3q9S
	5G40ltgpjiMPuoCBORi8d4/EDdXhJQ8btEql+FZnBTiIfQgi24fUqyJk2cmazFu7sn+C/FNcs=
X-Received: by 2002:a05:690e:1248:b0:64a:f1a6:6b0d with SMTP id 956f58d0204a3-64cf9b3425cmr3179552d50.14.1772667522539;
        Wed, 04 Mar 2026 15:38:42 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64cb75ba104sm8430163d50.10.2026.03.04.15.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:38:41 -0800 (PST)
Date: Wed, 04 Mar 2026 18:38:41 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 jrife@google.com
Cc: andrii@kernel.org, 
 bpf@vger.kernel.org, 
 daniel@iogearbox.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 martin.lau@linux.dev, 
 netdev@vger.kernel.org, 
 sdf@fomichev.me, 
 willemdebruijn.kernel@gmail.com, 
 yusuke.suzuki@isovalent.com
Message-ID: <willemdebruijn.kernel.1f16f5ebde0ed@gmail.com>
In-Reply-To: <20260304212128.1943568-1-kuniyu@google.com>
References: <20260303170106.129698-2-jrife@google.com>
 <20260304212128.1943568-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v2 1/2] udp: Preserve UDP socket addresses on
 abort
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B1D98209000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264091-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,google.com,linux.dev,fomichev.me,gmail.com,isovalent.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Kuniyuki Iwashima wrote:
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
> 
> 
> > 
> > Make the behavior consistent between TCP and UDP sockets by not clearing
> 
> This patch makes another inconsistency with TCP.
> 
> As you mentioned in the cover letter, before the patch, even if
> aborted, a bound socket still reserves a port, but it does not now.
> 
> This might be surprising for non-reuseaddr/port sockets.
> 
> 
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

If the only goal is to not clear inet_daddr and inet_dport in
__udp_disconnect, then another variant of that that takes an extra
bool might indeed be the more obviously correct approach.

> 
> > +	sk->sk_state = TCP_CLOSE;
> > +	sk->sk_prot->unhash(sk);
> > +	sk_dst_reset(sk);

