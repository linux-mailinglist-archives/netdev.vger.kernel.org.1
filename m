Return-Path: <netdev+bounces-304599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eiYFHJ3gR2rfgwAAu9opvQ
	(envelope-from <netdev+bounces-304599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:17:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7EB704302
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:17:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm1 header.b=cfsKI79L;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="P Q6I+9k";
	dmarc=pass (policy=none) header.from=johnericson.me;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304599-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304599-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D837300F544
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD815305047;
	Fri,  3 Jul 2026 16:17:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D307428488F;
	Fri,  3 Jul 2026 16:17:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095446; cv=none; b=WdR41GH4RGSHXL0l+PxZ13Nzy/gKeBxhf3E4L+BsY9TZ/WrVInXp+wFuQpCCWJicynR0gtZDwdHPYhADE50VeS9nl2n+nKoBFLaWAmDsT3+5KhSZdLLrTC3XrBNaevPYSKefxoxygv59MDGnE8Px1sNhjql6gxehkR1SL/qvt+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095446; c=relaxed/simple;
	bh=K1t3DU4zFcvSE8I0dwtDprBpNqurf09pmHflUdwBuys=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=H2rYNX0pvbTnQZIUUsw9bEtGHqAVje11mVQpMsw/ZB7ZdKKLD7gt6j3l89IrGbpb8Ru2XsdOnjCoVvkMTDQUKvbdfh04DqlvuyRDy6IrG8jAyVdHhEO5hc+FeUhXlR1SbeZBa32JEumWn2pFEAnGiNo0+Hg5Stfbd9e57Whw4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=cfsKI79L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PQ6I+9kD; arc=none smtp.client-ip=202.12.124.159
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 082EE7A00F6;
	Fri,  3 Jul 2026 12:17:24 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 12:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1783095443; x=1783181843; bh=/QkTsC6xUCqstWYZjMorpu7FsivaniwM
	rj3YB4WHzmo=; b=cfsKI79L64bxgB2ZcJAK1CbGnDSLy2vUki9GL8slWLaZ/aWX
	LidakxnQpqpYtO+54qsr2aqF7YNAg2RXZBdSI84S5HljSiznbQjXbuWVTRuNE0VE
	J1kUOcZlJv5LQs4+OjcKifB7xd0WZTnD8YkVjM0a0GD5AovKopNWvM1YcmIpmVSp
	VYSS32vokAx/g2fP1o/Lj6kmMKdKbMI2RRnX0Lv34saG1t6fiyI3/23ohR6bhnyA
	4SYU+lRON0BTxgqLYDXKsvojQqnmunDP48tH+1Y7K9LD8nb1TPs411dEmqcMzaV0
	ynOTh+b+VVk+Vft+OvjzYxfYYwnjEIhoUfUPfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783095443; x=
	1783181843; bh=/QkTsC6xUCqstWYZjMorpu7FsivaniwMrj3YB4WHzmo=; b=P
	Q6I+9kD3wRrmPqYjdP3gsMfH7ZEEucHm/uMDCyDvsvtKTOD+GG0wtkRcrKfkonDm
	3l6Mtq/9UY6LRywL0vSME/zMLboz5MeEfsV0w2w3QXo3jTteyU4jPSH7EFDDbcUe
	eQY1RS/GOg0wY3yfO4IQPchVQYe3HvIysqc7I9Wlqe/WLUaRZjF5IR51xkMMygns
	kmum/pvDNmDV5qHonKmGx6b78JPq1pC6co1Yl81hA+FhayrEyDi96yA4ASDryGWP
	GJRVuNZmqSkvHfTw8ZmUMx+/oIKv+FnRhidRDaey1j+nT9z6G6i/WasPfkYnWGNt
	yKa0kqc6C8X25E8GVeu+Q==
X-ME-Sender: <xms:k-BHalN8nVmWy9qyXGkLmJp8fH_qAuOXmt26m4vN_6KmxSicSNgoPA>
    <xme:k-BHaixV0xebXUsHD1J-YadkGLqNnWru-vaT-CCjNXAN77j7S5N7npoDTb1_1kJvq
    6FYWQ6hNmtwm0yBT58N-Bk0L8pLBA0qVbBte7lmHGAxD01eMXA2Ew>
X-ME-Proxy-Cause: dmFkZTEHAn6vndmOrj8IzKI2Nn3VxCG9OTqVQkt3NAfPiyVOpRMCwxACZcym0E6KH1SVfT
    KSwRVE1Moc8ZkzCS4inuCam+9NFdxD0BRVJALPF5sfR2v18mVzRGEZMO05pLvfRpJFW3TQ
    /QwLTKLvlXoW8uYIMwNG7/sWYd1ljrXF7AmqkGQo3n+0/FX8CXgpiH3ZUsnc1s/nTjeT3I
    jl/xWsSJ7qnH5jHfctA80WM2pTu3g8+btt2M1wlMn0171BAkv6CCFjPwuoeIlAzdo2plBW
    rwQC5NKpuj3Ia1PQd6xr2zbdeJmFeZbntI6Nmael1LDPrqWdc2sIPx/9z3J4L+AbjY/zql
    NgNYZXPycBAtn4Gfi7e1RmQ85qkjuSxrxBfT8DPn307Hu7ZV35ZPQbZwnei8Hqa7kF1QDz
    pvAQfieRL4drk4A/KnQkl2hkNX6YfhWTRRT6KIoTkXNULDMxPUcRlRx8D/msEpSLZXZQII
    FXl84qmHJnv0dK8apxUgDKhwK1xGkyKzmOTk3+cL1DrW1MQr04NBzxxAk7FT+4o3LC96dy
    FE+tKBE+7ObnmY5IT6yd23ElaFhAnP/kuHXVCyC04Hpgnfedml72X1cV3tVvfo4BRm5uwb
    moLYJ9Bi+ShSdYHFVdxk68hdwW3dgeZPMPyysABPzK0b6Gr0/YwSeTyZYq+A
X-ME-Proxy: <xmx:k-BHast_yMGc90-_Bk77eTn32SA9hSt45a9Ji5t-F5CMytjvFxBJJA>
    <xmx:k-BHalfJCl8H2Uvwf7z4TtHFBKjaM_vsOvXpLQuGSh2iQlF46g0dYQ>
    <xmx:k-BHap80c7ltQz3UaTf7eoVrRNALcapkByBo2-MyLEUPwDdXPHYLiQ>
    <xmx:k-BHagQinA6A6nztAm3YEtMTM8B8JU_JnR8u3PHIA-dH8Khu_-npSw>
    <xmx:k-BHagUJaVIamL4C0eghZycH9ShgTTDHMlHQOkyjyA4P2iiX8V_pEjnV>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EBEBB2CC0083; Fri,  3 Jul 2026 12:17:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aqzxz9K-cSE-
Date: Fri, 03 Jul 2026 12:17:02 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Cong Wang" <cwang@multikernel.io>, "Li Chen" <me@linux.beauty>,
 "Andy Lutomirski" <luto@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "network dev" <netdev@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "Sergei Zimmerman" <sergei@zimmerman.foo>
Message-Id: <6b7eadeb-5b4d-482c-972b-bfb9f6b56548@app.fastmail.com>
In-Reply-To: <20260703-teamgeist-ganoven-kundig-eff19aa92e38@brauner>
References: <b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com>
 <aicbyQIC2qEveNd-@pop-os.localdomain>
 <455281ec-3ee1-4f27-989b-c239f0690d8b@app.fastmail.com>
 <aixU_RccxS_BKhgX@pop-os.localdomain>
 <66eb8227-85b6-4684-a4fa-e3e17ac2fa45@app.fastmail.com>
 <e396ce86-ec84-4189-9da2-98af7cfa6c41@app.fastmail.com>
 <20260703-teamgeist-ganoven-kundig-eff19aa92e38@brauner>
Subject: Re: [RFC] connectat()/bindat() or an alternative design
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-304599-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cwang@multikernel.io,m:me@linux.beauty,m:luto@kernel.org,m:axboe@kernel.dk,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:sergei@zimmerman.foo,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,johnericson.me:from_mime,johnericson.me:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC7EB704302

On Fri, Jul 3, 2026, at 9:35 AM, Christian Brauner wrote:
> Please stop sending a bunch of disparate patch series that all do
> slightly related or overlapping things and point back at each other.
> 
> It's completely impossible to follow for anyone what's going on without
> chasing down discussion state across multiple subsystems. The net people
> have zero insight onto the fs struct discussions and it's completely
> pointless to try and design all of this based on thin air. Nothing is
> locked-in yet. This is not how this goes.
> 
> This frantic pushing of various features doesn't scale. It is requesting
> costly review time for multiple RFC series

I'm sorry for the confusion and the demands on your review time from
concurrently spreading my various Capsicum-like ideas across too many
threads. I can hereafter make things more single-threaded, as I'll
propose below. I hope that helps.

Just so we are all on the same page, at the moment I believe I have
created two RFC discussion threads, and submitted one RFC patch series:

- discussion thread: [RFC] Null Namespaces
  URL: https://lore.kernel.org/all/a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com/
  Current status:
    - You (Christian) are writing nullfs/failfs FDs.
    - I am submitting nothing else (e.g. the actual null namespaces)
      until that is done.

- discussion thread: [RFC] connectat()/bindat() or an alternative design
  (this one)
  URL: https://lore.kernel.org/all/b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com/
  Current status: Working on one patch:
    - Patch Series: [RFC PATCH 0/3] coredump, net: fix layer violation
      with direct connection
      URL: https://lore.kernel.org/all/20260703073948.2541875-1-John.Ericson@Obsidian.Systems/
    - I am not submitting any UAPI changes until that is done.
  (Note: This thread had some code in the first message, but I never
  meant for that to be a formal submission, just a discussion aid, and
  the conversation moved on from that original design anyways.)

To make things maximally single-threaded, I could pause working on
"coredump, net: fix layer violation" (i.e. preparing a v2 based on what
you requested in your review) until you are done implementing
nullfs/failfs FDs. I am actually quite happy to do that if you want; I
should spend less time on the computer the next few days anyways, so the
timing is very good for that.

Either way, I can also henceforth not refer to yet-unwritten and
-unmerged patches like nullfs/failfs FDs in the motivation for other
things.

John

P.S. There is also my non-RFC bugfix series:

[PATCH net] af_unix: fix listen() succeeding on sockets in the wrong state
URL: https://lore.kernel.org/all/20260703081416.2583118-1-John.Ericson@Obsidian.Systems/

but I don't believe you were referring to that one, since I think
bugfixes are supposed to be submitted separately and immediately. Do
correct me if I am wrong.

