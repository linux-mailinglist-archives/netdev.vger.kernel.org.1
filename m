Return-Path: <netdev+bounces-292244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPSYLmLGFmpVrwcAu9opvQ
	(envelope-from <netdev+bounces-292244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:24:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20A5E29E5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B73933012CEA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBBC3F075A;
	Wed, 27 May 2026 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5wpdlXU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tfNe2ZYx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0BA37AA7F
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877300; cv=none; b=GaCFZudQ/p71odVggQbPdgGjyvwsqaADJ/gRx0CLSuTZwm/a3qWRy84HMm6zpTmuDZeh7NiC360H7AwrykSuZXmdk7czF12fdeWlytjWu7jfM8HSSwD2n+/ltk6xvIZNSCeOp+mbiFgVSopEB5Iqijntb5Wn43YFG5Aglqobi6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877300; c=relaxed/simple;
	bh=s79viPu2d2HZuyW0HbWsr7Eave7tm4XA1tl/HWuoK1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ictbS8ufoo8z0JAnmUqFShZidjat1sOjLvhoTQCCJpr/fyTR5DooDXESzXKkjR1cCnOp7JjCn4C7XQtEO5xHplp9B92QDTZhtj5WafMK30AVZvf898HLNuFtxZKUloTeqbhszwMMbj3B90hbjPG89KM62bm6twVMUi3J1MUjPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5wpdlXU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tfNe2ZYx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779877296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOfZTr2QhtogmOSr0x0T/QYiQ3eokGu9YlGbUilxeG0=;
	b=N5wpdlXUAzyInEeNuCTg79K8EkjfQdsdBCj/fNudLFpkkkpAjlDQdrc4TsC3jGDQCh371I
	qIEVbGh7Zpuyr4izUe5iAjvKZQQgvAli4MhhNMs+F+nlK/HwzeZYlCQevxPzQeTv8oViUO
	oGpyyAuVg+FFp1QJHpYJ0YRHcu2REVc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-nBrFTd8lPGWruxsOuPv9uA-1; Wed, 27 May 2026 06:21:34 -0400
X-MC-Unique: nBrFTd8lPGWruxsOuPv9uA-1
X-Mimecast-MFC-AGG-ID: nBrFTd8lPGWruxsOuPv9uA_1779877293
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49058295985so25166815e9.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779877293; x=1780482093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOfZTr2QhtogmOSr0x0T/QYiQ3eokGu9YlGbUilxeG0=;
        b=tfNe2ZYxdoTNzeb4MyHzGUH9HKI/Ja6Hni+qQV+fyiv2tzND9ZfUIqlamSF5dCZY3+
         SvqrJtw8mVERyvctX+U64lkax631xzxC6BvsgttZwxqMdglB2s/Wcl+mUEAiYEAyUjUg
         5PwGWKJT4zfgKTFAv4EpOAuNxRySTn7UGQnTR250e9FPqDZDoi/NiVi7Sk4FYC1QirMA
         xBhHCAOGb73JWuaN3ks/YKDtUZrH20E1Ys38GVRRVlB7ymp+vQzBp0/y/7S+UZMwrcc/
         lz5UzFi/A7M915gLp1Y/EwAcRlkWJk34bhaqK7z+YjuCujhRX8CTU62vabr421kaDDFO
         PIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779877293; x=1780482093;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KOfZTr2QhtogmOSr0x0T/QYiQ3eokGu9YlGbUilxeG0=;
        b=eZamfO94iVHTDY0zgrsQF1sogjQNUsGAoHBNpjghJ0Ja+HTVPT0Xe4kKO6a5NJcY6D
         lKv6qTLG7lNfTfmGG0h57OzbcFLBcrCfNtvZyJYA4Y1uQMBY7BM9Rb/K7xWeKSu+rFf1
         T8WwdJ856nTOm1uupFzptPcmngUUpXeLxVoHthQF9A9cTMJmSJND//ATe0a+CVefliF2
         vbd4HkPJNk6Wq18w2Wcce33c0JQF0hKPp2En90fuogVdH7p15wc74nVVJKsa2y7gOK64
         1pJmXgWhpNEBakuXZCGg+5EKI+eqBSSvTgWiHnIBWGVT0Roij+3gWftXxE0CGI2bBp+y
         c4MA==
X-Forwarded-Encrypted: i=1; AFNElJ+4ZCPUQo98uy88MaP0RjZ/5bkacrRCPjH4F4Gts896G78drn6MvTd8GfEb3ejuqlbt/KkICUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wLbebv8c71Es0+XsU1WU8RLQu52kOIVQ0qCYAfFoFcr7M8MD
	tlhL1TilBcf1bypsQcjJiMBD+Bsy8w4OKNCQCfaaftvsCRZIgGw8o30IOSA3UnOzvCKh1wLW8Bj
	bT5jPK7zRvWQgH1LhvCMyEjwDn8QWjrGfH2Io86sc1yLBCm1cpFbSFqVd6A==
X-Gm-Gg: Acq92OE3hyyrQ9Rb+V9KoVQT1UKZNm6+2an8tlixjiSdUTCULzzdCI1zZYUuHOwhxWH
	leqDFLAn0A21tBXrm/Yw4pHjLglo56H6anjG3qDiwSt5y30vWmeFe4N//4FI2kcI7IKCuJrYst+
	WebsM2DzoHD5T7/GrWpOED2h1olk9SfXNtpWwU0KPQTSYRVgrD91UNngKc1LnW/hRyhcp751itU
	XbPt8+toVyUE5QGVRFmjvlnPJzIOuFpUl1m5L7aAyr9z6Dcn3tI0zliwTwrfaFU32ozv59nOY7A
	JebYVaRLxWMA8rrdBvD9JDeg4cC1u9MmXxWgKX1PNbKrWf2ZWkaC3KCWYVIro0+jgDsp6tYryIc
	CHhf4YeQZpddQjLrBvGeitgr/nG9JDY8Xf19BI8kRY4OkeJtePDpIForRwRU=
X-Received: by 2002:a05:600d:640f:10b0:490:3d45:48d7 with SMTP id 5b1f17b1804b1-4904248d296mr268514695e9.6.1779877293243;
        Wed, 27 May 2026 03:21:33 -0700 (PDT)
X-Received: by 2002:a05:600d:640f:10b0:490:3d45:48d7 with SMTP id 5b1f17b1804b1-4904248d296mr268514195e9.6.1779877292777;
        Wed, 27 May 2026 03:21:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527f7f7sm579202405e9.7.2026.05.27.03.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 03:21:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 23A317BA3CB; Wed, 27 May 2026 12:21:31 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, yimingqian591@gmail.com, keenanat2000@gmail.com,
 2045gemini@gmail.com, rollkingzzc@gmail.com, dcaratti@redhat.com,
 security@kernel.org, linux-kernel@vger.kernel.org, Rajat Gupta
 <rajat.gupta@oss.qualcomm.com>
Subject: Re: [PATCH net v2 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
In-Reply-To: <20260527100055.1661c5c9@pumpkin>
References: <20260526155913.1060694-1-jhs@mojatatu.com>
 <87wlwq2cxf.fsf@toke.dk> <20260527100055.1661c5c9@pumpkin>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 27 May 2026 12:21:31 +0200
Message-ID: <87tsrt2lw4.fsf@toke.dk>
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
	TAGGED_FROM(0.00)[bounces-292244-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mojatatu.com:email,godbolt.org:url];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3D20A5E29E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Laight <david.laight.linux@gmail.com> writes:

> On Tue, 26 May 2026 21:22:52 +0200
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>
>> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>>=20
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
>> > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>=20=20
>>=20
>> Re-ran the tests, and everything looks good, so:
>>=20
>> Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> Also looked at the code, and I have a few nits below, but I'm really
>> nitpicking here, so whether you end up fixing those or not:
>>=20
>> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>>=20
>> [...]
>>=20
>> > @@ -323,7 +324,7 @@ static bool offset_valid(struct sk_buff *skb, int =
offset)
>> >  	if (offset > 0 && offset > skb->len)
>> >  		return false;
>> >=20=20
>> > -	if  (offset < 0 && -offset > skb_headroom(skb))
>> > +	if (offset < 0 && offset < -(int)skb_headroom(skb))
>> >  		return false;=20=20
>>=20
>> This change makes it really obvious that this is really just:
>>=20
>> 	if (offset < -(int)skb_headroom(skb))
>>   		return false;
>>=20
>> so, well, that would be clearer, IMO.
>>=20
>> But then I guess the same could be said of the positive case, so:
>>=20
>> static bool offset_valid(struct sk_buff *skb, int offset)
>> {
>> 	if (offset > skb->len || offset < -(int)skb_headroom(skb))
>> 		return false;
>>=20
>> 	return true;
>> }
>
> There are all sorts of integer conversions going on.
> IIRC Both skb->len and skb_headroom() are 32bit unsigned.
> skb_headroom() is relatively small, skb->len can be over 64k but nowhere
> near MAX_INT.

Right, I had the implicit signed/unsigned conversions the wrong way
'round in my head. So what's missing above is a cast of skb->len to int,
i.e.:

 	if (offset > (int)skb->len || offset < -(int)skb_headroom(skb))
 		return false;

right?

> offset is signed 32bit and the code is allowing for it being -MAX_INT
> (but I'm not at all sure whether that can happen without overflow being l=
ikely).
>
> So I think the single test:
> 	if (offset + skb_headroom(skb) >=3D skb->len + skb_headroom(skb))
> 		return false;
> is correct.
> If offset is 'too negative' the LHS will be 'very large postitive' and
> the test fails.

Yeah, I agree. FWIW, they turn out to be the same number of
instructions, the difference being that one contains a jump and the
other doesn't. It seems clang needs an unlikely() to put that jump in
the 'false' path, though:

https://godbolt.org/z/5o5Gxqe3W

OTOH, I think the two tests are more readable; the single-test version
would need a comment explaining your "too negative" rationale. But given
the subtleties of the implicit integer conversions, maybe that's better
anyway.

And they're both half the instructions of the version currently in the
patch, so if we're code golfing (which I guess we are at this point) I
guess we should pick one of those :)

-Toke


