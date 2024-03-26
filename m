Return-Path: <netdev+bounces-82161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B7088C8C2
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BDE1C613E6
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2458F13CA95;
	Tue, 26 Mar 2024 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAJlTuXC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6733713CA84;
	Tue, 26 Mar 2024 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469664; cv=none; b=nMyJlkp34jRDJJiNYqyxBKqIeaoEm4ddrrnsKM0M4CyCOZAyVklfaiLQYISOz/9V2krFM/RVfb1bQySX9o+Tz+/QQph0PhINFwwRcrEaVFWq99K44jsdPUzp5y/HuM+lxiWLyrx3h96Gpy5uWNaEFddo3m1VpDvWFDcZfrFyDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469664; c=relaxed/simple;
	bh=g1hvV1d2dXHtN/u0tKCdBM+p5XOCPKbiAdtSV3yAR7I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oORDBChuD2XeTIBhLn2j8zlxTMneupccFmI5EBGXSmZIVDBQ+942t8Co18mPXbDcBGCxJsNS2Obo4l25IxaYT9IOcrFHIg//j+UZ2b8GNW10mLThD0eUEKozzAGeMvJ9NZqgkI0199z15ayI5LSKfsMX6kiYVeTOqI4MBTWnNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAJlTuXC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a466e53f8c0so753959766b.1;
        Tue, 26 Mar 2024 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711469661; x=1712074461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1hvV1d2dXHtN/u0tKCdBM+p5XOCPKbiAdtSV3yAR7I=;
        b=XAJlTuXCJijeuTZ8UEZNIFtjLdFzzmv8eMGU1Gt4+zvHXKDHEEB7HPBtIlsOh0A32Z
         ENTbTu8Fwp4fCd2ZXKSfT7QNHglUllfBiOH2NUM7LgyUc8g41qjXJpDIVI+Mg+uvXyBJ
         jVK1RIfO0reFmRq2DGK5HAq4NtCCKZq35BuSP3gn1JcE1datNGHgstsfj5P5P8JkMwf+
         Bh28PG9cArHk3AYemfqFsESpAraXx5BjFezI9XaFvSGbYw/KeTlAOj6EX18u3+8s1vYF
         kW9e9qqeTfogafNWIgzmowdt6jQ+nyiSdZUYoaCZGXe1lIEA7/kLkjdXObebFEiaSjPZ
         OfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711469661; x=1712074461;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1hvV1d2dXHtN/u0tKCdBM+p5XOCPKbiAdtSV3yAR7I=;
        b=BRtEzrC6VJnQ+nCtWct6yQ9QZE/5XqEKxUjj4a4NuhauOFLVSxWBAmsZfGPSQ6J8wS
         PRJJV9zycRDewgOnrH7UmGjkxFi0Jh+2JUvAinWwetZWdZJgMkxB8eK9e63EbZ5KtHym
         Rj+2tcI+O/hWIyOE4gbGMf3yxC4QpgFGYMd8zbOIOO/BoxGB2V+t0wH36vTEi1058a/H
         X305KuuWm1AfiLsoKMXrr2K4J8lbseIUJIXN2mKCj0J3Myk4UF8+BXKPnJ30MCSf4Px9
         Uf9z/p9aYWFmtMg8HL1Y3D6QN/+5Vtxib0rCHUEu6Bo7aJ/nd2Lcc+zdO3QwY4ICvXMS
         EMfA==
X-Forwarded-Encrypted: i=1; AJvYcCXpddvvhFkBLg8nYVgb3JPaZx798700ML/X009zr87PNAVSvwjHiKABZvMtSsaLbQuNsaoinhY7fX/Ab4RCVtvwWdoo2e/Z7l3oFwDvd8lTpb3NqVmYFJdQRNWO+NGQpW4yig2Q9oLFTHs/1hT12EM=
X-Gm-Message-State: AOJu0Yxy3Ra/0cjRdz2WngKDLOK6BLdDg+MdLamJoKQ/Rjrh1Hikwotm
	5itmT6euajnVBlny5mRP9QgRN5OBvyHcOnSXYkyAoYY5Suf2GHbwNDrBafpf
X-Google-Smtp-Source: AGHT+IEBHNqiFNYb5r3zugJqGGFXAk8fpm4CwmGW4Q9yNXdjIGP1N69XV/RnbJNf3VmpaZYb38pWAQ==
X-Received: by 2002:a17:906:ff52:b0:a46:da28:992e with SMTP id zo18-20020a170906ff5200b00a46da28992emr6689946ejb.71.1711469660563;
        Tue, 26 Mar 2024 09:14:20 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id y4-20020a1709060a8400b00a46bec6da9fsm4338142ejf.203.2024.03.26.09.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 09:14:19 -0700 (PDT)
Subject: Re: [TEST] VirtioFS instead of 9p
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org,
 netdev-driver-reviewers@vger.kernel.org
References: <20240325064234.12c436c2@kernel.org>
 <34e4f87d-a0c8-4ac3-afd8-a34bbab016ce@kernel.org>
 <20240325184237.0d5a3a7d@kernel.org>
 <60c891b6-03c9-413c-b41a-14949390d106@kernel.org>
 <4c575cc7-22b8-42e0-a973-e06ccb82124b@lunn.ch>
 <20240326072005.1a7fa533@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <c13fb57a-be40-e10d-0c27-1ceca2d25344@gmail.com>
Date: Tue, 26 Mar 2024 16:14:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240326072005.1a7fa533@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 26/03/2024 14:20, Jakub Kicinski wrote:
> I couldn't find a "please run this as an interactive shell"
> switch in bash
'bash -i' appears to be precisely this, and causes bashrc to be run.

-ed

