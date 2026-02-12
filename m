Return-Path: <netdev+bounces-258449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B4LAQnFjWnT6gAAu9opvQ
	(envelope-from <netdev+bounces-258449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 13:18:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7444612D5DC
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 13:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF4B130C5B82
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 12:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B8127E7EB;
	Thu, 12 Feb 2026 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWhlEHHY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="acorpGF4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0648E352FA6
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898611; cv=none; b=og3CG7HG6UE+Z/0KXx/5utB6piFVF9OR1kPxlOwsg8NS10l+3SLMalTUcq0vhhJk0RjNP7rovWQq7+cSUNQUwKq+iOX62pxNzjt0XWXUCcNh2zoG0yAOMC//Pgcb2TYbxqicYujLSuFMIn18cZ+lAcA88LmoldL0D4kjMegzRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898611; c=relaxed/simple;
	bh=JWljiblHKdW/kvLi+oANTy8OmaENQH4T3UWSJZWjvFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USi4QB73PAKSsqwgK/ZzeLaKkWe+rl2HZImasfOlBfDZOVEb1kT/7+EWUnGbYWvrS6uvsqbeRua4Ds5qZxK3hHwxkhn+oSNGxedBTi2Zvr+4IP5ebGld1JYKBofXKcRvRMmxHnRERhJFkD2J3CHIiLDaWVQFCWXJttknsVmmM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWhlEHHY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=acorpGF4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770898608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ASZtwC4Jr2vY7rfr/wbGtVzwGSZEjBKWQrjrryCwDs=;
	b=WWhlEHHYsQd2uGpaphuso2Uq/TXqlaElEqbTOJiwqSy7JEmPnVSIU5SDWSwBZshcjr6ECg
	WoWMRiL3s84ViaqxKtdHD37rbpKJYTSZG8inQ6Ej5/TQ2oP893vdNLSOcRgCDp8p9zIJKH
	YZNCfiC7HBhlH6MZPN36jUr3dUqqsvk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-25Cmg7j2MOyckvxNJRa0iQ-1; Thu, 12 Feb 2026 07:16:45 -0500
X-MC-Unique: 25Cmg7j2MOyckvxNJRa0iQ-1
X-Mimecast-MFC-AGG-ID: 25Cmg7j2MOyckvxNJRa0iQ_1770898604
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48336b182ebso36496875e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 04:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770898604; x=1771503404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ASZtwC4Jr2vY7rfr/wbGtVzwGSZEjBKWQrjrryCwDs=;
        b=acorpGF4kFx8o5/6t6OW4yUJji1mF9Tl9Vmid/46M0+rLwid8Ej469iqO3ijuBwdwK
         I4KdrQyydVq8GvDiKUTj/XYffmtfMj5IgtbtwNLi5+snAprHLtZhaE4loJqrhN9tMN+K
         Mf/bZT2uZi+RcyNmLR1BrMSqnRuj5OqN3QX5UVE/pe9IW3QMG9UtZX7SIg5t6S7HoQph
         VGRoaxwJrGRng4hKiJxEkkCpGUAloNRL1d7sY5g428MD3lIXiquXKGFqQP3RjQcO2Xwn
         AOVR9+xbQj5Nt+XEeqT8PoaWWG1Aric8NtLcOpU3nIFInH5jJ2K87qOPMEp3AabuU/wu
         LteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770898604; x=1771503404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ASZtwC4Jr2vY7rfr/wbGtVzwGSZEjBKWQrjrryCwDs=;
        b=RVur/MeagMB/KSgcWwi7O3TNruu4ULUTm4gGh08AfyxssNg5FWADfwwkZpYUoe2uzO
         8tWZm4lKUPEFQaLiYmeD9plDzDOezMs5mnAlouxisrNw3t3s+u5aAGZq6GPnTwu6EN3B
         qek2a69m9t55Mv5D513yAwmWqSy1iDtSDnx2PgyrvcTZEpVeHQr97ce4RLHEZHFpCvsn
         GDqr/teoZpKLfSIxJZirZUZZyb21nabTmYUm/XnW9Vjp+eGiIT2ffLdK8aqGT8BXNmW/
         m8U5MeF44no0+OmuFNXudadhy1WcTofryShz4eKHoa9n4MATFGcT1v3coj6jHQ0CmV9E
         Ei5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyh3Z2qQGdQ/q9xzeFSqaldgWuwZFUeae1hmH6oLRDMn4SADjxAyppfa4J3wmdgnFglT6wRk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0a6/8Ci+gcFHdidQi3S3lN5xY6oi77tDoj/tgMuR+mXU6a2ss
	0XQ1IUzpCe1IZpmCeN4+txGTUhzsQ8nYoJAq92zbJFAMMmJ6I93ynllHUolQyelJw54NSrS4Z1A
	KBT/8quuPaXKkQComMFqymD4uYvCbpw6xWtVldwHslvOstWemFBug5J2mrQ==
X-Gm-Gg: AZuq6aLZT6qjz9fbW7NShrR5b76wt2EYxkYXxLl21RlD35pmAPHM72dDJsY7LqG+GNh
	HLtmNhUibWx9KQwKmA70FxzLLCbXgNkdeuD9q85bg/cOtNWzdDfJSFT+qiPvMWypI8MdagJBkoy
	h+ehY+bdsRG14MbyuERA4JX/kOMjbbGNaUiS4WcF+j94piWlFVH5VHQkMLtZXO+S0SxqAti7UMG
	lROoqIJzLTwMEQQrSo2QnqxI/3sLEd4MFjEGyqdLZ7/3mk823tVGz0yUuNOQfVmTZRFuqNls7xk
	o4sUH8K76BL8cLH2mhxpcZJWK7u54yLKdds6xbUQU1ylcvi/MTe+M1Zl1Ux9VLeTRuFZrZgD7nt
	7lgdL76D+M2mSlzExdZxlwJ59Tg==
X-Received: by 2002:a05:600c:3b12:b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-483670fac23mr28141725e9.3.1770898604172;
        Thu, 12 Feb 2026 04:16:44 -0800 (PST)
X-Received: by 2002:a05:600c:3b12:b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-483670fac23mr28141325e9.3.1770898603714;
        Thu, 12 Feb 2026 04:16:43 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4afsm365332535e9.11.2026.02.12.04.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 04:16:43 -0800 (PST)
Message-ID: <e52a10e2-b208-460c-a3e3-305b91433531@redhat.com>
Date: Thu, 12 Feb 2026 13:16:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/4] net/rds: RDS-TCP reconnect and fanout
 improvements
To: Allison Henderson <achender@kernel.org>, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, edumazet@google.com,
 rds-devel@oss.oracle.com, kuba@kernel.org, horms@kernel.org,
 linux-rdma@vger.kernel.org, allison.henderson@oracle.com
References: <20260212053230.1921241-1-achender@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260212053230.1921241-1-achender@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-258449-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7444612D5DC
X-Rspamd-Action: no action

On 2/12/26 6:32 AM, Allison Henderson wrote:
> This is subset 4 of the larger RDS-TCP patch series I posted last
> Oct.  The greater series aims to correct multiple rds-tcp issues that
> can cause dropped or out of sequence messages.  I've broken it down into
> smaller sets to make reviews more manageable.
> 
> In this set, we address some reconnect issues occurring during connection
> teardowns, and also move connection fanout operations to a background
> worker.
> 
> The entire set can be viewed in the rfc here:
> https://lore.kernel.org/netdev/20251022191715.157755-1-achender@kernel.org/
> 
> Questions, comments, flames appreciated!

I think you could resubmit the first patch for net after that Linus pull
the currently pending MR.

---
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.0,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 23rd.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


