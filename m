Return-Path: <netdev+bounces-139364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 918999B19F2
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 19:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0671F21DF2
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B807D13A257;
	Sat, 26 Oct 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBH3I5+g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315D2F5A;
	Sat, 26 Oct 2024 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729962202; cv=none; b=rD8WHg+DdBlttcUxjPZhV47XB49r+aT4+fnEpeVjQqIs916TODIP2o+adu6tXFuCLQrZ5e4SS9z0Q8BKa3mokkVwCMDSx6TFV1lDju5YeDLnZipnppLyXjSGsaXxck9EFqaCztmmMf9Gif85RUMwmNbH7gyV4/6byTNJaUpbAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729962202; c=relaxed/simple;
	bh=NFyh5lXFmEb1gJIH1gRhPMpzkMHAFFi7nAu+Elf4Mjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpbxylKazpRuPBGc9pg8RfCixHxv/xz/6gwHdgFyK9uhe17IR3EOSi+L9VpDp6/FQWqw55HXy2nXXjchNFpt6tT0lWBvqh1TP/KbeKSMi2q8w9IuRk36UVD7SWzPeLONbB4hh11hxD6qWpeHATdxBLEdzdKRzvRGu3PbprJnc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBH3I5+g; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cceb8d8b4so16793165ad.1;
        Sat, 26 Oct 2024 10:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729962200; x=1730567000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9bYNUVNG//bj2DNBTD7X7A5iI9b0SfpO4hVFpFgvGM=;
        b=TBH3I5+gH+3yZ4AwxAO3oBSJx6wq7yixQ443Qmd2tdToUFveUTq+DeubCyFLAeKj0U
         U7klXfaF2936B25zlhES/6AFb40urrCpbTLPD6hV9PsBzt8ZlOat18m5XQsRLC0fHlnv
         45NtED0R5LukCXp0Jzj/S+9d2N1pikEq/ZYIvuhe8NOKgcYUpRFWDYmRB/KZprBdkV1+
         u485MKH06YMtHtp6WhP1Jicq3q7y/pTbA7p3CavlwHhraGqxsUXBIgzQ4bNTJn71U/5g
         jBiodBNlBjOCemuCpKAwjxxydgy7eztZKx90hI0Ig0L9JTo6XRvglYVrCmICCYImpTCU
         zKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729962200; x=1730567000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9bYNUVNG//bj2DNBTD7X7A5iI9b0SfpO4hVFpFgvGM=;
        b=l+ICc6B/Brybu79wVDMdQCCvAqdtnwZ9RpF7TXzZHqsGx/pTCelbLGLE/0T6bMo/vA
         Y+hw2zAaNUw3G7pXXtQ3mcTxY4PZPB2wwgiZ7kwCORCfFbq6LmONSIazFokudMZv5Ilm
         bmEhy4Ed2GHyqMxS+VykRitxisUaE1jbBLRhypqWgJzkTJDYPZSbdpK125Ky3ge68U1F
         YbhRcC2JikTwvaoaQRkGs15rbn25H7hk16Xa0kA8vs5+8OloiAC8P/wb+KuFynwv0guv
         KQfqWAXgV+9JU9j8HyoRn4iaNDb+vkVahGbrNoEhBLrwMoH7H8+W4ulczF6qQeWNweLG
         SljA==
X-Forwarded-Encrypted: i=1; AJvYcCW9kYf07RVCtf/9tAAF6RPj380Lgtx8FdXT2wnwTrnpnV0juu8PQ9agmQISGIKUVfZsU2FRmXfWU1MIGIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjuE2p84oEjxEnnegRpOVACtev4o/A/2nq7BTX2gGkvHb9s2w
	U/gwJo2T1NZa72Hnip3JCCZ8Ig3EH06rvltHYRcmYkmTbRrf+w0f
X-Google-Smtp-Source: AGHT+IH3PEp7hiKcb2sV42rZyT+yd8LMY/u6y1CDGPQs/kKHF2YNCyYY2UI4ZeILImh6kWnwFhbExQ==
X-Received: by 2002:a17:902:ecc8:b0:20c:cb6b:3631 with SMTP id d9443c01a7336-210c5a76dabmr46214925ad.27.1729962200153;
        Sat, 26 Oct 2024 10:03:20 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:6a46:a288:5839:361d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc044bdcsm26056795ad.241.2024.10.26.10.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 10:03:19 -0700 (PDT)
Date: Sat, 26 Oct 2024 10:03:18 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Vlad Buslov <vladbu@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Baowen Zheng <baowen.zheng@corigine.com>,
	Simon Horman <horms@kernel.org>,
	Pedro Tammela <pctammela@mojatatu.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: act_api: deny mismatched skip_sw/skip_hw
 flags for actions created by classifiers
Message-ID: <Zx0g1uQ6LTDycCKq@pop-os.localdomain>
References: <20241017161049.3570037-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017161049.3570037-1-vladimir.oltean@nxp.com>

On Thu, Oct 17, 2024 at 07:10:48PM +0300, Vladimir Oltean wrote:
> There are 3 more important cases to discuss. First there is this command:
> 
> $ tc qdisc add dev eth0 clasct
> $ tc filter add dev eth0 ingress matchall skip_sw \
> 	action mirred ingress mirror dev eth1
> 
> which should be allowed, because prior to the concept of dedicated
> action flags, it used to work and it used to mean the action inherited
> the skip_sw/skip_hw flags from the classifier. It's not a mismatch.
> 
> Then we have this command:
> 
> $ tc qdisc add dev eth0 clasct
> $ tc filter add dev eth0 ingress matchall skip_sw \
> 	action mirred ingress mirror dev eth1 skip_hw
> 
> where there is a mismatch and it should be rejected.
> 
> Finally, we have:
> 
> $ tc qdisc add dev eth0 clasct
> $ tc filter add dev eth0 ingress matchall skip_sw \
> 	action mirred ingress mirror dev eth1 skip_sw
> 
> where the offload flags coincide, and this should be treated the same as
> the first command based on inheritance, and accepted.
> 

Can we add some selftests to cover the above cases?

Thanks.

