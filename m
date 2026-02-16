Return-Path: <netdev+bounces-258831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN/pDrqkkmnCwAEAu9opvQ
	(envelope-from <netdev+bounces-258831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 06:01:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81851140EB3
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 06:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F65430067BB
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 05:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90C186E58;
	Mon, 16 Feb 2026 05:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2g9pNTU4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2291391
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 05:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771218103; cv=pass; b=Iu8Jfx6PS9PqOGhy5+TTi8gSouxfxxErxQPQLeBmw36eAG0P27X+xLX43BjASXWwrtZCZi+X93sU+cAffsKVHs7RUn7uarlFfZjY/qD0EqnmdtGCyI/KnwrUYBzqwvKzE7CSWoZv/fnEAUxLTgAoMy3oVBmrBBZFtk+7vpRaxi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771218103; c=relaxed/simple;
	bh=hB4EONdthUZNgMd3tuVKHVCvzviJ7IZrB7vtc0TYFQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3M/yyJHnXnYDbd8imZNZw89ESF9l4Te1QcP0QQSf2fvkaVn1/4LDR3zotnfeTPcVP9eQnXcpGmoUp79ZtvGabjb3lYFEiiDin2VE35qSjkz05rIdquU5esUz5kXzRqRUgI6h+zpyB8PVxWZOLvdQ3X1huO38k6fmhDf5OGX/GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2g9pNTU4; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6f21c2d81so312380985a.2
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 21:01:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771218101; cv=none;
        d=google.com; s=arc-20240605;
        b=gcaWgXqAIxCVOBmC+lvZ0WCg/6Zjjo1qtEE6W+2yLzKV9j6F2g4TIvehG8M0DNwjb/
         t3nJ787fOJWrfXiqnU4CepdcHyiG3Itj3YCQb/FXDbgtNNrB6rDGnyJmnsQK0LtEUc8p
         AJ4UnRhtxkxQeEtuoTf3kCmrVJ96bMD5o82arKYPI1eZbL9+s3j1TC5nUoWqE9k/ARci
         fRJua516pV8f42BYI+PPxD/09zJ0EXvUag5gdd2/7DUejga4dV9wIXUjE94008SgiKxG
         T8RY9XV78hNdD378dPuCHFV+NpgWT1F9sswxzqymn5LvJ8wThMQY7s+ZRJPdAuTm3kWT
         bx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hB4EONdthUZNgMd3tuVKHVCvzviJ7IZrB7vtc0TYFQ0=;
        fh=pE+IGbmTOr7WYNEn+oRNb2x5GGUKJnIAlpKVHC0SEq8=;
        b=MkQoBeFkcDjPWghMkrprGyO8OC9ONHgY8XCJafVh2wwUXvpKDLcK/KOM//5N/XfIeU
         VxFTnn04hK4NPXh3JVge/Twsvwhmv0SFpNzx9JZs9N+Jv+wZkspE76XwhZy4zeEYwQ+t
         fDFrerDukhIOiG/F4+emNRVy2zSiKjvDIcR8cjU4tWwN9a1PVmJELzxBhG7pzE3f7i1q
         p8AQzB0zkEwkL2IU104hjnAPAHMjEehPwz4W12GI31gbtMEDPQpP5cNXJABV3f5V0zvl
         Yd3Zc5+Z03teimYH3eX6kNf3Bn2GxsHsJdep4OFqfvi10chPKH0bFQniqQfBMI9R7dhL
         /XZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771218101; x=1771822901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB4EONdthUZNgMd3tuVKHVCvzviJ7IZrB7vtc0TYFQ0=;
        b=2g9pNTU4VxUAMsI5JDa2gh9PP4pMP33JfDOo9e+1uBwNbR3evi3zkW7o0K0NFPJW+n
         VabVU8cTR0D5XPTukT9mkoCGk2VKZj/wMcdEfd/udYAVlGeThmtOKe9dPoHMvPRG8RiX
         INulMcHCgr9NhKFqHQssRbGNRcqAcZ6QQ2HIc9s4RCY/ktUMFQWm/mvoxhukjq3CgUV5
         kEnmcCFcDmdvON47wpI4QbNTEAbe0mdzqAes0FK7BqsCsoSw8GOI4DISFvQPeyNTBaR0
         CFiSi74sdZ2eziOKyaS2LX64SBxC5rt19MtOcEZHs1LKrxik9Mb9HlOvI+n0z36J8CBe
         QJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771218101; x=1771822901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hB4EONdthUZNgMd3tuVKHVCvzviJ7IZrB7vtc0TYFQ0=;
        b=Abm9/bcf+hnS2FW6Yc3dRQbn8FOHWaF5IdlKhQa57IO2qCuHeTQZ2rrTAbsBlwmxcX
         OCtHPx47lUqWhQlBrB89Ru99MNaRz+zlpmwYd41R89jCFsztFGBhy3gK/LYoiYHd1K9R
         WTWP2mFveh8ZCAXsCzczfIzNXtUjs1R+B1peiSEQ9vo8j7BABITnrcFLbDV0BrdiJvcB
         c36Xtr0XlFLgsTkPU6rzjYInHfspK+8H+FR3NHTAFBp1L8Elh8sRXWjwnrHNZfv/6Q7O
         GiR3NGkzPtL/W/lA//vyk4iOI0FXdGHbQqE4gDhmwSkMPYMarwceiBp65vrP3+13detY
         Jrrw==
X-Forwarded-Encrypted: i=1; AJvYcCUvGVXgPV1hgkWdXsmAXEmeIgv6ylAz9WDEEv4e8X5TusEgG4U3tpa6s78uzTReJl4v9lpZcyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi97lC6PQbq87NooEbjY2HQLF2T6adOfx+GagKj4AQAVNst44s
	bR7lqKQ9rmxLOt1daUbGI0SHBRBI+utFdgQRzoHrBkDUXc/l0bLb2wXWzTTRpM8pPh1GLRtWJsG
	xd9D50RzQB8mul5WCzOxNiCp5oU7/JmyOhdNT/lsm
X-Gm-Gg: AZuq6aJsb4/QAOUSVMgbmi6RaWdpiGxbxXD/bHYh4TIZCqxHGDuZ6easlUqx+uk+dIC
	Ob8mdfGtoZfLY2aRkovn/Z4gFardIY5YQb/KF1ZNqfVWP68VXG9TOb+aM3Kh70IG+hthXSV1aTw
	Q5vELyr8eOtd9tko9/FXKa/AWizXyK/mJAPP4pHyBu7nytBakN3DCZlNDHDpipz1Z7rM+P3028t
	GLij2R1AytiKw6qyAx/YzjcOc1qW+oifibr1rjL3FtQ6x9gACMNxXsd9wtB2P3VO1fj/zG8g2pJ
	lngj+CuY
X-Received: by 2002:a05:620a:40c2:b0:8c7:8cf:537c with SMTP id
 af79cd13be357-8cb422a70d2mr1126105485a.37.1771218100858; Sun, 15 Feb 2026
 21:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215143821.2330791-1-edumazet@google.com> <20260215143821.2330791-6-edumazet@google.com>
 <CAAVpQUCt9R2=0UpPJioLTd_T6Nb5zHsp-qfF-CJCQ7RPPbwcNw@mail.gmail.com>
In-Reply-To: <CAAVpQUCt9R2=0UpPJioLTd_T6Nb5zHsp-qfF-CJCQ7RPPbwcNw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Feb 2026 06:01:29 +0100
X-Gm-Features: AaiRm53qw_E5SiKUC9hviopFwbBH6qizX8KmTjsLWl8YyESPKZoQ5Azeow_mSg8
Message-ID: <CANn89iLSGkY8zni9HcnO+rxv1+9YpQ-t7EL_fdeR+skv9btD6g@mail.gmail.com>
Subject: Re: [PATCH net 5/5] ipv6: icmp: icmpv6_xrlim_allow() optimization if
 net.ipv4.icmp_ratelimit is zero
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258831-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 81851140EB3
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 2:01=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Sun, Feb 15, 2026 at 6:38=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > If net.ipv6.icmp.ratelimit is zero we do not have to call
> > inet_getpeer_v6() and inet_peer_xrlim_allow().
> >
> > Both can be very expensive under DDOS.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks for your reviews Kuniyuki.

I just noticed this patch title should have mentioned
net.ipv6.icmp.ratelimit instead of net.ipv4.icmp_ratelimit

I will fix it in V2 and include your Reviewed-by tags.

