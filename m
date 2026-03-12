Return-Path: <netdev+bounces-267041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGPUCTGysmmYOwAAu9opvQ
	(envelope-from <netdev+bounces-267041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:31:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1055271CDA
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 449A030D9D31
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62D3290C4;
	Thu, 12 Mar 2026 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRX/zdy2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEMqAFYW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A03AC0EF
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318422; cv=none; b=nrpIMrQR9CTBG5e2P4T52yWf/VEbpucBbUBobs4y2X3uKT6LXMZma1SLJmXolXf2dDViztVkBhk097PlbHqH4LfgrMCfzMVQsdAYVuFQXIDQx+S0TBDq2s7FlqnRXA03/km94EFI71/+YrJW0pTYOwIpuhLjBfU9cX61ZWMHgV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318422; c=relaxed/simple;
	bh=tZ7QjHtMOHEqpdzA7R5BA5jscg6mMt+OSRX7pq7gTWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgxxTmg7xqbixOTgCySuFv1Y5FAe1LrFXnLFa3W0ssXfrg8o7xg8h4lFy8ptW0Xq3ME7CAt2LJ0h0xSBZCJwRqLWX9A0gyja8+InBQ2+r5xzhBd3oHAGwh/ATDtO2t/R9odnYAVy74T5VbzeBEIvRykew9NsiL9U0gqgaecot50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRX/zdy2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEMqAFYW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773318419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHjT3WKseZTQeBYS5xk5E+jJWJBVzbng/ZWMUtww+94=;
	b=QRX/zdy2rDTR2+crbqv30u3CKBYzkOXJKc2x62p1VF40VJUvsrd8aGHQd0Uk2VmUNFHbLX
	BpKbmVkAWsFCg1IrWFMuhrAHFVlx8JSghoMDdUCSVhd0RImcZHAA9sEM+Yd7EjPVveDzZV
	7dSS0gMO6sF0s7mhLJd8UVZMI8vkpKI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-7L6opadNPDC2FEaq_-o1PQ-1; Thu, 12 Mar 2026 08:26:58 -0400
X-MC-Unique: 7L6opadNPDC2FEaq_-o1PQ-1
X-Mimecast-MFC-AGG-ID: 7L6opadNPDC2FEaq_-o1PQ_1773318417
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-485345e2fdfso4832105e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773318417; x=1773923217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHjT3WKseZTQeBYS5xk5E+jJWJBVzbng/ZWMUtww+94=;
        b=iEMqAFYWUW17V+cRRhuLakQBuUx+k9BJSouAJpWeDK6ON4RfbU7XdjzOw24vHRfzL3
         okGyASVLpfFaIafmHmQNAizvtPDr9a2O7n8uvM8EkXH0UdKnaDy4p996e7apjeyPUsDr
         OTsNhiKBnKgDFMDz3vb0t9Y4ifezXdZwvzmobBmjixVgxW2SAhwb60FMedeEpiFHgEFy
         gWJapmbUwRrtkpb08nK96bPb5Lx05pbqcXgyS5i7NN6qsQSnq+bTD8MQOjqQ5mQdYc87
         mrlzaJGQrWqd4l7pkGExa6mR+1Q3WHzIWeUqZ7j8eF7yr83SkfoKHVNTuyT7Z6ngnh/O
         LuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318417; x=1773923217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHjT3WKseZTQeBYS5xk5E+jJWJBVzbng/ZWMUtww+94=;
        b=xVenLEnRCtSbBPZlOIAuJwqXZI9Tip6E9nS0cnTowfFWqM5TLpgkbowxKV7/5hxzxJ
         luRfO+BSZ/04OZFpkRSFI6lWmzhKppm96HbcbVEuNOjikD43APbjg5c4yNXEfg5aySA2
         NIApYt6YuQJZmRMGF9W1zgKQYghuA70DA1XlFSoGK6eRoW2iMdVLxnQKrvM8Ca1I5cgi
         zYAGqQ1m8w4UHffM9oyfoRcltE6m2CH1WLhWO/3ean+nLsat2yjwWt9e6Ff1/HjJBDT3
         Lhyc18Aoc7Jg4Xsz697enF6hkvqBwefdEy7GlatFawwbEmeYgnQTvcdtfDyKxMpuOj5i
         P1jw==
X-Forwarded-Encrypted: i=1; AJvYcCXXlaoioNuaXGk9v9dkyCXROz3n3A+spFCj+wCedjXLSZGN2a6R8vuu2ClPCEdDNvvdIsHiIQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztq3lw/MStiIg0qMzZmyk+2RIxT2TU2qGQw59Y+raYRYi9xeh1
	Sg8iJTdeTwHOZybs83gZiIXTkKAaP4D1Z9tkkPnWYZ1/ZNWOBKi/vjgYOskKa7GSjCh6qr6S6sr
	OAhD6vZPaBGuRSRCZWtP9ubburOdQhTolPiTEeXahGzMiHJS5F28bEtap+A==
X-Gm-Gg: ATEYQzznj7EtuGRCTU7EcZhdGOLdX9vLLJErgI99Z4Hqztab9W0tCKiqlFx0Ik2hP3s
	Yf29xP1Huwlq4SRIDEM3qG3v/W/0FkJAWIQYC4ANcWqveKaYGhqvlSORrG9fWdSrXBFwyKLsGLv
	rBu0z3CLtk8QNhPmSjm5H1L2oEB3sA+kVod9ce/w7sUAtqinDyHwd8YJnx4qDCAT/I3ZbzzjYJk
	GEYJDk5U8Zvd71fPn4UapwCoqBQYTbauna15+V4wc5o6M+p2TkS6RalXlnrE0hNrP+H9rarB/Ko
	cGR9L0PODB685HZLUhT1a0qqWCsoLmUY3mjgU2vgFyfmqPHOmCS2k3hpBK+L5atkOJZxcn8Dp2L
	zsZXgo5ALpCPTEcnR/BbFl/zTvi4ownv/Tj/3CdY2bQ5UOH0YZsv18WI=
X-Received: by 2002:a05:600c:4452:b0:485:3c7f:527e with SMTP id 5b1f17b1804b1-4854b0d6a55mr109166885e9.15.1773318416806;
        Thu, 12 Mar 2026 05:26:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4452:b0:485:3c7f:527e with SMTP id 5b1f17b1804b1-4854b0d6a55mr109166475e9.15.1773318416429;
        Thu, 12 Mar 2026 05:26:56 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e67ea40sm87142425e9.7.2026.03.12.05.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 05:26:56 -0700 (PDT)
Message-ID: <d335d51f-6c42-4d9a-aa3f-4c8a2802ef44@redhat.com>
Date: Thu, 12 Mar 2026 13:26:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: add tcp_release_cb_cond() helper
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260310124451.2280968-1-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260310124451.2280968-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-267041-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1055271CDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 1:44 PM, Eric Dumazet wrote:
> Majority of tcp_release_cb() calls do nothing at all.
> 
> Provide tcp_release_cb_cond() helper so that release_sock()
> can avoid these calls.
> 
> Also hint the compiler thar __release_sock() and wake_up()

I took the liberty of fixing the above typo while applying the patch.

> are rarely called.

For my education: out of sheer ignorance and lack of relevant H/W to
actually measure the thing, I thought that on very high speed link with
big TCP enabled, user-space process and BH processing running on
different CPUs backlog usage would be quite probable?!?

/P


