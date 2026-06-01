Return-Path: <netdev+bounces-293889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B/zDNvTHWq6fAkAu9opvQ
	(envelope-from <netdev+bounces-293889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:47:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 944EE6243D2
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E086302BE38
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236BB3EFD13;
	Mon,  1 Jun 2026 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oELoZ0VS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A282C3EDE5E
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339293; cv=none; b=CpJgAkv8/IzLChzJGCJuputND0XVt0CzrBJvlZFpmwebJVGmJc/IdfIm8GaZA3MY1GAEOvXYOnVdR4O3V27UjSrRQ6g9kDEDQZw9UZ2Xqa3l3szClO/31NDgTcTUhBGQAKOSxTgl/SVKDKjgPh2FJsIbcwKQCD03MMZNBlLKOeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339293; c=relaxed/simple;
	bh=KcYkINV1ZlG0Qamg5wYbsjaqYLLA239Zyfa4DeSP4mo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nYfrmaTp8XN6U1QKeASnWMOXASnRPhLC4BkRlf9hUl4IA5KUVStQL+w1eCSF3W0T5G6QbxEtslBTCqSTPQGksZhx5zqr9Rn18/X5JAMLjqWqSKz+JUN8g23DRghsYh4HHFlpJ+xEZljIdkYbGGdvF4xZ5oAaeGCRwaBZddTx5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oELoZ0VS; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304ddfcf72cso4371103eec.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780339285; x=1780944085; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T+WC2ug9yq79gIgrEeKHfSxVivYnKgk7AcPEO9gSSXc=;
        b=oELoZ0VSzCm5NMQpByzXUYPn7eTHlbrhv0DLdYXhAaXU8+5c6FXfRhzjXt8iNFxrgI
         DwowpYZee1Davg1lSbiGIHFwl01A2AAhZ5mOk30iIOKEL2TmkE0slyZL7nMwnibVsbtn
         QRz2ZkjLJHE/pTSGnusZJ4wClr51Reixzz0MlNe5HRGSwcUtZS8SZcHFJPVtlRMCTjuQ
         1vHZeF0MnTuH9kpBwyGPzWvUFeKejEXZB8Kurj/ihKDFm0V1OrWjpAKkeWyaFArLnYcd
         eweRcivQDy9SN5ZVq/QVm7+EZdTxBfcai56FUYY3tVjeeBDATX9wJJwXgZj8URaamwge
         q3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339285; x=1780944085;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+WC2ug9yq79gIgrEeKHfSxVivYnKgk7AcPEO9gSSXc=;
        b=iKjv/8a+JEHDW4zaMToLMPXdJ4kXAcyaWFqg+Cr2U1Fg7+aTZnnxOdFA9HFW4sC4T9
         nstkbJ4ChVRmRexiZhcc1XMRJ7Mp2b7eEEQt2KKXDgb7qd+rvScXOhZuhYYZnBEQ1LXM
         6S0h9qQj9it+y4sE/9yqOQunqaCwf0NyzOT6LYZ6XBUlc0qP33vhyO0hJep+h3aWEL8I
         vbEIapp2kKskG6/IVdIENuJyFk/JIEP4rPBhIt2A9Nuh54qSVpfltYC58EM6wz6V+Ok0
         gzw6WjceN+APpHc+iahZb3gKeGyHMWR9r1IH6ss1fWZvaLRm2jPJnRAf1vSeBRsU8SAc
         6YgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9R36XpbFaeQHFGksxeYTqnpf2uY0MjZs4l4vdWzy99lvd7pOHGvmIVGu2YKH14jkQ7xRNAR6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi7jKhOqM3MV9juzfppxma6GXNYTTtzgZdtuxqozq89f8OGPpQ
	HIriBW5QkHS3trl29mDwSweY5wIaiWNm9SOomxzWwwnPvKyH/cUr0ieEtdwS+8Sv
X-Gm-Gg: Acq92OFjjwXCz5Jn9cbWFX/FErWXdTTMT27VVxq6GrWvGe/JsP6D67CD1QopYihIuDD
	7OV9GyALJ8hz1RokXzg9DjlDsB0PNMSg1MI7zqGCswVl0GOQwfXar+LTk7Iv5LengJDjcujW8s7
	O/pccizROn5lxDT2WKG/fUg7MBE8/edGj8zqbrmjN76BknjIcdI/mdA3Ltt0gWO+2vk3rOV392D
	JvIWXh3bIGBJbnHRMtjnu8NpayLkvII89Sdfuc4fAZtDUrEDL4NbbQJrRUrG9GyUuYru2CTWHhY
	tkBV4YZ2A5Lmex3F/veMVUeUagtRNY6mvQ0J5Oowb9V1t9LAcMv6gsR5qb8Qc0H5xqsbKgKuvFY
	G487jz8XNrGv0b+y+Y5daFAoJsmPs7+BpDeM7cX3R+ploCWzXXsxkuuQQxDpKUlWfJjUU132Rvj
	yz4Tpu8DsCU+fVoKvKHFDW+2d7TqohU9qP7Ml6aM29dWPdFZUPuPlJ+Dt/qc365V1l7rz94jPhA
	6GFQyWVqH8qCA==
X-Received: by 2002:a05:693c:2c86:b0:2ea:b85c:153d with SMTP id 5a478bee46e88-304fa67b6afmr5705576eec.27.1780339285358;
        Mon, 01 Jun 2026 11:41:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:af92:b4b2:3f30:fe90? ([2620:10d:c090:500::96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2f2904sm9588225eec.9.2026.06.01.11.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:41:25 -0700 (PDT)
Message-ID: <37d229e482df3367436d9475d6e9d6d69c7366a5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 05/13] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, 	andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, 	mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com
Date: Mon, 01 Jun 2026 11:41:23 -0700
In-Reply-To: <CAMB2axNK9rf12YyLjfeUHWUpGEf=UrCtdHcgd2Tq6KcFY1ergA@mail.gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
	 <20260529014936.2811085-6-ameryhung@gmail.com>
	 <1bf1a11fa5dcb38287384833dd77c748f3a766b7.camel@gmail.com>
	 <CAMB2axNK9rf12YyLjfeUHWUpGEf=UrCtdHcgd2Tq6KcFY1ergA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-293889-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 944EE6243D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-06-01 at 11:36 -0700, Amery Hung wrote:
> On Mon, Jun 1, 2026 at 11:00=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Thu, 2026-05-28 at 18:49 -0700, Amery Hung wrote:
> >=20
> > I think refsafe() needs an update.
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
> > [...]
> >=20
> > > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > > index 877338136009..5945956a7573 100644
> > > --- a/kernel/bpf/states.c
> > > +++ b/kernel/bpf/states.c
> >=20
> > I think refsafe() needs an update as well.
> > Something like:
> >=20
> >     --- a/kernel/bpf/states.c
> >     +++ b/kernel/bpf/states.c
> >     @@ -886,6 +886,7 @@ static bool refsafe(struct bpf_verifier_state *=
old, struct bpf_verifier_state *c
> >=20
> >             for (i =3D 0; i < old->acquired_refs; i++) {
> >                     if (!check_ids(old->refs[i].id, cur->refs[i].id, id=
map) ||
> >     +                   !check_ids(old->refs[i].parent_id, cur->refs[i]=
.parent_id, idmap) ||
> >                         old->refs[i].type !=3D cur->refs[i].type)
> >                             return false;
> >                     switch (old->refs[i].type) {
> >=20
> > Wdyt?
>=20
> You are right. It needs to compare parent_id, but maybe only for
> REF_TYPE_PTR like below.

check_ids() should handle the case when parent_id is zero correctly,
so I think both variants are fine.

>         for (i =3D 0; i < old->acquired_refs; i++) {
>                 if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) |=
|
>                     old->refs[i].type !=3D cur->refs[i].type)
>                         return false;
>                 switch (old->refs[i].type) {
> -               case REF_TYPE_PTR:
>                 case REF_TYPE_IRQ:
>                         break;
> +               case REF_TYPE_PTR:
> +                       if (old->refs[i].parent_id !=3D cur->refs[i].pare=
nt_id)
> +                               return false;
> +                       break;
>=20
>=20
> >=20
> > [...]

