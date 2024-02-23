Return-Path: <netdev+bounces-74375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B28861105
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FF0285786
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124027A70B;
	Fri, 23 Feb 2024 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+Pir3YB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656F76911
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690032; cv=none; b=r4LebL7k/4wm7HgcBd9p7b0vXHlaP6qwHgbxmsGr0znsVojgQQKDy1y7lO9CO8N2ACEzj67TRobyf/0FZSttcgCpCd/De0vP812wmeRUt4Dp2b05prUL9rZhgC14g5ITyHQ8r6M5T7pBoybGth+G0mtQPBpRdwH00PttOogtYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690032; c=relaxed/simple;
	bh=Kd1JMJMXlkkVR4CwXKMm0PiO3g+HEzckxlhd68zKTyE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uo//CIWzqCwAvKd/SXfkQtjhyd8nXApPLjikifX9AMI2287NdA84UNYvMZypCid8L0QPo9NWvD3tRhmj6vIrfjevjF7LWhU7gFEbNQVEw/H2cvfRWGS8CnfFpn0JNSHEhDffy1Gofl5kqLUHKzPmWHlzRW6qs8d/wUQzo4I5dcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+Pir3YB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41296dce264so1813455e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 04:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708690029; x=1709294829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8S3wQ8mpD94daQuPMsiYw1w1VPhoKt/BYMaLUT2WWOI=;
        b=L+Pir3YBf34i1jDq5nfbzcnBvG+L4O8H5ycYd2Vdda64EaHLs+VnQJY32/irdV/2nR
         uxxWznl7PAQWsrQ06EQf5DpJWOFOU2xkmH7SqtbNHfz/AnE07wkiZGogYcpJt4OEYrlX
         aBkfz5pF+N1wtWQ2aP3kmlhoKtBVzIgUr78N4P5MZw5EMX+yjn6ofeXYeyCtPvMNFx9u
         WAevxODlSTQb7lzxgKrCq92hzlWONyibAz2Q4bMt8+7sbEKxMeV2h+wE5Bv5CwwSmAh0
         H0nj8gByf8dExIoH8Hv3ceAn2nNH64GICPyOPRbPN6SBZRI2sEtsfgTVuyjr2zD3Doxt
         eakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708690029; x=1709294829;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8S3wQ8mpD94daQuPMsiYw1w1VPhoKt/BYMaLUT2WWOI=;
        b=NAFLsTcfPOdRc1kqr6PeGcf1Ufvkev5nQo9kfDbn+pmuD6EisUTY8eWBac5o9L9d4T
         gc5R1hUBlgIj6TEKVtZfCz2s7Ziqb3WcZgnGYwJpKsQuDbTWxpjTMQCi+3X0vrY2/PZG
         3Fo4SkzjpdsurGjWQybz26K4HbJQryxo3I8ntvF/ZQSTsquoLvQlFCaleF6F5MXFcOuI
         W3pvrrml+cDhybS3VbfPorfDu8PwDDMVrwGHTcYhXlTti+Hjv6ZVw0rP4WS7WW/4s0PH
         Exjzy52NgqOa/833EwrvQRv0C+ktRC5nRSwprjpH3fqVAz5ufEhtdQ9sQtvVhYlqFpaA
         Ir5g==
X-Forwarded-Encrypted: i=1; AJvYcCVrzUkAMwFvFeQY/7Vx21CValeMRof10I4tYMBIfhKMx0XAsnW1qcKfAYU2LePOfiAf8sfDnMjMvDkFVk9UXI2cpNLoORTq
X-Gm-Message-State: AOJu0Ywe2jJax+KGcHy8TofTfgQ5cL0TqudSqFN31DQ23hdKRFUIHNMW
	zvMIPIk4Bt/oWe6RBtRJMbKCCYJEI2hCWzmEejyGNTw+x+bayDGV
X-Google-Smtp-Source: AGHT+IEoNmpoGWrKbWHW8R6gqoLuKDBICJHrndcmEKVchX9EfwMBbq+GpykYg/TOq1b9ZLKslQSJkw==
X-Received: by 2002:a05:600c:3115:b0:412:398d:19a with SMTP id g21-20020a05600c311500b00412398d019amr1032828wmo.24.1708690028505;
        Fri, 23 Feb 2024 04:07:08 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id c23-20020a7bc857000000b004128f1ace2asm2067219wml.19.2024.02.23.04.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 04:07:08 -0800 (PST)
Subject: Re: [RFC]: raw packet filtering via tc-flower
To: Jiri Pirko <jiri@resnulli.us>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, stephen@networkplumber.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, corbet@lwn.net,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
 "Chittim, Madhu" <madhu.chittim@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 amritha.nambiar@intel.com, Jan Sokolowski <jan.sokolowski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <5be479fb-8fc6-4fa1-8a18-25be4c7b06f6@intel.com>
 <20240222184045.478a8986@kernel.org> <ZdhqhKbly60La_4h@nanopsycho>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <b4ed432e-6e76-8f1b-c5ea-8f19ba610ef3@gmail.com>
Date: Fri, 23 Feb 2024 12:07:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZdhqhKbly60La_4h@nanopsycho>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 23/02/2024 09:51, Jiri Pirko wrote:
> Hmm, but why flower can't be extended this direction. I mean, it is very
> convenient to match on well-defined fields.

Flower is intrinsically tied to the flow dissector, both conceptually
 and in implementation.  I'm not sure it's appropriate for it to become
 a dumping ground for random vendor filtering extensions/capabilities.

> U32 is, well, not that convenient.

How about a new classifier that just does this raw matching?

> I can imagine that the
> combination of match on well-defined fields and random chunks together
> is completely valid use-case.

But is it likely to be something that hardware supports?  (Since the
 motivation for this feature is clearly the hardware offload — otherwise
 there are other mechanisms like BPF for arbitrary packet filtering.)

As the vendor behind this, one hopes Intel can comment on both the
 hardware and the use-case side of this question.

