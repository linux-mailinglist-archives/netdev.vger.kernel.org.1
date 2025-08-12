Return-Path: <netdev+bounces-212790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B969B21FD8
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F167D6807F5
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60872D6E62;
	Tue, 12 Aug 2025 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtBE8Tz0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099042D781F
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985067; cv=none; b=RUCIreEmBQcLwDg64ldHRcO+xtrNCzmgde8Bq108tEPFbwSDOLO4LKpV0UCtE6ibsDZRPKiBi6R/CnvES4tkdzcFrr1pn2zWqIT5kQmRq3xxaUJA3mnicvqkUlde9BLUhgTw95VCgL7OruFnKgfJ1N8Th9CTmVLFvSTPKCDX7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985067; c=relaxed/simple;
	bh=6FcqwIFbYDR7SR+Vnwf1iscwwu1oh82gRRHzaKm0EX0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ci8Pru42K8pJfhJ0fYRR5Lq71GLoJOvvAAbyccVcZxLGV60fqLyDe+MlFDfRqazmwc9Z2+UA4tBSwYTppDgfy05E4rCYpG1xF9sCBwB6tfSaM7kzOwuZiiK5KWD4ylLhNhKyB+Z/jdG1IPzv1BDODtdiQVCYDa6CNeTWphWQs8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtBE8Tz0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754985064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l0TOi3NsfzGGG2ydlG14RKfRoWrXPVBirqvc7jxpA/s=;
	b=WtBE8Tz0bM1bOAXaJGuVSA/xKOsMR/QD0YUE67PsQKNEjfn1YUQZt+RMvuEom3NS3foSsd
	TBaZE6kAbLoPAlLBufMUHMEChwl79ACyMfccMFAtnpmIcjv/QT8al2gcOeHxX8C3ZKWVfj
	zuq6gJPtlQkQ2VMILQviNpUYhdhWS8E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-1_WuHFydOoyFAshyXkUB-A-1; Tue, 12 Aug 2025 03:51:03 -0400
X-MC-Unique: 1_WuHFydOoyFAshyXkUB-A-1
X-Mimecast-MFC-AGG-ID: 1_WuHFydOoyFAshyXkUB-A_1754985063
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e69b0ec62cso1043100885a.3
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754985062; x=1755589862;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l0TOi3NsfzGGG2ydlG14RKfRoWrXPVBirqvc7jxpA/s=;
        b=FNqfSoOWAgjNX2jC/rkH4QuUsxtK9wuH3GhXvb1QGyucqhRUpE0QqJRgq46TUskv+G
         udBJA0GVQJCcIvQXe2u1WC0M9w4XoM216xJ/aZTMyXnmD8SwBslPbosD3X54lO7mgfRf
         dupNYd8BZ6APlwpPnR0y+EmFgnXzNWth49RfbEB+1ILNalvMyY+Dr6hDweo3FMQ+tNCL
         uvHXWgVtff9qU+x98z/YbyKF/Tu6h5eNC9uhfDkLJ2pmtJFo7HEmhVavzCXTFSbOS0q3
         ZDlszYa4rTpk+hDepBaF3QYKyr5Ql5qS4FTQpwijZ0yGiJz7Ls/x/JxUWvSAc2o47tmB
         EK9Q==
X-Gm-Message-State: AOJu0Yya7QPPail3Ap6ybcbCDQW53tbYpZBT+XwuHBOiFY7b23xSe7e6
	srXEMTQjVlr7l0fUaxBCKWapk89Y5chklC7Yg6jo2rj+JKlBhRa2QTReeKEOyP4G1BsiJDG8s8F
	lyH93ue5/rBa/lruG8NPxq+olnOXBkXK7YulL3qVBmtad7cr11YYB9EGMzTbK8FbumQ==
X-Gm-Gg: ASbGncueNIvJPHFlLFM/TXL0N51EL0WtWmVQjnDRUsvOeXruGusN7NCgqbwYsu4boBI
	a/SbPDbdKrIlUPHLEvt4wjPzGaob79XBkEsVkDbdZONoq2S+uQNclTLVk41QzCkiTCqIHx4xnb3
	+g/P+JBfuUdX+fTIDtKVgW/3oF9P+4kToENGJxSXAdtIWCkD8WJFexEBgEDzqT1AcuXeWtdH+iz
	5FgXmjAJnT58EwKpbOliWI1nrvXZ6xTSns2T+AbcAhemtrfS1BJCx1aegwbT0lvyturOr/7ctwJ
	v/BH5q4GvBPfsfTADrqHdHGuQzGCfg+aJzd+H7u707Y=
X-Received: by 2002:a05:620a:440b:b0:7e8:2c04:140f with SMTP id af79cd13be357-7e85880b848mr380958585a.14.1754985062597;
        Tue, 12 Aug 2025 00:51:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUbrxFfx8sd2v6OC8+o0ciYcjY42jBqu+ZlCnCG2eVlRZMAQbB0VdkiXLS9g6iS/ke0yILRQ==
X-Received: by 2002:a05:620a:440b:b0:7e8:2c04:140f with SMTP id af79cd13be357-7e85880b848mr380957085a.14.1754985062096;
        Tue, 12 Aug 2025 00:51:02 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e83515176dsm659068485a.44.2025.08.12.00.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 00:51:01 -0700 (PDT)
Message-ID: <766e4508-aaba-4cdc-92b4-e116e52ae13b@redhat.com>
Date: Tue, 12 Aug 2025 09:50:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 netfilter-devel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Subject: nft_flowtable.sh selftest failures
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

the mentioned self test failed in the last 2 CI iterations, on both
metal and debug build, with the following output:

# PASS: flow offload for ns1/ns2 with dnat and pmtu discovery ns1 <- ns2
# Error: Requested AUTH algorithm not found.
# Error: Requested AUTH algorithm not found.
# Error: Requested AUTH algorithm not found.
# Error: Requested AUTH algorithm not found.
# FAIL: file mismatch for ns1 -> ns2
# -rw------- 1 root root 2097152 Aug 11 20:23 /tmp/tmp.x1oVr3mu0P
# -rw------- 1 root root 0 Aug 11 20:23 /tmp/tmp.77gElv9oit
# FAIL: file mismatch for ns1 <- ns2
# -rw------- 1 root root 2097152 Aug 11 20:23 /tmp/tmp.x1oVr3mu0P
# -rw------- 1 root root 0 Aug 11 20:23 /tmp/tmp.ogDiTh8ZXf
# FAIL: ipsec tunnel mode for ns1/ns2

see, i.e.:
https://netdev-3.bots.linux.dev/vmksft-nf/results/249461/14-nft-flowtable-sh/

I don't see relevant patches landing in the relevant builds, I suspect
the relevant kernel config knob (CONFIG_CRYPTO_SHA1 ?) was always
missing in the ST config, pulled in by NIPA due to some CI setup tweak
possibly changed recently (Jakub could possibly have a better idea/view
about the latter). Could you please have a look?

NIPA generates the kernel config and the kernel build itself with
something alike:

rm -f .config
vng --build  --config tools/testing/selftests/net/forwarding/config

/P


