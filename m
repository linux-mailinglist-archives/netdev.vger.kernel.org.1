Return-Path: <netdev+bounces-213613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9F1B25DF9
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49779E738F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8967828CF79;
	Thu, 14 Aug 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ki5/50s2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D896D28CF6B
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157524; cv=none; b=nSMENrAi0I3dmd6zJSbsJf4ar97OXahO3qPIm6waobEHbflYEY+CYYgi+hGVEHhxsSSnmbyurk/r9oVsaUhUTbx6QLk3NGilS9qavQgSXGqGAgyChWAs/tucLnAvIXafx62vdrp4WxubpuxqeFA/5/6jFgRdVzEiLl3/ha9fymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157524; c=relaxed/simple;
	bh=KSWLnoTBOlNzYx5x5XVZJ7YKJEDG7DMm3pzboACqSU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eVxXYr6R3sS4Fo4A9/O2cIeOywgLFelHfDOx9nYTY8RoC1EaoYQiekKhP3x/Rc717wfOuSAnR5YldkC4MVJ+7cAwAVZLpYjp92yc+fIjdQrY5Jg3vTa2PQRjtF/ej30mPyI6RI0bHxf2lxBo4xFOWGYhhTQt1g4LQJ1gDMrM0qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ki5/50s2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755157521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh3fAUzpnwErAtwtO1rLAD+DknqFNguq3c79rP/CRi8=;
	b=Ki5/50s2e0zwaPJ5zlepwjwETpgveZE4LACfc0yXXySoDXdrnzGklobL3Sekl6NFIV7Mb2
	spE+7GA0YIN1wdg+Ymt6C9YmfvNY0WRo8WVcICB7icxPO4bVCGVBQcKmaLqo/pObgHtJip
	iylIq1VcDOzZbH05KijECQWOgHj34ic=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-OVqK1UOjMBKSD4ytzXsIEQ-1; Thu, 14 Aug 2025 03:45:20 -0400
X-MC-Unique: OVqK1UOjMBKSD4ytzXsIEQ-1
X-Mimecast-MFC-AGG-ID: OVqK1UOjMBKSD4ytzXsIEQ_1755157520
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a928da763so14989196d6.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 00:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755157520; x=1755762320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh3fAUzpnwErAtwtO1rLAD+DknqFNguq3c79rP/CRi8=;
        b=glVVw27QBWMuGQQj021tjaVl3EW11QRMfzKayVv8+cGDOlzcPePzr9jpF3Q8LqUlYK
         XKciTu2pJdgWidc7amI7/p9kUBNHTOfOVdqlVnZRJOJBSh7/umZND6asOjfnzL07GuW/
         q9HCcF2DFG2A3Ythy746WZZP0J6VnlZ7c1N+PxAhMCcw+IrQ3pGPVsumMc4S5sPEuwPB
         tqqpPBbyy/RgolPFvH4qmcTr9zN50oRxItYR4vE7hynkO9dpfBUTO+H+WYRf/LeEfiN9
         L0ZEtMD1x6Mpb0KfXwj+/mVxeBm+FRZnocRIhkbITFnCI2e1ijI9SFuySELZBZKiVtLS
         Yllg==
X-Forwarded-Encrypted: i=1; AJvYcCWPMgoTZ5zj3j8Tvw3SBX3JRcQ2ZTEfymdU+0K+z/5w0SI8OINvdrjwezTdyXSecnhHX8s8Xps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4WuVr6vf9tbD98V4906k4muR0fKnJSUzFtSvwemnSTP7L93E
	gf+1f1e0p8mzsVhwU9ojXyHwNLy1E75n+19n/2nrxIERg66rLlPwkDfgYXb6bOEy/mxLyinJape
	cxxaibUkA5yQRiHpg46uWjNPzHLoWvhOxGbP8EcrERnmzmaYJl2pjWwut1g==
X-Gm-Gg: ASbGncsYQ6vPrUjmZdh1fX2lxLa0QOjl62tWNfWfnxx6PRWy/INeuHyBYDhsxILxAP8
	Uu0ILy39aLb7z/S/dIkdN3dLU1PjF/VZrdD2N1qxQqnepupZkDaCRalOEWTg1uxLjmygt84yZC0
	RpDE9FDXZZ+M+S4z5wC1x8GsMZkfOEXYqCGQel0ueUKGJjJHnpLnPek2rKvo1nsOPklGZpwIA1B
	V8f4fB5MGDPkOB8y+qZktM0aSywrL/3WM1zSMklRghvTR6B0yuubdb2VC/qTcLWfm3cH4IwqnAb
	iWPlkc1wQgOJh75wLbOxUMyI89uszWwPCyj1ELnZjzdbXxQDVjVF4FWBwilRly7+7M4zoUEItMh
	HUbevTcXm5No=
X-Received: by 2002:a05:6214:2aa5:b0:704:7fda:d174 with SMTP id 6a1803df08f44-70af1cf09bemr31867966d6.2.1755157520027;
        Thu, 14 Aug 2025 00:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW6lRrp4NlQG1ZkIRQnCbAccBSIpsmnxNsHLJGiUzBCfXvnS33GU0a29KgbaqXmSBQXEvaOA==
X-Received: by 2002:a05:6214:2aa5:b0:704:7fda:d174 with SMTP id 6a1803df08f44-70af1cf09bemr31867416d6.2.1755157519405;
        Thu, 14 Aug 2025 00:45:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5b0692csm9715536d6.46.2025.08.14.00.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 00:45:18 -0700 (PDT)
Message-ID: <274729ea-8db3-41e4-9dfa-f33e5e65222b@redhat.com>
Date: Thu, 14 Aug 2025 09:45:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 00/14] AccECN protocol patch series
To: "Livingood, Jason" <Jason_Livingood@comcast.com>,
 "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@amazon.com" <kuniyu@amazon.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Dave Taht <dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
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
 <rs.ietf@gmx.at>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
References: <BL0PR11MB29614F8BE9B66484A478F6F4C72AA@BL0PR11MB2961.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <BL0PR11MB29614F8BE9B66484A478F6F4C72AA@BL0PR11MB2961.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/13/25 5:43 PM, Livingood, Jason wrote:
> Hi Paolo – If this patch series is delayed to the next release cycle,
> what release number would that be and – more critically – what would the
> timing be? 

See:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#git-trees-and-patch-flow

net-next is open now. Patch need to be re-submitted and will be
processed with the usual timing.

Thanks,

Paolo


