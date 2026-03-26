Return-Path: <netdev+bounces-272225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJpgM1uSxWlG/QQAu9opvQ
	(envelope-from <netdev+bounces-272225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:08:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEE833B421
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E48830467E3
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52DC3368B0;
	Thu, 26 Mar 2026 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm6UqphS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3355224AF2
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555500; cv=none; b=A3ePlBCkbQ9i42hzpvwmSxuPrz2gyTstl1wvUdMRoBsECJHJ8DxxzkJiLKYsEH2GH1aNSEt2I1/8e+ECM/vBtmJn0E6VJ7cODulc7IQ+ACYuuxnX7g305862dw+gq4W24StUY5XROHdNaETCr19hJV+/M0f82E37TUHD/oYfT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555500; c=relaxed/simple;
	bh=ujrNdHCX9TEDy7CP7jDt9f91D6F0a8Pi9EGghbbiTMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPZV0PGzJamzTDJ84aO1yOE7p77MJbTcnVEOexU4CwX+2VYCZ3nnjqHyvv07hZmliS7em6cpzCCbv/64CcH3KalRxZDvMElivS0xC3kSjEDmjQDi3uKsDnNtx9yXOZQP6gNEpY77khpzHtWZ/UlF4MwVwKPHlXsWilGXAz5Xl6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm6UqphS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10286C116C6;
	Thu, 26 Mar 2026 20:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774555500;
	bh=ujrNdHCX9TEDy7CP7jDt9f91D6F0a8Pi9EGghbbiTMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cm6UqphS+VgSZKSMmExy8+4/0ZDJ1XU1smq60mr0etaZbtJgBdOQi3Pv74HqbPXLt
	 yOdhLcibflO9rgc3HItkXSWRt7jJeajG3iFAzB+a2j3KBBWmT6GLunP0G1OnClyoDR
	 htk9KcONeW7cGoVF29JNSssVONH/L73haV1gOOAZQ9eHpybFkA4a7ajcFBGo6OZJ2j
	 qJH9rzeFx7CqFC017JBrTGaFcvtF5gW9eZWSqhP48MVigHr+NJsX9yvWOPKIS1YSDK
	 yUUg7RCYu2lJTlDwsafKtMS1Z8W55ncSuoWooqS3NxTtC0TeUjOegPJykGKz8muufk
	 ot+kip2AoAb+g==
Date: Thu, 26 Mar 2026 13:04:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, Yiming Qian
 <yimingqian591@gmail.com>, daniel.zahka@gmail.com
Subject: Re: [PATCH net] net: psp: check for device unregister when creating
 assoc
Message-ID: <20260326130459.7225ae28@kernel.org>
In-Reply-To: <willemdebruijn.kernel.39ac32125c0cc@gmail.com>
References: <20260324205107.318303-1-kuba@kernel.org>
	<willemdebruijn.kernel.39ac32125c0cc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-272225-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AEE833B421
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 18:40:00 -0400 Willem de Bruijn wrote:
> > @@ -320,6 +320,11 @@ int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
> >  	id = info->attrs[PSP_A_ASSOC_DEV_ID];
> >  	if (psd) {
> >  		mutex_lock(&psd->lock);
> > +		if (!psp_dev_is_registered(psd)) {
> > +			mutex_unlock(&psd->lock);
> > +			err = -ENODEV;
> > +			goto err_psd_put;
> > +		}  
> 
> This ensures that psd is valid for this caller of psp_dev_get_for_sock
> and psp_dev_tryget, which is its only one (for now).
> 
> But is it confusing that psd can be cleared out while a reference is
> held? Is the assumption that psp_dev_unregister usually holds the last
> reference and its psp_dev_put will complete the clean up by calling
> psp_dev_free. If so, would it make sense to defer everything
> to psp_dev_free?
> 
> This is a simpler changes and fixes the issue for the only caller, so
> LGTM. Just curious.

Meaning we should add a dance around removal like netdev does?
Sleep until all the references are gone?
Subjectively I think it's ugly, and in netdev it didn't really
prevent races. Dunno, definitely subjective.

