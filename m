Return-Path: <netdev+bounces-76156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5C886C932
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 13:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9BC1F23C77
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9347D07C;
	Thu, 29 Feb 2024 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WUUOZ98i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EUW/nX8R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WUUOZ98i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EUW/nX8R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB9F7CF0E
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209614; cv=none; b=YsCcjq1esuRCF1i/xOBbz+u3/uzouG2ddBbfeLrtBATyjjUaRMzQp/Idwzn/CVTc4kAVTg1UKBxmyQqySIMVSacQ3Mg0LQVkQqL+PM/OnNE+rYANDJk6mHNSJD6HDyU5sVTacdrCcRM3StGHxTKvjZu6uQYlnv0KldsQaKP1aPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209614; c=relaxed/simple;
	bh=atKFwe2ZK5+602KUhrH4DebAwQGE1rcVw/jZ4/t5Ggg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juZgbnb0ZXs2WfNbx2tQP1Bm6WdyXDW9h066akzNfqbXUIIzwVXtKRWsExreB8rRgYMhpr1gvtjC9qJ2B9CqcWuhXYP1ao5hTciE06EiYkQE4tfsR1Np2Lf0jWuRHzp6F6dRRyusw3DupHkkCyN2ONDKn8xgLSFgSZu2Zmr8JYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WUUOZ98i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EUW/nX8R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WUUOZ98i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EUW/nX8R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCA791F7DD;
	Thu, 29 Feb 2024 12:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709209610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSaKulzPCbUoju3ht7kfIeTyV1J56oaxEVfq69cXoVk=;
	b=WUUOZ98i4xrqUPXka7gl2agW0MZBjXSphXbC/eeSNAVJ/Snoo0WnkN0GDwRH+bbPcyDpDW
	ToDBkmAfDRH/4i02REWlPxiGwarihF2JJgU3ffUWkQ1qQbXj+SmLNAbVHnOb1EyNafPo3p
	Ak+ZQ3C+1eydrHefc6f6khLqG87pv14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709209610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSaKulzPCbUoju3ht7kfIeTyV1J56oaxEVfq69cXoVk=;
	b=EUW/nX8RxtpYqLEjGi1TKplgZKAyxnQIrQnI8RluHzJwXEXApIi2VOv4F+fr3DzQqry6BF
	QpMjrqW65u4Y6YBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709209610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSaKulzPCbUoju3ht7kfIeTyV1J56oaxEVfq69cXoVk=;
	b=WUUOZ98i4xrqUPXka7gl2agW0MZBjXSphXbC/eeSNAVJ/Snoo0WnkN0GDwRH+bbPcyDpDW
	ToDBkmAfDRH/4i02REWlPxiGwarihF2JJgU3ffUWkQ1qQbXj+SmLNAbVHnOb1EyNafPo3p
	Ak+ZQ3C+1eydrHefc6f6khLqG87pv14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709209610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSaKulzPCbUoju3ht7kfIeTyV1J56oaxEVfq69cXoVk=;
	b=EUW/nX8RxtpYqLEjGi1TKplgZKAyxnQIrQnI8RluHzJwXEXApIi2VOv4F+fr3DzQqry6BF
	QpMjrqW65u4Y6YBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 872381329E;
	Thu, 29 Feb 2024 12:26:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id za/GHAp44GXPHAAAn2gu4w
	(envelope-from <dkirjanov@suse.de>); Thu, 29 Feb 2024 12:26:50 +0000
Message-ID: <2aa3a4f7-4b09-488f-9ae6-2e61dd1dfe8d@suse.de>
Date: Thu, 29 Feb 2024 15:26:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 v2] ifstat: handle unlink return value
To: Denis Kirjanov <kirjanov@gmail.com>, stephen@networkplumber.org
Cc: netdev@vger.kernel.org
References: <20240229122210.2478-1-dkirjanov@suse.de>
Content-Language: en-US
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240229122210.2478-1-dkirjanov@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_SOME(0.00)[];
	 BAYES_HAM(-0.42)[78.23%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[gmail.com,networkplumber.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.51



On 2/29/24 15:22, Denis Kirjanov wrote:
> v2: exit if unlink failed

please ignore

> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  misc/ifstat.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/misc/ifstat.c b/misc/ifstat.c
> index 767cedd4..72901097 100644
> --- a/misc/ifstat.c
> +++ b/misc/ifstat.c
> @@ -937,8 +937,10 @@ int main(int argc, char *argv[])
>  				 "%s/.%s_ifstat.u%d", P_tmpdir, stats_type,
>  				 getuid());
>  
> -	if (reset_history)
> -		unlink(hist_name);
> +	if (reset_history && unlink(hist_name) < 0) {
> +		perror("ifstat: unlink history file");
> +		exit(-1);
> +	}
>  
>  	if (!ignore_history || !no_update) {
>  		struct stat stb;

