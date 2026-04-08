Return-Path: <netdev+bounces-276333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDTXC0UI1mnbAQgAu9opvQ
	(envelope-from <netdev+bounces-276333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:48:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B423B8880
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE2C53002F41
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4234221CA03;
	Wed,  8 Apr 2026 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Mj1+EbjK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QPno/2j7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1kKIZ/O+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2lxl02zH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEC1F09AD
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634494; cv=none; b=JGSL4hvnJUD85yzqhxoAAxLwJ6zMEQs/uBIiOOV3hYWpuJQb+H7UFPI8ki6SgAhP2+vC/E7vMNPKZG3amf560auR321jBRG1tut7w+gQmCd5Yg/TmGbKQIb5zqN7cIxhijrv6LPrzym18vXuuVql8sioFs/bYU5C41pdCRWVJCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634494; c=relaxed/simple;
	bh=oxU73agG/K/GsQVHTfPXm5aBMeYayhs45e5gLHSlfx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aI95wjl+Wz9yjdiip27YqG4ga5cdqVQQRYU9RV97vGqPq2FFxRC60kWrODmA3ygoUGnn3sFJ1yd5SY/7VWSJbBjVY5aGNB0bp2y3+2vv0PwD7KmPNfpSO15T6ZwYQa53SedvdLjXmuBy0g2Md5jI2DXXB0wmoC6uPlPZBkacD58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Mj1+EbjK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QPno/2j7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1kKIZ/O+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2lxl02zH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB7B24E8B2;
	Wed,  8 Apr 2026 07:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775634491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0+Iq505/Ifb4Fg4GmNo62XpGFRZrl4gwNyQQ25vOYk=;
	b=Mj1+EbjKI0gB0PZZrLELSNyxCCTYqYOQkC+W1proiXbXhs5dQSzD8L5pARE8GWWIRn4nGJ
	6h5LFN+PFf2tzcDgNfCtsaQ5rT0qoKFglfjlp2I9KRLa9dAwL/5WifqoKAPFqcuQeElOsR
	2v/RdJKE0M0DyBGR55JAqsvfBezy+nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775634491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0+Iq505/Ifb4Fg4GmNo62XpGFRZrl4gwNyQQ25vOYk=;
	b=QPno/2j7JbtC76bCGPjzx1aMpa73L437Mq3iqTu5qk+3jdRF42SLEai+txmepFYh7lJUm1
	B6te2kT4QMb3loBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1kKIZ/O+";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2lxl02zH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775634490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0+Iq505/Ifb4Fg4GmNo62XpGFRZrl4gwNyQQ25vOYk=;
	b=1kKIZ/O+mGSYY74IiN8vH+U/TcFYTNWac6QVeQonlY+LVk3xR/Ez6cI1qHm2LIYsKD0BvT
	zWfV4IEHhq9qF0fF9KKLTsDl3bw85QNb0bNvryBYBzJKP68FA3pX09KABJ1JbsuoQFCkhA
	zZWvOyOfzE6syAyj3FjMlmX6barUoe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775634490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0+Iq505/Ifb4Fg4GmNo62XpGFRZrl4gwNyQQ25vOYk=;
	b=2lxl02zHvXJbCWvYwSihcOworszAeWqBgp27OkfRwbvfOmaaT+iO0tQKcPUGc3Dk1Mtztf
	qks+rUBuaQqcneDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CFF34A0B3;
	Wed,  8 Apr 2026 07:48:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mdVtEzoI1mmXSQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 08 Apr 2026 07:48:10 +0000
Message-ID: <e29b7837-70ab-4db2-b9e5-abb59d8721d7@suse.de>
Date: Wed, 8 Apr 2026 09:48:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] net: hsr: require valid EOT supervision
 TLV
To: luka.gejak@linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org
References: <20260407162502.19462-1-luka.gejak@linux.dev>
 <20260407162502.19462-2-luka.gejak@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260407162502.19462-2-luka.gejak@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-276333-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: F3B423B8880
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 6:25 PM, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> Supervision frames are only valid if terminated with a zero-length EOT
> TLV. The current check fails to reject non-EOT entries as the terminal
> TLV, potentially allowing malformed supervision traffic.
> 
> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
> with a length of zero, and properly linearizing the TLV header before
> access.
> 
> Assisted-by: Gemini:Gemini-3.1-flash
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
>   net/hsr/hsr_forward.c | 20 +++++++++-----------
>   1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 0aca859c88cb..eb89cc44eac0 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -82,35 +82,33 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
>   	    hsr_sup_tag->tlv.HSR_TLV_length != sizeof(struct hsr_sup_payload))
>   		return false;
>   
> -	/* Get next tlv */
> +	/* Get next TLV */
>   	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
> -	if (!pskb_may_pull(skb, total_length))
> +	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
>   		return false;
>   	skb_pull(skb, total_length);
>   	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
>   	skb_push(skb, total_length);
>   
> -	/* if this is a redbox supervision frame we need to verify
> -	 * that more data is available
> -	 */
> +	/* If this is a RedBox supervision frame, verify additional data */
>   	if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
> -		/* tlv length must be a length of a mac address */
> +		/* TLV length must be the size of a MAC address */
>   		if (hsr_sup_tlv->HSR_TLV_length != sizeof(struct hsr_sup_payload))
>   			return false;
>   
> -		/* make sure another tlv follows */
> +		/* Make sure another TLV follows */
>   		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
> -		if (!pskb_may_pull(skb, total_length))
> +		if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))

Hi Luka,

why is the length adjusted here? The current total length was adjusted 
correctly above see:

total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;

Thanks,
Fernando.

>   			return false;
>   
> -		/* get next tlv */
> +		/* Get next TLV */
>   		skb_pull(skb, total_length);
>   		hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
>   		skb_push(skb, total_length);
>   	}
>   
> -	/* end of tlvs must follow at the end */
> -	if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
> +	/* Supervision frame must end with EOT TLV */
> +	if (hsr_sup_tlv->HSR_TLV_type != HSR_TLV_EOT ||
>   	    hsr_sup_tlv->HSR_TLV_length != 0)
>   		return false;
>   


