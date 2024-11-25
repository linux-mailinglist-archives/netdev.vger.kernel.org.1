Return-Path: <netdev+bounces-147273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 176CC9D8DB2
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 22:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4058BB21FD0
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB91BBBE0;
	Mon, 25 Nov 2024 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDqCHhAB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD5A17557C
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569151; cv=none; b=eJoeOE66QI5E0c8Q76mCA9hEI0eS0fR7F1+q5VTihisAhxlUN6icS59jpmJ+RUQ/KR8S5k0YB+JfVb+puQeLoQfY1mshknXKZuAvAFf+2+Xn2zjrVSoyLXDq/ji+qtzzIXLZ0sBGvHI/jX/DFQLwPcHb3z7Zt2Qn6UzmqJlmTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569151; c=relaxed/simple;
	bh=dyq4IQA4pHltVoC4RNAPuiVxjuM5Zge6uFwnQVblu+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYMM122nZpGXEf9UEQmMacwH1GNXCTFeUUCsmnUoLlqSD7ruQ0765ku+tBUR1NoMv/7KJQtmxKrb6e+Y94raCQiyXlGvPcu/72ApfnZAEC/Qy+O2tIkbrMQ26lr3MG9ATJ/EzTiDOR+ayH2VT+AIj0d4nKilsKewYUdVeBawNqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDqCHhAB; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71d4d3738cdso735916a34.3
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 13:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569149; x=1733173949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyq4IQA4pHltVoC4RNAPuiVxjuM5Zge6uFwnQVblu+E=;
        b=WDqCHhABJNo/I9v2MijvrR+FnG/1kgLcpWRuZ4vJ0Eh7e2uOPur3ZwGKg2339XeTtY
         Tn0J6JIfT5ji9eyjIr1ztGF2LBZYzfI+w4G9uljb2H2djt07yQHRwy5IrbMKpHMUBfYa
         dgvF5EC1pVdv23box7KqDOlEmZN1fYdS5ts0ttAn8fVi8G3k7WNTIYdv88t42NdmRaDX
         nREjwhU8ZOFGBb3Z50cY4Tz6dvHyklD4wvFtHrwB9U/WnaAbP9bqj6oMXcQaIXMyXMn2
         LGOuu2q5vmtMJNlCsA0vAgL6ohHsqjK97MG3XhQZDPOc6DVFAa4aZ2O/AWbRfNeavupu
         Rq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569149; x=1733173949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyq4IQA4pHltVoC4RNAPuiVxjuM5Zge6uFwnQVblu+E=;
        b=speMxSZDW50eSoZ+mo2DJgwhFRdIDypVL2XefmTtRIbHOyIbFJABqKR+E1U6mCCQlT
         JNzDcJHRnod1LT3zHvvrl8WoByftfpWWdowXW/RBzNN2zM+ln3BBV4mfW9sUwjPn57zS
         8J3eYn9+9yTyQlOGbLubMuecx72bTysvrN7Fk+3MPeHCnrlbIRlvyUvK431D3Gg51Pg4
         CsqoKJq5Wokocbe5tmH5+Ak8z66Ha1lVxTLa7+a0qP3Oo5WAzN4SngvCAr+jbL4QFI47
         XdOyrf+sML+rs7wxUmLSdHqCKQCz2xGYAom5FCwIBlt3FaJcaqKA+dYVxz8+Lr7EIM0Y
         1bww==
X-Gm-Message-State: AOJu0Yz817S4z5SflxTTN7IUfIxgbcHN/Q5dp2hRQDY6m4AtPnKq4QN3
	cjNI2ewAVRhUgj6JKRpi9xR6aC9lWSBIDrhvEFCQ0INig0oi+KYc
X-Gm-Gg: ASbGncvRSyRGeylLkCufpp5DU9uVPJKkHTTsE1N4RYJnVIHx0cnjLrMCfCPJuLf1yC7
	S8poWyXm4kZcj88qmKpMBj5SV8VV2ww9tldg3kEJuUFH/j+wbMbY4liO+/HR0bKJmYemvF5WN6D
	Kg6+6wHCooYs0ZdBO9mBo5BwaA2n9fubHKfS8UpYU+1XWGZ+oUCLcKKo+3WXBodv/FnTqhc62F+
	lsc39VrM2uLS9HEEWvNXw79GzvJSlAun3W5CVkVjprJxnafA9/gGMaz/PyHWw5n
X-Google-Smtp-Source: AGHT+IGE/NrNMM09+LLcKPnalx/SCrRux59sdxsSbXVBiit29ax75j2qE/I+NIZ4hMEk8jC4ZO4OlA==
X-Received: by 2002:a05:6358:5e1c:b0:1c3:813d:47c6 with SMTP id e5c5f4694b2df-1ca797d6c9emr714523355d.19.1732569149040;
        Mon, 25 Nov 2024 13:12:29 -0800 (PST)
Received: from ?IPV6:2620:10d:c0a8:11c1::138a? ([2620:10d:c091:400::5:527b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b23ed7sm47079026d6.75.2024.11.25.13.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 13:12:28 -0800 (PST)
Message-ID: <cd258b2f-d43f-4ae6-bd7c-ca22777d35e3@gmail.com>
Date: Mon, 25 Nov 2024 16:12:27 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC ethtool] ethtool: mock JSON output for --module-info
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "mkubecek@suse.cz" <mkubecek@suse.cz>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <DM6PR12MB451628E919440310BC5726E5D8422@DM6PR12MB4516.namprd12.prod.outlook.com>
 <f0d2811d-e69f-4ef4-bf0f-21ab9c5a8b36@gmail.com>
 <DM6PR12MB4516A5E32EB6C663F907C24BD8492@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <DM6PR12MB4516A5E32EB6C663F907C24BD8492@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/27/24 4:31 AM, Danielle Ratson wrote:
> Great, so when I will send the code (it is in early stages) it would be great if you could look at it.
> Thanks!
Do you have any updates or ETA on patches for this?

