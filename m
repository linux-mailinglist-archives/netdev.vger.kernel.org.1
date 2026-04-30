Return-Path: <netdev+bounces-282733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBN4EZkj82nIxQEAu9opvQ
	(envelope-from <netdev+bounces-282733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:40:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D3D49FF93
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B4CA3020FC9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3BF3A75A1;
	Thu, 30 Apr 2026 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jh8IoM0Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q7LkNJNy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035439FCA9
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777541788; cv=none; b=Z0e5Z0PKAbw1RXQ3iUug0Zb4EAe+1lfiKz0xk23v7WtaDGp5kFCe90Mp0PZmoXRzCThNaToA2+UjmrQAYP/eFDXZmgopiPDQrYnRXdGDenCs0+alRSeeIDv/YA02Q+Conz0rGwjLUnLrp6iIDddFMyrBjTWqhNIYP9eBg10Swdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777541788; c=relaxed/simple;
	bh=8XYI77eO2Q9i6/qngjnhgoeZZ2yef1kj2U9z0zeg0lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT7eDtdX2SLR5jQNjlReCHP2mVw5gGBcI6TD1siGF6wZ2v9h0l3cEgWqviibVi3e8NPotjDEBRVHd6IhSm49ZNCYBxaMQYST2ClQJB1UyE78eTD1dHbA1i0BjvxnlFKjF4rxg1ylgMSUD6PqbnWghpCAfJKUW4REgXEEZ739p7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jh8IoM0Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q7LkNJNy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777541785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjhWh406AAh7Ar0YD4uWaI6wng75NDyMA2YEGfoMNhQ=;
	b=Jh8IoM0YqEMlI2SAJaXhJJnr4wizw3Roe5+/gcxjDdO+Q06rXI3M81OVdCJG5fcGck8MnI
	1HjAFllpmkbMjftHbKDUC3r9qusfH4a0WyBMLo15Zph9K63fJ+3YAjlhkpJi1WmG0vBqdL
	iqir1lSViLewRO3w5zuCaKdzUa+/1AU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-k4M25raOPv6nvYyF6iDqEg-1; Thu, 30 Apr 2026 05:36:23 -0400
X-MC-Unique: k4M25raOPv6nvYyF6iDqEg-1
X-Mimecast-MFC-AGG-ID: k4M25raOPv6nvYyF6iDqEg_1777541782
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4891f97aef0so3392095e9.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777541782; x=1778146582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjhWh406AAh7Ar0YD4uWaI6wng75NDyMA2YEGfoMNhQ=;
        b=q7LkNJNyNfGyW8FU9eAbYkEHOZnubnzdHo0H2zH7NQxvBu9mPqZFVjIa5h13KZHUrx
         9n+7hW8gW4QlMUaUg/FoJOKxVeph4TNrz3H9Z5O1/UvInbztBx/F529ZOcZc1M0YLKpQ
         G+YhlEcz9CYdpZp+go25vitUISn8NqL4pMiJVZW5fUAz13y2O8RWobPzGAIBUT337Hj0
         XcYSR9XYmfMJo5s/XBxS9/kQ8XRd45JFiLgRO4CE9/0OSratoV5szj8+rr0EMXQgQVgi
         1vvimmzByRuqss4VwJDknKRgNmt6bZ6vDJ4oX4GX8DE+3NuzYjpShjRXgGbiJSZECzu6
         3/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777541782; x=1778146582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjhWh406AAh7Ar0YD4uWaI6wng75NDyMA2YEGfoMNhQ=;
        b=rLDOIXaU9hhDszYXuwG8iorNufn2LuoJSZhtpm7WjNoqr91BWJXexT6jSNN7vUT+Ax
         v2rr5w6oPGNBU3/MA0oVaV0W5MqVcYih0DtrsQVLbpfvvrBmYMBOLaAumpJO0BKWmYqj
         2WZ8Qsb/PU++j81pB4ZhhnIgB8MNcqPF9KoVTY1ajWCVd92ttPajc/7hV0NVrKBa85H3
         8e9IfD1i6JWPHn4q9lkYJLpAcvn3VoDb+9T8dLLU6LB8gpHbmmxt7Xsqt24WLPS2Iq5g
         YrhIEBNg+kDzP0SRSzkn5BgEpjmf+cJek3mRSQWw++TMD7tnNObYZ4YtULyPHthxKZyZ
         sZ/w==
X-Forwarded-Encrypted: i=1; AFNElJ9Qb5+xf51GDLC5Np9Q2WyPAz9thdnodaOZTs2iO3EgwjQQ6lDa6I/ETDTScXpI3P0VgOJ1TzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOqv7sNQZ9FKSgN6KjA5OJWcf6/QXAKepWO8rhp8a/nhWSopPm
	RLd5PSfEBsAiKw9ahrkAimkaZWrrsB4N0fRSvcfbqYt1MgFn7SgOVgqYo3BaNJ3m1UeKhqrheIs
	cyY+yOsrZHzwYFXIhS7OehLuiQ0CWKKzrDQ6XwEm338jDzwDrNthHOruKQA==
X-Gm-Gg: AeBDievx3L5PjtFpbPee4ZNetIgxYjWO7BY+Q1zQS+ojSip9K3xcuFm9MdXrzLZaBgu
	BIlGOEt1AcfYfh5FkCNIq49kQ+JgaWFQONwctzvgkioNiF20vL0UWdgXeo98Y81pwn9QtnVjK11
	fTLCT9v7sRVOaR+IF+X/qkD+z1yTZgcofuKE5Mh/j6YoKgfy19QJvDBMRzUYPibjrTkP6ozDzVV
	C+3mBfL/CACYmIXWg8wN9D2oUl/ntF6r4SDlT8cHLd7Sn//saTXds/iT0obDoM0MB4bST3Itghv
	OMB6nzf633mJ4omeP/qWFH3SGemAFOpQ28jymprgZGh1eii0ayoFB74e21nkofbkRAWeSlU4UV3
	wKUuD48zOiycYI/blg2pWM02eMdoUP/NgXiWwi+fqVuyzXLPet4md7a9zy8i7JGB6iA==
X-Received: by 2002:a05:600c:64c8:b0:489:149a:f9e7 with SMTP id 5b1f17b1804b1-48a84456b6fmr39323915e9.27.1777541781774;
        Thu, 30 Apr 2026 02:36:21 -0700 (PDT)
X-Received: by 2002:a05:600c:64c8:b0:489:149a:f9e7 with SMTP id 5b1f17b1804b1-48a84456b6fmr39323005e9.27.1777541781192;
        Thu, 30 Apr 2026 02:36:21 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed661bsm93521085e9.1.2026.04.30.02.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 02:36:20 -0700 (PDT)
Message-ID: <c80b2d54-a102-417e-bdf4-4d85af28c635@redhat.com>
Date: Thu, 30 Apr 2026 11:36:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 11/11] ice: add dpll peer notification for paired SMA
 and U.FL pins
To: Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, Petr Oros <poros@redhat.com>,
 Alexander Nowlin <alexander.nowlin@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
References: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
 <20260427-jk-iwl-net-petr-oros-fixes-v1-11-cdcb48303fd8@intel.com>
 <3c1f1894-e969-4dc2-914f-9e15db35dab5@intel.com>
 <20260429174125.191f9e70@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260429174125.191f9e70@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D7D3D49FF93
X-Rspamd-Action: no action
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282733-lists,netdev=lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 4/30/26 2:41 AM, Jakub Kicinski wrote:
> On Wed, 29 Apr 2026 16:28:48 -0700 Jacob Keller wrote:
>> Either way, to my eyes this looks like a pre-existing issue that may
>> need some attention but I don't feel like it should block these fixes.
> 
> Yes, I think "fail to notify" is / should be handled by setting
> an error on all listener sockets. It's very much not the job
> for this series.
> 
> Looks like the series did not get ingested by Sashiko fully,
> I kicked off another run locally, so probably won't get to
> apply this today.
> 
> I don't have any "organic" comments :)

FTR I run the AI review locally, with no additional comments.

/P


