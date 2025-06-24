Return-Path: <netdev+bounces-200593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B8AAE632E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9BE170BC9
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FEC28467D;
	Tue, 24 Jun 2025 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSnSoQAm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27787126C05
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762917; cv=none; b=FEfzG2fooRcTw6p5JxGZssCa45xnoPahHHPdb7ZXd+/KYyb2GPyvSTUUeywZFRFjz72Kp2xBARXsrENrN/BvgXaYqoc7aey8lC9lPpjBF8a6jjC43xGpvU+Oz/06wWB5GC4tBtCTXVWLrRiyyKHPu1v0eeBt2r6PKcxZKVS2/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762917; c=relaxed/simple;
	bh=GI7a4iR+LCdE9iTrNoclJaOJLfBAij5Trf5KhJb+XAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P4nnZ1IsLEqGB4ayC8xzKXap0Ai6snAnc6GH59qHu5VgrCuOXqnkAxbi/RrijWYucEgA0MWCvXopunRbI7Swgz+BJMmtURjPN+z5VEecNi2c9icrN73FcHA4ULwssz0cE3CXMyu5dses8tAnxcoeAqWJT0gZAJBS7MScs5HBj2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSnSoQAm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750762915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WrfMksOxB0G9GSe2G8W4zx4JfvBQpVqOPDOrmuF3RE=;
	b=TSnSoQAmtMcK/0B9MzYJMrf7TR7PNW9ghgceq6NsM0+idMR3KdWp2pzwyyxFF/1F8BzyF5
	QBb8meqOgx3UiT7kIRE3FDX4RHodEE19PscL4VgIdmIzd01nrZtZa+CmhZm9Zdg8nIUGcx
	4JFKai45G3NUl7MKWha1LRDMiSz0tyI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-6Eyii9mAOAyXTt0OYlcLHw-1; Tue, 24 Jun 2025 07:01:53 -0400
X-MC-Unique: 6Eyii9mAOAyXTt0OYlcLHw-1
X-Mimecast-MFC-AGG-ID: 6Eyii9mAOAyXTt0OYlcLHw_1750762913
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f3796779so170706f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 04:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750762912; x=1751367712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WrfMksOxB0G9GSe2G8W4zx4JfvBQpVqOPDOrmuF3RE=;
        b=ANUPjGgpaaUdN+fZpx/y0Lot9EGf566u4TZ1Ki8bB7+Ect8wZujJicYIA0oAXsNXEE
         pW38WfcO2H6nf0qL3BOhkUiX3L0fv3bt/iWUgSP/+oRdsGy3ZT1ZbFydKXixQqk5WSHw
         o6v3JPPtKIUYRJXICyHvVpC4xcDqXeWjHpq8e26Ar6QAi2K7WFRhwNpOlKWSUMLor3Rs
         W5LAu8ZiJTfQ6UIoxcSveBl3xIbmykPyJN6JxKDsHNRTE90apBQb9Lr/6quM16oBi8J4
         uG48JlyQu+bMZxymZ8pKE048dxeEvbQvpTzVU3cYkeqs2n57D2mPfyDsabK/T5dLQcnk
         hBdA==
X-Forwarded-Encrypted: i=1; AJvYcCVz/Qacpm+ATXkOchBYN6sB+qp/6rn7narya+N1vet+FsT0zOnC7tZJZg3Z29BSOGQRdEN6iLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwowX39cw8EMKxxDB+CwiVQI922WXVlNtqYzuyGPih/6NhT7TBQ
	S5/2+R0w/yrHrq7UhgLzkZt2MCYKFNoLUItiyRX4sIlZjz7Xgm5FrsHv/ET6D1I8TDmMM1VGIV+
	VKxHglJ/UJz0P5ml2B35GPdKxY1QpsLZqYg82PgjAZjgCfsFSXnrEWlRgaA==
X-Gm-Gg: ASbGnctAK/TvssLHWI41xDyoYhghp65DHL3t/QY1xTbqRF8sIcyO7iPQ0kz61MnJeFo
	worQQIGsG9e5Uh210A689eHeU2QT30yaEB0gUIh+Xtm3dF6NhMOzQgWlQquOF7WLBR3FBRm4MNt
	ggp3aHlzPCfN8NF5l5Jufvgq7N5NU7e7FbDZMfcxRcRCqbjp9eCkGb9+KvyZAGqLJ67qjJiJqPW
	WZ3gpzZUnBibnxajR2bq4xMzRDCL7ciFuTwvA73TWi5zdChNDYPvLnyzYFpqtIv6zMpjAShrD76
	A7Pml/xcl+ZPbjKlNIL+CNb9oPdz6w==
X-Received: by 2002:a5d:5f82:0:b0:3a4:f7e6:2b29 with SMTP id ffacd0b85a97d-3a6d12bb560mr13887343f8f.5.1750762912124;
        Tue, 24 Jun 2025 04:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbc3G2xwmW0Oe4vryhFRrLeFBAo0H3LJ7tnjE/h1ipMaX9PHwE4uPVzYLosVI0SGtoOOvt4A==
X-Received: by 2002:a5d:5f82:0:b0:3a4:f7e6:2b29 with SMTP id ffacd0b85a97d-3a6d12bb560mr13887269f8f.5.1750762911445;
        Tue, 24 Jun 2025 04:01:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805174fsm1665923f8f.6.2025.06.24.04.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 04:01:50 -0700 (PDT)
Message-ID: <926fd938-700e-45a6-928a-34a81d0c231d@redhat.com>
Date: Tue, 24 Jun 2025 13:01:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
To: chia-yu.chang@nokia-bell-labs.com, alok.a.tiwari@oracle.com,
 pctammela@mojatatu.com, horms@kernel.org, donald.hunter@gmail.com,
 xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, ast@fiberby.net,
 liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
 <20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/25 9:33 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> +static u32 get_memory_limit(struct Qdisc *sch, u32 limit)
> +{
> +	/* Apply rule of thumb, i.e., doubling the packet length,
> +	 * to further include per packet overhead in memory_limit.
> +	 */
> +	u64 memlim = mul_u32_u32(limit, 2 * psched_mtu(qdisc_dev(sch)));
> +
> +	if (upper_32_bits(memlim))
> +		return U32_MAX;
> +	else
> +		return lower_32_bits(memlim);
> +}
> +
> +static u32 convert_us_to_nsec(u32 us)
> +{
> +	u64 ns = mul_u32_u32(us, NSEC_PER_USEC);
> +
> +	if (upper_32_bits(ns))
> +		return U32_MAX;
> +	else
> +		return lower_32_bits(ns);
> +}

Minor nit not intended to block this series. If you have to repost for
other reasons, please consider dropping the 'else' statement;  the
alternative is IMHO more readable.

/P


