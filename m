Return-Path: <netdev+bounces-281796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BNJMnSY8GmrVQEAu9opvQ
	(envelope-from <netdev+bounces-281796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:22:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4534D4839A6
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49DE8308021A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAB03E63A4;
	Tue, 28 Apr 2026 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQvl67Wc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRx/Ju39"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517AD282F23
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374219; cv=none; b=kADRafwzf6ed7YE60IFFifJiGWfRzflyLhmQwQ4ALayOy2QuYkdqZoaz/cWkZnlk3nKhCNnNA+bcuHw959l/aOcwuo4Qm/W3xkwEAy6RTMHQ2kMmAvDBPXeM1N9HCSK64dPDXUWpUM8MoNmUkpa90FpLqhvDqKVmvNU5YJ5EGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374219; c=relaxed/simple;
	bh=KwHoNDnh1M8bGWb++E31QnOTc/4aQhmway/EsW4NFX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M30W9zenfSfZLPl3yUVEMLb1J4hFWXXuOoP2J4FmZLM6iUnyUvaSEBVbb5X71pPKqff2ArjFUx+sWsl6Hktu0zrn4L1jDP62u5dcokVm036gN8kFAs2PA5u/Aovg6Wh4GeuEy5TmdKWzV7eenlQJ5+Kz3gnF60ey5ke1DmnQsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQvl67Wc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRx/Ju39; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aTGB+L3zA78hZ8rQ+s8jp1YOahyLWJe2Z95bv9MWHk=;
	b=aQvl67Wc5K5D4SKUNdlcXsARF+YpS5WBTBDu0rd6SJVQx2jr7qTDcLxhVtZfO3gwPev62K
	KGzlJZS6iVOvWOfTBveDMEx9tZ348E7gNV4HKDO4Jz47nOwFfYVH+sRyuIJcDTGaz2Mwkf
	HtdFyNkJvrKvjHvmxCIUwOCItmWSrEY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-CqpiE4UlOyapjkUarU0uYA-1; Tue, 28 Apr 2026 07:03:36 -0400
X-MC-Unique: CqpiE4UlOyapjkUarU0uYA-1
X-Mimecast-MFC-AGG-ID: CqpiE4UlOyapjkUarU0uYA_1777374215
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8d5d03ae893so1979091885a.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 04:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777374215; x=1777979015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aTGB+L3zA78hZ8rQ+s8jp1YOahyLWJe2Z95bv9MWHk=;
        b=HRx/Ju39vVBUFM7yMb0i+8T6jFN4/AjQHrJzumqNDiU9WsLBSBZE2rnjdxkXmvqRxU
         PPARpvEkYoOA507kv9hiwnNq/PaJrIsEnhUCx1Snd90g+FKDjpFes1G5aipKIOpEL+QQ
         +p3o+rqfaAS+7MaEAlX7T7bq4RXcHl/CW93vwqqqoNvG4HFdRtxZeAC2dNNId1FXVpM5
         VVfSdZWIY06/gAyS86KyrXOccCn2OzaToopdOLO/+Dzi2vvdO9UxG7G0sRl8RhT2vKVG
         G9pkRFrb+PNzMCl9DSSc0Pn3jJqVfBc5FO5P/r9fD1Bbo2RLqGICWapMyfspUY1N3JGp
         6q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777374215; x=1777979015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aTGB+L3zA78hZ8rQ+s8jp1YOahyLWJe2Z95bv9MWHk=;
        b=bAb7UXxYjJP7dViJGjsyhNzBG+6qml/rp721rW9KA7EFnS6IRUg+efo3rzQxjsTAWb
         SysDcDBpmvB8Hiy5tsicEMHim2h2hf+qgGzdcysDDJmS3jJbD2JcsskI2ph6E575vVU7
         BAv1YMy7r0U4BD6d0LKEunwvtZ5zQ8CIRgvG8JLy5mF6XJJl6TRMvjPgNxxMU8hrX547
         UdLlL6xFbvtA/R/XB/oxwB+Eaw9B1DjYIJAHgplhAAsG9Y6xHW+uzufT/oik3yGdGboT
         oVzpqFVzHDxh+rW/AIkZ0NM/JrwzeDO2Qk9c7qGhSv1A3Z5N3NzHnHE2muHSEVNeFuQc
         LuFg==
X-Gm-Message-State: AOJu0YyLMLkHOzbHyghLnId8XDS2EwIjr3qPqJ6UfESlKTTUT73zVXWk
	Ty7X4OPCFzZHc2SsugX/H0MEZIOYTG72eOoLZJ3c2GC5WqHRuFel2YommBzYtV8epiRCYs0/P3b
	EVJ6Eoa4r2zbhsvWacERaa4a/+VSEB/5D19llOZW60RkRtQC6vcwBkDlTwA==
X-Gm-Gg: AeBDiesD9XZ2s9/V3PiyxV34zoghtWeVLFKXPxTq/bl47CuMtqs6p8oDqFqw/SspVMR
	GlDqKw633m1gBEsa4m8H9tJqrN142v3pjPjDbo/FEJ0q//pl8IyIJS4yPdZUcAAmVFUx8Re9MGL
	Q95DGa+hfCj6igExxzTN++5afOdO8Q8HWZ6GF0Xf2iWFuFdUqG6Fe+yRgec7WmDvmr7kN50Xv+m
	8g5inT9as4FG52Eo5KIlyzbWcgWF/jaN8sSw3gXKlcAMl3My7eAbdH8kb8vq2fx+3o0Dro7eOoz
	+SW2vrxUUNKravooLT5AbWvJZMp1DqzemY4u3NgNInOZ45p5bTPpGLRiYgA8KbXmli1sOby4gSA
	eTEI4hyPZd/HP7Rzx13niK+lju8u9DlIvqmrVANGXFerFg5h1M07OiUEBjYHAW+iJPg==
X-Received: by 2002:a05:620a:4708:b0:8ee:21b3:2eba with SMTP id af79cd13be357-8f7d9201baemr337414885a.33.1777374215204;
        Tue, 28 Apr 2026 04:03:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4708:b0:8ee:21b3:2eba with SMTP id af79cd13be357-8f7d9201baemr337402685a.33.1777374214349;
        Tue, 28 Apr 2026 04:03:34 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c84b1f71sm150970285a.39.2026.04.28.04.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 04:03:33 -0700 (PDT)
Message-ID: <73dadef2-4c19-4740-882a-0fcaca6b8bde@redhat.com>
Date: Tue, 28 Apr 2026 13:03:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: mctp i2c: check length before marking flow
 active
To: "William A. Kennington III" <william@wkennington.com>,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wolfram Sang <wsa@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260423001517.79219-1-william@wkennington.com>
 <20260423074741.201460-1-william@wkennington.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260423074741.201460-1-william@wkennington.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4534D4839A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281796-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wkennington.com:email]

On 4/23/26 9:46 AM, William A. Kennington III wrote:
> Currently, mctp_i2c_get_tx_flow_state() is called before the packet length
> sanity check. This function marks a new flow as active in the MCTP core.
> 
> If the sanity check fails, mctp_i2c_xmit() returns early without calling
> mctp_i2c_lock_nest(). This results in a mismatched locking state: the
> flow is active, but the I2C bus lock was never acquired for it.
> 
> When the flow is later released, mctp_i2c_release_flow() will see the
> active state and queue an unlock marker. The TX thread will then
> decrement midev->i2c_lock_count from 0, causing it to underflow to -1.
> 
> This underflow permanently breaks the driver's locking logic, allowing
> future transmissions to occur without holding the I2C bus lock, leading
> to bus collisions and potential hardware hangs.
> 
> Move the mctp_i2c_get_tx_flow_state() call to after the length sanity
> check to ensure we only transition the flow state if we are actually
> going to proceed with the transmission and locking.
> 
> Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
> Signed-off-by: William A. Kennington III <william@wkennington.com>

Note that you should have included Jeremy's ack, and you should have
avoided reposting before the 24h grace period. In this specific case,
you could have avoided a repost entirely

/P


