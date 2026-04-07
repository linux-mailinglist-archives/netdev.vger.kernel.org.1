Return-Path: <netdev+bounces-276103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM7UGog71WlY3AcAu9opvQ
	(envelope-from <netdev+bounces-276103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:14:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D92973B23EC
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96C95302E7C5
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6E8389444;
	Tue,  7 Apr 2026 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yWA2jgE0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xwASnASo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C0isRJE7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NfGd7tfS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BA433CEA8
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582085; cv=none; b=I964r0N5IW44Kq/mLu08NqPf7+C12uGF8A0SPl65ZYSgsmxXv0ZJ9ZKZHInvqNhX4rEuf8Q9iToG+60jOBVuJKnsyTa+rFBspZ/YACUlsK3xMw8WHC424+4tIjNmWlcGmfdHqjf9UKfp5L7dTl2wa+h7czJyGqf2UjDoF0hEwc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582085; c=relaxed/simple;
	bh=PCb7jzDtZrltEUDUs+KdG2BSSzrGlb0wi1TNmgcM+U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWewg3d3XLIVOuUElXTQyPuhEwci42SozlU4l2TUBGGNPyw+1vyapAD7CV9NyMVtxZz11LMZSHmvOuaV45PSTG2OceUzVZ19S8GpnXTeItuN24P6DTdhUmXdiKaqsQVsuiTAIukSeHUqk0/R9HxQw5xhC+7SbU6CQA9OSFgFuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yWA2jgE0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xwASnASo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C0isRJE7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NfGd7tfS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC8F24E51B;
	Tue,  7 Apr 2026 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775582082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXOpCoMcgIKJsO4Rl6iRpkevFMz/CPZkJyzyynfYR1o=;
	b=yWA2jgE0q9hTqhANoJigiz8jCMYeoL/hqQkEj7dx/blnNdj0bYnwR4BKrv0CFJtTf1Pn7s
	OolEpSHSTYSlcd9yLA/Mo6gDLiefsbDZU2OvAoAP6K9xXxvO7LMdIgB8z86V5OtwFs3TV/
	L18/vDzx9k8CJkNE8k93NOdhBnwNv1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775582082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXOpCoMcgIKJsO4Rl6iRpkevFMz/CPZkJyzyynfYR1o=;
	b=xwASnASoZz1KloteDvd+0zyv85QdoR8w4F04wMxPgaetHnU2I4FkQfEh17xqOmAXFGCTT2
	6BAUKzAkVlyhU+Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C0isRJE7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NfGd7tfS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775582081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXOpCoMcgIKJsO4Rl6iRpkevFMz/CPZkJyzyynfYR1o=;
	b=C0isRJE7pQwyhOeK13RlvVoJMVgtlfIqwFeG3UAUStOc2/6pssesss3PBq7rtX9TJEswUi
	m6zIgTCKBAlwOABaznsHeCSQI9cGwQUK3AlWrkfOpbZv77moAWL4p8tW+bq1+VCYqEu1QU
	QpM9JMJQdrC+mVhSzfnF7x/HotJZiGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775582081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXOpCoMcgIKJsO4Rl6iRpkevFMz/CPZkJyzyynfYR1o=;
	b=NfGd7tfSk5tPMuNapgJIqrI+XDPF2wCX3g0RqXQKm11E+PukiUEisi9rv8gAGwbCDKGomC
	fw2FXIbnwJc3LfBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D92C4A0B0;
	Tue,  7 Apr 2026 17:14:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id thZgE4E71WnjNwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 07 Apr 2026 17:14:41 +0000
Message-ID: <80b74501-5c15-4b69-a825-b747ac509855@suse.de>
Date: Tue, 7 Apr 2026 19:14:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net_sched: fix skb memory leak in deferred qdisc
 drops
To: netdev@vger.kernel.org
Cc: horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net,
 Damilola Bello <damilola@aterlo.com>
References: <20260407170214.4157-2-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260407170214.4157-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276103-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,aterlo.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D92973B23EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/7/26 7:02 PM, Fernando Fernandez Mancera wrote:
> When the network stack cleans up the deferred list via qdisc_run_end(),
> it operates on the root qdisc. If the root qdisc do not implement the
> TCQ_F_DEQUEUE_DROPS flag the packets queue to free are never freed and
> gets stranded on the child's local to_free list.
> 
> Fix this by making qdisc_dequeue_drop() aware of the root qdisc. It
> fetches the root qdisc and check for the TCQ_F_DEQUEUE_DROPS flag. If
> the flag is present, the packet is appended directly to the root's
> to_free list. Otherwise, drop it directly as it was done before the
> optimization was implemented.
> 
> Fixes: a6efc273ab82 ("net_sched: use qdisc_dequeue_drop() in cake, codel, fq_codel")
> Reported-by: Damilola Bello <damilola@aterlo.com>
> Closes: https://lore.kernel.org/netdev/CAPgFtOLaedBMU0f_BxV2bXftTJSmJr018Q5uozOo5vVo6b9tjw@mail.gmail.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>   include/net/sch_generic.h | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index c3d657359a3d..61ba54e909f2 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -1170,12 +1170,18 @@ static inline void tcf_kfree_skb_list(struct sk_buff *skb)
>   static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb,
>   				      enum skb_drop_reason reason)
>   {
> +	struct Qdisc *root = qdisc_root_sleeping(q);
> +
>   	DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
>   	DEBUG_NET_WARN_ON_ONCE(q->flags & TCQ_F_NOLOCK);
>   
> -	tcf_set_drop_reason(skb, reason);
> -	skb->next = q->to_free;
> -	q->to_free = skb;
> +	if (root->flags & TCQ_F_DEQUEUE_DROPS) {
> +		tcf_set_drop_reason(skb, reason);
> +		skb->next = q->to_free;
> +		q->to_free = skb;
> +	} else {
> +		kfree_skb_reason(skb, reason);
> +	}
>   }
>   

*sigh* this is missing the following diff - tested it but forgot to 
amend it. Anyway, Eric let me know what do you think, if you like this 
solution I can send the v2 appending the skb to the root's to_free list 
properly.

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 61ba54e909f2..0e4166319c02 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1177,8 +1177,8 @@ static inline void qdisc_dequeue_drop(struct Qdisc 
*q, struct sk_buff *skb,

         if (root->flags & TCQ_F_DEQUEUE_DROPS) {
                 tcf_set_drop_reason(skb, reason);
-               skb->next = q->to_free;
-               q->to_free = skb;
+               skb->next = root->to_free;
+               root->to_free = skb;
         } else {
                 kfree_skb_reason(skb, reason);
         }


