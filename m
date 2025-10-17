Return-Path: <netdev+bounces-230432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B87D2BE808F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 12:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 848C45676E1
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 10:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156F330F80F;
	Fri, 17 Oct 2025 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ayCSq4Eg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/JU05BQm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ayCSq4Eg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/JU05BQm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A02D543A
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696253; cv=none; b=upKWGWNXyQ/01C+Mu3PEH/YBtP10h1v/5kfJyWFBOTaXdMM9M5RnuTl73PjTE+SxVld10Exf5VAD/gkp3l89roDxjpcjFYuIh2dryq9eI5FgI2RvejA/3kPUWD3HeSL3ouwQKAlhj89pJGP5+Cn67jr/PgGWvpDgTxpMZA/3Pes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696253; c=relaxed/simple;
	bh=1QLU/gVVgYDO8JWw4ge7c5jK05jF3XWennbUt0+E7Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dR2aKjuOxmDh1mZQk+UiVrmeM/CxD+Dlsmkw8ZOLh06u9za8koQJQjG2WEuZEHvTxTIzX2IHzcEE7C6RuCFiwvVkgy1p/e4naGqqZPPC9m1JZjkOiJR3loD4YUQp2e4UpTNyf+9g86lM9aDf+QIr6fIv3KdeoTqnFHf9fBWapBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ayCSq4Eg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/JU05BQm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ayCSq4Eg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/JU05BQm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7EA8921CDB;
	Fri, 17 Oct 2025 10:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760696249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x28IZ01xRWN9EmhKGWtiepea9Jiz+TrC/Yq2xTTPlMw=;
	b=ayCSq4EgWGymcuLjQ4RxcaFdHokUyxFH1/bOmjo0xX2QGbLSxEi5qOj0hEc216aKFPrh8P
	ExrZuMWzGr860NG/imznoc9VdMcpp7hp5BTaqrSxikkNftTzgmyL2arA7nDk8pioo5qalV
	Ub/UNT14/yeWJ3YfhEJVKU8dYRnrJAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760696249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x28IZ01xRWN9EmhKGWtiepea9Jiz+TrC/Yq2xTTPlMw=;
	b=/JU05BQmGHctXQTf2OaJ/0oMnAlx1suG7kwEOvReciVa2VobXC9aFMiRIxc2VrBeBE/8IO
	xltPIncwP+uXgYCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760696249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x28IZ01xRWN9EmhKGWtiepea9Jiz+TrC/Yq2xTTPlMw=;
	b=ayCSq4EgWGymcuLjQ4RxcaFdHokUyxFH1/bOmjo0xX2QGbLSxEi5qOj0hEc216aKFPrh8P
	ExrZuMWzGr860NG/imznoc9VdMcpp7hp5BTaqrSxikkNftTzgmyL2arA7nDk8pioo5qalV
	Ub/UNT14/yeWJ3YfhEJVKU8dYRnrJAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760696249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x28IZ01xRWN9EmhKGWtiepea9Jiz+TrC/Yq2xTTPlMw=;
	b=/JU05BQmGHctXQTf2OaJ/0oMnAlx1suG7kwEOvReciVa2VobXC9aFMiRIxc2VrBeBE/8IO
	xltPIncwP+uXgYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 116C4136C6;
	Fri, 17 Oct 2025 10:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nVwhAbkX8mhYXwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 17 Oct 2025 10:17:29 +0000
Message-ID: <6f9742f5-8889-449d-8354-572d2f8a711b@suse.de>
Date: Fri, 17 Oct 2025 12:17:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/hsr: add interlink to fill_info output
To: Jakub Kicinski <kuba@kernel.org>, Jan Vaclav <jvaclav@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20251015101001.25670-2-jvaclav@redhat.com>
 <20251016155731.47569d75@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20251016155731.47569d75@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 



On 10/17/25 12:57 AM, Jakub Kicinski wrote:
> On Wed, 15 Oct 2025 12:10:02 +0200 Jan Vaclav wrote:
>> Currently, it is possible to configure the interlink port, but no
>> way to read it back from userspace.
>> 
>> Add it to the output of hsr_fill_info(), so it can be read from
>> userspace, for example:
>> 
>> $ ip -d link show hsr0 12: hsr0: <BROADCAST,MULTICAST> mtu ... ... 
>> hsr slave1 veth0 slave2 veth1 interlink veth2 ...
> 
> Not entirely cleat at a glance how this driver deals with the slaves
> or interlink being in a different netns, but I guess that's a pre-
> existing problem..
> 

FTR, I just did a quick round of testing and it handles it correctly. 
When moving a port to a different netns it notifies NETDEV_UNREGISTER - 
net/hsr/hsr_main.c handles the notification removing the port from the 
list. If the port list is empty, removes the hsr link.

All good or at least as I would expect.

Thanks,
Fernando.

