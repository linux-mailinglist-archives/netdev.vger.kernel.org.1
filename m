Return-Path: <netdev+bounces-135935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D17F99FD52
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1050F2824FA
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFAB10A1C;
	Wed, 16 Oct 2024 00:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AArDDwWl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13E1097B
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039353; cv=none; b=SuDMvgR8iNZjvKPJzoBrOXYOZJ9gAZ1w+YzlLGdh/OYyMK0TtpQJfkdHl6Ib/hEcujCDw0ofaIRHx6nBk8WuMsDi/Z9TwdOKA0AggOgExsmTUmXISU13j3XApxGcYiAOFQ4iG3vNdAcdViSNoIY8CXgoeWmjqNokot26w5q95M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039353; c=relaxed/simple;
	bh=L8Q8qpJfCaCE7Q/0SdKqr4Ppr5gsSqj9uwoMS3P1hIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbu50z9zqU5415JBGZGX7AXi1c0AhSxmEL9S0p9Xi+BUPXxVEl/DB+77RwvSyHMsu3LgUc1BVWjIQ8hKL6cYs7ek+yoFY4LqTb3z2Thd+vY1uuopf2EoVfzrgKNh9+++9wvNM1QoGlWEp0fnXHuQyUKWBVxIIXzjQKs2ViK7Zes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AArDDwWl; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cbce9e4598so39800316d6.2
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 17:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729039351; x=1729644151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqmwkpLQ/gsJYGO3lKpckNbCmMjQD8PgT5aXoiuk0mA=;
        b=AArDDwWlAUbwXQVbO+B1M3OhIsK2mMdIQIZQQsaiuyiuzovn1uVmYDE5XjrOktAd8x
         r7SKw5fLAIM/3DxYMI7YD38CjQUHpMKGUatdH5Ju+gIwzFxj6wnuPIVSmBYbqHEWCRyi
         PbvWvPlweQP8jwszIiC3NQFiPSDxH/OWx1iNdbg7381Fd43+91D/qv5VRSoxnorSyn38
         QtGZk1vgVvsTDBswM5bkAfV3YZ62v5QGueDIENrT+DbqGECFDbRrT4T8PUNh/JeJ0tSI
         rikTetno5r2t8CCGEEj2sWipZIOcQN3VwbwwmcJXlIPxAHjJuzsUBTTEzowIpfRZm1iP
         VeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729039351; x=1729644151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqmwkpLQ/gsJYGO3lKpckNbCmMjQD8PgT5aXoiuk0mA=;
        b=jtoszfxyrgiAi2IoY5WAnhL8Wpl+h/vWjuNcxj08JvPbVy+FgPG69W13cCd7buLmrn
         5rG/KmtNhRTh4l/t4ixEvki8bnH9urRpV6x8wqtIKxT7ByP17x7XlUulaNm475FUugcL
         c2z9kvtmBZ56M1vZrnEnl86eRZktUsyztR57qbBFMWFFLwrxKbOA4RXk82R53isv7MBm
         ZjIuoau4GkNJOgga5Epm8nyoIkB8oRdynGBgFxA4jmNoE7iFhlwxZ4OCWLOx7FDvh4mo
         52kFvX7eDIBp+34iB2YicrmTL20ErFF24NWwe40AJ79yIyRgH6YSiIqUOLIKjLYCuKOX
         IjBg==
X-Forwarded-Encrypted: i=1; AJvYcCXe/QCIjMU+Oh7pIHa1IGzZunBKBm4qu1kuP0Ky76pV12JW2licH68Ay6TDqBJIwB+MMgp4QR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIM6Vc3i5t+Rv9h3e/9+vnFnQqOZMOZxMcB0Wni1GvJVKpmRIf
	BgoTgkx+YW00ur9oXs5DSpDiJicZ/x19PIrvvI11L7+oGLaack6q
X-Google-Smtp-Source: AGHT+IHyxsruF7k/NrdPy4+YIRCykvf51b28z+y5y2nJnt6dtwj1EDgBZuXEPSViTJkM5xKBg2hjog==
X-Received: by 2002:a05:6214:449c:b0:6cb:c9bb:b040 with SMTP id 6a1803df08f44-6cbf9d0bfcamr194842936d6.3.1729039350842;
        Tue, 15 Oct 2024 17:42:30 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11c1::11b5? ([2620:10d:c091:400::5:f725])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2295a367sm12123136d6.90.2024.10.15.17.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 17:42:30 -0700 (PDT)
Message-ID: <51205a15-762c-43b6-8df1-0cbfe2380108@gmail.com>
Date: Tue, 15 Oct 2024 20:42:29 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC ethtool] ethtool: mock JSON output for --module-info
To: Andrew Lunn <andrew@lunn.ch>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, idosch@nvidia.com, danieller@nvidia.com
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <816b36d3-7e12-4b58-8b99-4e477e76372c@lunn.ch>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <816b36d3-7e12-4b58-8b99-4e477e76372c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/15/24 7:16 PM, Andrew Lunn wrote:
>> Vendor PN                                 : QDD-400G-XDR4
>>      "vendor_name" : [65, 114, 105, 115, 116, 97, 32, 78, 101, 116, 119, 111,
>> 114, 107, 115, 32],
>>      "vendor_pn" : [81, 68, 68, 45, 52, 48, 48, 71, 45, 88, 68, 82, 52],
>>      "vendor_sn" : [88, 75, 84, 50, 52, 50, 50, 49, 49, 52, 56, 49],
> Why use byte arrays? String, maybe UTF-8, would be more natural.
>
> 	Andrew

Ah, I mistakenly thought that the "-" characters in the vendor pn were 
put there by ethtool in place of non-printable characters, but I see now 
that those are just regular ASCII hyphens. The CMIS spec says that the 
four vendor_* fields all contain ASCII characters, but can possibly be 
all null characters.

I agree. Strings would be better.


