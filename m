Return-Path: <netdev+bounces-254379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wORiIKlHemkp5AEAu9opvQ
	(envelope-from <netdev+bounces-254379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:30:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E41ECA6EDA
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6695303DAE5
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0276A332EAD;
	Wed, 28 Jan 2026 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FvvmNFLx"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23D322C73;
	Wed, 28 Jan 2026 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621281; cv=none; b=N07MCE6fqkLdQ1xgUoZ+dNvG/k0pAIil65FO7jOuu3OTN1Dth71zFeRpUtzbBwZSs5F7ZuYJAki+0nAjK9ydicLYaj1oPvl2splL0fysuQQiHLAQ8UhrJl1cOTUP3w3Kf+8CctK1PR2PdEtlc6XzDRpHCZP2JUCgse90rTnvsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621281; c=relaxed/simple;
	bh=hoQ7f8O0ifvxslF9leeAjp1rd/O058g0+Im1NYwp96k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bVvDcY+ukv7npIK37JYEJQLXYUr1VOowtCvUDHcf48AmlmdDZjZK9pxyYrOMrv1HZJaU1Bj4U8thSZIN6SQCitVGnUNcaUWNcLvCuHu3W6QazvfJUBm8lNf9HPI1Llwzc467VHtY5LpukcgZivxtBGcUwHmSqvf5MOglYSL6LTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FvvmNFLx; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7611940C89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1769621279; bh=9oqJ9si/9jKjG6XLNNme1EVuvBefXUOVtMWR2s7pbuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FvvmNFLxw5Ixj5K56aynw58anknAfhai2s7OzYhzSWz+WqCBGTcPjmRYlUU8Ur18G
	 RJbtmjQ/aPzgrX5oRxL1CQsunZTEoNLfXH0GZ7M1S+QjSVgifNiVDWYe4aCAEG+dgB
	 oAWhO03n415iJQ9OvoiMClOgu2EUrzvAP2c4ZKjzBjezPFP0Xnbq/k2X0wQsfEpOm+
	 hfCw2xwJilzVMBQhq7IIOiB7zJ9l/B2WDFXNBe4mgzGhoQp1T8XcL0CafkebwxmbaL
	 F55T2oCjglGqFPiei9xUqE+NK0BcPNAl+b/Pf8KPmTXfd11jJs9DUGAI7z8B6QG1q6
	 F5Fn+En/4i0lw==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7611940C89;
	Wed, 28 Jan 2026 17:27:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>, Stanislav
 Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v2 00/25] kernel-doc: make it parse new functions and
 structs
In-Reply-To: <cover.1769617841.git.mchehab+huawei@kernel.org>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
Date: Wed, 28 Jan 2026 10:27:58 -0700
Message-ID: <87ecn97ild.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[lwn.net,none];
	R_DKIM_ALLOW(-0.20)[lwn.net:s=20201203];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254379-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,davemloft.net,intel.com,iogearbox.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corbet@lwn.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lwn.net:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E41ECA6EDA
X-Rspamd-Action: no action

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> It is impressive how a single patch became a series with 25 ones ;-)

*sigh*

I will try to have a good look at these shortly.  It seems pretty clear
that this isn't 7.0 material at this point, though.

One thing that jumped at me:

> Ah, due to the complexity of NestedMatch, I opted to write
> some unit tests to verify that the logic there is correct.
> We can use it to add other border cases.
>
> Using it is as easy as running:
>
> 	$ tools/unittests/nested_match.py
>
> (I opted to create a separate directory for it, as this
> is not really documentation)

Do we really need another unit-testing setup in the kernel?  I can't say
I'm familiar enough with kunit to say whether it would work for
non-kernel code; have you looked and verified that it isn't suitable?

Thanks,

jon

