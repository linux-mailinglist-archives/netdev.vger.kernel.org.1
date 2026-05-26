Return-Path: <netdev+bounces-291907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPfbMBnzFWqzfwcAu9opvQ
	(envelope-from <netdev+bounces-291907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:23:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6947E5DBF22
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A42BB30422C4
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20743B47E9;
	Tue, 26 May 2026 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6uRoVBi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="frtlP4vD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302673C060E
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823380; cv=none; b=D7lkQJYBrvhkkz3fm2dD+AcI3WsOyzQSi8zzAoqpxsYAwkxw9AyTOHfyyg7a6g1oRDcNOkpAFmPyOfDCuevdgv4DZ3oKlHDvX/HzcKVLmVhD2Mw+Pl6bASzFTfCj9wSz0OpVFBJIDbm+vVAvjufXhTcM/wwI9GD/eJZRQM/RCMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823380; c=relaxed/simple;
	bh=wTpkWEr8ySxIHAoGJEjiWbwMqfOK/fDlZHkwZBQSLqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e7hMqjJ1iyPOFNE6jmPuX18pkBfJVBYVH0IPXPy/Pgdh8xdFSnWMDr6Vs7QhM+0x4jEmomwJb6INTpfxtXJcpku3rgy/arr+p9VUDiZcehJS9GzNNyS/Uj7FtECnMXd4/dEwGWPLBqVu0eiTxnsk1QX5m168e+X8O7lqibngp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6uRoVBi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=frtlP4vD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779823376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBfdKmYqGY8+uEf1OEPpHI37x7FRR1lLCaceUQbd8fY=;
	b=V6uRoVBigtUeNkFGBzCE4++oC4mG4kZrG7/+OHxS7YhaWUAwyOKAlaDuenH6CXf83Ub+kS
	fhjBUaQ7zmijuOi26ir7xJhPLPCKxvUAMKIMzAeACUgD6Vb+HAW+knvuGBGYr21PWETWiF
	Xq6Yx2otFJbTg3wVwF4vNmP59rDu5Ag=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-YIkpM5LQOY2sUlPT9Haetg-1; Tue, 26 May 2026 15:22:55 -0400
X-MC-Unique: YIkpM5LQOY2sUlPT9Haetg-1
X-Mimecast-MFC-AGG-ID: YIkpM5LQOY2sUlPT9Haetg_1779823374
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44b186b715aso6793794f8f.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 12:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779823374; x=1780428174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBfdKmYqGY8+uEf1OEPpHI37x7FRR1lLCaceUQbd8fY=;
        b=frtlP4vD0VzpKnf0Cl6TMIHlpqsNoE4jrhTJsHO3tc7PnIGdGCTbE1qdqh/Dq7ZEqd
         zHVKUVF5l1X43RVU0MALF7Ht5a9/iuKtaUT/EufO79DgBRAGAG0cggyvbUkV2uaCFlnj
         naeAZAhurl1x8D5BZDvlJaji86yQ8248eL4GI8O2Yi/5fOMDRGZPAVQh3qRW5rZcDJD8
         l96hi/C//DGNpWcQ9RwgKY7uVvGECUKrFa78zZ3XbIOar4w/3k7EastfMUleh5HdMyNJ
         QpP41uruMuD3W30ArNaqpxHTaxgUgvNqR1D+wu/ZcAF3ciCAyZYJpTKYsexm19J6Dm3Z
         0b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779823374; x=1780428174;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rBfdKmYqGY8+uEf1OEPpHI37x7FRR1lLCaceUQbd8fY=;
        b=goI+H0cot4k/G+C+J8v3Bgl/kiSlD/QZR0ERLQ0rVez720A9rbK21+e7IAOb8msNAS
         N9inHROozYxMh3euX0iDMnmVOGFuPYSD+rCxvFuSv8xGtv328/PmH2fhdi0+2iTnP92z
         P9Tg+tVtAErbmacvWSrciT+2jEW+SP/DD2ZOTr+L2VnfmiDU/oa4yhFJ975XtL7Vm3kM
         PnqFnvSo2xvgni4W712XLkwlnAR2ZTk4aI6tHGT0s55zof10upbC4mDSUK+T1j7XNDt/
         CXfs4pi4zg2T6g7amJvUSgWH7XiJpsS2o+z17qHtQKJUO2fkAwZGb7GstnDbAaDz0d47
         3SYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+27Oeb30pdEMb5kTU/S+6DnI4pYr9gsTZ9uMLYinXJ4KrNU2r2Zl0UNnlr70FDhe4nfhXtYT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLh/nhLAVlNhlFn6vQYZUgyGlnG2zsl5VmkthIpSGIT4PjHlm7
	RT2U5RrDCahR36zCXevgjd9E55bpeq5apX69PX7aywwx0GU33urauj13wHi3wG/SOUo4K/wd4ad
	w5c94eYj0qiDMVfT1M0APg3+4sXO/AfmCytYLPmSF02w1aNVC2Tga7rz50w==
X-Gm-Gg: Acq92OFekGEdt5NCIZXjz+t8DAJURGIqteYIrNmeKC2dGbVeTuKfnT++Vg2IblnXnh7
	Hgcj8959qgBGfzuDEm6U2lu9ZPeuemvRgIUIAX4EbHD5K2GxzdaFY28bHWSjFt3XJ7aWMtx6nRt
	TtOTtJZ995setChZnuW+C2BoFsKqRcBEoCQumhipyZycJXBWShxlwBLHDHKaPeh39K67cNZ4v+b
	KTnE1qV9XJN7NmGx/igqwUhmAsVv8w3LpyqRViXKjsaNUmw0wGZf7rlZLAtT/o9BXldYwniPVLX
	iZ1qKteP7c/o28SFS7RC5GKdnObKlQ4AIxSO2gpAqENtHdVDw3UxvEj3gWhuprbvQfgolQhQGyH
	lP0afyI1hENR5oyqVQ6XVz8AWKNvcvHgbLRELuxU98KugeDEK
X-Received: by 2002:a05:6000:184d:b0:45e:a086:82bc with SMTP id ffacd0b85a97d-45eb39e3f86mr32357222f8f.28.1779823373990;
        Tue, 26 May 2026 12:22:53 -0700 (PDT)
X-Received: by 2002:a05:6000:184d:b0:45e:a086:82bc with SMTP id ffacd0b85a97d-45eb39e3f86mr32357192f8f.28.1779823373561;
        Tue, 26 May 2026 12:22:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb548dfasm389790f8f.4.2026.05.26.12.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 12:22:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0F7E67BA13A; Tue, 26 May 2026 21:22:52 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, david.laight.linux@gmail.com,
 yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com,
 rollkingzzc@gmail.com, dcaratti@redhat.com, security@kernel.org,
 linux-kernel@vger.kernel.org, Rajat Gupta <rajat.gupta@oss.qualcomm.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH net v2 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
In-Reply-To: <20260526155913.1060694-1-jhs@mojatatu.com>
References: <20260526155913.1060694-1-jhs@mojatatu.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 26 May 2026 21:22:52 +0200
Message-ID: <87wlwq2cxf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291907-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,vger.kernel.org,oss.qualcomm.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6947E5DBF22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
>
> tcf_pedit_act() computes the COW range for skb_ensure_writable()
> once before the key loop using tcfp_off_max_hint, but the hint does
> not account for the runtime header offset added by typed keys. This
> can leave part of the write region un-COW'd.
>
> Fix by moving skb_ensure_writable() inside the per-key loop where
> the actual write offset is known, and add overflow checking on the
> offset arithmetic. For negative offsets (e.g. Ethernet header edits
> at ingress), use skb_cow() to COW the headroom instead. Guard
> offset_valid() against INT_MIN, where negation is undefined.
>
> Additionally, linearize skbs with shared frags upfront to prevent
> silent data corruption when pedit operates on zero-copy pages
> (e.g. from sendfile).
>
> Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writ=
able")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Reported-by: Han Guidong <2045gemini@gmail.com>
> Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

Re-ran the tests, and everything looks good, so:

Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Also looked at the code, and I have a few nits below, but I'm really
nitpicking here, so whether you end up fixing those or not:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


[...]

> @@ -323,7 +324,7 @@ static bool offset_valid(struct sk_buff *skb, int off=
set)
>  	if (offset > 0 && offset > skb->len)
>  		return false;
>=20=20
> -	if  (offset < 0 && -offset > skb_headroom(skb))
> +	if (offset < 0 && offset < -(int)skb_headroom(skb))
>  		return false;

This change makes it really obvious that this is really just:

	if (offset < -(int)skb_headroom(skb))
  		return false;

so, well, that would be clearer, IMO.

But then I guess the same could be said of the positive case, so:

static bool offset_valid(struct sk_buff *skb, int offset)
{
	if (offset > skb->len || offset < -(int)skb_headroom(skb))
		return false;

	return true;
}

> @@ -393,18 +394,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
>  	struct tcf_pedit_key_ex *tkey_ex;
>  	struct tcf_pedit_parms *parms;
>  	struct tc_pedit_key *tkey;
> -	u32 max_offset;
>  	int i;
>=20=20
>  	parms =3D rcu_dereference_bh(p->parms);
>=20=20
> -	max_offset =3D (skb_transport_header_was_set(skb) ?
> -		      skb_transport_offset(skb) :
> -		      skb_network_offset(skb)) +
> -		     parms->tcfp_off_max_hint;
> -	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> -		goto done;
> -
>  	tcf_lastuse_update(&p->tcf_tm);
>  	tcf_action_update_bstats(&p->common, skb);
>=20=20
> @@ -412,9 +405,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *=
skb,
>  	tkey_ex =3D parms->tcfp_keys_ex;
>=20=20
>  	for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> +		int write_offset, write_len;
>  		int offset =3D tkey->off;
>  		int hoffset =3D 0;
> -		u32 *ptr, hdata;
> +		u32 *ptr;
>  		u32 val;
>  		int rc;
>=20=20
> @@ -451,15 +445,38 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
>  			}
>  		}
>=20=20
> -		if (!offset_valid(skb, hoffset + offset)) {
> -			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoff=
set + offset);
> +		if (unlikely(check_add_overflow(hoffset, offset,

It's a bit weird that this has the unlikely(), but the offset_valid()
check doesn't?

> +						&write_offset))) {
> +			pr_info_ratelimited("tc action pedit offset overflow\n");
>  			goto bad;
>  		}
>=20=20
> -		ptr =3D skb_header_pointer(skb, hoffset + offset,
> -					 sizeof(hdata), &hdata);
> -		if (!ptr)
> +		if (!offset_valid(skb, write_offset)) {
> +			pr_info_ratelimited("tc action pedit offset %d out of bounds\n",
> +					    write_offset);
>  			goto bad;
> +		}
> +
> +		if (write_offset < 0) {
> +			if (skb_cow(skb, -write_offset))
> +				goto bad;
> +			if (write_offset + (int)sizeof(*ptr) > 0) {
> +				if (skb_ensure_writable(skb,
> +							min(skb->len,
> +							    write_offset + sizeof(*ptr))))

Combining these with && instead of the double indentation would be more
readable IMO (shorter lines, aligning the 'goto bad' labels).

> +					goto bad;
> +			}
> +		} else {
> +			if (unlikely(check_add_overflow(write_offset,
> +							(int)sizeof(*ptr),
> +							&write_len)))

Same comment wrt unlikely()


