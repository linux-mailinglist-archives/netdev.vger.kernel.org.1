Return-Path: <netdev+bounces-276901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKUVFP9t12k5OAgAu9opvQ
	(envelope-from <netdev+bounces-276901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:14:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C81233C84EE
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABCE7305C8FF
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52F93A9D8A;
	Thu,  9 Apr 2026 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Acb4Uufx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOd9Qscf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77C3A8745
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775725630; cv=none; b=O72zxcdu2KojDS58MVm/mdCrZJAY+TiG6Z7cf7bfbS15OqO6JUDMhDFr5DtnAD5cjGSqZO5Cg4aPRMIvgnlU2kDPq4zYo0vzYCtTEwa+NMasIYwb86kSKrxrnuPi2XbfWIDZ31kN0tH0hpUs6J0T7YY5+ASeMt+JKKgbbGhbo5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775725630; c=relaxed/simple;
	bh=i1wcDeZy472F2DDydaaazwer8mrmQJnIkHi3ESeJhkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yz2V9Eko5Ow+vy9317fQOBbaWw4MZ/opkz8jTuOM7oiiOukSXMJjsks5GookAuSa4d+IEoPDSOGqZ1NkYmWFuS3wxeifDKwMdi1w5HNXqH1CKn+YvaJPqFQflyZPn1kGaIHXjYaICphbYBhtARIfJzuLxtrlGc6s7QI1YWNMoag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Acb4Uufx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOd9Qscf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775725627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kycERlqtaQObpK767b5Smd+ksenhEKvG6OD246qy+Uk=;
	b=Acb4Uufx6UMu6d/87g6O2jTvLbxjs4CxHLSxXQYsRenFuimdXgPWeDf6k09EXniUM3Iqd+
	utpQDh03O18BdhHr0Us4LUSAnrxbyMv0FSJqgpOAEgEMEDAmf1u50GtgYbV9YZI17UaQtR
	A2rZ6eidmXOCuu8rN6vyThSmvUkJZaU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-C6Xq4A69Pj2IaNjpybxZhA-1; Thu, 09 Apr 2026 05:07:06 -0400
X-MC-Unique: C6Xq4A69Pj2IaNjpybxZhA-1
X-Mimecast-MFC-AGG-ID: C6Xq4A69Pj2IaNjpybxZhA_1775725625
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43cf5b4dac8so662063f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 02:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775725625; x=1776330425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kycERlqtaQObpK767b5Smd+ksenhEKvG6OD246qy+Uk=;
        b=DOd9Qscf2y/BK/0L4pi7pv+jZgDNwG72qe78wQhSZEcBkBzXYT62JQ4LgVlux5bYzS
         5O6AJbB/xHGzCDgpwOnzypzqxIqBLfdhTOloc+gguEH/mo36TDHlDiNVeTpec/IPw5NI
         oT32H4f8Kl3p88efaN7zQjZQRIW8E+xA+PGG8+ujw4QKXy3pj/vF1wOichXszSgRKDWD
         U+z0lMyt76rCTwUovMD9P/JNy7gC9t0cRSHOXgebiOBiMZ4Xubshg5khkl3FwgDcpsAt
         syTqGerLJiDGt0pnGHQp4xuVF/sOpl/sElgCoQZin5Ji10NrufmhMqBimjNtOX95gIvS
         trng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775725625; x=1776330425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kycERlqtaQObpK767b5Smd+ksenhEKvG6OD246qy+Uk=;
        b=qIPSx4MHDMg2/khEr0GoglHqKk91qaP7dzvIpnBBwYp3Z040s5gxxp3vfJdHZcnW3L
         5FvdHOOcC/I2FG+CZFNwkBhI6gYr9G/VqQtjVr3FCuR7y8QY4CgyyHQ8JZRXuEPwjZAM
         860UhbYwsyZLhLVmZhByjmZ3ZKNQJftZfN+2ObKNq1m2n1lqs2k95hG34R3+zjIV7xTa
         bGINpBn793HfEPz/u8yWEf9EGfJT5Xikfiqe1xlF96shBGH1s1370VVIsDT6Bpv5wsn+
         9hoppU1/UoQU/qPvC15g873wED1juKJBAga3xxxr+oV9geTJpoknYkjNyV6H7VOq6WP1
         Mskg==
X-Forwarded-Encrypted: i=1; AJvYcCWckp8Fmozz2jXetlue+I+04oYNUAALl9VKjAnQTfaSYiToT+ZqyDbAQrD1KE5eR8TwvoO5i7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHlZ0716RDN4R19kzqv8R3HPR47DR1VADyjVBHsfochyXH0w+c
	5VIW47m80+Kqpz+aqFBMrv+K2dBbVdJihuTYCINuYp49yNemExwvEM6wfrlhs7xOxwRC1Os2mR5
	FK9FV1xFCzsMPgQRQz8xjR3wquUFSDVYFKgsHxEe8LyckPQbC2EHZVhwCRw==
X-Gm-Gg: AeBDievWjo+/2v1Ld0UsN6SM/hDTt654G9q2IipibWLgs2+VBKGnQYZiG2ULPlurElG
	mvFJJFRV8mAewA0bq9z78ni3lcKGp1NRzPxRxuAb5PRJW3R4Lxy4kkSOuUDf8uP40OVxFNUjtHm
	BzjpWwXuNw3I6u76z5z3Ocm+pmJ5GwCGUZOJzKEifBS8rooS42S5C+38Gz9QaabXBf+LQx3d4HO
	kvrhf94wHkS3PpNHS3dRkRAmpvL+DUCfI6PzpG6wu//Vap5z4Mt5bE5NGKg1dVXN6xGEkEmvg/G
	l87GSRcU+VQPLF2lEOCgbBPOhjpUz6NNmgVkXb1swGkybRmEoQQjvIXcfwWZeAm782zUoLIKB64
	sYTR2Q+gXXZ/XZXmOwxaztvmlBmhePXsQBqjALhmXqjVototyF5suQNBg
X-Received: by 2002:a05:6000:4201:b0:43c:f976:b8ee with SMTP id ffacd0b85a97d-43d292dab19mr34931849f8f.26.1775725625157;
        Thu, 09 Apr 2026 02:07:05 -0700 (PDT)
X-Received: by 2002:a05:6000:4201:b0:43c:f976:b8ee with SMTP id ffacd0b85a97d-43d292dab19mr34931783f8f.26.1775725624581;
        Thu, 09 Apr 2026 02:07:04 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d5e969bbfsm2652991f8f.1.2026.04.09.02.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 02:07:04 -0700 (PDT)
Message-ID: <b559c877-7712-4ed7-adb4-d2b667e16e74@redhat.com>
Date: Thu, 9 Apr 2026 11:07:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/14] libie: add bookkeeping support for
 control queue messages
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Cc: Phani R Burra <phani.r.burra@intel.com>, larysa.zaremba@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 sridhar.samudrala@intel.com, anjali.singhai@intel.com,
 michal.swiatkowski@linux.intel.com, maciej.fijalkowski@intel.com,
 emil.s.tantilov@intel.com, madhu.chittim@intel.com, joshua.a.hay@intel.com,
 jacob.e.keller@intel.com, jayaprakash.shanmugam@intel.com, jiri@resnulli.us,
 horms@kernel.org, corbet@lwn.net, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, Bharath R <bharath.r@intel.com>,
 Samuel Salin <Samuel.salin@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
 <20260403194938.3577011-6-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260403194938.3577011-6-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276901-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C81233C84EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 9:49 PM, Tony Nguyen wrote:
> +static bool
> +libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
> +			   struct libie_ctlq_msg *ctlq_msg)
> +{
> +	struct libie_ctlq_xn_manager *xnm = params->xnm;
> +	struct libie_ctlq_xn *xn;
> +	u16 msg_cookie, xn_index;
> +	struct kvec *response;
> +	int status;
> +	u16 data;
> +
> +	data = ctlq_msg->sw_cookie;
> +	xn_index = FIELD_GET(LIBIE_CTLQ_XN_INDEX_M, data);
> +	msg_cookie = FIELD_GET(LIBIE_CTLQ_XN_COOKIE_M, data);
> +	status = ctlq_msg->chnl_retval ? -EFAULT : 0;
> +
> +	xn = &xnm->ring[xn_index];
> +	if (ctlq_msg->chnl_opcode != xn->virtchnl_opcode ||
> +	    msg_cookie != xn->cookie)
> +		return false;
> +
> +	spin_lock(&xn->xn_lock);

Sashiko says:

---
Because the cookie and opcode are checked before acquiring the lock, is
it possible for the transaction to time out, be returned to the free
list, and get reallocated for a new message before the lock is acquired?
If that happens, could the old delayed response falsely complete the
newly allocated transaction since the identifiers are not re-verified
inside the lock?
---

> +/**
> + * libie_xn_check_async_timeout - Check for asynchronous message timeouts
> + * @xnm: Xn transaction manager
> + *
> + * Call the corresponding callback to notify the caller about the timeout.
> + */
> +static void libie_xn_check_async_timeout(struct libie_ctlq_xn_manager *xnm)
> +{
> +	u32 idx;
> +
> +	for_each_clear_bit(idx, xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES) {

Sashiko says:

---
This iterates over the bitmap without holding the lock. Concurrently,
other paths modify this bitmap using non-atomic bitwise operations like
__clear_bit() and __set_bit() under the lock. Will this cause torn reads
or data races that might lead the timeout handler to skip valid
transactions or examine invalid ones?
---


> +		params->ctlq_msg->sw_cookie = cookie;
> +		params->ctlq_msg->send_mem = *dma_mem;
> +		params->ctlq_msg->data_len = buf_len;
> +		params->ctlq_msg->chnl_opcode = params->chnl_opcode;
> +		ret = libie_ctlq_send(params->ctlq, params->ctlq_msg, 1);
> +	}
> +
> +	if (ret && !libie_cp_can_send_onstack(buf_len))
> +		libie_cp_unmap_dma_mem(dev, dma_mem);

Sashiko says:

---
When libie_ctlq_send() fails here, the DMA memory is unmapped and the
buffer is freed by the caller. However, the software tracking ring at
tx_msg[next_to_use] still contains the populated send_mem details and a
non-zero data_len.

During driver teardown, libie_ctlq_xn_send_clean() is invoked with
params->force = true, which processes the ring without checking the
hardware completion bit. Could this cause the cleanup routine to process
the failed slot again, resulting in a double-free and double-unmap?
---

There are more remarks on the following patch, please have a look.

Also, it would be very helpful if you could help triaging such
(overwhelming amount of) feedback on future submissions, explicitly
commenting on the ML. Sashiko tends to be quite noise on device driver code.

Thanks,

Paolo


