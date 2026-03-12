Return-Path: <netdev+bounces-267031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGG4FcmqsmnwOQAAu9opvQ
	(envelope-from <netdev+bounces-267031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:00:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A41271633
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94C893029A67
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9DD3A3801;
	Thu, 12 Mar 2026 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlAMiB1Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l5gq7hCh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2EF23EAB0
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773316801; cv=none; b=Mm5UPJr4vPkV5Bfk/10yCA+1p3jaItJjSSK3fy6BJwC4wM60LwYIU5OyVdnXxWRynL/elxr1lPi+aGPqmrwq/AxX1cDOw/aWW96y50joz/SAgNTX5NtwjGXm4hDt2307AaG1RI3vVZrFkbe699sbwvCsJqTtRv/Dnio2X7nSAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773316801; c=relaxed/simple;
	bh=pSM4c5SlwbfLlCY6MVDWcwT0Dj8gikrgvwZsevPv/bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9sKPkIvAiFNTWt9QD1tJ4EfVP2AR2S35e7kfHnc7FOyy0XLO0KSeDiHvPahC8mKr2KAZqIlZBnPLqSzmdwi8wiQor4j3skQfj3lIXhUvVuBSv9Y4GUtvPamIze5H5Up6tJhkcG50oaYyOsR/WLOxG2+RTM9Z4KqiVkoAEjptEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlAMiB1Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l5gq7hCh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773316799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRa4LvyU+A60q9Rpv8+AHl1L4aAB6JpU7wa5lWrjEDs=;
	b=WlAMiB1QEPkFwUx3qNOC2xLd2BxXkpA/x5PGXEJXlNH6QDwBQLpiZsBg/IIWo0NuRtdeP+
	VrTcy2UNtQz+crhi6OnLRPjdoNNbUh87moUGNhSem9sg3ot9GHZoI18RgfNIa9KBc+/1r/
	hGAMaXmfZrIAueKXLjR2it5T9mYamQ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-UD_QWQMuP9uMgalDessMog-1; Thu, 12 Mar 2026 07:59:57 -0400
X-MC-Unique: UD_QWQMuP9uMgalDessMog-1
X-Mimecast-MFC-AGG-ID: UD_QWQMuP9uMgalDessMog_1773316797
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4852ccff333so7297945e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773316796; x=1773921596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRa4LvyU+A60q9Rpv8+AHl1L4aAB6JpU7wa5lWrjEDs=;
        b=l5gq7hChyeyzzxYeDL5J57Hfkt4Cb3oU6QSJ1DO8hGkYINELnShHDbW3xYtnXVvUM2
         DOI1K1olalkbVal53hbpC+PfqWzCA2QQNPaNDNJb5uCBqOonCvJscUafKYQAyV3QdXhk
         Si2Nm+OVwaCW7imf/+uKTI/jUS3VaTSiS7m7ogMXSVddn69LTorpEosTC7bTzc2kF4Qy
         FZbYIP09mSkHZSN0BlGsMK2bqSItt3ufOoRunq4UAPh+IDH61OcKD6kMcsehr+vxtrnS
         B6/zDKAqtgweYBBc7WahGF4Py+szSz1YsGF6hty+vAnj1oTNzX1yJdZjLJehOTywbkiA
         8yMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773316796; x=1773921596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRa4LvyU+A60q9Rpv8+AHl1L4aAB6JpU7wa5lWrjEDs=;
        b=GwdPzC/ERmdui7gbtt/LBxJjKIkprd9mEGAqVsCdPuIP5ma89xJXnoBKgqvPTvicLA
         8FsrZ9ShoMtWLbA76z2FOTnFIa/1GSkE0TTY3SDHoErYI1j6VR01kGy5+iykWzOMhUUU
         kt414UlQb2Jg8FBSSpuKb67q6EjY7ZQIzKupbvDxjU4/uq96kjVK/G1hvhHxH86JiYOb
         jqQTgM+7uqPnfqt9jjq5tWwZcK7kyRQrQxnBDxk9B7Wv76KQDwzlK9kpPemCL86CM/Z1
         971TeWBEEuwjMaRASiytIrXtiBGjhorpkOXmqlNWIcN1eYFMZnFWARR4JIZciqfLg5BX
         EOsg==
X-Forwarded-Encrypted: i=1; AJvYcCV8rBQxulp1xdrE027HSnQkp1dX5eRX2M2ZXJH2k7FC4IaqfubtdKXSNYCFKvwQR3UrhZaySt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfl2RVL+3opWbuJgMUCjLuhGLVmsp8ohiF1jnujnoXGt6x7iNT
	dpoWx4oIiubbd2hgEXUglkJHmmDzlI13T7PKg+D6rMt0o2CBTggc6Jg5qP5MblxUWwpZrkZXqHX
	/zAc/XjNRgE4JUSgugL/qcXuS+tLTFKNnFJGN1twom1mB7hauog2MuCSiJA==
X-Gm-Gg: ATEYQzyiasStfru/LlhSCa3jPqVy72ikSMtpL0QVgleQG+2XEDnTCPL03ZuYdftUsp+
	OpNUD/3l8RvWIajI/MpyNQ6ldPC51GS7H6JEtFn/Ph3lF8ETvDFERy/41ZYa2QVPUbZzcx4UFhR
	TSIuGOk/xBKZ0a9722FeJX80dCcaJGzVtaHjc2IIfNpij6YOHlHqKGNjL9f4pStR2FSYyf5Fz1+
	0zjXN1VxZATiPlcKaqHj4m+XdYf4CkqdukxFShk+F0Jgj0FaWsRY9Ksbq8js201/s7m3ogwaq8W
	wGYjPT/Wc3oIFLNbsDOhxtvu6ZeYj1tlQ5rgIrHtpgVLmE3XZESAU6V8ZJoYrjilLeCjLyfAClT
	hFpbJSG2OoXffTQUjlNCKfLrqId7ztW7qhFR9kEi71WD9I1B6OJV//8g=
X-Received: by 2002:a05:600c:4ed0:b0:485:40a6:442e with SMTP id 5b1f17b1804b1-4854ad71905mr116049345e9.0.1773316795935;
        Thu, 12 Mar 2026 04:59:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:485:40a6:442e with SMTP id 5b1f17b1804b1-4854ad71905mr116048315e9.0.1773316795201;
        Thu, 12 Mar 2026 04:59:55 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b6070acsm106712865e9.8.2026.03.12.04.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 04:59:54 -0700 (PDT)
Message-ID: <c74e2c3e-277f-4f6d-b136-45bb049de905@redhat.com>
Date: Thu, 12 Mar 2026 12:59:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 06/11] net/nebula-matrix: add common resource
 implementation
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com, edumazet@google.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260310120959.22015-1-illusion.wang@nebula-matrix.com>
 <20260310120959.22015-7-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260310120959.22015-7-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267031-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,illusion.wang:url]
X-Rspamd-Queue-Id: 19A41271633
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 1:09 PM, illusion.wang wrote:
> +int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
> +{
> +	struct nbl_vsi_info *vsi_info = res_mgt->resource_info->vsi_info;
> +	struct nbl_common_info *common = res_mgt->common;
> +	bool vsi_find = false;
> +	u32 pf_id = U32_MAX;
> +	int i, j;
> +
> +	for (i = 0; i < vsi_info->num; i++) {
> +		for (j = 0; j < NBL_VSI_SERV_MAX_TYPE; j++)
> +			if (vsi_id >= vsi_info->serv_info[i][j].base_id &&
> +			    (vsi_id < vsi_info->serv_info[i][j].base_id +
> +					      vsi_info->serv_info[i][j].num)) {
> +				vsi_find = true;
> +				break;
> +			}
> +
> +		if (vsi_find)
> +			break;
> +	}
> +
> +	if (vsi_find) {
> +		if (j >= NBL_VSI_SERV_PF_DATA_TYPE &&
> +		    j <= NBL_VSI_SERV_PF_DATA_TYPE)
> +			pf_id = i + common->mgt_pf;

AI review says:

This isn't a bug, but the condition checks if j is >=
NBL_VSI_SERV_PF_DATA_TYPE && j <= NBL_VSI_SERV_PF_DATA_TYPE, which is
unnecessarily complex. This is equivalent to checking if j ==
NBL_VSI_SERV_PF_DATA_TYPE.

The confusing comment was removed in v5, but the redundant comparison
logic remains. Could this be simplified to:

    if (j == NBL_VSI_SERV_PF_DATA_TYPE)

This was previously noted by Jakub Kicinski in v4 review.

Reference:
https://lore.kernel.org/netdev/20260207022455.4017894-1-kuba@kernel.org/


