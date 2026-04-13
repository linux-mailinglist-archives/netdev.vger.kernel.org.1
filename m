Return-Path: <netdev+bounces-278088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCywNP/z3GkvYgkAu9opvQ
	(envelope-from <netdev+bounces-278088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:47:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF003ECBDE
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B78630557C6
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EDE3CD8D4;
	Mon, 13 Apr 2026 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eW6U5cNe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="af4QWh/f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14B3CE480
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087700; cv=none; b=eqpntafoEkK48UtEJj1mVsOXWIiWN4Hgi81NOVwLAM2V4jxlIhVhXf8p9FR5XaLJiWZYTanHAKbW90+Lq34Fi4uGyKluChgbCpURDJ1xGworRjLRd/6OLCBOxq0C6Onutukea2eKE9FT7EpOP7miiF9Y4SxJlQr34ufoTLWLatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087700; c=relaxed/simple;
	bh=6J091rsAiUHEa6MeYHP2u/eIOcdWJdLOZN2c5zK3G4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpZ0HNWeIPlAe0hWykdLozWoThz4keFgvMRUx3FFqMfEAaAeFt5JzOSn/D0Z91EuPYkZaqIubCkG4TkX21npqcy/CJp4R7l/jhbB4vM9Ne8JvfGFqf8jwKEOeZsjOv8lRpUFrnZ4qMDxh6fMNLDCZB7iFyrbzZ/+fQU4xPntRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eW6U5cNe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=af4QWh/f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776087695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzkXPd9kyWfE50Lh59h3/IfJjaKK6mMqEemEYMCknmQ=;
	b=eW6U5cNeOoNwXU6z58oBDIT35/AdgwZfEPIzPEjlZ/JaZOLr0hlUs8wHHCXNSzCkx/z/Hd
	5Wn0J5FtyH86uoe4qUqwlSgLWcbImSYHwCfz3WaUmLtY0RdJlbZxOj6yxvk5zB7zI/86oc
	YVPptYDbhjsNeP/alZXjbgfjntzsgSE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-JNqc9esZOc6zml8OBa0HxA-1; Mon, 13 Apr 2026 09:41:33 -0400
X-MC-Unique: JNqc9esZOc6zml8OBa0HxA-1
X-Mimecast-MFC-AGG-ID: JNqc9esZOc6zml8OBa0HxA_1776087692
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d744128b9so1182470f8f.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776087692; x=1776692492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzkXPd9kyWfE50Lh59h3/IfJjaKK6mMqEemEYMCknmQ=;
        b=af4QWh/fQAqxIHlaHxSdH8oozlLXgL9HJos6x1JARUv8vY/5q5+nNIYNKqLA2ihGJ3
         pKxAxjmgzTVoqSHfrU3PrimB875GtN7SFviT+AuLomu9SI73YTvNxcTvd/5KIzCKr4ss
         haSQHHhoJ4JyQZ6JLZdtkKrpbYoN3826khMvfhIhBs+P5MepnEJeCNQh4SJfmiaUhT6l
         J0noR5pgqOkkkt1t4VNNAfJpT/yDnA/ubfm9UCkdf6lOUeGuWhCQc44tLmO7CLmpuSjp
         bvTAfEdHMTg+usxIBQyXVR5uPwqBQBCFKCcczbgfxSHpxA9VBhKf7Wbk+5NsqW2Z1WeL
         ahpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087692; x=1776692492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzkXPd9kyWfE50Lh59h3/IfJjaKK6mMqEemEYMCknmQ=;
        b=ix6Nsp6HGbcr5Y0c6jk5qq3SJB+xh9lABj+I1Q4qQohDliG62uq4K8f9joJfPaZA2E
         YzHA/eYKXSgK3QE02OQAGtuWAY24doKb8vZ+1pkkoxC5pV21Ol3IxW8MCRtQMaSrGge7
         v/JZvkAxcnbjc/3jQ3+3qagUhn/o7lfk4Gfg9IEBCRBgPJ+zC4Gi57i6JNtWbq6bg4PR
         9x02HIYxlw9GgiT6q8T07J7ew+13acYCxMbT1gh1ICYOna56OebekdHJAoUP2wCM0Z2n
         4S3ghfZYUBfMrQRHmAVb6HhE1oorNbVnxOyhvNk6bwhrCIZlctvDApvYvrAAG+gZpphU
         lMQA==
X-Forwarded-Encrypted: i=1; AFNElJ9lkjSvif2LN8d8mbExj5vTvEkKC13W5KLQNjRh8lzrSLnRLdVCrbyl2th4jOsDcnS9D15ORwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx65inYsNk4Ug8tfqByO+xDFKcNpI3/cLAwtCr/fSWEAIc5d4TZ
	HFY324QsK/eqlJ/oZIdoYofrQV+h6xDZbdjNkU5/9MPz5C5G8DOz0122d/kl3tzXIWRTHR7UhuI
	k0PcCQexGnMs0Hb9v3atifI48ybNjAAJQu+jyxAiOoBXXj6NDRhtw5tE+ew==
X-Gm-Gg: AeBDievtVU0Zlnt7j26D2lNuoFUPDvpJnylw/CkGoZKf0f5nuCQJKBGpxcLvvu0EHtS
	tpe2LxxLjKSlRBznh6AZYYXrHMYZ+iRiGW/eKKUK61fK8+mP0sG9UmCQnZ/I+x8mP9E1rLbEbUs
	ACr9FD7H6P5OrGtwbGUKl05K7azv5gwELiO5qP6gMXXTJ8MssNO9tCQpk1bI667g+rW0dhTHqUm
	YZUoReR3lARvtsLEoymdPEQ6SdApxjGXMPPD0rn2+jPmqmorfLWvqps2xlbxxsRq29nhmMMfN6B
	glumCdgpFjhA2GWqg+5/sa21YDkjPfGlMeSzCnsw53jmhz5Msf1WFmi3O1AXwu2obmPwg79y6Q6
	GJl2kie9AcEHlIiefiMZ3i+ZAtkfoZaV1Vu66YGhL+XvkcAjug6ftqNUR
X-Received: by 2002:a05:6000:25c6:b0:43d:7cb5:43a6 with SMTP id ffacd0b85a97d-43d7cb5513amr2973310f8f.2.1776087692282;
        Mon, 13 Apr 2026 06:41:32 -0700 (PDT)
X-Received: by 2002:a05:6000:25c6:b0:43d:7cb5:43a6 with SMTP id ffacd0b85a97d-43d7cb5513amr2973255f8f.2.1776087691813;
        Mon, 13 Apr 2026 06:41:31 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6f4bf2b4sm17467514f8f.20.2026.04.13.06.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 06:41:31 -0700 (PDT)
Message-ID: <580f7972-56d5-4968-9dcc-32adc31e0673@redhat.com>
Date: Mon, 13 Apr 2026 15:41:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth-next 2026-04-13
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20260413132247.320961-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413132247.320961-1-luiz.dentz@gmail.com>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org];
	TAGGED_FROM(0.00)[bounces-278088-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 3AF003ECBDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 3:22 PM, Luiz Augusto von Dentz wrote:
> The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7:
> 
>   tools: ynl: tests: fix leading space on Makefile target (2026-04-09 20:41:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-04-13
> 
> for you to fetch changes up to c347ca17d62a32c25564fee0ca3a2a7bc2d5fd6f:
> 
>   Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling (2026-04-13 09:19:42 -0400)
> 
> ----------------------------------------------------------------
> bluetooth-next pull request for net-next:

Net-next is closed for the merge window. I guess Jakub could still
consider merging this, but unless you want it very, very badly, I hope
it can just be postponed, as the PW queue is already long.

Thanks,

/P


