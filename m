Return-Path: <netdev+bounces-257506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPShAYG2hWmOFgQAu9opvQ
	(envelope-from <netdev+bounces-257506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:38:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C36CFC1F0
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D905300BC81
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E987B35F8DC;
	Fri,  6 Feb 2026 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ad9ZPmUz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="riGcqfwI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00B35F8C4
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370676; cv=none; b=RNqTO704FbuOvydibehrqp5k91AsHR8pAoC3Ic66rFbWcTj3N2DpmYaeuFLt2NDx1kolMCQ0LLJw1EN80jA7BbftIUgqZcH+DPM/bMQspJRuAr/Qpa4tx22DmXQb1qfu1GKOSdH8tb0/qrvSkOQ9sR96zyK+nncFmTcf0DHdrpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370676; c=relaxed/simple;
	bh=APeXJCTiKt5VLYxNjRBpeCoKTELaPpoqO5cqxDIE7YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bs6xWTMuvwQV2mnNF0a3IEgsT0RZfcJ5Qa7JSChLS5Xj4QUbhV8o/PqNCU8Ca3RuEmX1zKXe83+z7cg6wN3EJDX0zSQm9dLp0ZPl702/0V/iPTsXJ985Ak2u0fABvPAEuzDboVOW7ILKHdIAUAEH6HipxF92ynyvC7vQsn15tus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ad9ZPmUz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=riGcqfwI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770370675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ho7HIWUFFrpSkkEX44l5BIRyTWGoj41FbAbjPX58W/k=;
	b=Ad9ZPmUzzhxWZR1gu0/ATCRoLAX12jbPxJKa272pFYQlkZtf9Yi9n9lAVNvSUv74fh58j3
	sSz0ZtjM3xXgww+D9ZgMn7nPUksMSe9DHC0tNjoJOzI4kOdfQ52SVFuiy/9R3iHuIEiWwM
	U1EsaTUXET+fu7dbM1rodDuP71mLT0g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-0E4MO-rIPe6y_iXHVU1rSg-1; Fri, 06 Feb 2026 04:37:54 -0500
X-MC-Unique: 0E4MO-rIPe6y_iXHVU1rSg-1
X-Mimecast-MFC-AGG-ID: 0E4MO-rIPe6y_iXHVU1rSg_1770370673
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48079ae1001so4313885e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 01:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770370673; x=1770975473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ho7HIWUFFrpSkkEX44l5BIRyTWGoj41FbAbjPX58W/k=;
        b=riGcqfwIuu3VcRGvLthuWbHIa7iV2ZfMQWtIvI7Kwm+sPhL785/pP46sPdhNDZ6vuP
         2HrhgP3l5WgUF4IH5AnNAuplZxla+CyTZOvVi32Rm5TvkRl+9Bz16DvjEEVRnyNO8jcW
         YzStCskh6a6douhGsiKu0D9l4wyjSP1WMbZIHd+vIwRw9Hpz1oNYQqabLAmQE0Qh12Wl
         oVqUfy3rHEpKdL0x8jgzOWua6fIqRRE8Mmt4eW7wQaQ/WTo3vosWrRxiRGFDQHV/pn7x
         tk6U30XUq/BoJn7GE/eZMgNMEDLkew5Ph1QZ6Dj/qUc6jmKU9o2Pdnw+ogbbA2KCDJMQ
         fscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770370673; x=1770975473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ho7HIWUFFrpSkkEX44l5BIRyTWGoj41FbAbjPX58W/k=;
        b=p6tc7xN7VmjOcABJdlNbLwaJbx4UyV3hTswEwCT9pZbNnGqJ+No6QYxjQrzAL6Kyfe
         xIhhwYJhRDkMyzctwfHwo5A6WaT6VnSMMk+/rI/PVPFzybmb+wJ51/eHHySoJYoZx9BX
         A2ITRJJHE/YciJpyNUoOQCkhtE4OXaSYD6XqO3QzbWtLZUoh0INSTx+MjAa5uAdqm1or
         R6BXqsMwsZVf3OUHC40K2+WAcQt1EpQ50Bwql9O83qzzQL9feLfrNCGsWsJlBQ9UVK6o
         l7lC1bxdWGJapKPwHJ7PPz8JdqVnKRN4L8mat6eBuJVwGzcki9SR7tSfRx/HleDmMASa
         dP9g==
X-Gm-Message-State: AOJu0Yyez2bzE6yQmkU3cfmZDhdHhyFqgUvfMQF0AUS9wShh6anSrRV8
	2bM8Q76rEboACqKWzsUWqiXM6DPSy6N+ht019IrUtP+VMn8a+r+tI7+LeWihxw43Fvt4TYOPeD6
	WxDjmKbR+vsaZE4y0CRhVTrqKNu3J/iHKzcmcf1XUMJNzOWowd5wDZLWMyg==
X-Gm-Gg: AZuq6aJnfolcrCuaMT44ITfclrn0NM7mglq1MXbvgjwOsiEb8Un1X7SbE+x7hWnTi2w
	7h0xS91+tNCE51QJ5NAggk7L3e33rczsN19Jw3A5pEs0myi7TyP4JoIrJrFiBZARA6W6XdW5r10
	RlWgVtSq935QTj56qZ5nzCAOS7/B5Qo4wJCgS6xFxg7g76F1sX2LpvJLLMGrsnhwKFVkVJV0Unf
	v41C9X0CfNt2rlWCFzhkf9cQhx8BRCzZKGhGVwlJOdcsGiz9saML8cOhDQ3blbRTq0RUw9hSSaQ
	BhS4axCYPih9amguTAONmMytmojrNHr1CQGZjQ+KWj37wy227F7hZ8JWX2qp8dB6dEtgUyDUvJ9
	yxg/Mk8vZHGDm
X-Received: by 2002:a05:600c:8116:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-4832021c74cmr30794215e9.26.1770370673090;
        Fri, 06 Feb 2026 01:37:53 -0800 (PST)
X-Received: by 2002:a05:600c:8116:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-4832021c74cmr30793965e9.26.1770370672707;
        Fri, 06 Feb 2026 01:37:52 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296c0f2esm4511580f8f.19.2026.02.06.01.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 01:37:52 -0800 (PST)
Message-ID: <57948250-bfbe-4d36-909a-987458374423@redhat.com>
Date: Fri, 6 Feb 2026 10:37:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] xfrm: reduce struct sec_path size
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
References: <a2552992ca2fa29754340eaa05b1a185fca7a381.1770309837.git.pabeni@redhat.com>
 <aYUxubug67eqQ6aH@strlen.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aYUxubug67eqQ6aH@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257506-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C36CFC1F0
X-Rspamd-Action: no action

On 2/6/26 1:11 AM, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>> The mentioned struct has an hole and uses unnecessary wide type to
>> store a MAC length.
> 
> Good catch.
> 
>> struct sec_path {
>> 	int                        len;
>> 	int                        olen;
>> 	struct xfrm_offload        ovec[1];
>> 	int                        verified_cnt;
> 
> Why not s/int/u8/ while at it?
> 
>> 	struct xfrm_state *        xvec[6];
> 
> len is xvec, olen is the offload length which can only be 0 or 1 at this time.

I did not look closely at the other fields semantic, other than
`orig_mac_len`, because just the latter looked an low hanging fruit to me.

Thanks for the insight, that will save an additional 8 bytes! Which in
turn is IMHO very nice because it will keep skb_extension size inside
the 3 cacheline boundary even with all extensions enabled.

I'm trying to understand why XFRM_MAX_OFFLOAD_DEPTH is 6 exactly, but
it's not obvious to me skimming over the code.

/P


