Return-Path: <netdev+bounces-305797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fpDfDZVFTmrqJwIAu9opvQ
	(envelope-from <netdev+bounces-305797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:41:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD847726631
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:41:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GoJwEpxN;
	dkim=pass header.d=redhat.com header.s=google header.b=VfhnJkK0;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305797-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305797-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 563333006832
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD16B44BCAA;
	Wed,  8 Jul 2026 12:41:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BD43E492
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:41:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514513; cv=none; b=ijXIrpuAeJJ321pXyhyMTO2qIGcevkS2IUC3WGiuv3BfnC/ps0mfJ8ZFVRxo4/IHh4JNgwNGx1hzY5PVkkl0wRtrT8FV7pTklV6mlI3+5fBgeQv/eGB6XKaNTLxwZzKu3pe6YsMPkfx8CvHH9AX+GCVkAEFzM/Yp8Cz6ivVEol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514513; c=relaxed/simple;
	bh=fLGIbp0DdhHYMwO1Pwij8MPQvxJEvMFfRLjQi7F+LQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPkaugEQYtpcV6HOBdV4Rn03Pxe+HxKxkurZ1fzH/zGIKJL7IQh3JHJP0NPA2ql8bTFFjgdXMOAkQd2vsYlVXe3QrCzhemvo/gaDMW2+uvSqQF9Yw0U8eXWBjiTP9pIkCx0eY1lnXuCpLz9/MX6yxsk3Xh3cF2OWQnri0CSEp4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GoJwEpxN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VfhnJkK0; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783514511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75a/pzd73d+PAwDpvAfCU4c1tY/Dc8IIgnB5rkhKiQI=;
	b=GoJwEpxNgXjZLHk3JT9moulcckmfMDGECGVpdYEcqUEnjAnnp+H+VemTUn1REKKYNBNFob
	0kRlB62TV9Uy3aTSNCzJ1b7x8c3UavCAvyq4oa6znRh9ZYIVryK2zdyxcXb2tOoVc3+/+g
	IlyBk91or0D6XqFgWItUVCElVAryesU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-JwBVdpwSNjuv8WSRMIr7Xg-1; Wed, 08 Jul 2026 08:41:50 -0400
X-MC-Unique: JwBVdpwSNjuv8WSRMIr7Xg-1
X-Mimecast-MFC-AGG-ID: JwBVdpwSNjuv8WSRMIr7Xg_1783514509
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4784d0fb9cfso582474f8f.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 05:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783514509; x=1784119309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75a/pzd73d+PAwDpvAfCU4c1tY/Dc8IIgnB5rkhKiQI=;
        b=VfhnJkK0bLAUeX2//sh9UauWadJnhIrE3ibOaOKHwmwjCMiku+GScCZBzNbeO0hZ5g
         WWMxk1bvb/1WVHlpYiYlOyVGhjWwY92UvUp+u7/EEYw7FwPbrAa1GXbKTV69mOTctEqD
         En+rurTr3yHMN8hYYepcXp/wloAFECXDuQgRtjlNjijWmOnum4I/KFb3kSReDdK5ncWu
         03PKlHCgINi+GBIKrKtqTxiXOD9z7pQ6F1lF2GYi9RQjUtDoQ9wPt85rfJvz5X38pCQ2
         qYKSMeQA+iwIUa9PjqopHOuJxXzmKqiEL42rJ1VGJYFR1rmexOPHkXVCT6VmHWgas8O5
         t92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783514509; x=1784119309;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=75a/pzd73d+PAwDpvAfCU4c1tY/Dc8IIgnB5rkhKiQI=;
        b=kct40fpbcr5HwBPW1tgNCuoKaDutqYF3VLzb54d5rbrPnMD8u7vnktqrakomCZAIi9
         OptBr9Tc304F3PpuwlIGqezjoVI89BNt4fslx82pT+3AqawR2kNI/jX8yEVkxK6wRIvJ
         LRVt3syHMxpPbs9GlNWTXkve4Zev9uRGojQSJ4oJ2DIRxk2T+00o5lCPo0ZwEPWDAwwZ
         r0bH8+kiv8lCeHH5yGzTyfKR2MyFIC9E2sWAgKzE6b8j2bpkq3GrLaQtyRjC64L51e1P
         QyE6hGdBb1scv3EWXRMG1Lu/osomMHOMn8tYHFoP7vaOi+oTrCjAyDLlqzIycrUSy/32
         aLSA==
X-Forwarded-Encrypted: i=1; AHgh+Rpofccehs8eQe6yGfcsuShZY7g+qf0fQhn8p/r8m0DsKey5l4saRFr1g+oA787D9JUTdMMvtuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylCYKOG990ciHwrduVdNT/OkDL2xSBm0WBuM1znZIRBIQrrp8j
	t45CYyzlqwKRJYz7WoXZkCEwwPc7H4GMcdGY2gPOfdIVmKcoKB6HweY+iMzt10e3s1wawsrCEhQ
	mNcKc8d5FoO9WuuT9J68vG0H+JwXURynF4xopZyRUg62u+AjNAEhEnQARXg==
X-Gm-Gg: AfdE7cmtYQCQ+97o1sGRMXLlmXUeraKTU3xCZIbDIKU37VOpz7i96ccqRYntHRdCsce
	CGCnVTS9MvWmAfK28/AxUg+mE7bZKuvxE5+mpbhB516m3KRYHnY6PJM5xPl6XtvvJv5c4DRQsBf
	81UuAe47sf8X/4jOgokFTCy1bWJuD5ewaN7De/XYBRHzqxbln8lrz+dex82JuRkNhWPTKsMNDrS
	KvscSaMHNVO7LLjoQF+zfiGfTB36TTx6RfEyA/7lQnysGuyKZJzIUdO45Ww6bxI2MOpilgxeq7E
	Ffml4PgA/ghWn3aRVAWdWnCs9fO6m3bC2gP2XmrRTZ1AsePhyP9GmB/jYb+A2JpDmhWh5TvUv4w
	X2/OKT4CBLZjn7se/Y/HGShPb4MCC6uj8qA/xKu+fdBiK6ZXwZegpuWo5KoVKMdZIHSEV1SHPdr
	eJsJp/8rg1dgsM
X-Received: by 2002:a05:6000:2f81:b0:475:f0f0:9ed0 with SMTP id ffacd0b85a97d-47df081bb63mr2547979f8f.59.1783514509134;
        Wed, 08 Jul 2026 05:41:49 -0700 (PDT)
X-Received: by 2002:a05:6000:2f81:b0:475:f0f0:9ed0 with SMTP id ffacd0b85a97d-47df081bb63mr2547947f8f.59.1783514508697;
        Wed, 08 Jul 2026 05:41:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae4fsm43724827f8f.18.2026.07.08.05.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 05:41:48 -0700 (PDT)
Message-ID: <c9ccb69f-43a4-4462-9dc8-d08aec7ca433@redhat.com>
Date: Wed, 8 Jul 2026 14:41:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/11][pull request] Intel Wired LAN Driver
 Updates 2026-07-01 (igc, igb)
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Cc: horms@kernel.org
References: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305797-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD847726631

On 7/1/26 11:02 PM, Tony Nguyen wrote:
> Kohei Enju adds ethtool support for get/set hash key on igc and adds
> setting of skb hash type based on values from Rx descriptor on igb.
> 
> Takashi Kozu adds ethtool support for get/set hash key on igb.
> 
> Faizal adds support for forcing link speed via ethtool when
> autonegotiation is disabled on the igc driver.
> 
> The following are changes since commit d6e81529749190123aa0040626c7e5dbc20fdc9a:
>   Merge branch 'net-fib_rules-rtnl-less-rtm_newrule-and-rtm_delrule'
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Sashiko gemini has some comments, please follow-up with them as needed:

https://sashiko.dev/#/patchset/20260701210303.1745310-1-anthony.l.nguyen%40intel.com

/P


