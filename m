Return-Path: <netdev+bounces-255073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF2lLSNzfGmAMwIAu9opvQ
	(envelope-from <netdev+bounces-255073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:00:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFBEB8ADC
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 411EB3001CF9
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42617313276;
	Fri, 30 Jan 2026 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwzOYDB/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1F2F90D8
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769763615; cv=none; b=DtGDjsgsl/7AfWDptjyHUfvIUQU3cQCNl0m1WGJIDAv1lePPV89zUbhZSrZNjIR+8IdSqeV/S0y8BQJ8DI0HELEK9w4iS5hThbWxOEe1lWUnLltOIBx1xnr1oOxx0QfefgjLv0wfNyQAwjaGMwRaOlNzji980MvFkW5nqBFxvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769763615; c=relaxed/simple;
	bh=ePduo64u11u6v+wbzkSP+xdsaIltB4wd0DxeqhPmXxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjCoTj0/2gZbyHzufg4yi2cDLl4u0tjd6rK9/nTAoZ8m7RATSoBv7/3gig1dD6ndRIM702mRotkzG8WJOYJi/LbpZCWXbwRXY71GYjJruHlNsRvi9ZPV4+nLf9XrUY6A/D8wvCdTyxn+lDXel2iBtxnC1pSQ5z5H+DRmd13R1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwzOYDB/; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-432dee2b55fso72558f8f.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 01:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769763612; x=1770368412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiIvi824zY9wmJCmgI0bFR+9pFwwPhfm8LVUcK3cTY4=;
        b=VwzOYDB/390lyTIJnfDCLmfRvLPEmbzKx9eYn5YnAS5JDfq5y5N2wnu8kEpl09ROyI
         YmKuegq8lT9NBZI8NmMMyNab1ymg9S7WNeGRfD+P2n+NkRSacmBgNzR8G1jQlcR0UXLF
         QqERmT2DJ0e38gd+Rj9ErgVhv6RrJlHwDYo/5lgXVkShwxNusOVzfjIDmG3uD1cc8m/W
         9r2NRbDazH8JpTd9PgotOs6wgms01W6Mknky8KBURKPRiOw0hkx7wVhl4IkYRz32rPvr
         6XGApCWzavSivSng2OyzAj/4mCEl3W2rrY/2psLiY/fYrKlMlNDIJ1ast+LshhbrSBLf
         ISDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769763612; x=1770368412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiIvi824zY9wmJCmgI0bFR+9pFwwPhfm8LVUcK3cTY4=;
        b=reMlG6hDA5LMx6gHARV1DXlNHghNbaKSANP/g65794W+hNCsj4cDUCOS6otIZelcAn
         jSnK9QByYfVAVRnw92QynM/HXuqD1eu2h91X4EQgcbvqmam1iRo3s6a1wkoysGMhi4+H
         wcSAl7AssnOUyd2IXmJTjeb5GRXjJAbPlCDc/e5mmo4OwDTmQyjqLahIeRM5CQDQL+H8
         76+GrCVT/ABtOGqWeqx0Pmxhe5+L1jStEf/fdtSRDLnCGKr2JydHWlq/zDPJp0aWREbM
         QHymXG2DamJBZl7GukTrLnldqOS8PVPqo2jXkShIM7P9Nhm9j4UL4JLw48Dm2Bo6Xn58
         2lAw==
X-Gm-Message-State: AOJu0YxWJziMjfX2a9Ur9dySaGXlEeLJx650EIUYKvS3gqrCqoMclJLm
	m+t4xAi0qL3HRC1s/Zznp4GPDH0JvWOiJFGZ2U7xoKu80JmIRFbSkqT+
X-Gm-Gg: AZuq6aKKnzUop+TWhh90QFW++0QdldpcEkxv2zAZQ3DLKCbH8esmVfPin41n8rH5+/C
	78aQy/H0iKgSGYcwmXAroV3ZKkK/Zwh5MlGnI9BVITzms1jtxsiOm2UMfjMbbsrUng1wxO/LASs
	9wO9do3z+X+GVP5GlGZlF5DEoPh/ng7GcdhGUoHxKrZV0O72NIVLzlK3EdBVZJz6JGhXI62aq7I
	UGLIzmcTtmZQswVgA/viBnG+cRrYZySDOT3YANbbYoleFCugtPvJQYku1j2BbFQJIAqP4Fqf1G5
	jENZniVFlkBFzxU2YO9eCwUj75e9Ea7lYEGnWK1MqJEP3dd4T8D0AWSQzFhmAk33yCZMjx5pkzF
	qTaboHwmGIBz6qPkoDu9mjbsLksLz2kmqD5vbDWz1atzfXVaZAYBeU1tROpegtpLV1l2Y2Bbe37
	3IZNX1rYgR
X-Received: by 2002:a05:6000:4381:b0:435:db94:1934 with SMTP id ffacd0b85a97d-435f3ab009dmr1747822f8f.5.1769763611702;
        Fri, 30 Jan 2026 01:00:11 -0800 (PST)
Received: from localhost ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cf16sm21898981f8f.22.2026.01.30.01.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 01:00:11 -0800 (PST)
Message-ID: <727b7f08-828b-449a-a89d-005ad1f50b32@gmail.com>
Date: Fri, 30 Jan 2026 09:57:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] net: gso: fix MTU validation of BIG TCP
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Alice Mikityanska <alice@isovalent.com>
References: <20260106095243.15105-1-maklimek97@gmail.com>
 <20260113214232.129356-1-alice.kernel@fastmail.im>
Content-Language: en-US
From: Mariusz Klimek <maklimek97@gmail.com>
In-Reply-To: <20260113214232.129356-1-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255073-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.im];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: DBFBEB8ADC
X-Rspamd-Action: no action

On 1/13/26 22:42, Alice Mikityanska wrote:
> On Tue, 06 Jan 2026 at 10:52:40 +0100, Mariusz Klimek wrote:
>> This series fixes the MTU validation of BIG TCP jumbograms and removes the
>> existing IP6SKB_FAKEJUMBO work-around that only fixes the issue in one
>> location.
> 
> My series removes IPv6 HBH in BIG TCP entirely:
> 
> https://lore.kernel.org/netdev/20260113212655.116122-1-alice.kernel@fastmail.im/T/
> 
> I believe, it makes this fix no longer necessary.
> 

You're right, your patch also fixes this issue by removing HBH headers
altogether. Thanks for bringing this up :)

Heads up: I'm working on another patch series that uses some of the code
you're removing...

Paolo: should we still merge this or should we just wait for Alice's patch to
be accepted? Also, should I already submit my next patch series or should I
wait until we're finished with this one?

-- 
Mariusz K.

