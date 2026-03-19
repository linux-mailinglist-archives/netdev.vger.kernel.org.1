Return-Path: <netdev+bounces-269411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKTbArzfu2lXpQIAu9opvQ
	(envelope-from <netdev+bounces-269411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:36:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 618902CA657
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06E323037E4A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8331D61B7;
	Thu, 19 Mar 2026 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsJe6ZsQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsBNZ+bK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3C358377
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919888; cv=none; b=LNnsY5slHCHB8y42brq/1aSQKfGgykyIU4KXNaavRYD4X7r/tLoRtcieAfdf5VVC/L7OkMWFreKyINH9LKFWxzehAXir+TTyvXTezCWikKouVJnahu8iN7o3LGbTRTO5EEaSy4DXco7e69uF4hmUD/tabB9yNNUHJuoUAqe4q94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919888; c=relaxed/simple;
	bh=lhawrlfjDM6ekxMavNYonIQYq9bZ5Z7Dk8BYyX67q+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8iyJpVjK0dpVMl+npRsme4JTRqXdw3ZTsVTFxvB/D8ENccmakYVxWjMf6PophPXRBcC44fyPsf0kwgRY3k0+tOK0tTdhP1u3FU3TgjVbKmZYlFpk6H6LAPhLtqdq5PELEODC7xezoK1N2/uKEdWcGzygrmc0mfbddFxeSurPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsJe6ZsQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsBNZ+bK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773919881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpsjXu/7Z73Aq5Y8+299/a9mJZXXbxm1Eq6cP+0/w5g=;
	b=QsJe6ZsQS8+SuADppkW5IL5HqUKh3kTq84aKHYjJqeq85qQSEVvI7Z2IgPC4dQXgBJXvbh
	Pr2zeNo+OSJS7LOQUoczxUChykR949g2RXEhzqrUXrTAY7p/xVxObWmVc+BOU7+AG9hTTk
	TAx5McDzk4sCeu8eG/vHluYEj6oUZIY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-LEGfyuC1PQicNTXQBBLQxw-1; Thu, 19 Mar 2026 07:31:19 -0400
X-MC-Unique: LEGfyuC1PQicNTXQBBLQxw-1
X-Mimecast-MFC-AGG-ID: LEGfyuC1PQicNTXQBBLQxw_1773919878
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b4d3919e4so611880f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773919878; x=1774524678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpsjXu/7Z73Aq5Y8+299/a9mJZXXbxm1Eq6cP+0/w5g=;
        b=TsBNZ+bK2hiekrDt9xdO3jBTFkBFoQjAlItP+nms54H/oZ3iLvgOTJ/UgOX0TKixcF
         PFLwlkzigBjdL1UUJ7ZLZW8wFEY9PJiI4ZzkSPrAhDr35j92CfQC75eHnDhnuJY9YIIK
         lj6KG/kg+/iVvhjFVaeATv+afmzqIpqo3i3nebC9PrVCjoAZh+nKMdVEnCkWTUXNW00e
         YyZNJfMPPBFXyf/5BCJpk8SLf4KH0SZasHgfBM17MBwP8o076xWonAvYaLKORPiK54di
         kdqaowBo0x8ZoNZgLxurmqnNJYNOHJ7tC/MEu1p4mWvLZDR2r3QDRmcCKSeXGuwvy21c
         BuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919878; x=1774524678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpsjXu/7Z73Aq5Y8+299/a9mJZXXbxm1Eq6cP+0/w5g=;
        b=PvDZy7XvbQpwmEOIT9q8sejvVTxklGUgOKdPwv+23iY0nFmYtChlM6k4ayOic1Hnzh
         gqjFb3PwJYgONziiW00NCWhQPqCrf6OIjHG8Ptpug61SfeIU4EpjnOIHX+VPHdkL4M3T
         KF3o0PRXC4kKngfw37CTOyesP+PqcIJ/98f1jHwC5kHyPtbDGjY1noUQkJcqryLBsmZw
         CA9svOXYWpiHmHKMk31NY6hVtylCnAe/y+70C+9G+3pGRbrIDbwVFh7TETlnMWV+3uAf
         XUU71MtIaUHvyjLLw5OGJd+qysrEr4SeOyplSNFHHTOw/8OWB9DxrnvaaJa2ngz4SLLu
         R6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiqtU4iDPuf6SQDN93ING3OLc0oWrG9Ku3sXX8I0XK8iXa4/KCvEnq7M+tMv9Dl9gRm6JN4Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+nFis+I3fPaTupkpXN5IsXmi4hKgb0vVpvTznaXJY9OxAp9E
	pXTrm/BgojdJowfNIsKDBn4fWmI6X/9ubiZMBVzYzccNKIdS7Js6Q0uqj6k/s5VNDscmzC/mziw
	2+VTiOx645nTqvXbarI40xT3+yoiZiSxSE7R/n4eM6mT0YZn+uaafsTBW6Q==
X-Gm-Gg: ATEYQzw02ShVcM935ofbN5jJ7ZknJAgynAgQ/5TgtHlIe0E8eO5I6k4ABbjfsGeP+d/
	UpXPiKWvLA2pwDRkXjPiQqmhMwV4sgEGgKds5P4qA4oi7t1IVyw4gKlHTE1id7AHdbh3LoO8+Kr
	oPmj7b9X+HdaSEWHER2x3REnmpbfSPepRWzKr/HnsAOMP89ywGH/1oB81JwOTYOqatr+ROHKNip
	lg3/Yq3JSc0NtpEinVjav3et5vcP1OayHkxwHB83hGMOx7oY79vP/6eZ9tUwRjO9LjzZw8tpILQ
	TKxvKzUeeR3b6zF7YkXM1Yxqy3kktTmlPMX6J1MurSsD78ooZmH9F0xYGb2GkR+ZzIa7gAvcrR6
	QoHiiQEREE66l9nA+0IIqJv9TwNRpFkOKlIlXB84R9Y8wjoiDUJ00EAMx
X-Received: by 2002:a5d:5d03:0:b0:439:b057:cb05 with SMTP id ffacd0b85a97d-43b527cc378mr11688606f8f.49.1773919878430;
        Thu, 19 Mar 2026 04:31:18 -0700 (PDT)
X-Received: by 2002:a5d:5d03:0:b0:439:b057:cb05 with SMTP id ffacd0b85a97d-43b527cc378mr11688541f8f.49.1773919877908;
        Thu, 19 Mar 2026 04:31:17 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852ab3sm15332578f8f.12.2026.03.19.04.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 04:31:17 -0700 (PDT)
Message-ID: <3c79d694-b078-4c01-b317-71c70e700b85@redhat.com>
Date: Thu, 19 Mar 2026 12:31:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 09/11] net: wangxun: add Tx timeout process
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Kees Cook <kees@kernel.org>, Michal Kubiak <michal.kubiak@intel.com>,
 Joe Damato <joe@dama.to>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Abdun Nihaal <abdun.nihaal@gmail.com>, Breno Leitao <leitao@debian.org>
References: <20260317073827.4300-1-jiawenwu@trustnetic.com>
 <20260317073827.4300-10-jiawenwu@trustnetic.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260317073827.4300-10-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org];
	TAGGED_FROM(0.00)[bounces-269411-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 618902CA657
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 8:38 AM, Jiawen Wu wrote:
> +bool wx_check_tx_hang(struct wx_ring *ring)
> +{
> +	u64 tx_done_old = ring->tx_stats.tx_done_old;
> +	u64 tx_pending = wx_get_tx_pending(ring);
> +	u64 tx_done = ring->stats.packets;
> +
> +	clear_bit(WX_TX_DETECT_HANG, ring->state);
> +
> +	/*
> +	 * Check for a hung queue, but be thorough. This verifies
> +	 * that a transmit has been completed since the previous
> +	 * check AND there is at least one packet pending. The
> +	 * ARMED bit is set to indicate a potential hang. The
> +	 * bit is cleared if a pause frame is received to remove

AFAICS this is handled in patch 11, at slot reset time, which IIRC is
quite separate from pause frame reception.

I think this comment need to be update to reflect the current behavior.
Also you should explicitly mention in the commit message that the actual
implementation of this part will with a later patch.

/P


