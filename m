Return-Path: <netdev+bounces-252393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CHMF5JDcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:34:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAAB68F6E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58BE49A7535
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5693612C9;
	Thu, 22 Jan 2026 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrEpCrf8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oKhOxIMg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C962F35CB8D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093868; cv=none; b=fFYGf9yFItIympMz+8QV61NUtTTlYqt7sOZfdKndiL2NXjZS3Vg+1Wu+/fDZ+L7C7lHz/7ezxN+PYh5dgsRDdcjpADkX1AKZsu3DAtUKVmbwFX0hlevyA0HtpwsmqiFi5KUAUZKGdlQNr0X8WEPV7ngaOyrTEKahzhDunLy0oHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093868; c=relaxed/simple;
	bh=aoXEQP/jbr4OlpCMv7lwXCCcOcxcNhPxgX9SwqtpX3I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s5+uPr9bjdGmM+zT/moXMOm5EK9KAm01G4oCUoH+Mqj7d5iv8BBtspBNp9/QJym0tyyoQOXxjTtVBAOkrsunqFkjsKKTB6yMFygImLTIacq8oBIPGiwUI4GL1hrpyYbS8obiAy+g8EMQe2p1kWKRZ2XsXY081K/xV95XJhEIc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrEpCrf8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oKhOxIMg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769093865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0stwt8+yHnGWH3Ffy/uFrriSPn1kjpKm1Fo6aZDEo1w=;
	b=WrEpCrf8qTQOY7DNo9iVEpeuKbggu+2fNZM54CKh6nyWIMOUWC6SLDOXSbJ0mmVVyTfZoV
	OtptnkhEQpPhw+rpgDH/p8lMZGILkOpWx0G4Keb5WwHAWE62GL0vyeaahQBrtMF6i0yoDf
	Km+w29Y5/J3BkJnUqpobckI6nVM1lxg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-_wJJ0PlNPeyJlwie--Op3w-1; Thu, 22 Jan 2026 09:57:44 -0500
X-MC-Unique: _wJJ0PlNPeyJlwie--Op3w-1
X-Mimecast-MFC-AGG-ID: _wJJ0PlNPeyJlwie--Op3w_1769093863
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43284f60a8aso831794f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769093862; x=1769698662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0stwt8+yHnGWH3Ffy/uFrriSPn1kjpKm1Fo6aZDEo1w=;
        b=oKhOxIMgFSe/CYn22nW9SdkFa1agRvmNWIMdV86jgsOdcILVcqNfY21rf7BHmw9GXC
         ItIiR3RE6GZLU+fBXjY5S6+Ft4JS/DSr1wMQxePnPE+rOjV7WnFUilzCn4yi5jIZnPB/
         GB8hEo1D9ramiau7txjcwNQkdCeEG6f6EtV/F+kPG4EIoi6gIdL95zS7KJbIuPIgxg0V
         /eZknqgtnlxfQ7jYFU9aZTAye00qcMcrvH256jJc3R30bDki/YrtawBASO4npp/wT9rs
         XR0Rb4+sBHJzmwN731Zl7+g6fvEelyuoWSAHlHGMi/B/2WnezEGGwqPhzuQpTg+DTCD1
         uSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769093863; x=1769698663;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0stwt8+yHnGWH3Ffy/uFrriSPn1kjpKm1Fo6aZDEo1w=;
        b=dHEvXUeX6++LOQ/GvCStAvF7ppkqJqdp+q3S/OM6B06Y8R3bnK7LREqOw/hFijjmo8
         rhvWD/q0BKwzsWuH09vXUJuTC05s6mOO/1H9h2TPmkkIsz5oFonPesGQMWUpSqqYtp1J
         NqeZlrI89WkqYEEb2pGCmUWggZPLYxM1Nm0WNkILbkxjMfuNqjrtTx2R8xzgyQWkOq+n
         +sUfLq+c6JlN1z9gYNWNFPvNyc5O5rJthGmr/jWZl0mXaurkA3hvZX2cVxzLCpokxYxi
         +xyijwB9K4ggdzScH7B7tfeof4ZLmwJ7j1t+xhT27Z/9Z/PJBkavPWshsNs4BJjri01V
         f8ag==
X-Gm-Message-State: AOJu0YwrKOOEqasHd2WCI5CP8roCkcO6Z/S72sddYqJY5w/7I82t67qx
	f295SjBC42BxseZug2KKS5MSXjMxgw78i8WLikIyFmRnfiSNw2ESTb5poEhRGqw8y8SIS3wAZFi
	oIMutBr9hc/XmxV1j+Wnn8bc5/k4Djrvx36PuswbL4//RLzGRg849ApuKSJ1m16ukrUKPwY2uNR
	aWFDiUCeUqfjcG4mk2G8pWbzvBWMYuZdPEZ4NIGwk=
X-Gm-Gg: AZuq6aI9kXy2GW/la1Tq6yzW5nMOxL33RoGOZ4KnYBUGgV7HZHUD/cUs/BA+xv49qUl
	/d0Pb99qq3feM3muR5OI2bxrseggtfk5Mx5Kj65760UVIHvaZRnOxg9b6XHQ3mJUCSKXcoq3dLz
	g8RJM9YyjuNopVnL0XwePKXk7OokF1xOtsc2uPV/86tZ8pMCew3Vdbyk3saTrTy/b/wiVJp19ot
	Valldem7+43BSX515lxkE6EeNs8veJPOP9d4ZIhB50uPPX2CB1o1b0r5SjzCXW6LeX35B71tJND
	TO3efWvvQQBBGMelFPUOez5SjyesWGhP/OU3R4zSOtp4tA3k620bNewp8dSDndSp0AIdVwpF/MM
	gbviS5PCbdSBh
X-Received: by 2002:a05:6000:178b:b0:435:b068:d3da with SMTP id ffacd0b85a97d-435b068d536mr836417f8f.4.1769093862584;
        Thu, 22 Jan 2026 06:57:42 -0800 (PST)
X-Received: by 2002:a05:6000:178b:b0:435:b068:d3da with SMTP id ffacd0b85a97d-435b068d536mr836360f8f.4.1769093862049;
        Thu, 22 Jan 2026 06:57:42 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43596291e0asm16772665f8f.15.2026.01.22.06.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 06:57:41 -0800 (PST)
Message-ID: <c5f875fc-9d87-42e3-bc33-59864e206f96@redhat.com>
Date: Thu, 22 Jan 2026 15:57:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 08/10] geneve: extract hint option at GRO
 stage
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, sdf@fomichev.me,
 petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com
References: <cover.1769011015.git.pabeni@redhat.com>
 <cd0e9dc42ba83f388b604097cffe268ffcb53351.1769011015.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <cd0e9dc42ba83f388b604097cffe268ffcb53351.1769011015.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,fomichev.me,nvidia.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[142.0.200.124:from];
	TAGGED_FROM(0.00)[bounces-252393-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[52.25.139.140:received,209.85.221.71:received,170.10.133.124:received,216.128.11.175:received];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FAAB68F6E
X-Rspamd-Action: no action

On 1/21/26 5:11 PM, Paolo Abeni wrote:
> @@ -566,6 +726,25 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
>  			goto out;
>  	}
>  
> +	/* The GRO hint/nested hdr could use a different ethernet type. */
> +	hint_off = geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);
> +	if (hint_off) {
> +		const struct geneve_opt_gro_hint *gro_hint;
> +
> +		/*
> +		 * If the hint is present, and nested hdr validation fails, do
> +		 * not attempt plain GRO: it will ignore inner hdrs and cause
> +		 * OoO.
> +		 */
> +		gh = skb_gro_header(skb, off_gnv + gh_len, off_gnv);
> +		if (unlikely(!gh))
> +			goto out;
> +
> +		gro_hint = geneve_opt_gro_hint(gh, hint_off);
> +		if (!geneve_opt_gro_hint_validate_csum(skb, gh, gro_hint))
> +			goto out;
> +	}
> +
>  	list_for_each_entry(p, head, list) {
>  		if (!NAPI_GRO_CB(p)->same_flow)
>  			continue;

AI review reports a possible OoB access later on in:

	if (gh->opt_len != gh2->opt_len ||
		    memcmp(gh, gh2, gh_len)) {
			NAPI_GRO_CB(p)->same_flow = 0;
			continue;
		}

specifically in the memcmp() accessing bytes not pulled yet from gh2. I
think such OoB access is not possible: before reaching the buffer bounds
the other packet hdr should match the current one geneve hdr, including
the hint option. Thus, while processing the such packet, the GRO stage
should have already pulled all the relevant data.

I think this is simply too much to get for the LLM, at least ATM.

Side note: I was sure I did the shellcheck test before posting, but nipa
says I at very least forgot about it before some latest update (warn in
patch 10). @Jakub: please LMK if you prefer another revision.

/P


