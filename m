Return-Path: <netdev+bounces-287956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKlUA5bGBWrDbAIAu9opvQ
	(envelope-from <netdev+bounces-287956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:56:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D198542020
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB2B5305727E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5484393DDA;
	Thu, 14 May 2026 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bcHCl4ex";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LQQVWzrv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bcHCl4ex";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LQQVWzrv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65970212550
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763355; cv=none; b=rE3fYk/9GztsqXfKj7wntZwdhD6YpfCLCsqbjy8vRtP57IZAWM4nH5Uhg9KKoBJXiSuWGoSaf/ZDi0FcfHWbX50HaAOYXUT/V1SkKJa6/svVcdhHY2dBWZlum67oi8C7b/KH4PUx9HC/Vl/KX+zT/vAEZj7+fkphQNrAW6BGN9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763355; c=relaxed/simple;
	bh=7MO+viv0Drmea5H6MB7PQANdLGtoGY5gKTupsWDC7T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2DNkKFewY1kkBxsgaAnHVSZ4EgCNNLUqouPtb7DFt+9t6qTXw4iVvsmmOQ8D+xlud05ACPbT7rnWn8ns2aKPPUZ0GubKdip9iZWK1xwgBIz3aLUN7h4hIM885UX4mvkYtgKYMtUqk71OHAktILP1QNp06jgK8AZSuJQOGVsyQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bcHCl4ex; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LQQVWzrv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bcHCl4ex; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LQQVWzrv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69BB75E602;
	Thu, 14 May 2026 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778763352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfVFNZb3El+hrHtQNU1Y6JLVk6/Ck4WJss/xNizlNlA=;
	b=bcHCl4exCtlfVlNRp78GBAHMYl5f+jeLIAndkssvHhgd2axPxnM7jDmAIPHuhgie58z+n+
	X+Hl9zLfzdJBEWBWCnlenUyedl2bXxfDI/qz5qJMKlWC8NZ91JAJEJueP8KoiV4zsLmHTt
	dEgnmmLNVsgaZAM+aT3tB1xAiTshtRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778763352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfVFNZb3El+hrHtQNU1Y6JLVk6/Ck4WJss/xNizlNlA=;
	b=LQQVWzrv6+wK5YepUb4BkPvQy3GAq1AweRsNmGbw0zzTYgUj0vADYTjuK+nQUU1iEJRvYi
	4RVXNTLrzqwTRcBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bcHCl4ex;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LQQVWzrv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778763352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfVFNZb3El+hrHtQNU1Y6JLVk6/Ck4WJss/xNizlNlA=;
	b=bcHCl4exCtlfVlNRp78GBAHMYl5f+jeLIAndkssvHhgd2axPxnM7jDmAIPHuhgie58z+n+
	X+Hl9zLfzdJBEWBWCnlenUyedl2bXxfDI/qz5qJMKlWC8NZ91JAJEJueP8KoiV4zsLmHTt
	dEgnmmLNVsgaZAM+aT3tB1xAiTshtRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778763352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfVFNZb3El+hrHtQNU1Y6JLVk6/Ck4WJss/xNizlNlA=;
	b=LQQVWzrv6+wK5YepUb4BkPvQy3GAq1AweRsNmGbw0zzTYgUj0vADYTjuK+nQUU1iEJRvYi
	4RVXNTLrzqwTRcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3F4F593A9;
	Thu, 14 May 2026 12:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 80lWOFfGBWo+UAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 14 May 2026 12:55:51 +0000
Message-ID: <af0ed1c9-bbdf-453c-b9b9-f2e0d04cef2b@suse.de>
Date: Thu, 14 May 2026 14:55:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net: hsr: reject unresolved interlink
 ifindex
To: luka.gejak@linux.dev, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, fmaurer@redhat.com
References: <20260513182657.20346-1-luka.gejak@linux.dev>
 <20260513182657.20346-3-luka.gejak@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260513182657.20346-3-luka.gejak@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 7D198542020
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_FROM(0.00)[bounces-287956-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action

On 5/13/26 8:26 PM, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> In hsr_newlink(), a provided but invalid IFLA_HSR_INTERLINK attribute
> was silently ignored if __dev_get_by_index() returned NULL. This leads
> to incorrect RedBox topology creation without notifying the user.
> 
> Fix this by returning -EINVAL and an extack message when the
> interlink attribute is present but cannot be resolved.
> 
> Assisted-by: Gemini:Gemini-3.1-flash
> Reviewed-by: Felix Maurer <fmaurer@redhat.com>
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

