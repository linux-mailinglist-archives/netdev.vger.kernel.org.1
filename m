Return-Path: <netdev+bounces-209811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C230B10F31
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302B3585694
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4961AC88A;
	Thu, 24 Jul 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kg0Ne24a"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC40279DAE
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372335; cv=none; b=nk+83VRma7VE+gOHtB++sjPknKnms6I+tEtw5wcsBUGwQZ6XYoNpvPIJk+V/rr3GIxY74QXYVtU4dVT1eYd/pO4FO/G90l1T4lfNOamlFnioS1hL3mHQBePVRen57U5u5+UFU0PfcmlV4zPYm0yQES4C7/371vzdmkI4DBQLvEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372335; c=relaxed/simple;
	bh=bmmTj+MiSK33HcOSA0U8X87MgfEePxwCxEk09H9aOfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYFXk+yFWn04f+34LTI2nRnlZPuT2l/HyGe3xSSw27XnAlP/LdBnNXh+V7hgu1Kf+p+x6WYgT20VX75MJeiDaMAprE0LVRh4IFobb6gFmmFIKDtYua0LWc/8zosgioi+uj1FxuV3HMXc5ts30F+uVjq63s4IAN3ZbE6/S5zxxHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kg0Ne24a; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0190e181-c592-454a-a99b-5ec361ce84e9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753372331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L//h0XSVg3DhOizsCCZuSw8seh/lsiJDLenYORLhCoE=;
	b=kg0Ne24am3D27GX+BXu+u7z9HxOx0P6C/sExgWeImKQLEwDaPbhdRYBYoXZeGyuO3y3unb
	ncZo7AuRPOwtYGoclWpi++COEiYUVJMkqmNLNNZaOrtjFnRQ5DyYxqGaZTRyj9ZQc7lUTq
	yQNXjUuQVsg/sH2GbbCBpb6ZUZite48=
Date: Thu, 24 Jul 2025 08:52:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Enable read/write access to skb
 metadata through a dynptr
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Arthur Fabre <arthur@arthurfabre.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Joanne Koong <joannelkoong@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>, Yan Zhai <yan@cloudflare.com>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
 <20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
 <20250723173038.45cbaf01@kernel.org> <87tt31x0sb.fsf@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87tt31x0sb.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/24/25 4:53 AM, Jakub Sitnicki wrote:
> In this series we maintain the status quo. Access metadata dynptr is
> limited to TC BPF hook only, so we provide the same guarntees as the
> existing __sk_buff->data_meta.

The verifier tracks if the __sk_buff->data_meta is written in 
"seen_direct_write". tc_cls_act_prologue is called and that should have 
triggered skb_metadata_clear for a clone skb. Meaning, for a clone skb, I think 
__sk_buff->data_meta is read-only.

bpf_dynptr_from_skb_meta can set the DYNPTR_RDONLY_BIT if the skb is a clone.


