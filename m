Return-Path: <netdev+bounces-180746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDCBA8254B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC03F8A866B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0DC25F7B4;
	Wed,  9 Apr 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVvU07Xs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149B25A2D1
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203068; cv=none; b=QD7bfR5aJBHC6XRmQqMl3q05aVm8loYEmUY7NBXIZf3DfR5ph0ywHGMmS5At/lmR6PTFl8Gk0MS+PnqfFjSAiKsFKWUFbGehCtE6ebNcRRKu/QGM47e865gLlcgTk7wxY4FqC55h6/t8ChE3WliY+kKXHO3HQF9rz8l20i6P+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203068; c=relaxed/simple;
	bh=HhtrwrJTl2aOShQxODzQiLYaYZfgYfcyI9BdWNhn1ys=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=h4UvkQaZqo3r1b+97Qpj/8Bto+p1beu74kSa66UGDmywFAcEzoXx9ORlVTMnq1ni5fMuW7g0G0pLlSVgM/GZcSmP/GpC9/R4dyFphMna+1U6XPNnjxY3qymQTXSVZnVI2YDS7YpKqxUL6w2tLOnvrdBcOTN7isl0yrQx31UjKhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVvU07Xs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39ac9aea656so5666630f8f.3
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 05:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203065; x=1744807865; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O1RhyNyJy+45aoqKK3YQ90Im3VcHkyPjJzzrYSfSsLk=;
        b=CVvU07Xsygz0kgROwDheC7s6zr4aIlRsDQPv7P7bSIRTE9VXiRhEb4+p9eVwWxvyFG
         HbLrTqbwXzcwIN2nfX7YGSXwxCXgp2sjbnbWH5N3P1365ehuZ6YJlrhZ22U6JJWe7KP4
         oP/M9bb+JK0KLNxkn4C+FM8K7BZiwDpoXczcqJ8F+PdqCGkhq1XihuLMj/S0GQfsabAP
         xPpg7c0JMzjRNaGbz8Ug8ISH4bhQCCCj7lyGutcGbUI9Qb8RVD6g+LSYhSdg8z7zNAFx
         9ygB8DcWassyceLl4N+JTozbqDznpN55wu4hj9ax5YQ5W31a0GT81JqGwUfWk9UiOfgT
         Joew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203065; x=1744807865;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1RhyNyJy+45aoqKK3YQ90Im3VcHkyPjJzzrYSfSsLk=;
        b=sNpp8Wm8QFzNUg19MhQzw+53dJ1jgJLHVepg7AeaVa3ETiI/HMVMllPX/oSgdGr3V5
         W7rY3JS8+0MaJgYRhEiXfz5e/BA00dtM+R78A7WjaX94x1HirsJxtiC59MtzLrHJJo8L
         nFUH2J7X6fbsTEfXftYt9aix7YwJm+PsZllR4XbSIvGszT7i6tt1W7ei1piRpkADINKq
         ZmucJ4DVxPSB2/V4zp2IB+3MnfFTbNwlImYIASbnHvoBdK28FTonPcamJDIp5oS66IVg
         /94cfk6bA4m7Vviy5Cp+3QjkbeFJS9/KyLO9l5mt9agcDB+H4WEOuga9UyBgQnUD92aI
         UQjA==
X-Forwarded-Encrypted: i=1; AJvYcCU3N0kqoyAXCFcp5807dRhXMa8Gy0sv8MYu2ifQTTczWKqvQHFcVo6V1cLlFq92OEqNtXIxJ6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkoHQrr1T/z9Cqn+dkpGnRx1Xt/HTKQxBfhNsDkISlLvdxrtdC
	IBUAtsD5v5Wz1+dacCe5x9at0AuKWVTIHXDtgIG4V/2iujT52wkn
X-Gm-Gg: ASbGnctJ9aJp/RlARfEU0fbDJB+4VX5EKRXAwBsF3Bqo7YDiprPldkJsQnGZzVCvWKT
	z4Bsrj2mXtOo3IUylnVYrVbwqTrPykLTqae37z1Y/6TOCJLtcyGXcJFd+jwQ7DYYXlLGMIk7QXN
	XAKnzQWw4K1qMhXm9XnIg3bQ/WznPlKvuczKIEinp85s+5hZgYEDjbtcN3zvvW0cnNWfLWzv/hs
	T31pSama3fnGiXU3yGxSJph8lKpRYIO7+1/K6RilPv2043P9ta41OZiKBQQzZTDPXXPvFUzWN3H
	msRWb0bT20oW3YDI4F6mbggevxhAip1iWAg2dPdaR8UHoB6SH6PZUw==
X-Google-Smtp-Source: AGHT+IFy+foacjhI+R8kULcerVoKmzJwNHo46TUbs9RPWYieQWAPm8oQLkLZlnQRgzkRd9Il3C1GnA==
X-Received: by 2002:a05:6000:250d:b0:39c:cc7:3db6 with SMTP id ffacd0b85a97d-39d87aa7edfmr2484475f8f.19.1744203064770;
        Wed, 09 Apr 2025 05:51:04 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2c7c:6d5e:c9f5:9db1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893f0b76sm1553958f8f.77.2025.04.09.05.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:51:04 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  <davem@davemloft.net>,
  <netdev@vger.kernel.org>,  <edumazet@google.com>,  <pabeni@redhat.com>,
  <andrew+netdev@lunn.ch>,  <horms@kernel.org>,  <yuyanghuang@google.com>,
  <sdf@fomichev.me>,  <gnault@redhat.com>,  <nicolas.dichtel@6wind.com>,
  <petrm@nvidia.com>
Subject: Re: [PATCH net-next 01/13] netlink: specs: rename rtnetlink specs
 in accordance with family name
In-Reply-To: <92cc7b8f-6f9c-4f7a-99f0-5ea4f7e3d288@intel.com> (Jacob Keller's
	message of "Tue, 8 Apr 2025 21:49:06 -0700")
Date: Wed, 09 Apr 2025 13:15:42 +0100
Message-ID: <m25xjd4jkh.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-2-kuba@kernel.org>
	<92cc7b8f-6f9c-4f7a-99f0-5ea4f7e3d288@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
>> The rtnetlink family names are set to rt-$name within the YAML
>> but the files are called rt_$name. C codegen assumes that the
>> generated file name will match the family. We could replace
>> dashes with underscores in the codegen but making sure the
>> family name matches the spec name may be more generally useful.
>> 
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
> +1 to being more useful to have the family name match the spec name, I
> agree.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Agree that it's preferable that they match, and that `ynl --family ...`
searches by filename so they really ought to match.

I'll just note that the genl convention is underscores in family names,
if you wanted consistency across all families.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

