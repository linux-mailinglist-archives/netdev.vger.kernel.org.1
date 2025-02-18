Return-Path: <netdev+bounces-167333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAFFA39D27
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68E03A4E82
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA0714B08E;
	Tue, 18 Feb 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LCUZT5+w";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LCUZT5+w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46D2417CF
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884271; cv=none; b=iOEcYi5okqZ6/Zmi/2wEFRB5N7GsUE4EHcU62pl1DxnoxSvHa9/p21ab3LBo9RqnltEoCU84ZM1LhrlF9pH1zzSJ9WAm5RwXqelPnFKJQlotUdo80mm5m/6rhzwzQ2UNmCBfToVP0fzJqNr7L+9cXczCHAgOTz4QdQWkVZe/lqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884271; c=relaxed/simple;
	bh=EW/xXWd85/l55A2g+WlVndeHmYBZUu45j5AUXdU84Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTD02Lj3Endm2BHx18/GpHMx6TBFGTKdx9zPQDyZc9gAcEhVKUg2e6xaZaWQNz7I45F9Ve55p/u8R0kJPO6CKdzrVIxW9x7FulFgViG5+I2A4Y7sTPgGnWm3FxLovSuNcvD/AItg7yU4MP1xFrUDKJuJMXtWpEiXQvK1XuEd0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LCUZT5+w; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LCUZT5+w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 850402116B;
	Tue, 18 Feb 2025 13:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739884267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDk74hVZj2fSSFjAp11DwD92ZHzXKT2sSBuSO59C/4I=;
	b=LCUZT5+wyh12nZtVTJGQXk1aYWA1dCsNCs+fQqW3ZZ92QHSxfubAAELLOWyIW95z5tvtll
	jEzd7ZmPA6AKyaHWRm+d9q72sMS+RTgjFB6A43K4v6JG5/5py8VeMSalyWR48k9lZ14c8c
	dCRT3Gp1YkvQ9Box+TQo5jEoDUTsUw8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LCUZT5+w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739884267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDk74hVZj2fSSFjAp11DwD92ZHzXKT2sSBuSO59C/4I=;
	b=LCUZT5+wyh12nZtVTJGQXk1aYWA1dCsNCs+fQqW3ZZ92QHSxfubAAELLOWyIW95z5tvtll
	jEzd7ZmPA6AKyaHWRm+d9q72sMS+RTgjFB6A43K4v6JG5/5py8VeMSalyWR48k9lZ14c8c
	dCRT3Gp1YkvQ9Box+TQo5jEoDUTsUw8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CC7413A1D;
	Tue, 18 Feb 2025 13:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kc9xD+uGtGebRQAAD6G6ig
	(envelope-from <davide.benini@suse.com>); Tue, 18 Feb 2025 13:11:07 +0000
Message-ID: <1818b3c8-b952-4dba-8b46-a3175adaeb8e@suse.com>
Date: Tue, 18 Feb 2025 14:11:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ss: Tone down cgroup path resolution
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, netdev@vger.kernel.org
Cc: mkubecek@suse.cz
References: <20250210141103.44270-1-mkoutny@suse.com>
Content-Language: en-US, it
From: Davide Benini <davide.benini@suse.com>
In-Reply-To: <20250210141103.44270-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 850402116B
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO



On 10/02/25 15:11, Michal Koutný wrote:
> Sockets and cgroups have different lifetimes (e.g. fd passing between
> cgroups) so obtaining a cgroup id to a removed cgroup dir is not an
> error. Furthermore, the message is printed for each such a socket.
> Improve user experience by silencing these specific errors.

Note that if ss has been called with -e (to show detailed socket information) or with --cgroup (to show cgroup information), even if the message "Failed to open cgroup2 by ID" will no longer appear, however the cg_id_to_path() will return a string "unreachable:%llx" and the output will still be similar to

tcp	LISTEN	0	4096	[::]:2049	[::]:*	ino:710321	sk:10da	cgroup:unreachable:8ed7	v6only:1 <->

But I agree that removing the specific error message would be enough to prevent customer concern.

Davide Benini



