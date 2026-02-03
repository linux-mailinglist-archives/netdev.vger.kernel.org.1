Return-Path: <netdev+bounces-256309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O8zDwYBgmmYNgMAu9opvQ
	(envelope-from <netdev+bounces-256309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:07:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46201DA573
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E953300407A
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0B03A1E60;
	Tue,  3 Feb 2026 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQQhPhdy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jnEO8uZW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F703A1CE5
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127615; cv=none; b=J5wzjFuRM6/VTMcCOucBiJRfj7pMEqA4/GRv2JrIKZZc4e152HVnlGkSg9cj4pmKa5l1n1YU+0WZRCNj4jnezP6APXQAsgkICoyAt+1wVgQXtT1bVBf0Xv7/8Fx3XMp93DkZqcN0m0Xb8Pdn3icss0FOYMmf4+JEbdit7v5KBow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127615; c=relaxed/simple;
	bh=tIlOcpMjb64Af1TfgwUmeDw5SEtHH5pjRN0eW8zbzfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Qm2p0n2KrKgQ1AM8S/2y0tvQeyZpb5JWmqL7R9/w9E49n5lwyDgU1Dr6h9Ajw2ueC8nCs3APBsdJsWufBXhEz4SnGt8B9uX+A5gNYx0n7QisPII8fOj+wAZ802zKbxIKBxAf4yZ9kzsBPInoqNu62FIkvOxefs74nfxEXXfVr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQQhPhdy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jnEO8uZW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770127612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BqOENDVrLPVdKFJluj41Yh7xT50IN2VP3lUDw1LUdFc=;
	b=MQQhPhdyoRIfEBMWjJfFGOvHdZFCcwIeMmViJQcrdRNjpdXFvmNJkw0jTfVyuyWWUrQg2D
	iq++5A80DFxAN4CRP4/eF+PkO22YYaAcxEgpwohP0yIVskw+c3UgtyGFpO18vz+0Jyz2Gp
	LvpFHMtmYnnIgmaGlKRWOlQZQkWF/Xk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-eT4kZoOzOSSC7jKbPrckGQ-1; Tue, 03 Feb 2026 09:06:51 -0500
X-MC-Unique: eT4kZoOzOSSC7jKbPrckGQ-1
X-Mimecast-MFC-AGG-ID: eT4kZoOzOSSC7jKbPrckGQ_1770127610
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4359e322f30so4136767f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 06:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770127610; x=1770732410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BqOENDVrLPVdKFJluj41Yh7xT50IN2VP3lUDw1LUdFc=;
        b=jnEO8uZWRruANnVxvH7oFmgbtoLwJ5WVFwLFka6AS1ELfvIaP0mjyDV8mP8ObUxuHq
         Tbtp65Jjt1kH2FgakRMdgf9j7TI7W1F+y5TZC93xj7Lg+oNMspJwzQuWiUs04dOeWLI/
         JqFxxRAv82gntAbiMwrtXFqUExh+PrwIR+NPjaZQLZAMmqb1Xj/geHhsxTFxss7K1Vlw
         +GTOhO5lFPEn20Vv86/vIOixnQRjPo/TW3rokWn6yYTQmeMe0batOhCIXnUGdUbAmMu4
         lFgD1ccIoccdqdXC19ioJh8Uw15glKet9h0lk1ndHC9ciVE2Qz0+o5n9FYxjw88ICl/r
         e9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770127610; x=1770732410;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqOENDVrLPVdKFJluj41Yh7xT50IN2VP3lUDw1LUdFc=;
        b=dRNsvGZLYs/NaluOmHImXQs7fg9p9VhARRWX+3Nn2tQ+BCfe9B5ytDIJVUpjg2PIgL
         Dwcr4m5YmN9sgyRkzBLX96b2VHBmWN3QTBuE6bcFq//z9RyNCG3Tw2D3DYEPGnHbK22R
         et9M9nZAVHK4Vs5Lfo/ZHpyJYTULAxvf5HZHGgO7+5tCWxNDK7N3aTDOiQVGAeP2ADFg
         AAdjuN1R2MyPzSNtZ9UG6Gtb66kaA/apYMMOg5T1ul06myn9YYIXPtfY1iybCEBWplBe
         2dEQ9dRaGcFAGV3Fpo6X4JNiPwlv+b+zGotdCd/k57sZLvEmrCa2LltYo6XDSfnYF5dQ
         h/nw==
X-Gm-Message-State: AOJu0Yz6FbHTe1QYXu/6MnQgtgkAkqsz+xjMDZ6oLuHHH2demmoUNoTx
	AL1nZ+pZdIYZQlI8VNExCYkwxiu6n6dJniJgt/sLnOfVVNFAkoD9llW+PepWLA/05pBP8IOFQSg
	c03t8Fp18xXjFFW2wJzCTUsH+wQQWr2PtFH/U+5CWEZ1zBrEkYpdjFwpJvA==
X-Gm-Gg: AZuq6aLOpvy5B9rTpxrYUCxnv8omVUAaWDrpQaDPzFLZ/VKD9ZX5C4zOtsfJkaQZJ3K
	Ta76DQRnWm27YxmSPwsXL2x5Nad3A5IUmzpsy0kRHwt2fWjM9W3nCQI5ZgWld8FrCP75G8OUVzO
	Cj/gO7hFOULlcxdjFo6t9HHb9FyecOQoWHIA4UPh/J7f1GuRa3w5Lv1AkdLgfYmdnFFkY2cfWBu
	ZlUP/AxANBzcFR7E8Z7VnbUlUfD8ozElNf2LOgjvyWHiGdx5cWwk8/yvj4z+EM1TGdjdwB0UySy
	1XCSQY/z9WYGx3HhwCAvEaW1juouJkDrqdJzBX+NVygQ0k6OXsb5UOrqMSUD85klhYoHgE3V8Ny
	RpO7a+z6Gu7k=
X-Received: by 2002:a05:6000:2481:b0:435:94c1:3714 with SMTP id ffacd0b85a97d-435f3a0bb4dmr21083130f8f.0.1770127609672;
        Tue, 03 Feb 2026 06:06:49 -0800 (PST)
X-Received: by 2002:a05:6000:2481:b0:435:94c1:3714 with SMTP id ffacd0b85a97d-435f3a0bb4dmr21083100f8f.0.1770127609226;
        Tue, 03 Feb 2026 06:06:49 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1323034sm54728853f8f.35.2026.02.03.06.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 06:06:48 -0800 (PST)
Message-ID: <bce76f46-26cc-4297-952f-4adcdac90c94@redhat.com>
Date: Tue, 3 Feb 2026 15:06:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v13,net-next,09/15] tcp: accecn: retransmit SYN/ACK without
 AccECN option or non-AccECN SYN/ACK
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
References: <20260131222515.8485-10-chia-yu.chang@nokia-bell-labs.com>
 <20260203123556.223388-1-pabeni@redhat.com>
 <AS8PR07MB797366B9A7E163A7B88C13C1A39BA@AS8PR07MB7973.eurprd07.prod.outlook.com>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <AS8PR07MB797366B9A7E163A7B88C13C1A39BA@AS8PR07MB7973.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256309-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url,nokia-bell-labs.com:email,nok.it:url]
X-Rspamd-Queue-Id: 46201DA573
X-Rspamd-Action: no action

On 2/3/26 2:56 PM, Chia-Yu Chang (Nokia) wrote:
>> -----Original Message-----
>> From: Paolo Abeni <pabeni@redhat.com>
>> Sent: Tuesday, February 3, 2026 1:36 PM
>> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
>> Subject: Re: [v13,net-next,09/15] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
>>
>>
>> CAUTION: This is an external email. Please be very careful when clicking links or opening attachments. See the URL nok.it/ext for additional information.
>>
>>
>>
>> This is an AI-generated review of your patch. The human sending this email has considered the AI review valid, or at least plausible.
>>
>> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
>> ---
>> tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
>>
>> For Accurate ECN, the first SYN/ACK sent by the TCP server shall set the ACE flag (Table 1 of RFC9768) and the AccECN option to complete the capability negotiation. However, if the TCP server needs to retransmit such a SYN/ACK (for example, because it did not receive an ACK acknowledging its SYN/ACK, or received a second SYN requesting AccECN support), the TCP server retransmits the SYN/ACK without the AccECN option. This is because the SYN/ACK may be lost due to congestion, or a middlebox may block the AccECN option. Furthermore, if this retransmission also times out, to expedite connection establishment, the TCP server should retransmit the SYN/ACK with (AE,CWR,ECE) = (0,0,0) and without the AccECN option, while maintaining AccECN feedback mode.
>>
>> This complies with Section 3.2.3.2.2 of the AccECN spec RFC9768.
>>
>> This commit fixes a bug but lacks a Fixes: tag. Consider adding:
>>
>> Fixes: b40671b5ee58 ("tcp: accecn: AccECN option failure handling")
>>
>>> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h index
>>> a709fb1756eb..796c613b5ef3 100644
>>> --- a/include/net/tcp_ecn.h
>>> +++ b/include/net/tcp_ecn.h
>>> @@ -649,12 +649,22 @@ static inline void tcp_ecn_clear_syn(struct sock
>>> *sk, struct sk_buff *skb)  }
>>>
>>>  static inline void
>>> -tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr
>>> *th)
>>> +tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th,
>>> +                 enum tcp_synack_type synack_type)
>>>  {
>>> -     if (tcp_rsk(req)->accecn_ok)
>>> -             tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
>>> -     else if (inet_rsk(req)->ecn_ok)
>>> -             th->ece = 1;
>>> +     /* Accurate ECN shall retransmit SYN/ACK with ACE=0 if the
>>> +      * previously retransmitted SYN/ACK also times out.
>>> +      */
>>> +     if (!req->num_timeout || synack_type != TCP_SYNACK_RETRANS) {
>>                  ^^^^^^^^^^^^^^^^
>>
>> Does this condition match the intended behavior described in the commit message and code comment?
>>
>> The commit message states the TCP server should first "retransmit the SYN/ACK without the AccECN option" and then "if this retransmission also times out, to expedite connection establishment, the TCP server should retransmit the SYN/ACK with (AE,CWR,ECE) = (0,0,0)."
>>
>> The code comment states "retransmit SYN/ACK with ACE=0 if the previously retransmitted SYN/ACK also times out."
>>
>> Both describe a two-step process:
>> 1. First retransmission (num_timeout=1): without AccECN option, but WITH
>>    ACE flags
>> 2. Second retransmission (num_timeout=2): without AccECN option AND with
>>    ACE=(0,0,0)
>>
>> However, the condition `!req->num_timeout` evaluates to false when num_timeout >= 1, causing ACE flags to be cleared on the FIRST retransmission, not the second:
>>
>> - First retransmission (num_timeout=1): !1 is false, so we skip the if
>>   block and clear ACE flags to (0,0,0) in the else if
>> - Second retransmission (num_timeout=2): !2 is false, same behavior
>>
>> Should the condition be `req->num_timeout < 2` instead to match RFC9768 Section 3.2.3.2.2's requirement that ACE flags are only cleared after the previously retransmitted SYN/ACK times out?
>>
> Hi Paolo,
> 
> This is correct because the increment of num_timeout is done after this block.
> 
> There are 2 places doing the retransmissnios:
> 1. In tcp_timer.c, you can see that the retrnamission is done via "tcp_rtx_synack(sk, req)" and the counter increase via "req->num_timeout++".
> 
> 2. In inet_connection_sock.c, the retrnamission is done via "tcp_rtx_synack(sk_listener, req)", and the counter increases via "if (req->num_timeout++ == 0)"

Ok, I suspected I got lost (and the AI with me). No need to resubmit, I
think we are better of merging as-is.

Thanks,

Paolo


