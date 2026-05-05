Return-Path: <netdev+bounces-284420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA8fNQz0+WkOFgMAu9opvQ
	(envelope-from <netdev+bounces-284420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:43:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF854CEBAB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1FC4305BF2C
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC96C3E4C71;
	Tue,  5 May 2026 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BR7sNl1G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiYgCUaa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141E47D95F
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988579; cv=none; b=o/utiSsX9FIbLsiJkTNIiytsQ5Ozwnaasfs3op+a/EpFS4b9JVJ+kEjpu24bvTvDIWcML1uQGvQep+BgJXXRuKHJJBIRYW3R/qqgSHNSqlXiqpJWOnqTPg8WexUJtUGH9yF2D7FF1FNPsxehI3k6YBgJjyKGOxe9pe+CuKskX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988579; c=relaxed/simple;
	bh=KoGS6aWgQmyghW2+RcilZE/a4UalTY9FWST44iSCrmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GpIUaZmTV2xWD9F99wl18fGQpwPYyiQfIrN82ijNKRkW8wGEPV2xAKOlZp9CzrJ9DPFg4PfqcIlVR01PEUo21weQFzgw31c6NsoLKdeq0XJyYLKY5zPt57EVUc+L9kEH8Qf+vZhqNTqL7w0SV9AgYu6iLN939LCKsmnilm7nJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BR7sNl1G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiYgCUaa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777988577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+U+GpGXOrL0cMnQRbFcA7ylLjvJDYXi4Fcpm7XE5qos=;
	b=BR7sNl1G5mfrQoKVi6Mb4+q7Mif3prcTc3tBd7RLzujVtycoJNhRcjdRJS4WP5ggZt3k+b
	81zTXvV9Ijrm9GXgWoQM1Au7bsjnS7Uaj4jVGEXjG/RuVwkEODWyEsv7JB5viUHs6wel0K
	QeEZQj/X+DFlL/RX0XHAZYJw4f+xKq0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-IyM-LzZsMTOCQV6Vov8a6A-1; Tue, 05 May 2026 09:42:55 -0400
X-MC-Unique: IyM-LzZsMTOCQV6Vov8a6A-1
X-Mimecast-MFC-AGG-ID: IyM-LzZsMTOCQV6Vov8a6A_1777988573
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso37547505e9.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777988573; x=1778593373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+U+GpGXOrL0cMnQRbFcA7ylLjvJDYXi4Fcpm7XE5qos=;
        b=XiYgCUaamZm6WTSI43K90aaOEBA5Nx5HVT+DagaNvt4YXFGrM8PC/hruoust7T0UOh
         /JjptZ6ZEWwSE/YaFAa1nL2d++YeXMdcGUapz/E9Nj6ERAP4LeEBEb/BwxZlhLRMjPnM
         RjSYKiQycZbwL/Sm4Aqbs7A8LZi+XRKYp4rKVh8Hqp0cWeiAbOyla7MiRj8r9A2U2ZEO
         gUf4q4fcD0EEwWP++lGtlMPSDvksWAM77zE6Pf5pmJyQLfX6AX9uoMLg1tBSDninDQNc
         JKr+HKgQaDzGm+rYUt3n73FIInQIqZbZMAcuckIrFPHYxUbV5SMqfPzbnf3YLzQcOCZd
         Ol+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777988573; x=1778593373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+U+GpGXOrL0cMnQRbFcA7ylLjvJDYXi4Fcpm7XE5qos=;
        b=U+Y6BznaCItjJBJ0lUmzDSlrPJjWiIfjb+cQVSSZ5EGwWKiQ1ZnYvjzNT/qMi7CelD
         ltDaRsqcs6JlIQYiMpfNQkVnc1PF6jbFEsV9Wjz64c3KBi9PcmFoModHitCCfyp3tqd2
         7CHbLTG5cHPYFksGH04ppt9rvK4jWmIAGFCS7s4QcrtpoXEMG9syNr3Vo0RCxthlMC9Z
         NHSuBfjwNDzmZDx0JXlYas08KJ9r1YVJFWCtru+LEfltjPkaNIa2IoTjqxjGJ9wRZ8Sp
         VoDjQ2A1tarDzYpHKdtEdbWBTb/Ov9W8pD5+cWUGOZzz+irwd7c899jtf8z5IKC2Efr4
         FY6A==
X-Forwarded-Encrypted: i=1; AFNElJ8G6LnGn86X/SZLkWrP5m5OI05ualbBJL1BzwXwZNNMf7khVlduOvTkbVLR0o+9SdlmTh+ASIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWvltHswvW7gBAuFTsHu7ltQFduEfoEBrWiKR6Maoq4NGHUcf
	Dd2v3KUrzlUipnqz/Tv0uu+IqM1Upk+9cJKN+O/pzJNBbzywt3T3RqmTwgjfqHDIUzeixq61zUS
	/6UVYgkQwHtUImZcUHuGnzcSbIR7n52OQdjkmvkn8G8qBUScWlDlZ57s7PQ==
X-Gm-Gg: AeBDiet3ajv7bq5+pPxlqvDYSJOZZaRxrhsgO/JX//aXnUYSfzaEMjgkY2Nrpg8KQhg
	GdinOxlhjKthVK26bpuWZT8nVmEyx/S1I32pfQo65rupU6JfSacKEmo4YsBPv7t+3lc8qNRhEFd
	Vtnb9sjVFWvCnDmGqTI2XA8JTBWrjqCA137XPlRMlXPqOLFO27ydq0a0mFNhCkIifLXD/ktQN3A
	wVxom1RNHH5bo0hPhJsKhq6OSaHs+aXB0GHEHFZSr997pXeII3eJlR7cqjCrKc6q0KbmvmPuHC9
	OWZ0/Ym7hp/G81bZJnrzVDLoLGkLQPt9E9gfBxhBYHTLPTBCLC2C+dVhtAxfHZeqZlH0jCQGCtx
	teOEDGdaAYjS2wHCFEqiAOGvdK0cJoQvafcwRGALVjJqu9W/CxPqETz1zcFHk8FcGqVk=
X-Received: by 2002:a05:600c:a30a:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48d18ce275fmr36490335e9.21.1777988573100;
        Tue, 05 May 2026 06:42:53 -0700 (PDT)
X-Received: by 2002:a05:600c:a30a:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48d18ce275fmr36489575e9.21.1777988572565;
        Tue, 05 May 2026 06:42:52 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d149d49acsm30503175e9.1.2026.05.05.06.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 06:42:52 -0700 (PDT)
Message-ID: <30f588ad-cf80-432b-bde3-13b3c0d5a124@redhat.com>
Date: Tue, 5 May 2026 15:42:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net, v3] net: mana: Fix crash from unvalidated SHM offset
 read from BAR0 during FLR
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, stephen@networkplumber.org,
 jacob.e.keller@intel.com, dipayanroy@microsoft.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 yury.norov@gmail.com
References: <afQUMClyjmBVfD+u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <afQUMClyjmBVfD+u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9CF854CEBAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284420-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 5/1/26 4:47 AM, Dipayaan Roy wrote:
> @@ -73,10 +74,28 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
>  	gc->phys_db_page_base = gc->bar0_pa + gc->db_page_off;
>  
>  	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
> +	if (sriov_base_off >= gc->bar0_size ||
> +	    gc->bar0_size - sriov_base_off <
> +		GDMA_PF_REG_SHM_OFF + sizeof(u64) ||
> +	    !IS_ALIGNED(sriov_base_off, sizeof(u64))) {
> +		dev_err(gc->dev,
> +			"SRIOV base offset 0x%llx out of range or unaligned (BAR0 size 0x%llx)\n",
> +			sriov_base_off, (u64)gc->bar0_size);
> +		return -EPROTO;
> +	}

I think that the additional fix suggested by sashiko is really worthy,
but should go in a separate patch. @Dipayaan: please follow-up on that
one, thanks!

Paolo


