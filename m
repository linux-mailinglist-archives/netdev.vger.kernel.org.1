Return-Path: <netdev+bounces-278296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFz3ErjX3WlLkAkAu9opvQ
	(envelope-from <netdev+bounces-278296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:59:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D8A3F5D5E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42CD330067BE
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 05:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4836833066E;
	Tue, 14 Apr 2026 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="PeKl84O5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D023A562
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776146357; cv=none; b=rkYmPmAwBkY5HZ8QYO7Kgv4TfbMG5ohY0qxvAs9gVCH8d68+Mxyv+cnwH+rAJad5vTFQ2xToPEpLmeQce61lsD6S6ewZdig4/Ad10at9tS+4MuIknq/eyvblVJXmNWKa2JJjAsTAxZcD2t6ZVLV9cdmGe2lhTB8bBm8iIDOZhIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776146357; c=relaxed/simple;
	bh=IXFwVz7pP81B0uC19OlWZ820OcjrEtLhkBy2UNGkeS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGzNS5EPK+fFqnC/+C/Vqw6uV8MEUIfNjaETaoPeO5AT8MMoBp0ae6fTYhW4steKUDrgnDI+Vb/jPmnyNtvkA3H6xwSlhVhuX5TpQC/arKzzve9EWCX0XcuE1khwRfZCyDc/Ci30rXcHC8OGLOm7HIvi2uDCIcIVqSAgi/S2MFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=PeKl84O5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b8efed61so49694005e9.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1776146354; x=1776751154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JM3KKroWo3iah2X1lSRBk+9/kqAHz8X4Y/dyTwo34GU=;
        b=PeKl84O5a9/z5SMZf7N/CM/Fk8zKzWSQBSc9hOiKDdVF4LIQulpszjrkUPNHcfvHjD
         QMgP9HgfeDi+9NTtBg5fDba7jlk5mFIIfJbh7ygB1Xrse753wiOcj854QETTP60FZe6B
         u6YFs2i3MzFsVG3zS1I4jK+0KQLa9XG1aNWM0gKRIDsFFsPwZNdmW4rQnv0An7cuvnrd
         KCOy9L6CSB8dW+2eL3WxvkS1KWuet3WKcoo13fAQVw8SCawxtgYjq/Q/nzuZpNGbppQM
         TgmifLMaORDWk3GSscJSTv/jEEmfVr+vjrg0QPJhJoXfeNA/p/6C8JpRfpqvz4aMuUNH
         4Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776146354; x=1776751154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JM3KKroWo3iah2X1lSRBk+9/kqAHz8X4Y/dyTwo34GU=;
        b=UcPiJNI5fnEZBEeSPb6btXPBHxwMCTIQ7oihVJVbAa1iC1NDkB6q1cs3HaAtqyqRbB
         Nr5xqP5IjizWoV38AqudsMgHdYcfACp8oCelM35mqvCjugJgW6vEG1QTKt+H9AnAkJ6C
         5htYOWu3bh4udPADfd1kXaYgukERI+/61TIxiXAlcWfBN4jx6ItrbyWgG3XEwyjx3fil
         n3WO7p7F27GV6oS+r4lHTk1kpZGXIyZYxjPW4aMDM/jm0kU91Z7OsMtFQyUgMRRol1+U
         o+bcMPkO1bNt60s/3LUTiMdaeemvr6IqR+8FEo/Lat3uQy7HqMnmXxfmnpm1QZSAvPUP
         Ptig==
X-Forwarded-Encrypted: i=1; AFNElJ//7CJswRSp7LgppE2Mq9/ehpAJod+wKhI70Q2XsCbWv7SllxlOVujy2klUOdrhrb2mCtihnhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDTB/REO/mvq8UPK+TIPnyxVm6qiSP7u4VsjvpJKmgHUjDAaLv
	s1r7Lo3AIRKnK9EEHHq9URC6LJsHeE0ID0t52rkiv8v4wwO5NbPoq2ITEPT4WKmyVL0GVi+Dfq4
	/NRYc
X-Gm-Gg: AeBDietUvbC0Z3SAWrJ6u2arDYJJjgsnN6ypqk/jtxvn+mB6ocdROeIS0uIX5hZ4FrR
	/S+FQcLNRVt3VoqtRH+XxO/HSgvyP7y6FdoskCqjCuJLsVr+z179kHRQsNhRnm0rRMUmvkDR7Mk
	+FmYS8NEX5+MT0HEzs/dP4LDPJgg9aHHeb/L/bQsRGCVxyKTjTGwOjZ1XYrxf1zijTY0NdDrXhU
	+tmjBYl1lNAGGJM+pYe4Yw1X8Mznq2clPukZHiaDwPRziXJOIpV5KmluYBkLfoNK6F3qemroFHD
	X+wJH9nn7mk4dgP3nep+N+2Rs2P+mKPnD5fms7xpGpoIk9DZgidKE3pNrDV+rZfgNtwFY3vHAel
	I8ecibtqwP6A9ft5MVFNztBiEbOvSjsFU91yO2CWfx0BU6yfPaSutJA+FUQm3ujTnoDQs23CCOQ
	Lyoqj2UfIOL5xnwh8r6tfvLEVpMa1zANwatThTvoAIfiM9yF6NToZCpCE=
X-Received: by 2002:a05:600c:a105:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-488d681701fmr146503485e9.1.1776146354210;
        Mon, 13 Apr 2026 22:59:14 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee049333sm21754165e9.15.2026.04.13.22.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 22:59:13 -0700 (PDT)
Message-ID: <2ede8302-91ea-4a27-b8ea-1813cc0eff0e@blackwall.org>
Date: Tue, 14 Apr 2026 08:59:12 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] selftests/net: Add additional test
 coverage in nk_qlease
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: kuba@kernel.org, dw@davidwei.uk, pabeni@redhat.com
References: <20260413220809.604592-1-daniel@iogearbox.net>
 <20260413220809.604592-4-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260413220809.604592-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-278296-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iogearbox.net:email,blackwall.org:dkim,blackwall.org:email,blackwall.org:mid]
X-Rspamd-Queue-Id: E5D8A3F5D5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 01:08, Daniel Borkmann wrote:
> Add further netkit queue-lease coverage for netns lifecycle of the guest
> and physical halves, channel resize across active leases, single-device
> and multi-lessee scenarios, L3 mode operation, lease capacity exhaustion,
> and corner-cases of e.g. queue-create rejection paths. Also make the tests
> more robust by removing the time.sleep(0.1) after netns deletion and turn
> them into a wait loop.
> 
> Full test run:
> 
>   # ./nk_qlease.py
>   TAP version 13
>   1..45
>   ok 1 nk_qlease.test_remove_phys
>   ok 2 nk_qlease.test_double_lease
>   ok 3 nk_qlease.test_virtual_lessor
>   ok 4 nk_qlease.test_phys_lessee
>   ok 5 nk_qlease.test_different_lessors
>   ok 6 nk_qlease.test_queue_out_of_range
>   ok 7 nk_qlease.test_resize_leased
>   ok 8 nk_qlease.test_self_lease
>   ok 9 nk_qlease.test_create_tx_type
>   ok 10 nk_qlease.test_create_primary
>   ok 11 nk_qlease.test_create_limit
>   ok 12 nk_qlease.test_link_flap_phys
>   ok 13 nk_qlease.test_queue_get_virtual
>   ok 14 nk_qlease.test_remove_virt_first
>   ok 15 nk_qlease.test_multiple_leases
>   ok 16 nk_qlease.test_lease_queue_tx_type
>   ok 17 nk_qlease.test_invalid_netns
>   ok 18 nk_qlease.test_invalid_phys_ifindex
>   ok 19 nk_qlease.test_multi_netkit_remove_phys
>   ok 20 nk_qlease.test_single_remove_phys
>   ok 21 nk_qlease.test_link_flap_virt
>   ok 22 nk_qlease.test_phys_queue_no_lease
>   ok 23 nk_qlease.test_same_ns_lease
>   ok 24 nk_qlease.test_resize_after_unlease
>   ok 25 nk_qlease.test_lease_queue_zero
>   ok 26 nk_qlease.test_release_and_reuse
>   ok 27 nk_qlease.test_veth_queue_create
>   ok 28 nk_qlease.test_two_netkits_same_queue
>   ok 29 nk_qlease.test_l3_mode_lease
>   ok 30 nk_qlease.test_single_double_lease
>   ok 31 nk_qlease.test_single_different_lessors
>   ok 32 nk_qlease.test_cross_ns_netns_id
>   ok 33 nk_qlease.test_delete_guest_netns
>   ok 34 nk_qlease.test_move_guest_netns
>   ok 35 nk_qlease.test_resize_phys_no_reduction
>   ok 36 nk_qlease.test_delete_one_netkit_of_two
>   ok 37 nk_qlease.test_bind_rx_leased_phys_queue
>   ok 38 nk_qlease.test_resize_phys_shrink_past_leased
>   ok 39 nk_qlease.test_resize_virt_not_supported
>   ok 40 nk_qlease.test_lease_devices_down
>   ok 41 nk_qlease.test_lease_capacity_exhaustion
>   ok 42 nk_qlease.test_resize_phys_up
>   ok 43 nk_qlease.test_multi_ns_lease
>   ok 44 nk_qlease.test_multi_ns_delete_one
>   ok 45 nk_qlease.test_move_phys_netns
>   # Totals: pass:45 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/testing/selftests/net/nk_qlease.py | 951 ++++++++++++++++++++++-
>  1 file changed, 946 insertions(+), 5 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


