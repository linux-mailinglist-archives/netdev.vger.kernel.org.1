Return-Path: <netdev+bounces-194731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7704DACC2AC
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D465188F6D5
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAFA280CC8;
	Tue,  3 Jun 2025 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CaCAcLlk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF048271461
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748941729; cv=none; b=VipAfBeIjliofj7NfQE3uO7DOq0GAZgOCVKMMajHp6Tufuz55Gzgd3KthNxcX1FM6iaGnGaU9EmEFDzSUCBGjpd3dLeuForSnHb2aNdeTM21x+Jku4e1KHnTM9Y9z8+92Ija0j4gGDKDePVqDjuZsqLVjwXRMMTQcKmGqu/Vl1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748941729; c=relaxed/simple;
	bh=ezMQxZDqteiZLAA/4srBnls/BzK+AAArqanNlh+HxyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kthUNdbSihV6SzmFv4WcYqC3WOgd8BG6lTYAiv/Vx5lI1taHtf8vMRusHiv25YKGLAgL5qY6d9DCIwl5Y8A1qaGMIf0L4f6jFXBtshQslgzt3SxrkkZ22Fc1PAco/y5fhh/B+FUHHk+mABwmvteu6FkiQGX1FDcsXKum7k9MCr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CaCAcLlk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so1762445f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 02:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748941724; x=1749546524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SxmD1z6pOp05spuliexBRisj6bb89LYiWTpZD9RghI8=;
        b=CaCAcLlkEQnaoax8ImPDxOPjQK/W5E+2Dn2hkE2Im1w5bBluke6/W4z5oe/sLMdtJV
         G009nTVYgcg+WA7s5c+aGcTxN3JZUduDe5rh47/4lBvmK2zSdslgvoOwN2eCCwrLb/L7
         da+aZMDv3tqCA7j2A6e5AXwWLajJrzEY9ZHFEdKZRrGnDKdkty837v+uktpkDYja8PA7
         KmW4JXPpPIB+aYr5wA4UVfm4rm9xOHZqdUFZ8wjAF674Ci3bqvEN7ADlxVSy53ELi/4U
         JEmNgA8HzjNleLnYaLWhhyuLu1EmRR8hdyM0glwC0ZsxhxQsogu50tDTgISYi8UceszK
         acGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748941724; x=1749546524;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxmD1z6pOp05spuliexBRisj6bb89LYiWTpZD9RghI8=;
        b=VqCTmzYkpF2knBLMnkCw8mWM4+LAP+FudhvhNIR5WCq9csS5YqsYj1HuhBjpoqttOK
         cJ2tTww82jIgoeFKlNJVtElGO7BWKPkDSybV+uu5NiM5VePKxcar5vzRG6O2NUIq0/UT
         fyLHCOv3pMSSe+v3vjqsqmvvdpB0wTWAHLSK66t4tXR7uzBzc7+LXuGMG8jjfkVpviUf
         C88TcYw1p99OXrTsFjZXD55ScsaDToyPKC4dYpBWBoVjp35sFUvmsZmNupZzIMZMvvOE
         Q1dw0av9iMcjm0u81v8h7FI65BJibVosHOvMdVgzmjNf/RjUNQCDQ6ukoiolMSbPVw2W
         YmMw==
X-Forwarded-Encrypted: i=1; AJvYcCVSaCjpi5oLJUmCTFlrthKbTDBtL4DA2FEfWSsAO5qZruU6pvdxL7j4R6NkLAN8yc0M/c3maxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe61zZs3nwJM8KQISC76BPNnhGoErPRrIuKwT86V56QmT3esBB
	ygQeJtpRWyzcyHzqMJbseV4z4IJs8+/2/cNslWCOIuDO1EV+Qccw5ZcdcqNkTmbGHtYWE68e9Ri
	cPVdvrmR6CKEUgqa6dk0H1cbYc62gxGFPYsGF62kSOSVOiNjRwbE=
X-Gm-Gg: ASbGncuGOIUT4XEvBxhWDQowURoHS+YSPYDFA83BKFEF+TR4Ce2OS6DfyLDYRVBn8+k
	9RQQlh/guOFQb/sJpVI/8VbXlA2gATFeBJ5xqQcVkZZKE9Ci8K7qaA2rIIoH4zN17RstAHcg4xb
	aqNbvgiY8FfYNhxte0xOaxwGeuEBH2aeoCNLB12uEqm6cYeQGX6jVig5bKZuKzASIAJyh9xTzNV
	Pz3DlbKjnF8jLavzEWXMdo4YdY5q3Rnvgp8+AcIzazuyQmqPLl0+R8O6WY6XibpHGtSZiVB3I15
	vfzv5RFteIPuTAy5MbYjZoEG4K/DeDQ5RFDooTTMWSDGOgO2BTDKZ6MtfYilwwaw7aIlzNWNA+F
	h1c24gGxZg5RZTmEfgB3XXDwb
X-Google-Smtp-Source: AGHT+IHVb4yHQCJQzNEKYAzuJOQVyV4cQcrfdXVPXWdbvaYw9fuRJQE4zK61t+XXcbZMT8RbQPtAEQ==
X-Received: by 2002:a05:6000:40cb:b0:3a4:c909:ce16 with SMTP id ffacd0b85a97d-3a4f89e322dmr12307140f8f.49.1748941724088;
        Tue, 03 Jun 2025 02:08:44 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:32cb:f052:3c80:d7a2? ([2001:67c:2fbc:1:32cb:f052:3c80:d7a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c7adsm17213195f8f.26.2025.06.03.02.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 02:08:43 -0700 (PDT)
Message-ID: <0b48468a-8635-4211-b7fe-27fd146debe1@openvpn.net>
Date: Tue, 3 Jun 2025 11:08:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] ovpn: properly deconfigure UDP-tunnel
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20250530101254.24044-1-antonio@openvpn.net>
 <20250530101254.24044-2-antonio@openvpn.net>
 <292bd402-f9de-45ac-829a-9cf04c4ce22d@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AFCRWQ2TIWIQTKvaEoIBfCZyGYhcdI8My2j1nRTAUCYRUquBgYaGtwczov
 L2tleXMub3BlbnBncC5vcmcACgkQSPDMto9Z0UzmcxAAjzLeD47We0R4A/14oDKlZxXO0mKL
 fCzaWFsdhQCDhZkgxoHkYRektK2cEOh4Vd+CnfDcPs/iZ1i2+Zl+va79s4fcUhRReuwi7VCg
 7nHiYSNC7qZo84Wzjz3RoGYyJ6MKLRn3zqAxUtFECoS074/JX1sLG0Z3hi19MBmJ/teM84GY
 IbSvRwZu+VkJgIvZonFZjbwF7XyoSIiEJWQC+AKvwtEBNoVOMuH0tZsgqcgMqGs6lLn66RK4
 tMV1aNeX6R+dGSiu11i+9pm7sw8tAmsfu3kQpyk4SB3AJ0jtXrQRESFa1+iemJtt+RaSE5LK
 5sGLAO+oN+DlE0mRNDQowS6q/GBhPCjjbTMcMfRoWPCpHZZfKpv5iefXnZ/xVj7ugYdV2T7z
 r6VL2BRPNvvkgbLZgIlkWyfxRnGh683h4vTqRqTb1wka5pmyBNAv7vCgqrwfvaV1m7J9O4B5
 PuRjYRelmCygQBTXFeJAVJvuh2efFknMh41R01PP2ulXAQuVYEztq3t3Ycw6+HeqjbeqTF8C
 DboqYeIM18HgkOqRrn3VuwnKFNdzyBmgYh/zZx/dJ3yWQi/kfhR6TawAwz6GdbQGiu5fsx5t
 u14WBxmzNf9tXK7hnXcI24Z1z6e5jG6U2Swtmi8sGSh6fqV4dBKmhobEoS7Xl496JN2NKuaX
 jeWsF2rOwE0EZmhJFwEIAOAWiIj1EYkbikxXSSP3AazkI+Y/ICzdFDmiXXrYnf/mYEzORB0K
 vqNRQOdLyjbLKPQwSjYEt1uqwKaD1LRLbA7FpktAShDK4yIljkxhvDI8semfQ5WE/1Jj/I/Q
 U+4VXhkd6UvvpyQt/LiWvyAfvExPEvhiMnsg2zkQbBQ/M4Ns7ck0zQ4BTAVzW/GqoT2z03mg
 p1FhxkfzHMKPQ6ImEpuY5cZTQwrBUgWif6HzCtQJL7Ipa2fFnDaIHQeiJG0RXl/g9x3YlwWG
 sxOFrpWWsh6GI0Mo2W2nkinEIts48+wNDBCMcMlOaMYpyAI7fT5ziDuG2CBA060ZT7qqdl6b
 aXUAEQEAAcLBfAQYAQgAJhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJmaEkXAhsMBQkB4TOA
 AAoJEEjwzLaPWdFMbRUP/0t5FrjF8KY6uCU4Tx029NYKDN9zJr0CVwSGsNfC8WWonKs66QE1
 pd6xBVoBzu5InFRWa2ed6d6vBw2BaJHC0aMg3iwwBbEgPn4Jx89QfczFMJvFm+MNc2DLDrqN
 zaQSqBzQ5SvUjxh8lQ+iqAhi0MPv4e2YbXD0ROyO+ITRgQVZBVXoPm4IJGYWgmVmxP34oUQh
 BM7ipfCVbcOFU5OPhd9/jn1BCHzir+/i0fY2Z/aexMYHwXUMha/itvsBHGcIEYKk7PL9FEfs
 wlbq+vWoCtUTUc0AjDgB76AcUVxxJtxxpyvES9aFxWD7Qc+dnGJnfxVJI0zbN2b37fX138Bf
 27NuKpokv0sBnNEtsD7TY4gBz4QhvRNSBli0E5bGUbkM31rh4Iz21Qk0cCwR9D/vwQVsgPvG
 ioRqhvFWtLsEt/xKolOmUWA/jP0p8wnQ+3jY6a/DJ+o5LnVFzFqbK3fSojKbfr3bY33iZTSj
 DX9A4BcohRyqhnpNYyHL36gaOnNnOc+uXFCdoQkI531hXjzIsVs2OlfRufuDrWwAv+em2uOT
 BnRX9nFx9kPSO42TkFK55Dr5EDeBO3v33recscuB8VVN5xvh0GV57Qre+9sJrEq7Es9W609a
 +M0yRJWJEjFnMa/jsGZ+QyLD5QTL6SGuZ9gKI3W1SfFZOzV7hHsxPTZ6
Organization: OpenVPN Inc.
In-Reply-To: <292bd402-f9de-45ac-829a-9cf04c4ce22d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2025 11:02, Paolo Abeni wrote:
> On 5/30/25 12:12 PM, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>> index aef8c0406ec9..89bb50f94ddb 100644
>> --- a/drivers/net/ovpn/udp.c
>> +++ b/drivers/net/ovpn/udp.c
>> @@ -442,8 +442,16 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
>>    */
>>   void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
>>   {
>> -	struct udp_tunnel_sock_cfg cfg = { };
>> +	struct sock *sk = ovpn_sock->sock->sk;
>>   
>> -	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
>> -			      &cfg);
>> +	/* Re-enable multicast loopback */
>> +	inet_set_bit(MC_LOOP, sk);
>> +	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
>> +	inet_dec_convert_csum(sk);
>> +
>> +	udp_sk(sk)->encap_type = 0;
>> +	udp_sk(sk)->encap_rcv = NULL;
>> +	udp_sk(sk)->encap_destroy = NULL;
> 
> I'm sorry for not noticing this earlier, but you need to add
> WRITE_ONCE() annotation to the above statements, because readers access
> such fields lockless.

I should have noticed the READ_ONCE on the reader side..

Any specific reason why setup_udp_tunnel_sock() does not use WRITE_ONCE 
though?

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


