Return-Path: <netdev+bounces-215679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C88B2FDDA
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EA0176DDA
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FA91DEFE0;
	Thu, 21 Aug 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUR06Buz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6DA2EC57C
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788531; cv=none; b=cjdcSaO+ffrIHhT2UtT7fQMfALVuavHoDoUah2+2xdJRsVkUHYkwQ7HJHtYHNKhyPdXzgveuFMAGMScwuBh0AYkJkOFUecOq/Dll1Dm8gLLo59dkrUc95xaXaYXhNJEC/Q2tYHR2nlZtLmixdCdVmRClCNUYx+VXr9/aCafbO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788531; c=relaxed/simple;
	bh=Q1R0CMc9mJlGf3babIixDfaWYUexWKFLtG0auBCl0yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdOpqScXj3Z6A9zWYY1SF4mOh2fgYokYAjqjkhTXRmFiBaiubdkCxCq6Dk8ABOoIPml/0DWht3BCYfqL5JCiIcaBw3juJqCRa0fqc8x/QNYGbfCE/TC4ogfNiVAH/039OhWvXejd1Z1OQPH6kG2vghf+B3feiuOCOIx92vyx4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUR06Buz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755788529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeGF49xrsvHxpIxRGyeOUTffjJ2buyuXBi1SnFQwl50=;
	b=bUR06BuzAPmEh77KIBTWD8/ipTdcBJ+AfLmTuzkbb8jzxSKEZyQkTZk9GmesKCCF9yUgPX
	MilLWTPg+RqBJywC6GCpBmodVgm2mo8IA4LX9d/DPDWXqpVyzH3eRghpWA496YWvemHkKu
	D/cbK90YyCSFMRCGld+QoxVTiFPInRE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-n8XtD68oMg6tdg0UHOeahw-1; Thu, 21 Aug 2025 11:02:07 -0400
X-MC-Unique: n8XtD68oMg6tdg0UHOeahw-1
X-Mimecast-MFC-AGG-ID: n8XtD68oMg6tdg0UHOeahw_1755788527
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109765d3fso23405321cf.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755788526; x=1756393326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YeGF49xrsvHxpIxRGyeOUTffjJ2buyuXBi1SnFQwl50=;
        b=opPNPqs4zeZ5P5FdH1fNR91NkiLcDU2oMrsO1lsdhaiFOLaoSuaNAmTny/GjDScqkS
         HDrk51qtDnQ5tPVa4zq96AisSW8baQcPHDmsUYS5mlTFW8/1rmyU1CllS8BbsHmkQ5Cg
         zzAW7ihTo8Gyhe8/CISrHheS83aNCN1h+yS2SQdzF7DXyme00c2UI9zPnHimAbHNhyg2
         hDEVWIJkI53pEJ1qf/Cy/lXwWz4hhrDiYxf6WBZxjPQE0oQFuYCQKtWXX57lU1ZIhTS0
         Hw8E+b+pAjqvtspffL2ykO0Omccb5V2gua5ERZR/6TIqkNhHjT+eW8/ITWkXh6yOoNOD
         W/YA==
X-Gm-Message-State: AOJu0YyXRewlnJ6rXkBOLgvcIkEeUjbk5pU7J7xbcaEGa1W5ExLH6Nzx
	rIo8OHEuJjGA2tBndA1qk6dSIBQcupQW37TegyX5V7pofJ9LloFTsNXfb1+CedZDaFlS6exL9AY
	IloEryt8VqlCnKMlVZOyH7xNX1Zwo8O9zohj2aDJ3DseKCo6+ZexZiBsqUc8qmMiAJg==
X-Gm-Gg: ASbGncsaGbOmnYUAimFF2X83uhc7y52J6zSc+/Js7m9cq4UXy6vUtuCY4tnHk9yJnkw
	jTIPJ4flApGWy1r2ioFXdtSXfVX0fQ8hXkUd8vzvwpwQ/b+gqpFFUIghECSXW0f7jepvixdgIJU
	/lm6xcwP4VaZ/n8lk9weWnwedpMs4bf2Z/uVOhOkGovVPPWhUa2WgxlJXJ5IUxR1fzLQ1uIU4sc
	yy6zsyuW4QGop8Wb1OrGv/oZdnUqf9kBz6Bm2t53ly7Tjz+F9eJNvxJaObbW/4yIjrVx5aqKa8u
	ZTwMzJSgDuBWQA1fEVHOhRc4N1Ff72G4KdzGsr+EglvFZeLgjTlH2gd2lCph7MbNyNjG1DVnLmS
	X1jBnjfzzjKA=
X-Received: by 2002:a05:622a:258c:b0:4b0:e92d:78e1 with SMTP id d75a77b69052e-4b2a03d1480mr24272971cf.15.1755788526206;
        Thu, 21 Aug 2025 08:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1yTqUmEeV1YEtObKjQ71P70k0K3dK5xIY+TNMHECNzT6irjNTadrArKELPuAe0Vb2jDE6yg==
X-Received: by 2002:a05:622a:258c:b0:4b0:e92d:78e1 with SMTP id d75a77b69052e-4b2a03d1480mr24272011cf.15.1755788525372;
        Thu, 21 Aug 2025 08:02:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11ddd6947sm104428351cf.36.2025.08.21.08.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 08:02:04 -0700 (PDT)
Message-ID: <457036b2-cc6c-45db-98fb-3967c535402e@redhat.com>
Date: Thu, 21 Aug 2025 17:02:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] eth: fbnic: support queue API and
 zero-copy Rx
To: Jakub Kicinski <kuba@kernel.org>, Taehee Yoo <ap420073@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, almasrymina@google.com, michael.chan@broadcom.com,
 tariqt@nvidia.com, dtatulea@nvidia.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, alexanderduyck@fb.com, sdf@fomichev.me,
 davem@davemloft.net
References: <20250820025704.166248-1-kuba@kernel.org>
 <5bba5969-36f4-4a0a-8c03-aea16e2a40de@redhat.com>
 <20250821072832.0758c118@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250821072832.0758c118@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/25 4:28 PM, Jakub Kicinski wrote:
> On Thu, 21 Aug 2025 09:51:55 +0200 Paolo Abeni wrote:
>> Blindly noting 
> 
> I haven't looked closely either :) but my gut feeling is that this 
> is because the devmem test doesn't clean up after itself. It used to
> bail out sooner, with this series is goes further in messing up the
> config, and then all tests that run after have a misconfigured NIC..

Possibly I was not clear in my previous email: I suspect that the
ping.py issue is a real one/tied to driver changes - even if already
merged ones and not to the pending patches.

/P


