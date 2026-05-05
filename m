Return-Path: <netdev+bounces-284267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HLULret+Wky+wIAu9opvQ
	(envelope-from <netdev+bounces-284267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:43:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 253FA4C8CB4
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3CE8301D046
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD422F290B;
	Tue,  5 May 2026 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NW9omGMJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lCaIGj5r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904042C08D4
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970511; cv=none; b=CmOTHa6iIQ1cqzEUVHSDeYRiVO81/RdKb3glFUExEoZzj7EMXDXAxHntLpmGnu5gLIdJ6Em2OTImuktbMBjlH5GQYRlVQ3Bg3UtpJSJe0m3+kCttsXOhhtMlnETE19C7XeoyrpcIigw4K+WEY3t9QRm+U5fh3u7FWBZyLt38yT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970511; c=relaxed/simple;
	bh=9xxhG/3m9ehG0FSFag1gGg+nCTLmPuf0/dxPT53q3IY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e/yEOj5/KWidllfGg/ks5ils1bxNF1lhRDAqNhlncctK8mBVfJODdh9S11dcJoDPmUa3Wj9IbNGF1N/FTsFra4jOzIP8xSkt3MEMlZyA65+MJc3hrZejDy76HMQVb3E+c73hAw7aFZPv/Eng+jxz9YsjqsnsBoeDvqy1PMk2R8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NW9omGMJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lCaIGj5r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777970508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8hKegWyHanwD5VQwgSIlE9XwwTsZ4TMa9xhCdPsYEo=;
	b=NW9omGMJHZ+nX10vwmNgmkXwEcQ+ApjaZlcmRDSWxipeDFuFSDiqni7hCEp7zijjTK9OG/
	U7yyxcNroNpCRsFv+UC+rI+2HN2RHgIklLxC/HZHSbNgkZ688NOqfrLi6uDzEYGgRH6Fs/
	1yix8Keie/MUMW+p4euBW5Vc+1j1EZM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250--BJFBo0sM-6g7nGa8kaB4Q-1; Tue, 05 May 2026 04:41:47 -0400
X-MC-Unique: -BJFBo0sM-6g7nGa8kaB4Q-1
X-Mimecast-MFC-AGG-ID: -BJFBo0sM-6g7nGa8kaB4Q_1777970506
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so3097110f8f.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777970506; x=1778575306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y8hKegWyHanwD5VQwgSIlE9XwwTsZ4TMa9xhCdPsYEo=;
        b=lCaIGj5rpDY1OSLOIRMhnwieEsilhHgzi5v7owg2at9BH89Z5Um1AhUmQkdKy41LaL
         6v5T3cTpOEwWkGY4hAjoct4QvYGc8Mrz20aD+Y/to+eiykkm5GeLhU6CPT7IL3o8ndVJ
         5xC+j/+NaOQ8HqHbHM0j80/e1xKX/gQK2lLxz5djsPLt0mmfjM9308UsvcTbhuj2V9xa
         q0Ds7h1po1vHhr8hogaYMBPHCjlb5LVybLuGxb1rMpfTPJlzZ58VTuSXmno1yaEM0sdh
         1VFpb2Jz6rdtmkhiA2aoxZkq4WupL1eLKbVh0M+cfKznU/lgzjddlGZhHb0ve3oIJUTc
         BzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777970506; x=1778575306;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8hKegWyHanwD5VQwgSIlE9XwwTsZ4TMa9xhCdPsYEo=;
        b=gtq4CFiPghZzQPto9bmlSrctP5pKb67M7sg9pZ1j6n/smCgyUQhylQfiGPwCeKFLDh
         WeOFY/fbj827ornp15/YvKV1ISzhxRpAD/engxq8rONB2SIld5imJ8zIstBdyp6bLOS+
         mgN0F1OiPNpnhB+9Fw2sM1P1OobiykX+4OgQ4JeQnmIzZOekcGK2c2wpOZTxsQkYzhxD
         V5HXSuG/daPjboiZ8YZ59+cUtIHs24adAvzb8vRONoAlcUqQk2QiTtoPrOaX3G18Qjsw
         bZA4QoZznSX1Hib34TRCk/rbQqngLs1qlqt6K18IiilBDDHjBBrYzaTNkwQputLKyiMN
         0ZGw==
X-Forwarded-Encrypted: i=1; AFNElJ8oVjmAoD+gNkmnBDFhUHHukDI3xlcT27FYrPyOB/xMfwvQAg7Yy1GhJuGkX6kXa/YaV0uxQ08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1aXcX9mizZ/3Z973tsSxYajW5rQnekzGx1AhjdQX3ZgDjX98E
	h0gu5XCX2AS5mfwWFnfhMFVH7Icm2hDBWJEGxD35GenvRS0eSvt81DO09NxQdrEAeNdXKP0ivw1
	EGGCGUA2qJ3u0yBK0pum2MLgTgO4JqDQpvuMUo66IOU3FS8SF0m3Gwc2SLQ==
X-Gm-Gg: AeBDieupVTDp4WCXejA9mHkl1zzVdvy69EjUhiGz1NhW1XGE+m0GYPHjtKyJ5T7o8z+
	mFS52OKGtKsTKJdlKtTWmMHfF6rE2QJM063IZOc4QTU+getoQGQCx5nMHr+WEQobsmUlw+YDNm3
	16Vw7MpOHJ9U1nzDc7Gt0IUVEr1sMgXtoGRHxv9BhEbDTR7mAObMYAty0v/L4GpO4ifHLqGEN8M
	gfxqDTxEuNhNXXVketWXE6az6+v+EsWxtIiMlG98+BFdjcvDb/HyhDc6HbmwWRJn8srvuCYcQow
	GKGr/LGQ0JoFrQfpcQqv7Cn37IfuVc8a5r3rwhNUHdLaSSI4ubx7pmQtCUW7Z1JYfB0zDX77qOA
	SRMwl7oEvGSyOXc8JwT0rkKG/t6ykvm3JP22Xh7IclvskKonIxnIA4wCiOpB1xnpYhw8=
X-Received: by 2002:a05:6000:22c6:b0:43c:fb48:6856 with SMTP id ffacd0b85a97d-450041b05ccmr4139865f8f.13.1777970506149;
        Tue, 05 May 2026 01:41:46 -0700 (PDT)
X-Received: by 2002:a05:6000:22c6:b0:43c:fb48:6856 with SMTP id ffacd0b85a97d-450041b05ccmr4139809f8f.13.1777970505693;
        Tue, 05 May 2026 01:41:45 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505238e6e0sm2725053f8f.6.2026.05.05.01.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 01:41:45 -0700 (PDT)
Message-ID: <5766677d-525c-49f7-a3ba-c6e58c0695fe@redhat.com>
Date: Tue, 5 May 2026 10:41:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 5/6] tls: add hardware offload key update support
From: Paolo Abeni <pabeni@redhat.com>
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, edumazet@google.com, leon@kernel.org
References: <20260429181016.3164935-1-rjethwani@purestorage.com>
 <20260429181016.3164935-6-rjethwani@purestorage.com>
 <64d71f18-f86b-4fd7-a6bd-02243eed0492@redhat.com>
Content-Language: en-US
In-Reply-To: <64d71f18-f86b-4fd7-a6bd-02243eed0492@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 253FA4C8CB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-284267-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On 5/5/26 10:40 AM, Paolo Abeni wrote:
> On 4/29/26 8:10 PM, Rishikesh Jethwani wrote:
>> On TX, the NIC key cannot be replaced while HW-offloaded records
>> are still unacked. tls_dev_start_rekey() installs a temporary SW
>> context with the new key and redirects sendmsg through
>> tls_sw_sendmsg_locked. If no records are pending,
>> tls_dev_complete_rekey() runs inline during setsockopt; otherwise
>> clean_acked sets REKEY_READY once all old-key records are ACKed
>> and the next sendmsg completes the rekey, flushing SW records and
>> reinstalling HW offload at the current write_seq. A KeyUpdate
>> arriving while one is pending re-keys the SW AEAD in place; if the
>> HW reinstall fails the socket stays in SW mode (REKEY_FAILED).
>>
>> On RX, the NIC may have already decrypted in-flight records with
>> the old key before the peer's KeyUpdate is parsed, so the old
>> AEAD, IV and rec_seq are retained on tls_offload_context_rx.
>> tls_check_pending_rekey() invokes tls_device_rx_del_key() to drop
>> the NIC key; otherwise post-KeyUpdate records (carrying new-key
>> wire encryption) would be XOR'd with the retired key.
>> tls_device_decrypted() classifies records by old_nic_boundary:
>>
>>   - after the boundary: new-key record; drop the old key.
>>   - before, fully encrypted: advance old_rec_seq, let SW AEAD decrypt.
>>   - before, (partially) decrypted: reencrypt with the old key so SW
>>     AEAD can decrypt with the new key.
>>
>> For mixed records skb->decrypted flags can be wrong (NIC clears
>> them on auth failure); on -EBADMSG, tls_rx_rekey_retry() toggles
>> those flags, decrements old_rec_seq to reuse the nonce, and
>> retries once (gated by old_key_reencrypted).
>>
>> The new key's tls_dev_add is deferred until the old key is fully
>> consumed: tls_set_device_offload_rx() sets dev_add_pending while
>> old_aead_recv is retained, and tls_device_deferred_dev_add()
>> installs the new key once copied_seq crosses old_nic_boundary.
>>
>> Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
>> TLS 1.3 TX and RX KeyUpdate cycles.
>>
>> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
>> ---
>>  include/net/tls.h             |  84 +++-
>>  include/uapi/linux/snmp.h     |   2 +
>>  net/tls/tls.h                 |  29 +-
>>  net/tls/tls_device.c          | 753 +++++++++++++++++++++++++++++++---
>>  net/tls/tls_device_fallback.c |  24 ++
>>  net/tls/tls_main.c            |  92 +++--
>>  net/tls/tls_proc.c            |   2 +
>>  net/tls/tls_sw.c              |  76 +++-
>>  net/tls/trace.h               |  79 ++++
> 
> This patch is really big and complex and you should break it to help
> reviewers.
> 
> At very least you can split out the tracing bits and the trivial
> refactor moving around declaration and definitions to separate patches.

I should have mentioned the following in my previous email:

please wait for more feedback from Sabrina and/or Jakub before posting a
new revision.

Thanks,

Paolo


