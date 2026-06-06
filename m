Return-Path: <netdev+bounces-296156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p60ICJWFJGqv7wEAu9opvQ
	(envelope-from <netdev+bounces-296156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 22:39:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAE864E509
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 22:39:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JiETHX0M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296156-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296156-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AE71307BC00
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 20:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36ED2DC798;
	Sat,  6 Jun 2026 20:34:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9530EF94
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 20:34:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780778048; cv=none; b=DNYbwdfq9ZsE3WnP63plc52qu4e7XOuJ5KSYFbDld+1MpbYohOSPDaltrasDNhH8XrGtluuKTX/b+iAEQR38TPpSsPkmjYpR1Z53VbyNdmY93kWuwom9JtI8Og8RX7jjTtRq4zc7JCcLOpWeuvW44BFcXJ55K7Gkb/MV9xOVJ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780778048; c=relaxed/simple;
	bh=KZfgjYV0I+8RaYIW8rTryt4IF3AwZYO8MCxZBeKc3kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcS7p5HNs1K+hWp17pKNPvmo5pZKaJduvfjTZnccmJZ9oKj55ipa2xTyM2c8yQOB+3w8J349hXvzN70pGbxKnTpqhCrdxRODS16RgcDalWWO6q2Pm45rpDOD/8RPltbd/dQy645NE/BtubAfx10s4QshdsGvAaJdmz3qMctANMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiETHX0M; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso36219605e9.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780778045; x=1781382845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WixW9hwBnhDlhC+Gdp2bGWzDhW7ze8+rpM+LOh8QrUk=;
        b=JiETHX0MZYQNfcCihTX03Pxe1E+9dNo94N/WgNwcxDgNdupqoSDIWtvZ0ZNh1j0uCQ
         xHMFTbh9PpXkeLYG2NNaPKEEvcUPYXDhPxzeoE9/52d33yQAbxr8eG1OIvG36ZGQYfdq
         nCkwNQAzKH4X7zWxzlyACYMgUbQt36eLbxJY18QL4ZkbYQRTcCz07xVK0BrJw8wf4KYq
         JD1QB/q23sIVxnIgxDEVpFkUZGoWBiV704+vpMp4wHgb9BaOmoeZ7npc9Yd8q3gCb5Mj
         CUS/d+eD8pqM7Bli/2DMLjf+I64vdCetcr+6TElImf6ouU77T95QmKmCdUe2ToWNfHZd
         lJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780778045; x=1781382845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WixW9hwBnhDlhC+Gdp2bGWzDhW7ze8+rpM+LOh8QrUk=;
        b=MXAzOa/Ce1dgiVyY1jMuAv9Uj5s7TJVcj+lKbWZxANgPvxO+ciG+r42L7BjSYmgC3D
         micFSdPp1MSwLhD5+YTnxFr8J415VEiSAolWBdaCedBu3TNO5AEZeCYdzNgls5bj3iNM
         TRqVoC5nP/JLkFEERSWm9VBLBZz6g2B8t9hFbVGsi56Xjifn78j7w3ORUxXxttj0XDcX
         Uc19y/5r22Qw4rhJ7HaTIhM3CeiG7yOtfd+MkE6651tqJ+4zAEVGjUUVT1Qsnq6g1tpU
         44aVX75q2IpvQLy0vPR2C+Lw43yJCmbq3TMig3bNhJ4L1cRAxt+j4m1p+1i9Fy/NWLlb
         30kw==
X-Gm-Message-State: AOJu0Yxca+UezrW8uhrUHzMpvAg50YmxyJlwSo+/2XgGmlGPvBvunrVT
	F3WbhlrYX2EQL1dgmyIYdykI3vCVHRECy0TrTN15Mt3QKzIYkVDIyy/GTHUiG3gz
X-Gm-Gg: Acq92OF/4K/bvYCsGRgRkDMsgKej6uEiObZ02ifvEbJkVbQ+jMxPfPAbSE7flw3oDPV
	Hx2T/69YjwpO8cuUpBkYp1ZWJdoqcz6pDEW+edoQy5STZ2x/odTTMx9jFkClkodQSrQcmZVnbk3
	KQVh3VZNCbRqptvYLT1WW6+d0ZF3QL2dC5/SN5jiEDTHv1gxeX3NCO33VmqfPSxg4KMOglXAfnp
	vc35fY0S9/KAT90ZlVuLzEQfJo5Hd2v7nPKOGZxi5NlHRz5uYdSU1UHuZj1MHUOlaahuafZX/uo
	Nr9/d9cn1yFg1WMXpe4rujKq+ym+n6M3EIR1RaNhM7kFRiuPe1qZJ0bFy68T8s7tOzk5m1RpmUS
	pRnXu2OQl3U6TwJUjo7vzjJYK3MVvhLBls5ShxIkxaYxdSm2X1yFMZ1KTxfJZWozJABGbS7SL03
	rz6P4mWVyYDw3+/HPJBUsW4hPSQ7luXZDoODRHKTH5yDkqlABehkaaRhbUULQUnjRaiMbcWquKx
	YMObNSC2z6IOo7V8w1zI9XxWCq1pjiRELxYZqEhm9GAfkAiqV4+iEdLSPqevXPHCsPN9hQ=
X-Received: by 2002:a05:600c:4fc9:b0:490:b8c0:d474 with SMTP id 5b1f17b1804b1-490c25eee06mr146206745e9.14.1780778045349;
        Sat, 06 Jun 2026 13:34:05 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4a:1a00:ac2e:7640:d3:7bd5? (p200300ea8f4a1a00ac2e764000d37bd5.dip0.t-ipconnect.de. [2003:ea:8f4a:1a00:ac2e:7640:d3:7bd5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc0f8sm255109875e9.8.2026.06.06.13.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 13:34:04 -0700 (PDT)
Message-ID: <18427976-e075-4a36-bd67-22e4fa5792ab@gmail.com>
Date: Sat, 6 Jun 2026 22:34:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 221606] r8169: PCIe AER errors and recovery failure after
 recent driver changes
To: Javen <javen_xu@realsil.com.cn>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "lasse@lgb.dk" <lasse@lgb.dk>
References: <bug-221606-201211@https.bugzilla.kernel.org/>
 <bug-221606-201211-LMiiKJhHhg@https.bugzilla.kernel.org/>
 <b1bda1da-8231-4f05-94a7-7511041ae489@gmail.com>
 <9b206f58d93b48d194980374cf0da7b1@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <9b206f58d93b48d194980374cf0da7b1@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-296156-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:netdev@vger.kernel.org,m:lasse@lgb.dk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEAE864E509

On 04.06.2026 11:01, Javen wrote:
>> On 03.06.2026 09:44, bugzilla-daemon@kernel.org wrote:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=221606
>>>
>>> --- Comment #2 from lasse@lgb.dk ---
>>> Commit 9ab94a32af704fa9c873094283ae8744a07baf25 (r8169: enable LTR
>>> support) seems to be the issue. Running the commit before this doesn't
>>> give me any AER errors and everything seems to behave normally.
>>>
>> Bisecting the reported issue points to one of your commits.
>> Could you please check with the user?
> 
> Hi, Heiner, Lasse
> 
> Thanks for reporting this issue.
> 
> Currently, we haven't received any similar reports from our customers, and I am unable to reproduce this AER error on my local test platforms.
> 
> Could you please provide some more detailed information? The full dmesg log will help me check the exact AER error messages and the boot context. Also the output of sudo lspci -vvv. I need this to check the exact platform information, PCIe topology, and the LTR/ASPM capabilities of both your Root Port and the Realtek NIC.
> 
> While reviewing the initialization flow, I noticed a potential logic contradiction. If rtl_aspm_is_safe(tp) returns false, the driver disables L1 at the PCIe core level, but tp->aspm_manageable might still be set to true. This could cause the driver to incorrectly enable ASPM/LTR in the MAC registers later, creating a hardware state mismatch (PCIe L1 disabled, but MAC LTR enabled) which usually leads to AER.

rtl_aspm_is_safe() just changes the default and doesn't disable L1 at driver load.
Note that even if L1 gets disabled at driver load, the user can still re-enable L1
using standard PCI sysfs attributes (w/o r8169 driver being notified).
Therefore driver must not make any assumption on state of L1.

The hardware state mismatch you mention should be prevented by the hardware itself.
PCI standard registers in the chip know whether L1 is enabled, and chip should
prevent any unsafe PCIe bus activity (independent of ASPM/LTR setting).

> 
> Could you please test if the following patch fixes the AER error on your side?
> 
> -	if (enable && tp->aspm_manageable) {
> +	if (enable && tp->aspm_manageable && rtl_aspm_is_safe(tp)) {
> 
> Thanks,
> BRs,
> Javen


