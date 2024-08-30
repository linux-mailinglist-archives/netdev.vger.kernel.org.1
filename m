Return-Path: <netdev+bounces-123766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60108966749
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926EE1C20618
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5A51B3B10;
	Fri, 30 Aug 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVR3AnNz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31013BAE2
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036534; cv=none; b=sjilHHDjlkbcMXMs4YxxnLCoAvoFTjZTWxIwCKA1309myHmYyulYcNIfmsKBVVw4VuxlBmNktblfEtm2DoILRFzSsP+gzrql5zNpNNQWMGmfv1shC2I9IMxfvATNLK9/AZCViKLQWYw/nvrm1b6gydXQoelaPia5Zh1NxYgxTDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036534; c=relaxed/simple;
	bh=R2fI9bN+g0nPEUDdo7vVJfUe3q52zSNp8s8oJq4G1mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ulhh7umUy7uLeuFm9Gx8qoz0HZPKffqHqwI2iT+2D3Czo3HxX9esONK4t78VZMaO19jT+NdxIOOY6icZZFUxtxATJGzm8E7r9Zkb1n8vTgglo77RY5aQuZ2JWpnIhWQHXyS1bC3Q+KJMxV6Xohwcut6BrMSJyOnhoGpm7vzNZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVR3AnNz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725036530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZlnrG+MBzbRlPSV5XEPi8X4abe5ATIQGU9hv5YY0sY=;
	b=AVR3AnNzW4XFMjYQOzlCBCCN+1OEg04KCcD+fFsCiUHVFlVUamUL8kBPszn7fOtCyKTSbj
	kA4sfmhejAaadlRJQjcce8LOs+StB4i/ZDIoOktr8SInBZnIe4oQUZ0CVfBvGAd/jcGXQD
	IYerGrHhZuB3EnNpnexOwZUfAem3WK4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-p2IrMLqbNSK5I7jeZ1CpVA-1; Fri, 30 Aug 2024 12:48:49 -0400
X-MC-Unique: p2IrMLqbNSK5I7jeZ1CpVA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bb8610792so16161795e9.3
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 09:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725036527; x=1725641327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZlnrG+MBzbRlPSV5XEPi8X4abe5ATIQGU9hv5YY0sY=;
        b=sUQTqRfpie3hZUz0mlTwbqm3CkG6zApxrtQMCb+174/WNPsh6C3Zy1XqJ8xXXuI+SI
         mQvc+4fH37ZbY+RRa90bWmabvYZd2PxbfbR0up8rv1fxyLDUIyOOJJJczuMGoVXR96Dk
         s5wYnDEPLtkkxc2ZLkI+1an130qX96hnMMiR0SlYZNDgZ/PjNpBGM95CV3BoeISV68OE
         y5ppSjL8a7cA00dqSnsUTT4yQ37VJeFLNhJ6CwultaG3imCPgVuxR7CIENjTh6rV/xww
         WZ6Dv3DQ86aPqvWlk1U1VL65SWYhlJgKicixqqvLeWhMoVX+FkasEdhEJRBAoLGuOTc7
         7q8Q==
X-Gm-Message-State: AOJu0YyTgQhvtLXfDzF/JWu5L0/VxtOJ6rMC0BOqr1FOvAXFfygI+pN/
	9wCcuxTuv08G7WSULFsLEjfDjW02foiswEbnSAha2NtQ8verfKOe0a98gykjcUADaRHhxJCKHdE
	i72tmROfSEYiVlMh7OqZ6HqN8cnf+Mqizi7x4cCPEUEep/PNcKyoeLwT8PddiVS6i
X-Received: by 2002:a05:600c:4585:b0:426:554a:e0bf with SMTP id 5b1f17b1804b1-42bb02ee854mr52119475e9.16.1725036527360;
        Fri, 30 Aug 2024 09:48:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSO8pwAfemPfd5c5TXEQmZMnCL+D2vs8xMbOiFoUKsPLsdScOWIk07tHbzNNc7AtAjq8VmBA==
X-Received: by 2002:a05:600c:4585:b0:426:554a:e0bf with SMTP id 5b1f17b1804b1-42bb02ee854mr52119315e9.16.1725036526830;
        Fri, 30 Aug 2024 09:48:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b53:e610::f71? ([2a0d:3344:1b53:e610::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0adbsm51704445e9.15.2024.08.30.09.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 09:48:46 -0700 (PDT)
Message-ID: <d0244464-0596-4309-89ff-d8dcd9aa3d35@redhat.com>
Date: Fri, 30 Aug 2024 18:48:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 04/12] net-shapers: implement NL group
 operation
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter
 <donald.hunter@gmail.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com
References: <cover.1724944116.git.pabeni@redhat.com>
 <f67b0502e7e9e9e8452760c4d3ad7cdac648ecda.1724944117.git.pabeni@redhat.com>
 <20240829190445.7bb3a569@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240829190445.7bb3a569@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 04:04, Jakub Kicinski wrote:
>> +static int __net_shaper_group(struct net_shaper_binding *binding,
>> +			      int leaves_count,
>> +			      const struct net_shaper_handle *leaves_handles,
>> +			      struct net_shaper_info *leaves,
>> +			      struct net_shaper_handle *node_handle,
>> +			      struct net_shaper_info *node,
>> +			      struct netlink_ext_ack *extack)
>> +{
>> +	const struct net_shaper_ops *ops = net_shaper_binding_ops(binding);
>> +	struct net_shaper_info *parent = NULL;
>> +	struct net_shaper_handle leaf_handle;
>> +	int i, ret;
>> +
>> +	if (node_handle->scope == NET_SHAPER_SCOPE_NODE) {
>> +		if (node_handle->id != NET_SHAPER_ID_UNSPEC &&
>> +		    !net_shaper_cache_lookup(binding, node_handle)) {
>> +			NL_SET_ERR_MSG_FMT(extack, "Node shaper %d:%d does not exists",
>> +					   node_handle->scope, node_handle->id);
> 
> BAD_ATTR would do?

We can reach here from the delete() op (next patch), there will be no 
paired attribute is such case. Even for the group() operation it will 
need to push here towards several callers additional context to identify 
the attribute, it should be quite ugly, can we keep with ERR_MSG_FMT here?

>> +	if (ret < 0)
>> +		goto free_shapers;
>> +
>> +	ret = net_shaper_group_send_reply(info, &node_handle);
>> +	if (ret) {
>> +		/* Error on reply is not fatal to avoid rollback a successful
>> +		 * configuration.
> 
> Slight issues with the grammar here, but I think it should be fatal.
> The sender will most likely block until they get a response.
> Not to mention that the caller will not know what the handle
> we allocated is.

You mean we should return a negative error code, and _not_ that we 
should additionally attempt a rollback, right? The rollback will be very 
difficult at best: at this point destructive action have taken place.

Thanks,

Paolo


