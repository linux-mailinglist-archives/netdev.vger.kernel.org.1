Return-Path: <netdev+bounces-291242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL06Igv3E2puHwcAu9opvQ
	(envelope-from <netdev+bounces-291242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:15:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6125C6FDC
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B502301CC79
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 07:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF1B3C278A;
	Mon, 25 May 2026 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si9lDo+W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6B83C2785
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693304; cv=pass; b=Iepn4ZqrhLwXuqDoiVp6wa+1J/D0CY6zmOiSjl/u/gI5cd4nMbHq0WDchgW/1xcTk2Ixla/OvIiMUp3U7APAMQWfNh008xHax+tDJ2VZZpVPCIMxg7HubUScBusmKB7GS2ZMWU3NqYLL2MigeS2hHrXvyoMyCipahZ2dNRtLgaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693304; c=relaxed/simple;
	bh=la7QyJ5XOhyu7K1EQeqjdxLc9dFzbz+NwVQ2z3DYqNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jszk6aGp3Kk6LUeJ0lUPCUbKSPbXFjpV0iwul+WVXmkucl1f6K1hTEsLXZSlHGqhD8WrCd/4M9FGqAS/mw7EBOrsZW7zU1njuxYTYJE6Yi05J57UMFa9amL3jDnqgjTuzyzKdGqgf6W33IEXJKO3KjSpAm5QTwzsi+W0OKduErw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=si9lDo+W; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso7507453f8f.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 00:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779693300; cv=none;
        d=google.com; s=arc-20240605;
        b=USHiNp3j8zRK73hOBcNWHSg+djCqsAUx1kp4OOMarqHK5ZOXOm3NGOGg35kFbQtkN6
         kuluQcJKxJ5hlUGMCSu5b8QClieqRvCw1OwZSSMfIMoQaE9qULK9sz0FlD8msh9LT3Qh
         IcP4wVfmO0D0rvXOWqbWiYf+1eQ70wbKFt1RbPNU9XD9dCxsdljE2RXQJKhWpyAQD7Pb
         tnWzT/0/OvZ2IaN265QxNN7DgtCT9FCShlIQfVXUBIt/dGhm+0jw0flR5Mqpj5M+2Gjh
         Lu++A72fLgj1c4Dtv3EwFGFXrASlAeWWm03kDJ4La8CXqce7btYJukb98jaST6+XhEsA
         QnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=la7QyJ5XOhyu7K1EQeqjdxLc9dFzbz+NwVQ2z3DYqNM=;
        fh=/yzS9sRp5MtFcFi3oM7BA7BV59aoumIkwvwUJWR7rwk=;
        b=AwetfqptKl/E65rVYAf1yy/LrDjQ07lAb2U302y7VRFY9mRLIt2sw1/nbme74Q5Y2r
         qknhZZMdak4RozS5KNzZA+9j9fUG3+nl27m3Pw8UeVV3kPjSb4OG1eJKT/TQDRblKjhP
         re1Q9avEie5AaJmJqKKZfoMMOYUuff70el9dQkMkS4F2GD1kslQVGiBCwrOeEPXp9+jK
         LMCN9Cb/LBDKbDsD3ism/sDn2Et7PRV8O0YvTM0bxsVOMYzfqqFu4KOftsWBLmrhOQY9
         OcOJnqgLgFTh3tL5XiouqzvzsqFCyJ8Br4rCZZ3HlBzBZeXBqqfbHC8P2KnsM3QcILMY
         rzHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779693300; x=1780298100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=la7QyJ5XOhyu7K1EQeqjdxLc9dFzbz+NwVQ2z3DYqNM=;
        b=si9lDo+Wc1Bq/gULXyWpAKQE+8Kk4D5VAxsxboc7cTTYeR1e4p9ozoGbukpgHJ0SIU
         rKaTzXvemuexHwLfhxU2EYYtjlw+c/yvROApoJ0UbvN+IptLWmd8i/L3TKB2Wq8YwYZU
         9viAv/CWDxQhMkU4KjJWjtDsDM5zPQmvM4Btkm3qvaAnUvpHWhMWRyQI9+dvCwRW8m+s
         hruNoVOyukMNVKa8u4c/vYoM/yPWSGCR0fxtKBDxsmxqUQ/cnxMfP4IKubJbtyy9a7k/
         DLYJvSMv0OlA617bmfHwILBjzEDZOw0yxJiCLU3tSaoEx+s6ATXhPPCv198xajiJb9K1
         EnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693300; x=1780298100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la7QyJ5XOhyu7K1EQeqjdxLc9dFzbz+NwVQ2z3DYqNM=;
        b=M9aRo/hrP7meItkh+va8FN6JOuNYVGc5XNdEpRLCUH4IGSbPtOTXY5xd9owjXENOaH
         7MpwQw1iA1bN1bHoGTrwDbmY4nd/89WJiCVTJ63nZdXpkUQ6g+MDT7JMJhAj3ULWS29o
         6oMK3aJ7dK7rCpV7oLDontoeLI4dFF+syPi0QdGrqflWVMRTGrB2r6IRVsLGBHLDb5zS
         HtoyOGbWL7FX60qbq/GhS6syWtRf6EvwjhxvxiNkEqIfkLp6zmi9Ubdw3rRy2GAmQ+RL
         ri6WgelXSODSuskRtH7b4XIwDwRGD0HVob58lMtyAkD1CyaPVrdI9XANPxIgiy90DP7Q
         vl0w==
X-Forwarded-Encrypted: i=1; AFNElJ97l973CTwPG9wJ7OblvexMVj0xgZB4tR2BvDFkJCaRmRqvE7nMKmkORAjzQi627VXZdOjt3tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV3RhpED8lehXNggb4o4Q3nnWCVUJOAZkuSnW3iOoYYLH7JFmd
	2XuaaQtJHKDB4g5pAeXteVWnnhbvy/NNRXm1EBLZcUAivlr5KXCFTJq1O7L6yS44eZ3i3mjBr69
	i1CJF5TPkZK6/JyuARcG8t7YdyO2AYeg=
X-Gm-Gg: Acq92OFNJixh4SRBFCLJlWPaYfFrw8aUwJiN4xYUY4HPGL3RWV1aEEGKYynDqIJeG/T
	RFZZVmVKir4vTjJwTdrE79jTeiSoDi3Kg8ykY9XBe8ysWOFg7eerF6GhSXToMg3PHce4A88B22x
	5RQqYB1r6tqE4kHsB6WxdwZ8gwJySX0w6HO/kRNb4UV9yVPQPTOdq6hxsw6+G0NnwukpY54DEhb
	0T6t6YFGrOTjVQ7BEUaVDm85DK4PP9iW2xdU8kseOaZG86CWiS3f05RyZFE6PkYYxU1y2DfoDrR
	g+HktTA=
X-Received: by 2002:a05:6000:1867:b0:45e:9433:f301 with SMTP id
 ffacd0b85a97d-45eb38df5f5mr23849069f8f.41.1779693299661; Mon, 25 May 2026
 00:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522154125.121895-1-maoyixie.tju@gmail.com> <20260524155433.GA106863@shredder>
In-Reply-To: <20260524155433.GA106863@shredder>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Mon, 25 May 2026 15:14:48 +0800
X-Gm-Features: AVHnY4LxB11HXzPubfJpPubC5cC6T0FIZfbO7ZWmCXxNgQxOSymauL-QNILhj4k
Message-ID: <CAHPEe=EKkVX0LJ8xic0Six0-M1tKq_TAHuVWxafJ2ic2WcSL1A@mail.gmail.com>
Subject: Re: List iterator used after loop in mlxsw_sp_fid_port_vid_list_add?
To: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291242-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B6125C6FDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ido,

Yes, that is exactly the cancellation. I will send [PATCH net-next]
shortly.

Thanks,
Maoyi

