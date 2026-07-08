Return-Path: <netdev+bounces-305773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w91jABszTmoUGgIAu9opvQ
	(envelope-from <netdev+bounces-305773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:23:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1713724DEA
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:23:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=JU9IJmE3;
	dkim=pass header.d=redhat.com header.s=google header.b=fg87rMwW;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305773-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305773-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8983304CF3B
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1174F434E33;
	Wed,  8 Jul 2026 11:15:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776D9433BC2
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 11:15:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509317; cv=none; b=tkNHbNsV393lrcwgl4RQgRZvejV41ZmBGImzHnJrK3dvKvMF58pM1UXQox+zUgb0zHRx1tdkGQMHSa2g+lxPomCCr7+26aiiKrOGWXsf/oojAiK36rnFSl/DXWQGsuzIAeat858knCxMRIrTuOD9HZL5BRLZ79D1HAWHk2PY9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509317; c=relaxed/simple;
	bh=+L61LaO/tSTgwUG3yNGocYARlCgeLxPVR53vlY4PE90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiS8vh+T5wZo0mQZHEe7e41px2/L4TlWbZJd3syUfHZ1isIA1NjbeM0wYifVMCVkZGKgp93ZScNEg+79NrQOCHo8yWsCsEV89gWaCgWZ/Z6P7gkxoDZ2vgV4a1DdUTIRq8/pdzDl44E+0MT44LURka+7L1czP88piv5597IBjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JU9IJmE3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fg87rMwW; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783509314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAAfDroIq6UXGR519c5uoiGAKX45EOugo6OCZQqCTl4=;
	b=JU9IJmE3zfnZCQy2GrVrJKhag3An7hFkdQWkPV/a1+EqRf4aHeun2wqJc2iDVLzNOdbyHh
	OziO2914rOG/KKD3T97FF/s7cmmyEOfXv08f0w63P3KY6oA7cI1ZdkC4fDybeJgJX4xNAI
	Zivqoat7RXpMbsa/nFTTlUG6SP268PU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-z_Wn_xUnNMWu_7WvtQbGYw-1; Wed, 08 Jul 2026 07:15:13 -0400
X-MC-Unique: z_Wn_xUnNMWu_7WvtQbGYw-1
X-Mimecast-MFC-AGG-ID: z_Wn_xUnNMWu_7WvtQbGYw_1783509312
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47d81cf0c4cso497448f8f.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783509312; x=1784114112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HAAfDroIq6UXGR519c5uoiGAKX45EOugo6OCZQqCTl4=;
        b=fg87rMwWUPqGWgLbsOCKfm3r+5hRK7oydya3fQT7CmssLbDie8TG8Z4UVXFlOZDtO4
         lG4WIz6bKGRWsi82UlIhjXoFY9k73z/sX4rp2IIbzPIm/swwXVEjqw92gQLHHojX0V9T
         Bhx7Sla1SdBIxaZcywQI+QV+14O36AeJ7qrGFla7p9a7oKU+IA7m+4f9h60ivxnuDvHy
         9iuKMuuTmdeLDJq4/XaV2dE6d0Zwi8lcOxkD5EYAs+OgGUaczki+39EJxQYoGxhK4B6s
         HtANEbFEhVBIOQ6zlANa4INjDDL8wIMkuZpRAw7K7mZ2nrpKXd9NcTDC3d+31DhCjM2t
         2X8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783509312; x=1784114112;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HAAfDroIq6UXGR519c5uoiGAKX45EOugo6OCZQqCTl4=;
        b=DAWVf6HFsk/J0IOyMVhSzVJHcty0uXnyyyGrHY/SsbGRrK6pLIRPMQaDsGLpe6fdaw
         GntmgpYkwUsbT2dMOG0fTK6JG7xHBjDLbh4WG2w3ormJ5vC5OZB5d3MY6n1jfZVlFZ1f
         2X8i3Y3an3F1SBBzQ6WBHvP+h/PipYPS5s/dU3B2RI8XlH5Au5V2+vv/EIvIJ84QcuUc
         0VHwBmo2nXiT6vm9Wc1h8E6b0mfNQGv6xLn300yzmE7UlpDB/aNJNulX9MiQVF9wKyIW
         fzKHTeTX6RWUpm+Wm8QzD6zJPd/AIzKDdmgAzt85kPubNzaApwEJkSQx/RDPbFV6h9xA
         bwzQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEoMKypEBrBDy9UqKnyHMzAYylq9ZpeLtf1jePzaEmE9j8Qasyoz/S20SR5ZHbUBkxgTiX/5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyONUgnoSsEI2yWqXb+Heq2VPXcpPxJgQ1snu64ntIeYeAF0Jz3
	Cx+tMqGBJ5A7mJIdU0PzAe9w8SFiTZpHILCDL2AjoyUU4NeQ42SqCWsVjH/BRIQ1oHWufWAkUQx
	xsk7p3zlOxipYXVz3MqM7HlycfqKqk7jO5GCkOLIiJ8b5YR66CYxsRl1gEw==
X-Gm-Gg: AfdE7cntIbHQdR3CcT/UzUQjeDemINwrX/9rvh+Sj9SPbkhPHoTkm0yIH61TMFj6HLV
	887fe0PpQcwNSCzM3nVvv8a3tHVH1aEP3rzuxsWueN1ZZqZI/bClaiw5sj/fK0FmT4ZIhXV2D2f
	jVrMzkmrUtGcEYajiliDfcAPosYNb9Ea2PXAePmabVnu7SoXhVhk3PGkvRmVjprus5NNAbTPHxi
	PpPX/hI5PhPUxP7dCqm7n6uDxMmDaZWO0YfIkfZOUiydAM8KCKOGDnViZDoO7xKDqji21WA+lAN
	8kOVAAgTuPup/umm2yJKoOvAqvGgBWfyWQwqj5KLS3sYJwgxe4hORgMvcjl4DwNf8Fibd2bcKk5
	aV5z3PygYMX0pzxzdkoEzHFAwRgpf1KWtuSKHtBqUwB3rEv8BQ9wTfy3vWgm2eJ0LutyTpt4oZf
	2mwgkZbWl9lNHa
X-Received: by 2002:a05:600c:8b62:b0:493:adcb:d368 with SMTP id 5b1f17b1804b1-493e6843f10mr22365205e9.9.1783509312043;
        Wed, 08 Jul 2026 04:15:12 -0700 (PDT)
X-Received: by 2002:a05:600c:8b62:b0:493:adcb:d368 with SMTP id 5b1f17b1804b1-493e6843f10mr22364805e9.9.1783509311582;
        Wed, 08 Jul 2026 04:15:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm43419310f8f.2.2026.07.08.04.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 04:15:11 -0700 (PDT)
Message-ID: <e85432be-d9a3-4b70-b324-dc657617d1d3@redhat.com>
Date: Wed, 8 Jul 2026 13:15:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] selftests/net/openvswitch: add ICMPv6 echo
 type match test
To: Minxi Hou <houminxi@gmail.com>, netdev@vger.kernel.org
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 shuah@kernel.org, dev@openvswitch.org, linux-kselftest@vger.kernel.org
References: <20260702075044.1176798-1-houminxi@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702075044.1176798-1-houminxi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305773-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1713724DEA

On 7/2/26 9:50 AM, Minxi Hou wrote:
> Register OVS_KEY_ATTR_ICMPV6 in the flow key parser so that
> icmpv6(type=...) can be used in flow specifications. Without this
> registration the parser silently drops the token and the kernel
> rejects the flow with EINVAL because the expected ICMPv6 key
> attribute is missing.
> 
> While here, add convert_int() to the ovs_key_ipv6 and ovs_key_icmp
> fields_map entries so that specifying a field value produces the
> correct wildcard mask. The IPv6 flow label uses convert_int(20) to
> produce a 20-bit mask (0x000FFFFF), matching the kernel constraint in
> flow_netlink.c that rejects masks with bits 20-31 set; byte-wide
> fields use convert_int(8). The ipv4 counterpart already does this via
> convert_int(); the ipv6 and icmp classes were simply missing the fifth
> tuple element. Existing callers that pass empty parentheses are
> unaffected because convert_int("") returns (0, 0).
> 
> Add test_icmpv6 exercising the ICMPv6 echo flow key. The test uses
> static neighbour entries with nud permanent to prevent racy NDP, then
> verifies in three steps: install icmpv6(type=128) and
> icmpv6(type=129) flows and confirm ping works, remove the flows and
> confirm ping fails, reinstall and confirm recovery.
> 
> Signed-off-by: Minxi Hou <houminxi@gmail.com>

Does not apply cleanly anymore. Please rebase and resend. Note that you
can retain Aaron's ack.

/P


