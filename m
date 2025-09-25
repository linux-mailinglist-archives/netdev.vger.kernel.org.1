Return-Path: <netdev+bounces-226202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C833B9DE3D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFF31892525
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 07:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A34F2E92D1;
	Thu, 25 Sep 2025 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiqVT9m/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3691A2541
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786272; cv=none; b=aT9UOxNhuk5QC1fnzkjBhd1ufZ6eMnHumG08hfqfiRuw33nhikzx3yFxj0WA5Do6WKLPgxlaQlKsD6Me4RBEVJwEG/7CKMLnPKvd7QsW45wuuDBqI8BDGrVlEAdRTHgxf4mxDGjJU+jmV9kbvtit9avYaBComLe3GagSVKGdzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786272; c=relaxed/simple;
	bh=ugLehOMIQJ+Et15CIYTCGD2MzcB90KpcWiFwRf+O/xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCvNtGGNQQKXajPhTzf2OlEeZjeOwm8pXnOE5nmlbEJXzQ3zvxJnS3ozkj0lVVEmrQkGEG2bBXFyWe78aOcx3ykjdV3RlWnYWxBUGN3NR1dbsRxWcQeSFis9TsEZig1bS/QXv1pwXOCPtQUonLfqPxUWIuPulgtx9LPLlczEvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiqVT9m/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758786268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEtIyjQBQWhfMNa18kEW2ePRbLcIzRH3NXOv/vzbj6M=;
	b=HiqVT9m/stYaMTpHP3rrhGgzVZPc7E9yR1RylkWpCLDSXAfYVFaEkeC6zcOYQ+2RRN6Pmw
	/3DwoTY+2cJUqyYzQVoiCzNXCf98eFBVsW1xkIUX3e4VJAG3zZg6PnituqQO/D8jesqlpu
	GywaPATO7PmMxABuX6WzTOe9YWaSzo4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-74KTuhnuM_CdZAk_rWpW9w-1; Thu, 25 Sep 2025 03:44:27 -0400
X-MC-Unique: 74KTuhnuM_CdZAk_rWpW9w-1
X-Mimecast-MFC-AGG-ID: 74KTuhnuM_CdZAk_rWpW9w_1758786265
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so2477245e9.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 00:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758786264; x=1759391064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEtIyjQBQWhfMNa18kEW2ePRbLcIzRH3NXOv/vzbj6M=;
        b=WQc7HTlSwMv4VaY9MSLXRYh1XV7MtIicjHEX8JCwjn/vPH9oB6aK0B58Uysc2SKjdU
         h9cNFN7H73g3xWRAdER1t4mMrPzVWWd4ybc94XlRy8go9CRmyfiuUSxRgUrpyRN0KU5y
         unv5JmTQzw+7q6FArM5q+/3cueIZnc/I/h1iqPf0mDhM3l2HhEYcR3p9GuexTj+H2HdT
         TAT02alDM4IC9ksvKfvbUxp8WujMfe1DEgZndeHE9id5kpoDaj4+fRO7Gt3zENTVG6ut
         QzuCENKyXSkTEuRe/R+rF9nk+QN2W8fGZbapeOf+CniO2XOaYPS7Lulkwb4JHFVriQx6
         Bjbw==
X-Forwarded-Encrypted: i=1; AJvYcCVV8sc02hEBa2jonXpDu9II6G3UfSol4K6f/brBUNQRWRr83Uvq6o1CSeV/xQFnlE3qj6fEpDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQjFKb1HA7iquxcdAVdqQk/NHLP5fCILHNEz6CDeTcodrjYRN
	VotTyCa0CrJyLJZAeg8zOuECyDaE7LZnKwneafudlFtcO+5JuJgGDh/nHmIr5I2aZWwQLurJD6G
	z92lGE35syxZEv3huMC0nGW3VGlTuk6hzsDR9b/bs2wUbcNOiohMtIHuymg==
X-Gm-Gg: ASbGnctAfpE0fEurZK58I4htltR+UZtPkLuBt6QES5N4mG3OrcxCMWBm951SbidNYiE
	q0O5loiYwpV5naczLws6zlOOquCiFG4ZfxcIae1HYPJWP7cSbxdnB9Iwgsy6Bp+4tsAI/srymix
	GprWtYED62AsGc7lYDIm8lGt6dj/Gu4tauMzoJ9NmPVUHtCo6UYQp+s1D1WZyXpdDfKDymT3h+f
	BGwCxbtgPF9HQtKIKw7ZaapuE7yO1zEjlhbRgoU5kMi5W7gvYJBPq4doK9ME6o19wNnE1QIvzEf
	8S8P5R1mWPKY6uJn2RUeM2qp16/lWifXxX9SRyfQpl/5UZQYbB5VzrRnVMCNGrmuzrMKyeNCyF1
	+x7eC6Egit+iv
X-Received: by 2002:a05:600c:8484:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-46e329f653emr17736505e9.27.1758786264602;
        Thu, 25 Sep 2025 00:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt7+vuVFRubxJxrOllWmSQM91xay34blZgLFJjzErhlGB9fkTHJc47Tm6tJsYcxZXKKZ/Mjg==
X-Received: by 2002:a05:600c:8484:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-46e329f653emr17736175e9.27.1758786264164;
        Thu, 25 Sep 2025 00:44:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33baa625sm21917375e9.7.2025.09.25.00.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 00:44:23 -0700 (PDT)
Message-ID: <ce0f60b5-858e-4d88-904f-5f77bbe82643@redhat.com>
Date: Thu, 25 Sep 2025 09:44:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 03/14] tcp: accecn: Add ece_delta to
 rate_sample
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@amazon.com" <kuniyu@amazon.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Cc: "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-4-chia-yu.chang@nokia-bell-labs.com>
 <161c09cc-9982-4046-9aa0-d0ec194daba0@redhat.com>
 <PAXPR07MB7984DC6C693DAED54AC14161A31FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB7984DC6C693DAED54AC14161A31FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/25/25 9:40 AM, Chia-Yu Chang (Nokia) wrote:
>> -----Original Message-----
>> From: Paolo Abeni <pabeni@redhat.com> 
>> Sent: Tuesday, September 23, 2025 11:48 AM
>> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; edumazet@google.com; linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
>> Cc: Olivier Tilmans (Nokia) <olivier.tilmans@nokia.com>
>> Subject: Re: [PATCH v2 net-next 03/14] tcp: accecn: Add ece_delta to rate_sample
>>
>>
>> CAUTION: This is an external email. Please be very careful when clicking links or opening attachments. See the URL nok.it/ext for additional information.
>>
>>
>>
>> On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>>> From: Ilpo Järvinen <ij@kernel.org>
>>>
>>> Include echoed CE count into rate_sample. Replace local ecn_count 
>>> variable with it.
>>
>> Why? skimming over the next few patches it's not clear to me which is the goal here.
>>
>> Expanding the commit message would help, thanks!
>>
>> Paolo
> 
> Hi Paolo,
> 
> Sorry for my late reply.
> Here, ece_delata will be used in the next patch series by tcp_prague (or other congestion control algorithm) that support Prague requirement to adjust the congestion window accordingly.
> I will elaborate more on the patch notes, or you think this shall stay in the tcp_prague patch series?

I think the latter would be the better option.

Thanks,

Paolo


