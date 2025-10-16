Return-Path: <netdev+bounces-230254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0747ABE5CC1
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A62A19A74F6
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F932550CC;
	Thu, 16 Oct 2025 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xjDjw3vV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OLfQIoOm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S8zyJiuY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yb+9bw3m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5CA33468B
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760657440; cv=none; b=iGQ7u++MFymJYLN5zk1+9gJvU1mtye7ix3ifDzawIu+SIEIlBXze7FayBT4iSi4LZgQ7ujMAvz1n5bgkoFr5dXTJYaDaloY7bS7CBmN0d2ToLwQVECG4XwVs6ovC5wf9w+7MRLKCofQ5sEevxEnpy4FFBa/WKKkyd/yPe9VNl7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760657440; c=relaxed/simple;
	bh=F3KIC9GmfR1RE4lOn1ekazhYZECvgNjpR8BibTRXGys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8KmnAG6UJRdViPYd0bbNsDEdd1dJKgOfuOmD4jJwe0WumwJRuUmIbl9viFz9iMHN4exx81vjr0//o68WLrPzylF8DXtpQgChKSCfb6CQTDoHC80BwsfNcaeInAGwxqkKkgeV9RPVff98pT8k2oKddGdfVSsAcOq5Ax3vu3j4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xjDjw3vV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OLfQIoOm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S8zyJiuY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Yb+9bw3m; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F11281FB85;
	Thu, 16 Oct 2025 23:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760657437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsiMwKT3m3Bh123jLF8nxx4FYzt9Q5alQ9JOcyvODYc=;
	b=xjDjw3vVPYPxJZF8aD8YIpqOe3C02PuyPzJsDjbJREoGtKKi19e3Ulf/hClTVDNGJMWmJA
	xBZDQ8fUmXsrTFUD5zCcjCwC7oiI/sGUbPI3GwNXd17I9hqifRidDU4hMVbt7e9TA0HgVU
	FjE9jJ89z2JEq9qqVRZeEmEvYnYSliY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760657437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsiMwKT3m3Bh123jLF8nxx4FYzt9Q5alQ9JOcyvODYc=;
	b=OLfQIoOmob1L2t1ytFKmB3fvLLYIzjO8C7OLYHwSfRK7SQaJ4fyCEbRVUzVDsAFBzEQcqp
	UFX0lo+su49v47DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760657435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsiMwKT3m3Bh123jLF8nxx4FYzt9Q5alQ9JOcyvODYc=;
	b=S8zyJiuYET50uQoiV0UOVA+f/vpDI6ichu1UgQOjVHsc5MPkS6pbtMLAj6SZqSCGA4SOJB
	0/ovvSZANejaJFg7sTTmdqAgMNlJ9hx/wSXwRRUQqvd1aQ+/RVbvDiJpAtnHP4+p4zqPAX
	5XJugG5csrMnHNuqPdeUNIct8F2CptQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760657435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsiMwKT3m3Bh123jLF8nxx4FYzt9Q5alQ9JOcyvODYc=;
	b=Yb+9bw3mpB3OtPzZawpWlCNmfVuPQ1xohHVxzIVRYYW1twA6UZeGbjkth7idES/+SlBp4q
	GsiZBez8kCZVNaAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F47E1340C;
	Thu, 16 Oct 2025 23:30:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3GD+DxuA8WjVAQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 16 Oct 2025 23:30:35 +0000
Message-ID: <f4f5ac14-b110-4893-8014-81ba3a4170ba@suse.de>
Date: Fri, 17 Oct 2025 01:30:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sysfs: check visibility before changing group attribute
 ownership
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, cynthia@kosmx.dev, rafael@kernel.org,
 dakr@kernel.org, christian.brauner@ubuntu.com, edumazet@google.com,
 pabeni@redhat.com, davem@davemloft.net, horms@kernel.org
References: <20251016101456.4087-1-fmancera@suse.de>
 <20251016083835.096c09e1@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20251016083835.096c09e1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,kosmx.dev:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30



On 10/16/25 5:38 PM, Jakub Kicinski wrote:
> On Thu, 16 Oct 2025 12:14:56 +0200 Fernando Fernandez Mancera wrote:
>> Since commit 0c17270f9b92 ("net: sysfs: Implement is_visible for
>> phys_(port_id, port_name, switch_id)"), __dev_change_net_namespace() can
>> hit WARN_ON() when trying to change owner of a file that isn't visible.
>> See the trace below:
> 
> Dunno much about sysfs but this is what I had in mind so FWIW:
> 
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> 
> I'd be tempted to chuck:
> 
> Fixes: 0c17270f9b92 ("net: sysfs: Implement is_visible for phys_(port_id, port_name, switch_id)")
> 
> here as well. Or are we certain there are other callers that could have
> triggered this earlier?
> 

It is hard for me tell certainly. I am fine adding:

Fixes: 0c17270f9b92 ("net: sysfs: Implement is_visible for 
phys_(port_id, port_name, switch_id)")

but I would keep the current Fixes tag too. IMHO, given that visibility 
could return 0 for some attributes and > 0 for others in the same group, 
is up to sysfs to check the attribute visibility before updating the 
ownership of a whole group.. so this check should have been there since 
the beginning.

Anyway, I am not an expert on sysfs neither..

>> Reported-by: Cynthia <cynthia@kosmx.dev>
> 
> Perhaps:
> 
> Reported-and-bisected-by: ...
> 
Oh, sure, thanks! I am going to wait a bit to allow more feedback and 
send a v2.



