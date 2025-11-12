Return-Path: <netdev+bounces-238143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF1BC54993
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 22:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A81664E0FEA
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88D32DE70E;
	Wed, 12 Nov 2025 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJENCc9v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6E2A1CF
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982235; cv=none; b=YLzz8Wha7fjdBxuDRSFHhc5q2bjmslebT6zSTjXTaZpFCQGE5bFmPiaiB79vNSDnMKuWmlNopR2YspGjjYePz0Ss7UvhU+U1cMl90u6Eb1hzkThr1gFmTyTaD9HYJWcSF6pA1N7OrN5J7BqVtPJb5jhPAnboUfiyhSQb+yisO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982235; c=relaxed/simple;
	bh=Hv+MI87wNAeJB0MtR+ThCEGDtrHbVWd8n3vF+vNuo2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyVEK+fMKHHDlKLs8woU8Nc1HWuvdRzz5recSBJB+s5KEslJTgdVNXKVjmMViCPPQWLvaQ6lId1NBBN+R95W5MUANbdMdeX9pk6EKJLkKXaXhMjNh78aCJm7TMGM/AIDTvuZHntZhFfT2cqI5FqLSlIJivtoAr29z1B4jo2oIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJENCc9v; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477632cc932so572945e9.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762982232; x=1763587032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dfq7IiORCnaEGil0Gx1QeQnmkd9CjrRYNigvgURHSrs=;
        b=GJENCc9vFlYlsiz1r2MFNe5PisHE5qfLqlDaInqkqxHhHMwzMBeFwze8elea4mDUPR
         aY3iykSqEhw1R2ITYu+8LGtIoawKPxIVO3fWFDRr9Gw9EhTRhN0QWBPI7YCRo6EForHL
         x7BUM6h5XHywzJF2FR4ddSUnIBOisACP2sNZHAZs+c3/E7f17ORHZBcv3PZNxNP/6cwB
         Tg+MGJcrB003Xe2nYaxVxw1V7kWlTWfLSwf1v+a09m1lrWnC222cGVXMw5III00DarmS
         VGlXBmjuLt+oIdncobXlFkebuAuPIzcyo4sVHncurrp5TIA+VbLjR0JHhrSAcHLzuc0q
         x6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762982232; x=1763587032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dfq7IiORCnaEGil0Gx1QeQnmkd9CjrRYNigvgURHSrs=;
        b=XEzRZsswwwQUWXdawPofRf068TkUD5ZnGH/Io7/eJdD3WwONjNBr8YSB7X6YAG5pbU
         Bp+ppM3O/ujX5Oykb3XdhtldNZTec0MTTaDotcVJNSS6kgAxDIfk3FzMK/n7NYzi604O
         t14/dd3p2H6qW5NBi7JdXClUmcoV20bzix65VlKp2QviwMkEqm6XG2/hkTYA2qPZeSUA
         df+vxKBa0tINH0BSoa6ilptuejtjOoZsx8UuyTRrk1HGQ1zWGuSoPkl15i3tj0gDYMvy
         6821UlLjp6JP7Au0fs1qA0+wzX+gmB7t552NMJBv7tr3BZzrXSWzI/BqdQh7OR4UlV54
         19kg==
X-Forwarded-Encrypted: i=1; AJvYcCXo55FxYybllBC6qYBOLaZWkCTFRgUGW57Fh9ejTKYX0IYCJTNhQdrUxTgTp9q/7o6DxO34Dtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjntefmayQPGqHQhLWYMKntC2ZV0MPniBcltelQAGlfFNHqFnQ
	JdOTDqkJiw4QxCNhddnKUqLR3HBrHMdThxci0Ddk6goUV77K0E/efjJMo7jPWg==
X-Gm-Gg: ASbGnctnCL/aMEB6Uf+g0N9EJokk1/DzfaofR6m4t36+dbNv1z3QuyPY5hFSTaWHh4O
	sulUwDddy+E4OouzdaMMYN9tIo4aPgKhWJTF2qEwV4FcFECyQ0GOQEkH7hHNQCIWWrbkl7Z+CWR
	lDpeENzqQkU3MqiOTEUlgA4e94g94SPPYBtK5pfU+DU80JlGP7a/utX1yoRUPM8H5xmP2NYCH7s
	8lDiFH70t+D0XHE7rsbU72K9kjdRZaLeg5C7e+BBJD4Q0yVn0y4RW6aOtw7YuH+YFVuPEtAFPf3
	0dl8O19p3FJndkn842/c3NwtvikVE8MgUi7/OA7zl14vg1GC6MTR1b3pO49X4TOlvsQ6WY5SyyO
	9jRLeX/MkO2X4dglUUhZnioVXXOlMzNDu5is3K60UdkJW8MTHhmG0cQ9b52kzzclU0I/BeccTRX
	aC0Y3HZKTacfk/+j0y2QrFFeJgeKE8vUpyNv4l9uglhruoCxgjChMFORJEiVbIrBo/AdBwK7TRY
	Lme/ugQReCICvq5PRRc0aZf6m9PWTOHbBNeg9pwang=
X-Google-Smtp-Source: AGHT+IFEBgAmqP6sDTbjye4OdG3fWeZ3MM+uxcqobrNld8gb0/HgCLmtsFCbxxNCrkpKZipBjinz+Q==
X-Received: by 2002:a05:600c:1c15:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-4778707065emr51691725e9.2.1762982232177;
        Wed, 12 Nov 2025 13:17:12 -0800 (PST)
Received: from ?IPV6:2003:ea:8f26:f700:b18b:e3d1:83c0:fb24? (p200300ea8f26f700b18be3d183c0fb24.dip0.t-ipconnect.de. [2003:ea:8f26:f700:b18b:e3d1:83c0:fb24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e51f54sm53476905e9.8.2025.11.12.13.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 13:17:11 -0800 (PST)
Message-ID: <9f6f7b43-9153-4e56-a473-b9ad588f5014@gmail.com>
Date: Wed, 12 Nov 2025 22:17:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: remove definition of struct
 dsa_switch_driver
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <4053a98f-052f-4dc1-a3d4-ed9b3d3cc7cb@gmail.com>
 <20251112211329.6hm7an4lwi43kqis@skbuf>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251112211329.6hm7an4lwi43kqis@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2025 10:13 PM, Vladimir Oltean wrote:
> On Wed, Nov 12, 2025 at 09:46:24PM +0100, Heiner Kallweit wrote:
>> Since 93e86b3bc842 ("net: dsa: Remove legacy probing support")
>> this struct has no user any longer.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  include/net/dsa.h | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/include/net/dsa.h b/include/net/dsa.h
>> index 67762fdaf..d7845e83c 100644
>> --- a/include/net/dsa.h
>> +++ b/include/net/dsa.h
>> @@ -1312,11 +1312,6 @@ static inline int dsa_devlink_port_to_port(struct devlink_port *port)
>>  	return port->index;
>>  }
>>  
>> -struct dsa_switch_driver {
>> -	struct list_head	list;
>> -	const struct dsa_switch_ops *ops;
>> -};
>> -
>>  bool dsa_fdb_present_in_other_db(struct dsa_switch *ds, int port,
>>  				 const unsigned char *addr, u16 vid,
>>  				 struct dsa_db db);
>> -- 
>> 2.51.2
>>
> 
> Thanks. I think I also have this patch in some git tree on some computer
> somewhere...
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> 
> Are you working on something, or did you just randomly notice it?

When working on following patch
https://patchwork.kernel.org/project/netdevbpf/patch/3abaa3c5-fbb9-4052-9346-6cb096a25878@gmail.com/
I came across 34b31da486a5 which refers to struct dsa_switch_driver in
its commmit message.


