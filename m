Return-Path: <netdev+bounces-301434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OQREIkHGOmo8GggAu9opvQ
	(envelope-from <netdev+bounces-301434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:45:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF96B9325
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:45:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b=cxpjNDPi;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="M o9immC";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301434-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301434-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A12A30031F8
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7431832938D;
	Tue, 23 Jun 2026 17:40:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231AB26E165
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:40:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236433; cv=none; b=VKVAPkG6UlPQVXP8SUdylKtg0l3kCnXApl5odQdshF6AQgRcufOGQ7TSNQA+kl1gGhMFjIJdp6RNQzsU9oNpmCVyR6GG3t7wiDwIxU0ncCggov/rquCGBompFqRfWnfN28Jooz1nXplr8gezvzh9XMJrj1RTxpgnytffbcljkSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236433; c=relaxed/simple;
	bh=oSQvxznWe4ypj+axOzEFmAdkcR3C5J0ABK5XxKx/tNU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FdtF8buLwWfVZnkNmoHQDmXHW0gJvwi78VgDCaWQHaGNbdnVniVuPpDYQvPhJiCT/w3jn4msT5ERXNUCPoeIBWV4QLdw/u8a9nEkjjd+bpfsTk+iUatNJ8RlzsvXuvAwqM2tQ81uBiDUyL4YuyMhTK6U+ZfpWSWVhP4g5idW2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=cxpjNDPi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mo9immC7; arc=none smtp.client-ip=103.168.172.144
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3462FEC01CC;
	Tue, 23 Jun 2026 13:40:30 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Tue, 23 Jun 2026 13:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782236430; x=1782322830; bh=oSQvxznWe4ypj+axOzEFmAdkcR3C5J0A
	BK5XxKx/tNU=; b=cxpjNDPiGR7y4D7z5GyUhooyK1XE7X9FihQiH0eBNvrMfNCo
	NY2ZdL2i5SChmg7lJLTuLo5b+OIA/K3DMg6hdVpV+jJnOhE21AmsFtWsmk9QmsX/
	KLqKQEfNaBpR71oFDo6qa0HUKzWPadyEdX26nAdxyGADuTlbor3/OlkP2CtAJaNq
	InCk2UktRQoxfmYsu1ZUOQYttX+ZbgWOshizRfVqrICFwFL0k3i6JvcFxqJVGreB
	F1O7HzR2PtXgRSHPiokXLdU3evfYqWbr3QK33auTyUPz7dZsSt7NA+GvWAhtuTM0
	8Y92v5UHjILGMXYhoRAgU/XaiV2Qr1nSni9aQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782236430; x=
	1782322830; bh=oSQvxznWe4ypj+axOzEFmAdkcR3C5J0ABK5XxKx/tNU=; b=M
	o9immC7ibPngc1MeENfdh4ErRqLCJzwVmPCCGn2ITuR3nv0MIqLFVUQa0wUO4FPk
	JP2SfS9fZVyvCr3/5e5Z3bNZ3gVPRfiAMrei2R6Ezz6NKMAH1MfANHd26kKXMSAk
	pgLpvMPEubIPkgIO+1Dco32+lIPg6XhHnESazX5+I5qGgerA4jr3FPFKl3gGXX+y
	nUAYPCD89CbD2H4Z6wkRUuCIST3aTyuL9+eJW4lkr2rHp9yv1oq8CFP7u93INyot
	8y2yuCsmM/r3pE6gwfENzbkV/Jyq0Y3+tKQNReCtIHCkcerFANK/7aLYtoTBQTL5
	VYIvEIFT8daSDSyhYaadg==
X-ME-Sender: <xms:DcU6anv2d3iYvEO9bLTz3udNb_z8FGU2AxgzQouuG-24qlKDzxdkfw>
    <xme:DcU6ajRIedGrEyoJcCDLSxDlkZsciqVYUJgoxSRFyixJiU_fUNusp_RzHtyT-H3c1
    UdUi6eQjbF3B-nPU-J1mAMxKr9HWUh_yO1itCzDjL5ikj6UWBz-7w>
X-ME-Proxy-Cause: dmFkZTEEcIQSwnJHrOxkKJjI4DpllrqcRH2YsHytmG/5AmuJDjKOOd6aj6xvQZqmHITs7G
    HEcV2hCv21vOYxWDWmhIYaiSaoO1aDU+GjF2lXT/nkhfuxYhY0FgFHplsXEXizLphbj6/A
    2VVrkLQC+2aJ6+3Ge4a1xTAwBkNwa5KfVbEJVDG+PcDqRjHJpe/kTCMJG+Tk5eHXq7Cnc7
    oiw4udpvcxzxuTfLzxGI8Ru9ZLumJuS8MW/MSN7sCcnQzCNvSaP9lySsrYeE3N/o6TM7Xb
    mobTIOny1gQAeS4UiYhrw7OsBSnRTZkeMCHJ8jscGpBGHQXIfN53WWmOBUe/zpe4PEYwTz
    yoxLpJmry+ew2myGTE5gRv+J+gCUQb6QbPSCjYA/4N2dEZDUdKwAa0r+5HpUmC3UNFsQKm
    UsvB2BrwOa4fRbnRNkATTMCFSdIePdHHEW/B3+2uLjmWbI+yT+6/e2otuFaXYBvuFBco+b
    w9WOjuLccCQi0W2iNUWLq05iPDFpnjRQTocm6IcrlYcqfWIkAiUx8ekpyv5QWZGKGeDwyT
    bBFyc1a5BN0kuZ0llykdSisStNqDy7q9fF4R9dZBDKmMDlWWjTipWF7998F6/7v6vBA7VS
    lWHV7mMBm1cmiwcP4AfbhgQUlfcs0pCJ+zJV4kXLqkymImFrUl6ObINT4eWQ
X-ME-Proxy: <xmx:DcU6arpWwBr_cadx3dOrXjekDj4g7UcbxSURC7ZToJkEcmw5RhhN9Q>
    <xmx:DcU6ataMElrAedx_RNXgb2kut5Pszt7LYzB0R4qbslJ580qhLEb00A>
    <xmx:DcU6arS2F9iyHfFhL2FCIbgRe18_e8aFmfweSz3AQjj-p1y3wEQN_g>
    <xmx:DcU6as4DwODo6pg0HSoYFJLalN6neAbBg0lvvIMBIFrH-RAAWx6MDg>
    <xmx:DsU6aszRMxzRRO_7R1gly7o6xKE56qwVs7Hb-whwjkbCCxRw9wM-yWEh>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D42922CC0083; Tue, 23 Jun 2026 13:40:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aqzxz9K-cSE-
Date: Tue, 23 Jun 2026 13:40:09 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Cong Wang" <cwang@multikernel.io>
Cc: "network dev" <netdev@vger.kernel.org>, "Li Chen" <me@linux.beauty>
Message-Id: <66eb8227-85b6-4684-a4fa-e3e17ac2fa45@app.fastmail.com>
In-Reply-To: <aixU_RccxS_BKhgX@pop-os.localdomain>
References: <b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com>
 <aicbyQIC2qEveNd-@pop-os.localdomain>
 <455281ec-3ee1-4f27-989b-c239f0690d8b@app.fastmail.com>
 <aixU_RccxS_BKhgX@pop-os.localdomain>
Subject: Re: [RFC] connectat()/bindat() or an alternative design
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-301434-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:cwang@multikernel.io,m:netdev@vger.kernel.org,m:me@linux.beauty,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim,app.fastmail.com:mid,johnericson.me:dkim,johnericson.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CEF96B9325

Hi Cong,

Sorry I have taken so long to respond. Rest assured, I still wish to put
in the work discussing this and (if there is agreement) implementing it.

On Fri, Jun 12, 2026, at 2:50 PM, Cong Wang wrote:
> "Nix needs it" is a much better justification than "BSD already has it".
> :) So please add this to your patch description/cover letter.

Well, to be clear, the motivation goes beyond Nix's immediate needs. I
think the Nix ecosystem would be interested in my object capability /
"zero trust" experiments that this (and other things) would enable, but
this is farther afield.

> Just curious: any reason not to use TCP loopback here?

Sending file descriptors over sockets is very important to me, so TCP is
ruled out.

> Any reason not to use abstract socket?

I wrote a bit about that but perhaps it got buried:

> > But I really don't like this because we have just replaced one
> > ambient authority contraption (the root filesystem) with another
> > (the abstract socket name space in the network namespace). The
> > problems with ambient authority remain all the same (and indeed, our
> > experience with Nix has been that network namespace unsharing when
> > you do want to do some outside world network access is much more
> > work than filesystem namespace unsharing).

To make that more concrete, connecting to an abstract socket by name has
similar TOCTOU issues. For example, it is possible that the original
server disconnected and something else "stole" the name in the meantime.
With file descriptors there is no name reuse issue --- the `O_PATH` open
file must point to the original socket.

I don't want the socket to have to live in the file system *or* the
abstract socket namespace. I want it to be truly anonymous, and only
referred to by file descriptors.

(Also note, the mechanisms described in my last email go further than
the original patch's, but also subsume them. If it would be helpful to
illustrate exactly what I mean, I would be happy to share a new patch
implementing them instead.)

> Indeed, it would be very hard to change since it is coded in UDS API since
> probably day 1.

Just to be clear, I don't consider things so hard to change, because the
bad UDS UAPI stuff is rather "cosmetic". "Anonymous listening sockets"
(let's call them) can be retrofitted fairly easily, just as abstract
sockets were retrofitted fairly easily.

Thanks,

John

