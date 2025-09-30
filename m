Return-Path: <netdev+bounces-227283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E90BBABC99
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AF31C2ADB
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 07:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58A023D7D3;
	Tue, 30 Sep 2025 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7IDYeXY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C8B2066DE
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216898; cv=none; b=uH52USU9bWe6OH8Jj9rfc87viYFPjlP7d8KhPBdMM+tTdzUo8OiFN4pgUcgzJPXn1fg01HsTX/OeXlNvtRxmhSfNNk7VquKCd0l2sz79wyyhGGXzgASUxKET2tdecGNLQCNr478fRlj33EfbL818RTaNAXah29Mm9JlSL16Sn/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216898; c=relaxed/simple;
	bh=dCRf7y+7o0G9yzamBjZL1cOYEK8gQOL68lavXqA7trg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0H9UA4cdUtK7ciaIxgmIAlPzzETbF5TMGz5vuf0uMaSVgkK+2FWn21ZaI4zmCWH19gtkSKGarPm4MXKctQ8qaml5AamjRIsxf2S4ipnZx4wzpHdqLgdJYqFj39aG0Drec1+7CKDpPNcpoD3KcokdQyFgKOhexliRujLb+wGUzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7IDYeXY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759216895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Al/i6W40xbIT4S3aNeDx4RlPkeWOU836D/dHuzJwNg=;
	b=d7IDYeXYFWYZo3UwgQGE35cu1kdkeTKPJWMwXh1I1Mg3bEOGE3GhX2RTA7rgOxarBLpaeW
	rAx5S84ZE4Dn2ZuYxwUhomo6BACkJB/sYKPJRdHbG/icLC7aUlEp8iyeSWWQ0bA0gWGayr
	P0b1xE4vHYMpT93QjLCdsd8MQ4cEOWQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-TgxHPiImO4-31ykxlrM3Ag-1; Tue, 30 Sep 2025 03:21:34 -0400
X-MC-Unique: TgxHPiImO4-31ykxlrM3Ag-1
X-Mimecast-MFC-AGG-ID: TgxHPiImO4-31ykxlrM3Ag_1759216893
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e41c32209so22677725e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 00:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216893; x=1759821693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Al/i6W40xbIT4S3aNeDx4RlPkeWOU836D/dHuzJwNg=;
        b=SDgfmc1ZNqu3bvM6sDFKcwhDvSh5GFoVXCxWfSctAhGjp7vl4g2/SqSZAlyKYWfQWt
         HglHJVBlqgAPz+DzBzG9chxtI8VylGl2Yv9c+hTpQhZPmPqtNzGJfS+jwmkzXlun0eQg
         MOn1sbslPCFvM9bAZHIB3TntCQYs8DBayydJDJSG+UMmLINPntcDx7cSWnb8bQQGCGXc
         o1FMlBfB0YZucuqtPA6DYlkSMcB/Wdt8jglPIWn2N4vpZPh5IjYBhxaBfxIAbLYS/LQr
         ljKCpulc00uwvY6VciMnoSWn+6VVdi73eqAsljxIFkIKh/zS8tEEY2AssX+EdduHosT/
         ov2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxv28+W5zCoTHnW3Wg/fMHywuePl4UPulOfNjE8MX8ynJcTozDJSWO5r/bRwr6NPC/bXsbW2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXaKzObp/Z7M05WMAQ4apObmyMsv6NUsjh8DpGTXA6Nur61pEk
	ihT5mOpWBtRpm3fngxPu2GVtqug+4GY3Zp52owjb0SugpuJRpun2tXJnTWOB3rc0y9WvTTMVeV/
	f70DOSCZ76Gv3YhBUKA8G0Wq4P+c4+HfkjHBy7o56NxTpUHa7V0Qa6VQImw==
X-Gm-Gg: ASbGncu06ECCkekGuzJP9cJ4ZzF7H5sRj/FtO9nb6ZcQc0iy33/DMBxjoQMRJXRW9Fx
	jdjPLoUSguUtl3XmRrq6gr1mxV9f8IayXwknJX3a/Fe3bSvVa+iZZAgq8gKBc6tjlaGDKJ7UMLm
	yzxn2xPvX4oO9+Lzccz0mKgJD+TJY4oQ+NmI+yAJfS79cE+cUy+u+k5kIMS7GQZb3DPhOs+ojV4
	Lo0PiKrgcvL8aFipdpgwJ9Yf51lmT3m6JW6oqyfJLm5R0T6YD6Z6yxX2SYzMFFYu67X+K8sPAR9
	NIenxDzhpgnCMlTHzsLH08lKhiIb79DKJ5cRT4vazD4RdK2ycbMtOR19eHPI1dZ+wW3JaIE5nzR
	vcED2k8UD86SqPm7Efg==
X-Received: by 2002:a05:600c:354a:b0:46e:37d5:dbfe with SMTP id 5b1f17b1804b1-46e3b187536mr127174225e9.32.1759216892814;
        Tue, 30 Sep 2025 00:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+M2vMq5nSC+tLXd/cGZyPFn8UTcDMLEeAfT13tFdgG18mJ8+8EW2Y9dpvxvUU2LkB8yHlKA==
X-Received: by 2002:a05:600c:354a:b0:46e:37d5:dbfe with SMTP id 5b1f17b1804b1-46e3b187536mr127173965e9.32.1759216892343;
        Tue, 30 Sep 2025 00:21:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f74439sm41075905e9.16.2025.09.30.00.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 00:21:31 -0700 (PDT)
Message-ID: <6be07cb6-7dab-4125-b9e5-0bd4c42235fe@redhat.com>
Date: Tue, 30 Sep 2025 09:21:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
 stephen@networkplumber.org, horms@kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, edumazet@google.com
References: <20250930012857.2270721-1-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250930012857.2270721-1-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/25 3:27 AM, David Wilder wrote:
> The current implementation of the arp monitor builds a list of vlan-tags by
> following the chain of net_devices above the bond. See bond_verify_device_path().
> Unfortunately, with some configurations, this is not possible. One example is
> when an ovs switch is configured above the bond.
> 
> This change extends the "arp_ip_target" parameter format to allow for a list of
> vlan tags to be included for each arp target. This new list of tags is optional
> and may be omitted to preserve the current format and process of discovering
> vlans.
> 
> The new format for arp_ip_target is:
> arp_ip_target ipv4-address[vlan-tag\...],...
> 
> For example:
> arp_ip_target 10.0.0.1[10/20]
> arp_ip_target 10.0.0.1[] (used to disable vlan discovery)
> 
> Changes since V10
> Thanks Paolo:
> - 1/7 Changed the layout of struct bond_arp_target to reduce size of the struct.
> - 3/7 Fixed format 'size-num' -> 'size - num'
> - 7/7 Updated selftest (bond-arp-ip-target.sh). Removed sleep 10 in check_failure_count().
>       Added call to tc to verify arp probes are reaching the target interface. Then I verify that
>       the Link Failure counts are not increasing over "time".  Arp probes are sent every 100ms,
>       two missed probes will trigger a Link failure. A one second wait between checking counts
>       should be be more than sufficient.  This speeds up the execution of the test.
> 
> Thanks Nikolay:
> - 4/7 In bond_option_arp_ip_targets_clear() I changed the definition of empty_target to empty_target = {}.
> -     bond_validate_tags() now verifies input is a multiple of sizeof(struct bond_vlan_tag).
>       Updated VID validity check to use: !tags->vlan_id || tags->vlan_id >= VLAN_VID_MASK) as suggested.
> -     In bond_option_arp_ip_targets_set() removed the redundant length check of target.target_ip.
> -     Added kfree(target.tags) when bond_option_arp_ip_target_add() results in an error.
> -     Removed the caching of struct bond_vlan_tag returned by bond_verify_device_path(), Nikolay
>       pointed out that caching tags prevented the detection of VLAN configuration changes. 
>       Added a kfree(tags) for tags allocated in bond_verify_device_path().
> 
> Jay, Nikolay and I had a discussion regarding locking when adding, deleting or changing vlan tags.
> Jay pointed out that user supplied tags that are stashed in the bond configuration and can only be
> changed via user space this can be done safely in an RCU manner as netlink always operates with RTNL
> held. If user space provided tags and then replumbs things, it'll be on user space to update the tags
> in a safe manor.  
> 
> I was concerned about changing options on a configured bond,  I found that attempting to change
> a bonds configuration (using "ip set") will abort the attempt to make a change if the bond's state is
> "UP" or has slaves configured. Therefor the configuration and operational side of a bond is separated.
> I agree with Jay that the existing locking scheme is sufficient.
> 
> Change since V9
> Fix kdoc build error.
> 
> Changes since V8:
> Moved the #define BOND_MAX_VLAN_TAGS from patch 6 to patch 3.
> Thanks Simon for catching the bisection break.
> 
> Changes since V7:
> These changes should eliminate the CI failures I have been seeing.
> 1) patch 2, changed type of bond_opt_value.extra_len to size_t.
> 2) Patch 4, added bond_validate_tags() to validate the array of bond_vlan_tag provided by
>  the user.
> 
> Changes since V6:
> 1) I made a number of changes to fix the failure seen in the
> kernel CI.  I am still unable to reproduce the this failure, hopefully I
> have fixed it.  These change are in patch #4 to functions:
> bond_option_arp_ip_targets_clear() and
> bond_option_arp_ip_targets_set()
> 
> Changes since V5: Only the last 2 patches have changed since V5.
> 1) Fixed sparse warning in bond_fill_info().
> 2) Also in bond_fill_info() I resolved data.addr uninitialized when if condition is not met.
> Thank you Simon for catching this. Note: The change is different that what I shared earlier.
> 3) Fixed shellcheck warnings in test script: Blocked source warning, Ignored specific unassigned
> references and exported ALL_TESTS to resolve a reference warning.
> 
> Changes since V4:
> 1)Dropped changes to proc and sysfs APIs to bonding.  These APIs 
> do not need to be updated to support new functionality.  Netlink
> and iproute2 have been updated to do the right thing, but the
> other APIs are more or less frozen in the past.
> 
> 2)Jakub reported a warning triggered in bond_info_seq_show() during
> testing.  I was unable to reproduce this warning or identify
> it with code inspection.  However, all my changes to bond_info_seq_show()
> have been dropped as unnecessary (see above).
> Hopefully this will resolve the issue. 
> 
> 3)Selftest script has been updated based on the results of shellcheck.
> Two unresolved references that are not possible to resolve are all
> that remain.
> 
> 4)A patch was added updating bond_info_fill()
> to support "ip -d show <bond-device>" command.
> 
> The inclusion of a list of vlan tags is optional. The new logic
> preserves both forward and backward compatibility with the kernel
> and iproute2 versions.
> 
> Changes since V3:
> 1) Moved the parsing of the extended arp_ip_target out of the kernel and into
>    userspace (ip command). A separate patch to iproute2 to follow shortly.
> 2) Split up the patch set to make review easier.
> 
> Please see iproute changes in a separate posting.
> 
> Thank you for your time and reviews.
> 
> Signed-off-by: David Wilder <wilder@us.ibm.com>

Not a formal reviews, but this is apparently causing self tests failures:

[  274.739699][ T2985] Oops: general protection fault, probably for
non-canonical address 0xe2b11fc1bf7efa00: 0000 [#1] SMP KASAN
[  274.740206][ T2985] KASAN: maybe wild-memory-access in range
[0x15891e0dfbf7d000-0x15891e0dfbf7d007]
[  274.740513][ T2985] CPU: 0 UID: 0 PID: 2985 Comm: ip Not tainted
6.17.0-rc7-virtme #1 PREEMPT(full)
[  274.740820][ T2985] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  274.741034][ T2985] RIP: 0010:bond_fill_info+0x4e9/0x17c0
[  274.741271][ T2985] Code: 5d 08 41 b9 08 00 00 00 48 8d ac 24 ee 00
00 00 45 31 f6 41 29 d9 4d 63 c6 49 83 f8 05 0f 87 98 0f 00 00 48 89 d8
48 c1 e8 03 <42> 0f b6 14 20 48 89 d8 83 e0 07 83 c0 01 38 d0 7c 08 84
d2 0f 85
[  274.741933][ T2985] RSP: 0018:ffffc900056f6db8 EFLAGS: 00010206
[  274.742160][ T2985] RAX: 02b123c1bf7efa00 RBX: 15891e0dfbf7d000 RCX:
0000000000000000
[  274.742475][ T2985] RDX: 0000000000000004 RSI: 0000000000000000 RDI:
ffff88800aaa2ef0
[  274.742752][ T2985] RBP: ffffc900056f6ea6 R08: 0000000000000000 R09:
0000000004083008
[  274.743027][ T2985] R10: 0000000000000000 R11: ffffffffb6d6ff00 R12:
dffffc0000000000
[  274.743302][ T2985] R13: ffff88800aaa2ee8 R14: 0000000000000000 R15:
0000000000000000
[  274.743572][ T2985] FS:  00007fdb2f61a800(0000)
GS:ffff8880783ac000(0000) knlGS:0000000000000000
[  274.743871][ T2985] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  274.744092][ T2985] CR2: 00000000004e5a38 CR3: 0000000008c5c006 CR4:
0000000000772ef0
[  274.744381][ T2985] PKRU: 55555554
[  274.744515][ T2985] Call Trace:
[  274.744645][ T2985]  <TASK>
[  274.745942][ T2985]  rtnl_link_fill+0x22e/0x890[  274.739699][ T2985]

full oops:
https://netdev-3.bots.linux.dev/vmksft-bonding-dbg/results/320021/1-bond-options-sh/stderr

more:
https://netdev-3.bots.linux.dev/vmksft-bonding-dbg/results/320021/8-bond-arp-interval-causes-panic-sh/stderr
https://netdev-3.bots.linux.dev/vmksft-bonding-dbg/results/320021/15-bond-arp-ip-target-sh/stderr

Also:

## Form letter - net-next-closed

The merge window for v6.18 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.


