Return-Path: <netdev+bounces-153147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D89F70FE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 00:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6480C169C4A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44DF204564;
	Wed, 18 Dec 2024 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mw7c/xTQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139C20101B
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734565056; cv=none; b=IxZR1zopuBPNCRw+DO2kffSYSOIlVclpEnG408uXloSPOcovgRA6pGiojYKerFGeX3KwGSIWtEEYoQfT+iJzvq2hmZAmu99Y+pDMB9h0CJ/qhrb255KhZRQvA+SGDk2ox8ichKPKTWcE+cNUDIyrguPOSRn15obw0l/lOuNQE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734565056; c=relaxed/simple;
	bh=sFAoi3ZSBj2JOlSyrlGOJ2lIbd3TrtoGMgGcLp0OJxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBT3XwVLqBdnSt6hD3QoDw5of9j9vcnog0M8qJTrv63Z/UaaYdb8Kw4GxTFoqDOLPwDa8EN323kj8cHuN2NKxF6uVmxhhCQzF1jQLE7PwRX+MQw0UUX7PO/TPd9UPMuH9vMblwFOBdMLBTlUXtc/zrOtXCm0IXEsXbJE1y0bXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mw7c/xTQ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d0cbaf41-7632-4430-a228-d56c70dd6aed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734565042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ng7nsfRRx/pLmf09Sdjvv0KjhEGPPLEJnoqOlj8GtbU=;
	b=mw7c/xTQ4lGBXNKFq56pfGPu6HV7ml1l4ahKaYi5ZlSI+cOD5aarzyIbtFcMYC5Cp9cJi0
	MybYYIU55ZyLB49qxaceYJT65FAnc4MaiyEdr27k+MfiNjYtDwoyGJrCt8wXA7hQR7QUeT
	Nv+CpmJFxBAWGTN9O11qxwqGTPjDpWc=
Date: Wed, 18 Dec 2024 15:37:14 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 05/13] bpf: net_sched: Support implementation
 of Qdisc_ops in bpf
To: Amery Hung <amery.hung@bytedance.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com,
 ameryhung@gmail.com
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-6-amery.hung@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241213232958.2388301-6-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/13/24 3:29 PM, Amery Hung wrote:
> +static int bpf_qdisc_init_member(const struct btf_type *t,
> +				 const struct btf_member *member,
> +				 void *kdata, const void *udata)
> +{
> +	const struct Qdisc_ops *uqdisc_ops;
> +	struct Qdisc_ops *qdisc_ops;
> +	u32 moff;
> +
> +	uqdisc_ops = (const struct Qdisc_ops *)udata;
> +	qdisc_ops = (struct Qdisc_ops *)kdata;
> +
> +	moff = __btf_member_bit_offset(t, member) / 8;
> +	switch (moff) {
> +	case offsetof(struct Qdisc_ops, priv_size):
> +		if (uqdisc_ops->priv_size)

bpf_struct_ops_map_update_elem() has enforced non function pointer member must 
be zero if ->init_member() returns 0, so this check is unnecessary.

> +			return -EINVAL;
> +		return 1;
> +	case offsetof(struct Qdisc_ops, static_flags):
> +		if (uqdisc_ops->static_flags)

Same here.

case priv_size and static_flags should be not needed, just return 0.

> +			return -EINVAL;
> +		return 1;
> +	case offsetof(struct Qdisc_ops, peek):
> +		if (!uqdisc_ops->peek)

bpf_struct_ops_map_update_elem() will assign the trampoline (that will call the 
bpf prog) to qdisc_ops->peek if the "u"qdisc_ops->peek has the prog fd.

This test is not necessary also.

> +			qdisc_ops->peek = qdisc_peek_dequeued;

Always do this assignment



> +		return 1;

and return 0 here. Allow the bpf_struct_ops_map_update_elem() to do the needed 
fd testing instead and reassign the qdisc_ops->peek with the trampoline if needed.

> +	case offsetof(struct Qdisc_ops, id):
> +		if (bpf_obj_name_cpy(qdisc_ops->id, uqdisc_ops->id,
> +				     sizeof(qdisc_ops->id)) <= 0)
> +			return -EINVAL;
> +		return 1;
> +	}
> +
> +	return 0;
> +}

