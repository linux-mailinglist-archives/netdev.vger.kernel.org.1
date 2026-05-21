Return-Path: <netdev+bounces-290552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDmaNgw4D2rUHwYAu9opvQ
	(envelope-from <netdev+bounces-290552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:51:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2946F5A99E8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72F643176377
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF77363C72;
	Thu, 21 May 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLY12gNf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E533987F
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378965; cv=none; b=g/E+Dt8tVkRon3Kk6Flwy/oG3eBheGyrNB1/1RsD+YWoNXIeYalKM3lMoknW5AlqxfdI9OrUZ+0wzXKVO3AkJOY9KTV+RdXYAbY3+E4JnLGo7cLAgt1zP81dy41Uc7fQd2ME20iuE1ox3kLz0mZAqDhlfmvCcLN8xmWi9sNLCqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378965; c=relaxed/simple;
	bh=huiBDVm4YZGR+EoYLcyww3eqlN3NbX+f7WlpOSgs6u8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iO/n0q0ILJmW1tzLb1cBFDYfi0P2DBHypAQwMAHZPQAF3737dIdE1Xoeb+b7Pj3OqBpnyBN/id00FIYuqZUNeT+7Z//yskMAiBcTrDZaXw6bxFsKrnmve0ssy30CRx1js4ClljLMY6O0bxAPU0ITqVoJfKA/+E4tXrSlUQrSeKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLY12gNf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEE41F000E9;
	Thu, 21 May 2026 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779378963;
	bh=AVHSwaF32iw0dr0NP2vboSwwUGX0DL+w7UhbleUcJ/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CLY12gNfK+pqlfCXH0Bqy1pMiGGg7fSeDvZbi0TJ5/lXQkAjl6I+YjW5kpYjPuj6s
	 JXZWVOMFPNLFmNAHN1CkZ2P2DFyliJ2ZlpOz9Ipf4eX0NGw9nHEAO18W4lEnCZwE/g
	 cnIVuG83rP5NKgNqM+3PXpazjv26TMlGNr5HVKYC/bWRTTtltdGtYpk1I9cEyKlioQ
	 JO/D6uj17JqCR6Aa0kwL6bPGWZlwRoB6ii8XnkciSNc3c6doQMSwdZcj3Zq5mKOSwQ
	 YYDnzuWBqOPYENmj7mw6CE0LL01ozncXcGnP8TqVj0i1pRs6JNK4zeIwJZYXjGy+yL
	 cLcsecap4+78Q==
Date: Thu, 21 May 2026 08:56:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Rajat Gupta
 <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <20260521085602.1a7d7ef0@kernel.org>
In-Reply-To: <CAKa-r6soz=iMBiYG0Grhhc12yhdw9vMNV+XjjEPCmtgKK6+rhA@mail.gmail.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
	<20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
	<CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
	<CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
	<CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
	<CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
	<20260521073526.793d30c3@kernel.org>
	<CAKa-r6soz=iMBiYG0Grhhc12yhdw9vMNV+XjjEPCmtgKK6+rhA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	TAGGED_FROM(0.00)[bounces-290552-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2946F5A99E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 17:51:25 +0200 Davide Caratti wrote:
> >  Do you know of anyone modifying payloads with pedit?  
> 
> yes: MPTCP kselftest does that on purpose, to mimic a middlebox and trigger
> DSS checksum failures [1]

As I said in another reply (looks like the ML is having a significant
lag this morning :() - we would still support it, the shared frag
tracking is just an optimization to avoid a copy. And maintaining that
optimization for an occasional CI test is not the right eng tradeoff.

