Return-Path: <netdev+bounces-267039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHySKW2vsmlGOwAAu9opvQ
	(envelope-from <netdev+bounces-267039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:19:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 166DA27195F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CD2C318DA4E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC921A682A;
	Thu, 12 Mar 2026 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODJTs8II";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXJ47++w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8F15B0EC
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317740; cv=none; b=ZpqcJL+UvuW+eswv+ZY0b4y7KD0ecVeG1TcNd+Ny26vOTXIFy3fJdSwHF1/XmiJzHYllpr1JdOxSwBkI7cZ2dfEXLAow9Xblmfg5xiO5rcubLHgqHFaHK7SgtvDLUirE1th3VffwJxEcdsAeTqj70ImlBz61XCf8LYNffYylJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317740; c=relaxed/simple;
	bh=VGUC6wUOypIV4CsAk/cYVlAk1OOCaoat8J+NcnwZaqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6UFMY45MBEhtQZwmDQCCQIfp0zKuX8Qmmjuz4UVdQsfwcECjCxWAh//lOiXh9ouhspUcoJeb+QfKhUC536zAgBgTJEJAx5CRphvQLGoADOzy9iUlCSON+m0RmeZdZCgzSYCKDkvhu8FMfu3LYiyv2bvBB0KPpGI3teN3E7G5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODJTs8II; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXJ47++w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773317734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=loNIpigFiuTuj5urzh0sT/xjUHse+AOsRM2zfPikL40=;
	b=ODJTs8IIKinuIZPSkxiPDWNy60g4f79MmwqgDIPkjiTG3axr5DFR/q4/fiu7qKyckHDbvQ
	0pZvxhIGlqHctNZaSXeZfiwe6UYZjfuS3w5LNebmOhxtXqK9b8TeBeJ6Fq27yAsfwAc1R9
	XZv4QDHLgdLp2B4Qh3joGpP3sbAdpnk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-y9Jpv41SOYq6PD_1FQGZZg-1; Thu, 12 Mar 2026 08:15:33 -0400
X-MC-Unique: y9Jpv41SOYq6PD_1FQGZZg-1
X-Mimecast-MFC-AGG-ID: y9Jpv41SOYq6PD_1FQGZZg_1773317732
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4852cf0318dso8734455e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773317732; x=1773922532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=loNIpigFiuTuj5urzh0sT/xjUHse+AOsRM2zfPikL40=;
        b=bXJ47++w5qRWlgCajG20ztHev//ND09tPL04sIVb44XJLHHvnIQFm7lDHhCK/Wemx+
         ppq2tDhkJSlKhrfDuBiyJSJ02meVB2jw7tc5C298cRtKTQbu7+lYHK2EmGlLV3a6oMEQ
         TkgoJ691iT5/8PdUhD0ApHfCrd39GTJHOAn3f4uPHtfj5/tuOXkq+0hhDt5R+ccF2LEX
         dmuWuYQmzmzf1XSxdzvuBAJDKQxY9EyWMsNeNRwYA3qJWQzaYfH8FAbVn1IWdMHjgQfU
         zHJH4LCBRjf2emRlNlB60XfQGmwqUzSGbyOV7K/n3BwIyiUhtTB0fPoNmUJ6IT8m+eyl
         IPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317732; x=1773922532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loNIpigFiuTuj5urzh0sT/xjUHse+AOsRM2zfPikL40=;
        b=ZUnDs7ExGae8/lqsuy+EzCFNzWADeUp23klDg6ylm1PL/0i1mzWDxccALG/4Pu/CCx
         n4J+4zV4BUPxB9tYxRGmBnYozhSjJ1guWnlY6qqHVYBeZhchj6Kz8Myu8clCMncXMBgO
         tYzvm+vg8YVEUt8Zv4SnYps30k92n8bGcz39Gw4GEtduOPNr3CSB8WfmhaeAl69bQQn2
         JWsG3zCoB/GyxJ1ldEHTlGfvjJmjPN7iGWf3YO7UhoGpL7oAKP/GojJFvvu6dO95mf+i
         NFlGbL2h/b2BSdb/AcvOxdsVBoeH+71o6+lJSUgvH9cyA+eoBwI6csYdsreapm9VU/6D
         V3/g==
X-Forwarded-Encrypted: i=1; AJvYcCUtXNmqWMzb7BT9+WobMEiHHBEwLbnLInDca07vckNEcMX1KKwrGi2nvX8Ay8w7bB1nlf/NxhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwNsDZUsXDwAe+Mu9j6T3LDIm+U+z+4KFfnIOdYmBzEIJYxkG
	XEYsTabiS7aT81akWMv74KbaAAqVvwklfp25kElDkY4ru8ShrDlu+DaKfOCJTz0X74bNARtLueg
	BLZGlVJ3jZtE+svcAAbDhEz1tgXJwzud5je0GXx/YmjshDfrO7ox/g8uomw==
X-Gm-Gg: ATEYQzw1zLHcjUSjZzBe3PzyrE3+XDW1If+fr7zPxYHueHuUFf4m1U6A5oneC6vU+dj
	GslLls2MlkoMYNA5Ds1INoJrv8rmTdEGD6PB9+4WCRZdWbMT3s+y1K/MmaIH3oSk6A4jbZEXvCu
	wCn930l8nbRR8beX5mhARFxE83NvkjWAIiUSweHWHzgTByZ72aGE/lOU67S5Akk45QUqRMCTu1s
	1XruC3A2rXgbcmfxGiaBjYEIjqE93f+hsN314UCI8YxalmkVq8RknR9HuJ6UaPuAFKRlCSd/8Cu
	8d8wbeQboAiscexfthVDAQfIFpP5Yo3S6UwLZwqZFV4TBqTrrwmcuPm3plnLVbC913aGr9vZywM
	Bal5DPVJOP4COxTRjFhYi+IX1DEuqx2XgnjyetuJvY6gjmPFFjnrAa78=
X-Received: by 2002:a05:6000:2dc5:b0:439:be78:e1e9 with SMTP id ffacd0b85a97d-439f81c0248mr11988493f8f.14.1773317732154;
        Thu, 12 Mar 2026 05:15:32 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc5:b0:439:be78:e1e9 with SMTP id ffacd0b85a97d-439f81c0248mr11988421f8f.14.1773317731647;
        Thu, 12 Mar 2026 05:15:31 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a737csm7076461f8f.10.2026.03.12.05.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 05:15:31 -0700 (PDT)
Message-ID: <606d9633-d48e-49ff-81c8-cbed7e92f698@redhat.com>
Date: Thu, 12 Mar 2026 13:15:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 11/11] net/nebula-matrix: add common dev
 start/stop operation
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com, edumazet@google.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260310120959.22015-1-illusion.wang@nebula-matrix.com>
 <20260310120959.22015-12-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260310120959.22015-12-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267039-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[illusion.wang:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 166DA27195F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 1:09 PM, illusion.wang wrote:
> +static int nbl_dev_configure_msix_map(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +	bool mask_en = msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en;
> +	u16 msix_net_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
> +	u16 msix_not_net_num = 0;
> +	int err, i;
> +
> +	for (i = NBL_MSIX_NET_TYPE; i < NBL_MSIX_TYPE_MAX; i++)
> +		msix_info->serv_info[i].base_vector_id =
> +			msix_info->serv_info[i - 1].base_vector_id +
> +			msix_info->serv_info[i - 1].num;
> +
> +	for (i = NBL_MSIX_MAILBOX_TYPE; i < NBL_MSIX_TYPE_MAX; i++) {
> +		if (i == NBL_MSIX_NET_TYPE)
> +			continue;
> +
> +		msix_not_net_num += msix_info->serv_info[i].num;
> +	}

AI review says:

Is the condition `if (i == NBL_MSIX_NET_TYPE) continue;` correct here?
Looking at the enum in nbl_dev.h:

enum nbl_msix_type {
	NBL_MSIX_VIRTIO_TYPE = 0,
	NBL_MSIX_NET_TYPE = 1,
	NBL_MSIX_MAILBOX_TYPE = 2,
	NBL_MSIX_TYPE_MAX = 3,
};

The loop starts at NBL_MSIX_MAILBOX_TYPE (value 2) and continues to
NBL_MSIX_TYPE_MAX (value 3). Since the variable i never equals 1
(NBL_MSIX_NET_TYPE), this branch can never execute.

Should this dead code be removed, or should the loop start at a
different value if the intent was to skip NBL_MSIX_NET_TYPE?


