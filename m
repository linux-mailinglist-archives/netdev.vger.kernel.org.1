Return-Path: <netdev+bounces-278325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEeGKV3y3WmMlQkAu9opvQ
	(envelope-from <netdev+bounces-278325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:53:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DD93F6C3A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35CC2302B22B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C620386C34;
	Tue, 14 Apr 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4ZAe5bU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wu97ZrmI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7570138643E
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153174; cv=none; b=q/BqpE+ZQr2DeyFmLwgueGClxoTLlXo9oAhvfFJ/eiPXBWdKFF45ZYQ/TFeoSLR9Cn7H+viN6kzUOdcASJ32LFL2YgKWPLUhZDlLG33DKp4zH+nZFB9CNDKr0gu4kJXsMGgkDMSrmuJcn2OWOUCpgjYvmTxAZUyYRGRjeARMrGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153174; c=relaxed/simple;
	bh=60TjoW69SEMYV67rWJZm3IfUOon1lXHM5dTsc4GhQ8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpDk6w4Uv9Rb83crix6v4D1Ti4y3hq6f9QSicB0BQu+y2xrbGjQkeCz4s5oT3DnC9AqHdnQze4dlHWUkPVg+UG+i9CJImDdaQ6pX3xCRLqg/plp+qrBvtcPGtj/eRMr98EmUXo1b7W5P6XVTcGQOmhq0FXM/7k1VLJu6NPWNfc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4ZAe5bU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wu97ZrmI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776153168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWXdQM8N5cexjRjQLADCVxhOXrX5mzn8j5y2kffSwtA=;
	b=c4ZAe5bUn8okjk9IOB7onmqz9Gc3yyStLrvD4r85EMuK4tKaKMLSM2wlJuiBGpZb/j8psX
	suBr7jhLhRpCscRa4m6f2c5HuuG9Ikpls2ApkRnjIryL2VYMRCNTrkD7xMpqOpo16nKCVD
	1lGyTfdju88ODvNlHzTRUR2uTTlctjc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-_rnyaKQNO-Cz1uUQnGw1tA-1; Tue, 14 Apr 2026 03:52:47 -0400
X-MC-Unique: _rnyaKQNO-Cz1uUQnGw1tA-1
X-Mimecast-MFC-AGG-ID: _rnyaKQNO-Cz1uUQnGw1tA_1776153166
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488ba2f4094so35944715e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 00:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776153166; x=1776757966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWXdQM8N5cexjRjQLADCVxhOXrX5mzn8j5y2kffSwtA=;
        b=Wu97ZrmItmAnENWjSNw9Sln87t7rroUAlBb/YBygawDF7jfkFTcBLlycaKaweiQKXl
         nwbn+2OAk7VYK2yk/0KOMrSR6ilvLHAhClXbEw42nKkO6C/9LAXFv/Azh12aheouwvZw
         gQfJhB821ZboU+AZJp95vgVU0wJbQEzOQeoxAl+pK8NN7mdZB2+VIENgau6UjHAZE2T6
         8+vouCh5G/WSzmKhE2DQe3tH9nK/hEY/9Z3POp2WTXgIeOs5KFxjioDOVvgXb43kHY3m
         dvsYE+w31s43tn0MqCjVm5SF3CgGBT5+jL4e52XqLR83jAVIkunG12ZbrPPFxIyJ+3vB
         d4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776153166; x=1776757966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWXdQM8N5cexjRjQLADCVxhOXrX5mzn8j5y2kffSwtA=;
        b=PjBZQOLyyYRtr4nScCuz7TPkHEKnLqJVl4QuByivBF1m9u2IbM7ofmIvTvIK+40BLt
         JplOR7ccm8DaY0FClCEr8ssN4JphS8n5tKndO3GyWn9UU0Mbm3dUnZCcOt95K00zUOyP
         rJwj0zD6eAVnum6PVQV19iYyoO3rXAIStvt1DU4hwAXkjqrx7dfKra3TwAy7gRWlIRsU
         oO4qpzOeiFn2w71I54xE4ttCh6v52hU44RaXE3LG7dMHC6r7bWEyErApy2fYwDLwvURe
         g3e8Gle2htNg70Lwqcqq34bNrPmyeLtVSK1RswUHl/Ho2LMiq+P3j52l8UoDCKqPpMBn
         B7wg==
X-Forwarded-Encrypted: i=1; AFNElJ8Q+Jb1lxsCjoRq5WulV4Ez3bUT9twV6RTOord58uCLqXRBhWxYYUsRJZeoNGJ7zsDmlDjXMUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7U+iLq6g+k9gtAsKBVaFUIuodZZZsk0eSbuOEHa9o6hMyRE8L
	+J0w8Nid8k3b0L3dI/NzGEBHJg0clmuTlskb8uh1JbZ+36P15lzkE+/ZXQpf2vnQM/pHWkRZeEZ
	2wnAS2gdTCmZoUlrTqUn1Js4NZgLXtFWOlfxpOE9ZAcfucONgFRIZQabhhA==
X-Gm-Gg: AeBDieu+G9QCRjx4UL9uNmH+XKnCdJk/iqnpokRz24Vp4cHygTWewnVwVLliZCymiUW
	2crS8Aks110wrIKqZMvx7+v1G/+3Q0zBYz2hnmy4lPCE4b51jze4SG3xQHDzQpUNYiFML10kPxN
	2h7oAm/iUhqaGA6k/lumbpv8xFS6mj0CnE3cUkrfjD2B7FUJM5ItkPCWcpq0XDO1FjfMjAj5iKl
	pgJRqhBEcp/Ck69bc2MImcPHE3pM3uz5B3NEtjX6jB2DsoMeUEJlJWhh0Clefk+pObu13dS8bkf
	CLbGrOaSGW1TqYN43pL6fblsvgQ+Qj0e70ofF2vDIPILj54oVSLPGcIMRmicUNLJw8T62NfihBU
	11Ce4qQd4bP+2WDQhodwcQy5v9LfvQoRvuZ/UnL4h/GRZ4XFeeIKHIDPH
X-Received: by 2002:a05:600c:a11b:b0:488:bfc3:efc with SMTP id 5b1f17b1804b1-488d66559d0mr191102605e9.0.1776153166219;
        Tue, 14 Apr 2026 00:52:46 -0700 (PDT)
X-Received: by 2002:a05:600c:a11b:b0:488:bfc3:efc with SMTP id 5b1f17b1804b1-488d66559d0mr191102265e9.0.1776153165760;
        Tue, 14 Apr 2026 00:52:45 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee042e47sm29494335e9.13.2026.04.14.00.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 00:52:45 -0700 (PDT)
Message-ID: <dde1b2da-75cb-472e-a1ce-7f15004cc528@redhat.com>
Date: Tue, 14 Apr 2026 09:52:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] nfc: llcp: add TLV length bounds checks in
 parse_gb_tlv and parse_connection_tlv
To: =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-nfc@lists.01.org, stable@vger.kernel.org, horms@kernel.org,
 =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <framemain@outlook.com>
References: <20260409164129.GO469338@kernel.org>
 <20260409185958.1821242-1-snowwlake@icloud.com>
 <20260409185958.1821242-3-snowwlake@icloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260409185958.1821242-3-snowwlake@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,lists.01.org,vger.kernel.org,outlook.com];
	TAGGED_FROM(0.00)[bounces-278325-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com,vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 16DD93F6C3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 8:59 PM, Lekë Hapçiu wrote:
> From: Lekë Hapçiu <framemain@outlook.com>
> 
> v1 of this fix promoted `offset` from u8 to u16 in both TLV parsers,
> preventing the infinite loop when a connection TLV array exceeds 255 bytes.
> During review, Simon Horman identified two additional issues that the u16
> promotion alone does not address.
> 
> Issue 1 - truncated TLV header:
> 
>   The loop guard `offset < tlv_array_len` is not sufficient to guarantee
>   that reading tlv[0] (type) and tlv[1] (length) is safe.  When exactly
>   one byte remains (offset == tlv_array_len - 1) the loop body reads
>   tlv[1] one byte past the end of the array.
> 
> Issue 2 - peer-controlled `length` field:
> 
>   `length` is read from peer-supplied frame data and is not checked against
>   the remaining array space before advancing `tlv` and `offset`:
> 
>     offset += length + 2;   /* always */
>     tlv    += length + 2;   /* may now point past buffer end */
> 
>   A crafted `length` advances `tlv` past the array boundary; the following
>   iteration reads tlv[0]/tlv[1] from adjacent kernel memory.
> 
>   For nfc_llcp_parse_gb_tlv() this is particularly impactful: its input is
>   &local->remote_gb[3], a field within nfc_llcp_local.  A large `length`
>   can walk `tlv` into adjacent struct fields including sdreq_timer and
>   sdreq_timeout_work which contain kernel function pointers at approximately
>   +176 and +216 bytes past remote_gb[].  The parsed `type` byte at those
>   positions may match a recognized TLV type causing the parser to store
>   bytes from the function pointer into local->remote_miu, which is
>   subsequently readable via getsockopt().
> 
> Issue 3 - zero-length TLV value:
> 
>   The llcp_tlv8() and llcp_tlv16() accessor helpers read tlv[2] and
>   tlv[2..3] respectively.  The outer guard guarantees `length` bytes of
>   value are available past the two-byte header, but when length == 0 it
>   only guarantees offset+2 <= tlv_array_len (non-strict), leaving tlv[2]
>   out of bounds.  Per-type minimum-length checks are required before each
>   accessor call.  Note: llcp_tlv8/16 additionally validate against the
>   llcp_tlv_length[] table, providing a second safety layer; the per-type
>   checks here make the rejection explicit and avoid silent zero-defaults.
> 
> Fix: add two loop-level guards inside each parsing loop:
> 
>   if (tlv_array_len - offset < 2)            /* need type + length */
>       break;
>   [read type, length]
>   if (tlv_array_len - offset - 2 < length)   /* need length value bytes */
>       break;
> 
> Both subtractions are safe: the loop condition guarantees offset <
> tlv_array_len; the first guard then guarantees the difference is >= 2,
> making the second subtraction non-negative.
> 
> Add per-type minimum-length checks before each accessor call:
>   - tlv8-based (VERSION, LTO, OPT, RW): require length >= 1
>   - tlv16-based (MIUX, WKS):            require length >= 2
> 
> Reachability: nfc_llcp_parse_connection_tlv() is reached on receipt of a
> CONNECT or CC PDU before any connection is established.
> nfc_llcp_parse_gb_tlv() is reached during ATR_RES processing.  Both are
> triggerable from any NFC peer within ~4 cm with no authentication.

It would be helpful if you could condense the above text in a
significantly shorter form. Also it looks like the issue addressed by v1
is not addressed anymore here.

> 
> Reported-by: Simon Horman <horms@kernel.org>
> Fixes: 7a06e586b9bf ("NFC: Move LLCP receiver window value to socket structure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
> ---
>  net/nfc/llcp_commands.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> index 6937dcb3b..7cc237a6d 100644
> --- a/net/nfc/llcp_commands.c
> +++ b/net/nfc/llcp_commands.c
> @@ -202,25 +202,39 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
>  		return -ENODEV;
>  
>  	while (offset < tlv_array_len) {
> +		if (tlv_array_len - offset < 2)
> +			break;
>  		type = tlv[0];
>  		length = tlv[1];
> +		if (tlv_array_len - offset - 2 < length)
> +			break;

I *think* it would be better to bail out with an error, instead of
silently returning success. A similar consideration apply to the other
checks below.

>  
>  		pr_debug("type 0x%x length %d\n", type, length);
>  
>  		switch (type) {
>  		case LLCP_TLV_VERSION:
> +			if (length < 1)
> +				break;
>  			local->remote_version = llcp_tlv_version(tlv);
>  			break;
>  		case LLCP_TLV_MIUX:
> +			if (length < 2)
> +				break;

You can probably consolidate all the `length < 1` checks in the previous
one (before the switch statement and add here only `length < 2` check.

/P


