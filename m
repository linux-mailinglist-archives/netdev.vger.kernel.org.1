Return-Path: <netdev+bounces-281174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMQrKKMz7mmxrQAAu9opvQ
	(envelope-from <netdev+bounces-281174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 17:47:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F46B46A831
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 17:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F045A30088AE
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91757199920;
	Sun, 26 Apr 2026 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPNbnaMS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4ACBA34
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777218463; cv=none; b=rgGksZJHVRlE+OnK2lYNEEorFmW70RlcVaz12Wq+B9evrrAatmwA2tvdSI3QY4lSuPshDBGS0HijBvZTPXB7e+JJAKNZ/z8zwgm0U0ZFdP33ZKj5wnheMXklgOuftrOYeatZ8jIJmGzU+GK6V36IBzGPjJ33rGQAW1wOHdhGomc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777218463; c=relaxed/simple;
	bh=Z8ND/h3+ES/wNZrZvi73y09iCyM4VBm+jK45SgGki/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3Om0tvciHM0E+hr5wsRp1Om6V6lICWTnOXIxT+afayGA4B8uFrQB6ZdZMdfBHSA+YzWf6wz3NQMUWZA+cwdiAjNj7xoRX3gkCUeZyikFf35kSUdpBuo0J9/T+UgljmoHfO9Dddch6C9eefWmvKbVUklkMzBAYvFih5xku+ufN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPNbnaMS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d03db7f87so6396470f8f.3
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777218460; x=1777823260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osxlukL4bWVcmJyHumd7QEicrKO6SRTBll/XBrGVUeg=;
        b=OPNbnaMS3FewENQ8iAR2iWDp5AmASnYBu+R6DtlU8L14VKkUbuZx2J2St1ZnQ+XrU8
         fYHkJyEPnLhtIgDg6sh9d4x7RsNdpWm6BGL09S0v9B74qWIK+CSEpLyq5bp/pcG8dWh3
         xRe3fAEKiynwp7pwmSE/QnS3PMcWIqmDoL10E7HxodfKuvztb67X7YfAprMEInDzOgbb
         0/gfF9E9OOwmN7GhJqMyLvTS61EwUGpo0mXxMAKeskmBT2sWN5oFUF7OFxscKZy1nLJI
         nMEDivSfEBGw36VVNYimKdvCFZw7LMl/xPMwNXGBw92aXzI9ueKOwh2rvxzJyanx4U94
         SyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777218460; x=1777823260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osxlukL4bWVcmJyHumd7QEicrKO6SRTBll/XBrGVUeg=;
        b=BmXMlpZufltXMNeZVBaIgPHUVah5Olcc2l2N5f1jQ1krtnlaE3QanLrMG7cGUacuLH
         6REycYrNGmx5lIiEIbjk5MRsflahN5KWWuwGt49oEeg3oDZ2eXiLBj1vSdLiOZtmojcf
         1jMicWEuTX5Rz6Fu0ZlqpZI3ur/3q+JUttmJUhpqQbJoGu4MJNas+SfUSPqTvNp12pIB
         5QV3Q6dEyFnRYDgFinebhgisCNfKfaLyBKTZ42hOaQUwIMYqyqUxnZpszxAuwhe3qBzF
         w5kvsE/LQV62GF3A6iqGf0Qyb/hgcLnSnqy3rPS3yRY1MrMLfcPLrQj3VwQI7fQV+em0
         BAqA==
X-Forwarded-Encrypted: i=1; AFNElJ+qmOU2n0HDS+uFPTHtgQcC0R1Ij3BCKFW/sQu+VSIZhq4Rpe8Iu7StqHuLyqFtO5cqm1aPspo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5AcwSsjrl2rr713GZPP5m63ggTSBUpqhfhhSlFzinEvyLHyrz
	aM2xoRjqtC4rtLWakkBFjW4m3ExmzrnC7z/fzxDl/6MXJI5WPXYd01uX
X-Gm-Gg: AeBDievHgs/FLj38jrmpad1XRIOdYKSkh4aT54/5t954osdDQWCwkE5awab96AaUum2
	hjjvw2jrg5Yge+zzTV3pxGWvB/7ssULsizLHrJxivBdnknBLhtj0ctnXsDqW68oRB+Wb6PoAQT0
	crCIpjv++dM/ZiCw6Qb92Kvj/f8SG3wAxFkGMuwEKWjrtYhPCRTb/aFqGqe8tBGwUSQgacIXzKU
	Fk9C98jVC/NQVV506sh2LJ/WeshZL0y5mVZbF95eT3fOMZCTLCK8oshbOIM6gg5FCp4o7bIUc75
	WM+E/h9pwiJV6X5Ne0Va45Eebf9RbcVcMRVpfd7D3VdlvgbLS9gD4CeWDqMNsFfV6Wmq0qLPtWM
	3FPGKOiImmLmewpQN2rlj7/r6M77BQR/H6ipXTMfBQSeM8BYvFDicbn901boayHoH+1IVZx8d+q
	6dsGN3ef+XyZydQyVdQ9xJe3/HhP71Whv2u4SNeLvofjJI9P6YWh/e3j0M/jg8VWboIzk0VERdZ
	F9tL2Gwsjru1SMvoBITONSKzsA=
X-Received: by 2002:a05:6000:184b:b0:43d:775b:c9bd with SMTP id ffacd0b85a97d-43fe3db3a23mr60433680f8f.10.1777218460059;
        Sun, 26 Apr 2026 08:47:40 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:981b:c965:f5e2:f75f? ([2a02:a03f:a75e:9a00:981b:c965:f5e2:f75f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412e36ff8bsm25455665f8f.26.2026.04.26.08.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 08:47:39 -0700 (PDT)
Message-ID: <dca69fa4-2284-4251-a569-8b26ab9fca07@gmail.com>
Date: Sun, 26 Apr 2026 17:47:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: Implement limits on extension header parsing
To: Ido Schimmel <idosch@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>,
 tom@herbertland.com
Cc: kuba@kernel.org, edumazet@google.com, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, pabeni@redhat.com, netdev@vger.kernel.org
References: <20260425075521.736328-1-daniel@iogearbox.net>
 <b50025ba-c59d-4575-a790-fdaf0a48961d@gmail.com>
 <90c7de29-2641-413d-9d5f-5eb323cf875c@iogearbox.net>
 <20260426131714.GA180947@shredder>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260426131714.GA180947@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1F46B46A831
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-281174-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]

On 4/26/26 15:17, Ido Schimmel wrote:
> On Sun, Apr 26, 2026 at 12:38:31PM +0200, Daniel Borkmann wrote:
>> On 4/25/26 12:19 PM, Justin Iurman wrote:
>>> I've given it a lot of thought. I came to the conclusion that we
>>> should use a hard-coded value here as well (just like we did for
>>> 076b8cad77aa, with the same logic), not a sysctl. IMO, the main
>>> reason is that it provides as is a suitable security fix to be
>>> backported, i.e., the max value is the max number of EHs allowed by
>>> RFC 8200, Section 4.1. Also, we remain consistent with
>>> draft-iurman-6man-eh-occurrences (I think Tom is about to send a
>>> revision of the series soon for net-next). What this series does is
>>> not only enforcing ordering, but also verifying the specific number
>>> of occurrences for each type of Extension Header. Which is totally
>>> compatible with what this patch does, i.e., limiting the total
>>> number of Extension Headers (regardless of their types) to 8. I
>>> guess what I'm trying to say is that it seems like a good
>>> plan/compromise and that the aforementioned series would build
>>> perfectly on top of this fix.
>>
>> Initially, I had a hard-coded constant (when it was still 32), but Eric's comment
>> was to rather go with a sysctl, such that if someone unexpectedly complains, then
>> there is still a chance for that person to fix it up via sysctl without having to
>> rebuild the kernel. I'm okay either way, but presumably given we're now being more
>> "aggressive" into lowering the default to 8 rather than 32 then having such a fall-
>> back is probably better.
> 
> I also think that 32 without a sysctl knob is fine (just so that we have
> some upper bound), but if we go with a sysctl then let's make sure that
> it's compatible with Tom's series [1] (I assume he is going to send a
> new version).
> 
> AFAICT it's possible to create conflicting configuration with both
> sysctls (e.g., "enforce_ext_hdr_order" is set to 1 and
> "max_ext_hdrs_number" configured to less than 8). The documentation
> should make the relation between both sysctls clear to users. It can
> also mention that "max_ext_hdrs_number" might be useful when users are
> forced to turn "enforce_ext_hdr_order" off when dealing with hosts that
> send extension headers in an unexpected order. That way, they still have
> an upper bound on the maximum number of extension headers.
> 
> [1] https://lore.kernel.org/netdev/20260314175124.47010-1-tom@herbertland.com/

Ido, Daniel,

As I said, my vote would definitely go to the solution without a sysctl 
for the very reason Ido mentioned. Note that an upper bound of 32 is 
kind of unrealistic, although super (SUPER!) safe. Sending more than 8 
Extension Headers (assuming a different type for each) is not standard 
behavior and would make you non-RFC-compliant anyway. But I'm happy with 
32, as long as we don't define a sysctl for that.

