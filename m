Return-Path: <netdev+bounces-123160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8034963E5D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE8B287E2F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E060618C35B;
	Thu, 29 Aug 2024 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0oBEhDI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254E518C02A
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920024; cv=none; b=qFgnOoTsitViAdvBtzEYlKs6KSpx52Nmq+h2voVp/gI+24aa7kT2ZJgC2QgT0uBiWokp0vsghM/H73tp/iiX6NIVBeRlQmKnU0NAMUpt/6HnirXmKNo1wh/oedeaokCvUdVM1IaJTXDPRxbsckpYEhv2SApb1XGLztlhVXvhMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920024; c=relaxed/simple;
	bh=Bg3qnOD/wVviS+JcQvXBgCI/eQDVp+5vsrv7n/OOhkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4D8RyEG1lfMGXQL/MP2Cx7tfxCjzD/KVUC5y7jiG3iE+sAnQePJNuC2VUXTVt3EiJiY4bGdJxGDq1xXcPVPno6Qxkzldel8SKj2r6b8db4wyhsLg+NKabkJXxT/mDK8vHs/y7G4dSIrpeeWx4wPEyfXb8tJs7d9xai5ZgLz8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0oBEhDI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724920021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=009aMKtYz3alNozgyKcZzRLs3QnC7nYwCnZ9axqzyJI=;
	b=P0oBEhDIqaBVed4N7nJV8j0c/bk4MLAlpYqoKkJUmC8UFq25Z+RBL9y71j367W9vIP7LEe
	y7PHYk6Jtf3osXqHe7jDblNTn3TV/UcOAaahtTJMm2YVE/F7ixwwVYfIcHV4uWYGaRkTy4
	gLOpudiVRtPc6ArVBPhxwdfCmyCt+/o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-lk2ulnfGO72YxDSK9IFncw-1; Thu, 29 Aug 2024 04:26:58 -0400
X-MC-Unique: lk2ulnfGO72YxDSK9IFncw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a867bc4f3c4so66776366b.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 01:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920017; x=1725524817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=009aMKtYz3alNozgyKcZzRLs3QnC7nYwCnZ9axqzyJI=;
        b=ceXxl0jhmv2igDGUdmvCkNFU4/zejTTJaDpOwGwkIXtW5vcB5lVXp/N6IsGEPIv0F+
         GppSXc0duWLjznRG7mJX708BUeL1tpI3Jfh7mWYNzRLLGei2ixBtI5qq6icOVBXiGXky
         q6HVMJrYyZO4nG9DjFddpi6NnugYbIxdimgHKOuFKVQohEqnTxvK3WNbQidFI5DfRqqI
         GFG1hnGVxb4mT2RzmNxoHBQthNW7rZV6Ydh9B7P+Lc7nbvUOQ3pzClDV/oxXc7evRyUq
         0iz2xk2L01g4FYAFKOexv3Typq58hZadm5INYiGxTpi9infovzSg3fYbT9tAaYgRZjMn
         MHZw==
X-Forwarded-Encrypted: i=1; AJvYcCXg1+lNlVGHlqrLxZ5Y1HeGH12PZymgJi81d8IJPsLrtoM+JTISCyh9Id6UjVzymObGPpAbI5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWs8iqFHsBXf8bK3ydn1LrJgdNaP7fg1Nofrlsz1NXgOV3E2He
	ksp9dV0v28y6oN/b+F8rhqk5h5HmQY4jrUXt6Dhcl9XvFud7vHk6yf/1EcwzmVy17+bE027jQt9
	6DDTKKq+bxCjTKlTBMcmWtFllZ1guOvl1es58d2fUmhn+W3juQNu91w==
X-Received: by 2002:a17:907:3f08:b0:a7a:8dcd:ffb4 with SMTP id a640c23a62f3a-a898259d562mr216809066b.17.1724920016807;
        Thu, 29 Aug 2024 01:26:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpgPvAWdmdMwSpjC1P4giL7TG3nksWf9mUuwzWdS9aF/bqlDM5xYu2KySqyBFkeSGzQSLmJg==
X-Received: by 2002:a17:907:3f08:b0:a7a:8dcd:ffb4 with SMTP id a640c23a62f3a-a898259d562mr216805566b.17.1724920016274;
        Thu, 29 Aug 2024 01:26:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13? ([2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c7c060sm413582a12.50.2024.08.29.01.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 01:26:55 -0700 (PDT)
Message-ID: <26d3f7cf-1fd8-48b6-97be-ba6819a2ff85@redhat.com>
Date: Thu, 29 Aug 2024 10:26:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfc: pn533: Add poll mod list filling check
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Samuel Ortiz <sameo@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240827084822.18785-1-amishin@t-argos.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240827084822.18785-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/27/24 10:48, Aleksandr Mishin wrote:
> In case of im_protocols value is 1 and tm_protocols value is 0 this
> combination successfully passes the check
> 'if (!im_protocols && !tm_protocols)' in the nfc_start_poll().
> But then after pn533_poll_create_mod_list() call in pn533_start_poll()
> poll mod list will remain empty and dev->poll_mod_count will remain 0
> which lead to division by zero.
> 
> Normally no im protocol has value 1 in the mask, so this combination is
> not expected by driver. But these protocol values actually come from
> userspace via Netlink interface (NFC_CMD_START_POLL operation). So a
> broken or malicious program may pass a message containing a "bad"
> combination of protocol parameter values so that dev->poll_mod_count
> is not incremented inside pn533_poll_create_mod_list(), thus leading
> to division by zero.
> Call trace looks like:
> nfc_genl_start_poll()
>    nfc_start_poll()
>      ->start_poll()
>      pn533_start_poll()
> 
> Add poll mod list filling check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: dfccd0f58044 ("NFC: pn533: Add some polling entropy")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

The issue looks real to me and the proposed fix the correct one, but 
waiting a little more for Krzysztof feedback, as he expressed concerns 
on v1.

Thanks,

Paolo


