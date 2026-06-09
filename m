Return-Path: <netdev+bounces-297016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P3AvNa70J2og6QIAu9opvQ
	(envelope-from <netdev+bounces-297016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:10:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E03765F553
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:10:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=aU55KofC;
	dkim=pass header.d=redhat.com header.s=google header.b=Y37BYBNG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297016-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297016-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7EDE31C81D5
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A00B3FC5AC;
	Tue,  9 Jun 2026 10:58:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102603FA5FD
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 10:58:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002691; cv=none; b=Tu0e0irx5PqfxnM8Ls91krmeV8LKbuHvvHoskhvon+D7/WpWTbPcqcDOeIbUsLmvSWS7Dy1hnTDjiOMuFPROed+amy26WDXC6Od9keCA5Aky/eLMGRXMqyf6q90piEZgAuSdOTY9cHmArLOa3cTbi2UTgpQ6LZLqXJT9Ct9rTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002691; c=relaxed/simple;
	bh=JveCsx9Hslr13u/DSY0be/52qVCMiadnjjogqq+Li1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l417U4FRpxpJtUTBdyM9yqKGNazp0fh0+ABpbBaCuQ1DpAWOcpM2C0Ai29kJrHr3CivC8AegkUYCdJzVM6g3XYBNT76vQ8SPiyF9FkTzHWAK8Yu8+lGWjJ5dBcLx37cg3HcTLOIEMVxUHXZMda69oQDEpqqR65FUH6MUYY9TAKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aU55KofC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y37BYBNG; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781002689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJCMh9QJ8mzt02qiZIC/NXMj7sB/BVWq0X5RNKCrb0M=;
	b=aU55KofCFQf/HnRjUXzNLGWK28r6ynbCqs0nMeVq4OJddrT/EdcI0BpUCD4kXE243AcN2i
	IbhPtoTn/h/Wre2vX6IsfpzwBpqsj9FcXkGuN3fCVvcV4cTrL2U2SN6UxX1w9W7AlJO3Qn
	OttGSL+SIcSJ4C9BvSVy9zZ2m3BkL9E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-1LuexCAaPzK8bOYa6CgEJw-1; Tue, 09 Jun 2026 06:58:07 -0400
X-MC-Unique: 1LuexCAaPzK8bOYa6CgEJw-1
X-Mimecast-MFC-AGG-ID: 1LuexCAaPzK8bOYa6CgEJw_1781002687
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b79e6b94so39006855e9.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 03:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781002686; x=1781607486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJCMh9QJ8mzt02qiZIC/NXMj7sB/BVWq0X5RNKCrb0M=;
        b=Y37BYBNGPwbSiyc7JXQ8gdYU9lFaLeC3essTMnVF4+pXhNtpqcJwiv1HDXOLR+s8q2
         SvQfapt3g17/NVkgJAVTIXgTmThEfNyBE1H6/af9z6Xteo5+ozlnmOKPCs1p3CIUW/Uk
         axcQl4sWVdbDNlHc0tCoC/A/G4TypF228Wu43zJeDfYsuRQPbPoWp4Z0CTOX6K+T6gkE
         YRp4wNBGxuJ6AmDUA8C1VLKpI+yhAEWeam0Z/6C87YmOmLldW+y8wG+zSk0bw6d2gsrF
         BDlPT0HxUAUc7pycKk6DdYsP3lARw3zKzA4wDloM6Dtq7PW591d+vcCrMO7Yz5D6aY/7
         7sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002686; x=1781607486;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJCMh9QJ8mzt02qiZIC/NXMj7sB/BVWq0X5RNKCrb0M=;
        b=G6ZNlyxGg4DBiNbDoBsxFQVHs4AxJA4NyPIYfezseSozphA5XFzshsQK0pOkCc2kAM
         z1NfKHmSxxgStvmdLjt0p5sBvufZvOJH7j+7b7o2ETGnc20fZ3ZsdM7QFJ5UUYH4uDXc
         VgUnPdlVPry6c39lvpzodEtK7qUCql+BJwm+nMMRPViEoYACvCd2Y2BiN+7swlAzRooX
         vOvPsOx+W4T3W54r6zVnY2ThghQaOupJ3DO3axG9v8hnL2siOd6loyAmlDX7JtAKY72I
         yXhWIS6wjFp+poRwhJp1DiwVuqRxordaudVBxwa1K+xbsntlsTZ818i4+17Zv8EWe/iI
         Yx+w==
X-Forwarded-Encrypted: i=1; AFNElJ8YZX95YQGi3xssS22LFcUTvJN0PGSo+rtbDUN6QU6d3JVm0Dsj5BZezYHkd9SUSSqlavWxogM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9qhVB8ZMu4rwCV7Wgkp6XkUGjhgRVWu6/Ugo4KPsCOUCZDgal
	+oVzjBEKox0Uo3CxcvF9/bDy1TiMe9Sb+khv1+ymlLu2mQ0le0XP/p2WhVTQ124VS2T3dbObnDK
	cBLV8BRqJ4hI8PwNjnTklaZKtttXvwLbdOQtMVFW2I7wJyHC1i2u/4HmFSA==
X-Gm-Gg: Acq92OFSg77kmx7FoQkKIq8eJoyQFbxuxcx2zQ7GVCHpItl7+5uf2bLIGbZBTix3Y0+
	7o9tJjcVSpTtsL9gKbqKxHCoASji2uKwQxFLXv0ZKROmtnD+rwl8YMt2QRIEKn+8+EliTnVmnWa
	knVLUReE97TEOsASd6RUoT1ViCT94wPwI6iTsKAOX36z2pAse6YtIowAG0ssCrl6ukxO0+JGsFc
	SNSIpJ3HUdhG0iGaq+p2vbafaB46QuYBrsehcUsDztdyUljCfNEJnLr1NJcxczrFmq9kg41d4gP
	8qt3ozj8qUGo2BfiNtWIaR0RN3mzl45a1skke/Se2XJywybsZotD/ZXjSCWFll/KekUNsE5uUze
	2U7NLS6z3k+1D+h4xCPUtygjTL6ivHV3hcvljndKU9Ycq41seZkgxQ5Q8+QVvvDeZLw==
X-Received: by 2002:a05:600c:a51:b0:490:b189:212d with SMTP id 5b1f17b1804b1-490d724314cmr25872665e9.33.1781002686467;
        Tue, 09 Jun 2026 03:58:06 -0700 (PDT)
X-Received: by 2002:a05:600c:a51:b0:490:b189:212d with SMTP id 5b1f17b1804b1-490d724314cmr25872295e9.33.1781002686079;
        Tue, 09 Jun 2026 03:58:06 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm477699555e9.6.2026.06.09.03.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 03:58:05 -0700 (PDT)
Message-ID: <f4643f4f-8db9-4621-bc53-34992820ce19@redhat.com>
Date: Tue, 9 Jun 2026 12:58:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] selftests/net/openvswitch: guard command
 substitutions against empty output
To: Minxi Hou <houminxi@gmail.com>, netdev@vger.kernel.org
Cc: aconole@redhat.com, davem@davemloft.net, echaudro@redhat.com,
 edumazet@google.com, horms@kernel.org, i.maximets@ovn.org, kuba@kernel.org,
 shuah@kernel.org, dev@openvswitch.org, linux-kselftest@vger.kernel.org
References: <20260604163016.3929371-1-houminxi@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260604163016.3929371-1-houminxi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297016-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:aconole@redhat.com,m:davem@davemloft.net,m:echaudro@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:i.maximets@ovn.org,m:kuba@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E03765F553

On 6/4/26 6:30 PM, Minxi Hou wrote:
> When ip-link output is unavailable, when the upcall daemon log has not
> been written yet, or when pahole does not know the OVS drop subsystem
> ID, the affected command substitutions silently produce empty strings.
> The caller then passes empty sha= or pid= arguments to ovs_add_flow,
> or matches against wrong drop reason codes, all without a diagnostic.
> 
> Add [ -z ] guards immediately after each assignment. For test_arp_ping,
> also align the MAC extraction to use awk '/link\/ether/' as in
> test_pop_vlan. The drop_reason guard returns ksft_skip because an
> absent subsystem ID is an environment issue, not a test failure.
> 
> Signed-off-by: Minxi Hou <houminxi@gmail.com>

Whoops, I unintentionally replied to an old revision; same point, I
think this is net-next material.

@ovs crew: WDYT?

/P


