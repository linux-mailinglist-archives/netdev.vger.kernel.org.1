Return-Path: <netdev+bounces-268527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBZDAmImuWm1sQEAu9opvQ
	(envelope-from <netdev+bounces-268527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:01:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2742A76A7
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FC063037D54
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8D3A4507;
	Tue, 17 Mar 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1KBpy8h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTpBMRpM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71103A3E97
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741467; cv=none; b=fnhJpz/TZ9JaMAW//D7wil8Sunclet0lMJM6lW7W0jI5cHmYIQ5fa380z4433F1aOSIqhmJH7UKlvCoLksnhZ8eiS3Nv0ZRZ/OfRnT9Zfb6CYa83zMpT33iqF6wsXgjuavfxBHW7j7oR7sjTOAwJ0XKzrupb4dw27w4+hWasdhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741467; c=relaxed/simple;
	bh=mKVRVOSt/fsx4ilTPwxMzDSFGIg2+3/bIQ+LVhC/BS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKvN7bWVQZDLvGE4QgnbquA6dZ+yJJ/KfnKKibki3sRicvDMwDd1FuhijynznZ+kK/k0Rbm8JZ2gXN0F++EpG/b6gi5Q5m/yHqj5w94okhIrTzLUYdhuHPaLbootBVAGrKpvaYqI1QnNXa/QVNlv6KuA0nww0SwvG7CSaMBTr40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1KBpy8h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTpBMRpM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773741463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVn25Xo84DjYnUkEutgl608g8cHLDvs9Iup/54uYbZk=;
	b=c1KBpy8hiXCxTSwZzQa4hh/3EE3idRi3FeLzOMBejLnjAY+NW9h4FFI6waGebx6YNXcff4
	VN2bNBFl1t+rnJIFMxdw27oxXqd83AY12db4PztXHBmv2fRhrGxfr5wZzLf3DaZOE53CNw
	VQgHjgr9jAjyeO7K/8VeqsyWLsim+rE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-zK1WYmyYOYCgjSIRpVpXZg-1; Tue, 17 Mar 2026 05:57:42 -0400
X-MC-Unique: zK1WYmyYOYCgjSIRpVpXZg-1
X-Mimecast-MFC-AGG-ID: zK1WYmyYOYCgjSIRpVpXZg_1773741461
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b40c22eaeso1449261f8f.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 02:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773741461; x=1774346261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVn25Xo84DjYnUkEutgl608g8cHLDvs9Iup/54uYbZk=;
        b=UTpBMRpM4dBaOfKIjN8h9Ycd4Rd0V5pnqJvgX1SGb5Hgg/9LwrZDbxDUrhdKOM6Et1
         66JMZW8CSZ7OutsqoLVLW3NelfHDYrufO5zo9Q5VJLuQ7XXQyQP70VCqbbg4DHqfEIJq
         812rBY6Uieaq1gOC/rPFU7gmDzR2NErVs3aJpyQDI5XTffPfySHqBKwwl3dzZavJXxVq
         Ls5mk2pzWsiqtDXMT8wOyUr9GanrymfVLHocKXMvN5JG5ZyzZGg+jjJKyej05jLZcvQu
         lE+tyvwdlw2CVULa1XiE8wB1YksPN6xJ2sdtUcEL3dsEVe4zQ/IeMOZx4KSalg9w/zSX
         he6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773741461; x=1774346261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVn25Xo84DjYnUkEutgl608g8cHLDvs9Iup/54uYbZk=;
        b=rGSAOGOnJmW2iiflTn6/XV35QuGX5UDZp7JSX3JdJV196ioEmBY2q9yZ9/Lz1hUEzm
         bcv+ZwBV3BXixHNDMnTY1Xlx+k2vsEDYK2vmSudSEIczO+j2aCWbNFniz8NkvGKE2r8p
         1tB9Hk9+b4ehywdz5wkcZZl1v64w6O21xKH8mMAcuTOZLkOIjj+HXQ/cdKFG/8V/e1wV
         shLOJmU4yYvE/TbmWtvvZejxNyl4rMcgQ1Yfn4TBUWme1/v0E+vHeNvkOfH1vwTIPlDd
         J/T5vf69LJEdi8y0fdhhwO9wzTBcHSddGWFbfHCRLVM9PRs5f+5nM66ApsQf8x+2o3tY
         n6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpHNePx/jR/w2DH/RKcEi679Dk3ORBqYj33A/lQwlnJN6E22fOV0ufpGescjcQ6OHUBCgq88U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CxT9KHSH2TxrerjANLgrxMfr0u1Ni5Cacvdhp4TT+g1WE+Q2
	umbwMBE3KJ+MXs9SMsDG5J1Al7oJkHJ4o0NvXM5tkk8MfoVpXRoII/9HU7mOjAmdIn7BCAN9wVN
	AHjMxVyCnAQuxAs/gHihD2MqW/fZuS59EG2TAk8K5Sw4+/I45jESjTfrf1g==
X-Gm-Gg: ATEYQzzLcIAx1jdpAxZ8nE0scbqYhRH6yvav7BBcIKXu28bauquZABsPVE8678X+mNl
	1JHYz32/AtMMZan7EL1W8VhnXmWbpoE8ryQU4W0sv9ALBomT1OYX4Sh1crmDJgs3WXr1AU7y/Yk
	yEjGvkY8CylKa3uIAS0xi6+XKnDDqG8bmm++luw8bFgHLC6jVSsfnx51K3Q5rHUTzUF8qD1cVHP
	e2dvMJKY4RKM4Sy025d5txwWJDW3tXsKhansGYew+Owo+U/zWQisj5z9KT6SUwptdVEzZM0vrmI
	zWwIXjA9Efn3C3K7xBBqpQdRrfiXYQx2Cy9RnhtEOdmz+CP/yMyxzT7elH5W9wnSgGztHEl3pIF
	YuaEKqORMjfAVvLDKFkXYqN4QSIyaT95ZxDtxvLm5j1ivQAbCoaWEtu4=
X-Received: by 2002:a05:6000:2288:b0:439:b79d:b9a5 with SMTP id ffacd0b85a97d-43a04dae73dmr29950119f8f.37.1773741461025;
        Tue, 17 Mar 2026 02:57:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2288:b0:439:b79d:b9a5 with SMTP id ffacd0b85a97d-43a04dae73dmr29950070f8f.37.1773741460554;
        Tue, 17 Mar 2026 02:57:40 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1affe9sm51534817f8f.15.2026.03.17.02.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 02:57:40 -0700 (PDT)
Message-ID: <7b082017-5245-434c-9668-49b630af6484@redhat.com>
Date: Tue, 17 Mar 2026 10:57:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] ppp: remove pch->chan NULL checks from tx
 path
To: Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>
References: <20260312093732.277254-1-dqfext@gmail.com>
 <20260312093732.277254-2-dqfext@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260312093732.277254-2-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268527-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[dqfext.gmail.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA2742A76A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 10:37 AM, Qingfang Deng wrote:
> Now that ppp_disconnect_channel() is called before pch->chan is set to
> NULL, a channel from ppp->channels list on the transmit path is
> guaranteed to have non-NULL pch->chan.
> 
> Remove the pch->chan NULL checks from ppp_push(), ppp_mp_explode(), and
> ppp_fill_forward_path(), where a channel is obtained from the list.
> Remove the corresponding WRITE/READ_ONCE annotations as they no longer
> race.
> 
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

Looks sane to me.

It looks like you are investing a significant amount of effort to
improve the ppp driver. I strongly suggest you to create some functional
self-tests before any other changes in this area.

The code is pretty intricate and obscure, a reasonable code coverage
could add significant confidence in non trivial changes, and could
possibly help revisiting/cleaning-up the locking schema (which is AFAICS
the most significant pain-point).

/P


