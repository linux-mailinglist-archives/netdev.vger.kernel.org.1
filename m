Return-Path: <netdev+bounces-304100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PgitAl5CRmoyNAsAu9opvQ
	(envelope-from <netdev+bounces-304100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:50:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 517266F6323
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:50:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=iVBGqyxk;
	dkim=pass header.d=redhat.com header.s=google header.b=N3V8b9CI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304100-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304100-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C783C31C3345
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394E23B2FCC;
	Thu,  2 Jul 2026 10:37:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADA3A0B3F
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:37:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988653; cv=none; b=rUT2crP/MEJskBdC6J+93I3RM5+opVzKvuIKbqIKNve9Jq0aURqladi60N7X0lUgG2T2Uq2IJ9jPWlmcfEmIHiJ+lwn37pXlNsOOugk5pNEsQGy3cEJ1RL8zByURfG+YG92xi+L8lgZBZwyks97b8Ln2xgdtdmxkZrayw/UD/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988653; c=relaxed/simple;
	bh=nddTsFpGNx0n7hooigV9Oq9WL9zEKKsr01A9M4TKXSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXP7Y+cGgcw0qDDuLl6lCcNQT9xIntedO/fnA6GPAMMkA6yVvlr2X/twQrOsadVWOxanOxvZcFaNwt4lPk0oX6RRpQ9lZ6VzI4VQahhqHLoE6mAagegK2AX2biRkBmDr+0ukcajPpfrIfpnZh/F3KWbPJbXY9KIoTzErGSBwZTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVBGqyxk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3V8b9CI; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782988650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nddTsFpGNx0n7hooigV9Oq9WL9zEKKsr01A9M4TKXSY=;
	b=iVBGqyxkZgQqc2SFd4kWhvlyaBlnoPSf/S72skZfWMfYEYJ6zdsefEcmHFQ0zOl14nIeoP
	SLK+cHIkSTEDDLPCftBn1rLDfBe2xRvBqv80CfXnQxQjXRuSPw46jjaCBNcB/d68eZ6R/M
	nhA70hA7hX6yAw1vv4bglQuYWrEQ8SU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-j2djK4QnPsy3iyEba3wfzw-1; Thu, 02 Jul 2026 06:37:28 -0400
X-MC-Unique: j2djK4QnPsy3iyEba3wfzw-1
X-Mimecast-MFC-AGG-ID: j2djK4QnPsy3iyEba3wfzw_1782988648
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4744b72f90bso1162807f8f.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 03:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782988648; x=1783593448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nddTsFpGNx0n7hooigV9Oq9WL9zEKKsr01A9M4TKXSY=;
        b=N3V8b9CIjkagl5Zkq+MBy4IO8BcNMe01MkLCnI/rfJI6545CzB+mhkbVOXhkZ41cmz
         F7EDY6v9FDUXF0q+jAErSGhtp4SAmqSxkLSB7bIjKrI2ZJyX3MaLtQ95rYBeRHLlUsF/
         lkj9mHvoklG0h4r4bbPAc2TCvhLAbpsuBAxXyholH6Tt81MYlDiPmBMMwIkYzR0otpyI
         zEGNkOjgAiCNEv/eyzepnRuCb+lQktl+L9ss5FJOxQPHC3uRXk/FDjmF/XKkqSrjfFjH
         HSbLlMytUWL1H8cQLuDAHSqX78SWOC2LyM172/t9wYh/x1/tyWK/dtC2mJ67VW3Bsfj2
         4j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988648; x=1783593448;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nddTsFpGNx0n7hooigV9Oq9WL9zEKKsr01A9M4TKXSY=;
        b=O9ehta8O4GqHBrVeUoRrZQQB3BezaJqL6CKkbu/qXHCPjVt5uKG4C4bO90/oSAQ/42
         kPv+1XijMAJB7+RpGURDo3BCSIj2iDVyLLzvcJlLcpuNatcX5ooD87D//Pfh5IKLJHgD
         YtEhvCzGPFRBjXUm7UnQIdIhM1fs7Pma3Ljl0r9yWDZFrC3/aKYh3TgL0voK8uskfhpt
         R6KIKTfF+pRDqRQTpUj5RBwwDtaYm1eTqlseOOhe/owgu9JlD03TfOkwAEge+2tLPV4e
         Yu6/Uqn1jezjrlou2uhwpQbV7nD0vNtmyp6oCDWR3Cq621tCRX8D+xBUIRpVwmWnOTzc
         PLAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9zmw8XQEjvVxHmI7t7D4/yCwLaBUnSPu/k/LB4sgR+ZU2iq4/J8OtNIb4h62cc9xMCvvvPPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/Fx1inAkwxqN8LLY44NvtndQ/OUWO0y6jISt6Nboo8bXD9O9
	EKX8kd0eMLXY6IOtVDqp8Jw0PVA8kX1XuUuqrpuriBj8HcfJRSVU23+LGdye+9JkNshF1MxblTN
	eFoPSyAbkVQ8xp5z2Le+KedmM+tVKs7PwnqGMPUCyYVD7nubBX4DBfwbPdQ==
X-Gm-Gg: AfdE7cnbILzF6cZPavzsE0ZrDQ6JjRlxSrZpbrkgMV/PHaq6inXJJ/WXAzGk3y1LGOb
	hpQDpXYeyl7/Y/6E0T8mOV43YQiqGlHv6IJOiGZsTucce4RLvlANJrDJM/ilWDoKBX31LyCkcwI
	08UaKFdEWiPA1GqKlTwcpIiNqVVLLRNd4PA1ngOLfI1qoruZkbOeSqgzielGtIzihCl/QTqg0b8
	DT79q+P6TBV0JdyQ90+gsuhYXWtE1TE6gBQD5rhGkeymGBeWNCmHuZRaj05rV4dclob+AArJFiM
	EZ/OA4ViyACuX/GI3BuUrw3svkr4ZQuyJYaiRzi6B5Fk5iWhwgprugHw4yTUbaX0vsueUxr7l21
	jilOSPLoOmWRwuSqoKV0dtWMaQqbH1+WCoV9/gG50u6Og3NKk24GO9ysdmB5OPjFCBonclBXiQc
	HlExlS1BDK9Q==
X-Received: by 2002:a05:600c:1594:b0:493:bcba:46a4 with SMTP id 5b1f17b1804b1-493c2b7dc45mr45641815e9.20.1782988647632;
        Thu, 02 Jul 2026 03:37:27 -0700 (PDT)
X-Received: by 2002:a05:600c:1594:b0:493:bcba:46a4 with SMTP id 5b1f17b1804b1-493c2b7dc45mr45641605e9.20.1782988647189;
        Thu, 02 Jul 2026 03:37:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bfe616f5sm78192135e9.1.2026.07.02.03.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:37:26 -0700 (PDT)
Message-ID: <81a52d1a-350c-4242-845d-cde2e24724a1@redhat.com>
Date: Thu, 2 Jul 2026 12:37:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] net: emac: fix sparse __iomem warnings in IAHT
 register access
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260630041634.284127-1-rosenp@gmail.com>
 <20260630041634.284127-3-rosenp@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630041634.284127-3-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304100-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 517266F6323

On 6/30/26 6:16 AM, Rosen Penev wrote:
> Annotate iaht1/iaht2 in the EMAC4 register union with __iomem so
> sparse does not warn about address-space mismatches, and simplify
> emac_xaht_base() to return &p->u1.emac4sync.iaht1 (or the EMAC4
> variant) directly instead of computing the offset by hand.

This patch does not include the actual annotation.

/P


