Return-Path: <netdev+bounces-170329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7F2A482D6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFD216E67B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55AD26B2CB;
	Thu, 27 Feb 2025 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoBUy3N0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8426A1B7
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669532; cv=none; b=EyGRgb0K0C0YD46oicQ3pXanopHRZdRLo472aRlEAknw+5Adf/vOPneHB+3Kl+PKSkqbQVPReL8eXnKFDGdyHgvlaaSc6RW+YSxztL9WHWL95BB8TaLldLuKpnq+RAHFz9YrolmXIwtZsxD6w+B9reTymZcBcyMTn0GMKsmktdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669532; c=relaxed/simple;
	bh=4bp3cXjewV2kwQJhDJl5O6fulXvsdjqsw3ZAzhfsXMQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nH0W+dUY37aemsotgI/MAY9ciwlFDjIHuu1nGPWJFiZIdAjnYmJIBG0Hcv6a4YlMfOWEQKxxEPcNfE2rcInBi+vJfj/3opscDgIW+4UZHGtEx54ZTBVISjopecyUrvm4QRdayeBk6tkXVKjheGJIZkGST12HWDhMBMzWwTSayl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoBUy3N0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so1569772a12.3
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 07:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740669529; x=1741274329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bp3cXjewV2kwQJhDJl5O6fulXvsdjqsw3ZAzhfsXMQ=;
        b=AoBUy3N0enH793Zdm6+PVSwz3va8udTZ2uH+R6rVOIJDZ63P10w/oPGSKgRY5a1M4x
         loV/vTyz4ZOdUXsDyLCc24eAwl2qIA7zmuXr62g7bOz0WYCgEy8NuHzhOO9o2FhJeBqM
         9ZgPAV25CJbTdTWcIMznpI7ksuxDqrm03CKsUSy6iDxxJ/A9REdEClzUz8hzIStvUzW6
         As0518wNQzBQDXXppI61AvvnyPBwtt+b/FlS3m0LpXwtDirJDOQAzp2kNwYCTfqWl2nR
         U78nOloh3TC0M8TfUp4fe9v4eLl9TYFRmoDy0HCLSHpP1oaZTBvFIRdF/DhYHT60nYT3
         Igfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740669529; x=1741274329;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bp3cXjewV2kwQJhDJl5O6fulXvsdjqsw3ZAzhfsXMQ=;
        b=wGjB6u8y7Okem1uNcjOSop7P0DSNc7yhgdXwMtFz2gxRExxl095b0hJBPwIMkxARIo
         3KB45doBrzq258Pc9QHDruHTisB5tTNFe31/mlPnx9btZz1kMRoca+KwIslaePHIbJ+f
         fkTyY/9uNDOEboHtTgOpPnJ/sKtvD25Sy/rzCEJNm58xmTbLpacv5/32TRGzFQUfmwB3
         VNr4vF1AFpTQHv5Vwg6AgTdhGfuNYOKVqvgno5EdQO1luoNjUgyOP0tpERVi9o//9/v1
         rKFG9b9zfZ8wc6gSvQOA36l+3ClJReLcraWOYHDtClO0dVCQPQJYAhoG4WJcQssb8AjD
         TSIg==
X-Forwarded-Encrypted: i=1; AJvYcCUMwvcKLDqRHy3wzOIs0uJvpHTyjlYBTW1duX4Ro41FGy0TdFYwDs0Q6RkH6F2nZtOMuEbS8K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRMGgOR6FjhwQZsQ4b2375MQbHMWv6uFLOVd27BM5lHYw9PRXP
	M2HgESX1gJzh+v2FEPcOIkaTaLYxzIrNuXsCPs9FZuYgJzDKcteO
X-Gm-Gg: ASbGncs3SC22C8RTnMI0mwmzBC4OuMMwIgeXvgNPQHmDoLc24EUmLAejhpQbjuTsEYx
	3SjooKGw0vhDTeqc05G8NdEvHe432+SlS3VmUlY4PbUIQvL5r0IO1thP+RViT7h1/YfG+cotGQV
	0EngvMsbqXSSJshKQLdjPfi2CcrRPKtLdtjOINz3S04alxie15w54nhpjJMrAXiXVcWHqk0KxPi
	dz0NcqhpG+f70u4XmdbfoZSr9XaknJEJlph39flMERVtHXRmohU3BLf5999zP4zCG1fvVJs+6mJ
	LUf+Pn0BpmEvAoCe2DnuppjVKFS3AdIFLbU7zYrjr+kc+r0kgwSpdqm01j5MOcZV7RiNcbYr6Sn
	nmi1J0u1x3tzGmw==
X-Google-Smtp-Source: AGHT+IFHYGWMQiqcF8V1vOSbIiW1ulpCtw5f75DbqDK+IyTMCyXMHCCBlDow4JciUYtzhxucmL5jdg==
X-Received: by 2002:a17:906:c103:b0:abc:ca9:45af with SMTP id a640c23a62f3a-abeeee2db37mr993828966b.18.1740669529196;
        Thu, 27 Feb 2025 07:18:49 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c7bbfe2sm138293666b.171.2025.02.27.07.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 07:18:48 -0800 (PST)
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context exists
 in case of context 0
To: Jakub Kicinski <kuba@kernel.org>, Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Joe Damato <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20250225071348.509432-1-gal@nvidia.com>
 <20250225170128.590baea1@kernel.org>
 <8a53adaa-7870-46a9-9e67-b534a87a70ed@nvidia.com>
 <20250226182717.0bead94b@kernel.org> <20250226204503.77010912@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <275696e3-b2dd-3000-1d7b-633fff4748f0@gmail.com>
Date: Thu, 27 Feb 2025 15:18:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250226204503.77010912@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 27/02/2025 04:45, Jakub Kicinski wrote:
> The ordering guarantees of ntuple filters are a bit unclear.
> My understanding was that first match terminates the search,
> actually, so your example wouldn't work :S

My understanding is that in most ntuple implementations more-
 specific filters override less-specific ones, in which case
 Gal's setup would work.
On other implementations which use the rule number as a
 position (like the API/naming implies) you could insert the
 5-tuple rule first and that would work too.

> Oh, I think Ed may tell us that using context 0 + queue offset is legit.

I hadn't actually thought of that, but yes that's true too.

Anyway, 'mechanism, not policy' says we should allow ctx 0
 unless there's some mechanism reason why it can't be
 supported, and I don't see one.

