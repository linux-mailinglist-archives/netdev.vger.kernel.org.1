Return-Path: <netdev+bounces-287265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMqJDZp2A2pY6AEAu9opvQ
	(envelope-from <netdev+bounces-287265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:51:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB295282CA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BCCE30760B9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D6D38239C;
	Tue, 12 May 2026 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YAENTL8N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ltkB4KAf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TQ/aAidO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VyA5QEu0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BA35F185
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610285; cv=none; b=e7NIGRQfxVkddiZvUH/bZglnnrj342efuWSV9hdIOX7TimecjJmy6/luc2tRX76i0sLf3XEQjUscuULZuFq81dxdH78noZWCg4olcNQMh9tKRrHT69MGWL8qxP+CudJXhsaosuTN98AVyrUYSKcqeJ442/ZEZ6GpzCRtg0Qnimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610285; c=relaxed/simple;
	bh=kjaV2EHoQQnwbhC4lDukCmkYz9scdQIduNu19KlnuKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxFVXrzFxmu8bheGOnn1GTm5h6fnfM5onPrHV1W4iBAwQuUCToLgdSFDWLXrWZUQqpqWwf0rRzR8GnwJl6whwV4mq6GwqKe8bySnN9avkFx2xTHMNghRD7lrIDULZ0vX7u1y7hFU0q8r6m8ihxeVGo+4U+6Th1Qes40UN9R75Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YAENTL8N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ltkB4KAf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TQ/aAidO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VyA5QEu0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CCC176196;
	Tue, 12 May 2026 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778610282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFmSeZYewv5iGlrC38yb8XQSxhsOHPKHqzXiXgd78I8=;
	b=YAENTL8NpOj7eFMLggRSmI4i8y6WrgoOYjpWiWL0z6vmBK7M+oePOf4MAMANFL3XU4N5PZ
	6oQ7hr1Z6rL13F02gy1LjhXZnEkFVxyfKGkzjfkHA0wDwEnLZtF7xPuPHJn+qpCaAn0AAx
	S3Vuhu5r1X/W6gJscJDR+xc28irfjcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778610282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFmSeZYewv5iGlrC38yb8XQSxhsOHPKHqzXiXgd78I8=;
	b=ltkB4KAfgociwUWBETVRjJbP+sRRRVEsgIiufaEE9NbGWSReeU3lpUkETaK73rQ41HzK/E
	9sVpMfnlosw43wDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778610278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFmSeZYewv5iGlrC38yb8XQSxhsOHPKHqzXiXgd78I8=;
	b=TQ/aAidOkOQwEWBzJYsWMc1RoG8Dkp/wljwCH9WgWPyg0li6O+ZLNRyh2ua4340OV1wzLs
	Mf9er/Z+ygjsExWCYyzWFJ/fXX7Pwl04bDJPAOkeHerBGqfWMCqX4AuvtlhLltDa+188zz
	Cu2LMmGcMcWS4EV4ccq1JeotbtvYcd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778610278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFmSeZYewv5iGlrC38yb8XQSxhsOHPKHqzXiXgd78I8=;
	b=VyA5QEu0h7Y+j48ix2z5ZYvDaGuAZfzHEkuhwhcJ1I1QoBZrQvAvbUkrwp3Cdq0OU+iZs7
	a2747wXtHEY4T9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2573593A9;
	Tue, 12 May 2026 18:24:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SMVlKGVwA2pcfQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 12 May 2026 18:24:37 +0000
Message-ID: <3f371efe-1b1b-464c-af21-ccd66b6c5df6@suse.de>
Date: Tue, 12 May 2026 20:24:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 net v4] ipv6: addrconf: fix temp address generation
 after prefix deprecation
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net, =?UTF-8?Q?=C5=81ukasz_Stelmach?= <steelman@post.pl>,
 Ido Schimmel <idosch@nvidia.com>
References: <20260511122645.6233-2-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260511122645.6233-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 9CB295282CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287265-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim,post.pl:email]
X-Rspamd-Action: no action

On 5/11/26 2:26 PM, Fernando Fernandez Mancera wrote:
> When a router temporarily deprecates an IPv6 prefix (either by sending a
> Router Advertisement with Preferred Lifetime = 0 or by letting the
> lifetime expire) and later restores it, the kernel permanently loses its
> ability to generate temporary privacy addresses (RFC 8981) for that
> prefix.
> 
> This happens because the address worker attempts to generate a
> replacement temporary address when the current one nears expiration. As
> the base prefix is deprecated already, the generation fails after
> marking the temporary address as already having spawned a replacement
> (ifp->regen_count++).
> 
> When the router eventually restores the prefix, the temporary address
> becomes active again. However, once it naturally expires, the address
> worker sees this temporary address already tried to generate one and
> skips the regeneration.
> 
> Fix this by checking if all temporary addresses for a given prefix have
> already tried to spawn a replacement when processing a new RA. If so,
> spawn a new temporary address.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Łukasz Stelmach <steelman@post.pl>
> Closes: https://lore.kernel.org/netdev/87340td30q.fsf%25steelman@post.pl/
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: adjusted commit message, adjusted the implementation to cover all
> race conditions
> v3: regen now if ipv6_create_tempaddr failed due to timer to avoid an
> infinite loop as we restart the loop and we need to check now against
> prefered_lft again.
> v4: change the proposed fix completely, now we address the problem when
> doing manage_tempaddrs().
> ---

Sashiko feedback [1] is right about the DoS, that is a router that sends 
multiple 0-lft RA until it exhausts all spawn attempts, leaving 
temporary addresses disabled on the system.

About the leaked address, I do not think the feedback is right. If an 
ifp does not have any ift, it means something went wrong most likely. 
Either this address was removed manually (any RA would restore it, even 
with previous implementation) or for some reason that prefix didn't get 
an RA but we didn't try to generate one and we MUST do it.

I think we can cover it by avoiding to attempt create a new temporary 
address for a 0-lft RA, it makes sense to me. Something like this:

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 18a6f2de30ce..6c511e9c1bf5 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2654,7 +2654,7 @@ static void manage_tempaddrs(struct inet6_dev *idev,
  	 * We don't want that to result in creating a new temporary ip address.
  	 */
  	if ((list_empty(&idev->tempaddr_list) || all_regen) &&
-	    (valid_lft || prefered_lft))
+	    (valid_lft && prefered_lft))
  		create = true;

  	if (create && READ_ONCE(idev->cnf.use_tempaddr) > 0) {

Any thoughts?

[1] 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260511122645.6233-2-fmancera%40suse.de

>   net/ipv6/addrconf.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 5476b6536eb7..18a6f2de30ce 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2595,8 +2595,9 @@ static void manage_tempaddrs(struct inet6_dev *idev,
>   			     __u32 valid_lft, __u32 prefered_lft,
>   			     bool create, unsigned long now)
>   {
> -	u32 flags;
>   	struct inet6_ifaddr *ift;
> +	bool all_regen = true;
> +	u32 flags;
>   
>   	read_lock_bh(&idev->lock);
>   	/* update all temporary addresses in the list */
> @@ -2637,6 +2638,8 @@ static void manage_tempaddrs(struct inet6_dev *idev,
>   		ift->tstamp = now;
>   		if (prefered_lft > 0)
>   			ift->flags &= ~IFA_F_DEPRECATED;
> +		if (!ift->regen_count)
> +			all_regen = false;
>   
>   		spin_unlock(&ift->lock);
>   		if (!(flags&IFA_F_TENTATIVE))
> @@ -2644,12 +2647,14 @@ static void manage_tempaddrs(struct inet6_dev *idev,
>   	}
>   
>   	/* Also create a temporary address if it's enabled but no temporary
> -	 * address currently exists.
> +	 * address currently exists or if all temporary addresses already
> +	 * generated an address.
>   	 * However, we get called with valid_lft == 0, prefered_lft == 0, create == false
>   	 * as part of cleanup (ie. deleting the mngtmpaddr).
>   	 * We don't want that to result in creating a new temporary ip address.
>   	 */
> -	if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lft))
> +	if ((list_empty(&idev->tempaddr_list) || all_regen) &&
> +	    (valid_lft || prefered_lft))
>   		create = true;
>   
>   	if (create && READ_ONCE(idev->cnf.use_tempaddr) > 0) {


