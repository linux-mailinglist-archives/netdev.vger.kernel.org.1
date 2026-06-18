Return-Path: <netdev+bounces-300443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DxMrOBb2M2poJwYAu9opvQ
	(envelope-from <netdev+bounces-300443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:43:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 583C46A0AB6
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leemhuis.info header.s=key2 header.b="iKq9Z/96";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300443-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300443-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FFAF30488C9
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335111DC985;
	Thu, 18 Jun 2026 13:40:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA253B27D7
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:40:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790019; cv=none; b=RVFxcdfjDqQPbgB0VbX+6FcDdSaNH3/x8lt2tjwMQFCDxXchzT6LO2BLTh2Pf4qNjE/N1NjFQR5mr6IhMh5NnvZLlSVmsGA2oS3dF0h111Q1gkFHXDti9Xiicht6TzSqmosGyoCgiGxFWi+M+pTFL5qB7037ipV7vrBWjjS9e9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790019; c=relaxed/simple;
	bh=E1YtVC8BP8jTDJwiEdVixAjfZCeN8YWyqEqMVhMlzY8=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=ZX/jb56G0QbYzHVwnnuXuU8KY9K1p+l/Bk7CPIlKllqLoLYZHGEJCP+GJ107U8yv6nr+29r8I8nCfTt2JXGIkOt/+7QFPIHSWjP5JDn7Lt7vfCzddTNd2sFXTidqtkga6lwGP4jtLfFSeyzV1aF14YZbiud1c8drtlCpSsUzPOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=iKq9Z/96; arc=none smtp.client-ip=188.68.63.102
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gh2066jFmz6KVv;
	Thu, 18 Jun 2026 15:39:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1781789990;
	bh=E1YtVC8BP8jTDJwiEdVixAjfZCeN8YWyqEqMVhMlzY8=;
	h=Date:From:To:Cc:Subject:From;
	b=iKq9Z/96lpRl85WPdhB72b97fHEm3C0s+5NN/kVcmnbtVJtlKGkdsVL6XpyW6mShy
	 bafK0ZVMDPQFoflAdLUvLLSOnH/GIXo79jg7obQ78JZtMbVpJ8hhJ99G8flIFbPz3j
	 3Fe9g8lP9U5tFgRKnvzsbwlpxekHVeRAdoJsLLYOzTzbZ69GeMYceTgIkmO2IB+3rP
	 Z5RuXjlGfoa2WqZEHZasv2DNKtz1uy2NFAZZFy0Qua2YRaDqioChbQyGDPCM5buuV/
	 y8kMB1VxtPP4XfeZbqBYbD/sjCN1ayv4hXToYUOVMtcHeVAYEJvtsPmw//XGaZ/yHk
	 Zt2PJyCs/UIEQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gh2043fX6z4yKl;
	Thu, 18 Jun 2026 15:39:48 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gh2036GYdz8sZw;
	Thu, 18 Jun 2026 15:39:47 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 2D7BF5F941;
	Thu, 18 Jun 2026 15:39:47 +0200 (CEST)
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ade91456-2f93-442c-b76c-28bd7157f074@leemhuis.info>
Date: Thu, 18 Jun 2026 15:39:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
To: Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: netdev <netdev@vger.kernel.org>, Riana Tauro <riana.tauro@intel.com>
Subject: building ynl afaics requires updating the UAPI headers first
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <178178998747.2030643.15971267552177160941@mxe9fb.netcup.net>
X-NC-CID: 8A4goW+hEIDtnhAwm1EbEXTMSvecIgmOEa/5iGkjAOxKrAKhBhg=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300443-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,leemhuis.info:dkim,leemhuis.info:mid,leemhuis.info:from_mime];
	DMARC_NA(0.00)[leemhuis.info];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:donald.hunter@gmail.com,m:netdev@vger.kernel.org,m:riana.tauro@intel.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER(0.00)[linux@leemhuis.info,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 583C46A0AB6

Hi Jakub, Donald! During the past few weeks I two or three times ran
into errors when building ynl as part of my daily -mainline/-next builds
based on a srpm pretty close to the kernel srpm used in Fedora rawhide.
Today I for example ran into this:

"""
> [...]
>         GEN_RST team.rst                                                                                                            
>         GEN_RST wireguard.rst                                                                                                       
>         CC binder-user.o                                                                                                            
>         CC dev-energymodel-user.o                                                                                                   
>         CC devlink-user.o                                                                                                           
>         CC dpll-user.o                                                                                                              
>         CC drm_ras-user.o                                                                                                           
> drm_ras-user.c:19:10: error: ‘DRM_RAS_CMD_CLEAR_ERROR_COUNTER’ undeclared here (not in a function); did you mean ‘DRM_RAS_CMD_GET_ER
> ROR_COUNTER’?                                                                                                                       
>    19 |         [DRM_RAS_CMD_CLEAR_ERROR_COUNTER] = "clear-error-counter",                                                          
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                                                                                    
>       |          DRM_RAS_CMD_GET_ERROR_COUNTER                                                                                      
> drm_ras-user.c:19:10: error: array index in initializer not of integer type                                                         
> drm_ras-user.c:19:10: note: (near initialization for ‘drm_ras_op_strmap’)                                                           
> make[1]: *** [Makefile:52: drm_ras-user.o] Error 1                                                                                  
> make[1]: *** Waiting for unfinished jobs....                                                                                        
> make[1]: Leaving directory '/home/kbuilder/ark-vanilla/linux-knurd42/tools/net/ynl/generated'                                       
> make: *** [Makefile:28: generated] Error 2                                                                                          
> make: Leaving directory '/home/kbuilder/ark-vanilla/linux-knurd42/tools/net/ynl
"""

DRM_RAS_CMD_CLEAR_ERROR_COUNTER was introduced to mainline yesterday as
ee18d39a087792 ("drm/drm_ras: Add clear-error-counter netlink command to
drm_ras") [v7.1-post].

I finally looked closer today and noticed how to prevent this: update
the kernel's UAPI files (e.g. the stuff that lives in /usr/include/) on
the builder. Thing is: that's basically impossible to do from a srpm, as
those should not change the build environment and can't even when
working as non-root.

Note sure if relevant and just a shot in the dark, so maybe ignore the
following:

While investigating this I noticed this comment in
tools/net/ynl/Makefile.deps:

"""
> # Try to include uAPI headers from the kernel uapi/ path.
> # Most code under tools/ requires the respective kernel uAPI headers
> # to be copied to tools/include. The duplication is annoying.
> # All the family headers should be self-contained. We avoid the copying
> # by selectively including just the uAPI header of the family directly
> # from the kernel sources.
"""

Is that maybe not the case anymore with the recent changes to ynl?

Ciao, Thorsten

