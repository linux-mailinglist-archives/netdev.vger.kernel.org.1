Return-Path: <netdev+bounces-284920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDZ1K/1e+2lgaQMAu9opvQ
	(envelope-from <netdev+bounces-284920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:32:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCD74DD45C
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E865D3009170
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFAA481A87;
	Wed,  6 May 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5AwRLjG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQduzks/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED048AE0E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081447; cv=none; b=aLqMubEUifoIPGxkWJeOclndW12EpiBX+V1Wyp/TazSAidKj83hgJaWL8fHc2C8StsL5Xsx7qM5oOpUCoNKaW/47mL1MVIlHTcfuXexYBkjKjKH5Hiydos6QxLvI2v2XASF+7MqYTNLl5PhKDaQRLDJBeB/PX/7kw1MEhsYKvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081447; c=relaxed/simple;
	bh=+CVOJ1B8PW2INcgWflXAEelcpfaLxfm0F4gfkFsTUVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8HMOsLsiSTxKzFKOVvO5l5BfBBdHKxAyxDYZJvyTL5CYPJRZUTry455eLsh6JXPrgcDPZ5Q+3QG0BE+qsxCWTFlL3PAqPuu/QTaRKXPMI40PA+DgYNUioy7guI/IqiR6cY3kYZi3sWKSNmoNuBnDhwTHlix7edjSIBpvyUnwcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5AwRLjG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQduzks/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778081441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CVOJ1B8PW2INcgWflXAEelcpfaLxfm0F4gfkFsTUVc=;
	b=i5AwRLjGWP3hw96aGCujhSYWGReQ1YI0xCY2x061n2bEpfbAljEcceAQnivKFty4yFv/Lv
	2J/BUNmGtz5/Ei692yf4rMCVXs2lb4upUjorL25PWRwmH/blRRv/RAWTabaFALsFlJhdH0
	hFY0nBYJjFfx0rUxdb4fbwBdZpMK11A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-BYAFH3qQPE2REp2wfdXKgg-1; Wed, 06 May 2026 11:30:39 -0400
X-MC-Unique: BYAFH3qQPE2REp2wfdXKgg-1
X-Mimecast-MFC-AGG-ID: BYAFH3qQPE2REp2wfdXKgg_1778081435
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44a122a5128so3965643f8f.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 08:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778081435; x=1778686235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+CVOJ1B8PW2INcgWflXAEelcpfaLxfm0F4gfkFsTUVc=;
        b=IQduzks/Aa3aQaPzCE80LHVAZPXvbZTwM/vpj/hMvQmTU6swShunYWjcxZybpFm+dI
         mE7jomw6t1SCKfSjVjxrdJ45E2HixtJ+lNwVP4uxZ1RiBUnLjVXfmyKNaE37q7BlikTh
         sS06jcmPZJgGAdPIWdSPSGccsRSGzoDMM9coq0IeWfbibDYoD19+T8PkQcJgk+afAjAf
         JdxUDfvFc0ew+fGGFCiejhqcu7TU5uKPuM818JId9SMJ5Rshlsfb8zgXX7QdAAVTnCKC
         N1gefwEztcOrXNjt3jCnfRKy/AkumanO3wxTPvwniDtU++5CIbGZbvYiuA8/wgiuQHua
         GwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081435; x=1778686235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CVOJ1B8PW2INcgWflXAEelcpfaLxfm0F4gfkFsTUVc=;
        b=lBNesapFPWir+AHcVP7BgF/wSRyalJxbPQE4KmD9ezpegG54z+YyOjCuXcfbLQGe2o
         0/CMMSEsZHUM4O+cvCqQJbfWdPKrk0rCYKLOz2BYAAIwLnxngFOl3CWphZs3MTiaFtd/
         ntijl6R3x4kqGMOrEdfsGqTlFlHQ1DW3a4N0I+g8RWa2s6gW5eco8ooQlck7bVbtFOYE
         cVKxxH1rHKCDnrUtmRHwCJkD3JFSIneKyRLY9BPF0FfuzDrQJA9PC8J02pJPjHh/cFWC
         O/DDFq6PUhHjnsytW6s/Wn36xi4p42/Cv+IUYHDPrPT6ekRsTW2H0jc2QoMIR6yxW5sx
         KteA==
X-Gm-Message-State: AOJu0YxtK+yFYtINOtuNP7RAPAhuCEp1UVAjfDRJ4Jt5DQKwfzKBmuZ5
	bGa5NyXCqU/1NGFwIDpCfVdebyt84RQ32ms29oJ+GUaqFyurxJkvYZqbd88PBslnBnUukjha1ld
	HKX01C9R/qQZb/NNKqUbD1EcjO3XReyJdbu9CXBs4C3B9H8BCkwbqBdQBJg==
X-Gm-Gg: AeBDietmKJPR/RuVI48PZ0V8t/RckEr299stv/2tNcy1HgHoTdOd2YMaKOawSxU94Z+
	h9lDpBrhG3D4EWkQXiVahIOXegpcAk6QoCmWqvQTJzYSL/2DCt8LGjYISnz2sfe1jBYASa5Bwjc
	M01rspnH2R9Mn1ll3mdcD8YK1s9p/5/jQxlEoffIaX1DWaDshssnWCATIqTlFSP4R2hwhk3pgG7
	k6NV+S3RdPIEtmQ++w6VZP+VL1tDZ3pfebrE7crMBqrt4pVJ9HXBfw3SCngWNUJv3zE+OYJAW2I
	87KAeoy/tgcEkgOuYwxdpY1z+YwYbHUgKfyw9j8VQoYw3zc/a6XXDVgjfAwlGYJkkIzrKoaeGAF
	PHNk8C+NA/hecbxb9vvGSo6lgeAAKcXHK3nhIYIZfKnaRCcZ60OzJpLlItrZxqiWy5NQ=
X-Received: by 2002:a05:600c:4f53:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-48e51f4456cmr67008425e9.20.1778081434826;
        Wed, 06 May 2026 08:30:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4f53:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-48e51f4456cmr67007475e9.20.1778081434293;
        Wed, 06 May 2026 08:30:34 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5311f891sm31160105e9.4.2026.05.06.08.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 08:30:33 -0700 (PDT)
Message-ID: <ae14591f-f93e-4947-b3d4-af4c441d8229@redhat.com>
Date: Wed, 6 May 2026 17:30:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 01/12] net: shaper: drop redundant xa_lock()
 bracketing
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20260506000628.1501691-1-kuba@kernel.org>
 <20260506000628.1501691-2-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260506000628.1501691-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0CCD74DD45C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284920-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 5/6/26 2:06 AM, Jakub Kicinski wrote:
> The shaper insertion code is written in a way that suggests that
> perhaps it was expecting readers to be fenced off by xa_lock.

FTR, the code was shaped (pun intended :) that way to avoid acquiring
multiple times the xa_lock when not needed. Sort of evil early optimization.

/P


