Return-Path: <netdev+bounces-252314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP3aFHoZcmnrbwAAu9opvQ
	(envelope-from <netdev+bounces-252314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:35:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C6766B39
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDAD372C09E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1EF449EA8;
	Thu, 22 Jan 2026 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3YJwLdg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNiGR02K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB743E9D3
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082694; cv=none; b=hTEEdiKCbf3nYzttHaoRFuoLW/dk/E6DJfVCu24clLp3NORTX/OgH4JOndTE6MAl2FziA49hP7AsJLRihsKRJn+XN0ui98/CGs9a0fCiHWTPrD4r67y6ehlAdaUpcqH+qjYpsN5aggvZxWhN62SRcyCW5662gnuT9hZc7+luJZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082694; c=relaxed/simple;
	bh=7KL1VMVD3OFpbZXu6ToVT7ahy8hRxRMUgANKnvOVq7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoR3EqEMUooGESSiXAoluKrZ3WULmcA+h9fmMEosBcG7kWOvFTCjbvhbLrHq61kvPOLl/lvFRosybrFu/XyvLXth47UwSNAgmmLXb3vx04Mt9oUyLEER1DZYN8TT3jy2Xh8jkGlIKQezkK9F5Aq/jf2OKBxPSP1drX4sGvEmvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3YJwLdg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CNiGR02K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769082691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JTm3xpnzgFJS91sLL+soLriB/Qr5GTFc7WAwtsXhWA=;
	b=B3YJwLdgWu0sH03BtW89nqfch15u7M8VedXgRiUuPaAvYkI4ZafaU1nNt6+V9NTAAioUNK
	2t1Pb3AyLvKARQMIWO3p680LXbsWrL9vVP54l3o82eOZHbRzGiCMUx/95JWW2vul6GbSMa
	641uuwQr4Ha8+ls9659P2pO/vqAABNg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-Y7PErNkiOGmcJz3F1I8U_w-1; Thu, 22 Jan 2026 06:51:30 -0500
X-MC-Unique: Y7PErNkiOGmcJz3F1I8U_w-1
X-Mimecast-MFC-AGG-ID: Y7PErNkiOGmcJz3F1I8U_w_1769082689
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4359d70faa2so593264f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769082689; x=1769687489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JTm3xpnzgFJS91sLL+soLriB/Qr5GTFc7WAwtsXhWA=;
        b=CNiGR02KxtXnSh+DoOi8sZI2ctNVylVd5kk1li9xKA7iSsGlfQdMlVYh47mwqeT9pl
         FsXzkcUhBZXNOpGyktU1AI8WbApeeUJ/P3qGrPO+RIa7aisOI/5StRW2dh7tTGWXMPCJ
         mgOyNok8d3kIAyMWP61S8jBYNvjhNr9mJD7Keei1rOE40Y7AaSQkiJHNzPL87y7fTtiI
         oMyRn3uy3lJcnhDxSUKc9CnPPKF4bDdV7n7p9L5xo0TuNIw/DhGzcGLcgtlQ8gf3p5Uq
         4xydtgay+CGyewTqQlgpb6kgHuSNbG4Ry1mJyYy3TdQSver0OP5cKHpH0Qirkwhpi7PL
         bw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769082689; x=1769687489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JTm3xpnzgFJS91sLL+soLriB/Qr5GTFc7WAwtsXhWA=;
        b=jur7XscY0WxKbtHwXeHi3fL2DKpOXSCM+JyrQj8G4I6vABd4fjWdW+KRArHAspoofQ
         0KAkQgCJ+o6Ro+0Yk/Qxuo8r/Tl1af7igdGf/31srCS4xLyyVlcRRsvdreqbwvbfmldF
         TdhyC2VNo+zsIM9jYuxwZTkz4J5N26WxjnSiXg7oNqSmkhR53CqvO0L9EldCSmmLoorK
         RvO1hDyEm7t/m1GpgrOzu3VCJUVCxQUtm/FKfK4uyXCmx8VyDg5vryN/v8TkgJmVE3K2
         ibawxK4Qk5i5steXDxvjibZhZxKAY1sJhx+shTLbbgoG3n529uEGHlfhvfdqwQMr0AsD
         ivtA==
X-Forwarded-Encrypted: i=1; AJvYcCWkObT3Rlx6+kcNvJ2W+/j+SuPoUwdZ4N/olivNVc/UyDXa4nxCZuuz9Wl7O3ET/yc/h1QT2kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvieUywPZZ8ev9Ul4zL7Xkzp/dzFHM9FCBYTIbj64Yh1CK9Xer
	UDeBbjk4Jx1GYTZEyXInbs7v5L0fOsqH0guSrCg5swA+1scK//PqYv+8hG0UvDJFkn0nigIimH3
	z/zT4dCBxd/Zn1am6ng518009erxiZUaVfS5jegb1JCG6pQUBPH0DarrucQ==
X-Gm-Gg: AZuq6aL5I6QhKWInRfpD3cRLER69arpkh8LBwRBnk4831GGXnP9sG8oq9h+G/axTFjF
	oixAC3mdjuT0cS+rATKrnDR8UR89mINzwq35HthswD+turKfYa7tVyT6qd1uXH4kBaSZWhU4k34
	8rTA5l+yTFfgGFFNWImrWv+nO2w6xoDS7pSnFQHx4ozoIBscJbtwqYW+I7OJYLe3SfzRpMDltJw
	uKJMQYS4z5uGgPePFAGdzZWcx+umhQoHV2PxKE6SVN4mvBnyMFE4mQdd6c/FMZ2BV8LnBJJzU+0
	cvI2WFmznpzW8Ejg8+ef3l5cj4P4g3vVK3d/DGqXTt1NOys1J0abBW+pQR5+YVxWmF0z0wkLTqA
	b/P07jW5Zvn6m
X-Received: by 2002:a5d:5d83:0:b0:425:769e:515a with SMTP id ffacd0b85a97d-4356a05c0bcmr32153856f8f.42.1769082689340;
        Thu, 22 Jan 2026 03:51:29 -0800 (PST)
X-Received: by 2002:a5d:5d83:0:b0:425:769e:515a with SMTP id ffacd0b85a97d-4356a05c0bcmr32153818f8f.42.1769082688972;
        Thu, 22 Jan 2026 03:51:28 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358f12ee69sm21693720f8f.11.2026.01.22.03.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 03:51:28 -0800 (PST)
Message-ID: <d9170bdd-140f-4d36-954d-76223e31b209@redhat.com>
Date: Thu, 22 Jan 2026 12:51:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: spacemit: Clarify stat timeout comments and
 messages
To: Vivian Wang <wangruikang@iscas.ac.cn>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Yixun Lan <dlan@gentoo.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260121-k1-ethernet-clarify-stat-timeout-v2-1-76ff1a1168d9@iscas.ac.cn>
 <20260121200439.64c22125@kernel.org>
 <5639ff0c-dfd1-4528-a0ce-92d3c457ce64@iscas.ac.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5639ff0c-dfd1-4528-a0ce-92d3c457ce64@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	TAGGED_FROM(0.00)[bounces-252314-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: B8C6766B39
X-Rspamd-Action: no action

On 1/22/26 11:39 AM, Vivian Wang wrote:
> On 1/22/26 12:04, Jakub Kicinski wrote:
>> On Wed, 21 Jan 2026 10:17:18 +0800 Vivian Wang wrote:
>>> This patch isn't a fix for the problem per se, since it is hardware
>>> behavior. The new message and comments, however, should direct those
>>> running into this on new hardware towards a fix.
>> Is it not possible to improve the situation?
> 
> Maybe I should have made it clearer, but this comment and messages
> improvement was proposed by Andrew in the linked thread [1].
> 
> As an aside, saying that made me realize this patch should be:
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> 
>> Is the refclock disappearing because of power saving?
>> Or because the link is down?
> 
> I'm not really well-versed in what's allowed from the PHY here, but at
> least the Motorcomm and Realtek PHYs seem to only stop this clock while
> the link is down. So from what I can tell it's PHY stopping the clock
> because of power saving for when the link is down. I'm not sure how that
> should translate into an answer to your question here...
> 
>> Because if it's the latter we should be able to skip reading the stats
>> when link is down (still racy but better than waiting in cases we can
>> detect?)
> 
> If checking the link is definitely up as a condition for updating stats
> would be acceptable, then maybe the original patch from the linked
> thread [2] can also be adopted?

My understanding is that such option would fit Jakub's suggestion. Note
that the commit message should be expanded and clarified WRT the
original submission.

/P


