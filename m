Return-Path: <netdev+bounces-178762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52722A78C96
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90128189476F
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF48235BF0;
	Wed,  2 Apr 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EplJr8+B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qpuImgyh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EplJr8+B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qpuImgyh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881153BE
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743590695; cv=none; b=XYAACjPzqhj8fNa/KnrBNVNfbI/pCWAoMo2WuTRY3KBc4CMOVnjefRtBZ5VaTzWryTL2cOelEnzsufQ6dxE8edqgwOjuZf2Sq93B1+R+LNM+hWiKY1x0w46wNXTOnbC84FV/lxWCa+Xhk1C4LHlDxDreT94NZYKJ6ntfy8lDNeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743590695; c=relaxed/simple;
	bh=+uB5iUofgagnRdSq6+dSLbB0qAKAimYmRXFsyrrPlaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPnQUXSPbxYcxtTmrs41y227UTnJLjK8kYpNqQ+HVar1o6xQqujk9edIgXM7hit2dmDsVRKGPJ17tJpMJEvfkdIBFfRMYhA3Cht9f9q7O55CqgJ5metHWeELIYxkkyJo1zE6zxSZ3v4bJLypbt0REHIm28avz0xQ69tCDLcQfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EplJr8+B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qpuImgyh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EplJr8+B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qpuImgyh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29DF41F38A;
	Wed,  2 Apr 2025 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743590692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V44jQhfXZFRMaYV7EYWgg+brV+qQ7i8rYGkA/MtWj1Q=;
	b=EplJr8+BK+pJm2YQ2ZJTFdqc3XPtJ6TX8dVEmw1CaQVIW8ZW6up9Vj7BaoHUkMftbqZL50
	3/HQjChFzrNoqULvi0jw88k5gKQ6vBVq1Uo8WDjWgXVmCJ85Y2Wv0tQ2mNAD4gtygKQFxH
	AMU7nqKMSyog8qUZzOqbfvU/RPD7sII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743590692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V44jQhfXZFRMaYV7EYWgg+brV+qQ7i8rYGkA/MtWj1Q=;
	b=qpuImgyhZeem5DOPN+L2+Zs5U1kwMSecOMXLIJNHGhsvo3XNUFJZIzGqYI1po9FczHpLC+
	QFhDLGC/oxP2HnAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EplJr8+B;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qpuImgyh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743590692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V44jQhfXZFRMaYV7EYWgg+brV+qQ7i8rYGkA/MtWj1Q=;
	b=EplJr8+BK+pJm2YQ2ZJTFdqc3XPtJ6TX8dVEmw1CaQVIW8ZW6up9Vj7BaoHUkMftbqZL50
	3/HQjChFzrNoqULvi0jw88k5gKQ6vBVq1Uo8WDjWgXVmCJ85Y2Wv0tQ2mNAD4gtygKQFxH
	AMU7nqKMSyog8qUZzOqbfvU/RPD7sII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743590692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V44jQhfXZFRMaYV7EYWgg+brV+qQ7i8rYGkA/MtWj1Q=;
	b=qpuImgyhZeem5DOPN+L2+Zs5U1kwMSecOMXLIJNHGhsvo3XNUFJZIzGqYI1po9FczHpLC+
	QFhDLGC/oxP2HnAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 860F4137D4;
	Wed,  2 Apr 2025 10:44:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CfIsHyMV7WcKXgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 02 Apr 2025 10:44:51 +0000
Message-ID: <3f387b13-5482-46ed-9f52-4a9ed7001e67@suse.cz>
Date: Wed, 2 Apr 2025 12:44:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] slab: introduce auto_kfree macro
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 torvalds@linux-foundation.org, peterz@infradead.org,
 Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc: andriy.shevchenko@linux.intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@gentwo.org>
References: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 29DF41F38A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,intel.com:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Cc Kees and others from his related efforts:

https://lore.kernel.org/all/20250321202620.work.175-kees@kernel.org/

On 4/1/25 15:44, Przemek Kitszel wrote:
> Add auto_kfree macro that acts as a higher level wrapper for manual
> __free(kfree) invocation, and sets the pointer to NULL - to have both
> well defined behavior also for the case code would lack other assignement.
> 
> Consider the following code:
> int my_foo(int arg)
> {
> 	struct my_dev_foo *foo __free(kfree); /* no assignement */
> 
> 	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> 	/* ... */
> }
> 
> So far it is fine and even optimal in terms of not assigning when
> not needed. But it is typical to don't touch (and sadly to don't
> think about) code that is not related to the change, so let's consider
> an extension to the above, namely an "early return" style to check
> arg prior to allocation:
> int my_foo(int arg)
> {
>         struct my_dev_foo *foo __free(kfree); /* no assignement */
> +
> +	if (!arg)
> +		return -EINVAL;
>         foo = kzalloc(sizeof(*foo), GFP_KERNEL);
>         /* ... */
> }
> Now we have uninitialized foo passed to kfree, what likely will crash.
> One could argue that `= NULL` should be added to this patch, but it is
> easy to forgot, especially when the foo declaration is outside of the
> default git context.
> 
> With new auto_kfree, we simply will start with
> 	struct my_dev_foo *foo auto_kfree;
> and be safe against future extensions.
> 
> I believe this will open up way for broader adoption of Scope Based
> Resource Management, say in networking.
> I also believe that my proposed name is special enough that it will
> be easy to know/spot that the assignement is hidden.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  include/linux/slab.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 98e07e9e9e58..b943be0ce626 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -471,6 +471,7 @@ void kfree_sensitive(const void *objp);
>  size_t __ksize(const void *objp);
>  
>  DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
> +#define auto_kfree __free(kfree) = NULL
>  DEFINE_FREE(kfree_sensitive, void *, if (_T) kfree_sensitive(_T))
>  
>  /**


