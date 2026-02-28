Return-Path: <netdev+bounces-262166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAkTNUoWo2mJ9gQAu9opvQ
	(envelope-from <netdev+bounces-262166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:22:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC471C4430
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C63C930022E0
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 16:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349F82D2483;
	Sat, 28 Feb 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkapF/kb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BF62D8762
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772295751; cv=pass; b=SMrvvuBZWCIreoLnmLH7qJy1zD26VLrQb6bfYacBff3KuevoefddSYKquwziu+/qzkrb8WsYi66tunzr1SRPudlpiB8mIyVTbjCb4a+OHfEz3rzyhlwFiV3VDrbzksYJUentoWIzw7ivVxbgzGamjAaalVc0CYUbxKSwj5bGgxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772295751; c=relaxed/simple;
	bh=2EmNqsvfwSgV29bgzFNK05xTABzdQIux3l5mFDejotY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rni7QN9MpuJS1sid5VUL1ylHdJkQmb5ZqX0YEI7Hs1Tt8tJBKLyJ4PBP4Z7xZrIV3sQfmcpAo/qB0A1VlBSKRNlYIIqrJMUDHxfZg1W/giLz44sQcVE9yTlSUCOKrQDvDrtJBWHDDpbgMPkeefTXznUfyQ04/k2w8UM4PZjYVUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RkapF/kb; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899b95707afso43110496d6.3
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 08:22:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772295749; cv=none;
        d=google.com; s=arc-20240605;
        b=jY9PlTqCxlXdk6+/n7Z6ohQtSyrsKQbY/6a7TT0DVuTasDadNOq6ykOeI1h17K1Vbl
         wo35oiLQP02HY329AzxH4r/fagj8MGqgENACmB5c+PaIPDCc0VwvuSN9ffMlbg6e8mlV
         6C9o3cQ2VuWsd2ePzjNmGGsW90BH/bCNScOnb/+FcAAvKl9f9WalzkheIKB7TSXlt4XG
         Ji/CF1wPwB14nFZf9z3tXxPdlEAQxf83Tznp56M+gHuZLBak7odV2T1exSuQmG41SyM9
         Mr4J7ettzKeopRBaYsaA56vOGzm3R9/X0vU6O4+yvfjri+1+pVcO1k+6/SlkWb3+TCPA
         UotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2EmNqsvfwSgV29bgzFNK05xTABzdQIux3l5mFDejotY=;
        fh=2B7bor9eMGInIBgsjG9Dg9/rIbn7pbnh3IXH+cZKQiM=;
        b=DyQa4hyvSlAPAvEbA6y6qpD4R3gDL+brYfOuhxETXi1gnJzCFxiuUG10oDCmt1tzQa
         WQyqrFEVtysBoFmuOcd6khV4lRP6FzfY2C/ZjV+wt1aMHzncrO11gY+begyXdocKWunB
         816HMrJnFA3oNjPg3S+LBayHZ8pALNZC43N4vuIbuvYMKH4tpleTXyqUEB9k5irFbkNj
         wcV6aRYqvH4HhdtcLDfYvJEQfvygkeO/6Z0gtY9Pwu05BrgYq3QgsgVl9XxFmQX+wF5w
         TgIN/bYZ2w/2UMYLMb2G1EbPGTCM/mgFDM86UI2Om4+waplq4J5/31o+ZRteqhKQC00S
         ScHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772295749; x=1772900549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EmNqsvfwSgV29bgzFNK05xTABzdQIux3l5mFDejotY=;
        b=RkapF/kbOvVg0aqUP0yPYbb7OOP51450sYJMZ3BYmh2iCEazqwzWflxyjEN72+SJ67
         8RhRiivHfFwZHvrmSKWU/6L2q83n4cYyybJJbhSLniFV5AUKUFfV2jy19ZQUg0CB83N9
         MgV50eXQSidtPwZmZWkuX/Wz7xcdOcOP13B4Nl1Z8W1+z0mgy/cC3ft9RmNDzjBsHM5P
         tE0SIhelf6+qnfyrQ3S18InpnVSqkSgp0EowWcHm9mIXSqLE4K1IBsis07YxFMGEmoo1
         QLEZk31V/apDFKsbIduSqc+k1zok4PPNSAYt8Rh1KpZsFbX6j1nIq7D6z5EZrFyw82sk
         YOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772295749; x=1772900549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2EmNqsvfwSgV29bgzFNK05xTABzdQIux3l5mFDejotY=;
        b=pHKmkfUXAAOwTTw0gscfCV2lCm70TumyGx7j3neTdTRnOaTi1FSsafV++fyl2Fb7nR
         33ADZ6Sm9ZjmcxTAPz+blsxib2s3vpoTjT82nERsNwDj1PshmSmq/daTGeTA4swqwW9F
         Ot4l5LpT1B6QxBqmfrpoM2Yt9TaoVquXSp4zcMIpybPdqgZsOgP4rcpiA0URfUeIQQ18
         VWYZpURSwJlRy0U8muag/7d05ni6t8NAIHpG/Bb7oixSwT3lUeOc99OfqCgHxtCOhFZE
         1rET4oWc+gJmlpPtkhCzArllFclh1Sp2MCrrTG1ND3ufQ/Vp5abUbYhkpLLOZQ4l5jJU
         p6tw==
X-Forwarded-Encrypted: i=1; AJvYcCVIlmGBGnI+Q90myYWq8ALKUA1/mLYpuMz6RBeo7+ub0Wu04zkYBzzL8l60GsvhCATdkZTvaHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmcRsx4zNS78+3lR4fpAPwLDJMPSEofkNgTDZ2oRnoMxr+C4mN
	zp2vAe3m8v9c2JipiuMSGhxCCk8f9HCD86qz453vcZMN46A2tnmtoUpvG1t/aEPgrBOZsp/GJi5
	KgokD85tE1rwTBJE2z9m0tI2Sr6RuFlnY1QFr41/Z
X-Gm-Gg: ATEYQzzIjUKO+beRAzZB/JbXc+UE1QMbjVaSrYCq1am7YG6uy6pPCdH/1s01DVvT4SL
	i7uYgMyuxnLIcwGmPsDytGh729sdOpV19xk0NOT6qKUDWVYyRhWToHi1zSjqOkdJjxHxzWtYA0L
	jMM5QhuvLe+UDh3qAJ7Lp6dwWRZhAYfOiiXAVP1GZAQb3MIzJ5Ykt4rL2Lc9kwSkXb1Sm6zuB4b
	r7I2uCa3zGyEc+N8IbjNayLKbQ7tDQO39fzW+cWVNPCGz7a3pO9eIqnSxy/TuNgV7omDe50Djy9
	u0GJ7hee6NmxXCl6Zq0=
X-Received: by 2002:a05:622a:1a92:b0:502:9e93:617d with SMTP id
 d75a77b69052e-50752992970mr87291941cf.46.1772295748473; Sat, 28 Feb 2026
 08:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-15-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-15-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 17:22:17 +0100
X-Gm-Features: AaiRm51JZxBEnPMKvKpT6UYFImLerMda-UBE-ajfbMer-6KnEKR23o6JlXkq8bw
Message-ID: <CANn89iLe=ZmhL6k5VXM5uWUFiduADBUHsjKsOzqUqnwUb-8=3g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 14/15] ipmr: Add dedicated mutex for mrt->{mfc_hash,mfc_cache_list}.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262166-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7BC471C4430
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> We will no longer hold RTNL for ipmr_rtm_route() to modify the
> MFC hash table.
>
> Only __dev_get_by_index() in rtm_to_ipmr_mfcc() is the RTNL
> dependant, otherwise, we just need protection for mrt->mfc_hash
> and mrt->mfc_cache_list.
>
> Let's add a new mutex for ipmr_mfc_add(), ipmr_mfc_delete(),
> and mroute_clean_tables() (setsockopt(MRT_FLUSH or MRT_DONE)).
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

