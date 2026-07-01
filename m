Return-Path: <netdev+bounces-303436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u/D9AblzRGoavAoAu9opvQ
	(envelope-from <netdev+bounces-303436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 03:56:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 694DD6E9229
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 03:56:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=d3h6nlxM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303436-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303436-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F8383023051
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 01:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E343612F6;
	Wed,  1 Jul 2026 01:56:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858936165C
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 01:56:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870965; cv=none; b=VGEx6dOdZUEK2c2MSCwcjvRaX/oi1walauQL/cLhqz7TCICYbtTXaX4fxUZ28QnBIkn4zwfgIeCUNumyQcI+gFfHe6oSSOX0whVcycQR96ZcIej9YV/AgEezmbGXVOIYC+2SdgptX1MyQwj4xbtW7TbmtZXTDAP07MqeYbuQpxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870965; c=relaxed/simple;
	bh=wM3CsmGX0nl8zMwGMg+pS5spCKJaoaeM4Fd9xLr4ghY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slii+eUAEXlqmGQ5NTYM6cYap/Ff2tbs7JnbVefoyhKK821GW3Mq9shmtUrL6H03d9E9pLPvqhpRlKYZHrZaRWdFBYIf2SycQGTcSIYWgehNRAbNMGc++/J2DSZTPLz2K/S1z5Frh9NUrSunIMpzc7Sdp3QUODWrXjot669zi7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=d3h6nlxM; arc=none smtp.client-ip=74.125.82.42
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-139f1dfc9faso241171c88.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782870963; x=1783475763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9m3T4XVAP21TyUbvDobhhT/cz5cQL1P/yVuBMnJiUlo=;
        b=d3h6nlxMLizlJVFRteq18JV7fK4S4K4l06QBUEHhWxKBHto2XIlawHAIOuhTdcVrfq
         85Da+1xD6DHRlFZC1hYeEJEIoSPzzHN5YD3OeKBP4J+DHwP0aaRsb8cHP6EmS5tqNGug
         gyDv/jEtOOmW1OTZ3ulfzBq+D36XusjT23YDSQ7x8u+b5No50SNPM3tshzsbQP5YuG0S
         jKTvhkSK2ysGu9rSvjkVXP792gr/0vn3Ubwwl1nM6cPh9g1twXbMKMbsG1h5Kkb3Ew2H
         8/axLCiPoXMwRdllwpK0lWWqRYcmbtDkQt1UKBsHOYP61K3ZNfE5VE5qIwx5ZcRYaZQu
         EsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782870963; x=1783475763;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9m3T4XVAP21TyUbvDobhhT/cz5cQL1P/yVuBMnJiUlo=;
        b=nlDUP0OtNmEpDu70uNm5bYUe9ueZEgIZ4vXqpEarvTn4SEPztXQ+s+wbi4MKuzisZz
         67vbOd0rC56/PrCrpdtyrHNnxV+f8hQGcpgJVtZjpbtWJLqnYt0I0qi35XcvSnnxT/jv
         gqZVPRFRjYdsFnqGCmwfshUfDgHnMIVw4hIk8N2a1j+NPY2WvgKwXNA+ZtBU/dLKpiO5
         kjsSFsdTO9qwgVbgKjXieh1ZgRJ6MzgJL0MIEJvR160erJ1CcVpCu3T9rvtEDvTDr8nh
         tBUF4eTrPfUHp1IWgUzHgwvcuOX4d07epKexHVddcPdclehpiTF46yE7YESBLRVlKdtU
         Nm/g==
X-Forwarded-Encrypted: i=1; AFNElJ9U76FTYTO092LpHXdvM4nWRsB7LCgxbN9Qh4kjEmk9PkiQ87r/x54nzGdnNy6TYbJmYzJ7fxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOn4N5G1O6rJxASfNNnJM83VhkqDtsyeY6UjKFvLpKLmMkvp6A
	KUx5ywTRvtzRLtzQBCVFXZYrFCxNKz3SJPVhBxWgLo4nb0nMBuO8kvjIT8bHm7y0MWo=
X-Gm-Gg: AfdE7cn0wjsdwRle6HsSnyzDNDCeYppPYe4N2jbJ3VTSoSy0IQ1MyTDOKSl2dk11i/F
	Do89bN+k5QHOockhalLECBKAZzhX6VzQ2yXmG6bxX2/X3QKLsh4YpaL/xXHM7nfr+TQi89PaocT
	JNJdd750NiRq5LFW5WB2Hxr4V0kUe+8672Ognnd24W9OfUHeFySrHmhBUtSRFRP57FAKV8Z4H6y
	1O8vJL9ZDVcz0ZzwkWbmdNlJmxu1kjP9CU/VJiut4/RGKQCaB7RoPygYqwvJnxUhTyRu2VVRr0D
	7CfNVFXic82F3f/Gg88EKwpUqzrjDsNjoAcMoDIF/oF1AOTubUONKSx9ReAGmHBWs83EaaVDFif
	8IWMATQxpdJEeytZMIemaHhIh4GEE5V7V6BesrSIKH1V2L0mm4Tci1x4b2Q52i6+0jZ5IV2uZug
	OuUvwXqQz1xv+fAm912tTglFsyGYCt1FZ8mtX5xhRNr/g7X1V31oKoJQ==
X-Received: by 2002:a05:7022:32b:b0:139:d82f:2fd6 with SMTP id a92af1059eb24-13b2a17613fmr3845694c88.22.1782870963225;
        Tue, 30 Jun 2026 18:56:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2aba794csm11793919c88.10.2026.06.30.18.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 18:56:02 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:56:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] ss: stop displaying dccp sockets
Message-ID: <20260630185600.43d55c7c@phoenix.local>
In-Reply-To: <CAAVpQUAwrWkXxjErj8QvXg0DCdPc4zkphB4OSLgDDRmGuSrfxg@mail.gmail.com>
References: <20260630114121.26430-1-laoar.shao@gmail.com>
	<CAAVpQUAwrWkXxjErj8QvXg0DCdPc4zkphB4OSLgDDRmGuSrfxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303436-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:laoar.shao@gmail.com,m:netdev@vger.kernel.org,m:laoarshao@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[phoenix.local:mid,networkplumber.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 694DD6E9229

On Tue, 30 Jun 2026 16:13:10 -0700
Kuniyuki Iwashima <kuniyu@google.com> wrote:

> >                 case 'd':
> > -                       filter_db_set(&current_filter, DCCP_DB, true);
> > +                       /* DCCP retired in kernel 6.16, kept for compatibility */  
> 
> I think it more user-friendly to remove the case and show usage(),
> instead of just ignoring the option.

It should just be killed completely, parse 'd' as error.

