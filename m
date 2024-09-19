Return-Path: <netdev+bounces-128986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE8897CB65
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 17:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC731F278D5
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D191A2C34;
	Thu, 19 Sep 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRk6f5Lv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F01A01C1
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758713; cv=none; b=rdDMBiLvbylrbtyy3XOtQX9cfmYEfJMNFQmEb93G4C05d5suVpUubqRW/WJVE2x+WUH6kT39qV57DdZILBq6msL9ocH9sUiR98X43ufL23jRXb/vaBXULF/M6Kmq2UMZlZiZ+nFEXuSIKBH/L8LJr14cNiAy8Ls6KJDnXK7Fqjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758713; c=relaxed/simple;
	bh=cOTpCCcYN8ouwxcZ7yiWaqBgX0UfguEywivn45jiqv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPK7clpL8ADm9k9WVBIW3z7E7OUdvcX/SHEquT7dM71lgX3MooILrZcB7mevse3fX7s20iQXbZF6QruwIXGJ2jKck+pGCjmDg5c7iKeLRqyK+8XzVxIzpeTIAfTNxTzNRigKivSCaUiqJ5VgxkTzz/WNSjlt8A9fIV+G7xXmjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRk6f5Lv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726758682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJEclnwidI9173RuzovtuDHoL7BhkIW2RQWXN6ibzdE=;
	b=IRk6f5LvV+t74urvRGtsQZHyELZ+J9Np6/Qu2HliTjbftMcNtRkMadZbzviTQTHi69owwB
	6pUm15swOY2Zuj873oPsACkTacnHqSQViS/cUHOmj25CoNwnZhLXaC6/TtgTFRZ16gn6dx
	KOPOLppqy50Rp3jnOr0JadKeJw17XzQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-Gw3-06f9NomFSWrnA1Z1uw-1; Thu, 19 Sep 2024 11:11:19 -0400
X-MC-Unique: Gw3-06f9NomFSWrnA1Z1uw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb236ad4aso6061095e9.3
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 08:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726758677; x=1727363477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJEclnwidI9173RuzovtuDHoL7BhkIW2RQWXN6ibzdE=;
        b=F7aaTl4zTNowsq8yS2oURUdNa2kJUFTgYCxye/etx7QL9gkjLrBv0otKCSdCxktDr6
         Ml0xsEyVeT5Y3uTbGyFBPSLGec42l/DKjVBL88yt5Mz1mhjV8ydfoyv9Efj/x7+Na018
         KzIEBe9v8b6cMjugPLQt05oHQdSBJg2u0CtSlXCqMV7iT7XmDWPF5BR4tAwSxWPBwnpE
         pUyg+i1vJ1eme7l7S1LpoGl64KAESWrqgDhxQN3kXhf6+q1IyYtgIHRvVSnUYogyNtoy
         qwIyPObvrv7Wdl4x8hjfllaZGQpVm7T+8qKV53WDmZe14DEmgFD7xJ17GJu9fTv5HzI/
         bMxg==
X-Gm-Message-State: AOJu0YwOWudbA5SxqB8+SBVJLH35HLy+KLheI2ovvA5mE2xbT2N4ri+j
	D4sMloQGnM06WjR53yQLGIksMSZrGaEwLKARmLSgEzd2VsSIZ9ySJYGGOL9NFD4nQ/LdaKUb7LB
	VZ5YuZciJXxZqlaE7gOra25c+M/JCo14qeI4SoIQKShpcoIso/cLCig==
X-Received: by 2002:a05:600c:1c12:b0:42b:afe3:e9f4 with SMTP id 5b1f17b1804b1-42cdb4fb823mr208889855e9.3.1726758677453;
        Thu, 19 Sep 2024 08:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC4cB3CAxVsgvjqszMfytyqacuQqCAf8/XBti3mW5PirHzEZ6nH1BI1O3Oy3ICGcYDpdFQsQ==
X-Received: by 2002:a05:600c:1c12:b0:42b:afe3:e9f4 with SMTP id 5b1f17b1804b1-42cdb4fb823mr208889645e9.3.1726758677059;
        Thu, 19 Sep 2024 08:11:17 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754a6379sm24114225e9.35.2024.09.19.08.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 08:11:16 -0700 (PDT)
Message-ID: <29e3378c-5f12-480e-8531-d1afa7d840dd@redhat.com>
Date: Thu, 19 Sep 2024 17:11:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v7 net-next 02/15] netlink: spec: add
 shaper YAML spec
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Donald Hunter <donald.hunter@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, edumazet@google.com,
 Madhu Chittim <madhu.chittim@intel.com>, anthony.l.nguyen@intel.com,
 Simon Horman <horms@kernel.org>, przemyslaw.kitszel@intel.com,
 Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>
References: <cover.1725919039.git.pabeni@redhat.com>
 <4ac641b1cb3d0b78de3571e394e4c7d2239714f7.1725919039.git.pabeni@redhat.com>
 <688515d9-9bf2-4939-a3c6-9b22a886dfb9@molgen.mpg.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <688515d9-9bf2-4939-a3c6-9b22a886dfb9@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 9/10/24 14:08, Paul Menzel wrote>> +config NET_SHAPER
>> +	bool
> 
> It’d be great if you added a help text/description.
> 
> […]

Thank you for the feedback.

The lack of description here is intentional: we don't want user to 
enable the knob explicitly, only via 'select'.

I'll handle the other comments in the next revision.

Cheers,

Paolo


