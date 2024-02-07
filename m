Return-Path: <netdev+bounces-69669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47DE84C1D7
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105B1B21C5C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 01:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DAF5C83;
	Wed,  7 Feb 2024 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="siR675Sv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aFqrzLLA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="siR675Sv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aFqrzLLA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19139D268
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268915; cv=none; b=EHWLjhDUgq4YcoBkXJNVn9CLSM6sqrJVEYPy9AmLDYymh+/m8lwv7ApDOfxzsoWM00L5t5iUzsFPmt2eN0yWPmtUbEtennKUTMPfN2y/eOXaFFMu3vJTmk+ImP0HDRrkv6W1CqdrRa99Q6NoXiRK5E6nAYr/REQGwYKAMUnKzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268915; c=relaxed/simple;
	bh=QP4b6iMinNA6fbi9MlC/VzO6Vr1Ia7P85NTw94gh2Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sy5TNDqJfrZGTGZUTnpSIV1qYZFaSgnb04V/ZQ6HY++s1Bp124ovvtiPjy4AOY2/n6Uq6pEQplEINF3ASE2Qi11ilJ5pzv6DLK2cxCdZm+WB+bIz/iAmXrqyljcyLl2Hqpuu9FpFBiCXgAI/emQuE0ylpSPJYJH4tZ8138S0LtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=siR675Sv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aFqrzLLA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=siR675Sv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aFqrzLLA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01F2121FF4;
	Wed,  7 Feb 2024 01:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707268912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tb1bFva1nuFmw2W/4ywFFy2C9NQVrgmZiIKFy7fRmM=;
	b=siR675SvnDUwgKAPy4i+2L2+KUfuqOpnj44oLDF9X3DFg2g8Gbnvq3NOrOM6vZcxzROVpf
	dxJWN9WmPnuGvoF8ZBj5Wa/NGWGy46jSygcmwR8FdFM/DI8fryh9zkXoOYqiqiFZ7A/hEf
	bkFroKVibvLftCWfHfj/kmZfjx2cvUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707268912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tb1bFva1nuFmw2W/4ywFFy2C9NQVrgmZiIKFy7fRmM=;
	b=aFqrzLLAx1MR05a8iBqDVdKH96pQeP05VvfxM+RZaja7ec/uJePmEqXzsvq9BSPhV8eMPI
	qPqEHQu3z/5lZtAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707268912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tb1bFva1nuFmw2W/4ywFFy2C9NQVrgmZiIKFy7fRmM=;
	b=siR675SvnDUwgKAPy4i+2L2+KUfuqOpnj44oLDF9X3DFg2g8Gbnvq3NOrOM6vZcxzROVpf
	dxJWN9WmPnuGvoF8ZBj5Wa/NGWGy46jSygcmwR8FdFM/DI8fryh9zkXoOYqiqiFZ7A/hEf
	bkFroKVibvLftCWfHfj/kmZfjx2cvUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707268912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tb1bFva1nuFmw2W/4ywFFy2C9NQVrgmZiIKFy7fRmM=;
	b=aFqrzLLAx1MR05a8iBqDVdKH96pQeP05VvfxM+RZaja7ec/uJePmEqXzsvq9BSPhV8eMPI
	qPqEHQu3z/5lZtAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4E03139D0;
	Wed,  7 Feb 2024 01:21:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2EtYHS3bwmXpbAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 Feb 2024 01:21:49 +0000
Message-ID: <5cfc6045-ac75-4faf-b0da-d46a2d219f51@suse.de>
Date: Wed, 7 Feb 2024 10:21:46 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net/handshake: Fix handshake_req_destroy_test1
Content-Language: en-US
To: Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
References: <170724699027.91401.7839730697326806733.stgit@oracle-102.nfsv4bat.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <170724699027.91401.7839730697326806733.stgit@oracle-102.nfsv4bat.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=siR675Sv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aFqrzLLA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.02)[54.16%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.52
X-Rspamd-Queue-Id: 01F2121FF4
X-Spam-Flag: NO

On 2/7/24 03:16, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Recently, handshake_req_destroy_test1 started failing:
> 
> Expected handshake_req_destroy_test == req, but
>      handshake_req_destroy_test == 0000000000000000
>      req == 0000000060f99b40
> not ok 11 req_destroy works
> 
> This is because "sock_release(sock)" was replaced with "fput(filp)"
> to address a memory leak. Note that sock_release() is synchronous
> but fput() usually delays the final close and clean-up.
> 
> The delay is not consequential in the other cases that were changed
> but handshake_req_destroy_test1 is testing that handshake_req_cancel()
> followed by closing the file actually does call the ->hp_destroy
> method. Thus the PTR_EQ test at the end has to be sure that the
> final close is complete before it checks the pointer.
> 
> We cannot use a completion here because if ->hp_destroy is never
> called (ie, there is an API bug) then the test will hang.
> 
> Reported by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/netdev/ZcKDd1to4MPANCrn@tissot.1015granger.net/T/#mac5c6299f86799f1c71776f3a07f9c566c7c3c40
> Fixes: 4a0f07d71b04 ("net/handshake: Fix memory leak in __sock_create() and sock_alloc_file()")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/handshake-test.c |    5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
> index 16ed7bfd29e4..34fd1d9b2db8 100644
> --- a/net/handshake/handshake-test.c
> +++ b/net/handshake/handshake-test.c
> @@ -471,7 +471,10 @@ static void handshake_req_destroy_test1(struct kunit *test)
>   	handshake_req_cancel(sock->sk);
>   
>   	/* Act */
> -	fput(filp);
> +	/* Ensure the close/release/put process has run to
> +	 * completion before checking the result.
> +	 */
> +	__fput_sync(filp);
>   
>   	/* Assert */
>   	KUNIT_EXPECT_PTR_EQ(test, handshake_req_destroy_test, req);
> 
> 
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


