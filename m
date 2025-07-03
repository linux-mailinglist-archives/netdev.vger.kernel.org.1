Return-Path: <netdev+bounces-203662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB06AF6B1E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1D91C21816
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37C72951DD;
	Thu,  3 Jul 2025 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g6nG4ymr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ORXemz07";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g6nG4ymr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ORXemz07"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C995291C24
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751526610; cv=none; b=WR/pQn4UlA1OPBYHSmx0fsLlj28rto/TJr1MUvOoeEhp6HYPvTBlaAgEa/JSNqUwGqv7EaBcbyyxRR25yXUrAZd9ei2/2cFFeo07bLstykX+6bDTU9TLYyWF8krJ12R9XrF1XdcGkW648i45qM/W+cwGyt5DFlyfzl/0f3Ke3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751526610; c=relaxed/simple;
	bh=5NvsSIVafDB968rU4vhGrFIy7dGzQ8AqKS9TK7HWs1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syEwjtsSmZPuzaBG1aBgEJ89XW8YWG/SIa5V4WgaVpkocisTrWIfskYpL13rttI69mYZBvx3jqbyyoemsNqlBpSTtQxwoxsjf3Z+Av6WDwmCqHdI7ia292haNVbU2c1YryIIs1YdZtLmBiCdk2sU4LeARa2rkZ3P47IaQplfhTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g6nG4ymr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ORXemz07; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g6nG4ymr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ORXemz07; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6522721193;
	Thu,  3 Jul 2025 07:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751526607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVXU/KxQ8SQbqZWG1jOnIHKSU0KxbNAJe7kDw3fb264=;
	b=g6nG4ymrO9MqatJz4EgAGDKix1U34XNPivS/D2V3/T6jKWTXxgfhTXVWngzuu3kCIv46Wb
	BBM7/9Ii4xEdIg/afRj6dQDaM2PJk646Z5ATBPOmGh33ducGjG4yrg7/2nzeqqf1Ccbzv9
	KfQGD/7Q9ZO4jvzRNQnPsRlgQRnKRMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751526607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVXU/KxQ8SQbqZWG1jOnIHKSU0KxbNAJe7kDw3fb264=;
	b=ORXemz074CMraXIdsTZOh6bY/PN/WEG7QP0pnw0lu7+vQD7+WRnP/QJRtKif6tch7HyNrr
	E8Hutg11tCMdZ3Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751526607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVXU/KxQ8SQbqZWG1jOnIHKSU0KxbNAJe7kDw3fb264=;
	b=g6nG4ymrO9MqatJz4EgAGDKix1U34XNPivS/D2V3/T6jKWTXxgfhTXVWngzuu3kCIv46Wb
	BBM7/9Ii4xEdIg/afRj6dQDaM2PJk646Z5ATBPOmGh33ducGjG4yrg7/2nzeqqf1Ccbzv9
	KfQGD/7Q9ZO4jvzRNQnPsRlgQRnKRMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751526607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVXU/KxQ8SQbqZWG1jOnIHKSU0KxbNAJe7kDw3fb264=;
	b=ORXemz074CMraXIdsTZOh6bY/PN/WEG7QP0pnw0lu7+vQD7+WRnP/QJRtKif6tch7HyNrr
	E8Hutg11tCMdZ3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31BBF13721;
	Thu,  3 Jul 2025 07:10:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VfE8Cs8sZmhtVQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 03 Jul 2025 07:10:07 +0000
Message-ID: <5c465fcd-9283-4eca-aef4-2f06226629a3@suse.de>
Date: Thu, 3 Jul 2025 09:10:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/handshake: Add new parameter
 'HANDSHAKE_A_ACCEPT_KEYRING'
To: Jakub Kicinski <kuba@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
References: <20250701144657.104401-1-hare@kernel.org>
 <20250702135906.1fed794e@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250702135906.1fed794e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Level: 

On 7/2/25 22:59, Jakub Kicinski wrote:
> On Tue,  1 Jul 2025 16:46:57 +0200 Hannes Reinecke wrote:
>> Add a new netlink parameter 'HANDSHAKE_A_ACCEPT_KEYRING' to provide
>> the serial number of the keyring to use.
> 
> I presume you may have some dependent work for other trees?
> If yes - could you pop this on a branch off an -rc tag so
> that multiple trees can merge? Or do you want us to ack
> and route it via different tree directly?
> 
> Acked-by:  Jakub Kicinski <kuba@kernel.org>
> 
We are good from the NVMe side; we already set the 'keyring'
parameter in the handshake arguments, but only found out now
that we never actually pass this argument over to userspace...
But maybe the NFS folks have addiional patches queued.
Chuck?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

