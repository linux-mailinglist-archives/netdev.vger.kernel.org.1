Return-Path: <netdev+bounces-260078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAQQOSxunGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:11:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3551D178880
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E5683029AD2
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D2B366060;
	Mon, 23 Feb 2026 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pmyRjEdO"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41719361DB2;
	Mon, 23 Feb 2026 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859256; cv=none; b=JnbHaTV9YmljZeU/VTJnHdXHZOdA7/61qMyl7O3LzEoMDq455U8axtyvXLaqphEArUx2qVkcc8v5DwTBj7jjioG1oe99Uho2uRsRmmas/f/h2CaZufBX1o2AAH0p7tersxQjS0b3n2d5c/PJmZk4haYH3UpePDcbMxgeRqYX+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859256; c=relaxed/simple;
	bh=6ZP8MgbtGH5MobBoC2FmXVMgOF3DCo3R40gaWjqdmuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JD6WBu/PHULf0vbZKHSGIFoAzRugZaH3vM8tz+VDlNXgXvAyiAsxsOC5Ite4Jg+JW/buf8QsQdQT+x1m+e0i0vLYk/RxS1oOTnqHn8mDnr04h+7pqlAi0DsQhMuOIQ2HhM3YBl2GTd5ypWCi0uxJpeizT0UwyEbluspZdVA5HyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pmyRjEdO; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 36B9640C6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1771858932; bh=uNGo1sx9Ki+w096sWaEIkC6IKo4fwwadEMyWfut8oEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pmyRjEdODIjeAipqFcXYuUUMrCqulImfJMdvpChSX4o/WEBWx/D9iIlWRpC28MpMR
	 qVDCmq+hq0AkV08Ab8WKXCSn3jVSTe44fDZpyszr6qmMY8FVvxyKZSG4VIFau2YsLd
	 6HmQreBiYMLctEplPjUNpkQHDtzx90LkD1LwYV6ym6ZGVr2QfWgD8ASD79pfZpssJm
	 6jsdZ7c9cQC8TcmBk0h3GmT35iZy0vd2tpZL0AmNvmaqMWI1Q7BnfoIBzCZR5JfsDI
	 1+Hnuvb8/6/Nn5MLCnkYX2noN97MOig+H33SStCdhDKoh1Zib9BjIAcfdAoKMAPONc
	 fVwEGo2bWGoog==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 36B9640C6F;
	Mon, 23 Feb 2026 15:02:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jani Nikula <jani.nikula@linux.intel.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kees
 Cook <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 00/38] docs: several improvements to kernel-doc
In-Reply-To: <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
 <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
Date: Mon, 23 Feb 2026 08:02:11 -0700
Message-ID: <878qcj8pvw.fsf@trenco.lwn.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260078-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lwn.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corbet@lwn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,trenco.lwn.net:mid,lwn.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3551D178880
X-Rspamd-Action: no action

Jani Nikula <jani.nikula@linux.intel.com> writes:

> There's always the question, if you're putting a lot of effort into
> making kernel-doc closer to an actual C parser, why not put all that
> effort into using and adapting to, you know, an actual C parser?

Not speaking to the current effort but ... in the past, when I have
contemplated this (using, say, tree-sitter), the real problem is that
those parsers simply strip out the comments.  Kerneldoc without comments
... doesn't work very well.  If there were a parser without those
problems, and which could be made to do the right thing with all of our
weird macro usage, it would certainly be worth considering.

jon

