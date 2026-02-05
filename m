Return-Path: <netdev+bounces-257218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONZdOUqthGk14QMAu9opvQ
	(envelope-from <netdev+bounces-257218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:46:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E4EF436B
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67FB6305854A
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F92241B346;
	Thu,  5 Feb 2026 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POHMtUfG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aa6tYdNk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08F041324C
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302666; cv=none; b=YQeA4e4rI2f0H+f6YcVtrQc+VGa4AgEajOtfzvQ1U4BOR75VD00HyRPY9o/haeNRhASwgPy5qrvTANAtBH7tu8JOFNbZyueVFuWv7LRpN3rTK7ZnovS9/BGtFhjm1T+sgmF0vQMV3iUdO8p/naN6QO5+KTTgLhTq0KhQrXvk7RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302666; c=relaxed/simple;
	bh=PIqaVXNQ5avKJlj+GDHcP0gyG7eXBn59rD+0P/4iLvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYo7pUJ8JnJItOTaoUOSnd4gJXhuY1+P6kT81srzpbRx2ydNXoNdJH+7EgIfaAEZBqDIvcJfC1S7RoY7J2R0EUi7zZP/NUoqkxdF3iheW4SEgN0v2YR8nCbyPpBNYooIAj0n5cvWYtv4Gpx/iHkXALQCmih9V/Zgfzpw6SBIrzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POHMtUfG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aa6tYdNk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770302664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31gdjaItHe4PG098cF4IzTnQcXvjAVhk0kFze4dcVRA=;
	b=POHMtUfGvD2cq+nZd/yMDYMsd7aWddReTirrHGcLp92SzAZGdDcTu6/+mstSg8Kh8/+RGn
	U0h8otQ+KvaCopcKoPMtgwamglvMPXU4/Qk+XlzG+vLIJPbPpD623Dyi/4AK9GStu48o4a
	zKc7GsWnoPQFGUaZJxin5zTPkSDhitw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-GpeARV0BNrWsssfPGghN8w-1; Thu, 05 Feb 2026 09:44:23 -0500
X-MC-Unique: GpeARV0BNrWsssfPGghN8w-1
X-Mimecast-MFC-AGG-ID: GpeARV0BNrWsssfPGghN8w_1770302662
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-431026b6252so1139852f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 06:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770302662; x=1770907462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31gdjaItHe4PG098cF4IzTnQcXvjAVhk0kFze4dcVRA=;
        b=Aa6tYdNkcLi2hzY1rEPFEeB6WkQeQ+Hge/3fl2HTe9Ys/4LIpkYW/mIoKuPp1uZHQ0
         UL5HLifz0IlaMHNlslaKY355HwY68cR1wmW+1f7+wMOPBZDtEBIyPFjhxuqMOLXTfNlc
         X+BmUQjwUsUcffjzyKZRj8Q2ANGTcRzQC51JyWDw+RHYx5H13xM3rw/aAAVqFGAG4SS6
         YhTBGQtTFaOk/IIJns0bU4ue2CHbwmLKIja7SajbUaittyos+bGKdOxanWw5inRBq7RS
         N7KECfpcccqzKjWeXw4gPPxFZzdNbzfSv8SnBi/pEoDCJm/gT0AERKWvmFnZvbGBRoNw
         xhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770302662; x=1770907462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31gdjaItHe4PG098cF4IzTnQcXvjAVhk0kFze4dcVRA=;
        b=aQbwpo9In37eWHLyJeuH7GW4aP3wsrpV1x7OBOB7jhUPfzNNa3Kx8KWqIRCpinUOX8
         E2U58zgl50w2jQXRcOSECZjlc7McTSipiQ062TLi6bwEodt/EoZutYea36/kGSNfSw5B
         32GissjfYFS+DWE4xTQrgXQObOjYfGaAtfR1ARe+c0WeNaL0U7aiLpAsxfaKpIadd4KQ
         MqS+dh3O/GT6LLVWA2l+X0/aNE7AbTAXTIaWCfQRB3EqDU3gKXr2GlxQN5bQIeSjxTxS
         yl1WR/mexy5PFzwB1QxXUq9OFTdqS2VrhW3Ylljn4bTosAccgXVK2dUVRFwByoya2npf
         QFQw==
X-Forwarded-Encrypted: i=1; AJvYcCU0nW3sZ/yRtaEziXN32N49MiURqszqi2yDpndVvang5lS9efYV8N85uU+NxVlCoCEbQZVRNtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwySuqgY9NQXs3qnofE7a6InOVXh3T3oElYY3IK1XLO/y9FrcPm
	dHhqJMrvCJeTdNpW2e+mbIYQUC5ugsZgLHCfBmxBMVK7cdjar2j6sXtx/Lcfk42+glJIr9obgHb
	wN9cWLM1rDMCW/o+At30mpCP1bv2dNp6/HF/kXa6yLtm0ll9a8cB4U85YZA==
X-Gm-Gg: AZuq6aK2VIOT70tqdx29fhnkiIDYhAZgEybclbXgCCZdPWXy2uYDrHQvhSQ1F/BZrsC
	QTGc6ZO7hiteSkxFkV7IwbtVpIhq+4jCO1AYJUUlAhAZO95Ehbb/U5jeaHz3iXSl2DH21beohu2
	DWZcMKTzQUFLONOQcnMldhyOTfY+H9numgPjEZSgFZDr2FlTfuaifbAaFQX/DqFBvTr3oEhhuAb
	3tJBIZF8zvq6vU+kQJU+wolll6nESDqKKZBqVgt8lx+nUbJD24b5CKQovxLG/p+/ivmj99LQ2Te
	wFBHKAMCcY01khCZt350U3DcxA4L0GRyGjWhlFjStGkqCS/+/L4t5Xf9CT1K+8hsEWD/6MykM1X
	ZHwGU4gbqvfcP
X-Received: by 2002:a05:6000:60f:b0:430:f255:14b3 with SMTP id ffacd0b85a97d-4361805cf28mr9267198f8f.43.1770302662128;
        Thu, 05 Feb 2026 06:44:22 -0800 (PST)
X-Received: by 2002:a05:6000:60f:b0:430:f255:14b3 with SMTP id ffacd0b85a97d-4361805cf28mr9267141f8f.43.1770302661687;
        Thu, 05 Feb 2026 06:44:21 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180647aasm13164858f8f.41.2026.02.05.06.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 06:44:21 -0800 (PST)
Message-ID: <49573634-3837-4f35-908a-44ccdadca1f8@redhat.com>
Date: Thu, 5 Feb 2026 15:44:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: dsa: eliminate local type for tc
 policers
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260203172207.98533-1-mmyangfl@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260203172207.98533-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257218-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48E4EF436B
X-Rspamd-Action: no action

On 2/3/26 6:22 PM, David Yang wrote:
> diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
> index 596ab9791e4d..a2b1b752958a 100644
> --- a/include/net/flow_offload.h
> +++ b/include/net/flow_offload.h
> @@ -275,7 +275,7 @@ struct flow_action_entry {
>  			u32			trunc_size;
>  			bool			truncate;
>  		} sample;
> -		struct {				/* FLOW_ACTION_POLICE */
> +		struct flow_action_police {		/* FLOW_ACTION_POLICE */
>  			u32			burst;
>  			u64			rate_bytes_ps;
>  			u64			peakrate_bytes_ps;

I find a bit unusual put the new type definition inside a wider struct.
I think it would be better move the struct flow_action_police standalone.

/P


