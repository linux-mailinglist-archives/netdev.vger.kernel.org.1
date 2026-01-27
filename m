Return-Path: <netdev+bounces-253775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHNXIBWJeGmqqwEAu9opvQ
	(envelope-from <netdev+bounces-253775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:44:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D871091F20
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CC09302A50B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFEA2E0923;
	Tue, 27 Jan 2026 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IawBPD25";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrqF3LPp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13C233D9E
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506855; cv=none; b=p7qLaUcoi7S9IJbjsNWMAvETAB5S6HPivu6T2rR2ex3z1UlGiKx8e9cUQP9cfTzkKkawxbHADXYjsaVR8AZ2QsARsJvPShY7ccBk5vLQrBtqjcajUobx8BJdTZKVp4hgnp7lwdJIwcmfiV8dY6wsAHCCbiyTYknuPmc0Kz3EivY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506855; c=relaxed/simple;
	bh=TaCylpJ3oBWXtsgydAsq+xnzjouw/VNwJPzJMQjLhvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I47oot6QYMze7uk8IoRJIARRYTLFDye8V4kP+G8xPZ+Xr9qgKDsdLQiUWWaGvr2s7/zHlcR/uDBOd1+LOfTvTRvSbqWwAUZ1uvJzqAaNRFWG9wnh1jLxGGits7a2zafZHjZLMrlB0sQENhk44x3bOfarOYoQeZiEvY6lDM61+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IawBPD25; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrqF3LPp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769506853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaCylpJ3oBWXtsgydAsq+xnzjouw/VNwJPzJMQjLhvw=;
	b=IawBPD25HogvllBbfPz99Crh6l0THwq9DQR3lSowYELdWhx6VRjYePxP0jj7jcMtwg+tp+
	+fwPrhkutcmfmRnyzn9pDjOq42mx+AJi2s7Hbzab0v0boSBiERrQ1dJ5tRfp8wbP4vVZeT
	JVihEJ0sArgQ+UYQJy1uEmHdbS39XgQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-pZgzvdw8NhOb52xfT2EyKw-1; Tue, 27 Jan 2026 04:40:49 -0500
X-MC-Unique: pZgzvdw8NhOb52xfT2EyKw-1
X-Mimecast-MFC-AGG-ID: pZgzvdw8NhOb52xfT2EyKw_1769506849
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48066dbd873so4207065e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 01:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769506848; x=1770111648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaCylpJ3oBWXtsgydAsq+xnzjouw/VNwJPzJMQjLhvw=;
        b=FrqF3LPpcdy1gCE3UdRyAbioJMVggmdXCSTWmSbOUMFya2p1MRHsCTGKPMaFGGG9DW
         VkNy90BaXKKLYQGfwVTF+lHad4Zzt2bRwOGKYYFZjdFzJyLY5VAtoa3yv9p6ftHlL9Z4
         VIqOJ7c/LyJ1xXgdVVg4DppxVdujph2evebKJTugm0n3hlGHKUaNxJst48EKTWoG1HYq
         l9aN93bszOtE2ujw7J6D44xR7iQ8D3yUFGisLLKhJc3aQZVcs/R5Awnx/QeXIfLRlg/a
         7LD4x4eWGdC1TffcwE4nJnAy5MepX0bxEEOlh46LIVpl9gQtEVbpCtjAv103Gy4rm8nc
         WvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769506848; x=1770111648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TaCylpJ3oBWXtsgydAsq+xnzjouw/VNwJPzJMQjLhvw=;
        b=GBcZVIxIR0lszblhvO5p0sAXyhfAVdc8KOpDJg7sifUQGZdAHFmRWJXrKK0PVepDYE
         Gm41h9Z1R9hGoGwPT5MOrisMzyMeG4UhFOEfFU1ek0lh5HHHok8B2Vbr+N3ZCfpqEMQx
         4spOlT8QWCMhmnjpU30r4ZXhxhtSiuHhbgW3l04AC1GYq/MwqeJWGnoV4/Um6XzxYoHB
         ssTclgq90a5KGtnr44ER4BDutHp/N2cHatKf0XzSAPL3fav2pnZPyUuMLU+2uKYadBV7
         X5/Yf7mQzdtrAffsa+w+3All/rwZiaDcouWuABS4U3qEEzpIz8pt4oeeD0BUwrQtHMrX
         /Ayg==
X-Forwarded-Encrypted: i=1; AJvYcCWE45gETwnlJ6aJ1Bm+YGOmxwokpa4EVoprpeH1pb7ADKV7jh6ff5lhEyUjLuALC+bG8r9t6+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT42o3LkWYEoSNUQw7URjVoxGorcVeosMp46LRQ0gxyQfCD2TB
	HVMF6NejKP83bNCSdvGfQn0vzLEXRMpd8gSvnSrRg7m/kMe3rfdBHGpw26JNZFW+8Lk4UIONEen
	1TB7CWYOzWaQizx6ruEKwFXYuLPXGQIEoPcEcMmEPEq/KIooSch3+i5BH1A==
X-Gm-Gg: AZuq6aLTYcuV3Kw8VdkbwuaYvgYNLq0gnogtlOtuIANXvQyjGVojI3MdfC8j2LTr9Ge
	GbEpH5s0tp5x8ZwsQJ9krD8uDJHbM8aT5yQd28L71cEeZp4fDwAZ/AnEaSNXujl0mnxgyPWP8nD
	zxMFRl/HMPnKDGXxZlVxKVoC6BXz1W68YzldD+J6KP0EY8P1CcCBiEEf7VgrFgyIQavhhANruNS
	1ohToy76apnZ1KT626brKyRw7BMcOdaBXHDu0XcUVnlpJezsKW9s9TbvOLbug+WblsRYwittXYb
	nsmWuXKkGEfcCqRWHucvs4LG48Z28HikxogX8oN5WhpX1CBM35j+Yp9Xn/UV8FNK6xgxlCQp6c9
	AeHeF305dDXDR
X-Received: by 2002:a05:600c:450b:b0:471:114e:5894 with SMTP id 5b1f17b1804b1-48069c9620emr13219575e9.25.1769506848578;
        Tue, 27 Jan 2026 01:40:48 -0800 (PST)
X-Received: by 2002:a05:600c:450b:b0:471:114e:5894 with SMTP id 5b1f17b1804b1-48069c9620emr13219155e9.25.1769506848117;
        Tue, 27 Jan 2026 01:40:48 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d3ae17esm130747395e9.0.2026.01.27.01.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 01:40:47 -0800 (PST)
Message-ID: <bbe37fa4-aa44-4200-bd97-075772498485@redhat.com>
Date: Tue, 27 Jan 2026 10:40:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] doc/netlink: nftables: Add getcompat operation
To: "Remy D. Farley" <one-d-wide@protonmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org
References: <20260121184621.198537-1-one-d-wide@protonmail.com>
 <20260121184621.198537-6-one-d-wide@protonmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260121184621.198537-6-one-d-wide@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
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
	FREEMAIL_TO(0.00)[protonmail.com,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253775-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D871091F20
X-Rspamd-Action: no action

On 1/21/26 7:47 PM, Remy D. Farley wrote:
> Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>

Some (even minimal) description is needed in every change.

Thanks,

Paolo


