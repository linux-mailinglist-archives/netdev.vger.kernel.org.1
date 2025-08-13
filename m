Return-Path: <netdev+bounces-213417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A5B24EAA
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88FB9A4075
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1994127E1A1;
	Wed, 13 Aug 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYUIMWMt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD31F4703;
	Wed, 13 Aug 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100184; cv=none; b=selpaKoeYl+NKQbq7UTpzXB2o0hkxAMHOdGynsQ9QxnVsKsNtNRiYK/ifLPXfkCdZb0bRXdlOdOTbJ8HTKLHafUzwlWOomAHpF/IY7oHYPiOdsVWoXBas9GFTsOr9GkFwQA9cdzhCYJohrTcZYE9aa+kqEQx1SSWzT/7gXLL2CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100184; c=relaxed/simple;
	bh=CsYvuJxSVYzNNupPDsZKGz0kEZwDe4aG9Y9BcoWUHK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptW+IfW3XDx6/Nl3cchxHo01Jz2pyeQpvlic8ucYuFbF8LpjXVxC9zkaG/fcGQcQUkP3OHCF63gbA29lG/f+LniOfWx8ngGNutyoD4lja6tY96PwLYAyukn3XeSJ1s/U35vQLYiBeFmle0nRafUrEAU/doVetagyqYqhaxNhTqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYUIMWMt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b913b7dbe3so976365f8f.1;
        Wed, 13 Aug 2025 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100181; x=1755704981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1nl6t4UrYnJgiJX3eQ/5I9NfdeiMwCWkTmXotlRLfw=;
        b=LYUIMWMtLeWz4HClabbij1NUjyRAAiMVU7k+ErTNBkXiDADGrA0ENiCBLCJF4Wa5DH
         nZR6QU8h/rsWffy8ZS0zElQXLyXxb8bkdmNzGmZWpO9VBMSvtPyEZ4rbN/qjWTzCClFv
         IiBTpvWSvvaBwPVjB84XRsu1fFcHEFX4zzXIxZA2t0pBmMj0O3Dk+awWLdPe1Zci3/DL
         4jPlQtf/eg/9FkNo4ARvpmTP5/7GdwkiOgY3q6ZC5Zzv2QMAVlTdW8TjDaouO20+6/o4
         v0wiU5t/2xncj8JMTDwju7Qf/qFuqV6rm13uI7guWbVr4sCt+Pufj0lVAxZgeaPWy9LX
         kyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100181; x=1755704981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A1nl6t4UrYnJgiJX3eQ/5I9NfdeiMwCWkTmXotlRLfw=;
        b=JYSW6+8HQGhWKruGKwypDGzQ6zLJPWbQWpqUBZ87O/AHW3LysMgQIN6USXXjKS3NsM
         m+DIjOvQj3oA7DAAZrSvhFW/odMj+WfS2Yg0VSFXorNrV5RbTpxGVritYTZZdoo2TnRb
         z1Z+XPGNAyxRVVQmGA+BEo7g9KRzFhcgvtPr28XJ9l5n7PbtmQNMFKonG2c58zilyB5t
         /jggg+6RhgIqI6qPX3Y046lydrb2RBMvuf1DSqRFjvU7FmJ/6kHMCfKXbcRQSjPQPv+v
         WNW0WxMD+xUqelbl7tQ9NEWyumbiEpmvEekLQagpxwY4YDhTbcbVE+t1tJRs664cBKBe
         /mMA==
X-Forwarded-Encrypted: i=1; AJvYcCWHuyea4XH0AtFm0BJNSZZjRsf0L+jp1sXHqcRAa8BWfJTWH+TkU6SWhN6Mwj/G89AAqQrTL1OlIPw2SxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8yHLxS/viEYIHbdiyXbQ1uXFuCI9aa/rNKEGUNzp2BqMIEuBr
	e7w6+xUPKbF63p5yLrwQbmiGw7uehOoeWLd847TMVocUrN7bC2lajMMC
X-Gm-Gg: ASbGncu8dsyDTZOVi1gGaRO23HzZyCnmVQg//nIdRsNSRIerD5nYTvlr82+AkQgPsZL
	JAbM5SmUEG/oRX/vjeKr1laooomFi3R15whgpojFBpQZQE5j35aimpRb4/KDOpeqFae8/THluSr
	ZItK07PECt7tm1ag8AvReRl2E1a7fvvIAd8k5opZ2JvZObS82Hxs31jSQZbtKkNeA2+1rbLWaan
	m6YWwocffVWwG3s1aobjGGKhYPDPnc8tYkM0zKqxzuCGICvb3P1306YrWtrM6N8rw3ybcmv8rdI
	53ISGOjuEWYaswl9iaLFlj/ylUyuw1EWh1DxPl3Wk9nQbBoo0HkRAubbYibVmGTtXPUSz8cEBw1
	DSvPySXOtEkWrZgJuDGnSHf5EAy9B76yxOj/pPSJsDe5S
X-Google-Smtp-Source: AGHT+IE549XRhClWITeC14rDRnNihbIydw6bo0X/3sR1LQozFnF08n9/ldro8THKIenk544BUeHxcg==
X-Received: by 2002:a05:6000:4006:b0:3b7:9ae0:2e5e with SMTP id ffacd0b85a97d-3b917d24bfemr3048304f8f.9.1755100180598;
        Wed, 13 Aug 2025 08:49:40 -0700 (PDT)
Received: from localhost ([45.10.155.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533f1sm48530989f8f.42.2025.08.13.08.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:49:40 -0700 (PDT)
Message-ID: <1e8ba3fa-81b6-4921-a02b-1d6da756ecec@gmail.com>
Date: Wed, 13 Aug 2025 17:49:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 5/5] selftests/net: add vxlan localbind
 selftest
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, andrew+netdev@lunn.ch, dsahern@kernel.org,
 shuah@kernel.org, daniel@iogearbox.net, jacob.e.keller@intel.com,
 razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
 martin.lau@kernel.org, linux-kernel@vger.kernel.org
References: <20250812125155.3808-1-richardbgobert@gmail.com>
 <20250812125155.3808-6-richardbgobert@gmail.com> <aJx6pUrnRMnh0RAU@shredder>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <aJx6pUrnRMnh0RAU@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ido Schimmel wrote:
> On Tue, Aug 12, 2025 at 02:51:55PM +0200, Richard Gobert wrote:
>> Test to make sure the localbind netlink option works
>> in VXLAN interfaces.
> 
> Thanks for adding a test. A few clerical comments:
> 
> 1. Indentation is inconsistent. Please convert to 8 characters tabs.
> 
> 2. netdev CI started running shellcheck. I don't think you can eliminate
> all the errors, but some can be easily fixed.
> 
> 3. There's a blank line at the end of the file that should be removed.

I'll take a look. Thanks.

