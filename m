Return-Path: <netdev+bounces-180899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F91DA82DBC
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 19:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3013BCF9F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB171277011;
	Wed,  9 Apr 2025 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir/UGwJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D19276057
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744220204; cv=none; b=T9VG6VkESq5qXzB4rr+86CrVxieMXFgtBLdKUJEbA5gkQrObiTndr2QSY517wnaM8s2hy1yGfGqWPYOFXhttMjE4FmfdAomGt9CLuOdGkX82jpAqyjj2QwN439i+fkV9i7JXbYtUDDnW5DG7PVgDB2fCO8d9xv1/6L0cnZgQozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744220204; c=relaxed/simple;
	bh=Q4XJvCzdhjeXcVQ4Y+JnXKU/LyOAfIOIQHjXaXd5MyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVXM5AaRulqhly9CMcbevLUNNUOAVFc4eVbW7xbnopVo4fQI7sjCYXGLTFbjCAWjLTIh4T5YKFKy8jVFAKCD3CfKAmuD61URC51fDSyffQU/BVTtEg107bqx74+57hEpkqJEjMpuLrCMkSLezR8Bbafviq1Wvkk7Ht80+tPK5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ir/UGwJ+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227aaa82fafso61536085ad.2
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 10:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744220203; x=1744825003; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Q4dylNtAWL3Z4j40z9Lr4JGXK752esdgpEuUK8PMic=;
        b=ir/UGwJ+S9HHg/20PKONlcqyZUoNhpgDH1rGtNOsow3SfLc2Fi4wa1GnbHHh8kt+HS
         L+837l0Zw5gvRuyQ1Yjx5O4Jw7Y+kZO75pHLFr5C1N4i2Wg8uKyQ2MY+L0Wn6+6IIIjH
         jY7vi1mW/Jpb9itabwNuhMPN9Skbud+s1+ExzNkGwzOFWxUHbz8oN5fXYY7eX3hNVLq6
         333TvCJr0MMPSS3feEN3b9gfo2VdF+s83CojLVsJLFmYSyJ0Ka+sGXj5L1aFftjjeyKN
         DrGGnURsIVgVhiNnESIGqNF1iwpAe78TVsWj5TgTtZS/aR2dpxpMA+KLKwUkuasI+tO4
         PVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744220203; x=1744825003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Q4dylNtAWL3Z4j40z9Lr4JGXK752esdgpEuUK8PMic=;
        b=XKhor4Qq9fWObPXFFE5yyMf0Kn5Gxg61aybEYm2FHhzFtYURQJqNv4u1vRLCRDS/jL
         x9gq7GZoKiHWe4QKRRxTvhD8fhKR/9Y7TUPz1j11xW05h7rHniykQVr9BgOz5rWHkr6M
         lFi+1BXAKfkNjIwpumch6G7WKKC780H8oLwC6zLQeLra7hqWqkqEzwuOBb2CJGmHQndn
         XPxgCa2Whx6tM31cEp5O/4ccPvHB2y9umnMSBK+oaKoYjV8EnEiYHwpsKmsEJ2hk01LF
         y3N35oIC0zlhKyaHEzQqifpJ9N3fsha/gsxsOWzMGI7fUpXkbaL0rQLJiafM7z9MO/ZV
         0mWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOvuc1F4Ix0Yr5+h7wvWo77E+SJ6y3QxZdK1GkhJ17znw1GAYr8yn5Wr9eIHQBqS5FnTgyoGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHGV5ccWRri9nckWvc54AcOKswzUDCbHoRE91zXD1/NiRNQTD
	d5ZTIBjdJt6hBq88/famLNStJuLNAEY3GqljnySgx5VWrJqjmu31
X-Gm-Gg: ASbGnctp4MbK62gLAJdFw8xyN5qo15Qzsn4QVddijkYFnGlyMILeSES0IuQvALsbtvq
	bO1u7cjzpu3ijP3+LQvVpM9gWqCjeNshI6EuHGJJ9j8jpT59OzVtA3PyExMX5QusMqtDwAm1pL7
	m6b+L22JMd3U2jphu2iNar2QkdAROEW1ti+enqnSF62e1ujpeaqiiwNPj2PFgVkFdHQPTBXomqq
	vmMK/F0mgX5uda3w2OWNayLs1VWoUrZHK6mK91Y0zeudGZ6k9iSxSqmOM//GUoKlI66/aa8ow3d
	MLKsI82twfb3fW3akhkzySAp/jJZGJtEPZNg7AHgXCgR
X-Google-Smtp-Source: AGHT+IGcA5ZCwUXn4ebKuVooZIn5+4m6UrykabSOowFbbKkro+y26uXtdOJynGDYC2Sjk01fBhKOZg==
X-Received: by 2002:a17:902:f60b:b0:223:6657:5001 with SMTP id d9443c01a7336-22ac3fee2edmr59468205ad.40.1744220202684;
        Wed, 09 Apr 2025 10:36:42 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b62bc7sm14864735ad.23.2025.04.09.10.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 10:36:42 -0700 (PDT)
Date: Wed, 9 Apr 2025 10:36:40 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Ilya Maximets <i.maximets@redhat.com>,
	Frode Nordahl <frode.nordahl@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] tc: Ensure we have enough buffer space when sending
 filter netlink notifications
Message-ID: <Z/awKFETLHDwN6dE@pop-os.localdomain>
References: <20250407105542.16601-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407105542.16601-1-toke@redhat.com>

On Mon, Apr 07, 2025 at 12:55:34PM +0200, Toke Høiland-Jørgensen wrote:
> +static struct sk_buff *tfilter_notify_prep(struct net *net,
> +					   struct sk_buff *oskb,
> +					   struct nlmsghdr *n,
> +					   struct tcf_proto *tp,
> +					   struct tcf_block *block,
> +					   struct Qdisc *q, u32 parent,
> +					   void *fh, int event,
> +					   u32 portid, bool rtnl_held,
> +					   struct netlink_ext_ack *extack)
> +{
> +	unsigned int size = oskb ? max(NLMSG_GOODSIZE, oskb->len) : NLMSG_GOODSIZE;
> +	struct sk_buff *skb;
> +	int ret;
> +
> +retry:
> +	skb = alloc_skb(size, GFP_KERNEL);
> +	if (!skb)
> +		return ERR_PTR(-ENOBUFS);
> +
> +	ret = tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
> +			    n->nlmsg_seq, n->nlmsg_flags, event, false,
> +			    rtnl_held, extack);
> +	if (ret <= 0) {
> +		kfree_skb(skb);
> +		if (ret == -EMSGSIZE) {
> +			size += NLMSG_GOODSIZE;
> +			goto retry;

It is a bit concerning to see this technically unbound loop.

> +		}
> +		return ERR_PTR(-EINVAL);

I think you probably want to propagate the error code from
tcf_fill_node() here.

Thanks.

