Return-Path: <netdev+bounces-201663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6DEAEA44A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 19:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F291C45782
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D77719CD1D;
	Thu, 26 Jun 2025 17:16:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97078F2F
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750958192; cv=none; b=W/UR2fVrlQLjERHrJTDgn3nwufzzxmldh4Z+DGk9EntyOvMZVEbp9BNkbNgSMbGjWOS4qtQuOeU4b4AnMLAAYmZpRjjGiW1rIIu2u+lcDpD8TfVpyU2RfF4gCeOjhwMO0rgjEn2b93ZY/MPFDWT1DcfavyT/Htj5cDBvbnrsOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750958192; c=relaxed/simple;
	bh=rwkKRBZ+lyhasomRPsgeshixRmNuwVgfXdacU5XgXjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=XHMAS1iThIqDJZrHw4zoLqicfIGISU/OJ6lSlhBlHKpIjDVcbIbiFQmrAbv/nF/8V2CTk4HbJHCiXLYqk40nZKz2KInVzhowuo4Tsc8/S2PJLPu13JjXnKcD6cUMRIdflfBeTMqq8MYVbroAfz3ZoE0RhSc9ZFx3aEq7+rKsYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso2330280a12.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 10:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750958189; x=1751562989;
        h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qBIB7+mc11Y+dGBJLTPIKxlNdJ0jh36LwiC3wblkfk=;
        b=bFsKOgimmvxv7eWZGV7NopPQIrx+fvfkXGJIu0F6e29Gbox2ZB88uRNBDATF1P/eYt
         Mbia/AplV/MgIvSvHLfm345AiSdDgwI+dB7RHre+Pm7KpMyhduV07W14ZmBFNygoI6Qp
         7AfAaCEVcKkiO2q2PzuZQKmATncnzHvBr32JTI992P/fOJMLd8BpRCWG/O7opSwnOLrf
         url8p5iwJc+eoxijJ/PMH+sF0BIRfJ4WMtlbiIQBad5AmzKOVtr3ghl1viVIDDtVfoIV
         GTocy3qPiZfFEyBzUDCqRjFCrqVYaUaZKfk6sp+ytLeMiJ0NkVX/UpNwm1oBt6mhInOj
         JUSA==
X-Forwarded-Encrypted: i=1; AJvYcCW28fuHoUHFajDUsWF0TFjQ+2HtWrVFLZC9OkgmKk4IvfE2+v81U9YzIkb8w5G0AREoIiZUneM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsuLxjZ/J90/NDvE8Sj/B+UsdC6+57ruC4VH6XBhgLUlDTesXh
	em1oMz6jXJd9VuoVlbo+ZGcclsrwAdsjtjzmfj0Is1pwF+Tk8lDCwnkg
X-Gm-Gg: ASbGnctCmF/64/ptnaqJeGF0KlGxgPHT+Dx4n/BTHvBf/D1dyTFy0UN2JefPa9OeWRz
	rHJme5x54w+jF67yHknvRMVV3VxfBPh7B7rz569w2nDLlPG1dSzD7Tbgixuob/s3ZYlQxRam1EN
	UP4SEb47VefZNMaNeM8Tquurqhar3BgMec2InuN6Tv5bnU/pDyFrcR80rrw1+XnmDDhXQjBt21n
	/ylYTEBryf2bZ2QNbHyQgcPQer/nmhVCKv6yMft5I/lvda1NTMdFEnOosaBQnvYV5yW+x4eqBec
	vQJHQLplWi/5FQqbICk1Afsu51Vw+8enyR8AVtBWmdvXnJ0WxErLndb2ZDf745NfwwcvIteLzAA
	a/EDQwhyfDKBYIZ5/JUhFbZo=
X-Google-Smtp-Source: AGHT+IFqh8AiGOqB6wOmixWJ/GVBrNNHvLDzQuJRKYciH0q1akSVpKyCEwMJ56UMslSl3P53DFcK3A==
X-Received: by 2002:a05:6402:1ed0:b0:608:4fec:f14b with SMTP id 4fb4d7f45d1cf-60c4dc1b2b2mr6926080a12.9.1750958188695;
        Thu, 26 Jun 2025 10:16:28 -0700 (PDT)
Received: from [192.168.88.252] (78-80-106-150.customers.tmcz.cz. [78.80.106.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c831b3e29sm244889a12.42.2025.06.26.10.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 10:16:28 -0700 (PDT)
Message-ID: <08200104-eda5-47f5-9538-b0be2b7fe1fc@ovn.org>
Date: Thu, 26 Jun 2025 19:16:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: openvswitch: incorrect usage in ovs_meters_exit?
To: lihuawei <lihuawei_zzu@163.com>
References: <6B26C96C-1941-4AFF-AEAC-6C7E36CDFF02@163.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Cc: i.maximets@ovn.org, davem@davemloft.net, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 xiangxia.m.yue@gmail.com
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <6B26C96C-1941-4AFF-AEAC-6C7E36CDFF02@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/25 2:59 PM, lihuawei wrote:
> hi, guys,
> 
> 	Recently, I am working on ovs meter.c, after reading the code, I have two questions about the ovs_meters_exit function as bellow :
> 
> void ovs_meters_exit(struct datapath *dp)
> {
> 	struct dp_meter_table *tbl = &dp->meter_tbl;
> 	struct dp_meter_instance *ti = rcu_dereference_raw(tbl->ti);
> 	int i;
> 
> 	for (i = 0; i < ti->n_meters; i++)
> 		ovs_meter_free(rcu_dereference_raw(ti->dp_meters[i]));
> 
> 	dp_meter_instance_free(ti);
> }
> 
>     1. why use rcu_dereference_raw here and not rcu_dereference_ovsl?
>     2. why use dp_meter_instance_free here and not dp_meter_instance_free_rcu?

Hi.  AFAICT, the ovs_meters_exit() is called only from two places:

1. As a cleanup for the datapath that we failed to fully allocate.
2. From the RCU-postponed destroy_dp_rcu() when the datapath is
   being destroyed.

In both cases there should be no users of this datapath at the time
this function is called, so it doesn't make a lot of sense to hold
the lock or postpone the destruction of these internal fields again.
Half of the datapath structure is already freed here.  So, unless
I'm missing something, we can just free the meters directly as well.

Best regards, Ilya Maximets.

