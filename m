Return-Path: <netdev+bounces-275391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJFUMt8p0WlsGAcAu9opvQ
	(envelope-from <netdev+bounces-275391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:10:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD1739B853
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99EF5300463B
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787CA2DA75C;
	Sat,  4 Apr 2026 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezm48tf4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29668296BDC
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315417; cv=none; b=dmDIH9OUjZ2r/J07QtcIF2f8CuqfZnOblpxcu6KFPGHL1GE+U17diugAErd7HF8yM0FgiaifpWSS3qx3+87KXWL1Ft0MbgFhwnTmd8xeihoTGYbQfe+1UZpIn+ooF5LT1GethA5s74rBUzN+xZWYzaOczfR7xm41XQlc0i+UNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315417; c=relaxed/simple;
	bh=Anq4LDGq5lVtFK+TsNxarTniDdSAlSCXkoSEiP7oYu4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jFa6WFkgeCDpyH5DmfGt1FxM1gZB5DahCbsTjr28A8lHoCN7DiD3uQb4858QKWKVfSOFw8Y+Q3kPx+fFY+JNh0DDVu4mHF2gYsUBliEWsy3Ec+ZTevoxH3hv7hZsmSACEsQPvw0aOq3qPjROAB6jMkzI5N5Jn4j3UR+XNceG3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezm48tf4; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79f855b2575so26280017b3.2
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315415; x=1775920215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/TbcvvItW1iIB+wImdS8Nm5LxtPLoKDDsWDJz1asoA=;
        b=ezm48tf4/iv9tXkcfbW3TSWMem9i4NOmXPKhUgywsQcWRtTkjiHw0L+RCFdXuiy9/o
         +2bYIbXxgZpM9S0miZhgWTWJTwGXJGFIkIHExYMvfpoxs27SJlFxU51XtQGs/Zrplks2
         36yb41tf6q3EqZzhuyx62gWYsAvS6jY28LDWxcWQlrnN/hwRn24ks6X6ueNR6yWzOdMu
         UeXFhQiZiXY3umIS1zDzi5HyOSa/1q2hXCFD35HC3pSgb5mU4MWGMTY34tkMUPic/pz+
         EdCsDYMmL7ytsOJggLOSKJYBqUq1D8wWxLcsrUsEFXOVecd9tr5UfV1ueO1t8GdTKvJh
         ZzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315415; x=1775920215;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/TbcvvItW1iIB+wImdS8Nm5LxtPLoKDDsWDJz1asoA=;
        b=sD7qFwFYiUG7lPoQQS4CJhdCPdN7R41N0CmoRY3EiBqWiEPFcMX0tvtKjJwTUN/M8Y
         eX/Y5MXuOzRsiZxYMqJAdp1+tmEu3mtxunvMO+GjPdAMPjMJqI/etd2JJqOP9wzQaJDO
         nptemCmLytCKkzVJUi5nYvYZXbHU57M5EG87amzcnHf9Jwk7nAJqKR/4WOguiIxsPGHE
         4/CXM8/A+dFUd9xZjf1L2SIHcShqwTR7sOb/Udq4KqG4fzibUodQfzISr/L5zmeUpKA+
         Mc7YLRMruFAeduz089ophuJffsMTA5fB1Z5pk9y3jXB54szL7PzNNJSn//OTRImJ7p0d
         KTTw==
X-Forwarded-Encrypted: i=1; AJvYcCUWtsHbFZeUSuj3w30xAwZO9hcIpmsiQ7f7pN+CGr6v/aETZQdLccS3PIQe/+pxXd/doLYe7Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtfkqPqUryY5dMjbEwzrWY6AyOPLP2TItPE7SpryMrtN9DsUb
	+JIqaz69GE8ojkWZl1Y5WuUXtjGaGsub7KNBvpssWVmvzy5BuPxHYwLo
X-Gm-Gg: AeBDieuIk4eIXdAyea5Yk+QlEh/ydhKCxTViZFiu69/gdOI7U8y8CIsJbZac4cr2jDS
	+7HDryYzZPL7c9hd5wyj3KDuNg0YV4qGFpOiRZuY9lMokSz3V87Oq5PP1JcIPdhGC7uutfS4u7R
	xWpNXNiAxbLbLUP9Z2WXsy5H27MhxVRUw6K/NgBZXbCkGWvXecRNtyPX3uXaVpLUIhtfxf5DWbZ
	GJrdu98CQybGz5c+w8w8hBlatxjDOY9ZmpUqQga/bTgTHwowF4d3VFUbxqDcMa+2YraN3ONOg/c
	AqaJ+2rc1PHgVT0lCAEZltgoWR5rK9+f491SkxaTY2k2H6INlCLgh2trR4tFLq7XVDiD1ljBHM3
	7tTmGt9+yktZZVdVvFo6ZsAte33/NtW4wcCdbleoac4EFW/u1RTdulOSUutCpy/WQrjDR0YKO60
	2Yjh6NaTsll8XaL4RV5o3iMl6t20L7yhoR9lJa7WFBG3K5VqEw85s1bT0ccbsUlUY2NyHYQ7+Pv
	6GO
X-Received: by 2002:a05:690c:c513:b0:79d:d23b:4c32 with SMTP id 00721157ae682-7a4d35d5cf9mr69352567b3.1.1775315415094;
        Sat, 04 Apr 2026 08:10:15 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a3712ecc53sm32578907b3.44.2026.04.04.08.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:10:14 -0700 (PDT)
Date: Sat, 04 Apr 2026 11:10:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch, 
 linux-kernel@vger.kernel.org, 
 willemb@google.com, 
 Joe Damato <joe@dama.to>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3ad8f36da2a1f@gmail.com>
In-Reply-To: <20260403233240.178948-4-joe@dama.to>
References: <20260403233240.178948-1-joe@dama.to>
 <20260403233240.178948-4-joe@dama.to>
Subject: Re: [net-next v2 3/3] selftests/net: Test PACKET_AUXDATA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275391-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AD1739B853
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Joe Damato wrote:
> Extend the packet socket selftest, adding a recvmsg path, to test
> PACKET_AUXDATA. Check basic attributes of tpacket_auxdata.
> 
> Signed-off-by: Joe Damato <joe@dama.to>

> @@ -322,8 +376,11 @@ static void parse_opts(int argc, char **argv)
>  {
>  	int c;
>  
> -	while ((c = getopt(argc, argv, "bcCdDgl:qt:vV")) != -1) {
> +	while ((c = getopt(argc, argv, "abcCdDgl:qt:vV")) != -1) {
>  		switch (c) {
> +		case 'a':
> +			cfg_aux_data = true;
> +			break;

These are intended as independent test cases: test_auxdata,
test_drops. By using flags the flags can be combined. Are all
combinations of flags expected to work? Else maybe we should instead
have a -T "test_name", or so, to keep them mutually exclusive and
easy to reason about.

Or just a test that two flags are not set at the same time.


