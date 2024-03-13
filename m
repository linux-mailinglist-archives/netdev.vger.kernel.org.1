Return-Path: <netdev+bounces-79707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997B687AADA
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 17:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7EBCB246F8
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 16:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA947F7A;
	Wed, 13 Mar 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Kn3T6NJz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668DD45BF3
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345817; cv=none; b=mW6yNmJhuEOJwPKcOtiyxY9CRaBK4Dk3ESa4WWXwM87PlTT118wwCMteXIEgoJAWIFu8brBzqZTCxDXFgQr97onfX/REF8391UUy194UeLVsm5hzDcA6UO5KcWvnWP2EkBJpEkC2j/5TsNCYMFuhncTBWY2/WcKWKxw3wcAo+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345817; c=relaxed/simple;
	bh=hgTR7wzXRsKHZLwLyfmn+dK9bWT9uX9NY7759/xAvzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJssZbMcXdPcUtml+KAZyXcFmVvboOqxCRxKZKa4/mxcmm5A+3rYu0SdEv2JLzBiRFTj4/aNVGriNEp7qfThE62YI1aNxHNnNotjcq+13LD56fd2xtjrZ3Bb8rZkSCEOvHYbo01PlZqXmZE2ujUfuX6hVMVZLqmV45TuJcYYrPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Kn3T6NJz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513c8b72b24so898160e87.3
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1710345813; x=1710950613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4h5PMnDNstnMGS87jv4daJUofxu2OftqstA2Q7fWwBQ=;
        b=Kn3T6NJz8bx6C44iXydwAig5PPhfLHVaXy2SbVYXW9NUQyHVvTEQM2fnQ0ehJQ2DfO
         Dh62K+L7mvuQJJ1TKWomdM5MQMdH4jQe0k5sdf2AxCLSlHMis5LrWkXzh46fHN87dwkS
         IN6D35xWZcEIR+trvLk/+p8wjXZRWDQWYUiygzz4giVRIG4xVTxmGe1bn45yhS+J7dQe
         GYtQKa+CZtqhhT6ihzjd7dlYGo+F1QUrFbpPWMqiBeePATFQwwVl9r+iPPVca7wFJeMl
         FrT6wQZM00Xnz8k9DKL+HDH+Yz/SqvZi0iIXWE8zylVtffg70UAL1bA4DCUSNggRERHE
         8ZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710345813; x=1710950613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4h5PMnDNstnMGS87jv4daJUofxu2OftqstA2Q7fWwBQ=;
        b=vJGH+GbgiaDP46MvYCEn4nyPs3Az1cx++oxJ2ywP1ysZmz2e5htCCD1LKGml/RRmSi
         S2NdItNYtOXoUYQexBud2ptp+7CiwNqnQEpf+p8Ebrzlq4jjSu/j9ZxJSwV5rSoy6GQl
         G5BVF1pxLQ2iQ2QFT4rJHVhSs8rGxJFz/Re3ZXtLBcc3WZW0UWzJpPjF0921VNA7diZ9
         9JsNNAlmP7sSjWzgO4ECSvGuGcjb31sorrpSIbopBT3Ai2Dg8uO7jBy8zRyMNbvyvkKK
         JU7dqKQ7xa5MqBJ/wGrBIt1qA9NETwETU6LEMbHSHkfatHsost45bEK5CYYsqY/lBQrD
         xbfQ==
X-Gm-Message-State: AOJu0Yy3MheCUE/uMI63aIjmpPKqSJljTMghKGF+Szlxt9lkQRNEDHBU
	Ki5hePhf+VzVO7fc99N5ed9pILg7l6K2BouOwF+xTKmDbeZKc+2pQKzzhuyYeUrZwdbTpK0cl3O
	0
X-Google-Smtp-Source: AGHT+IG5Bdf99ZtfwIn7548nayyLGpOW3y/eBEp+jQp5SKeomYKWcz5X3rrzghmrarR7lBaFyMpAwA==
X-Received: by 2002:a05:6512:3442:b0:513:60f5:b488 with SMTP id j2-20020a056512344200b0051360f5b488mr3625736lfr.24.1710345813168;
        Wed, 13 Mar 2024 09:03:33 -0700 (PDT)
Received: from [192.168.0.106] (176.111.179.225.kyiv.volia.net. [176.111.179.225])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b00413eb5aa694sm1903586wms.38.2024.03.13.09.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 09:03:32 -0700 (PDT)
Message-ID: <5f483469-fba4-4f43-a51a-66c267126709@blackwall.org>
Date: Wed, 13 Mar 2024 18:03:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VLAN aware bridge multicast and quierer problems
To: Andrew Lunn <andrew@lunn.ch>, Ido Schimmel <idosch@nvidia.com>
Cc: netdev <netdev@vger.kernel.org>
References: <123ce9de-7ca1-4380-891b-cdbab4c4a10b@lunn.ch>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <123ce9de-7ca1-4380-891b-cdbab4c4a10b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 17:40, Andrew Lunn wrote:
> Hi Nikolay, Ido
> 
> I have a colleague who is using a VLAN aware bridge with
> multicast. IGMP snooping is causing problems in this setup. The setup
> periodically sends IPv6 router solicitations towards the router and
> expects router advertisements back. After a while, the router
> solicitations were no longer forwarded/flooded by the bridge.
> 
> The bridge doesn't drop the RS frames, but instead of forwarding them
> using br_flood(), it calls br_mulricast_flood() with an empty
> destination list. MC snooping is on by default and is VLAN-aware by
> default, so it should work in this context. If he disable it for
> testing purposes, the RS get forwarded.
> 
> We then checked how the destination list gets computed. Not very
> surprisingly, this is based on MC group membership reports in
> combination with MC querier tracking (no querier -> no MC snooping,
> i.e. br_flood() instead of br_multicast_flood()). So far, so good. We
> don't have a querier on the VLAN in question but we do have one on
> another VLAN running over the same bridge. And then he noticed that
> br_multicast_querier_exists() which is called by
> br_handle_frame_finish() to decide whether it can rely on snooped MC
> groups doesn't get any VLAN information, only the global bridge
> multicast context. So it can't possibly know whether there's a querier
> on the VLAN the frame to be forwarded is on. As soon as there's a
> querier on one VLAN, the code seems to assume that there are queriers
> on all of them. And on those without an actual querier, this means
> that destination lists are empty because there are no membership
> reports on these VLANs (at least not after the initial reports right
> after joining a group).
> 
> It seems odd that you spent a lot of time adding code to track group
> memberships by VLAN but then left our the last tiny bit to also track
> queriers by VLAN? So we are wondering if we are missing something,
> some configuration somewhere?
> 
> We have a test script which sets up a bridge in a network name space,
> and uses scapy and tcpdump to show the problem. I can send it to you
> if you are interested.
> 
> Thanks
> 	Andrew

Hi Andrew,
Please check again, br_multicast_rcv() which is called before
br_multicast_querier_exists() should set brmctx and pmctx to
the proper vlan contexts. If vlan igmp snooping is enabled then
the call to br_multicast_querier_exists() is done with the vlan's
contexts. I'd guess per-vlan igmp snooping is not enabled (it is not
enabled by default).

Cheers,
  Nik


