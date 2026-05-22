Return-Path: <netdev+bounces-290874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH35J6B8EGrdXwYAu9opvQ
	(envelope-from <netdev+bounces-290874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:56:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 449AE5B73CA
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23F22304F77F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF5C46AF2D;
	Fri, 22 May 2026 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO4s5PrI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21384218AC
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464774; cv=none; b=N1AXmBAQGomhcgE5drF4QXESIzOVJQCzvoYsFH3t0ZSQcEEuGHuxyOiEoj3yxVPDTxUJEL5EUoZyvtoyzJvT5CV85hrRMA6/Ab/3blBV9YWBB1m48kO9hBUO8xL2zrpOY4g+m+yadzwknHwV1VWElGHAlGYvzz74yw/Y7i6XXsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464774; c=relaxed/simple;
	bh=hx2KDFWu0T/vqnbDAwu9mZ1KWA/Wdq2y9iB7XC+O4c4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Afy/HdmC5FbO0xBvaGMq1YBrB5ZuvSMNOsTZITSSM15A2iQEn+kCbIe8uzrmKciltCpTasXSfSIcjPc3GzjHEHquYZbamRitfNgnPkYwpFYDhGjXIHp2rmFSldzF2/eusjiTC22gnqliLr/16xoTPEViRDnptIJcrcmV6TVbq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO4s5PrI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F9C1F00A3E;
	Fri, 22 May 2026 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464772;
	bh=sOA1bW+w9MFq40muaJz92VaTBGym/9qUKl3E7aZi2vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fO4s5PrIuu1B74LiOhMZnIqwvIShhm8LFSoajTvJevhDx3hBgp81giYsQkFCIpIgt
	 bj7yW0wWAh12CRHE322qHnkidzvhfQ//ioljVdiAPtX93yzfNYWZM+maJEX3VF6qe/
	 wGzSEIthm6nnk3JYDJO3A1nbYd50/bTgD/YwsCs5/srsyEnE3MjcL8nYyGFGo45HMB
	 9j4HWkAeIM86gcokctXFazJBT5Mqucx17Qk5I33X16CaLVbl2GNv7IbADmdlCflOMl
	 rvTQ5YXhMFe5CYvv9ppByeW6q2Dbae8Lf/ovlVFxKx7mqfM3AH5rpVwQj5XNmqaDc2
	 GrhrrYBDlz7dw==
Date: Fri, 22 May 2026 08:46:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <20260522084611.390fd0a6@kernel.org>
In-Reply-To: <CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	TAGGED_FROM(0.00)[bounces-290874-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 449AE5B73CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 07:47:32 -0400 Jamal Hadi Salim wrote:
> > > All these issues stem from the shared frags point, but the patchlet i
> > > showed is unrelated to SKBFL_SHARED_FRAG, it is more related to
> > > cloned+frags.  
> >
> > Right, right. Just pointing it out cause Rajat's patch adds another
> > skb_has_shared_frag(). Which we'll then have to delete in net-next :\
> 
> With a note that the exploits currently take advantage of that
> specific cache issue. How about we allow it for net now and then
> schedule a follow-up phase to remove it when you get rid of "shared
> frags"?

I must be missing something. What's the problem with changing the patch
to pull headers instead? I mean - if we agree that this is where we'll
end up - we should just do it now. It's the long standing kernel policy
to "fix things right" instead of creating temporary fixes which then
have to be reworked in -next

