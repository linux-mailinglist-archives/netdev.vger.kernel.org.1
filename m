Return-Path: <netdev+bounces-237172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15093C468BC
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2186A4E9D92
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0529ABE5E;
	Mon, 10 Nov 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JFwayQSD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337F18626
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777072; cv=none; b=hlR3sF7AqUJTamdN4LaNufoXFdfUCBPnYxWTFLR6WUdLyocxar9sTto4Aeb2mTK0GpjHEJ5YeSxbvAvslM/ViyjC3g1DxTrPYs9jbo1r1d706BOGLFVCo8M6SWOOKzaNcUJsT3Y9rpXVuB5XP5ol0gMmXx4oqfIvCB0i8LDL9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777072; c=relaxed/simple;
	bh=x30oLxU9HmV/Il4EwmoaWXxL/qsnd4mDnpMr5mGkzsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GaXvGqXR4cwMMg6lePd8DfHsUCy8+VQvFw5cV0sVZ7LKirrCUbXOSUZmZ7yn5f59hOFWS8JBwDahPoctzqcplW3xxAnYMRBSNJ56vRi2XNv05umd48QqAd+iy+3UImiV+WZu+bxOYObA8PVFQoPTaaiiVJ85Y+J6pPXWwl3OnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JFwayQSD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b729f239b39so633380666b.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 04:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762777069; x=1763381869; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0158B5PEE13qHTCWtnff3hPAcsBc/ztcbY+33+pkdE=;
        b=JFwayQSDROs6O52F/Wmi8JT9LkOcrvtwNS58s5AywsfHJARMXuSr7CPCsi2dv+jakM
         zm3/2RxvfzRkGjrf4bSRwfwRqljV10vmNsfUEOpLb1FJHSAoSf8vCGgZxtKe2cK4hyb4
         MaE2QtflqTIEeM1owfIzi5LdGNHhGojAqt+gD30sMFtBdzEqE6OB+qKJZbI2qANdixcb
         i72KfbNkAdCNRDpPIBDnGn+51dAKGKFFGj6rTjZyQT3qQHbfceRXbiXHoP5ZksdK/RHd
         pmxTZ5OQvLXXACX3PEMwB57MwXPbIaIMpZpF0yPS2JLTgGFQwkr9M9EsvdOF28CvQuvi
         2r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777069; x=1763381869;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0158B5PEE13qHTCWtnff3hPAcsBc/ztcbY+33+pkdE=;
        b=YK5WxFj4LJ2fxLmN00m7usj3AGzUkO95gk+AL3JipPer719IYmmxk5KPv2rBKPKDJA
         UFMwDe+9TdxBqowULTG1zyBJeqi0x/khrnPdeJRd1X1kzPbrhkfVj1zJR6mUtd7SyOuH
         sUylOgvk4Ziqf0JbbLegb4cRWLSR3wabB/nECIXgWSysnh53AiAriBxH96SZvcuxK88X
         Q/dGapLH5LV/lYeuruqYelFE5mz19o8QVw+dX8pZ5eXm/QQwQ424mnkM9RdAWrbpASvJ
         b79W2/p8nPYFYCF2bERB/ygiKWHZVDjjRqurA4yH2kzogYer1djF7oqnReAXHXo0FA2l
         RU2Q==
X-Forwarded-Encrypted: i=1; AJvYcCViLBrm4symT3Gb/N6QZjw9VJxLwbzGBPjEBHGO4ciWAoY5D8bAhzc1O8yrXEVI1BKRU7APvxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxdeIx71yKAOyA6TRu5iZMI7N70uYkGSZxCly7XJncBlMAvySK
	PDpidYbFNgvH2IFM38laxeGsb6k+kd9DFdkHLb8afzfxzYMV0zNwAoc/qq+mLLY+8cI=
X-Gm-Gg: ASbGncsno5af9EzukPa4HcBPtl5AfOfmT80OPsFj8MZNFUeD9PYqjJt9lgyD7LZ5CUs
	xGX8oHZNEi67rBvKscmqyiVu9DpmG7GMxxdDF/CPen+TA9JbeEJl3NNIEKO3a7XvyFcl2hL2Jm2
	JpYXM1l+XuBWzT8htsY7kmw90r6mXkozrAU8s/Bg6DDKKJbq8mCKuK202bPAab8F8KIuAYtsifI
	kQFCw/lwV3VaEgEQ0QpMY0fAOyEb1caq1xwhcte6ZEFEogD2Y2UU80xcLF77WzRrqUnpyx46uAP
	5sWNWOI+hh2d0me0T/JkIhzNOxv6sd29n6TKWDwFbQkcqvPXl1j9SmvbfmmIXAuFawoq/eCvbeT
	pyXlExUsRbagpFAZkT743pc8J0aHYtqIuRBAnZ0N8xUknjSm12XfHWQVDg9l2g6d8X2HvCAiDLH
	YDeLs=
X-Google-Smtp-Source: AGHT+IECCKaLcKBY/MM0m4Eszl3cAn0BtYgSFLjttdAAn1/dYj799+6saR7RH4VK6qqLCBl6bcCgHA==
X-Received: by 2002:a17:906:dc8d:b0:afe:159:14b1 with SMTP id a640c23a62f3a-b72df987f81mr836964966b.9.1762777069511;
        Mon, 10 Nov 2025 04:17:49 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbca75bsm1107983266b.14.2025.11.10.04.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:17:49 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,  davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, arthur@arthurfabre.com,
 hawk@kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v4 07/16] bpf: Make bpf_skb_adjust_room
 metadata-safe
In-Reply-To: <9b3ca8c01aac5510f1ff8738b3856e5e2bbe43075333c27642eb69a6847a50ef@mail.kernel.org>
	(bot's message of "Wed, 5 Nov 2025 20:42:03 +0000 (UTC)")
References: <20251105-skb-meta-rx-path-v4-7-5ceb08a9b37b@cloudflare.com>
	<9b3ca8c01aac5510f1ff8738b3856e5e2bbe43075333c27642eb69a6847a50ef@mail.kernel.org>
Date: Mon, 10 Nov 2025 13:17:48 +0100
Message-ID: <87bjlaf5eb.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 05, 2025 at 08:42 PM GMT, bot+bpf-ci@kernel.org wrote:
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 96714eab9..370ddc61b 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -3260,11 +3260,11 @@ static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
>>
>>  static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
>>  {
>> -	/* Caller already did skb_cow() with len as headroom,
>> +	/* Caller already did skb_cow() with meta_len+len as headroom,
>>  	 * so no need to do it here.
>>  	 */
>>  	skb_push(skb, len);
>> -	memmove(skb->data, skb->data + len, off);
>> +	skb_postpush_data_move(skb, len, off);
>>  	memset(skb->data + off, 0, len);
>
> The comment update says callers provide meta_len+len as headroom, but
> is this true for all callers?
>
> bpf_skb_proto_4_to_6() calls skb_cow(skb, len_diff) then calls
> bpf_skb_net_hdr_push()->bpf_skb_generic_push(). Similarly,
> bpf_lwt_seg6_adjust_srh() calls skb_cow_head(skb, len) then calls
> bpf_skb_net_hdr_push()->bpf_skb_generic_push().
>
> Neither accounts for meta_len in their headroom calculation. When
> skb_postpush_data_move()->skb_data_move() runs, if meta_len >
> skb_headroom(skb) after the push, the metadata gets silently cleared
> (see the WARN_ON_ONCE check in skb_data_move() at skbuff.h).
>
> Can the metadata be lost when these functions are called on skbs with
> metadata?

bpf_skb_proto_4_to_6() is handled by the next patch (8/16).

LWT and other encap facilities are out of scope for this series.
bpf_lwt_seg6_adjust_srh() is on my todo list.

[...]

