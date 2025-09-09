Return-Path: <netdev+bounces-221254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAE7B4FE3A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D747A2BF5
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253DB33CEBB;
	Tue,  9 Sep 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="GgkRQ2dQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EBC2C0F60
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426056; cv=none; b=oh7W+kMOxa46aYLWewT3YU4heyZGrI7M45baDEnHsJcVoLPl5kVkwrGtEL+CucpA1hwKqo302pIPjGWbAKJLxgxGNYt5qJI3X8qSkHqqpKV7gruBW/1W2sc3Yld6noI76ANDuPNqQs9mcB0Pxz2JRQbVqSjEsIssniUsdWXkGw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426056; c=relaxed/simple;
	bh=YhonCsL2+i1t04/EjSC4B5cfjBPekjGsrFkb7rcACHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqznoPblpj1SkaY1btuim9A008LCSczjYEjL7ckhv8eK+7HOB0Pw47ucceqCkJwAygJfsq2B+KbWdUOGsFU8dGUenkVPTZ1QzGlPlz4VZ86ulOqxVdRlGk4t60nWXAttc/+qyey74uTGHeutmIPYbrUqUzs5rdjW088G0+1jpBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=GgkRQ2dQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso809865e87.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757426052; x=1758030852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQHwjW0XolK2cLXoJ/mCK6P6o0gGp4hv7KOrIVUSB2c=;
        b=GgkRQ2dQBbxph1V0n/rAQGuGBGKoUieAIbwXBcec4punDZxf8MewOvF3y+pIkkJXZW
         Vi+LWvQA+9KcG+bglm9m3zq85XRKp01zp9AbQ+ZzVCnCfMcvcVsV09c7cP9GJ6PPP131
         up11fC1auvV4SoL0IjXb0GsGJ11w2W2vP4oo95MJiDiUoNTx3kMJtABJCZTM3xM9ZjJN
         N5sf30ShvPpVGCqToM0te/t5S/pdfuC7x38IybbbU5fUXU03nt0XuXsOKxhM8cLMlu/C
         ozi26uSboeux/78dlVpPuKO+hztHChoWhvBUJ4/woDPNCwtXf9tL0bavm7X7j9uGIkws
         xeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426052; x=1758030852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQHwjW0XolK2cLXoJ/mCK6P6o0gGp4hv7KOrIVUSB2c=;
        b=rWBj/++cDfeVZwdUAz9Bcsbb4R6ZFP3GkcRrpzoq4E+WpBv3Ylii+bKMxY5B2QuTzu
         Luk91rfdvN3tJHrAHP4bh+fpXEhuGepXFZLE5sPUQupRyK+0lSWamYEuLoAB7Jnqg2C6
         9X5g+zkU73pbkESaCTOUmM9r3/2yps3YzmW9meQGSHBby0WYCv9LHsk5PXcYO4Xi5F8K
         yZj9kUvya/5r8Dal/ke6gTcEsTPFGKjUiLjD0JqHfCCF3DoPpdY4pHBeKGEQK4FZOFIX
         Z9lLVWUNY3xErSOmTYAFd6BM4tC8q6uL+W1VmDkdikj+xZljhfcMsGWvqL30H8pL8ScI
         gBYg==
X-Forwarded-Encrypted: i=1; AJvYcCXSxYBSRvpD/52ulauNkyl/d9iKVmubG62OunQcuHLACMbkOmLllUrjOCnvKsoEaULTPP6Jh0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT76UCcZ7y4ANL4poR9WbGsQW3Kk/f37Gj1JW6PQhl/6EF6un3
	2ucX2WY7HDvN075yyUWOEm5QBNb0J+j6yre2ZE/6jFx+/BLGTEmfoUklHak5g+TcrN4=
X-Gm-Gg: ASbGncsMwdYrO1pZapHp6uVZpc0F1GuWsJ5D7jIje/S05DpNCMYosYICO6KXIqezehW
	/mgPZ9ZG1jMdNxoy0vw295jGFnd2ea83z1idstMMvibkEgwD28sXWzAVnBdfQruUSGA/PLcKv3L
	oik4SsewZ+DMNsZMDZL4fU0cVhvdotapVdFMDflirk+GRAr+6jIeKG+YjwJUDvrsUPkmZZsEWzO
	MZsHztaOWLjagMMEPIII73VLQVM2/QMqqHo+CV706w83F+lD9tt7xWrXyGhi1kavGJI0O+UQkyf
	Cwjsc9h8axXjqhJsf8q/2F5l6LFleaX8OMcSsamUg7F5VCZ1Re5OX8EhXKOkUDYelTHn25YUO0a
	7zlwfloXRNvdPUOTSQ0AIvCnBBhKVELV24XBppcek7pRO6PA+X0D3ztfQLgfvVd96iOJU/odi2u
	TCWQ==
X-Google-Smtp-Source: AGHT+IGf7/0YwPYPA61wZmPp1rPbdAZjk+Pj6Lkf0q+JryixDZCHM5MZkZ43/LtMSTwhpHnPiqCCxA==
X-Received: by 2002:a05:6512:3996:b0:55f:44b8:1ecf with SMTP id 2adb3069b0e04-5625f62ab83mr4240665e87.9.1757426051881;
        Tue, 09 Sep 2025 06:54:11 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680cce8b79sm543508e87.48.2025.09.09.06.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:54:11 -0700 (PDT)
Message-ID: <9a0ed3dd-d190-4d89-9756-9b36976665c8@blackwall.org>
Date: Tue, 9 Sep 2025 16:54:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
 stephen@networkplumber.org, horms@kernel.org
References: <20250904221956.779098-1-wilder@us.ibm.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250904221956.779098-1-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 01:18, David Wilder wrote:
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
>   the user.
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
>     userspace (ip command). A separate patch to iproute2 to follow shortly.
> 2) Split up the patch set to make review easier.
> 
> Please see iproute changes in a separate posting.
> 
> Thank you for your time and reviews.
> 
> Signed-off-by: David Wilder <wilder@us.ibm.com>
> 
> David Wilder (7):
>    bonding: Adding struct bond_arp_target
>    bonding: Adding extra_len field to struct bond_opt_value.
>    bonding: arp_ip_target helpers.
>    bonding: Processing extended arp_ip_target from user space.
>    bonding: Update to bond_arp_send_all() to use supplied vlan tags
>    bonding: Update for extended arp_ip_target format.
>    bonding: Selftest and documentation for the arp_ip_target parameter.
> 
>   Documentation/networking/bonding.rst          |  11 ++
>   drivers/net/bonding/bond_main.c               |  47 +++--
>   drivers/net/bonding/bond_netlink.c            |  35 +++-
>   drivers/net/bonding/bond_options.c            | 135 +++++++++----
>   drivers/net/bonding/bond_procfs.c             |   4 +-
>   drivers/net/bonding/bond_sysfs.c              |   4 +-
>   include/net/bond_options.h                    |  29 ++-
>   include/net/bonding.h                         |  61 +++++-
>   .../selftests/drivers/net/bonding/Makefile    |   3 +-
>   .../drivers/net/bonding/bond-arp-ip-target.sh | 180 ++++++++++++++++++
>   .../selftests/drivers/net/bonding/config      |   1 +
>   11 files changed, 433 insertions(+), 77 deletions(-)
>   create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh
> 

I'm sorry I'm late (v10) to the party, but I keep wondering:
Why keep extending sysfs support? It is supposed to be deprecated and most
of this set adds changes around bond sysfs option handling to parse a new format.

IMHO this new extension should be available through netlink only, that is much
simpler, less error-prone and doesn't require string parsing. At worst sysfs
should only show the values properly.

Cheers,
  Nik






