Return-Path: <netdev+bounces-290805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIdBLPpKEGpvVwYAu9opvQ
	(envelope-from <netdev+bounces-290805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:24:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8145B3DDE
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51B6330D342C
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 12:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE803750AC;
	Fri, 22 May 2026 12:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490CB36EAAB
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451260; cv=none; b=ZwAX/dyHp2GJowwlJnwQcWcK3J7RbsUA08LuC0O/zrZQ+3OPasHpxB5z+ZB0S4Bz2Qroc2t6ndrFCTXhlROaktYOcnBhVthV3xeTFBFvysqBT9GlE6ckyfe5syh5kId4dblXBi0p8pKlFjmOl3CATrsbaNmzf7sxiN7wfh/ThTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451260; c=relaxed/simple;
	bh=/VL+cC9uB4nBLYJv72fsewmofAzMA0cQjn/ppSOQa+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a2yYvf/0QwF6KheeJCD3M7gxxTMa9a5IuTwQeoo+WYEBpUw6fvXkCxWmbkZQE68fvAO0A6brcsXUrkQeqr7QrCh9O7krpGf/U0XwzYq1YKTQi86d6qx3Dxqt3YYCsEtSqHGH5q0CruSd+VxUINvYzekNUJgL6DmPSSn7sGWmjfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Jamal Hadi Salim <jhs@mojatatu.com>, Davide Caratti <dcaratti@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Rajat Gupta
 <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
In-Reply-To: <CAM0EoMkANSFw7AxAX3opcnJhzd_qchosW8nFVfWV8wEkdL9R9Q@mail.gmail.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
 <CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
 <CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
 <CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
 <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
 <20260521073526.793d30c3@kernel.org>
 <CAKa-r6soz=iMBiYG0Grhhc12yhdw9vMNV+XjjEPCmtgKK6+rhA@mail.gmail.com>
 <CAM0EoMkANSFw7AxAX3opcnJhzd_qchosW8nFVfWV8wEkdL9R9Q@mail.gmail.com>
Date: Fri, 22 May 2026 14:00:55 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87tsrzodqg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [1.10 / 15.00];
	DMARC_POLICY_REJECT(2.00)[toke.dk : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290805-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,resnulli.us,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,45.145.95.4:received];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0E8145B3DDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> On Thu, May 21, 2026 at 11:51=E2=80=AFAM Davide Caratti <dcaratti@redhat.=
com> wrote:
>>
>> On Thu, May 21, 2026 at 4:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
>> >
>> > On Thu, 21 May 2026 06:15:17 -0400 Jamal Hadi Salim wrote:
>> > > > This is the same claim as sashiko1 but sashiko2 gave a much more
>> > > > convincing description ;->
>> > > > skb_has_shared_frag() is only true if the frags are flagged as
>> > > > SKBFL_SHARED_FRAG (which is what the repro did); however, if we get
>> > > > frags from eg a driver on ingress and that skb gets cloned with fr=
ags
>> > > > we won't catch it.
>> > > > One approach is to do an if (skb_has_any_shared_frags(skb)) and th=
en
>> > > > do a skb_linearize_cow() but that sounds like overkill.
>> > >
>> > > Yeah, this would be overkill - imagine running tcpdump 100% will be =
cloned
>> > >
>> > > > Another which will make the patch even uglier (but less expensive)=
 is
>> > > > to add an extra check insde the patch's "if (write_offset < 0)"
>> > > > to do:  if (write_offset + (int)sizeof(hdata) > 0) { skb_ensure_wr=
itable()}
>> > > >
>> > >
>> > > To be precise, something like attached (untested, uncompiled)
>>
>> hi Jamal,
>>
>> I tested Rajat's patch with your latest addition; it compiles and passes=
 with the same subset of tests ran earlier by Toke.
>> Agree some follow-ups can be done (e.g. removing the hint, and maybe ano=
ther smaller thing not yet detected by Sashiko) but AFAICT you can add my R=
eviewed-by: when sending v2.
>>
>
> Thanks Davide. And a Tested-by as well? I guess the same goes for
> Toke.

Applied your hunk on top Rajat's patch and re-ran the tests. So feel
free to apply my reviewed-by and tested-by to the combination on
resubmit :)

-Toke

