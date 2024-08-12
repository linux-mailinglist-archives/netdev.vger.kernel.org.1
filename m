Return-Path: <netdev+bounces-117776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD9D94F24E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688001C211C6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EE8183CBF;
	Mon, 12 Aug 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBayekE7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24BF1EA8D
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478636; cv=none; b=I18/PHnpoza/UBanNB4O2hacfm2hc6Drp8n5toMpTKxpyRQbQMASka9fAaOpK9yTxLKIfWp4vDgmuWkBbSd7oqImYWdyVuug9kL7lh91ZgjFxvMTnQP9U70H08Y8+Cr6ON251AyITUjgz236OUXvDCvX07Tx/sLSGIDhgwtgLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478636; c=relaxed/simple;
	bh=qdag4ETUFa6IAOkeFe1cSO3N/plwOt0/QREk+/vo7QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDs5cA7JRUfDQFbKpv1Cv88K+rg+TKria6BV2eok1WZ0qIjg+LDCDHeNXSprxJ+RLyRe7UOIxKX26mSLBxO9Tr96pdl1Y/VlVVNVXsDjxKNhVBRU4riuckCIhNZ+qOSQXxGtoGfONGh7EdukxWiWqbuSHXQTEb/VxhtAG1T+6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBayekE7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723478633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xYqwIo3WQVe5IYKTevNTP/BE8HoOmYcz/hBcpV1If8=;
	b=jBayekE7shpZ2Xl6zKQ2D34KzWhFJLc3JvwMd54fbGr3cmLhTyJL6BMP5nI4/5XV/OIG2T
	cEdigoFu/WYcp77izHqsKNFMD7/4oN/fCZwZodu3SvUKHNiUq5VA3MXtzVNtK3aEvWie44
	kzjUvkxpQ40i5Kfy4WspRORrGVNAq0s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-GEk6QViONlqH4VSUJ27pjQ-1; Mon, 12 Aug 2024 12:03:50 -0400
X-MC-Unique: GEk6QViONlqH4VSUJ27pjQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4267378f538so8784925e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 09:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723478627; x=1724083427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xYqwIo3WQVe5IYKTevNTP/BE8HoOmYcz/hBcpV1If8=;
        b=AarCxztvDKq+Su0Wh74AsKT87UA6DvFNywooSnOBXQeAh4fTz70zcDkts40FzRt3c+
         ADnRK0srWjVHM74VATY63NrwgwoblpS8AaP1QTMZx5gbO90NSE/t/IN6612zROjm12F8
         SnED1M/n6ZYON6nnoEbbFyoGJXKf6/MhMh3PPBsB3mmkh51gzHylBjUFPNHvIMUUGi3d
         aKLQiwbPeRmvnntrifCTkJ8htiKHSMkJwQmd6chqcuWolttttpuIl6kGBaL/N/hY+o3m
         8Lxy+jqGTuuY9xOPRS1XVlwr2kf3qAKepSgFREWJjZ/oVS+6/n8n2cZ61bNRp5QAhRvN
         tfPA==
X-Gm-Message-State: AOJu0Yw+neNr+fv59RB5zTL7arGLWuBaOiG4U3/Hlgi+OYG0mYN9q0Jk
	rzX9IEX/HkXztMIisPOK0dFhnWKr2zd5bfZLJDIOaugacYBsDB3HlT6vB46ZzfQ1L2TEzVACSqk
	V/NEUBugno08FE7jLw91Yv/5h/OpvIio3v6tzMVOv9GPb/NVxGiNvyg==
X-Received: by 2002:a5d:6d0e:0:b0:360:8490:74d with SMTP id ffacd0b85a97d-3716cd46258mr398947f8f.5.1723478627362;
        Mon, 12 Aug 2024 09:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElZqi74HTZ/smiQbo/FiSZ1r8hz1FEQ3fJs2GrvwZvTvkGqSvQXjKnWzbKLavVEK5hnEb6Uw==
X-Received: by 2002:a5d:6d0e:0:b0:360:8490:74d with SMTP id ffacd0b85a97d-3716cd46258mr398925f8f.5.1723478626854;
        Mon, 12 Aug 2024 09:03:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:170c:dd10::f71? ([2a0d:3344:170c:dd10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4d1dc98fsm7870952f8f.65.2024.08.12.09.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 09:03:46 -0700 (PDT)
Message-ID: <c5d0169a-ab1e-4431-a626-8b11cd7d9a9c@redhat.com>
Date: Mon, 12 Aug 2024 18:03:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] testing: net-drv: add basic shaper test
To: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1722357745.git.pabeni@redhat.com>
 <75fbd18f79badee2ba4303e48ce0e7922e5421d1.1722357745.git.pabeni@redhat.com>
 <29a85a62-439c-4716-abd8-a9dd8ed9e60c@redhat.com>
 <20240731185511.672d15ae@kernel.org> <20240805142253.GG2636630@kernel.org>
 <20240805123655.50588fa7@kernel.org> <20240806152158.GZ2636630@kernel.org>
 <20240808122042.GA3067851@kernel.org> <20240808071754.72be6896@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240808071754.72be6896@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 16:17, Jakub Kicinski wrote:
> On Thu, 8 Aug 2024 13:20:42 +0100 Simon Horman wrote:
>> Thanks again for the information.
>>
>> I have now taken another look at this problem.
>>
>> Firstly, my analysis is that the cause of the problem is a combination of
>> the way the patchset is constricted, and the way that the build tests (I
>> have focussed on build_allmodconfig_warn.sh [1]).
>>
>> [1] https://github.com/linux-netdev/nipa/blob/main/tests/patch/build_allmodconfig_warn/build_allmodconfig.sh
>>
>> What I believe happens is this: The patches 01/12 - 07/12 modify some
>> header files, adds a new Kconfig entry, and does a bunch of other normal
>> stuff. Each of those patches is tested in turn, and everything seems fine.
>>
>> Then we get to patch 08/12. The key thing about this patch is that it
>> enables the CONFIG_NET_SHAPER Kconfig option, in the context of an
>> allmodconfig build. That in turn modifies the headers
>> include/linux/netdevice.h and net/core/dev.h (and net/Makefile). Not in the
>> in terms of their on-disk contents changing, but rather in the case of the
>> header files, in terms of preprocessor output. And this is, I believe,
>> where everything goes wrong.
> 
> That's strange, make does not understand preprocessor, does it?

AFICS kbuild creates a file for each enabled knob under include/config/.
Then, for each kernel object target, it creates a .cmd file including 
the list of all dependencies. Such list comprises all the included files 
_and_ the relevant, mentioned "knob" file under include/config/

scripts/basic/fixdep is responsible for including the "knob files" in 
the dependency list.

To test the above:

   make drivers/net/ethernet/intel/ice/ice_main.o
   touch include/config/NET_SHAPER
   make V=2 drivers/net/ethernet/intel/ice/ice_main.o
   CALL    scripts/checksyscalls.sh - due to target is PHONY
   DESCEND objtool
   INSTALL libsubcmd_headers
   CC      drivers/net/ethernet/intel/ice/ice_main.o - due to: 
include/config/NET_SHAPER
Cheers,

Paolo


