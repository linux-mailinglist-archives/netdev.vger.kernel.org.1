Return-Path: <netdev+bounces-79435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04BC879330
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31281C218E9
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527DD79B7F;
	Tue, 12 Mar 2024 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7Xi4doz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D31679B88;
	Tue, 12 Mar 2024 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710243592; cv=none; b=UXGqoRoy83LFoBjwTZQ2L7RdwmdlSFgN0xkg/is6MenIb/9r2W/x7rbo7DA7oD6v6NZPIGTs+gPmK6QGbWdW1R9WhuxWnrnSez9AVjoZ+Ozm8/pi7xW85E4MTRPf4G35kJr9+SBoz3FE+KqmEfzclxzFW1XLDt+WD7VxvedXDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710243592; c=relaxed/simple;
	bh=kmn47PjIzR/ky/MylPma5T02SFEFUmtYpRq0lKTAiBM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nSPv5ixxAh1+T+OaT+EvDa7CfgNxHgOYLj1ps5kLmoymyLMoVlfqeU6OIY4lDmgwSucxyPOHpUxcLWRea/OmruRDbK5mcuL4mF8jEEyVPkjnzhH7zlRtt+snbY3h6Jx7rPPpgYPHp8nCc1mhjfLy19rRplgo327Q3VhDEkk8E7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7Xi4doz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e1207bba1so3057770f8f.1;
        Tue, 12 Mar 2024 04:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710243589; x=1710848389; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02lCA0MSv28asgZut0YsYn3wWri4elbaoE+v7i1YFLw=;
        b=e7Xi4dozGJ10MgpdFNHRlwHO5UmRDbCAt+beUfNDnLA3D54Jd9aVBgXbFgt13ldipQ
         13C+WPdsYgDD5+6n2Zo+Rok3CNO0VY7kLH+tAUNOhonwo6tvf3iaMx+er2l1a6oRV4Od
         4Kbn1jIAxns9nYnLpgISMTozQHmfaybYMur4HznJJAuO6EPuslVe6FOrO03g0Lyz6BM0
         U27JXDTXPtcvHfNKnCW/gu7BwqFGOSouFgi9q0ajYrJLW6TCTgrh3TFa6pLrIGPrLven
         P2nRjAm4VISBKzgiEoM2Q5jIRylYZPi1+ww+0EUC9WdH5CNQz9N75S/637b8sv4uHr1r
         ecaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710243589; x=1710848389;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02lCA0MSv28asgZut0YsYn3wWri4elbaoE+v7i1YFLw=;
        b=TkAAzKBnYdzf8vSDn+L8HYaAJfMdTp44ef3p+X6V8DndDsVSOHCHctLqaH7AdTNtvB
         lDc+e96T8FprassyFMD4y3u3UzcyeFDThtIXkKUyczD9xvILs6wT3JKxQkFQMj51ZUeS
         xEbVVukYqxOJjSG2btViAOwzU6gm1EGFXLg/IOqhcseswltKEX4K7gMKKJnfEZ6uAdPi
         5n0C+bWaHPu4ZdZ5sM3KT3Piiz0UAZDopcl+aePppOsOxU+fBtZTCQVcRQ5SJaAkticg
         EbDdsYwUVznd+D/yDCZEckKKbsF+QfwO6keZmXvpRCNhlPVPNqijGQdeitq6jQak/AYo
         EJAw==
X-Forwarded-Encrypted: i=1; AJvYcCXph87stzGr/2qUMOzcW53zDCs/nRJksHdEnfpIg9hHlUAuGul7pGKMPydNRMCs6pgDHbkxpoX3Tkj0hbZYcT4OihvRFV46dcN41GNObd+UrAbU4d2azs0Igi1o
X-Gm-Message-State: AOJu0Ywyl3EYW9s5guOu0tle9ohUlvYlqT47LLXgj34D+MFOmrs9ja5F
	Or8ryFv2cyrKM9oy9Rx7ViIqClIySjEdC7yDhE2snPuiYhiF4kQY
X-Google-Smtp-Source: AGHT+IHQBl+UWKjLX3p5eZIQbVauEokUqAyym2VUlqgCqF0aL56whTuvCJzroBIfz+r4ZR3RxRvbbw==
X-Received: by 2002:adf:f54d:0:b0:33d:7ea3:5b90 with SMTP id j13-20020adff54d000000b0033d7ea35b90mr5799614wrp.65.1710243588701;
        Tue, 12 Mar 2024 04:39:48 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id l5-20020a056000022500b0033e712b1d9bsm8904129wrz.77.2024.03.12.04.39.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2024 04:39:47 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH net] vmxnet3: Fix missing reserved tailroom
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <5092d0d0c4b034e66645ffc974cf9d694f2bbb7f.camel@redhat.com>
Date: Tue, 12 Mar 2024 13:39:36 +0200
Cc: William Tu <witu@nvidia.com>,
 netdev <netdev@vger.kernel.org>,
 William Tu <u9012063@gmail.com>,
 Alexander Duyck <alexanderduyck@fb.com>,
 "<alexandr.lobakin@intel.com> <;hawk@kernel.org>" <daniel@iogearbox.net>,
 bpf@vger.kernel.org,
 john.fastabend@gmail.com,
 pv-drivers@vmware.com,
 doshir@vmware.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D33EF776-A902-43A7-82DF-7D7B43608EED@gmail.com>
References: <20240309183147.28222-1-witu@nvidia.com>
 <5092d0d0c4b034e66645ffc974cf9d694f2bbb7f.camel@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi Paolo,

Patch tested and work fine without any error.
tested on latest 6.7.9 kernel=20
m.

> On 12 Mar 2024, at 12:56, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> On Sat, 2024-03-09 at 20:31 +0200, William Tu wrote:
>> Use rbi->len instead of rcd->len for non-dataring packet.
>>=20
>> Found issue:
>>  XDP_WARN: xdp_update_frame_from_buff(line:278): Driver BUG: missing =
reserved tailroom
>>  WARNING: CPU: 0 PID: 0 at net/core/xdp.c:586 xdp_warn+0xf/0x20
>>  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O       6.5.1 #1
>>  RIP: 0010:xdp_warn+0xf/0x20
>>  ...
>>  ? xdp_warn+0xf/0x20
>>  xdp_do_redirect+0x15f/0x1c0
>>  vmxnet3_run_xdp+0x17a/0x400 [vmxnet3]
>>  vmxnet3_process_xdp+0xe4/0x760 [vmxnet3]
>>  ? vmxnet3_tq_tx_complete.isra.0+0x21e/0x2c0 [vmxnet3]
>>  vmxnet3_rq_rx_complete+0x7ad/0x1120 [vmxnet3]
>>  vmxnet3_poll_rx_only+0x2d/0xa0 [vmxnet3]
>>  __napi_poll+0x20/0x180
>>  net_rx_action+0x177/0x390
>>=20
>> Reported-by: Martin Zaharinov <micron10@gmail.com>
>> Tested-by: Martin Zaharinov <micron10@gmail.com>
>> Link: =
https://lore.kernel.org/netdev/74BF3CC8-2A3A-44FF-98C2-1E20F110A92E@gmail.=
com/
>> Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
>> Signed-off-by: William Tu <witu@nvidia.com>
>> ---
>> Note: this is a while ago in 2023, I forgot to send.
>> =
https://lore.kernel.org/netdev/74BF3CC8-2A3A-44FF-98C2-1E20F110A92E@gmail.=
com/
>=20
> The patch LGTM, but you omitted a quite long list of relevant
> recipients, added now. Let's wait a bit more for some feedback.
>=20
> Cheers,
>=20
> Paolo



