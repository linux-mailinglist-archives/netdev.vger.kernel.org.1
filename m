Return-Path: <netdev+bounces-276898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK1WOs9p12myNggAu9opvQ
	(envelope-from <netdev+bounces-276898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:56:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C63C03C8173
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BED2C300D759
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C55F39281B;
	Thu,  9 Apr 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2ANfS5S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qtuI8GAG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D93932F4
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724997; cv=none; b=TyPh2QwF7G6WulfB8GAdgN/stFEPJ0RJtw01ZugrX5uuo4r7QV/b11XCxUr8FcveMKNI5gCpSdATksWPdsrDlCad/Conq1aXlVRmsjngj8bAnmFVaHh2GmBkrVktWP6AgPAzBpixI2m6ACIeyLRruMbC47gbpn2QpHK278WY+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724997; c=relaxed/simple;
	bh=WcwVq5/9fgi1xjKMepCQB56yilXqeTSjBbMxnY1af9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOjzVspUeo5h5bSZuPYSFQwNKN8nh8xxszy48MO6V1U/ESIqU18s7JelJIiWljN2CFaLTCmHrUnbrLKX2UWxZnqO3BIKecA3pCCAlQJC2UdCAxyQau6JsK5RBo+9RUrlmaSMJqq6lVrR3w9IigfbyLajWRigmRnzNXlfdP7GVQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2ANfS5S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qtuI8GAG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775724992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zwk2fh7y+C0RrsYFO5wfxM8gZjDw/BYRnFc3e8tTqpc=;
	b=X2ANfS5S+bXt6T8O/1aSQnx6PgSUoM+Nl6/1Ei+rp/RcD+9SUsR4LrkJsTaxUBu+EatFis
	M62iSTaw23vo3CDmUboUklHzi8Zpi+8SI+jGc05T842P00EFttEwbNrmE6zS3oRc5HGNf0
	WNn89Y1e8pJfJhkoOEkbWMlB24TpZ+4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-1iXTdOHiPRG26b9Y1hktrw-1; Thu, 09 Apr 2026 04:56:31 -0400
X-MC-Unique: 1iXTdOHiPRG26b9Y1hktrw-1
X-Mimecast-MFC-AGG-ID: 1iXTdOHiPRG26b9Y1hktrw_1775724990
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c74405ecso4020225e9.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775724990; x=1776329790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zwk2fh7y+C0RrsYFO5wfxM8gZjDw/BYRnFc3e8tTqpc=;
        b=qtuI8GAGQ7UdYywZG8NRnAMt8A6hLwDwxFXdBbzlNjTa8Dm7QAiATssdm+YZAT8E2u
         A544SkTh8bg4oW1nu/tyxym6LL3Kz1FM2FQbLbt6H/vKgV68m2F6TrWS1J2OwfVsQQsn
         MHJhxWmZL+uF0Ujjt33xeX9mBCuboS6ITrffIu0t6nc63dq4LJG/EYBOSNsyP61Jnv9b
         kr+X1qjMBKx73dOktljrBGK7+49ZFpSIFDU5cibH9lpDHWrhzzNhKW8wOdbsK4pNBSI4
         MGVUvxYqASl9RbEjhgv7boQ3i6P9c0Zncrr2RHD4JjFRTHZmiou+EbG9ziHZR3l6LQWM
         L6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775724990; x=1776329790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zwk2fh7y+C0RrsYFO5wfxM8gZjDw/BYRnFc3e8tTqpc=;
        b=kzOcLDcjCS0VFueHQDb9DCIPXX+ZK8hqKr4RZxtyrzpOETGmV891naTk1fnlqL8NAN
         x0+tBOZM/cAspCrnfRVY9PHXjjOOo+gi9qp0jmmI4dzddRBq9wff5/RW71I7iG91M54+
         yfzKE3c/cCHZd7SEWnYs4I95CEA7XwPRjsUB2OAgnS2WQsp0u4e3dUVdBLP6SptdXFpa
         oXKcKIgMlz+Sd6i6Ij2Ec6qI27QKDcQgxo8HFKwmixfOzFbrtu+x52ZwWhWlDODdOit4
         YWvlmvDLSgEFwrjff9fmc/g5dXJy64lAW/53xHxTC/y75dI59bntEidSfm6kGNZ2jS2w
         cN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/0j71lycZwhHZt+OZQ7xPPTv77I2G2Aw04yKtU50vR2/NpVkbbbRUp7Bzp/IK+NsWEB9q+QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7A1jr99aQjMoZYiyVLpG7nAwO0D+IZ5K01PmaCn+tMv3vYKr
	qXcRm02Vg8RkRW7Ms6a0JBRNCMFa2w262RBxgaKJc/Ns/u//TUzBD87XFNIpD8wh5ztK3U4JTfN
	NVv31XKidrnbAtC7i+v3ohRUBUsQ+WU9QHoGw8h93ghXT2/BZhsV2sCLBFw==
X-Gm-Gg: AeBDies0OPbpVJTtXdY9Tibbtd5BriucmVvnyJPGqXlUCrVMSlE3j3cvcmv9vjtDUJd
	YM7OryrVeyYoZV+zQWpMY4hte4JKjtzXqjnBsLYXjPQ8u5OtEbWS+uq/PnRBeserIhAy5J1KEkt
	LohlAsCyCbE+HGUT4HYbRoLtP124Ql2/QGYuXIMdpUnKVO6gqIaHS87ajrhFiI41z7gByR2PiD7
	ZyNLwhpvfysPma2aJRgkybwvDVM7ZPzPmZG4IhBBnKxJvrKhqj0BCvctTbdQ44vaGmAaA3NKFeT
	2qRqTEHB3+tZYewmnzdOTwNpqMIYrnWFCHGd6WOs48hteB/pMkW12/OBcJNqhFFV2SkKb5zhy08
	UrA8+wlCLtWDRDh2iZBLYiHuy6KgFaj+Y41AYyUq+QssRQkCIXRPxnz2z
X-Received: by 2002:a05:600c:6384:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488c282e8a7mr126336605e9.19.1775724990117;
        Thu, 09 Apr 2026 01:56:30 -0700 (PDT)
X-Received: by 2002:a05:600c:6384:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488c282e8a7mr126335955e9.19.1775724989664;
        Thu, 09 Apr 2026 01:56:29 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd19ea26sm56602265e9.3.2026.04.09.01.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 01:56:29 -0700 (PDT)
Message-ID: <2e618260-2153-4c36-be61-d2329c9da13f@redhat.com>
Date: Thu, 9 Apr 2026 10:56:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/14] libie: add PCI device initialization
 helpers to libie
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
 linux-doc@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 Bharath R <bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
 <20260403194938.3577011-3-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260403194938.3577011-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,vger.kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-276898-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C63C03C8173
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 9:49 PM, Tony Nguyen wrote:
> +	mr = libie_find_mmio_region(&mmio_info->mmio_list, offset, size,
> +				    bar_idx);
> +	if (mr) {
> +		pci_warn(pdev,
> +			 "Mapping of BAR%u (offset=%llu, size=%llu) intersecting region (offset=%llu, size=%llu) already exists\n",
> +			 bar_idx, (unsigned long long)mr->offset,
> +			 (unsigned long long)mr->size,
> +			 (unsigned long long)offset, (unsigned long long)size);
> +		return mr->offset <= offset &&
> +		       mr->offset + mr->size >= offset + size;

Sashiko says:

---
Does returning true here without creating a new tracking object leave
the new mapping tied to the original mapping's lifetime?
If the driver unmaps the original region, iounmap() is called and the
tracking object is freed. Any cached virtual address pointers to the
sub-region would then become a use-after-free, and subsequent queries
for the sub-region would fail.
---

/P


