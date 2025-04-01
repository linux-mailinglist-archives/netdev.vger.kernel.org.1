Return-Path: <netdev+bounces-178525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 631F2A77719
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD8C1644B7
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 09:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708B11E1A16;
	Tue,  1 Apr 2025 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FC47UPsP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E2B2E3398
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498116; cv=none; b=b/a60a+TOHrFhFpKurFWzDrgNpi73kah0OQ6f+T5lrdp54zjtGg43zUSVEZ+JnP+nmOr4/Td2U9As0fN5I9Cic15eSRGGYK6cokPASztusSpEx7/M9qKAqk+tjynd+pTg/95Z0HozVVYYR1pBVQprN6P0+XOtsoP5Xqc52CLBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498116; c=relaxed/simple;
	bh=Alm/NQeAVgEcuh4ciLphCWPGTw4jKXnaMg0KD3XqiG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbXycEy2frh38lYZiV+DTEKAMJxdiP19gdsNLA7fGgzRz48gyCjLV3ZAZBnlMnhgJZCxgjLDvoDe41xbSB4T548/4Ya8cnvlSWUUZ5APdevHzsluf8/G2ZuHWJSOG8Z2OdFg6R6Dztl8Q9T6Q1hw5JmcTpVO6V0P7EtjNBO4xYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FC47UPsP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43690d4605dso35882615e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1743498111; x=1744102911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n46xaXN7gcanzSsfM8jO0yQceE6z1/lxfQvp5svqoQ0=;
        b=FC47UPsP1GD68VpPMrHCBGo7l3jyAbIpfdLNJxDHe5XmhgHcLTCQMfEWEgkCU+ZOuy
         HcWeHRptHSuu37UuC/IzrCovnGSeMb/PdKAvBVCljenjxbn/S6H/KcDeaqTVMhtEl+EJ
         0SVxlwRjZx+CAN7I8VO24MMj61CZ1RLl0k0nLoNn+pE4qe6tFBEbWyniwYgeaqJ5jxOs
         sck+2oco3FrWDYrq62j7Hofr9yxCU4Il3KZxrjRHoTeF3ZKUmrMlmV0tQb1J8n3ZDiAg
         i+n9AY5M0PD0d5Vrroj+N6m4nnm7kppfhbsvuULUdr8LDV+C5W2Ep6yUOYxtz0gPDgLw
         Ck2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743498111; x=1744102911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n46xaXN7gcanzSsfM8jO0yQceE6z1/lxfQvp5svqoQ0=;
        b=stpiIDy0Hqyhgy4HcyKjya82ZpFR+QfVHjiSJ0zh/tR+S7s3WU5jbOsEKgdSzKIX7t
         1L/I9BpBsjB5zI8OnHUTZailVRYyKHLp8HFzIyNX9A2SiBdTJ29qPNXAmjmpKHShRtCM
         X6rCBUDo19cMpq1V+i9iBHdk6YgUjDFWm/Trrvay2fnsHwU4b5tscXJN7KiqFufrgr+j
         yLvqPZbMPzQQeJJ52l3ja0VkV6Z8MP+0oCPL8BkKh9jpY2aSNqReBeMt9/e7Rw+PxjC8
         klSQzAqOArmiDk6cz0hcSuD9MGajnZ/o8aut5QTarNBOCTp6o+b+Js+nT1OQCedPerkQ
         geXA==
X-Gm-Message-State: AOJu0YwLHYfWAUs8170PePCq3aoYDnPKoLwDl2uXuBSUKzrPNtEAJrjy
	Nr2ncixdAJt0q1ZfhPXKEtfG6AEVyLgksudA+QCaW+tX8ZfrK7X/HGNGFyIiI+A=
X-Gm-Gg: ASbGncueYErGWByQBlJ0izsrdHWjkJ9eXKBxN4OYI5ITT4ofzmnIyRSJ88Zw16wsBPP
	hb1DoJvg13Dp36y9MxqppSWCWx3ih72ozbZzPNl100x7u4dnK3NfPGH5/tVC+dWT7/RmUGfGePb
	EnimvF8EhIXoWVyvzNce8W/akc2lucZxBf0RtOD51UC0weTjvUMnTt1lclvf88xGqKNmCIK/JaD
	uQ7+VG0etYb5GAxJKexBH2rYb4rtTw1XF7TRk4oV+6B7Bcmu7fqi8dsEWwD277LItXXLYO93KGW
	YJ0jg+7TQoFo17Vqpgh4BfF6ZggONYnTyQ/a9GwAr+Qka1Pv7TSuahC1TGKZpfGQld7okZhglON
	BtxGHcO4GUp4=
X-Google-Smtp-Source: AGHT+IE1pFZ2aeS5F5KYmjpz6vDu8iHwL34YVovaKWqffWU7tAc7e0gqKeEeofXyr3+FSdvuytsgWg==
X-Received: by 2002:a05:6000:43d5:b0:391:29c0:83f5 with SMTP id ffacd0b85a97d-39c12114dbemr7535395f8f.44.1743498111310;
        Tue, 01 Apr 2025 02:01:51 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66a9d2sm13540606f8f.43.2025.04.01.02.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 02:01:50 -0700 (PDT)
Date: Tue, 1 Apr 2025 11:01:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com, parav@nvidia.com
Subject: Re: [PATCH net-next v2 2/4] net/mlx5: Expose serial numbers in
 devlink info
Message-ID: <qt22pagi3weqc2mazctajndd5sej6zmvr3q4sq25r2ioe2qaow@parw3mavhvji>
References: <20250320085947.103419-1-jiri@resnulli.us>
 <20250320085947.103419-3-jiri@resnulli.us>
 <20250325044653.52fea697@kernel.org>
 <6mrfruwwp35efgzjjvgqkvjzahsvki6b3sw6uozapl7o5nf6mu@z6t7s7qp6e76>
 <20250331092226.589edb9a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331092226.589edb9a@kernel.org>

Mon, Mar 31, 2025 at 06:22:26PM +0200, kuba@kernel.org wrote:
>On Mon, 31 Mar 2025 15:06:18 +0200 Jiri Pirko wrote:
>> >I suppose you only expect one of the fields to be populated but 
>> >the code as is doesn't express that.  
>> 
>> Nope. none or all could be populated, depends on what device exposes.
>
>Then you override the err in case first put fails.

Correct, will fix.


>But also having two serial numbers makes no sense.

They are serial number for different entity:
  serial_number e4397f872caeed218000846daa7d2f49
  board.serial_number MT2314XZ00YA

Why it does not make sense?

