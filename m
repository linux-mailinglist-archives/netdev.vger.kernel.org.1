Return-Path: <netdev+bounces-253720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPWaKNZfeGmPpgEAu9opvQ
	(envelope-from <netdev+bounces-253720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:48:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F3E90813
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BF2730095D8
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 06:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5070E32BF25;
	Tue, 27 Jan 2026 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nluosrmj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C232AADF
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496527; cv=pass; b=gho0E7vgD8ROtEAF+1M33lIyq9RjFxi3CEE1x0/d8OQbjRFB6cZBHOk/stP8IszZhqk6l9e6mnkxs4XAtDEn0HnRwilYyQjF2s8AkfvMrybiV3CoFZyIa+7zTCppBDWdJUy3Ewttw2KtD4HwHlcHl2sKeUpzy4+aoAZTs0ahTY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496527; c=relaxed/simple;
	bh=CxIRMovTnfY7BOPDwAT+IKKznYhpBl0NgKictrAZAM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRza7hcJjD0Rn9jiYHahLAuDmliuerC/A/OiRuZ3XO6TXBBPIDv1Bo8bAzc6FNlrnGpPA8y+OgD0IIscUFRKp4P/tCYbApklifUOcvA6Nn5eZMmwEExLk3hD5/pF1/HAp5GOx7ES2jq6YayJzQgBcEvlSF+kVxDDp+SN4EhZaaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nluosrmj; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7cfd71761b1so2797424a34.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:48:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769496524; cv=none;
        d=google.com; s=arc-20240605;
        b=XqStX3RHeU3fT3+1NC5M76HLdHy7tEGKJt2cecZTduad/6mGs+P1lPNzT+4MmT16Kq
         Uoz85KTMf99ZqJRv9ezWbXWKc0+AE4q45HyNX7Q91uLf8cpBmj+2TQh6tVwpx51PvZDr
         ArTbtKqRwk73oVmcW4wrtwmSRQaX8+r+BqWJmgL1cg4ybm2G/vc8xDxY+oUSmOKlXb9Z
         I2LP12VCOeecWeckBMktv7RAII5zSbYONx0bUjMxFbk1pMrch+A4letnb6dzv5nVfEyY
         oQE9tngYWX4svDAIEtF6U9Y/y2Jy50txZXOrUx7zHpe4xgIyjp9ZaPzWhuenTUP5jIvI
         sJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CxIRMovTnfY7BOPDwAT+IKKznYhpBl0NgKictrAZAM8=;
        fh=J7pcVZ2GjqsjeoMGnPU13Qo5dsrFkW/+C2+KKzaUhWc=;
        b=D9Z0E1yxd3VNL/nfz7HR9gQZ7lpGD5BfZ82JE/HIl5EsC9I8sZdLw50Or7Hccr5vLx
         dU5Zy0BXWX+Ae2bMXw8wJ90wNNZA/iiZfhQwSE1vU8VikYeA3lQYx3+S1edET2oATd69
         voiSXO5Fi/TdtsmPotj1FQ7VAUKti6+kZbMN+EM6OiG6KWyAsMVhpIMWWGn/ysCRWkAD
         IPdNXxbQnxszuVRwO1TUhzxSOWL7WCM58Z1utLYKwjWVRzL1Er4D2pVabjEMcNAjLBXk
         //LeTDdQrNGjvAbnX9xlvSq2nX4D3NeuU0FNC0sMLuNy1YoazCJul/z1pg7G9Dv2liMJ
         nF2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769496524; x=1770101324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxIRMovTnfY7BOPDwAT+IKKznYhpBl0NgKictrAZAM8=;
        b=nluosrmjcTC03EXfQsaf4QF4B6ABR3n/fFgV68xkeVfb1/PZr2WI9P2f2IS3s466lW
         DcLNFtkme7y5gn6bljy+sgz3PdblyG6xGf94d2dwQCE8Kv8AY3jM0typ3V5tTrQbtE6l
         urJ13yKGi4YId+hOvitKw1848zoLduDSWanaFmhA/v1auF2ZYdt7SUXrsLSiqDRINATo
         hm/jZxpAV05TsigbJJlVxcD7wAl6+IskjIE66wt2Trs9goZIJ+zETyuq7Nisjs4VMOlh
         YJj5vsA86fBj01y/cH2FnPMTxDwyrj8ajuNAH8zJ3PJhzfsvgTQ7pA42+5GOrumQt8QO
         DOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769496524; x=1770101324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CxIRMovTnfY7BOPDwAT+IKKznYhpBl0NgKictrAZAM8=;
        b=KPQwAtvSWPeounChxcpLwKPPamy5+BbQVZSM8pxwrYMME5jBLyUab8c7nKYUfT5PMb
         YPz149ru3e6e8oebjG+qN8jqhm6NqNxHsGybptrBOJAA/Gxd1jXlIlg62MMdoU4WH2em
         +NYMP/pibIlPTvAtnmC0mFafNMzuqCv9HksFAg6yUcLW7lmLHnB7xvwwuoWWPZ8D80Pk
         jYFXmt6G9HZP0W+kmE/qDyOYnma81zOG4VoaHwgSibCU43pNUIZSdc7aLlta/1FvITtC
         QmUt1JCqsskolwu8JMi5IGN8YoHaIQpTHD69QLt9wGO599oTMjjLTRQhGNBeRy5Lq5zl
         lUbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrGAkMiK6lMgbzpRaxW2tHTqP6P7pOqTIBLNxvhbkVkWwpfJ8NJSJIbTXM+5AYkMx6dFyOO6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKCDp0L5urdTqBugR6DtIOi115s6m718Pe9PhFiju8ArRpZJKO
	qFITLo4huIz3S2vRq4mq/wjBS/8UvD1zMzFyMTTJJVdmUqbcbSbv09UDQMmKymTBLFY66FzuK48
	YdAMMLlWLI95h6Dt2r8FdG8LEP+n7U+g=
X-Gm-Gg: AZuq6aJFqWHkVaS0uG/mhqCCV+Bt55rWZHlQR1J7H+IdSTGFB4MYYa7RBx93PU/F+hp
	kvB7EjFlzAXJt57ahIod4H2VdaHJKoFU4OCM723IlTYSa4tdC+l+T+uNtrarsRHYp+VwninUniP
	ZW+acpSFVQuX0Ql1Owf+GTGU03JVAX/h9Ff3dDbAbU4uksVcuNKVroZvjKHq0LuR+m468NE/nO6
	VQRhhFsYgMIvF0pbz5v3jo7f7BkRKlC1WG4XaE3xdC2WE2zoWXDiwL9F5+CiCoTIyUPpCY=
X-Received: by 2002:a05:6830:2a06:b0:7cf:cbff:85e6 with SMTP id
 46e09a7af769-7d184d86abdmr569911a34.12.1769496524446; Mon, 26 Jan 2026
 22:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260120170749.101e8bcc@kernel.org> <CAHS8izMZxM6rcF+7Lfw=KFv4dmbHGSUrQBPmxO+sYj=V3TRuwQ@mail.gmail.com>
 <aXe2QhzL4DoVbesQ@devvm11784.nha0.facebook.com> <20260126173124.1f0bb98e@kernel.org>
 <aXhUfC7ZyYge1jti@mini-arch>
In-Reply-To: <aXhUfC7ZyYge1jti@mini-arch>
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 26 Jan 2026 22:48:33 -0800
X-Gm-Features: AZwV_QhrHs-Dl6cs5hMxx8ciXfNLSD4IBMm9I6-KLkEEChYQVa1XWumT4YtOBco
Message-ID: <CAKB00G3p9_VUTEW_KQvS1JAd+Ju_pjrU5r-v_p+K8Y=vH__mTQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 0/5] net: devmem: improve cpu cost of RX
 token management
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253720-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,arndb.de,lwn.net,lunn.ch,gmail.com,fomichev.me,vger.kernel.org,meta.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17F3E90813
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:00=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 01/26, Jakub Kicinski wrote:
> > On Mon, 26 Jan 2026 10:45:22 -0800 Bobby Eshleman wrote:
> > > I'm onboard with improving what we have since it helps all of us
> > > currently using this API, though I'm not opposed to discussing a
> > > redesign in another thread/RFC. I do see the attraction to locating t=
he
> > > core logic in one place and possibly reducing some complexity around
> > > socket/binding relationships.
> > >
> > > FWIW regarding nl, I do see it supports rtnl lock-free operations via
> > > '62256f98f244 rtnetlink: add RTNL_FLAG_DOIT_UNLOCKED' and routing was
> > > recently made lockless with that. I don't see / know of any fast path
> > > precedent. I'm aware there are some things I'm not sure about being
> > > relevant performance-wise, like hitting skb alloc an additional time
> > > every release batch. I'd want to do some minimal latency comparisons
> > > between that path and sockopt before diving head-first.
> >
> > FTR I'm not really pushing Netlink specifically, it may work it
> > may not. Perhaps some other ioctl-y thing exists. Just in general
> > setsockopt() on a specific socket feels increasingly awkward for
> > buffer flow. Maybe y'all disagree.
> >
> > I thought I'd clarify since I may be seen as "Mr Netlink Everywhere" :)
>
> From my side, if we do a completely new uapi, my preference would be on
> an af_xdp like mapped rings (presumably on a netlink socket?) to complete=
ly
> avoid the user-kernel copies.

I second liking that approach. No put_cmsg() and or token alloc overhead (b=
oth
jump up in my profiling).

