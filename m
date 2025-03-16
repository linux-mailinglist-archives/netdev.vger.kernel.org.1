Return-Path: <netdev+bounces-175140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85FCA63751
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 21:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0C716A059
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 20:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CCDD53C;
	Sun, 16 Mar 2025 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njJ6/UaC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684B7485
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742155638; cv=none; b=bxSQgT9W0KG7gxI9uP3HNw+CoekTIlgl/B7qhZ/69bvvpH+8ALGSbWTvi87jt78fqiouin7KJmro8ByzjprZ1QBwjfekQjo4FE9fI38UlNreB9RHPOWO8DigTFusJ17nTe5jiz8L1TQ3QcHP3ww0SFmJwf0nNoOf33+oP56XGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742155638; c=relaxed/simple;
	bh=cUBqvPNca61xlBjPEuJhReeZ0bb4mRtjB6nF838EN+w=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HzbPOvE7kcgzldr5eUY2nB2pff2bT3t79fd5CHVg/SZbQWzlGMuBOg7V4jS1fCNjtuE5NkGOlFZ/ou0Yhgs5k78VIcNouSNtgF2J22jxD38Oi0UYiT2ybCBshd2Isw6k/pv2C7iWKqMFjVJ8eTdHtQj0uHuU/N9fkV+gIv7JUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njJ6/UaC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso16280515e9.3
        for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742155635; x=1742760435; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCXfyI/K5QPg6cCTycO2U40eJ5LKRNc27d+bEn9/kg4=;
        b=njJ6/UaCZt6bxOtsJZgNgo/tQc0kSi/aHe2gK9X4W8j1ious7JPoebEFZReFqNc7Tx
         usQPBYrEsXKjI2+FuEY+LU2KPEp4JEzfGkjnXBIAl6rpUjI263Bbg/cKDFRGwZyJHXPX
         27LuSlkObPwp2c5X5SO+YX6zZkRAIunJ1NX5Vv5y5YIvK+/1ku7wX+hY/hwzKNRYRMVm
         JXtXyxdhxHZEVlC5wjKBRWkbg7wqSe6x/pcgLtf6Dtdw8aJxOvsUH7DSGAIRq1Xvzqu3
         Dj/9WjeQlU9V1EuX6n8wkJssmkAZJREFeP2Wi6xtcGRjHtIAwaeEkuUfdnS9x2frZakh
         adtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742155635; x=1742760435;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RCXfyI/K5QPg6cCTycO2U40eJ5LKRNc27d+bEn9/kg4=;
        b=YD27y2HyGBusoMZPihJn7esPt/KSDSyEKSLQa7YsnCutH7nmrCtpve5lhPk0fXjV2L
         B3T/9CZwUxZKZTgAF4zxrBfH6zOqLZH/VyWj9lMel1CPDj7n22qeJbk0qTRGmPU8Kw6m
         FQMA+W5RVAF6R3oVRH4upsRelnKpa6Kod0ovCIp2m4VOFR5qQC+TXlBGmGZFdwDtnT3R
         T7zSWJN5vfXRN/RQ2f8n4XOA58TweeEytJzehBkjxcCtq0dVZi7SgJlEeQQgwh2dRgDY
         GOsdJSFSPgSyJad3tMhvhf4F2duo1z2SH24VGx/VXzbUo/2AAjVCA4ZSKuxi4RB7Htvf
         014A==
X-Gm-Message-State: AOJu0YyHgruYhkDjtOaOTKFLMnKDtiZaVV4qnUyCI2j2m2VuqML7mU3Y
	0WRniwj//735Vd+o+px0h4cj4DvLhzQf7mtjDghVXgihqkciEYFmNh+68Q==
X-Gm-Gg: ASbGncvQEN8h4omqhWtPd78U1jgzcmAwCvFo46XJr3ElZAjejGKyw/qwjeCtfnrxrjs
	h5+Fqx6oe3DiCbS7xe8bnWHMbtfiKK97c1/9lmkbDJfWsBNlk2tLpE9tjgKuA9elCItW4HOkREx
	xCa5kOzorR0Y05GEq1OTXezj40MCSrlvYcustXDOy5utRylCzMzqwdjobt8AkE5vOYR7dga1YNT
	SMRy4S65MXSBhlYWJuJSOzIi+/fnucJVQIRYSURIMCd7MVvR7Hq6FTqP/WZ2gxMkzVCcyeswYYJ
	v6G5/sWDqh5DGyCDSWRVdNtOtW/HdfqABIa1bcFzHoCpIhEK0zGZicfc/nHVzusk6w==
X-Google-Smtp-Source: AGHT+IFCY4ppdTgSH1KlJWZAsL58CDLPlVWPd2C3PmgNYywcRKK0ms/P4Otc+kUQxRzd6UIWX5uWBw==
X-Received: by 2002:a05:600c:4796:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-43d1f84a89bmr88018115e9.27.1742155634987;
        Sun, 16 Mar 2025 13:07:14 -0700 (PDT)
Received: from [192.168.1.57] ([82.66.150.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda30esm87067245e9.5.2025.03.16.13.07.14
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 13:07:14 -0700 (PDT)
Message-ID: <881f5c3f-b766-4c0b-b6b8-a147114b0253@gmail.com>
Date: Sun, 16 Mar 2025 21:07:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Content-Language: en-GB
From: Alexandre Cassen <acassen@gmail.com>
Subject: Nvidia Bluefield-3 IPsec Benchmark
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Please find here : https://www.fastswan.org/Nvidia-Bluefield-3-Benchmark/

Stress tests done over Nvidia ConnectX-7 (using its Bluefield-3 
integration).

Top perfs for Packet offload + XDP

Cheers,
Alexandre

