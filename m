Return-Path: <netdev+bounces-273923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNDyCcrIzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:27:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 828FA375D8C
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BF3A3014BDC
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DA737C0E5;
	Wed,  1 Apr 2026 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e+qwnt+z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pKZwkYTx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QVSzu0Yd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aIX+tDKX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47D037A486
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027920; cv=none; b=drPHpv03qJAMH9zghbEwZzcdTFK/2y4NNFaybRmzXK7Q0GbaXrjOF2oGpxby+jiHdT37LFryw+zodpH6EI1cBJuxy6DqqfhK199CnSvn/Rm0BkLYGrZvyul09yOi8HwobpoIvkVOSk2payf7jNynDPOgZd+HMvTxBk9+paP6aJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027920; c=relaxed/simple;
	bh=tVOS7i/nHLfacjVaTWwKaXLSmoXCdov9NMuZcBPiDa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kw1fA0a+9jR7nUnuN4bKBCdfWsPnYZW2pvfsNYVK9bKU8emeiOwWZQaqHFL/W27oyt1IOkxnzhnxVmWUHi0R1RcYPhDrM370nWwZ+QjSV7VAR8+nZ3xvKv6O3K2GPuPVp1vNBo0//CghPPe26lsMFLMxcJMoAGMdMEq0H158poU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e+qwnt+z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pKZwkYTx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QVSzu0Yd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aIX+tDKX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E60D94D1E6;
	Wed,  1 Apr 2026 07:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775027917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbPHL+J1WQJzc1o2RqFCAMRlwN3NHaEC+8hh/RIi04g=;
	b=e+qwnt+zZJJ7OHmsPdquDV7MFxu4hmx0C1+caCRt4MlnFgUO1Cl0IclK6N9f16o/zf9tlk
	Cieh9SDqjVmc+Kt5ZsjXdj+8vmnaEUsECC/SBE9CvdDMwum3NJr44X/PBSN/65bhtl8TcV
	mkzaAQ2BI+DzdwE5MGi6UUNCoC+t8M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775027917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbPHL+J1WQJzc1o2RqFCAMRlwN3NHaEC+8hh/RIi04g=;
	b=pKZwkYTxlEcQdx7SeV9Pp2lOf0oHC1VFMtTtJYMTzESPWh8cVg17X95jctIDLwMOw4OckT
	ORxojIKY4RWJ3EDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QVSzu0Yd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aIX+tDKX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775027916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbPHL+J1WQJzc1o2RqFCAMRlwN3NHaEC+8hh/RIi04g=;
	b=QVSzu0YdkLMEdkrYMAk3wvbbOFGXugc9mdzVD3XU7UDgmYG3qhd5k+qkfGP3WSFzeAmp3T
	Xns2eZxKMAf+6QbfbILRwicbiQYbKoyiCKcpGeXYFm/P2g2iyB+gBPY0wQOOx7faSONneb
	/HIdRWDpyIoSijcqC0cRik04u+lEMzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775027916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbPHL+J1WQJzc1o2RqFCAMRlwN3NHaEC+8hh/RIi04g=;
	b=aIX+tDKX74LL0+ugLTSgxTqC8e+sGTa9EceNz52JMb9LH3QbEutpiDlwMoU3jwqDLGJDg6
	LjlP6xJQtL0WHjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D8E64A0B0;
	Wed,  1 Apr 2026 07:18:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LSmTF8zGzGmbPQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 01 Apr 2026 07:18:36 +0000
Message-ID: <877d2e1f-77d4-4f61-959b-903340e6026e@suse.de>
Date: Wed, 1 Apr 2026 09:18:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: nexthop: allocate skb dynamically in
 rtm_get_nexthop()
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 Yiming Qian <yimingqian591@gmail.com>
References: <20260331115943.10404-1-fmancera@suse.de>
 <20260331103538.103e3778@kernel.org>
 <3025cc67-ddbf-43f6-a313-602193979ace@suse.de>
 <20260331154154.317437c4@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260331154154.317437c4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273923-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 828FA375D8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/26 12:41 AM, Jakub Kicinski wrote:
> On Tue, 31 Mar 2026 19:40:38 +0200 Fernando Fernandez Mancera wrote:
>> thanks for sharing. As I replied to Eric this is the main reason why a
>> V2 is needed. There is also another bug I discovered while fixing this.
>> When dumping the stats NHA_HW_STATS_ENABLE is being included twice per
>> group. I am fixing that in another patch that will be included on the V2
>> series.
> 
> If you remember -- please try to slap a pw-bot: cr on your own reply
> when you notice that a follow up is needed, especially if the patch
> is breaking selftests. We still lack automation to attribute failures
> and bad changes get stuck in the testing branch :(

Oh sure. Will do next time. Thanks Jakub!

