Return-Path: <netdev+bounces-254774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GE7BsFHe2mJDQIAu9opvQ
	(envelope-from <netdev+bounces-254774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:42:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85104AFBE3
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 379A63013D5B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81A338758E;
	Thu, 29 Jan 2026 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk75tIwO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42029C321
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769686969; cv=none; b=g/YlkHb39JtBzgeRNfpIVW/OyjZ/3iq/XSWG8iern6+Gqqx3IXEP9KZOq2mujfHcoPXx+YiRoOiMNXT9J1ocr3Opsr7ERHt0MdopML0Kgr8ipnvJLWIT7XAE+q+4xYzE4WC8AsoM7Ohc19nWV0ZOl+CKCMruz+6hOi7HHQSMAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769686969; c=relaxed/simple;
	bh=cDsjTr8NOREyb3V2IZ6tssmVIts4YV/0OJr1fofp29A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1BZo5SeXmE4N1c2mZ3ex42zskih9YdY3pVuf13eJmvjo5NVxDmjVMN8aiZ+22RzmwQvE/KaHgA4PThBTqCtvJGV5yhV9ciC2lQLWx9zMz8/+Jx1siIFHJTdM/21NDPu71/w3Sn2YBkq1vQjgK8FCWYXguAaqdQq55V878EetmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fk75tIwO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769686967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuJvB0A06H0Qpw3z6ds6etgT8LccOnx3FjYAUnXyGsU=;
	b=fk75tIwOSbooZ2+c9/RtEbe9coDXF/9HjOFX4GLUi5KqEjZfZZ9FoI+vmzTG9AFYCdPG8m
	U9P3cGCRdrzOYRdv6DU1KTfZd1sjmiLNdd/S3KAm+H0nL4k+Kggqz6GjFOzEbAN58O6q+6
	OFbVGrZ13XhgT3ZVWXXtv8teZ5fyXqE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-ZrZgCA76NOqyDa7RvcORBg-1; Thu,
 29 Jan 2026 06:42:44 -0500
X-MC-Unique: ZrZgCA76NOqyDa7RvcORBg-1
X-Mimecast-MFC-AGG-ID: ZrZgCA76NOqyDa7RvcORBg_1769686963
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AED561800365;
	Thu, 29 Jan 2026 11:42:42 +0000 (UTC)
Received: from [10.43.2.2] (unknown [10.43.2.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D17319560A2;
	Thu, 29 Jan 2026 11:42:40 +0000 (UTC)
Message-ID: <38eec798-d0f7-4923-8285-6d94569af150@redhat.com>
Date: Thu, 29 Jan 2026 12:42:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 net-next] dpll: add mode setting support
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, stephen@networkplumber.org, jiri@resnulli.us
References: <20260129112849.8796-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260129112849.8796-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254774-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85104AFBE3
X-Rspamd-Action: no action

On 1/29/26 12:28 PM, Petr Oros wrote:
> Add ability to set DPLL device operating mode (automatic/manual)
> through "dpll device set id ID mode MODE" command.
> 
> In automatic mode, the DPLL autonomously selects the best input
> source based on priority and quality. In manual mode, the input
> source must be explicitly configured.
> 
> The implementation adds dpll_mode_map for string-to-enum conversion,
> str_to_dpll_mode() and dpll_parse_mode() functions, and refactors
> dpll_mode_name() to use str_map_lookup_uint() for consistency.
> 
> Man page and bash completion updated accordingly.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   bash-completion/dpll |  6 ++++-
>   dpll/dpll.c          | 52 +++++++++++++++++++++++++++++++++++---------
>   man/man8/dpll.8      | 18 ++++++++++++++-
>   3 files changed, 64 insertions(+), 12 deletions(-)

Tested-by: Ivan Vecera <ivecera@redhat.com>


