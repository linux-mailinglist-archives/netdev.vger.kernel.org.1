Return-Path: <netdev+bounces-112549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC22939E3C
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977DB1F22045
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B316314C59A;
	Tue, 23 Jul 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+pzBrbD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0622097
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728280; cv=none; b=teP22nJkNs0wHmzseBv5o4WI1LLpiKWRs0wtIazK5Ixl/8JVBrF7dIA3CjINgy4lK810LfEW3nCAWaX45X03NQZdX5B3umLvPh29RIE5lI/FU9qpCX5TXTbxlqgmA6bcqtVX7ZE1qJ6NxnyFqz/5vl4WvsK/DS/wie0razrr3B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728280; c=relaxed/simple;
	bh=i7rNl+67fAT8PKhZRT/GeKiPfF3BELNAyAhPPXTGCBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tF1GTdulyaRq5u99NZvbI/ZEKiLAjYRp147UFQ4FkYwtrFb3YcNCuP/nhCPPY7Hb7R9lMy5kfxN7mWnH2Xvo9HlduiHSqc8E/vrgc2jOP6xNLP/IVeZVQ6K0Mo9xAGF7kztcDfYu8zmuITbLB6PI9UO1LTGYHyeyXX9CXIC7310=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+pzBrbD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721728277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzFPsc1ihRqbXe0SoW1BBc62YJIhLbX78dD6XbXDIfs=;
	b=T+pzBrbDTCJmiRDZvBl58PkxFGiPV3x3gLLb0w/K4t9g9p+/SiBXiFkowU+VsFD9JwYgcB
	R9UZ+kjqz7wLxxGVzbI/Jh6ynWbi0T85WTiM2qVCiNHesY5rIMbLc0hSMXaOXJeeROon+q
	MTSrnoGvIGImV85xfuq78Lqtphp64LI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-zn1lm5L-N1mUNKoPjNmdFQ-1; Tue, 23 Jul 2024 05:51:15 -0400
X-MC-Unique: zn1lm5L-N1mUNKoPjNmdFQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3685b3dbd26so836707f8f.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 02:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721728274; x=1722333074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzFPsc1ihRqbXe0SoW1BBc62YJIhLbX78dD6XbXDIfs=;
        b=qgCrA1HLWjQ51WTmRsVOKs5TfYsqtCOSzYsvEaAt4Y0Y7w1kbAZMduhZwCba2YYV9n
         U0hypJDdybrlfxoIReJhDyjco/vg5z+RIERz7HLTnYwlTgwecYCI1is3mqpb31jzMkur
         aQ1g6dOnAuqIS+p13fU9DFpS1nPXgqoTgppbew60g4yn/HPg9SQcY6o+LLuReynypo1N
         eY85BYxFWL3mD7Tz5Rblm8ASam2xsO1wGEZLnhOthS4SxUS9P6SoZqgM4EirjwJaNdlX
         4Ha8essvXe+NOlicAoq7PdKx46kZqB911wP9wxPiMbv7+nnlpaIQ6BCP5vIjgpc7MZsq
         IuAg==
X-Forwarded-Encrypted: i=1; AJvYcCXa6I1etWq3pbh9p/uURuZkk60kGmusbeAb5BNOZvZLz8XpCLFhJ6y5Zog6WXydWRKQtYJI0WJl/vkY04KYlqISNk40HgxY
X-Gm-Message-State: AOJu0YxxdOp8U2j1HADEDI7xHsrR1kQNH+rU6nFb/khbGBNUVpwGX/wh
	q/MIe8PalgPhWWQWM3up6y3CCTTHMqHOfuv7mhGSJfR7c0x/FEsP5Dxuo1aoy8fK4+SDVPoz/xV
	RBttjgAsX9w3Drs2jVAjSPQ2JD7wEh6pvSo1YqAM6G3fp2YwIgSfVy7SECWoCSg==
X-Received: by 2002:a5d:6d0a:0:b0:367:2da6:aa1b with SMTP id ffacd0b85a97d-369b67989b8mr4509594f8f.7.1721728273959;
        Tue, 23 Jul 2024 02:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIytT5cTJP5IKl2UEUGxDWh6vr7lGXjaghfENrcrRRQDxnl6Q2MLi7gFEINuJu1XCISxJ9kQ==
X-Received: by 2002:a5d:6d0a:0:b0:367:2da6:aa1b with SMTP id ffacd0b85a97d-369b67989b8mr4509586f8f.7.1721728273544;
        Tue, 23 Jul 2024 02:51:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868425esm11217520f8f.23.2024.07.23.02.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 02:51:13 -0700 (PDT)
Message-ID: <ebe772a2-9350-45c3-8c73-cda0cc5c804b@redhat.com>
Date: Tue, 23 Jul 2024 11:51:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: drop special comment style
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: Alexandra Winter <wintera@linux.ibm.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20240718110739.503e986bf647.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240718110739.503e986bf647.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/24 20:07, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> As we discussed in the room at netdevconf earlier this week,
> drop the requirement for special comment style for netdev.

I hope Jakub or Eric were present in that room?

> For checkpatch, the general check accepts both right now, so
> simply drop the special request there as well.
> 
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Makes sense to me, but net-next is currently closed. Please repost after 
the merge window.

Thanks!

Paolo


