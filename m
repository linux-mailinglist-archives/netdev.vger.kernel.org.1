Return-Path: <netdev+bounces-280558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KnkBtZP6Wl2XgIAu9opvQ
	(envelope-from <netdev+bounces-280558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 00:46:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E37844B525
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 00:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E76C303B4DD
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 22:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED8B36BCC4;
	Wed, 22 Apr 2026 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf+BJfiG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9232ED24
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898001; cv=none; b=DOUpaQw/2p1UalXNl1KHXAy2ehGA79xAJygpcA6/rbBFcJwioTucdh91JwTdlFiuZxjvtdNSgCGgKOjVk9/CaW79o+/j96aWuYX4IIe/1B9jWYdCJ7vgnh/X1ZyYu/UTQnGUswg3hpLJb70uaM9BmzYODmallmuZhW0qGRdGOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898001; c=relaxed/simple;
	bh=F7TJBzFZwZLMVJ/+7nHLGSi3U67GV5N2TOeyd0Ipg54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LIFeCC6SJWTauhmnBnA/hnL6MVJylPuDOXCpgfUY7RHiw0l14TR0+MMHoIC10W3+n2ZYMwhTpnwHZZ7HgyPN99R3TREh+lpYu/JoZOGIbHPBjOX+JCnJzHVtk4sHxMowvZhhESN145ul4QrWCsI+ieL2QCGBjF50IqN2QOIF4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hf+BJfiG; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba895adfeaso6658877eec.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 15:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776898000; x=1777502800; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9RSghCmV6ZXfFUAOGVeKtkj3rRXQVbd2GMNzi4ARfNw=;
        b=hf+BJfiGAk7s8ETUeNSdLf0f0Ymry+JbeaaKh74NmquXnw/DdY81EYzFyLEDtlIXYs
         Ej37jFJo0q6p3FE/raeiu894aUElR5XRHvjLloy6UYd0OHW1QNzFuHmuwkYKTynEkUX5
         /E4kYjATN2ntTWBiucJpSXqVqOHFmE1eHBLfwHDfEJcxs5UKON1h4DoUbJA9jvwAbjM8
         NgWbssooGBWYBgchFi56zB3nMxnEah08cLw1+Ol5W6gKLV8/qkLj7D38Q/M3etZYH73Z
         aLTXEhAKWvrLsZBx1XuZoCeIPmpte8RDK7J9Jo6SVx+66AS50s3+Ad3tn2M2KwZgTGib
         s0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776898000; x=1777502800;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RSghCmV6ZXfFUAOGVeKtkj3rRXQVbd2GMNzi4ARfNw=;
        b=O5f3RocGCItL6J9EEkMuGbly4vj0on+lxC+wmvL+rZQMld28OnWieFKnhkrK5bzt0V
         i8Gr9f5td491yWx+wluO2zjXkp4GODVxB4zAm8ijB8H2bTdpQm9J35QCJZ5cLot0TYC4
         iK9K1bQMWAHSXWW2YBLRuqqFlETIn57of7eOiR6y/0pIB+C6uWf+M1/kcvSJaBJyoucI
         TTW/WNAU/JuEKYA6FngEg2V+UhtnquDyzNGmjpZD/BZ0OFsffTpokdbFf5Um8jMHe6lm
         cesqbGYEUxnpaiMrzLNod+UveYtO6Wx94LBs7vtTG/lRnP6BLyCMyY5sCTyT/VR05/ZM
         Kopg==
X-Gm-Message-State: AOJu0YzUKqY/Nz9wQ7JBTm8Oct+VTxMx9bwPk6fcVq+N8HmKqmNHISwn
	bdHoyPJVMgARnxk6Ztc6MCnQUG8fK6PzJxsL+hM7R3u5r80hid3xD4/C
X-Gm-Gg: AeBDiet3jNJulsiieepZCTT2r1nTgUqySIt0nFWyuPWqDJPh7g2hDE6CjZPMzF4k2ye
	Q2btpmYZPWfoSB0j6PLCG+Z6RU6n6z2Sqr/y4O5QgXRj5gkEDJR7/iB3HnZARC87DGBT0BT9z7x
	WzoUtkiy0kH5w0mMlEfv0lNzKX+iGNy/7HQHOtlJB9Tgk9Q7RVMP7U/QB8khHr7rAQFfq8SiXvf
	+g3qny/Mcx6H3H8sfcbTbQOdjPLHqMBKP8ITj1AKQUOjWTDsdX6aZR8ZmA2L517TfWAe8y7c2js
	aX0P7UqVOchp0QjKoFNwB7RD4bpvR4A83+nbXVgG4D3LbDD5FIVmTpl6QK96bGtcR56Pgc4Wi9B
	h9MH9dLEquGwxtk756o4ydpirIcsAP5rkTvv46r/p/00fxv5yOET4HBLKV8vDAhJi5frvh8V/CK
	cOfz88xFAm6PCeKfX78ySpF1e/OeOeF28PVbjQGeVXnnn2NgotkJGqI/vO8qB0ZuWpzt+D2X3ne
	10trt30gYa0RwrI0i7Q
X-Received: by 2002:a05:7300:fb97:b0:2d8:71c2:255d with SMTP id 5a478bee46e88-2e47873aad0mr11689328eec.14.1776897999473;
        Wed, 22 Apr 2026 15:46:39 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1053:1d3b:d6cb:4350? ([2620:10d:c090:500::2:bea8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d9b056fsm33363023eec.29.2026.04.22.15.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 15:46:38 -0700 (PDT)
Message-ID: <9e477e253c202b10ed611213e4fc9a7017bfc51d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] bpf: Preserve reg->id of pointer
 objects after null-check
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, ameryhung@gmail.com, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com, ast@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Date: Wed, 22 Apr 2026 15:46:36 -0700
In-Reply-To: <d5679e6f2b458bb8771f83e6985247befd68fbab894a0d2a09797f0ec3a90efe@mail.kernel.org>
References: <20260421221016.2967924-4-ameryhung@gmail.com>
	 <d5679e6f2b458bb8771f83e6985247befd68fbab894a0d2a09797f0ec3a90efe@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-280558-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E37844B525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-21 at 22:52 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 93003a2a96b0..0313b7d5f6c9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15886,15 +15886,10 @@ static void mark_ptr_or_null_reg(struct bpf_f=
unc_state *state,
> >=20
> > =C2=A0		mark_ptr_not_null_reg(reg);
> >=20
> > -		if (!reg_may_point_to_spin_lock(reg)) {
> > -			/* For not-NULL ptr, reg->ref_obj_id will be reset
> > -			 * in release_reference().
> > -			 *
> > -			 * reg->id is still used by spin_lock ptr. Other
> > -			 * than spin_lock ptr type, reg->id can be reset.
> > -			 */
> > -			reg->id =3D 0;
> > -		}
> > +		/*
> > +		 * reg->id is preserved for object relationship tracking
> > +		 * and spin_lock lock state tracking
> > +		 */
>=20
> How does preserving reg->id interact with reg_is_init_pkt_pointer()?
>=20
> In v2 review, Alexei Starovoitov raised this concern: "That pointer has
> to have id =3D=3D 0". Eduard Zingerman responded that dropping the id =3D=
=3D 0
> check should be fine, but this change was not made in v3.
>=20
> The function reg_is_init_pkt_pointer() still checks reg->id =3D=3D 0:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0return reg->type =3D=3D which &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg->id=
 =3D=3D 0 &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg->of=
f =3D=3D 0 &&
>=20
> With this patch, if a PTR_TO_PACKET register goes through null-checking
> in mark_ptr_or_null_reg(), it will now preserve its reg->id instead of
> resetting it to 0. Would this cause reg_is_init_pkt_pointer() to
> incorrectly return false for init packet pointers?
>=20
> Reference: https://lore.kernel.org/bpf/CAADnVQLCKi_QL1FeybW+6MH6FAOAoRJyW=
06UvtX3my3yNSH5eQ@mail.gmail.com/
>=20
> > =C2=A0	}
> > =C2=A0}

Bot concern is bogus here, reg_is_init_pkt_pointer() is called only
for PTR_TO_PACKET. mark_ptr_or_null_reg() checks for
type_may_be_null(reg->type), meaning that for it to trigger one would
need a register of type PTR_TO_PACKET | PTR_MAYBE_NULL.
It appears there is no way to construct such type at the moment.

