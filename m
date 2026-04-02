Return-Path: <netdev+bounces-274582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKbzBSmBzmkqoAYAu9opvQ
	(envelope-from <netdev+bounces-274582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:46:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F1B38AC68
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D48E6301AF4D
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C513E9592;
	Thu,  2 Apr 2026 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYNVAt6w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE86030FC2E
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141000; cv=none; b=hMGDj70MJTRfn1DrsmegYyjhyKCmzzVIjyKptUjHyU94DxMts8Kc/IQPDdiTV8hlycYRbwY70LFwJv7qLYa47RFAWU92LaTKmzz2t/7jlUS3goGW3l6i/HCJMYO1d/3tVwk3beqXg4HgkVDLxmHjUmUGT9IK2NQ3oucCZg4S3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141000; c=relaxed/simple;
	bh=+1DtgmBJGYL+AI6qq5AuRnLqe+hKgZDdNkl7qsLrNxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0Q5EYeeEgp7EWk2jSoLye0E2RWI6nXl4NMoVoBx5Q92S/ytDSafC+HwaI727Ezld1F+HLVWvISaTM6lUuxqkwBPPKFqPRCUYOG5sLFEOPljQAQ2/xJa4rSvun5COfiNPLkPrR2T8i47rOSJMjaY+7u5RadcrF5B/ZJ8MfIj8gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYNVAt6w; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4888375f735so8139585e9.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140997; x=1775745797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+1DtgmBJGYL+AI6qq5AuRnLqe+hKgZDdNkl7qsLrNxg=;
        b=ZYNVAt6wUUA9TMrfqgxDS5Nsb0LQtwGgf+LFU9B4Dh+M/j2lWwtnkZRRnMtM/eWqQc
         jNCCNdTBCQI2lQw1SNIGLK5Mp1OtkvoZUHqVzElE0/OorxXNkUEIiffu3zuPI7tNOPjs
         slxKMjzXH2Dga+iJ1AZSy+lppbY96MSHNugB87YFwX498TQjspUJ7gD5bs74drJ7MZpW
         glL9uMmc322W0pZ5NF/wIt/eunR+eaIHvSef+dXi+CRRCzcCUVOCvTLdfzBiefjzQo29
         x07rzer/r+SgTAiyTlntlCDk6tzmYwJTmD9fPe4BZhUOZxhp7yJZtWRDK+/Xqgr842r/
         mfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140997; x=1775745797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1DtgmBJGYL+AI6qq5AuRnLqe+hKgZDdNkl7qsLrNxg=;
        b=IOfCNJQ4G0vh8H8O9v2FanE34CAObVxEJriPZOQCrKKlwYLumAXA8sCulZjCZ7Ckvz
         22STrtmtiViSvqdCDRgdrrFaG8sZU1WmJaBbss1nmy1epP9V0mFySpaWTsSUpuM5YmZX
         wZUi/Us7RP6PlfXN8yRswbw40F2dTcXRwkI0E1TPASnybRBLHpX2ExBWGYzK1nWhI2dn
         hvDOCUNADkIPdrPTpGhsJL3PWaNvdZJKU4Z3cIJGwFsDjZsSbgFc+RvHgpV8YaKgqFlj
         uZg22jJb2XlMG8v1D4mHl5PubjIlEUuFJ9wkdz29+HdNqoai2XMM62r/H/IvSiAjx8q7
         MxLw==
X-Forwarded-Encrypted: i=1; AJvYcCV+zWRmbY6bL6CEnH8nDDDZLocG5k6/BS985DtwfyFM8QU7jrrJm8rg/UsCBo3jpCWPaBZHfeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YylquiL3xCMV+SEgIurFWQI4Ag662rNpvK7+zcHMAJUI6lkcwAP
	sX2eo6NEci9pXLqEWKk8QK7JcsTwxCdx+QnK2sO9Cr5da0DaK7aMAkHT
X-Gm-Gg: ATEYQzx2PHwtEvFBgPbXDCVcBKrrDI6CuO1UbYssX3+WkqAqAEZpNkDmbppPkQeB0IM
	gOmAONewzLjlc9QQf4jHD3otb/0l1CKJ1aay/ZK1KpOrvjnvgCPOqXtGbSKA6UJRQ+SvYxSPJwk
	ORGbwxvUQwQGhOjrqw6Amy1FAqMPTQ067NK82gP21dVYqXecT7WqKXJ+w+hsMQJIpHP9T7phcL1
	P+P/jCksYkSUord5+/uP9xG6e5+Lq3dJBA1CVvn22l1fZgFoi7yaqwzlrI4H4I4VCya17UIvctA
	kpTy4GRfpxx+4cAbMx2aMchvpHlGA7iq5jC2qhXxbHrORhyxC/jOfS9zZ3n2eF/EvRKho6AZDe+
	W74j0eMlHcwxQhghgbtTM31SISIAhkUM2lrjkfmMeMUrYb0H81JP5vZAMZ2Ux6JgHYA+WnEk/iT
	2voSfuz9FsJbZ/+IKD7dxzm1rBX2Rf256rfVB26RY2AvO68mjn2o7cAaVXtmcT7tRDxnF5
X-Received: by 2002:a05:600c:1d16:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-4888359dc45mr133537805e9.20.1775140996932;
        Thu, 02 Apr 2026 07:43:16 -0700 (PDT)
Received: from [10.128.11.51] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a630922sm249922365e9.0.2026.04.02.07.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 07:43:16 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <4ff8ce01-6001-412e-aa70-5ec2961f8c57@gmail.com>
Date: Thu, 2 Apr 2026 15:43:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ppp: update Kconfig help message
To: Qingfang Deng <qingfang.deng@linux.dev>, linux-ppp@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Dianne Skoll <dianne@skoll.ca>,
 Jaco Kroon <jaco@uls.co.za>, James Carlson <carlsonj@workingcode.com>
References: <20260402050053.144250-1-qingfang.deng@linux.dev>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260402050053.144250-1-qingfang.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274582-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94F1B38AC68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I didn't realize there were dead links in the Kconfig help texts.
I've added a check for this to kconfirm and found many more instances!
In most cases, I'm not the right person to be replacing these links;
I'll send out a message soon to the mailing list with what's been
detected. Thanks for the inspiration, Qingfang!

Also, LGTM, so:
Reviewed-by: Julian Braha <julianbraha@gmail.com>

