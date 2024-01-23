Return-Path: <netdev+bounces-64927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73962837E1B
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 02:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754D72855D4
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 01:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79FA4EB52;
	Tue, 23 Jan 2024 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb2jmQbZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523A84E1A0
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970374; cv=none; b=BV4eMV54KPIlrX6guPEnRiVOOZqRh2Gi5RhHY1WYA/tYNvX8kK7O1ZMAxcehEiqTgs4au7lovgR9c1a0QQ1lvr3Wg2Z7L7lpJOyGm4U7c9YB93eYlojXeeMiT1V6pL6qsgtjhuAZVhIUxOUiBUxtDvP3Jsadrf9RvNPF1n4zk3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970374; c=relaxed/simple;
	bh=6hVviq5rdkzhZ0VX0A9g6kZikKzFJ8xPgRag8puiNhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUvbmAMSOB/a9QPaRaHZT8JfX+IwDOtZqBi3Ujf3v42DgK0CYv0Z0ZuW7M/DNdqKRWKG3rZgZZivUxMXleqbK4H2cR2SRF6pWa1QZMnAjuzuUieXQaPOQ7aOAjXiAgDNwkx+fKBQ8ATTMaAGZMsXmlcY3S++MaDli37ySDSviKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb2jmQbZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3392b045e0aso2162493f8f.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705970370; x=1706575170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hVviq5rdkzhZ0VX0A9g6kZikKzFJ8xPgRag8puiNhk=;
        b=bb2jmQbZYOF6yJYv7NO0vWtVTZWuOTqeOv9z1ENAwbAiq5kED1tSrdy0lLnwk5lMFv
         /92CB+z2jXsAfoDI9kOTzukdhNMHBq+SnRW+cMYS0E9zBN1IKGa2Nd2XRa6KXsycReQz
         HeMtDpbCwEz5bNz/Kv+tGX2Xb/zi7P3ohirTpuxnfKSaP8+05pCSFxSnfBlabWX/ioMi
         DIobcmtqxFFqQErBwd3car7yb3TUBcF4l3otdLRlDu641BpW0asZ4zVWfrfwNKdgsPoW
         qHWNcpyHgTy1QzDTwMFZdgHfQKKvG69Yf4w6sMQYe4NXL8Gzq5qRTPFztkOyh4Y2Qt86
         dA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970370; x=1706575170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hVviq5rdkzhZ0VX0A9g6kZikKzFJ8xPgRag8puiNhk=;
        b=Yy0d0B4Nazh/3NFKI1YWo0bCDrgFpFy5/2HrYnYY+ClhVmSRnh1QlpynFMxgBVCW5t
         hjwycbgim8jiBIVMmMqtnCXZviw4NdEn5iLInZ/qeAcIRGPdge1oas8rogFM4c0zZnRp
         tpZVhsy7ysACc7/6y/SdxOxDW7oEvD7PuTm8EsiaWQMoxBVdvMN1+0uoOzdE6+spJx5C
         a4qU3EQO0TnAHHb55I8tmkYCTjZ7e9yO7MUtdy48A3MBrM/T2hmXyS21LuOMXGF6xjXN
         ExBUsHtdtPKYWqr+qt/zG6JXhWvpD38Qmju+1UF6GoqYTdaDEMVq5utjgPEjmyR1J8cM
         Lgrw==
X-Gm-Message-State: AOJu0Yyp9QFwgWXR+zcQLE/40lDLdJulxoQpGTBqbJ9Ol153rlJE4Yu1
	/fKI9BiYJnKlF/oU1OtsaeA8YKtA/WSywP/W3YRVdCYJSGGE0gwB
X-Google-Smtp-Source: AGHT+IGX+pd+TFkkuH5rqf+oDLhIT6kgX3RnbhesTDeaLavCmvMnDqtUU7NJID9ppbB2KYUWa9ihCA==
X-Received: by 2002:a7b:c8c2:0:b0:40e:5659:fb0c with SMTP id f2-20020a7bc8c2000000b0040e5659fb0cmr36285wml.165.1705970370319;
        Mon, 22 Jan 2024 16:39:30 -0800 (PST)
Received: from ?IPV6:2001:b07:646f:4a4d:e17a:bd08:d035:d8c2? ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d4e87000000b00337d56264d4sm12013220wru.8.2024.01.22.16.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 16:39:29 -0800 (PST)
Message-ID: <1cb1ec44-cfa1-4736-ae8d-3f33df27df3d@gmail.com>
Date: Tue, 23 Jan 2024 01:40:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] tools: ynl: Add sub-message and multi-attr
 encoding support
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sdf@google.com, chuck.lever@oracle.com,
 lorenzo@kernel.org, jacob.e.keller@intel.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <cover.1705950652.git.alessandromarcolini99@gmail.com>
 <88580D1A-7F70-4598-8E2B-18A85174EEF8@gmail.com>
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
In-Reply-To: <88580D1A-7F70-4598-8E2B-18A85174EEF8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/24 22:43, Donald Hunter wrote:
> I have a longer patchset that covers this plus some refactoring for nested struct definitions and a lot of addtions to the tc spec. Do you mind if I post it and we review to see if there is anything from your patchset that is missing from mine?
>
> Thanks,
> Donald

Hi Donald,

Yes for sure, post it and we will review it together.


