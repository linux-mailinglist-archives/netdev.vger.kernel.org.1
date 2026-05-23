Return-Path: <netdev+bounces-291128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /OgYA/jZEWqerQYAu9opvQ
	(envelope-from <netdev+bounces-291128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 18:46:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B0C5BFDFD
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 18:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BFE530097FD
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA212271443;
	Sat, 23 May 2026 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlXNEpdT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9441234964
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779554804; cv=none; b=IN/3IY7JhM/NJC6UhfM2WnzQ4GqLNE/s2LJUT7wAQkf+kwKqotecfpLkNtt2N11Q4OgnolUCecWsskiZ54kBQmjtbR0KIR6fh5Ao/mNJTKSqJvPcZHaqMWxMB36fbcrOJNJPBrs2AVByjEgtsUSULzQoN7Ky2hb2Dc6cwIlzKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779554804; c=relaxed/simple;
	bh=xEsHHbTMIZlD6eXWogBdQ4MolzKKJMIyKMMMj3+p+wY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olwAIr2gaJ4Krzf3edJIL5qSKKFntSA+B+OI2/cvhJauvs2dBzeUid150MTvykH7lCJshbt0bJ7DJJEuuhdRynzR6lclvksrKOJQoPaEmtdNt1h0WnsWyj8HqTkre3l0OxoMhX2Wlr5kmkblqstmkr22h8u4E2FSwYWtDkNi1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlXNEpdT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEF61F000E9;
	Sat, 23 May 2026 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779554803;
	bh=SDb1wUE+0uQITslPsbdUEUywAUrmmfifmM9EQFEUuxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BlXNEpdTJVvfyT+eV1m17xVI9HuPb+RW3SUCapT9o2fKgB+/KnRU+xFn7pyVl2v7v
	 Q7DcPrCm6lZTkMXvMvX1ssYQSVBmRNfD3INL3Hc3WYZv0Gz/QhTTfamoMxSNcS6dFr
	 JhTK0TW0OR4MlOcGd9B2Tx1zoTQZ7GXbRE4BjcX33QGm9mbWihWuKdrDXkyPd67wH4
	 ey+SdVEo8qVwv4b1PKBd/ZC1ubbnqchNIeTdx9WsLifa9akKKmabNKFMA60eXB97WR
	 faVgYs8i8YrGBiCsptEnV5qCAhBFCwCqYc9ym7tEyetWZgm3TcsUFbHw95ULttcT2S
	 OuHMSBdX59DJA==
Date: Sat, 23 May 2026 09:46:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <20260523094641.2bef6580@kernel.org>
In-Reply-To: <CAM0EoMnDjLJ=_+p+2xuHrbWFhtNCdQhONu21z_S7eZK+OFMibw@mail.gmail.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
	<20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
	<CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
	<CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
	<CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
	<CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
	<20260521073526.793d30c3@kernel.org>
	<CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
	<20260521084640.683c1ee6@kernel.org>
	<CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
	<20260522084611.390fd0a6@kernel.org>
	<CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
	<CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
	<20260522175507.02b4fe83@kernel.org>
	<CAM0EoMkh3CF4EpNQDHUogxJLyqdw8gMFfvXQFOE+N4dLZY6gJQ@mail.gmail.com>
	<CAM0EoMnDjLJ=_+p+2xuHrbWFhtNCdQhONu21z_S7eZK+OFMibw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	TAGGED_FROM(0.00)[bounces-291128-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 54B0C5BFDFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 23 May 2026 08:13:21 -0400 Jamal Hadi Salim wrote:
> > > @@ -474,8 +473,6 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
> > >                 }
> > >
> > >                 *ptr = ((*ptr & tkey->mask) ^ val);
> > > -               if (ptr == &hdata)
> > > -                       skb_store_bits(skb, hoffset + offset, ptr, 4);
> > >         }
> > >
> > >         goto done;  
> >
> > I see you are trying to get rid of the skb_header_pointer() /
> > skb_store_bits() piece. Sure looks cleaner if we must linearize.  
> 
> The other thing (i may be over thinking) with pskb_may_pull is: if the
> data is already linear (in a clone), wouldn't we corrupt the shared
> linear data of the clone?

I said

  for the portion of the problem that's "we are writing to frags"

IOW not replacing the rest of the patch (assuming we care).

