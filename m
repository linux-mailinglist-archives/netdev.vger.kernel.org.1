Return-Path: <netdev+bounces-65170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8EB839676
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C6328D7C1
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BAD7FBDC;
	Tue, 23 Jan 2024 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="thE0q5pO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAC5F555
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031157; cv=none; b=UrcMh+VkCNTjG5OLVkesZvXaMXn+n/l9HSWMbwh5hOGyVVwosTPhFoCG3GOwpbV7fq6g6HtokX24DuM/nxl/IvxyuOse1vh4dgeCIDbLms74jWHhxRkQpUTkpbg/aKvTWod4WibPI2eu7og9QNMB0GRIyhmkPbPCqAzllhiEteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031157; c=relaxed/simple;
	bh=PCC25MdyIxDx6+nyvkbKRYLn45NYp/L57eAn5i4rk8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gV8vZ7Om8lb8EGn3z2iUxc9vkroWpkNDMprwm1+IbhG5p/eCekatft4V5CwGQUUXWv1RA4cr3HLv8BfzoqHfaGiEBqYllS5GDgMguWT3jaQ4mkU/7luLf3jTuj4SjuvyOyCwN3IynbLCoPwXJCeHzaEBDMPn5vW9vie5xhQ0rG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=thE0q5pO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cf450eba00so3729969a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 09:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706031155; x=1706635955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMkl4lrGe+Wjsdlxgu4GaqGG6Nlrj4aqXcF+J3uPhls=;
        b=thE0q5pO7+qR0GDX8DNh6rzkGtbC2eC8GFNDYa3+PzLGFRHVvmv1jTsh+LtzWHZItK
         IjEz6eiiyFp1SaWtTjpk0UtCsjxovqZDgqE4H9XD4BHEe77QGtr1IfXqculqt9HQynnh
         C/hdaL4acejeuXHVr3odlydxKCcenGb9ddouctirJ07fFN44T0+NSY+8c/cYB/iP5/a2
         5ygVbZA9/wQKdLzgZHViRKYXqRH2obo8sITq2ZNN3mbrfcS2VWySnSUrBuKAHxEbinsV
         cMXEu4irwQmZeSuUgbssaG+vi2AreTOJnC8ooo01HrpIyUln+3JUDft3OaMNkhMU/ft4
         u40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031155; x=1706635955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMkl4lrGe+Wjsdlxgu4GaqGG6Nlrj4aqXcF+J3uPhls=;
        b=vi8QlmSR/aR5Defq5oqHwzMeO+4FrQRCQZajjHnv3Z0M1GyEvwVShNxuufwocp87SH
         4yrNGOwZrj0z3hPsq+g/UYI3+aajG0VT+xKoYMc7DuupOVkZRkqBqRXOIP88KhPlAFoX
         HDe0aXfb9Qx9VF1mhPQzfZ8JuAUjuRt4c4j3w1rdtQzyUGv8qbjjWyYJ+0mdMlk7ov6J
         /nsrcsQ7SB5SSHds1sLrU7a3Kpok83qH82nRBIvVXarOmo9vmZGhgt3vsPvocsOtiggD
         qWAiUu8U46TMvbwgT0wnBx3QdbfaQ4rEbqHMCtBd7KjXWMdr+YxeHlrmr7PjN0AsEpgJ
         FmTQ==
X-Gm-Message-State: AOJu0YxyHv2RYQNzKT1CjK8DOTzpe6cKS0zK0Rzmj1WU4QEv9b5n6O3X
	JwBBxoPHgoiq+TdVjlUUEKQ7u6tYsOpVSJAxuXCat/5761QqPIjbefzjMIrI3oP8g4/KTEkp+Yt
	tnw==
X-Google-Smtp-Source: AGHT+IFNWNTdQNslghgClw2xe8yvbEem/mhABnYiPMWm3vNgACl+wPvDxWlsfZXyoPnlfCeUBjRg/g==
X-Received: by 2002:a05:6a20:d489:b0:19b:62da:16b0 with SMTP id im9-20020a056a20d48900b0019b62da16b0mr6531307pzb.5.1706031155183;
        Tue, 23 Jan 2024 09:32:35 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c1:2229:1771:59f5:c218:f604? ([2804:7f1:e2c1:2229:1771:59f5:c218:f604])
        by smtp.gmail.com with ESMTPSA id g8-20020a635208000000b005cfbef6657fsm6459747pgb.58.2024.01.23.09.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 09:32:34 -0800 (PST)
Message-ID: <49ecd3a7-caf6-443c-9519-be300f8866ec@mojatatu.com>
Date: Tue, 23 Jan 2024 14:32:32 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] m_mirred: Allow mirred to block
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dsahern@kernel.org, netdev@vger.kernel.org, kernel@mojatatu.com
References: <20240123161115.69729-1-victor@mojatatu.com>
 <20240123091811.298e3cb5@hermes.local>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20240123091811.298e3cb5@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/01/2024 14:18, Stephen Hemminger wrote:
> On Tue, 23 Jan 2024 13:11:15 -0300
> Victor Nogueira <victor@mojatatu.com> wrote:
> 
>> +		print_string(PRINT_ANY, "to_dev", " to device %s)", dev);
> 
> Suggestion for future.
> Use colorized device name here.
> 		print_color_string(PRINT_ANY, COLOR_IFNAME, "to_dev", " to device %s)", dev);

Thank you for the suggestion.
Will send a patch after this one to fix this.

cheers,
Victor

