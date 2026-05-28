Return-Path: <netdev+bounces-292817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IAhBiWZGGr4lQgAu9opvQ
	(envelope-from <netdev+bounces-292817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:36:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF7D5F7347
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1D3B300A742
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7C831C56D;
	Thu, 28 May 2026 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmcHMImW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F2431618C
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996691; cv=none; b=nQw/DuV2Ex3jp+ekkzfIwV6ozxTy8CQCbKGZjBq4jTo5FBS8AgDnN+sh5VLka7P0QOKQBhcJp5aeKkRJC8f6GfrqBNc/0LnTGz2XmLN/wGj4UYz7hZqtklLV3mm3VU4Pf31GdD8/RoJMHzqlYS+nrzVaw7owi1hWWjB2IK30I9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996691; c=relaxed/simple;
	bh=TureLoSGvT/t2l+gGQyq6tBMeZ7Lh5lEUfGkc8MjN8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lngaXltSt5+a4VX0nVsfdBoE28YH5KRCjqmpCI4X8hLI/pGCVO2im8Q4DQck2Ka4dLTnX/SBZYpKHQt8YW4gWdRUJh5fePG2yh/10gxfcIEeUIAkROhdIgqdapEHKaSzuRcjPwNuPYdyra2k2oPf58UtxFildjKprHct/YVfPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmcHMImW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso113246165e9.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779996689; x=1780601489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJHH8tTcdVk69kWoiIbmMgDgPdTpdO6J9wSSWHIHs6Y=;
        b=CmcHMImW4LG+cetzq+fKm95LOaPSe39tLOX+WJPXwRb+EiaLmVBxiOGmQEGR19x7EL
         QeHAWXq2lfAQU3p9079o522mR6SpwV/7B6O+ukB/ymh1A0Tf0IhmOQlCfLty6medx0cD
         qwwzm0YO+jDoCkrRQxCS/WfHl3ilDxGKXxMH877p7MVffnUWbVHfo6Mcz906YpgodF3d
         ePpR4Z5jCePYvXPJDocz/nj+mhQnfPUFLFIfWFMt+SJ1V3VX3phYHUnztiFC2HVBMBAt
         gCz+ic0BH9NMtZi4V/xnGy1I+DKJQgSSzr1ki1go3g3+hTgd6YVTTj33hQl5OXs3QUc9
         HHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779996689; x=1780601489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tJHH8tTcdVk69kWoiIbmMgDgPdTpdO6J9wSSWHIHs6Y=;
        b=KRfQnCWzOUPa+d+j9AA/+cYi3emvjAirj6lA8fuIr8KbWvYgQDzpWn6ujqnjzTi23K
         E+NSVztxhhbyDzk2mSO+NSEEKNWBENi7gHWbJyZtsc8dQhO0EIp4sDdHnjmWji8uk7ln
         0jnuaka2xEWbn8MhF8CIRMR/oJWEsCvJVsnN4zHFRl6WVOVkuq8KjFKxmhpm0AzWPOuS
         qB6z1lRSGAyMuFdYUn7+eLGr40HUWWvHZjRoq3VdFsr9tryAv4IddPH1olfOh/J6t+JB
         kv1ixXKJxaNS4NnpwID8/e8Xifm7C3eDwbe1Kk2BvL5XeQHBQWliWOP9/U2tMncyULe1
         dSgw==
X-Forwarded-Encrypted: i=1; AFNElJ8gfu825R2MM+0gbQkPf8vLlKEG3V7tZjxXKA/6Ke5Z+n6S9plj/AvudpvS0ByT0f331ALZoUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz4ChAHINXaAMvO074B0a1g+miizON1Y78FzrLxeKbLP8gV6Ac
	jPsemX5oHzJHPEWrRzcJoaX8Z850H/UlcDx56/+JM4BrLpfYNRlxWD0n
X-Gm-Gg: Acq92OFPkm4HvsfcHYjbKehqMS5RLG8h3+wNL87zCjxzr4n4N8FY8WZef9cTC4Y09jz
	jatrfcMrw/PfsoFribvX5zdbrbCV3ISdECvwg/rNzE2fyh7V3VmQKhMUiOnZWTLePcpFFmxKpBs
	4RlKyN11n0veyCazEQnoaEVZf4RRQ8P4NqxMvvQ6hYS2qyfn4xNwhcTc8ZTkj7+kmqSkCnW3s7m
	12zzwSR9o2LSYYmme1xtq/+NGAeP+QFIswV3TN8AJJsrf7xLLhJK3TEIYJ3Y05wZhvwRx3Uzgtw
	MzrcPXfMe5Uv97vNjBzM71Ljs2zPCoEphE/GL5TuiPkUKr+LZpVKxA9d5SHXXik3tkfr//Pmzt7
	epoCK0/tDq/5lds6oKNFkx4vRHLK3O7TeLL8BaIJ5Rnht4Er9tyv9hoMrE1jyiTlVZd1QNN62d1
	z6bnlulySgBnJNMY+wBPtLjF956EF1wvrhVpbs9vLy3yYjVqEYmhXwye4jecNp4FAbqoPKItmy5
	vx/8dztMw==
X-Received: by 2002:a05:600c:8485:b0:490:5074:651e with SMTP id 5b1f17b1804b1-4905074659bmr384698075e9.25.1779996688459;
        Thu, 28 May 2026 12:31:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909294cb81sm52032555e9.12.2026.05.28.12.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:31:28 -0700 (PDT)
Date: Thu, 28 May 2026 20:31:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, yimingqian591@gmail.com, keenanat2000@gmail.com,
 2045gemini@gmail.com, rollkingzzc@gmail.com, dcaratti@redhat.com,
 security@kernel.org, linux-kernel@vger.kernel.org, Rajat Gupta
 <rajat.gupta@oss.qualcomm.com>
Subject: Re: [PATCH net v3 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
Message-ID: <20260528203126.199a1860@pumpkin>
In-Reply-To: <CAM0EoMkkr7tXk+dHWDhvwKPPo4zrGCcVBokC=cPE_msshxOpSw@mail.gmail.com>
References: <20260527181731.1166373-1-jhs@mojatatu.com>
	<87ldd33l7r.fsf@toke.dk>
	<CAM0EoMndYr5MBg42AOV+592H1QQwxYW3Dw1Q40YtwYx9MfcELw@mail.gmail.com>
	<CAM0EoMkkr7tXk+dHWDhvwKPPo4zrGCcVBokC=cPE_msshxOpSw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-292817-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2FF7D5F7347
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 13:53:14 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> On Thu, May 28, 2026 at 6:26=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Thu, May 28, 2026 at 6:03=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote: =20
> > >
> > > Jamal Hadi Salim <jhs@mojatatu.com> writes:
> > > =20
> > > > From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > > >
> > > > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > > > once before the key loop using tcfp_off_max_hint, but the hint does
> > > > not account for the runtime header offset added by typed keys. This
> > > > can leave part of the write region un-COW'd.
> > > >
> > > > Fix by moving skb_ensure_writable() inside the per-key loop where
> > > > the actual write offset is known, and add overflow checking on the
> > > > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > > > at ingress), use skb_cow() to COW the headroom instead. Guard
> > > > offset_valid() against INT_MIN, where negation is undefined. =20
> > >
> > > So you did tell us not to nitpick, but...
> > > =20
> >
> > Actually, an opportunity to nitpick has opened up;-> I have to resend.
> > In my rush to send the patch out i accidentally deleted the "Fixes"
> > while adding names and removing obsolete commit log. Probably missed
> > something else.
> > =20
>=20
> Sigh. There's another issue that both sashikos pointed out in v2 but i
> wasnt paying attention.
> https://sashiko.dev/#/patchset/20260526155913.1060694-1-jhs%40mojatatu.com
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260526155913.106069=
4-1-jhs%40mojatatu.com
>=20
> I believe this is because we removed
> skb_header_pointer/skb_store_bits() (which ensures you get an error if
> you try to write beyond skb->len)
>=20
> Toke/David - Would this be ok? It passes the tests - but i am afraid
> it will require another round of reviews/tests

The length of the bytes being written got lost somewhere.

>=20
> static bool offset_valid(struct sk_buff *skb, int offset, int len)
> {
>         if (offset < -(int)skb_headroom(skb))
>                 return false;
>=20
>         return offset + len <=3D (int)skb->len;
> }
>=20
> If this is agreable can people test? then i will send the patch

If 'offset' isn't a controlled value you don't want to add 4 to it.
OTOH skb->len is nice and safe.
So the original(ish) comparison:
	return offset <=3D (int)skb->len - len;
avoids the '+' overflowing.

-- David

>=20
> cheers,
> jamal
>=20
>=20
> > > > 2) Add more optimal boundary checks (Toke & David L.) =20
> > >
> > > [..]
> > > =20
> > > > -     if  (offset < 0 && -offset > skb_headroom(skb))
> > > > +     if (offset < 0 && offset < -(int)skb_headroom(skb)) =20
> > >
> > > Seems that bit of the changelog isn't actually accurate.
> > >
> > > However, I don't think this matters, this version is not actually bug=
gy;
> > > so let's just get this merged, and we can code-golf the offset check =
on
> > > top :)
> > >
> > > I did re-run the tests on this version, and they look fine, so
> > > re-affirming my tags.
> > >
> > > -Toke
> > > =20


