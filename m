Return-Path: <netdev+bounces-183320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCADA90591
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0878E06B0
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81521F4E4F;
	Wed, 16 Apr 2025 13:55:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC616F265;
	Wed, 16 Apr 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811747; cv=none; b=dwqsx9DsKOG782VaD40q065XVAOYhXHIUsV+FriXsqqqP0i+1somjnIB1rmxZ8GE1Hzrqj9IIPCa8g6eQy0PfhpVl+UElEjkDo9c/PH/E35+tXeXso9QlJx6YgkTAUZMo8Gus/jXE3OiPaIcPcHj8HMj1k7JZX0IsC9Ur6Z3lII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811747; c=relaxed/simple;
	bh=7B4oB8tjso21ENSWHB/6vN1Jc1J7bNNQAnO6yXLsnTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7sVeze/3cV/A2HJTSGtbJ+Fo01qkFGF6hIrBZwQNH/s+Czng93tTUMFYCvP3zGleIIqsmaub/dC+SizUqlCvRTufw4ztaRivx4lpngJEW1k+Cn4jVIWiDj1QNDjGcVhTpFVdsd2PODAuHMK5G53gRXdLyL7StofwWjfw+hCoTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac339f53df9so53304066b.1;
        Wed, 16 Apr 2025 06:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744811743; x=1745416543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ3OD0eEokrpT3DVWyVtLnlo06W7u4wDjvTtFKjh6BU=;
        b=bz16fkuSCtziKo0lOqsBCsRcMkZzMRNWuL7631QC4pBi2j7YWAxH2W9OClHdwYmvJJ
         wZ7hUwZoVYY5U0ssrtt3US2BWnsopb9CRvh+xgEqx7frhAC2Ue3e+qA9nQmTVIpM3Daz
         oaQW0z08OHMQ4Vm+1WIxETsAimXHw7NUcwZpuP3VuNpLJQOhd5KKvyFbTC5qHTyvCr5a
         iSppvY6Tpd6MFlUhTVjFwRD6/zByCyMqRHIq3HnsxldRVjjSSLesQnzUKBHVhodcq7tG
         JzYz0CHWMiBMHZTBIUd2G3D/hL5ehJX3tgC6ufsrucmSwHhl8aG7o4+OUwu7HyAMk8JA
         WpyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4WZb3eLGKE09703kezKSsGfs9FDkbFwr8zaR2WAZMo+17ZFufu+xg8IDgQD/200qaLlzBJk7LbkTaYlg=@vger.kernel.org, AJvYcCXmC74voe45dXn+QhZ7EQsLJEVu+qHDypEiVdA4gUq6dubpeAZpPmtBdcx1w8KYVXxI+AHREZwC@vger.kernel.org
X-Gm-Message-State: AOJu0YyyQg5I4SCdr7+Dt2JNvy2eCdxwRyqPrMJR+PAMmFb8GNzdmcSb
	KH08rVIy2zxmSace+kayheBdvUYM9uXNgjFMSah9sFJ0rDxfBX65
X-Gm-Gg: ASbGncuolvy/6O2i1r6fRer856OHy4Z+3se0lxFr+JuXP2EZD+ckmmIWsGcreh9hNKH
	aHp1AdgW8N4fDbwPETAwAubOHFpFbAdTksKMSEf0JWzdtJeeUIThDjiKyQlF71BiReQKJjWpiOv
	SEsODzg+njM3gZ0HWwvL5Y7yYCB+LLhTEwrkrqUs4kJExDQpmzps5wkTi3TMvtBh9YazGDRHw2S
	ZZd4BqxrGTtpblLFljDBPb4e5chBzQ/zSf+lLuGKmt/6xljaPcXA6TLGiE4fVd5s1gTgtQ6ucyd
	VYS8cuBMzIQXcmxszlt6cLS9QewNCoHK
X-Google-Smtp-Source: AGHT+IEsSVFrqE1JUbYuGRAO3u1RK4EvR2OsGoHndeBmeeumP4xmTGJOk3uhEAl9bpJy/GcnXHWmvg==
X-Received: by 2002:a17:906:da8c:b0:ac3:c020:25e9 with SMTP id a640c23a62f3a-acb42a6452bmr138302966b.34.1744811742671;
        Wed, 16 Apr 2025 06:55:42 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d1a948dsm128178866b.126.2025.04.16.06.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 06:55:42 -0700 (PDT)
Date: Wed, 16 Apr 2025 06:55:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, horms@kernel.org, kernel-team@meta.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 8/8] vxlan: Use nlmsg_payload in
 vxlan_vnifilter_dump
Message-ID: <Z/+227rt0CfqZP9k@gmail.com>
References: <20250415-nlmsg_v2-v1-8-a1c75d493fd7@debian.org>
 <20250416011333.25090-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416011333.25090-1-kuniyu@amazon.com>

Hello Kuniyuki,

On Tue, Apr 15, 2025 at 06:13:23PM -0700, Kuniyuki Iwashima wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Tue, 15 Apr 2025 12:28:59 -0700
> > Leverage the new nlmsg_payload() helper to avoid checking for message
> > size and then reading the nlmsg data.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> Just grepped nlmsg_msg_size() and looks like the next series is last :)
> 
> neigh_valid_dump_req
> rtnl_valid_dump_ifinfo_req
> rtnl_valid_getlink_req
> valid_fdb_get_strict
> valid_bridge_getlink_req
> rtnl_valid_stats_req
> rtnl_mdb_valid_dump_req

Right, that matches my list as well.

Thanks for all this review,
--breno

