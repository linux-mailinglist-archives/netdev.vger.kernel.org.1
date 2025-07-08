Return-Path: <netdev+bounces-204918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9397EAFC877
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C931565D65
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9733285CBB;
	Tue,  8 Jul 2025 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgAJdjVx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EE8230274
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970564; cv=none; b=eSKwk0ZTDwJ4BYdDoFOomSbfao3KaLgn1Q5ceGgu+GNWy8LHYuTfsPHWQUwPAFsrL63NBGV8dhDs0sUpTvYGrbFvB5sNubFS3L24X7R3DhEmoEgEYNE/99fDrw8KEMNcxgwn/liBLON2BpuBpix16KkT6+0nAZjbcNFj32zoQ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970564; c=relaxed/simple;
	bh=nDKaw5wp3wPv6Su7DJn1ZlaCFO+KFc/YaXghu5EPCUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MM3Idjk62Mo2mIWmiaF78jCLB6kO81wTKnC2SvuoZZGFwifvslONzSgBJHxiSPpe/nKVwllXoZaqJcRlMB2KYf9MC4JlH1DFWhRAMbJ9brv1crp07ObfxtlhCx1Q0JImuP+nXyXvdsfzhsZDknCMmZBhgiqD+w+ySgiCAS132b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgAJdjVx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751970562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CzUCEXFgRnyn/r8sZIiHWX26XZZ+a95NsXDWMh+fb0=;
	b=HgAJdjVxH2ZLqdEQhOdfBLK7MJK+xaxPAlB0ic+m+8xO5JsMXfgTHodvR6fjt5Yog7SiNO
	+CR9OosJyHZoW4q5WLH2/vO750ZfYKFZqXsO4WoIMM5SY+YgZOlhZ0XTNgMubs5JrPVebB
	DQzB6hPG8x4pA5i/c3xMTS0CZuiOMb4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-8Rgx3AIhOTmnYD4e8TuzNA-1; Tue, 08 Jul 2025 06:29:19 -0400
X-MC-Unique: 8Rgx3AIhOTmnYD4e8TuzNA-1
X-Mimecast-MFC-AGG-ID: 8Rgx3AIhOTmnYD4e8TuzNA_1751970558
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d5600a54so33631825e9.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 03:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751970558; x=1752575358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CzUCEXFgRnyn/r8sZIiHWX26XZZ+a95NsXDWMh+fb0=;
        b=K0/MgTNp/ICl8MGGasdyGhPnkScMAIuAp5N16Wil7ND++LqBFIqmPDf4huOUyqK+KI
         s1eZYHPVs/WI9c1O6f6KAuk2W0BRmJQR4a7lmeQsJkvHfUpvjHMNAyFYEn+E3KzdiHfK
         xD3Ow2Ncj8At7EBovbEbUr8fne6FItgbcu1E9LNmuDp6SPhdVQAcp1y/yuJFGzqtHBOm
         pSHLJQWnBukqqtlwYFJPgctf0yMCAYWHnyZ3NgrAGt2maDmNcJ7R98xf4OIRHTB6Iu2P
         njqWOSBsDkuEyzPAEkfG99Q3aifbFuZKYzjUQdzesswLbIy2COdL2VaY8uxw0nbkaubo
         p4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7J2ZU72TsqLZycTsfL219OrFOgfUs3XSTStYH3ajrOtFIc8pMAY5bIAj/RUlbDMeInoDcbO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Pzu7R34Z/hJrBb4/H2b5rVrFa/8GHhdCg2QLCAfOBp1kf2fw
	WCHFaoq4He0pF6GJNa789Y/R4zKtN86XDn7oVdYJnTvYvLKXwUpcEtka5EWTHZeGcS6MFSzFEYL
	jh1pWW8J5KdqpeCwWWvTp35jDkXKcWUfpb3k0L6upjgtx+ZxE1N4a5C0lEg==
X-Gm-Gg: ASbGncsZqJOXD0x/jaTjgIJAt/JvqkYqw2BQYy1JLrLBTs0dAByhXdwk9Wt13EI0Liv
	tQH4jmPrPPwKKT7mLS1sMRStHhU0lShPXLWvzt40s0LgTbFIFj71IAbtTyAGUB3eEt7W006V30l
	71OVGBOXhkvpZS0KonKnkdfNzMNe9aAtSnn/4ZvmLx0i6qHSI8dz4DwEt1BBdzZRoFPQDtVPHyD
	O7pz5Ns2v6s9ltMzVREhiwJjn3tdqCbZmlbegdkfwmSISmhxK6YpvFoIP9c8Hje4qFa3i8/vGSx
	pgKPdESAVEtfZ2w4C9MtddRete1UMtIn4F8Q8KcRsyNTxjZ4kFx+MlgWpB+2oHb5sEEN5Q==
X-Received: by 2002:a05:600c:1551:b0:451:df07:f437 with SMTP id 5b1f17b1804b1-454cd523b5amr27866785e9.30.1751970557688;
        Tue, 08 Jul 2025 03:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV0sIn/btpu+R8moG7ALddhsgbp///BKMaHji+kT+s2LKs30wzMAiPIvbc826P3wci6D5VQA==
X-Received: by 2002:a05:600c:1551:b0:451:df07:f437 with SMTP id 5b1f17b1804b1-454cd523b5amr27866375e9.30.1751970557268;
        Tue, 08 Jul 2025 03:29:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd44ef0dsm18172565e9.13.2025.07.08.03.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:29:16 -0700 (PDT)
Message-ID: <13b00d4f-ad0a-409a-b9c1-0f4e195450a9@redhat.com>
Date: Tue, 8 Jul 2025 12:29:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 net-next 1/6] sched: Struct definition and parsing of
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
References: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
 <20250702032817.13274-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250702032817.13274-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 5:28 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> +static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
> +			  struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *tb[TCA_DUALPI2_MAX + 1];
> +	struct dualpi2_sched_data *q;
> +	int old_backlog;
> +	int old_qlen;
> +	int err;
> +
> +	if (!opt) {
> +		NL_SET_ERR_MSG_MOD(extack, "Dualpi2 options are reuqired");

Minor note: typo above ("reuqired" -> "required")

More importantly: the above is inconsistent with the below code, where
AFAICS it's not enforced/mandated the presence of any Dualpi2 option.

i.e. User space could successfully provide a TCA_OPTIONS with no nested
attributes.

Am I missing something?

Thanks,

Paolo


