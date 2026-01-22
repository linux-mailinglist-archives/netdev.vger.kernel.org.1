Return-Path: <netdev+bounces-252269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMo9Hk4CcmmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:56:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728365932
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50FB4689882
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448233161B3;
	Thu, 22 Jan 2026 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMs9kaye";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lIMwBdqV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B3A3D3CF8
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078049; cv=none; b=XpkoDusmJTcEzeWbIOVISBBlbyIneQEth96Lf94bQSmSp2rRuhdGByrCmNcZ6uYO7dc8k+k1wIEw43DUIPC0tAuP6+i4UupmY2mn0EjiQvbeiuxTkzibmE9O6lGfuDUVfhXn29W7FiNh3IlrrhdRzQ/aDzFGMVfWB0240kxYCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078049; c=relaxed/simple;
	bh=bpqaKp9znAOnSZ5KlW3MfmlKU7CJproZYrSYtxDDX5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqoOUDCzIOZlak3Klmup0WtP7Ynxjy7sj9jAlUMpjepTriyOZKZDWbe8jLV+N6I7ztxuk9YZ9MJhlgOsvkQ74juIWZ1yYFkd443P9cedkbk6VomNRwRSNzmSMbeQRWpr9rs4hWzul/RfYb+lmV4dtYlB9gA1ZVsV71fkdEcUTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMs9kaye; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lIMwBdqV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769078046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hE8dFei3bya+ynBeOHXmxyPXij+DCune4AiaN8nbR0=;
	b=IMs9kayejE694W1SNL1RLELmknMvqyeiX2Kh4FQt8Vi4MuCgC+Pe6NI/sklK8RigcxTDE8
	qDZ1O1lY5BcqPlU2JmxxmSCqEMmQbpaX6BYZnFWRLMIMM/lBnIBuNKuIyqCKvnx85lJDnZ
	2BVLptm7DKtUapXurkQ5eVUiD5xtncQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-OILXkSzDNAa8rMpq0aCufA-1; Thu, 22 Jan 2026 05:34:05 -0500
X-MC-Unique: OILXkSzDNAa8rMpq0aCufA-1
X-Mimecast-MFC-AGG-ID: OILXkSzDNAa8rMpq0aCufA_1769078044
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso520198f8f.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 02:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769078044; x=1769682844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hE8dFei3bya+ynBeOHXmxyPXij+DCune4AiaN8nbR0=;
        b=lIMwBdqVmatToAo4yVH8zRbpOQK37+ziTftvp00JX5MmAcAY9BcwsP8gOnTE4LszGV
         hf1YeKwnO9JqzjyN4dwGuMFob8YHXD3zrvcq7bAc3WH+yy795RAwURMFTB242ahpkW5i
         UkCjmj/oxOnGwA5l0mCAbYp8cMoWl2RC5Tx9NYxlxZkVi2lsOdqf7RZjxcTQSYHsJybi
         LjF+YakD6bYOyKT5SpT9Pz7lHCCKsyJGUvh5QyAMCBYqvN/aw8JvkYKzeUFLlCnpFlQG
         eowjKWu5itFX4BXwfJYWPB4AWxsBspsJXc9FkCG8V7s7oFjISUlef09kNX0/jEgNnroQ
         BzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769078044; x=1769682844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hE8dFei3bya+ynBeOHXmxyPXij+DCune4AiaN8nbR0=;
        b=JqiIbhbYy9ajzUMQWhHFrwc8aMalo89WX2OyKXbJ8kqhA0TkUrXDjXhBKhjWYJK+Zt
         cjzY06P8iekGJJDP8wsp8zmGaBLi9JFUmPVy6GkXruxobx0h9nXiogY80GcXt++YCbPD
         +IM8UxBJUQ7ytHKG9MgJhcghvBTA3yKp+QJ+zejKq72+RcgGmkXikUXIt84smGfk21s1
         1QUStDcYvX3EQoJvaiW61LetVDWkiAHhe8zajzUafiAccvLuADQ2HerbbBXoLi7361WN
         ayjaaD4qjA0q9FdAWlt/3BBKtMvK1OUHJYQcefc3OVMjjdbufh96rjmNXsNdbOt4kBxF
         Risg==
X-Forwarded-Encrypted: i=1; AJvYcCWz1OUgr1pgdtjLN40TNzjB25rrhHQUBNvd5qfvqBoBnnT/uY2z/VOFZLNGYhuP5Oc+oiaw4XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SzjvZ6/Q0sd9VGvzhGbei0OszIfJvDRNlAIzGsr7dPdI2yja
	uoSmsjbotOqjdCDyvm1EJ0TzqGWU8X8DlmeYUl+d82n8w5TTAKWaDFBXeFZfo+cCi3lUPdtN9Z7
	wNE1meOeHDJizY6xlpBurYstGA4i/4TbCr4ukKpU2GDOIA7klOwippgxqsg==
X-Gm-Gg: AZuq6aL/wBgE93IIi8uHOmFKpzyBtvDoCYNcL5yQtR20c7YnTXxU7PcN6eRuyRTJZ7I
	u3ssPEOLMK7y0aYp7j4VMqmu2/mkzbab74bZx1YD/mMLSm0gQVvfo5ptW50xnpSgSAgRogpdovX
	y2fd7Mt4trzaxXIfF6cw6NdlgOYupz5J2mQ/SZjxNHrnfWCORa55aNj3GnDhHBakis2Jc/Pexie
	VvhJngE3nGFtvruzVaRH0jXZlM3Sd6NpB5rDqBQ9KBdIybMkj8lQMqvU5noYYV8gE8Nb2/FqDTY
	WKNfWrg2bbBk1cpx5HqjmObau3+f142HMmKBhscncxkOxEUPbezhJWbpN1AnMI4EKwYOcmxXGc+
	k/o6p/Hk47Uq9
X-Received: by 2002:a05:6000:2406:b0:432:5ce4:6fed with SMTP id ffacd0b85a97d-4356a02639fmr28991520f8f.9.1769078043678;
        Thu, 22 Jan 2026 02:34:03 -0800 (PST)
X-Received: by 2002:a05:6000:2406:b0:432:5ce4:6fed with SMTP id ffacd0b85a97d-4356a02639fmr28991484f8f.9.1769078043254;
        Thu, 22 Jan 2026 02:34:03 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992211dsm44139826f8f.7.2026.01.22.02.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 02:34:02 -0800 (PST)
Message-ID: <c2b42356-565f-4374-91f2-6db69a6af196@redhat.com>
Date: Thu, 22 Jan 2026 11:34:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: dsa: yt921x: Add DCB/priority support
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
References: <20260119185935.2072685-1-mmyangfl@gmail.com>
 <20260119185935.2072685-3-mmyangfl@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260119185935.2072685-3-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	TAGGED_FROM(0.00)[bounces-252269-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 6728365932
X-Rspamd-Action: no action

On 1/19/26 7:59 PM, David Yang wrote:
> Set up global DSCP/PCP priority mappings and add related DSA methods.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Don't apply cleanly anymore on top of the LAG changes. Please rebase and
repost. You should keep a single series in flight touching the same
code, or this problem will happen again.

Thanks,

Paolo


