Return-Path: <netdev+bounces-280039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJclFPw152mg5QEAu9opvQ
	(envelope-from <netdev+bounces-280039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:31:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB90A4382FE
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69854302A68E
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FB7388E7D;
	Tue, 21 Apr 2026 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1LPCfXK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t66K1o37"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227063988E4
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776759967; cv=none; b=qc1RxgsI1fpLGy+F6jS74IaffodTalRpT9rbbKMu0weDrO4fWL008fzni+oGGg6Pg6TnSq3TntYogErZjy7MP66T5dcI+VWZ3iNZb061toiWwGEVg/Y2IQiaYNrm3Ux7I2kZYlB99KO9AXUHGMqPv27PMqNVcJhrbXF1nNSPrAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776759967; c=relaxed/simple;
	bh=5HpIU7XY/6mpsrTiNp5cSkefai76wtUpS6oTNX78r0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdq8ySpL0Ev1DafTQ7ddJ7AGeJ/tCpN8xE2xfudF55L+HpheN9/eJCMl9lcqbu6mUHpkurdzj7+I3F1W1/58PMk8zGUPVJp3eO8be7ZYrSvNnHv5HuJoUaSYT/HlYmJi+hzkEiK3W/BGzBb31kGh0+IpbqrmC2/vKE0g6GIoNvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1LPCfXK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t66K1o37; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776759964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3mKR3txNLa45kitEBn3PIc4bnpmQ+6Ml8tnnpo/n1s=;
	b=K1LPCfXK1GqFb2fDjmg88/EOdmHTMMjm1zA/muM0rCZ0v+Mz1c7QPro9VOcbsRiZ0YncXQ
	x+HsfSoEy056U75b8PmWJc62GLlo8rkUkFbhUwDVvumaG5dbSqUevNB1RGVQUguoiBBiBP
	kecR+NWosH5M5yabDJEN4gzK8/CMt74=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-mMg9s93lM_mSabGYv49UVg-1; Tue, 21 Apr 2026 04:26:03 -0400
X-MC-Unique: mMg9s93lM_mSabGYv49UVg-1
X-Mimecast-MFC-AGG-ID: mMg9s93lM_mSabGYv49UVg_1776759962
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a90510a6d1so32502295ad.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 01:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776759962; x=1777364762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O3mKR3txNLa45kitEBn3PIc4bnpmQ+6Ml8tnnpo/n1s=;
        b=t66K1o37p8SQO6YaiIUTOyj8RPggrMgxQzwfx6JGegPohP0ag9D7kbxS+5nQJiko/R
         noqhLuL81DK5ALrM+6AWamWmwKgPstlRR/ytE1b9KGE/TAOtci7ilEG/eWEHPzHnfTCO
         ROtJ7Y2cA76L9mPN0/7vXNg+TE+FksNiU/jyJKbXEYYggSHdnPPh7xUa0xiOfQdPeHnl
         A845TkHSKXZyhutZWHkpiDZOWmogYTqrx0bmbfNG1cYYbb8ocIHfRA9cjMZAxVHZQqcr
         FvkFesv8TJY5ED5ifW5oE1rT2Zr4FqnU/7LPuCy1N3RNSoVJ+u7Q75bA2UhtMTzSDKJW
         8WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776759962; x=1777364762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3mKR3txNLa45kitEBn3PIc4bnpmQ+6Ml8tnnpo/n1s=;
        b=hSudT4nBKqHQQvPqofUlhctVozTjR1G47qVObturKsmwG/JIgUsow0lgJ1Lk/xOhgp
         UECBshOWFGKa9lI3HvkVxlOd3nt+Uk6n/gl73TlLaPlUqcKW4NGwXrMqJ+zf3azZE5st
         RBlhhpRk9nePicg1AxRwtRpqnQ+8LUxIiEhzDsMBZNUvMNZsOuxE7mJ85sfSTtTsLY0n
         lcjwooao/pt1/LlJKPvcbVHar58At7J6/HrGRBklN75frweCxLOHskJ+wWy4x1VFtfg6
         CTEOdh3F7HbG9lu9gR6sa3qD6mdNjMY+tIdT7NHez04kkGfjn+51i04JDtqKrW1RyCpY
         FkIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+XH9XymMxKHFtJTGh8xRcc0goMXTo61v/WknPY7qPvUinM9d21pX9yLHNKuBaowK2VowmzYtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGAw7GqqwNuISSvgtPaY++EiQxS10zlFv6k3dX5dQ5qGdO5Tpd
	OO0Vpt3s45tpouFkrAGFPTB7nQF9Px3CMOY4295ZhEKErU2lQ8LuVcBsLeb55UPuy8gUPyg6/Bs
	SGEIVJDLgary/lazOYucwOW1+HY/WcdzYo6byc76jKnRput43jgjnN4HA/NFrH8LPHA==
X-Gm-Gg: AeBDietWinVGrF9Jq/oPJ8H5+Jh79WIghm1lJYfwLSgRMVXlBsahCMc52GzYZSysGmq
	Gja8yfEO5RL1oqj8jQxZcCa0QimPgyGAXyJRjP91LrJJ5asSdKq3ZN0vF2cgfEfFp4HDMZnShmY
	qhF82bqMiYWhPwQZWW0T79pbCGT8YhNF0R5bH+lRKYc6+Img3iMOfjNQjtuD/SGZRe2FNh3PeYQ
	bPE+3ZKs04ReqCF0uKm4ixaNjbkIALozy2V4u9k3Mmz4be+aLDaz5NtiTNi/3UkG3DVwE0jrbVG
	HCnILbBgE02nEYwJ5il2LDvrpbgMqTK65PsrbqOGUbHHJXu3U7yH1DCDGocQnhgU7TQ0Ht8G21j
	mxhorbJvC7sflybOGUFhhL6f4YGVmlSUH3rC+AZwObxPPzr/B+k3lNP1EHNoLUInbf7k=
X-Received: by 2002:a17:903:1110:b0:2b4:636b:dc4f with SMTP id d9443c01a7336-2b5f9e950a0mr146302575ad.15.1776759961660;
        Tue, 21 Apr 2026 01:26:01 -0700 (PDT)
X-Received: by 2002:a17:903:1110:b0:2b4:636b:dc4f with SMTP id d9443c01a7336-2b5f9e950a0mr146302295ad.15.1776759961180;
        Tue, 21 Apr 2026 01:26:01 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab3ad18sm132433855ad.71.2026.04.21.01.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 01:26:00 -0700 (PDT)
Message-ID: <3c2f573f-c457-4aec-b929-9e049b4c1d25@redhat.com>
Date: Tue, 21 Apr 2026 10:25:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net: wwan: t7xx: validate port_count against message
 length in t7xx_port_enum_msg_handler
To: Pavitra Jha <jhapavitra98@gmail.com>, w@1wt.eu
Cc: chandrashekar.devegowda@intel.com, linux-wwan@lists.linux.dev,
 netdev@vger.kernel.org, stable@vger.kernel.org
References: <ad5p7XlSOKoaQC5D@1wt.eu>
 <20260416113205.1789319-1-jhapavitra98@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260416113205.1789319-1-jhapavitra98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280039-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,1wt.eu];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xkcd.com:url]
X-Rspamd-Queue-Id: EB90A4382FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 1:32 PM, Pavitra Jha wrote:
> t7xx_port_enum_msg_handler() uses the modem-supplied port_count field as
> a loop bound over port_msg->data[] without checking that the message buffer
> contains sufficient data. A modem sending port_count=65535 in a 12-byte
> buffer triggers a slab-out-of-bounds read of up to 262140 bytes.
> 
> Add a struct_size() check after extracting port_count and before the loop.
> Pass msg_len to t7xx_port_enum_msg_handler() and use it to validate
> the message size before accessing port_msg->data[].
> Pass msg_len from both call sites: skb->len at the DPMAIF path after
> skb_pull(), and the captured rt_feature->data_len at the handshake path.
> 
> Fixes: 39d439047f1d ("net: wwan: t7xx: Add control DMA interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>

Does not apply cleanly to net, patch says:

patching file drivers/net/wwan/t7xx/t7xx_modem_ops.c
patch: **** malformed patch at line 41:  	return 0;

are you using any https://xkcd.com/378/ derived method to cook your
path? please stick to old good git and verify your local configuration.

/P


