Return-Path: <netdev+bounces-65119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8931D83948A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A039285C6A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36886281F;
	Tue, 23 Jan 2024 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOibm1Vr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E75F545
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026744; cv=none; b=LVoYub7uBQeRaxgYADzmTgHKD8IAA1MR346xqhuZgi3Mb2fDOk4rzcvoDI/6ABjUzZBLs6/19ZQnew6m9oQZFwVFEN+9x9jwmGAzryP6JSle8220o2Q/H6WRW9q74u7wNLs0C0UX5yDEQTDAG3DnqCiE9xCkXfWYS3SouE4DaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026744; c=relaxed/simple;
	bh=kblZGqpoT1v3973bj1dYvhSwfjRbVNskJRT/CllZPg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTtRruGm3NyViU/1wJYHJqipqLh4007tA1DuGmfoAfbmnvdWZ9eXmVX1/owsjD5tDacuxY2TUjPkET1xl53gsc39j5mzIUWosC9OOIoMLm2nSv6SadhHnYp3e1vndPS00fpn5WqPnhVTuThSkDZ8UV3qZs39KcyyO/Z2TMKI8Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOibm1Vr; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-361a1665791so15705025ab.3
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 08:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706026742; x=1706631542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQs7BP6kms/S4iiLpTV19GHpkxt/8LQZgx5uhUMzPXQ=;
        b=gOibm1VrOM6iaT+3gH8jzQTpcHV1H9clQuXgW7xyf6Lrhh26xyQnLryMehnmthiRUp
         ky0JMwsLtOqjzkXkDRpmWmFJYyPrYTV5t/Tw/BZwv+V2R61k4K492rqtZf+d/+T/rK5D
         ph9GrIVgewMdfyFR8icupfgAA2L3AmvtZTYKKYNhSW/IBFYH+uEwDXXmwW6YBc0QblmW
         YB2zlybQH+Ln426GG44zVZd7uB/YoUI7WQU1nSgPB4bRLbwr6tj69aGmMyoBXdv5oXSa
         6c5G/lZsth2rdgw/vUHmrAeL4oG7BeOc0ZkaDZq+v2F7ZgvLCvBOPyo4UTS2AZZtV9hy
         eTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706026742; x=1706631542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQs7BP6kms/S4iiLpTV19GHpkxt/8LQZgx5uhUMzPXQ=;
        b=PEQO8Kn2kibywAgbUrcEkom/kdGFkU9Coa8uaAWsZzIIG9tMEqvyHU4KLM89UMgNiz
         rJTPvloIIzKbPs4TnUXVgdwUGPG8urSWfsXHofgImq6plCiGwsqmJuyVJzeBo+nCODdb
         TB0l+dVnYFHLsFLVu2epX8YjCIRntAdTEihybvTUrUbnrM9TtZ/Yeen/RpexabvHd31l
         zok1qc8fJMDjL+2AvWG4cubphgpb73LJVaJUfbnWNiu3Rz/dnITmWyzUL0q2/+9IBUnN
         3lKeEbgOBC4GTSRFKRSKGGTFB5bq0rIf1dKA+ESh/KM8FI7q1DAgjN2ix9iGyE1wPCgy
         N7Ng==
X-Gm-Message-State: AOJu0YxthPxLRo9kRM+s7j5kAzwwFRuhk27DuiCXRScbehlBoOx4nN6c
	qe8yTmuHVpT262ltbqsglSNPZ6FWqKB+y6VYy/cVEGWK8EgW2iM/29JaY2J+
X-Google-Smtp-Source: AGHT+IGgej0/2j51eNU/27AlhiPehqmC+32npHJK3mAsnUqJJoB9U8GbBQKU0q6UkQ6s0hQlhqHemQ==
X-Received: by 2002:a05:6e02:4ab:b0:35d:66a0:5432 with SMTP id e11-20020a056e0204ab00b0035d66a05432mr78660ils.13.1706026742596;
        Tue, 23 Jan 2024 08:19:02 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:3c2c:1afc:52ff:38e7? ([2601:282:1e82:2350:3c2c:1afc:52ff:38e7])
        by smtp.googlemail.com with ESMTPSA id d7-20020a056e02214700b00361a2072693sm3618433ilv.63.2024.01.23.08.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 08:19:01 -0800 (PST)
Message-ID: <1fb36101-5a3c-4c81-8271-4002768fa0bd@gmail.com>
Date: Tue, 23 Jan 2024 09:19:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
Content-Language: en-US
To: Vincent Bernat <vincent@bernat.ch>, Ido Schimmel <idosch@idosch.org>,
 Alce Lafranque <alce@lafranque.net>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org
References: <20240120124418.26117-1-alce@lafranque.net>
 <Za5eizfgzl5mwt50@shredder> <f24380fc-a346-4c81-ae78-e0828d40836e@gmail.com>
 <1793b6c1-9dba-4794-ae0d-5eda4f6db663@bernat.ch>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <1793b6c1-9dba-4794-ae0d-5eda4f6db663@bernat.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 12:58 AM, Vincent Bernat wrote:
> On 2024-01-23 01:41, David Ahern wrote:
>>> My personal
>>> preference would be to add a new keyword for the new attribute:
>>>
>>> # ip link set dev vx0 type vxlan flowlabel_policy inherit
>>> # ip link set dev vx0 type vxlan flowlabel_policy fixed flowlabel 10
>>>
>>> But let's see what David thinks.
>>>
>>
>> A new keyword for the new attribute seems like the most robust.
>>
>> That said, inherit is already used in several ip commands for dscp, ttl
>> and flowlabel for example; I do not see a separate keyword - e.g.,
>> ip6tunnel.c.
> 
> The implementation for flowlabel was modeled along ttl. We did diverge
> for kernel, we can diverge for iproute2 as well. However, I am unsure if
> you say we should go for option A (new attribute) or option B (do like
> for dscp/ttl).

A divergent kernel API does not mean the command line for iproute2 needs
to be divergent. Consistent syntax across ip commands is best from a
user perspective. What are the downsides to making 'inherit' for
flowlabel work for vxlan like it does for ip6tunnel, ip6tnl and gre6?
Presumably inherit is relevant for geneve? (We really need to stop
making these tweaks on a single protocol basis.)

