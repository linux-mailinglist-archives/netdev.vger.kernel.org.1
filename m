Return-Path: <netdev+bounces-139172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AD79B0A5F
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 18:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E0B2804DE
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5341FB895;
	Fri, 25 Oct 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTPhygJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA631F80DC
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875283; cv=none; b=fCODconQzKnmgkVeS1yX4KtOJzuABxbIwoJUSvyCSW6fMDmavcsEmvFGZdiD8zmnQslgyXRgS3fZBmEpTEtfSnRhxU+p4Wl/KohEABAQ2RjRXmJwwEl9lUYgJIvNG2jVkqibHyk0OxY4osQgCynBtBiATt1Rf+8+Pq/Z7zJjRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875283; c=relaxed/simple;
	bh=38Bj8j0QHNFF9zA4YKmpn7Vlstozhghgkmy0cmStkD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raRBoKulfGdiYs3DpVGGva+zpWfIcPATL1OyhpRaQkexFLvkfjIcd/mV6lMNExT9d6HxA1lNkGRXygLx9hCfd48sVihtE8UoQAWaacFwDZkqiViQ2x1LuM9LubaC/0XVv1wk9CKGwZJttsyi76T0W+SPB31VLdroHetzFGbh4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTPhygJ+; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3b7d95a11so8110975ab.2
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 09:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729875281; x=1730480081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4x7oxPlklgkgPbob3SEvRWQSt+YBX/THkXoYo82qfk=;
        b=VTPhygJ+hekJ/ioo+W49LHuikzG26oWt1e+/sIi1AQwjX9oZi7A8iBw5Fwf5miYYGy
         uSUPdK5NoKzNgg2j/endiofjKZMI6INEr6vxC3cW8SU45G5jms//8YfABwFIpZjWavfd
         t7cqRuXRWYBZsck/FThYhzAsCr6JCBr61l/3l+WiahobMXTF8uKa8NhQDd4qAsNmGXxf
         vbmTcsl7h9tiwLIuIvYAjcf1oCSeh8nHZwKNn4jnGt7neuAHyNA2kNosBdr99dIshQa0
         qA5q2Ykusg6vOWWQew3YPVnaADp1paqLxLLVWmohhbX6Ar5rtEMSaWOLGVdDzKylkskN
         jGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729875281; x=1730480081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4x7oxPlklgkgPbob3SEvRWQSt+YBX/THkXoYo82qfk=;
        b=Ny0j3Ix/D35Qrdl78GNKdRPMZE6f7uUDmJCxKRI82NORu/JasKW58mh44BknFuj32q
         DIicIsXkmAneVwqPzDvJxfv16Hxs5It+U8dXqFT2tkfJzwIckYGUuaWAfxP2HsKZ/R1J
         KmgQElEH7TNPJKmLzMy/O5Q8FMuOqMaevuPBhMtFrPyzIff0eHtX+QB142Hy/WS7hRzG
         aJCVNnekDEAmPivvFOZRNBUBmIDnvi+OuDE1EXNIW1xNu3doc7VKvfp2JhBtZpL3XzSx
         gXFHDiM+V3bAIVllTJaskBFQlliNV2/bWXCymHd+zMI04u+X5tcsTJZcw2KcCEein4x0
         Rlug==
X-Forwarded-Encrypted: i=1; AJvYcCXgPr1bIxOSnvRdGjLKbWB26XiR5GNP79bexzB2ySVGA80Emd0Cqf0ypDwFnBTBOR0+OP155KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjst50jmAfQB4/rOTJhI2GAUBeaP5w43yPmw1OIjihP/SSN27
	5TJbG+zSVJUpAuuygiEjAe7mHLXLRafkM4N5swigVV6aws6iD5ac
X-Google-Smtp-Source: AGHT+IGlESpOLZnErZT95D/iIgO2KZSeNwv20OTBhw4FMFeSfsF941RT2m+GA8R5HsVp8FexIZKRBQ==
X-Received: by 2002:a05:6e02:1b03:b0:3a3:4122:b56e with SMTP id e9e14a558f8ab-3a4de840a0bmr66641525ab.26.1729875281043;
        Fri, 25 Oct 2024 09:54:41 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:fdf3:30f4:f45c:8fa3? ([2601:282:1e02:1040:fdf3:30f4:f45c:8fa3])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3a4e6e72b29sm3496865ab.81.2024.10.25.09.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 09:54:40 -0700 (PDT)
Message-ID: <ee6202b0-bfab-4b2f-87db-14b66476982a@gmail.com>
Date: Fri, 25 Oct 2024 10:54:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vdpa: Add support for setting the MAC address and MTU
 in vDPA tool.
Content-Language: en-US
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 parav@nvidia.com, netdev@vger.kernel.org
References: <20240731071406.1054655-1-lulu@redhat.com>
 <469ea3da-04d5-45fe-86a4-cf21de07b78e@gmail.com>
 <CACLfguXqdBDXy7C=1JLJkvABHSF+vJwfZf6LTHaC6PZTReaGUg@mail.gmail.com>
 <CACLfguVZg7AAShfqH=HWsWwSU6p6t3UUyTD+EaA4z5Hi9JG=RQ@mail.gmail.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <CACLfguVZg7AAShfqH=HWsWwSU6p6t3UUyTD+EaA4z5Hi9JG=RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 1:01 AM, Cindy Lu wrote:
> Hi All
> ping for this patch
> The kernel part of this tool was merged upstream in following commit
> commit 0181f8c809d6116a8347d8beb25a8c35ed22f7d7
> Merge: 11a299a7933e efcd71af38be
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Thu Sep 26 08:43:17 2024 -0700
> 
> Would you help review this patch?
> Thanks,
> Cindy
> 

patch no longer applies. Please re-base and re-send.


