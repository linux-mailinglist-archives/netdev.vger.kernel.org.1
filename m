Return-Path: <netdev+bounces-255797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OOEICVugGnC8AIAu9opvQ
	(envelope-from <netdev+bounces-255797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:28:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C470CA1E4
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 916BA30058F9
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71692D3725;
	Mon,  2 Feb 2026 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7w143A/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qf7wp0ty"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB30142E83
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024483; cv=none; b=sHhjULmeUvd1RUGdr5/k0iDe5/r4Vtj3kvGsjgjbS4CBmtNyEaFyYvtM+vM20ht2kXeMwpMducLrPPSMGCobVQ7Vwjew7Ha5aE70XjXR16j7iWpNEqjHdvCF4NPaxCfKjm6tHunEBstxzTrJA0bfQnnYkck4o3zLgA9GYMH6Xvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024483; c=relaxed/simple;
	bh=Ps12wmNRlfIr4jWLYjjWW0a8gmssH21Cvl+wHQgM2a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASL0sSSCENi2wjZRqQwYzNpEWzFY5/lJzvq21g89bHIIbX0sSCA1krauvwCikfTGtJcBqUe9E86J/Nt87NDAq6R+rANQFy7UorZK3lo4NDp4lfw8N/6fPv0XY1Dmp4Ctb4+5B4Hhg6luX7MMzgQNa6mhS3txWKGL16pk231Gc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7w143A/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qf7wp0ty; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770024481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfpLtRQfQn42RUL48k7TwWls5HiMY1YLOuBbBZW1yJY=;
	b=L7w143A/ZjhrOCOXRrE0ppsyaLm8bkEMSLudlYV6sm1PO6sZyXvbjM9PxKIGk5FBMeCuff
	0LiJfjKg9RjsMn0npBY6unUnHgo0uqr7mCN2SK9EFxMRPt8NYGX7u47Ia7vSc/FD5abT43
	pmQ25StcA1o/WC34y9flb3/vmEdMB3k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-x1eCzPS-P4KpX2QI84EjSQ-1; Mon, 02 Feb 2026 04:27:58 -0500
X-MC-Unique: x1eCzPS-P4KpX2QI84EjSQ-1
X-Mimecast-MFC-AGG-ID: x1eCzPS-P4KpX2QI84EjSQ_1770024477
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee432070aso32884015e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 01:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770024477; x=1770629277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfpLtRQfQn42RUL48k7TwWls5HiMY1YLOuBbBZW1yJY=;
        b=Qf7wp0tynsfpg+pohXODnAsasJJsyCVzXpZmh2H4Db279awBF/Bsv/POQr4nOETbQj
         KWsNuyJVKz3oWMkohWlbDeFcEYk6p0BQSLVkEIn0HKJb1Rphnu7kwy1L2jIe7vuc5Juj
         3IPxaFRebINmp5Y3EicFguR4qFSx75ImebIT3hdT54PY0WIOlV4SNWnjal1XwKWlc3/C
         DEsi4GNgVG2bLO8Ey8ExIMN/xZuWE2mH4umR5/KevrnvjT/oTtRXvH5lLyi9a5T3NxRA
         IdZ/oWPztU3VfPLYfL86y5PoVC5ZWibqmM8Jw982OHG5Ad5cw+ytQka8vtxUN5ckKRVB
         Yfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770024477; x=1770629277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfpLtRQfQn42RUL48k7TwWls5HiMY1YLOuBbBZW1yJY=;
        b=XRMSZdPrZcd1P+/fXTL7Z8fu/lhlS4YbcSvqCOvjczFpJL9nlQP6YtQ2jFb23duade
         Qx/hLqokroJEw2bTIL/Jirr/z5ZzliE/mFoup1kZNhZfVsBYTcS8E7N25cr/1kVuKOg5
         FBh010IXvQmtcG2pWPIbv6bUaQz6jzSe5nV6zY6OTeAZ6golQXW4uD/CVJcoBS2qk5Qu
         9cTzpPeIkMoYgARUhF1snzhdN5rSBN793EjHY2W02a9EbjTIBH8vQ1EaE5NmOvz96Lrs
         7XVff5E08IcvUhjTD6U5BdCkb3QmUb+NAtcBtnzC4Oxr22MagPJchy3CID4pSfvxLoYR
         FPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7JNVjQ3lERFrHvF6C8NCza44bZdMo2XNJqH6ur10BBz8hIJUem7RdZTR8PKiZ85FJ2DrnD3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0TqVp2SS/tcdCSO1oOws7979DNeBAaU/tc+IoriVvfzGyhL1
	jOLE3s5zdlPE1FE6bYFa/c/zFOWcwbnqOKbXAWmIoDKyAXmjdIHy4/uR2Yu8+LB8TQV7HmknQqu
	/FcQN1VGq5CGlHer03f9nswO947ZDnxzWiguBF0QrIDvLsvB5GRQ8dVgFzQ==
X-Gm-Gg: AZuq6aKXHTQBTsY/9iJFmtw5owAk79A2zGXyzVO+ebyRlCP6BFhQ3K76t+rrrDR18S0
	ZATrhn/8Nt6G+8cu9FyLncWiv5Er3awkzetpqMa43cDoi6vhzgzUkzPonNS8oKttLD0kn6qS1Gk
	fJZgrWoZkLcRCydEaUcIUXGPQ7vjGBIW9AClEpdk+gym5DknJ+iihWO5jphB3xt+mhpVSZlTiU6
	N01ifTSQKLNcv5UkDDatzTJntfBvO8O1f+jZZigY15VTx/S4mYI13CgYEcmmcP0NdHQ0tG546Fr
	Mk7o4YDLNsif1ictzMpZO1B7ApGmJCL2Y7fU1z8ZWUKPaFIyfmgSIWiZM82FIFgWksB09RkuiqD
	+9YnK02PLQrU=
X-Received: by 2002:a05:600c:8b27:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-482db4998ddmr129478825e9.27.1770024476821;
        Mon, 02 Feb 2026 01:27:56 -0800 (PST)
X-Received: by 2002:a05:600c:8b27:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-482db4998ddmr129478555e9.27.1770024476481;
        Mon, 02 Feb 2026 01:27:56 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffc0sm437544775e9.5.2026.02.02.01.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 01:27:55 -0800 (PST)
Message-ID: <39c1b386-e6ee-46fc-a653-f86fa21e9e9e@redhat.com>
Date: Mon, 2 Feb 2026 10:27:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 0/3] bonding: fix 802.3ad churn machine and
 port state issues
To: Hangbin Liu <liuhangbin@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20260114064921.57686-1-liuhangbin@gmail.com>
 <aX_6jyAQaDoqsR3G@fedora>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aX_6jyAQaDoqsR3G@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-255797-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C470CA1E4
X-Rspamd-Action: no action

On 2/2/26 2:14 AM, Hangbin Liu wrote:
> Hi Jakub, Paolo,
> 
> Is there anything I should do for this patchset ?

My take is that given we are now much more near to 6.19 final, this
should go via net-next.

Beware: it looks like Jakub and me are not 110% aligned on this topic,
so please wait a bit more for his feedback, thanks.

Paolo


