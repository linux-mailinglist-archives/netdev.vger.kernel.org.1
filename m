Return-Path: <netdev+bounces-261055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCLRNBQ/n2laZgQAu9opvQ
	(envelope-from <netdev+bounces-261055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:27:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3081219C405
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F313D30804E5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59562ED872;
	Wed, 25 Feb 2026 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="BYctJZUy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F84B2DF6EA
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043816; cv=none; b=k5/wjUymKHALzw76PYuztbpoQr/gyhmZ2E7qn+TsFCNpY0VimojpNABWcXWtfSP+50SeVZplBoLufA/oreopOl6yZKYZ1pPgS6i0VrTGqNXcSh0rBtfwStnsugNKBSvTNTQp18gPsGGcJdVm70DstG5Q5i7PzWdpJ/YaKwIQgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043816; c=relaxed/simple;
	bh=0K3LKFnDvLjGWKrTbbUMIQkBc8xXSAG7fXip7GjvrwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qb/+NzhYkkkE663MBakCCMy5uCDBnHBYIydNYuHeR6mnoW0o3+OLw29AiyFS0EE8GTtQajtR3VsL4GOCCig6Fg011BIQ67CDXaJC751Njf63PU+y6n2E6g0TwqnSdSswhTax8MJpYOZY5jwMja0/skUjQ4t3KOOvY1pwRxRPCCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=BYctJZUy; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdc8bb60f5so700951eec.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772043814; x=1772648614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUXqNEsrT4CsEBjMs2pgaovA/4zhcTSAPVWmFZa4btM=;
        b=BYctJZUywCvPNhvTOPsAbvKmNLnwJr+wyyAmOk5X2DlGXp+/KfkrayOd2JF/NVtQXf
         j/cR/Rd0mCxeDf67Wrhw4+BTYg+vTvec1kPHk7oQv6XGDPjC2OR2yR+UWiohjWXiW8ze
         rxrfNLg2THFXgqxmL+tHHQfrzXs/yCrJZyIhbQrvANeYz2cyqehzGmFDv1V92FTrkIAp
         KFNmQcw0CijJWUyWZldMpOih13N22F5L8E94VOIOcP5rVCgrRYuPHl4MDFXMJkpqWIF0
         zw0OvNt813NyhfOloaUazNgvcej1cKuc097aMMm00wXRT7o//EzkhFcDiNDmxZcREr+O
         dqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772043814; x=1772648614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AUXqNEsrT4CsEBjMs2pgaovA/4zhcTSAPVWmFZa4btM=;
        b=O63YP805ex/LeiQxSQfzuR77oUToOTW/2wn4W81Gtr9SeHeZRi0kKxe0W7b+bE8x0+
         sSV1FLl4RWRLw4ccNO59/jcilWYtkoCQRqLjV1ZhJgYGOTF03mKiB4KQyIhAoVjLMvng
         TbwEo87xHeTBjZdcMbQXjBl6UIkLcGLvsBkRdjw1X+K68g2sA34L2kMDSNDBOzk8tEU/
         5VtzEpnv8MONwRfJynRx9azNLnzk9FS0r9MAeXaqvJFJdfIkFvYQ5EmtQYiYDQK1aBIj
         M7B6dcHLGpXyCpzVaZ7qS93604COB95YlNDK30wv/bl6QmI42Z6rTaBcvWwcYzwwcK9J
         bcUg==
X-Gm-Message-State: AOJu0YxYYSEzE8/3zOipJ+5ykGBWhkvdRkHHmd9H+MsyGZ9mNCrTl2Ea
	rQpSs9u7mVK2dYnLqdqgteuEVmAz8GgpLxbJWbccZWvyBLNq9jP+OvWeDDritBdsEDw=
X-Gm-Gg: ATEYQzwCo5d0PQe6J0yDDTzb8f/17kOqE3CV+Rp2TIwrIveUA22mcX9ywXj09mfs5X9
	kQJnZGy5z/OAXStV5cFROrbt/Ob51QpB33eRO8OhixBHgCWlMeKnpLF3qvMZIjoZOHMU0Z64cnU
	XWYmRjFkXBfMN/wNZQqfsClWfQTPCJifyn3YXf33nAYBq3o89X5mXM//TvtJsHQRYZ/SREPpZvx
	cpsHi5/9ZW8K+fndfiMRZE3QNPNYAW0UvyvOT4MrsV4aAeD9aY6E78I/6oVdO7cweNFThK8x6/R
	BMAv681u37T+rIenW9aNjXH5L66m7fk9gw/yXVoRYtoTo4yDRONLOG8ftVwIiHrHJ9+y3VkgIkq
	6h3w+cOy/q1tGKfpeRguOT869HU/aY8+eu5CPsTr4soLpBfAmr2smUtNH6gDIjfTkHU3nx4zrm9
	+JRvT7edUZykHDPiiiXOWI5I1TXC1FohmYwsQNbfQTGjYS1MGdYYE4w4g0/9MzLfGqIlZ+N/Gi4
	3w=
X-Received: by 2002:a05:7301:678e:b0:2b7:a27f:3a6a with SMTP id 5a478bee46e88-2bd7b9d9844mr6755759eec.4.1772043814353;
        Wed, 25 Feb 2026 10:23:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc37895sm9529700eec.33.2026.02.25.10.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:23:34 -0800 (PST)
Date: Wed, 25 Feb 2026 10:23:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Daniel Schulte <trilader@schroedingers-bit.net>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2-next] ss: Remove trailing whitespace when
 output is not a TTY
Message-ID: <20260225102331.6d09b8b9@phoenix.local>
In-Reply-To: <b0414a07-f26e-4795-a697-37fb32d05595@schroedingers-bit.net>
References: <b0414a07-f26e-4795-a697-37fb32d05595@schroedingers-bit.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-261055-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim,phoenix.local:mid]
X-Rspamd-Queue-Id: 3081219C405
X-Rspamd-Action: no action

On Wed, 18 Feb 2026 22:19:53 +0100
Daniel Schulte <trilader@schroedingers-bit.net> wrote:

> Sometimes a value in the last column might be very long.
> When grepping ss output the matched lines are also padded to the longest value.
> In some cases this can result in multiple lines of the terminal getting filled
> with spaces.
> 
> Don't print right padding in last visible column when ss can't determine the
> screen width.
> 
> Signed-off-by: Daniel Schulte <trilader@schroedingers-bit.net>

Patch makes sense, but will not apply because either your mail system
is corrupting the patch or you are using an out of date version.

Please fix and resubmit

