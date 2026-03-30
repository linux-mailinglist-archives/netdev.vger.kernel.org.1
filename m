Return-Path: <netdev+bounces-273090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCehOhcvymkA6AUAu9opvQ
	(envelope-from <netdev+bounces-273090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:06:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B27C3356DD3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6301300DD41
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCA43ACA5A;
	Mon, 30 Mar 2026 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMTi7wjC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TG8M4INq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1123AC0F5
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857976; cv=none; b=iQmxGd2ZPgTA8WxPKM/TzokhyMDkc/5G4TTe8Drpzy7ct6wbxNJhjkxerQwV45lQOpgKZDgAO74mq8fxsZPTWyt2DXKkj9EEJunvyUJwGrDG7Im4hLeRmvadDfBujucKA3NVQdm9wWjua3dFxK+Ec1hQorskY2/EDOUBQxYw23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857976; c=relaxed/simple;
	bh=kkfD2P1hm0+ZubT4vEQkzecPsPm6oKT2oHVK9d+50Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arbcnKOJPZO2vg1okEW8Atfumh1sKyHNytykGo7y5Ledp9hNawS225rTj92JpaiKHWn7WgyS2NZPrqZuYeegY22j3zUC5MmnE5DL7vdIxp1C40sApahmfaSxvTyJ/jCD5yBsFsSQrkrO2vuqFJag9G2DUZV5kJ8AqeK/swKsGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMTi7wjC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TG8M4INq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774857974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7T4GSdfs4U7ZrYueyx37xTT6R+FzPto57XBQfWOXzFU=;
	b=IMTi7wjCPl/oK/lh0qfop5ywm1g97usm+xRRRpAMFDWSOrUgreHFl1M37oTWXKoDTBcD/G
	fPIVbPmqSuekfI/a9Ag9CNuq+mXwDhBKck7FpdY76q4uMgXYuF2oXsm156CzGzIFB9KKbO
	xNC+9D+yuSM5Kr6Fph/Wu+Ww9jxnaiw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-5Ed-PRPhMiCS-5hS_eIbvA-1; Mon, 30 Mar 2026 04:06:12 -0400
X-MC-Unique: 5Ed-PRPhMiCS-5hS_eIbvA-1
X-Mimecast-MFC-AGG-ID: 5Ed-PRPhMiCS-5hS_eIbvA_1774857971
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso56089135e9.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 01:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774857971; x=1775462771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7T4GSdfs4U7ZrYueyx37xTT6R+FzPto57XBQfWOXzFU=;
        b=TG8M4INqEZHAsE3RdcO+Vtn9yemH5EW201gyCulmGqzGATQIvjbVDIT0tESm9A9c0e
         ftAMTsTWzPa1YakdzCPHWRQ07YTjOLqTEgqXtqutsnihv1sm2mc0DbXO6dSJh+KPelPB
         Uw9zHgsOsIIjVzGFZW9IUVZAEPoCaJ49zssl9vRPMBGOAva6sB/7HKF/PSim1RYvtQnt
         zJFJkypmHGdJnlu92cWfBksUbl2FiY7JYsbd7k7x3WmTpeohoDlIdUeNCnYy12WWgq4q
         WxNV8S9q6KZDNSOmrzyCQ+TGc5S4g6z3oftUg5cJgpmQyx3OLQxKP/clcpHWgwRXxxP2
         mfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857971; x=1775462771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7T4GSdfs4U7ZrYueyx37xTT6R+FzPto57XBQfWOXzFU=;
        b=VZcZQR9HIVkjsjy3+MVQbtl8/Kze4qnGYLznydc70q8e/LXEy9Q3F1vwoC/j6ZZlHP
         nC6VCrs8M29uxMDTrkXQ5qAsCKu2LIiJfXbkL4UEwzKGkYoK6vUaz/uwFDfQRX/Bwttp
         8VJokOsOcqXwnfcCXhKjwF5H6lsrkiFe7yHM3E76Gpij/7rrLDt2fb/nztfXTRP+7Unq
         0TOt5ddDI1rkG/T2dRhJzTZewMZ95Be3TwTvE7VczFKmJC2X26aURLPHWiPG4Idnp4nH
         CdSYApwvb1G+LFUNbcvlllqyjffZXe6/xRjKddhTsxnz9rcygdoJnpPrfzAOF/iM4LXZ
         QRJA==
X-Forwarded-Encrypted: i=1; AJvYcCXOEOykGyGvjiDLUnvx9ByuxrNN6SfzTU927j/XVWahBPCRtReXNwc38XJasxf7CtEasIeVsY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPFFZOhKgU9QvfJ3Ez/vnKvaW7LzsBmeheZeDfQA0r7yJlq7R
	H3gSMjgbVvRbQO/5ac+bjXN5IjWPtyBMCLdCLBCWt/3CdAucyQQYcTQ7uyQtnjB6xKMiC8lTpFF
	pWwlFruIgqjiGUexDxVaudgLSdFE6i0g4/vOM7GmU4JYw2hFMoKY86zCD8w==
X-Gm-Gg: ATEYQzwXIA1FnleG8PFXnANJQZbZ1ejwVpT6R+7sIAR6j4oTpVFUZwuwZE7Pu0oRnAD
	6PWP0H1Cied/jM0gKdwttG6z+lGSJBRq3xDavqhHSEQSp72Ufj9P5Riew/qwiO9YV29dRz11epQ
	V9WPoXQSHNlMEIB9Lk7Mr2sdZaUY6dbl/5vYER4J8wGww2Jpubafv0zzWdQbT0EgKUdNyAm+Lv2
	ER4WTG72KK/U9JKHzbXdOg04HHIL4kbeRjniXsQr8IadnaBRuDFPV2dNZz+1+LcGQ8w1soxMWWG
	RPObt/F1AolCk2DUR+STHYuStinkKJj9iKFxzCrMyFpw3UTXfsMIeSVSOxghxH14WfjeoW02LC8
	nugDo8wv1RMmXQpg7Pz+qEowVTk9W6ETeAl+nAcB8jcbLzWAJWiMAK7vb
X-Received: by 2002:a05:600c:450a:b0:485:531d:28b9 with SMTP id 5b1f17b1804b1-48727d774e6mr200981595e9.14.1774857971196;
        Mon, 30 Mar 2026 01:06:11 -0700 (PDT)
X-Received: by 2002:a05:600c:450a:b0:485:531d:28b9 with SMTP id 5b1f17b1804b1-48727d774e6mr200980965e9.14.1774857970693;
        Mon, 30 Mar 2026 01:06:10 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722be608bsm392031745e9.0.2026.03.30.01.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 01:06:10 -0700 (PDT)
Message-ID: <cf7128a8-80f2-4d4c-8c68-2c9f386cedb2@redhat.com>
Date: Mon, 30 Mar 2026 10:06:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] selftests/tc-testing: Add netem test case
 exercising loops
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Cc: Victor Nogueira <victor@mojatatu.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 Shuah Khan <shuah@kernel.org>, William Liu <will@willsroot.io>,
 Jakub Kicinski <kuba@kernel.org>, Savino Dicanosa <savy@syst3mfailure.io>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260326181701.308275-1-stephen@networkplumber.org>
 <20260326181701.308275-8-stephen@networkplumber.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260326181701.308275-8-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273090-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu.com:email,networkplumber.org:email]
X-Rspamd-Queue-Id: B27C3356DD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 3/26/26 7:01 PM, Stephen Hemminger wrote:
> From: Victor Nogueira <victor@mojatatu.com>
> 
> Add a netem nested duplicate test case to validate that it won't
> cause an infinite loop
> 
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Apparently the new test does not pass on NIPA:

# not ok 364 8c17 - Test netem's recursive duplicate
# Value doesn't match: bytes: 294 != 196
# Matching against output: {'kind': 'netem', 'handle': '1:', 'root':
True, 'refcnt': 2, 'options': {'limit': 1, 'duplicate': {'duplicate': 1,
'correlation': 0}, 'seed': 6495514880116664183, 'ecn': False, 'gap': 0},
'bytes': 196, 'packets': 2, 'drops': 1, 'overlimits': 0, 'requeues': 0,
'backlog': 0, 'qlen': 0}

It's not clear to me if the causes is this series or the follow-up. I'm
tentatively dropping the latter from PW; let's see how/if TDC is impacted.

/P


