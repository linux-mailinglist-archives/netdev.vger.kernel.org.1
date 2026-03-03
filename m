Return-Path: <netdev+bounces-263130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL/VBIPApmlDTQAAu9opvQ
	(envelope-from <netdev+bounces-263130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:05:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A55741ED5BB
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70F36310F02B
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 10:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D593CE4B9;
	Tue,  3 Mar 2026 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyNR9zUU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tJ7L5XIw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1D3CC9E9
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535401; cv=none; b=f7DVJXtA3LVUUZVKELa13n1TBFHbbMCFFFquQ6GaxE5Q//QkrNo/o7jT8A1HelNZ7coflkUE2y4mpy8U+m0rQcVxcfov/EQj9EKpryAC38NL78Sdd9qB2mzb1gHKOxaFAY5cpXCBX4srlUdkdHAhwbAPyplVoxv46Te/Eps4t5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535401; c=relaxed/simple;
	bh=sxxVfVpOS6gefLhTyaSzi6d8tpJBgjZuKKmC8M1vrOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S+Gv2wAT2sfgsjirA2VVcsBNHpSYdhBhOYdpiArjuuvuqziZaka52OE+QMVwXjpciL86QMVVP6yjN6QWiURb+Gg5cymGrtSD9uyEO10LvwKdMZbleyRvFnCtgDx7Nv0O2O3fPu9tr6+PBfhSeyq7izfxYAaz8sRXByejtwj88+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyNR9zUU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tJ7L5XIw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772535394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unnFcg3oz6A6y1pxfDBz1S5V10XOha7AqEFUFjOVM58=;
	b=YyNR9zUUpccpsFUaTj732mTcfyJHgW2+rfD/cOqa5aCc7iYzUCHlCBCcHiINOohp6EtGFB
	gcSSCRFQ489N3QUlXlZxORXnfy9FVQvtv5kqfn/pu2x01eKmXdsl8WwJKqb5izK/iNo1lM
	O0+TWj+EX2l86aA2/Wwn4fAnrpHsQZ0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-MkMAund9MdK_xOMbkFqVaQ-1; Tue, 03 Mar 2026 05:56:33 -0500
X-MC-Unique: MkMAund9MdK_xOMbkFqVaQ-1
X-Mimecast-MFC-AGG-ID: MkMAund9MdK_xOMbkFqVaQ_1772535392
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-482d8e6e13aso45995625e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 02:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772535392; x=1773140192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=unnFcg3oz6A6y1pxfDBz1S5V10XOha7AqEFUFjOVM58=;
        b=tJ7L5XIwnOWSLAs/1WjlOmuHEMBX48JwdwZ97rzru1iDBmQpWs9G6fAVSVuWr/Jukl
         8W8VAP9woRjyHkodR4XzR3zHT4bilT3dO8Mtv4iFkEgSFT7y+WxlwzweDgopWsi6dRbV
         5DFKgefDAijxCtDAlMNPd4e8fzVpK70a++aWpxNF2oU7u8xKGj8/6dVMXVLraOfwZfHW
         hq9Mx6Rf84hYYfgiB4uL2HN6S/ZQ58K6kzPzxR/GPQBIcFoFO0L8Zv2+OGoYIHHZqjWL
         k5BHksItHA564XnFhL1fQoqvtN1O5AV8by5ncYm05U6EX+T1XR+BuP5O49T14SwiLk6Q
         CIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772535392; x=1773140192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unnFcg3oz6A6y1pxfDBz1S5V10XOha7AqEFUFjOVM58=;
        b=lnXEjPyQlam8fmf92xZPiidFVkrphcGyyP4qxiWNeuy1vEepmsGg2safs4nbjM7ZXi
         9wHu740MXHopjltKMBJJfFXh8GO8Ueb+3pb3CGuPVBe1zoIkPqSs1uaS/B+UVXHhoaIi
         XgnIBaws9+hGktXAl/Z22XJFziqkjVHynsuoJNGB3SdrvCsy1htUt4rUTdNNsWyAQ+PQ
         cfsFM6yNCXxOvHBPlflohWgqoXZ8tDVFGIf4lcUhRFHKxJCZGOayoKZaGa9wdwPX65aU
         4G1NzlG3IVC69PfY4KHRxrqLXu1JwQdyjoTd3/YORlxKdhFsE2ZXMyMD+GD1v5F8n3RH
         rL+g==
X-Forwarded-Encrypted: i=1; AJvYcCX9PI0s/3NjGZRGLmLoD86E7+NokMbJOsWXOZX06/Tk+6A7EKUQ1ctfCmC9wcVpC5rL49/RlN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH72/7PTZNgW0tgtVc+BodqTrZl7bcF36fcJfJCijzXBtq7L2o
	j/Na9nZIiUIYE0w8LzZ7yLP0ujFwbxx0KuuBQPy6U/LM7Wm9aayG+FoZTHf2/dkwiAfiNBqpTdQ
	QG8rjtsRpByUR0d/QEu0tljMw6VxOnVkMyqUtn7qTCRPVMkV1DqG/MaBvfBvhqdlgVw==
X-Gm-Gg: ATEYQzxkuYY6TJCaSYm2TxIht6R1I51BiXiNnRVFZAmp9ewtU6MC7G96F5sfx91VPoH
	vL06bfA/P9nBKGjNkE+srZzBCRt7arJgETSnMu+YxCOgv4ww0F5fGFIkRAAGzoE8Zf7kLT9p1WZ
	TA3zVmMqWeM7YbUiOP1Hx6bQcVR9nS4B/5YVnM8cjAgkhSbbsVHGYKWLHTaX7fApbhCM/04rcfp
	mIKpF79cU4N3l8wcwiPJMqun6W6HZ6T2ZsE+na3J+74ffos8XuBjdNA7eK4IfieLbNhMqmu14UF
	qt8o7m9eVDBgAFCZtbeGkCgA4A4BdaTpj2/EDVge2jSaFBwwMSMyRbmj+T+FDiw0q3zN7qpHcEI
	Qmeh2D3YLGj6d09GDHZMAaSCZ
X-Received: by 2002:a05:600c:6812:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-483c9ba3af1mr238405705e9.6.1772535391871;
        Tue, 03 Mar 2026 02:56:31 -0800 (PST)
X-Received: by 2002:a05:600c:6812:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-483c9ba3af1mr238405265e9.6.1772535391377;
        Tue, 03 Mar 2026 02:56:31 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750701sm492414275e9.11.2026.03.03.02.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 02:56:30 -0800 (PST)
Message-ID: <81b7e296-0cfe-4c24-ac97-7f6c712aa0e9@redhat.com>
Date: Tue, 3 Mar 2026 11:56:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: Force full-page RX buffers for 4K
 page size on specific systems.
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, dipayanroy@microsoft.com
References: <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A55741ED5BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263130-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2/27/26 11:15 AM, Dipayaan Roy wrote:
> On certain systems configured with 4K PAGE_SIZE, utilizing page_pool
> fragments for RX buffers results in a significant throughput regression.
> Profiling reveals that this regression correlates with high overhead in the
> fragment allocation and reference counting paths on these specific
> platforms, rendering the multi-buffer-per-page strategy counterproductive.
> 
> To mitigate this, bypass the page_pool fragment path and force a single RX
> packet per page allocation when all the following conditions are met:
>   1. The system is configured with a 4K PAGE_SIZE.
>   2. A processor-specific quirk is detected via SMBIOS Type 4 data.
> 
> This approach restores expected line-rate performance by ensuring
> predictable RX refill behavior on affected hardware.
> 
> There is no behavioral change for systems using larger page sizes
> (16K/64K), or platforms where this processor-specific quirk do not
> apply.
> 
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 120 ++++++++++++++++++
>  drivers/net/ethernet/microsoft/mana/mana_en.c |  23 +++-
>  include/net/mana/gdma.h                       |  10 ++
>  3 files changed, 151 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 0055c231acf6..26bbe736a770 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -9,6 +9,7 @@
>  #include <linux/msi.h>
>  #include <linux/irqdomain.h>
>  #include <linux/export.h>
> +#include <linux/dmi.h>
>  
>  #include <net/mana/mana.h>
>  #include <net/mana/hw_channel.h>
> @@ -1955,6 +1956,115 @@ static bool mana_is_pf(unsigned short dev_id)
>  	return dev_id == MANA_PF_DEVICE_ID;
>  }
>  
> +/*
> + * Table for Processor Version strings found from SMBIOS Type 4 information,
> + * for processors that needs to force single RX buffer per page quirk for
> + * meeting line rate performance with ARM64 + 4K pages.
> + * Note: These strings are exactly matched with version fetched from SMBIOS.
> + */
> +static const char * const mana_single_rxbuf_per_page_quirk_tbl[] = {
> +	"Cobalt 200",
> +};
> +
> +static const char *smbios_get_string(const struct dmi_header *hdr, u8 idx)
> +{
> +	const u8 *start, *end;
> +	u8 i;
> +
> +	/* Indexing starts from 1. */
> +	if (!idx)
> +		return NULL;
> +
> +	start   = (const u8 *)hdr + hdr->length;
> +	end = start + SMBIOS_STR_AREA_MAX;
> +
> +	for (i = 1; i < idx; i++) {
> +		while (start < end && *start)
> +			start++;
> +		if (start < end)
> +			start++;
> +		if (start + 1 < end && start[0] == 0 && start[1] == 0)
> +			return NULL;
> +	}
> +
> +	if (start >= end || *start == 0)
> +		return NULL;
> +
> +	return (const char *)start;

If I read correctly, the above sort of duplicate dmi_decode_table().

I think you are better of:
- use the mana_get_proc_ver_from_smbios() decoder to store the
SMBIOS_TYPE4_PROC_VERSION_OFFSET index into gd
- do a 2nd walk with a different decoder to fetch the string at the
specified index.

/P


