Return-Path: <netdev+bounces-278353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOneIswC3mkRmAkAu9opvQ
	(envelope-from <netdev+bounces-278353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:03:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E43F7A0E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 192FC301BEDF
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3062F90C5;
	Tue, 14 Apr 2026 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Im2TbrtC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95E13635C
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157385; cv=none; b=aUqL8mNFGOn4REcJLCbHyiP2GbAcioFTKtHyuvMVT3Pdmq6g58jbNCcrv6oUnwUuuDkWQ1G5sBKr0qrX8QwXA92xtHoLHuSn4edqY9dHcspGGQQIxG44ts/9GR9mgcnItr4kmky/FNrwGNssPhqOyT/fRHij3s+qgOAFzShZtNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157385; c=relaxed/simple;
	bh=odYOG/2EKaguQIVc646DoAkN3Rpt1/govygNjiKs2Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1b+f4kiX5B36GmxASGnXyxws9oIcZVg2HNzuUeJV8p0d22zMGq0btK5lU23agLkgzSTFNwCqX5t8zt0vxFgR/LSun6Zsf5Z0blls23ZAg+fwlz8ljyfeIrkL9PaCXPP6o07lHqpWiFFhOdm9QUG9M0M2R9ygad3/sNDyyPhj/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Im2TbrtC; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50bbc41677dso77219211cf.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776157383; x=1776762183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hFUGdxNOQkMUkfnyHDuWQyrRlIu1sHgF/LLF9Bc4qfQ=;
        b=Im2TbrtCLL5/4a7O4XQrzQMvL1NyrkxlO0uOxOxjMXDsPc3oMx9wK6ScMAyDTvlNtR
         XOsfraXFv1+uu/bT1ea7u38UAThqSkdslaZXGyHzuw+n/D5vqUj0RhwOr3OeCSHsJJv7
         Flbg/htkMJiuS9GQXcJA4TxWU1etLzk1lx0oKLi72pu45vtvnEYVqg9GQc6rUJxXXmlS
         YjnEJUhWklcS2RRYXaJj3zNuj8ReRJhVktfBT3XWYkTy+uqKX45bpKNFSy0Z91YO0gZv
         LfnR6i+mz7CmNcxalxMTLXgyWaGIHeUtVwF/nshk7czPRIgr/06sG9L7Ad5JpS13dZch
         N0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157383; x=1776762183;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFUGdxNOQkMUkfnyHDuWQyrRlIu1sHgF/LLF9Bc4qfQ=;
        b=QCzzXQsAGpcrDCuld0sLAGLWLIzK0V/aC2FPsXvFkKLnFCtU6V+NhYby4xdaiaAwwV
         voM5RGx8vucYNf1Vz/VLEf/zbZ5WBSr7x1zKq8F3Oyn55dZI/OqyMbfHq6U5WqryUd8+
         DAnGAfygJxt25oCS8lwT8z+FND7AcixZ1nU1HXstCRcQHnyGUc4j7BgKkXhtoAueXz9E
         ruuuKiHxjPJFdVd+g155VXq0GonEMS16v288vTlgSeE6wgGTRHMMFdC891Ck1RV7Zz/a
         nDwHrY6SBsoeQNKO01+Nn94ABU1mZUS4zeEDo5ud4g+W0mMa4Kd1RY4uZK3GlBaC2Smb
         5anA==
X-Gm-Message-State: AOJu0Yza0/WC5P7ARmePJJvxN7OrDExhd+LnYc8PATvDjr0KVw0M2CzX
	m1etK205uQVwGOL3TevFJoIUH73Nz1DbJXojNE/pQrO2zjgYhzFsIymUM0ROphd4h0WZ6ZcbmuK
	ywY2fRc2tZJgvUo7t8Ga+Fe+XKSYOfWGcf6oRVG4ubuiro9FofXE=
X-Gm-Gg: AeBDievtC0Cn6pWnWnlbL+f3jUgWKK51YV+/70749iPsy2UCyRPx2zALp8VwmGHCdE0
	iPVdDdIMWr/oqrizARyAYKIijVo8WLAgkECYQjhb49bwsNim4Mde/MDGCsAIisdGoe7B37wO107
	gBnp0t+wUnufm7DMYm8oAv6Qgutldssn0KV3XAljp9zAbcd8CzRLlGA6w3mWRv56h6zMwVXKPJ4
	kE7UPObUvgjXmwO6T9JYbwNi6rgoIUVo3fxpF4U7cVYdwTg5yUKV7nZBqhhehqh8ljof74JiNQI
	lCKAwNZWUkBNIBFexNrSVOJ9HvH4GwL1VSemEm2xbSkcrdDA6QKJbOcvNhmmg2kR/Mk3FtT2A5X
	hjiSXwFpXx/tJMe/gosyaoUeEvHX/o36wGGx8iSkRx4ZkG5tbvjxMxiNXz6QST4xqJHdgaL9j2E
	NeYZidYvkkz5oWuzSBwHAYtYMq4ymQIEKopGguLYZaruj59HszsLBZmxVPSPxhdg==
X-Received: by 2002:a05:622a:a9ce:20b0:50b:49d4:e54 with SMTP id d75a77b69052e-50dd5bd9be6mr191906691cf.15.1776157382523;
        Tue, 14 Apr 2026 02:03:02 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:8842:dc29:5b0c:176c? ([2001:67c:2fbc:1:8842:dc29:5b0c:176c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd5637f4fsm106568141cf.28.2026.04.14.02.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:03:02 -0700 (PDT)
Message-ID: <0282807b-967a-46d8-872b-f94a6feffb16@openvpn.net>
Date: Tue, 14 Apr 2026 11:02:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] selftests: ovpn: align command flow with TAP
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com
References: <20260412221121.410365-6-antonio@openvpn.net>
 <20260413235608.3699773-2-kuba@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260413235608.3699773-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-278353-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:mid]
X-Rspamd-Queue-Id: 1F4E43F7A0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 14/04/2026 01:56, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says: "The second one looks legit, would you prefer to follow
> up or respin?"

Will respin, since we also have to fix the timeout in 2/5.

Thanks,

-- 
Antonio Quartulli
OpenVPN Inc.


