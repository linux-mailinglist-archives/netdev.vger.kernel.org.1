Return-Path: <netdev+bounces-277243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM7JB+SE2GnieQgAu9opvQ
	(envelope-from <netdev+bounces-277243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:04:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B393D235E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8936F301BA7D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCEE32F759;
	Fri, 10 Apr 2026 05:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y4WuR2jN"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C54A284690;
	Fri, 10 Apr 2026 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775797468; cv=none; b=Hk0Qj/WfNADfyzk0DB6HgFBepZNvvzlplYApiyk5sheclSpyjNRUBFbcwHe8Xxp+IoW7bL/ngNvmkLLgEmWw+G+ShlILKBmE2v/AQwfS9C5/zQCE3vNp6rz/WWl81NWKJjJ3z1SQrOpEZcFOZCSTvj7ushwzSTSRF+37+7TthfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775797468; c=relaxed/simple;
	bh=nI2y+gmhMd9L2l8Rp8X5IPN0SLWfRmr8q/4r9bbj3bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaLKqdKSq48knxh1l787sdz1blX1hBlxl3yUuRQlUVWE8J2BDMaA+kR73ROOv05OX7lAAjTER3yV8I7NU1yoMlG/aMyMIm1IK61WFgN1E3Z/dJDqTK9BkrlPq6WxVEnNd9sUH/4ooVyVbmSS97L8ym5MgaV1xfvF7HU8zvJjW0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Y4WuR2jN; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4fsPq413B3z9ybx;
	Fri, 10 Apr 2026 07:04:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775797456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwM5jD6bjXoC1na/Qg0ZOQmP0AfF5uQjq2HMYHm1vZw=;
	b=Y4WuR2jNaA3jkpHMESBElggzsazJkrFGNcRgDz1mn9RZGiNRkMTIf6I27n6oWlr0wqan0w
	E90lnzVO6eARy+yGHcTaA37INautuwFfj8q8JCAxZ0kQBYTWL8phEf1Pok4mBAQkPdfkTD
	4Qf9tGypM5NSkHOd79oebIrMNNABtINbEih0frSYr0sBdROELWC0k+kY3KRpqsGnD5bOcR
	hD2/SUwZFxrOkmyHqfY3lNV9q52wwR+u/HGvufC7Ev1jnzVX4le1EcPpaJteIrtS85lNkr
	84aTlywT8sq6LJNmb4woPiUCfNVCHoTbbfVG25n14nf68BBsd7rYP9Jhlbh/9g==
Message-ID: <f09008fa-631b-4668-a883-1b9969f93751@mailbox.org>
Date: Fri, 10 Apr 2026 13:04:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: netrom: fix lock order inversion in
 nr_add_node, nr_del_node and nr_dec_obs
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+6eb7834837cf6a8db75b@syzkaller.appspotmail.com
References: <20260406110643.82577-1-mashiro.chen@mailbox.org>
 <20260406114904.89088-1-mashiro.chen@mailbox.org>
 <20260409195436.3d021e7f@kernel.org>
Content-Language: en-US
From: Mashiro Chen <mashiro.chen@mailbox.org>
In-Reply-To: <20260409195436.3d021e7f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 223c067f0a06e7a1996
X-MBO-RS-META: zmkscbzbg8mcd7rib79sjqkjjxdtg1xa
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277243-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,6eb7834837cf6a8db75b];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:dkim,mailbox.org:mid]
X-Rspamd-Queue-Id: 65B393D235E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 Jakub Kicinski wrote:
 > Can we please merge nr_node_list_lock and nr_neigh_list_lock
 > into one instead?

This makes more sense, thanks for the suggestion.
I'll rework the patch to merge the two locks into one and
repost next week.

On 4/10/26 10:54, Jakub Kicinski wrote:
> On Mon,  6 Apr 2026 19:49:04 +0800 Mashiro Chen wrote:
>> nr_del_node() and nr_dec_obs() acquire nr_node_list_lock first, then
>> call nr_remove_neigh() which internally acquires nr_neigh_list_lock.
>> nr_add_node() acquires node_lock first, then calls nr_remove_neigh()
>> which acquires nr_neigh_list_lock.
> Can we please merge nr_node_list_lock and nr_neigh_list_lock
> into one instead?
>
> Lets try to simplify this code as much as possible.
> It's a maintenance nightmare and has fewer users than syzbot reports
> (i'm not joking).

