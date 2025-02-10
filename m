Return-Path: <netdev+bounces-164808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED2CA2F327
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD841884886
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333B2580DF;
	Mon, 10 Feb 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FAsNslvt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A02580C8
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204496; cv=none; b=bJAog4s65tVwaE/kgDOY0APIfYUZ22tIsIp1UHYXccrFapq5vLanTLAENyBtbakBVQFFqcO9xHNSMDcuK2uXL89j8ao+AkHgRuYfoSpwVJZns/nGxYcLIpFPJJc84XuZtSia0La3yJt8h6WDXf+EWSq49b6pTQJCdkq9SDyLoG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204496; c=relaxed/simple;
	bh=BZ6FEcgeiaOjLd3Tixtc2bHXfqe9dXsC8MO4qcm9sCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kg2B6U4v3zQAQv8R1/ykpQ8+rq9arCMuqmtGlpdn57Ee8N53zotLzwf8hsUYBA63zGnrNe8/czKhJsg0FqWewWULMdTG8dQOepH9JlEeN/ZZAAjkWDJ0NPR26C4CnpiOE0dgiZvWlm+jUv3p+WYsh9Ui26iS/dQAkVK7/PHiNh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FAsNslvt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dcf8009f0so1505654f8f.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739204492; x=1739809292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9O+XloDs8DnRzoKt+TA29eBQb7Pgt7UsBPep/1MpdKk=;
        b=FAsNslvtLoH0tfexAudQosdYGYN4AvBvU7OpDf8QDEblPq/Dng+z+6BJ7OkxirRAoJ
         lfypeweEJ7DprkuuugAFbnvs+/nST+TYZ7lHr9rfQRkR3qDVsCbaWc9JS/8PF2wMkoI0
         UojBrWA6QrUiYzfK4G9lkoSAQPQ0X+71HZKG29gaWiJ8y1canOS1JN5rKxcVWaEj+Xcu
         thw6FimEKPS/hBD4zmxkxfdSv4yZp2+kX79jE5ac7Dx/Nvt8/jx2bbxXoAXutgc+ORH3
         AcYkdbAk5HM5332MjRvRvJVPH1IHMFKF/qcdQew40RVwY0OAH29sj3/9YxtBHAyr1how
         VhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739204492; x=1739809292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9O+XloDs8DnRzoKt+TA29eBQb7Pgt7UsBPep/1MpdKk=;
        b=iUxpaYlohQ3zggZ/ryBnxAFQnYCO3H3zDlsLijobQusI/+E6G52nnUmd45b8mxC3w7
         TS6PVS73i95ikJJ34GGEFUxRAjT29ceSCszu/nmlf2TD0AJ5NPBgS9Ue1IOtKxjN7crf
         pt8a9BIprK/EQrRNXJTWPsgUFFDzW81gf3tdFawW3d7fMLRHx6IwXBFb8OONRodvwyUR
         NuEQZZ1JtId/ZkbgReDyDZ8sAgWRJ5BCxsk0wg4J1XqbOY2PSrx/sbwWPRPTTFZSL7PV
         l+fVdzJntL/YaCkMWkicfsAL+osjzch98g81TxpSesCKWo53iNjOUSWj7nYP+7+ApW/H
         p8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTJz1+ROkVa9gWsX2vdBFFgFtJ+JTlTl6K0Z9PSL8hZHcOL4Ztege4NRllkCiKPzbD3rgzvgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxwLrlp+Sbk2ZL2TSvLhZ2oIJ7qln129BaeR7T0OmPVLM13Rk
	R+qmQXNSjxXTqEWb2DtBkgV7GRrbFUMqxN3gEMN0Gm09j/lRAWYxs5K2mZj7QVU=
X-Gm-Gg: ASbGnctHtCkNY6XV0I4tyf12LwVG0O2Qzui0WIQ3jBiYB088QmKX1qtgkjlsw59q031
	RUY65eH1IclQGGObU5KJNIOLK3mjJIVT8TEiP3EmJQSI/bkPWd8M+5v9jG/dRWJiwp8QFt9JKnp
	xgaEh2eKjiKnPBPvIKOMF/xiqiYg4huGlgRPrcvWrZ2nkRb1TZXHlqd8ShIWL5eaLpPxMlJBkok
	agetIvhX6E6Qn87MpLxoW4KGphHN6VPq/WVaMDmQrjVHOng46lLgn+UvQ1eU0m98KED1DiJ6Ar8
	NkC2rSsTbjicORXwYtvdnqc=
X-Google-Smtp-Source: AGHT+IEUYTukLGOMYuoBtg9O3W+Mp1rtoXhqdv7wQDCdSOu6jRuoGbbJoKn+SBgCOh0cx1Z2RO1Lng==
X-Received: by 2002:a5d:64eb:0:b0:38d:c70d:f459 with SMTP id ffacd0b85a97d-38dc8ddaa49mr8772858f8f.12.1739204491119;
        Mon, 10 Feb 2025 08:21:31 -0800 (PST)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390698a164sm111167555e9.2.2025.02.10.08.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:21:30 -0800 (PST)
Date: Mon, 10 Feb 2025 17:21:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	habetsm.xilinx@gmail.com, netdev@vger.kernel.org, edward.cree@amd.com, 
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 net-next 4/4] sfc: document devlink flash support
Message-ID: <jdcpuvjqoa3ous73eb5m3f3xartbrasrmwbyefnrwjrscmmrs2@nzalfdm4zd5y>
References: <cover.1739186252.git.ecree.xilinx@gmail.com>
 <3476b0ef04a0944f03e0b771ec8ed1a9c70db4dc.1739186253.git.ecree.xilinx@gmail.com>
 <p527x74v7gycii3qfgcqn46j2dixpa62tguri6k2dzymohkeyw@rqqmgs5tbobj>
 <116cc011-4e4a-12c9-0cba-3097c6e85e0d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <116cc011-4e4a-12c9-0cba-3097c6e85e0d@gmail.com>

Mon, Feb 10, 2025 at 03:50:18PM +0100, ecree.xilinx@gmail.com wrote:
>On 10/02/2025 13:51, Jiri Pirko wrote:
>> Mon, Feb 10, 2025 at 12:25:45PM +0100, edward.cree@amd.com wrote:
>>> Info versions
>>> =============
>>> @@ -18,6 +18,10 @@ The ``sfc`` driver reports the following versions
>>>    * - Name
>>>      - Type
>>>      - Description
>>> +   * - ``fw.bundle_id``
>> 
>> Why "id"? It is the bundle version, isn't it. In that case just "bundle"
>> would be fine I guess...
>
>bundle_id comes from DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID in
> include/net/devlink.h, which git blame tells me was added by Jacob
> Keller in 2020 as a generalisation of a similar name in nfp.[1]
>Its use in sfc was added[2] by Alejandro Lucero in 2023 but seems to
> have been left out of the documentation at that time.
>The present patch series is merely documenting the name that already
> exists, not adding it.  Changing it might break existing scripts, and
> in any case would affect more drivers than just sfc (it is used by
> i40e, ice, and nfp).

Yeah, correct. I just found out myself by accident.

Thanks!


>
>CCing Jacob in case he has anything to add on why that name was chosen.
>
>[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c90977a3c227
>[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=14743ddd2495

