Return-Path: <netdev+bounces-230039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B4BE3278
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67557586C92
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFF91DF987;
	Thu, 16 Oct 2025 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mB80dZwj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADCA6F06B
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615286; cv=none; b=mhXSCLLdhSTjX0wn9FLmn8GmQLGlwWm93ZKSqpOOIB+PzBA2hKnHW0bKWr6ssaae+k5AO6LIbMGOK/6p24NuyL0c+0Jevos5P/dlJHMx5chdsw+bITeDleYiDQtTPdyn0UI03EGvsZ1VIAeqoqq/FaEFDYGomEq6XrmQqjie0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615286; c=relaxed/simple;
	bh=Dc8waBH75ppgUwF+xT+5Jh0KGOEm144WX8Rv0Wr3F9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhJU+OOsJ7JMLjUkAf5GeR42gV5jDsRzuckwieGy89wC5iaklEkfbJFLR9mdHKcOg2TEmCS0KCnNJ5R1tmwWa2Nb2eSghHWtbXhmIAfk51kQOyA0UWI70a9X9q5quC+CilOXM911DiM6+aNQRxzrl3Zcg4MkRWsB7O1AbuMS0So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mB80dZwj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so102973666b.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1760615283; x=1761220083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1OoSzMQ2BfeSHJmR9F+oLsMuK/mPY4C0ug3bI9+xK8=;
        b=mB80dZwj0aoDdWjZRjQl+PT5Ll65HLUkvmpLwdrxA64VhLTyaiAx0hpUZIcy6R9LlM
         38mCvypsiSXzNhwpAv9X5MUCE1WJDM0Gdfh6Srv7s4UPB3MXY1rRFun1YiB2SwmowLPU
         UVdsIECtkmRFYyT3sOhKseOK2zpP6NGU53XrBfw3JAvbGZWIOzGPiJshx6RIA0jVyKXR
         WTvUkos6C1P7bCRObqgFjt8qREfHt1gWB/J6uGkw0WiZonAyW4Hs65mQZj3+O+fTb56o
         Qlpk6qH3aOUHNSZXHrhlFp6hLCk/oULFBhkneE0coqBbuBiR618AT/hO3KkkO1fuVD71
         Pfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615283; x=1761220083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1OoSzMQ2BfeSHJmR9F+oLsMuK/mPY4C0ug3bI9+xK8=;
        b=pUg40AcWUUbLAOFJLoY6uMlrLCZ+8GvjilUqA0/GPsvBaN0EQ1NyGD7FKYTzq91W+j
         Y3TRcs8ZOmLAvaQZWNMkeYVrr1pi+rmjt4wtfhjR83FkWKIFnQQiChCKAJbqqNY0p8zn
         dCUQnIS9mFqKBuPIFiOJJe/tCJQueqraLcQ2ANG0/sMSXz+7iVohnIeWibYFl11jX2Uk
         UB9ldvexuvk6/rIGEWSfNnEnXcRbVwH45pgYEbFL+WUqkLJLMuI3/5/27U8kWj2zEETh
         tWqmiU/nibo8t0iC46T2GUz/LBuRcn5vo116+fd+ubTLwIn10qU31orWPRNpJ3QysiKQ
         6LRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYpJ+HDZPJ2eiMhrPs75rHPDXeIB40dl6SQJ7qswlO4ItGc2ZzOGKiTDjZerjb+r7UZWbIo4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWf77bmVfCVhpjwKMfFyNgVCiDxSgKQIx5b0XyacslJM9+pnf9
	T3HjKgT28sKaOnSCs9uftposR10gOVThxyTDzg8Nb+WKB27AZnMPNzitWSyyUUbiISA=
X-Gm-Gg: ASbGncvJXyXPhV4se0KTHAnxdfbUrKtHNg/gF8RTCcKYdNGer65iYQI0smFVv5IzkXl
	75xCyDbbSF0POCeiTPtNgIjcpYY8AjJblMw2R9+uTE22tFVO9ZvWnLEbP6XHz6MlsngT2aAm0g2
	aXiVtnDWryLhaQxoaslcKmVtooGXsANRIbYvc0Ox/DxXG1PQYwXgi35NrOpO8Xu/LpQPEI5pa7g
	kxM9WR3lX8G/9k2Q0bU1F6o4TR7aAp/pkFIwlWSUkiu15kh5Y6AoshOFYsdW9Ge3C4KScMvQokJ
	+Oh9HnWWoIdX+2St2rv9P4I/GvGY15a2ntBL5pO2oDdvIjigPwjo82zDa964B2Ww4xOFIHfTTGw
	/N8uYDyknyMWHAUbswK5PDEQrmtEjojIADBst9aG3gqeCJ9DFCzA/w9InzPMMbRPMo5bEmuTP8y
	EJoeeRJyETIFuuBlm5OvA0SAlXlHXkWFUuLdBCQUxFNhE=
X-Google-Smtp-Source: AGHT+IH8YHOHFygEA51kD/ARZUgEozIeKuYwMXGPIRI9Q65ZsmuRwD98EhsprbuQbJpmp6PL98WWkA==
X-Received: by 2002:a17:907:868b:b0:b3e:babd:f257 with SMTP id a640c23a62f3a-b50aa49207amr3909997166b.10.1760615282550;
        Thu, 16 Oct 2025 04:48:02 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba45ad2fsm495856966b.35.2025.10.16.04.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:48:02 -0700 (PDT)
Message-ID: <0cf528b8-7d6a-4e50-b91c-d83b4cb65e2b@blackwall.org>
Date: Thu, 16 Oct 2025 14:48:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeep@us.ibm.com, i.maximets@ovn.org,
 amorenoz@redhat.com, haliu@redhat.com, stephen@networkplumber.org,
 horms@kernel.org, kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251013235328.1289410-1-wilder@us.ibm.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251013235328.1289410-1-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 02:52, David Wilder wrote:
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
> Changes since V12
> Fixed uninitialized variable in bond_option_arp_ip_targets_set() (patch 4)
> causing a CI failure.
> 
> Changes since V11
> No Change.
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
> David Wilder (7):
>   bonding: Adding struct bond_arp_target
>   bonding: Adding extra_len field to struct bond_opt_value.
>   bonding: arp_ip_target helpers.
>   bonding: Processing extended arp_ip_target from user space.
>   bonding: Update to bond_arp_send_all() to use supplied vlan tags
>   bonding: Update for extended arp_ip_target format.
>   bonding: Selftest and documentation for the arp_ip_target parameter.
> 
>  Documentation/networking/bonding.rst          |  11 +
>  drivers/net/bonding/bond_main.c               |  48 ++--
>  drivers/net/bonding/bond_netlink.c            |  35 ++-
>  drivers/net/bonding/bond_options.c            | 140 +++++++++---
>  drivers/net/bonding/bond_procfs.c             |   4 +-
>  drivers/net/bonding/bond_sysfs.c              |   4 +-
>  include/net/bond_options.h                    |  29 ++-
>  include/net/bonding.h                         |  65 +++++-
>  .../selftests/drivers/net/bonding/Makefile    |   1 +
>  .../drivers/net/bonding/bond-arp-ip-target.sh | 205 ++++++++++++++++++
>  10 files changed, 467 insertions(+), 75 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh
> 

I remember reviewing previous versions of this patch-set, please CC all
reviewers for future versions.

Thanks,
 Nik


