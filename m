Return-Path: <netdev+bounces-285754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKdGDOO5/Wm4hwAAu9opvQ
	(envelope-from <netdev+bounces-285754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:24:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D124F4F93
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E3E330378B7
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 10:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B533CAE9B;
	Fri,  8 May 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5QpGj/y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGCrnwNc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF23C2792
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778235845; cv=none; b=oE0tzGUkjBsBLKZ0KcIRyXiyEfhXOe1BAg++5hXp4clNDLrDvjQtUg22SBgJraXAn4KTIGPf4eihpDYwFV+TRVasEU5C7AEiDCs/EoAHdwQobQfi/R+1vJGod26et+h/lWR7CATriTL3YlfO4qbRODPd20gYjNR5x3seKNodqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778235845; c=relaxed/simple;
	bh=V0S77WuEXUDfU2urKVEn7xkQzr0Ul1uEZMmvaVqcTQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJFOzOCN9hv0UVWIZL8bSrE4KqByUhOrAAsyk//4tsaFVV6kyM6SVtKwBu5auxoqWomX4l/7d7yeocli69/ctl5ADK4qFWMsR3jaTBcxh8EEOfmUflR5YNslSABUghkyZRcFsRmPkA5RsMgFPfE/Rvwvl/elUoj6UwQyaa1qgaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5QpGj/y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGCrnwNc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778235843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/aqqvi31nG0cLuop8j70SGka90++tg12ySoiLhybgfc=;
	b=N5QpGj/y+gXLKdIlz6TXwCyUjbvMPdkFWd4PKnBhDAgoM24qUMTEnLiT8kHGAM+vRee+ny
	hm2x8i3pPBFAOu53jAhKuX7AkA9oJxDpzE/j7k1ks/n/ZjU1hJtAQIeuIyIkUqTrzdiFKT
	gBfFV8/uwQtG2H3hCKuKNWUSnosF3So=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-TAHe2IM8OFiS9bQVcXs5Sg-1; Fri, 08 May 2026 06:23:59 -0400
X-MC-Unique: TAHe2IM8OFiS9bQVcXs5Sg-1
X-Mimecast-MFC-AGG-ID: TAHe2IM8OFiS9bQVcXs5Sg_1778235839
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48e5eecd0aaso10315245e9.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 03:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778235838; x=1778840638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/aqqvi31nG0cLuop8j70SGka90++tg12ySoiLhybgfc=;
        b=YGCrnwNcQIPLkUNcDxDOxd0wZHQrifVbPtJPvQDYo+TQ3p4A6/WdKkDroLrpjfYja5
         cfAZk9BEFFUHQJFA4ozw/buMMtYYi+ZmUd2YPmnFwl0wdh0WENUFoqXFHb9iSZimubmv
         RRcXj6mvFupUmfee0Y4jHElvxD2teulnwZdtYKVy+27qng8qkEHC33vydROApOCcYsis
         RTecjwJ666wsrf9Yo/9nuXHzh+KVnPRuPpxc042hEsgezXW+NgBf5lPuDaT+k6Hbgv/J
         jvt0DBLGfzDHmV6vd7LTzSNXStKu7SsJe46SPaGYHOtNLpYuiPPTj162h9161QlvjBD0
         kLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778235838; x=1778840638;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aqqvi31nG0cLuop8j70SGka90++tg12ySoiLhybgfc=;
        b=KRr3Y8K+6bPYrRzXkRH/6FSSz/jhqFdWQ0F0/mGqvu5h/xKZf/Wzqs1+k6vDP+YWls
         ByXhcbxwu8NgSLnaVJ+6NgNon7ViCPhRkzKk7m0r8ggl1j7bppCniwwm3Ix0OlSMgaSq
         12yRcBBDI9c3+aWEihnHAlPb5UhgXa8Sf+dTTtvlHL1hKHph7j0TbbIAF2ioq6hdmzQe
         iZ5E9nk4E0qXYX/3K6bAgj5s3LJt7rlbU9nXonO+VZpiOWZcxVc7l8jVZuSgrViFMk+2
         0BPEuJ8OhY33W3iykJY/PXgSE9yMI6xk1DZPbCmWwN3nZDW2iIDdgiXzlyh/SGMcaYcN
         XdXw==
X-Forwarded-Encrypted: i=1; AFNElJ8LpVB1pfH30CjJKGeJKNOb/wbdGh4WqZinQc+KaK7m7UM8EiAhWFkBZg6gkCWkizlWHXOVocg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wBY7Xpo9yfkUs0NzrY1M3V5Z89Jk6CQXbx5ytQmogt1sP7Ls
	eXCaBwPGxTvvo9xyR13RqzcubRQOpiY/m1HqaOlNjar742ReIk1SwpUbvZ5ViGvNSEihhO2qx6x
	hrpKv/rlY13V7AOdvhFMGCk1Hscb0vc5Gl2ACe5qEVLtiBOSYRh9H59a6kQ==
X-Gm-Gg: Acq92OHAoCx1iR79U2HDUSTmbdUs4XbAyIsRzfQktWdR8DI8ENkEp7OpHCkGOBTAYXD
	ElIBO9lkZQJ+jVAmIIbmmk3larZEWYLTqOrt5S8LWp6u1X7sk6m2I+eZT35UXX1otCwTqVQqjdo
	T09Kowk9SHEAVSkLVLaZd6OMdflkqacZdm1yV2MGt9MbSXeczrScbL4eF2IvrnzXOHyCFJ5LG1f
	62xbXzSNDM7B+b7B/Gpfr9HTE5kMFOeupPrLNeFfIRsTO73zbujBHYl0vSF0M2Q1Qf01IicGrDN
	7nNrZCay1eg2Vz+2VEsELyZvxf9oLErPBzmcR17zcIXzZhjqf36L5SfmJap80NSS975VnW6Lc1a
	f6+Y0Gczt/h70IzYPoBDCYFHtG570KDngji//Jk00WlQS1DOrhn0GkpnO3g==
X-Received: by 2002:a05:6000:420c:b0:43d:7a97:78a2 with SMTP id ffacd0b85a97d-4515c5752f7mr19940565f8f.28.1778235838518;
        Fri, 08 May 2026 03:23:58 -0700 (PDT)
X-Received: by 2002:a05:6000:420c:b0:43d:7a97:78a2 with SMTP id ffacd0b85a97d-4515c5752f7mr19940485f8f.28.1778235837943;
        Fri, 08 May 2026 03:23:57 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6aea4sm3873533f8f.10.2026.05.08.03.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 03:23:57 -0700 (PDT)
Message-ID: <8988ea27-59ae-4ebf-ad7d-6e4ef3bf28ed@redhat.com>
Date: Fri, 8 May 2026 12:23:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mptcp: do not drop partial packets
To: Shardul Bankar <shardulsb08@gmail.com>, matttbe@kernel.org,
 martineau@kernel.org
Cc: geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <20260422143931.43281-1-shardul.b@mpiricsoftware.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260422143931.43281-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 84D124F4F93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285754-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpiricsoftware.com:email]
X-Rspamd-Action: no action

On 4/22/26 4:39 PM, Shardul Bankar wrote:
> When a packet arrives with map_seq < ack_seq < end_seq, the beginning
> of the packet has already been acknowledged but the end contains new
> data.  Currently the entire packet is dropped as "old data," forcing
> the sender to retransmit.
> 
> Instead, skip the already-acked bytes by adjusting the skb offset and
> enqueue only the new portion.  Update bytes_received and ack_seq to
> reflect the new data consumed.
> 
> A previous attempt at this fix (commit 1d2ce718811a ("mptcp: do not
> drop partial packets"), reverted in commit bf39160c4218 ("Revert
> "mptcp: do not drop partial packets"")) also added a zero-window
> check and changed rcv_wnd_sent initialization, which caused test
> regressions.  This version addresses only the partial packet handling
> without modifying receive window accounting.
> 
> Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>

It would be great if you could send a v3 addressing the AI comment.

If you don't have time or capacity, please LMK, I can send v3 with your
SoB and the needed editing.

Thanks,

Paolo


