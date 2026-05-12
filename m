Return-Path: <netdev+bounces-287220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNU0AkJPA2r63gEAu9opvQ
	(envelope-from <netdev+bounces-287220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:03:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA95244B1
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1BE232C9F00
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAA83B1014;
	Tue, 12 May 2026 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7c/1dh8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6437C0E4
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599582; cv=none; b=PBkgolPozhPNyLPfIcpvkvVUHaqYSWR28F0iubyR9/9GtqfUNr6XOq+/vfvV+DWFjlptxAmwsizgP2a6JF1PMxaJKwZ9mWiOFq8bdBhdVZ3XnvewWHlew8oOxfWzfr4b4rmuw09wlhtM4XL6tmTUSrv6JxALLMqYtXjScunGhHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599582; c=relaxed/simple;
	bh=3ehGzWQU+70yJ090gNmtVgY/vTW8+hyf3dPW9XfAV20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4gEyLg9/DCfcnQKr3Uc0LxV5QHOsHasZqI1uNLECmQEDHn3gx7OdIjr3BVEjpfy5wYQmrU3M3dTJ5X655y65X4CXwDz5TNQgXWNmRXrItiS0VaBwUXsiXc6BHnNhhTxQDywBilMOZhQnpfgcgTwQAHsyjbD+QNeygodwLuNvTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7c/1dh8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778599579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BezmigH7O0BDcu4nsInGoCnXCKbTqdgiR1KEZtCHpzw=;
	b=C7c/1dh8rAbw2IV5X2+2jc4qUOdVSg42rLSBh4LDkZY89qgsLiurC5YTk6cek5NydqTK1F
	b1vgyMqRW+LtG1tA9dwxLQ0mMDEkfoHuRI+AdFccBmtZsYJ2gk3l7RasstdfwikPWjdZBp
	lnybVMKPb/vzm1M/lFQkldRcrpXtdCs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-EKKDH6_GPAqB1RF_TUAgig-1; Tue,
 12 May 2026 11:26:18 -0400
X-MC-Unique: EKKDH6_GPAqB1RF_TUAgig-1
X-Mimecast-MFC-AGG-ID: EKKDH6_GPAqB1RF_TUAgig_1778599574
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 506861956050;
	Tue, 12 May 2026 15:26:14 +0000 (UTC)
Received: from [10.44.50.38] (unknown [10.44.50.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBF2030001BB;
	Tue, 12 May 2026 15:26:12 +0000 (UTC)
Message-ID: <1dd6abde-cc43-43b2-aa39-5c51aafea783@redhat.com>
Date: Tue, 12 May 2026 17:26:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/2] dpll: monitor: add -t/--timestamp and
 --tshort options
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, stephen@networkplumber.org, vgrinber@redhat.com
References: <20260512135225.167158-1-poros@redhat.com>
 <20260512135225.167158-2-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260512135225.167158-2-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 91DA95244B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-287220-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 3:52 PM, Petr Oros wrote:
> Bring dpll monitor in line with the rest of iproute2 by allowing each
> received notification to be prefixed with a wall-clock timestamp.
> 
>    -t / --timestamp  emit a separate "Timestamp:" line before each event,
>                      using the default text form of print_timestamp()
>                      (matches ip / bridge / tc -t monitor)
>    --tshort          emit a compact ISO 8601 prefix
>                      "[YYYY-MM-DDTHH:MM:SS.uuuuuu]" inline instead
>                      (matches ip -ts monitor)
> 
> When combined with -j, the timestamp shows up as a "timestamp" /
> "timestamp_short" field on each notification object, the same way
> ip -j -t mptcp monitor integrates the helper.
> 
> The flag is parsed globally but only consulted from the monitor
> callback, so passing -t to non-monitor commands is a no-op.
> 
> --tshort has no short alias, so its long_options entry uses an
> identifier above the ASCII range (OPT_TSHORT = 256) following the
> iproute2 convention used in misc/ss.c, instead of consuming an
> ASCII letter that could later collide with a real short option.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   bash-completion/dpll |  8 ++++++--
>   dpll/dpll.c          | 21 +++++++++++++++++++--
>   man/man8/dpll.8      | 23 ++++++++++++++++++++++-
>   3 files changed, 47 insertions(+), 5 deletions(-)
> 

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


