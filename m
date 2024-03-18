Return-Path: <netdev+bounces-80338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AB387E5EA
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C5A28217A
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8EB2C19E;
	Mon, 18 Mar 2024 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e3U66CuT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lDPK8keq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e3U66CuT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lDPK8keq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C632C848
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754672; cv=none; b=gyfQXYvi8OAGGxcFVUK9ewUubfsheyi9hi83T/7j77duuOpjNonQ5oi/s/KmkBp/xmIk6UYfRf/EeEzZn2Pc3yK07jeOogQNPh1AotJu97VzaS3AF/jGUhKrLhCVCGXTrF9iNEyD0ZCHQT3lSkZxFEWyzTOsf3zvYDlv0lI2OyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754672; c=relaxed/simple;
	bh=9J+YlDy6tLz369oHKdrVDdaE/rqHuOReW1LMLEXAyNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUGwTzeArbH1s0TPCjJqJKFbEA/eYM7pyA61ahRgKqifcuD1c9zcTog9wi1H9M4nfC8xmME3faD/5iwYPT5XIdN9m/vi60Bina7Ikyfq23VNwTNIlQScKdeey78lTNcUe7y3ZcpmBURBngBYkXnJ/EQYoSqldoJztcbg4MG3Ddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e3U66CuT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lDPK8keq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e3U66CuT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lDPK8keq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97BE35C335;
	Mon, 18 Mar 2024 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6A3zhVCWraIGBJr9OpCpEJTxuQx6eebsnthwVU0RjTo=;
	b=e3U66CuT+58TuIVZCP/bwstuZabi2ZU4gmEBDRe9jbHfrK9DLHyPqt21L3yJVp/VZSh37Z
	E0S8DiI7/73o5cBAzLT2pCY09HmCTONUWHh1UomkztmxEhb/ejWJvo483QZlBuZ0vnGJ6W
	s75wlMqRiSfiwE3t6328Rk4QZqQRGFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6A3zhVCWraIGBJr9OpCpEJTxuQx6eebsnthwVU0RjTo=;
	b=lDPK8keqAUfU9lRBwsO4e+xwCTVJVUqgWhSCjjq8HKNye14eO3hGP78NFlhyN7Nx5PzilI
	qHjV+jEijFPD8sCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6A3zhVCWraIGBJr9OpCpEJTxuQx6eebsnthwVU0RjTo=;
	b=e3U66CuT+58TuIVZCP/bwstuZabi2ZU4gmEBDRe9jbHfrK9DLHyPqt21L3yJVp/VZSh37Z
	E0S8DiI7/73o5cBAzLT2pCY09HmCTONUWHh1UomkztmxEhb/ejWJvo483QZlBuZ0vnGJ6W
	s75wlMqRiSfiwE3t6328Rk4QZqQRGFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6A3zhVCWraIGBJr9OpCpEJTxuQx6eebsnthwVU0RjTo=;
	b=lDPK8keqAUfU9lRBwsO4e+xwCTVJVUqgWhSCjjq8HKNye14eO3hGP78NFlhyN7Nx5PzilI
	qHjV+jEijFPD8sCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 546F81349D;
	Mon, 18 Mar 2024 09:37:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HhfmEGwL+GU3UAAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Mon, 18 Mar 2024 09:37:48 +0000
Message-ID: <e34a10c2-0901-4fe2-b984-5acca572af6a@suse.de>
Date: Mon, 18 Mar 2024 12:37:47 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create
 /var/lib/arpd on first use
Content-Language: en-US
To: Max Gautier <mg@max.gautier.name>, Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240316091026.11164-1-mg@max.gautier.name>
 <20240317090134.4219-1-mg@max.gautier.name>
 <20240318025613.GA1312561@maili.marvell.com> <Zff9ReznTN4h-Jrh@framework>
 <MWHPR1801MB1918B6880C90E045C219B9ADD32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <ZfgCZNjlYrj5-rJz@framework>
 <MWHPR1801MB191828A6FF7D83103C75ED6AD32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <ZfgI2Aow6751-EGj@framework>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <ZfgI2Aow6751-EGj@framework>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[51.00%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.986];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO



On 3/18/24 12:26, Max Gautier wrote:
> On Mon, Mar 18, 2024 at 09:18:59AM +0000, Ratheesh Kannoth wrote:
>>>>>>> +	if (strcmp(default_dbname, dbname) == 0
>>>>>>> +			&& mkdir(ARPDDIR, 0755) != 0
>>>>>>> +			&& errno != EEXIST
>>>>>> why do you need errno != EEXIST case ? mkdir() will return error
>>>>>> in this case
>>>>> as well.
>>>>>
>>>>> EEXIST is not an error in this case: if the default location already
>>>>> exist, all is good. mkdir would still return -1 in this case, so we
>>>>> need to exclude it manually.
>>>>
>>>> ACK. IMO, it would make a more readable code if you consider splitting the
>>> "if" loop.
>>>
>>> Something like this ? I tend to pack conditions unless branching is necessary,
>>> but no problem if this form is preferred.
>>>
>>> if (strcmp(default_dbname, dbname) == 0) {
>>>     if (mkdir(ARPDDIR, 0755) != 0 && errno != EEXIST) {
>>>    ...
>>>    }
>>> }
>> ACK.   
>> instead of errno != EXIST ,  you may consider stat() before mkdir() call. Just my way thinking(please ignore it, if you don't like). 
>> My thinking is --> you need to execute mkdir () only first time, second time onwards, stat() call will return 0.
> 
> That's racy: we can stat and have a non existing folder, then have
> another arpd instance (or anything else, really) create the directory,

Agreed ^^

> and we would hit EEXIST anyway when we call mkdir.
> Also, that needs two syscalls instead of one.
> 

