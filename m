Return-Path: <netdev+bounces-292352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLiHAtYJF2pB2AcAu9opvQ
	(envelope-from <netdev+bounces-292352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:12:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9911C5E6A06
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F354130098AC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1A93BE635;
	Wed, 27 May 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlBQyTs8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pZA8u4hS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57E2426D02
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894738; cv=none; b=brldaYneqjWN6ERqr5FQxrUmm1L1nJAwpTkNrXTVMstZa3zEJ2xrUvFNJF5FQ95BnW0e/MOQAmLK8giWZegC1ryqKoyju5h/6CgTeLvjdTWYUdrrvriRT+c6Na5c1wmReEL9EXeMAnzLvhTx0nvvBFE5uI2lbkIvRs6Ip5qOJSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894738; c=relaxed/simple;
	bh=1bvHL7GQh9cB/k/LpIQVLg5aGGr3J73Y2enn7B3pijs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q9LbnkvIBcuEz0DgjEC3h5d5f5yuNMjGRdKr2N4XsR0HQRCoVASiRvQUHx0o0gYRN0vgl7Np+3kGyaA8zJmXrysbGBDEEmIwq7sTSJijCtau0Kmp6EnBvgrBlMwXjprWTn2y9Nt+jNdO6QUeXsjthpnKDVC7pddYImyYKw4MNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlBQyTs8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pZA8u4hS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779894733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6jWaMmczxbXaHTehAkKFrZ91cS+gU5kq6t9M6Xe7N0=;
	b=WlBQyTs8FuuJIgUz0rvEPJyzC08sAazsGZYLBv6LPCKTCpajDbGkMcqQDwTRduPmVTpDva
	De0XhxEPbgsN4PWsGDJhQg7Or5LFcNzjLxhqenUyJOKBNq+PAeG/Ml3BrpjMbgknX97d1B
	BlmKWoRuBn2MKbsBgf0+3o8977GM4c8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-G8GFaJp2NXClzbQnEL2YLQ-1; Wed, 27 May 2026 11:12:10 -0400
X-MC-Unique: G8GFaJp2NXClzbQnEL2YLQ-1
X-Mimecast-MFC-AGG-ID: G8GFaJp2NXClzbQnEL2YLQ_1779894729
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45e81291d62so9896082f8f.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779894729; x=1780499529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6jWaMmczxbXaHTehAkKFrZ91cS+gU5kq6t9M6Xe7N0=;
        b=pZA8u4hSXuwHw32NUP5/wDu2TTaGHEoina1xwoaIRlvBHYpqkc128/dAIHE4GmfDje
         4BeIzmez575HCXym7xyDFxgfkuP6qoVowhCS8W7wdWGJmfvoSxuk3UU7NE1mtKkNtxZT
         EBHyXobXPl1HNo734BzmXyndIvILMhOqsimJH6gk/An/2fnqGWYUzIsPp4+96heAPElt
         v/gtL9ppk7Q1fbL3gb/3yI22JggmGpJ3Vc7jcn1dsk/OGYZoZY8HGgCJWUgFOKQgDjtH
         /utqm75uTz/kmFRi6oI4PgCEXam4hUNEq8pcovY/f0WVXAtxd60+OztkAMfe4c1JNr0x
         AnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894729; x=1780499529;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y6jWaMmczxbXaHTehAkKFrZ91cS+gU5kq6t9M6Xe7N0=;
        b=ZkQuzwIanSFLszVMAFhp0zVBV7IaLgw8IOBURHXTjmja36UMaLAdKseM2NBqYiUn2e
         IkSetOfC4AJerqLEzK7+2ssaco+FjmSixqglgVxpMSSIMiyITFf6MTqWUgYted6ntrD4
         Nikex/03zMEBoml7FZokJRgLpX0Dt2mUr0+E1V2n49v7UzeSPVP/+UrNSJuQwGVp50VG
         EBIZ8u7mXgl8YxDXobW387u6sgUrK1JcTBgS9krmNDzRY5s+iG7ETwgmWlcwGsRb0f12
         HqMCzs6Tb2J04Tm8LdWaTYZ6aLdT2D1Hvv+3yEfLc7CwveFWpequf2F/xij/3Y9BNLNX
         Zy3Q==
X-Gm-Message-State: AOJu0YwhQ0FG2Apw9O1Jxm1o+IUtpXRSvgULiPlWnf7NZjRC48kVND9B
	Zasg6G5bfFT2/ZdqR3oOGALe6/TOO2pToTeonx2It7muhFDgTvvPIZnAyKd6rkBpV/vZeMsBQdc
	EJ45QDeoZjFm7aEqVRPeK4NRsmUe7V1mAniLdx3HrQoYDmXYkgsVbkh65sA==
X-Gm-Gg: Acq92OFWRDN6j8W9TUJ7QHrgj6l7o3qPWXVDz3D9zhRJrE+D3ugXaWXkDpGqzRUI1Nb
	1E8IOq01k1QX21942whwKhBzukOIP/WNIMPKDZOaTncPFqk5dyKxS5wCBVagvKqByZqh57LFkcf
	YePEEn69TDpRt1DZGjdBjXgh98S/PncsI+4cOKZ2Z+42mlIBjAOjQ6xtpuhXaRbyQMh/7I0908H
	LbGIhhN8RuItGDCrxpr5gczeoo0FHaLVq7u3Ow+RGEY7Lqr+Z29KKk7fKYIRvD2dp/IL4YiTiH9
	iPlRGs+YGvQVFmU0pdlLFXUx627vG52NPtXBFoFnz1yY+lOiMvs2Vg/u9N/aUKl2rz5gFD2oIS8
	YNvUf80o+rZuCrmUiBrR0ns5gwTJ44W77vRH1aQv6ehIqafss
X-Received: by 2002:a05:6000:4707:b0:45e:75c5:1a6a with SMTP id ffacd0b85a97d-45eb38bcb3fmr38239007f8f.33.1779894728634;
        Wed, 27 May 2026 08:12:08 -0700 (PDT)
X-Received: by 2002:a05:6000:4707:b0:45e:75c5:1a6a with SMTP id ffacd0b85a97d-45eb38bcb3fmr38238930f8f.33.1779894728163;
        Wed, 27 May 2026 08:12:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb558f52sm7090556f8f.14.2026.05.27.08.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:12:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 79C877BA45F; Wed, 27 May 2026 17:12:06 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, david.laight.linux@gmail.com,
 yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com,
 rollkingzzc@gmail.com, dcaratti@redhat.com, security@kernel.org,
 linux-kernel@vger.kernel.org, Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Subject: Re: [PATCH net v2 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
In-Reply-To: <CAM0EoMm_FcS0xSNmCjdXaRMfZh12jU71xM92Z50eVE8uk7tKFQ@mail.gmail.com>
References: <20260526155913.1060694-1-jhs@mojatatu.com>
 <87wlwq2cxf.fsf@toke.dk>
 <CAM0EoMm_FcS0xSNmCjdXaRMfZh12jU71xM92Z50eVE8uk7tKFQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 27 May 2026 17:12:06 +0200
Message-ID: <87o6i03n09.fsf@toke.dk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292352-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email,mojatatu.com:email,toke.dk:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9911C5E6A06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jamal Hadi Salim <jhs@mojatatu.com> writes:

>  &&
>
> On Tue, May 26, 2026 at 3:22=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>>
>> > From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
>> >
>> > tcf_pedit_act() computes the COW range for skb_ensure_writable()
>> > once before the key loop using tcfp_off_max_hint, but the hint does
>> > not account for the runtime header offset added by typed keys. This
>> > can leave part of the write region un-COW'd.
>> >
>> > Fix by moving skb_ensure_writable() inside the per-key loop where
>> > the actual write offset is known, and add overflow checking on the
>> > offset arithmetic. For negative offsets (e.g. Ethernet header edits
>> > at ingress), use skb_cow() to COW the headroom instead. Guard
>> > offset_valid() against INT_MIN, where negation is undefined.
>> >
>> > Additionally, linearize skbs with shared frags upfront to prevent
>> > silent data corruption when pedit operates on zero-copy pages
>> > (e.g. from sendfile).
>> >
>> > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is w=
ritable")
>> > Reported-by: Yiming Qian <yimingqian591@gmail.com>
>> > Reported-by: Keenan Dong <keenanat2000@gmail.com>
>> > Reported-by: Han Guidong <2045gemini@gmail.com>
>> > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
>> > Tested-by: Victor Nogueira <victor@mojatatu.com>
>> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
>>
>> Re-ran the tests, and everything looks good, so:
>>
>> Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> Also looked at the code, and I have a few nits below, but I'm really
>> nitpicking here, so whether you end up fixing those or not:
>>
>> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>>
>> [...]
>>
>> > @@ -323,7 +324,7 @@ static bool offset_valid(struct sk_buff *skb, int =
offset)
>> >       if (offset > 0 && offset > skb->len)
>> >               return false;
>> >
>> > -     if  (offset < 0 && -offset > skb_headroom(skb))
>> > +     if (offset < 0 && offset < -(int)skb_headroom(skb))
>> >               return false;
>>
>> This change makes it really obvious that this is really just:
>>
>>         if (offset < -(int)skb_headroom(skb))
>>                 return false;
>>
>> so, well, that would be clearer, IMO.
>>
>> But then I guess the same could be said of the positive case, so:
>>
>> static bool offset_valid(struct sk_buff *skb, int offset)
>> {
>>         if (offset > skb->len || offset < -(int)skb_headroom(skb))
>>                 return false;
>>
>>         return true;
>> }
>>
>
> Yes, that improves readability. If i understood the discussion between
> you and David L. something like this one liner would be reasonable?
>
> if (offset > (int)skb->len || offset < -(int)skb_headroom(skb))

Yes, I believe that one is correct wrt the integer conversion rules.

>> > @@ -393,18 +394,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_bu=
ff *skb,
>> >       struct tcf_pedit_key_ex *tkey_ex;
>> >       struct tcf_pedit_parms *parms;
>> >       struct tc_pedit_key *tkey;
>> > -     u32 max_offset;
>> >       int i;
>> >
>> >       parms =3D rcu_dereference_bh(p->parms);
>> >
>> > -     max_offset =3D (skb_transport_header_was_set(skb) ?
>> > -                   skb_transport_offset(skb) :
>> > -                   skb_network_offset(skb)) +
>> > -                  parms->tcfp_off_max_hint;
>> > -     if (skb_ensure_writable(skb, min(skb->len, max_offset)))
>> > -             goto done;
>> > -
>> >       tcf_lastuse_update(&p->tcf_tm);
>> >       tcf_action_update_bstats(&p->common, skb);
>> >
>> > @@ -412,9 +405,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
>> >       tkey_ex =3D parms->tcfp_keys_ex;
>> >
>> >       for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
>> > +             int write_offset, write_len;
>> >               int offset =3D tkey->off;
>> >               int hoffset =3D 0;
>> > -             u32 *ptr, hdata;
>> > +             u32 *ptr;
>> >               u32 val;
>> >               int rc;
>> >
>> > @@ -451,15 +445,38 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_bu=
ff *skb,
>> >                       }
>> >               }
>> >
>> > -             if (!offset_valid(skb, hoffset + offset)) {
>> > -                     pr_info_ratelimited("tc action pedit offset %d o=
ut of bounds\n", hoffset + offset);
>> > +             if (unlikely(check_add_overflow(hoffset, offset,
>>
>> It's a bit weird that this has the unlikely(), but the offset_valid()
>> check doesn't?
>>
>
> I focused on the bigger solution and worried more about timeliness to
> get this patch in - but it seems the distros had already picked up the
> first posted patch, so hakuna matata (Still, I should have caught
> these unlikelies ;->). Yes on the second one you pointed out.
> Will remove them.

Cool.

>> > +                                             &write_offset))) {
>> > +                     pr_info_ratelimited("tc action pedit offset over=
flow\n");
>> >                       goto bad;
>> >               }
>> >
>> > -             ptr =3D skb_header_pointer(skb, hoffset + offset,
>> > -                                      sizeof(hdata), &hdata);
>> > -             if (!ptr)
>> > +             if (!offset_valid(skb, write_offset)) {
>> > +                     pr_info_ratelimited("tc action pedit offset %d o=
ut of bounds\n",
>> > +                                         write_offset);
>> >                       goto bad;
>> > +             }
>> > +
>> > +             if (write_offset < 0) {
>> > +                     if (skb_cow(skb, -write_offset))
>> > +                             goto bad;
>> > +                     if (write_offset + (int)sizeof(*ptr) > 0) {
>> > +                             if (skb_ensure_writable(skb,
>> > +                                                     min(skb->len,
>> > +                                                         write_offset=
 + sizeof(*ptr))))
>>
>> Combining these with && instead of the double indentation would be more
>> readable IMO (shorter lines, aligning the 'goto bad' labels).
>
> hrm. So:
> if ((write_offset < 0 && ((skb_cow(skb, -write_offset)) &&
> (write_offset + (int)sizeof(*ptr) > 0) &&
> (skb_ensure_writable(skb,min(skb->len,write_offset + sizeof(*ptr)))) {
>             goto bad;
> else {
>   ...
> }
>
> Not sure which is more readable.

No, I meant just collapsing the two inner levels - this, on top of your
patch:

diff --git i/net/sched/act_pedit.c w/net/sched/act_pedit.c
index 719bee335e1f..eb61d73730c4 100644
--- i/net/sched/act_pedit.c
+++ w/net/sched/act_pedit.c
@@ -460,12 +460,11 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *s=
kb,
                if (write_offset < 0) {
                        if (skb_cow(skb, -write_offset))
                                goto bad;
-                       if (write_offset + (int)sizeof(*ptr) > 0) {
-                               if (skb_ensure_writable(skb,
-                                                       min(skb->len,
-                                                           write_offset + =
sizeof(*ptr))))
-                                       goto bad;
-                       }
+                       if (write_offset + (int)sizeof(*ptr) > 0 &&
+                           skb_ensure_writable(skb,
+                                               min(skb->len,
+                                                   write_offset + sizeof(*=
ptr))))
+                               goto bad;
                } else {
                        if (unlikely(check_add_overflow(write_offset,
                                                        (int)sizeof(*ptr),

(You could do the other thing you suggested, but as you point out that
quickly becomes a too dense soup of && :)

-Toke


