Return-Path: <netdev+bounces-95919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642D48C3D66
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D188280E55
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24608147C84;
	Mon, 13 May 2024 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZhbj6YA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E561474BF;
	Mon, 13 May 2024 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589558; cv=none; b=jsfv9ieurDn7i++YKM+kEINKUPOlz3ytw7FsWleIVPRYaRj6sADlZneEUOEfPr27P7eC/QnLgmaWaPXO3+Sh5DvRufEBp7ydk5zEPBiUdjjWK2RflpPY3ymh9HHyBJE0ipvrur9Ltyxj3ffG2sCyZ81JOtw5mfgSb5VrKfevcOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589558; c=relaxed/simple;
	bh=5eXSshADMMz2HS4+hYQumTpVGsj8NwwTPlGcAqN449Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=R8ZcWkI7zOE43n/PJemp4ZnV3wkWg2qeq+5wZsNgfk7WxBfzaL5xdXfGmMwMlkoyWWvdNvEthn0BKexRCCK8uV4HTfBlHx8tO5TzMH8iJpCz1KD/HuJaOrQDHpWbgsHHym+JAix2UOIBvyl2kbPX8vr1gFYH+lZB3PgWCaGhK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZhbj6YA; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c968f64cdeso1602060b6e.0;
        Mon, 13 May 2024 01:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715589556; x=1716194356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ByH4IXOe7meQgCOsgj+8mcZz2ctYq1wZFMn2SyMyJGU=;
        b=FZhbj6YAAjrQB3IbQN2YmunpzKGMlyqg27A6GA1X8qQwv0m+N9Mcugm54BwtHqn7Kz
         ZEyYPEw4CgzKJc71a1iG9Qlt10WvBnMa0E3TFuEKjgrdquYNvd9FXn6tj7MiFsk6jYcD
         CvyyGJ/duphBf96pL3cfWDKgb+2qxkr9Mvjgxdis/AagRjj1Wf1Ox3230+ryykmTv7Co
         PTzcLd186EKPUlBCzU/0pk0v21KnnLSW7filqbX6CBH1WevbBPrdRyLUx/SeuuhfqLAR
         CDjWLAT2qjEcCETYazXURgSBGqeUmnU4KnMBbEC+bnD+k43vUt7wZjIY/XEto1H1V8Nl
         4IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715589556; x=1716194356;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByH4IXOe7meQgCOsgj+8mcZz2ctYq1wZFMn2SyMyJGU=;
        b=gMgIk8pfSNQ+uE407b+Ao4ukAGai3IE9U565C0Je+XZNeB1CfuLKKPhZYpbXXTacia
         6oAM/JMGIbLeiOYryPMAg7C4AaooJ5qLM4YdaZGyEAIFZGfK5yu580C2eFr7g04ujhDc
         sjoICC5HEIIaVjLry7HkeJ3MNKJ0Sr5U6pM+Yf1vEAXoS7dgf28E28HvyCV+lIUUizBt
         KqjsTNCjmgOkvuqn1vjSS8KW0Khnzatz1a9tVOVBoIBh4D1ZBRZmHNCqUHLsrXFvCJaE
         keyMqywvNx4FWiXs0YCFM2D3prgU0jfcaqlSYWRhvbOA3ombGqJmyD16QS9KYeX9eOrT
         LljQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGK2mIg/1NgObBzx9T+nvCJC3vsFxIO3EyCWzmXABqdBfnHEBxknkT2ePrUdaL1CM9ukg51jtgfK4981YNThsW4YDSLng4
X-Gm-Message-State: AOJu0Yz66Fq5NioLrqmI3s9T7h/xHliNQ4YavqFxPhcSoIQNQEiPHWcr
	ippntZaft3+fJwZNm4ukHTXoGqbtelHYPhtooF7wEtkmHZqav6cjTxjXog==
X-Google-Smtp-Source: AGHT+IH6PuFjkJnoKBx1FZT+HCTTmOyft0mWTEdDCJWk2yAMPypNDdyTUqOIUPS6yaqMBz/n9DpUFg==
X-Received: by 2002:a54:4597:0:b0:3c8:665e:1e57 with SMTP id 5614622812f47-3c99706d302mr11862624b6e.25.1715589555774;
        Mon, 13 May 2024 01:39:15 -0700 (PDT)
Received: from [192.168.0.107] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0da1sm6899069b3a.107.2024.05.13.01.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 01:39:15 -0700 (PDT)
Message-ID: <4e55a37b-f225-482e-ab68-4ab4e839da4d@gmail.com>
Date: Mon, 13 May 2024 15:39:10 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pi
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Networking <netdev@vger.kernel.org>, intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 lukas.probsthain@googlemail.com
References: <ZkHPRBLlHJpRytIB@archie.me>
Content-Language: en-US
In-Reply-To: <ZkHPRBLlHJpRytIB@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/24 15:28, Bagas Sanjaya wrote:
> Hi,
> 

Please ignore this thread (subject messed up). I will resend with
proper subject instead.

Sorry for inconvenience.

-- 
An old man doll... just what I always wanted! - Clara


