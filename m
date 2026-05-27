Return-Path: <netdev+bounces-292206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLHjCemyFmokogcAu9opvQ
	(envelope-from <netdev+bounces-292206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:01:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D69655E1768
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FA283023E04
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E693D6CC8;
	Wed, 27 May 2026 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch7XQVCA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3063C09FA
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872464; cv=none; b=bQ6JrpuROaqLsN8MqrrGCf+E5+T83nCJK9EN9hG4dsJQdv7AWmELxaxc9FpeV5rNLKdlfIG/IbgHRttIFwzRSepBmeMZR8quiyGBAUCh59iIM6Qg2c/pqUTx5FNgeV8j0j7Im6xuDr4qJfbR3gVgkNJ/lm/Inu5rchsH3mcZcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872464; c=relaxed/simple;
	bh=mgAKEUPbcZRsA85Cvv0Ctd+pDi4+iMPulVw2NC1Vn80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMAC+G24jXV21YvGC2pTVWbRTwsNOt/vfQUzkDqqjqCMv+ni+D/ruFhKrtnxor7zzfw56JSmwHZYkeVnzaXJuEVdSC2YWCJQJsiJf5sGFYkrSyAC4+nJy6J4rhl8VldsfHFwPO64h7y+sr/W4u00qHxjQtpXl2ci9s2jfNQqj6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch7XQVCA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd6460b0d11so2001776066b.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779872459; x=1780477259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbDgJoPZFBxMmCL9I1KZ0h3kDSbPdYcF9BRWc56VVPc=;
        b=ch7XQVCAHYKrXamaaLOS/Taz0CtTm0tohStMqUAJHAtZol0bEsOQyEpt8WApFANPvu
         CC0jeCQvvR6SuvcHS8FhmCEpCnmdl/tsMTko13tDYNWkDXY2jVrEvtjGr09Neb0L159V
         kks5xH9FG6pIop5Nu7UHix27Jfk9RAT9S36g/jAoNISj+fH2t4CZvFvplpubQSNaOI3+
         NI1lCmOpq2c/Q2+YbfIx+LIYWWJ1Jtk9IP20wbK/xEowCKfu+ZcCwRDHQRbne4/jTP37
         3rlUi4vudTMwlp6qE+RxJZCWiclDglluzRtebFsc+K1YNHFRm8Tbc4dqSbcMrbMKNeH3
         uwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779872459; x=1780477259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbDgJoPZFBxMmCL9I1KZ0h3kDSbPdYcF9BRWc56VVPc=;
        b=dT0hdzuLg80C1cisCDg2J2rnLaPwbPvq7TZMW8+Tc4YfF71/obbBs3Bx0d5kotolDz
         w+vFlrpoC2HE1mnizwKla43aTg7aBCXdu2DnTwGxXs1eLIQ4edimAoAg07K9XFqCKyv/
         e26eD6nHSuXM6BsP7trdeWdkaWFClyyceg6S3q0BcqPiEPLAYqtZrFdWFDOQ5S2A30DV
         Di/yhUQiE3pooF7PYy5bD5eqJd+ovasbEKCNlNgHK/KGCCHHNCkPncL2rXavrHsZm/z7
         568raZ2Rq1aJ22mmYW16KjrwFCtwXr6pXN/eILXYkeMGoPfka64TgF0/VmQh7ZtgrTfG
         ZhAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8TvA2xmGmufXJ3Wg/6uPdT9rLkRqxKPy7fA7dcuqxh/aiVkinOj741jGLzJpbF5jdBjgaTQU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Z+V+E+gjyOsxRY6wPd3TyIq8d2s6s+lhFB31G0kfC41Ohmx3
	/VsIo9Tazj56r8ur/6UzDHMJAnaCrgMDNcFxKhvlBCgi9jUh1QY9Xtw8
X-Gm-Gg: Acq92OEY70qCbOU0CVUvRqce1nzslNb8/GJn/qhtX4DjTx8fgiQRqFGw3qyle4/JVBJ
	6jICWMtt12mKHFaX5EY8T+4RnDt5eTx/EuOQal/1R3XamG9YxHSvxab+K2aPruMXn3TTmqWSIqp
	deCt21Q+GnfOhm8jqOWrAIbgwy9KNv5PXsGrgrCNeq8OAz4oKuKWCGAjAJvxxgv8fkzu8S/sjlg
	6L8ZYdAAWhIcVT1ZraTlTJfZl6b8z5u2MG1BRWmWKKdK806wiaF1RdRL/Lap9TYNnd6JGj2Hd8S
	o8UMPagnQOcngCuF7iH8SeR/fMgm6ZFHQRjgJH3Fp2OvH/S1YKmI/VtwwqdVJPee8ARFjpjHSpa
	+6dDmEhP2nv+IRaAlYVAv1AbsU7tjXV/taNVA1cBH69Cw7EM4qyl2+hUK9yCl5Em6+CUZWrViXR
	eMrEv/E53yEgqRBfR6yPSsyUPWre3I3amniNMAu+QMmhbMgGa5ShDGBv/rvMSCXQFa1g5AnN+om
	eI=
X-Received: by 2002:a17:906:cc14:b0:bdc:9d31:3f91 with SMTP id a640c23a62f3a-bdd22f2831amr1147141066b.15.1779872457422;
        Wed, 27 May 2026 02:00:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb558dd0sm4402912f8f.16.2026.05.27.02.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:00:56 -0700 (PDT)
Date: Wed, 27 May 2026 10:00:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, victor@mojatatu.com,
 yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com,
 rollkingzzc@gmail.com, dcaratti@redhat.com, security@kernel.org,
 linux-kernel@vger.kernel.org, Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Subject: Re: [PATCH net v2 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
Message-ID: <20260527100055.1661c5c9@pumpkin>
In-Reply-To: <87wlwq2cxf.fsf@toke.dk>
References: <20260526155913.1060694-1-jhs@mojatatu.com>
	<87wlwq2cxf.fsf@toke.dk>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292206-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mojatatu.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com,oss.qualcomm.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[jhs.mojatatu.com:query timed out,yimingqian591.gmail.com:query timed out,keenanat2000.gmail.com:query timed out,victor.mojatatu.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,mojatatu.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D69655E1768
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 21:22:52 +0200
Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:

> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>=20
> > From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> >
> > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > once before the key loop using tcfp_off_max_hint, but the hint does
> > not account for the runtime header offset added by typed keys. This
> > can leave part of the write region un-COW'd.
> >
> > Fix by moving skb_ensure_writable() inside the per-key loop where
> > the actual write offset is known, and add overflow checking on the
> > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > at ingress), use skb_cow() to COW the headroom instead. Guard
> > offset_valid() against INT_MIN, where negation is undefined.
> >
> > Additionally, linearize skbs with shared frags upfront to prevent
> > silent data corruption when pedit operates on zero-copy pages
> > (e.g. from sendfile).
> >
> > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is wr=
itable")
> > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > Reported-by: Han Guidong <2045gemini@gmail.com>
> > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com> =20
>=20
> Re-ran the tests, and everything looks good, so:
>=20
> Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>=20
> Also looked at the code, and I have a few nits below, but I'm really
> nitpicking here, so whether you end up fixing those or not:
>=20
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>=20
>=20
> [...]
>=20
> > @@ -323,7 +324,7 @@ static bool offset_valid(struct sk_buff *skb, int o=
ffset)
> >  	if (offset > 0 && offset > skb->len)
> >  		return false;
> > =20
> > -	if  (offset < 0 && -offset > skb_headroom(skb))
> > +	if (offset < 0 && offset < -(int)skb_headroom(skb))
> >  		return false; =20
>=20
> This change makes it really obvious that this is really just:
>=20
> 	if (offset < -(int)skb_headroom(skb))
>   		return false;
>=20
> so, well, that would be clearer, IMO.
>=20
> But then I guess the same could be said of the positive case, so:
>=20
> static bool offset_valid(struct sk_buff *skb, int offset)
> {
> 	if (offset > skb->len || offset < -(int)skb_headroom(skb))
> 		return false;
>=20
> 	return true;
> }

There are all sorts of integer conversions going on.
IIRC Both skb->len and skb_headroom() are 32bit unsigned.
skb_headroom() is relatively small, skb->len can be over 64k but nowhere
near MAX_INT.
offset is signed 32bit and the code is allowing for it being -MAX_INT
(but I'm not at all sure whether that can happen without overflow being lik=
ely).

So I think the single test:
	if (offset + skb_headroom(skb) >=3D skb->len + skb_headroom(skb))
		return false;
is correct.
If offset is 'too negative' the LHS will be 'very large postitive' and
the test fails.

-- David

>=20
> > @@ -393,18 +394,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> >  	struct tcf_pedit_key_ex *tkey_ex;
> >  	struct tcf_pedit_parms *parms;
> >  	struct tc_pedit_key *tkey;
> > -	u32 max_offset;
> >  	int i;
> > =20
> >  	parms =3D rcu_dereference_bh(p->parms);
> > =20
> > -	max_offset =3D (skb_transport_header_was_set(skb) ?
> > -		      skb_transport_offset(skb) :
> > -		      skb_network_offset(skb)) +
> > -		     parms->tcfp_off_max_hint;
> > -	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> > -		goto done;
> > -
> >  	tcf_lastuse_update(&p->tcf_tm);
> >  	tcf_action_update_bstats(&p->common, skb);
> > =20
> > @@ -412,9 +405,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff=
 *skb,
> >  	tkey_ex =3D parms->tcfp_keys_ex;
> > =20
> >  	for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> > +		int write_offset, write_len;
> >  		int offset =3D tkey->off;
> >  		int hoffset =3D 0;
> > -		u32 *ptr, hdata;
> > +		u32 *ptr;
> >  		u32 val;
> >  		int rc;
> > =20
> > @@ -451,15 +445,38 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> >  			}
> >  		}
> > =20
> > -		if (!offset_valid(skb, hoffset + offset)) {
> > -			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", ho=
ffset + offset);
> > +		if (unlikely(check_add_overflow(hoffset, offset, =20
>=20
> It's a bit weird that this has the unlikely(), but the offset_valid()
> check doesn't?
>=20
> > +						&write_offset))) {
> > +			pr_info_ratelimited("tc action pedit offset overflow\n");
> >  			goto bad;
> >  		}
> > =20
> > -		ptr =3D skb_header_pointer(skb, hoffset + offset,
> > -					 sizeof(hdata), &hdata);
> > -		if (!ptr)
> > +		if (!offset_valid(skb, write_offset)) {
> > +			pr_info_ratelimited("tc action pedit offset %d out of bounds\n",
> > +					    write_offset);
> >  			goto bad;
> > +		}
> > +
> > +		if (write_offset < 0) {
> > +			if (skb_cow(skb, -write_offset))
> > +				goto bad;
> > +			if (write_offset + (int)sizeof(*ptr) > 0) {
> > +				if (skb_ensure_writable(skb,
> > +							min(skb->len,
> > +							    write_offset + sizeof(*ptr)))) =20
>=20
> Combining these with && instead of the double indentation would be more
> readable IMO (shorter lines, aligning the 'goto bad' labels).
>=20
> > +					goto bad;
> > +			}
> > +		} else {
> > +			if (unlikely(check_add_overflow(write_offset,
> > +							(int)sizeof(*ptr),
> > +							&write_len))) =20
>=20
> Same comment wrt unlikely()
>=20


