Return-Path: <netdev+bounces-104725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771F690E221
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 06:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B751B20F5B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 04:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99768288DB;
	Wed, 19 Jun 2024 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGJCH2WY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E41E878
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 04:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718769834; cv=none; b=fRsp7mFh4sGTRw8DxI59jLA/3BHiJlA0C69IZn0Kx5+bSf9zksQWmzW5ZRrv2wEV+HQCd5N0lFWZTJD+GPp6SeF2yN245j1I+sowqFS/Ttt9nbNDxx4eicukb/XYghYrUvPIjnp3K+M49vP8KFiGAyvtwN8CzVhCvHG15jLEkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718769834; c=relaxed/simple;
	bh=d7BuDkYUlW8grqejeVbbEVp8beTOMu1zgJrd8pW+pFE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OuiQGUWQIC6FYEk4XEGv3IgC0KUumNfXnskk4fWE6wDnTjhivbQjMWgrcZPgUzRAWxYvy9c58fmM00bPYDruq/Nj+6eOPQB6rNK6dNpnFycMMm8poIJDgFWPItbqmWNl6o/eWPWNRUEbv5lTD1GUA0Fj/ubXr138mW1vSujYDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGJCH2WY; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3745eb24ffaso3438755ab.1
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 21:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718769832; x=1719374632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htPLG3WbVpAyRnKsDn3tVziFDj/r62+rDzXEW04s2II=;
        b=AGJCH2WYdn20lhtsXMLBJQD5DsMzNni/0ye2eQIQKIM0dZBrz301T9HCpja8KD02mA
         Q2jt6GbsQWdoYfkacSvo525zEmKAO2DLBVEcJLHrJ0nc/fLYcfFzmOQZQORW/7Yl87ZE
         1bHM/Ym7OnbwvYvTOU+cnngGeN0tq93TL/8lR0WwBsfzyLh17zlJpFFqVRNXjSS/qwtR
         ZzggM6R5yNZi80bNDUgKZ52aVQiYRdRumtdyLgF8BWhPDJrhKKJXitxSSqc0K6DKAWdw
         6oktNqNtOziGQvieE+gn5Phkmvml686f9Rx41sDL2vAQ6zBNoC0c5vvk9oo38Lw5Zo+T
         hIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718769832; x=1719374632;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=htPLG3WbVpAyRnKsDn3tVziFDj/r62+rDzXEW04s2II=;
        b=X3t9kQ1hiJYwnaDKeXMLQ3SX9UyNIhXtteScGR73LFitJU7duIQyfqh6wCCGIZoJe9
         b58mlwtFUzkeZNxFz6w33N8RwUFh/JL2x/8CmKBsM6WF9xKeLSOrp5wlhIZ6+Ic8Ppp+
         /1iJ3eS8vBLPpk2ACNu7sJhG8TJI9cy0V78L89o1gHCrFzU1YnGMYvOL+ClE0BmDmt+A
         6V78HZBtv/ahcWOKYJWvjyDMhfxDLL2VttQlVoJu1mEDDhgr5Me1XKB9CFc+uc8pl16t
         /h3w+8rqb56C2mA7MGPwosFr8BS2+Nu1iFzdx0g/NHy7QzRaV9OEn8yWnoiMApBuqCzT
         deSg==
X-Forwarded-Encrypted: i=1; AJvYcCUmYmpgNfC0aF/jYi8YBOrBSsnXH5w7IqJ/t5GuZXhgJqbeyrwI1GQiGfUEE1gO10DRynQw9bJguk5WG6MXb4W1uwm9ZV/8
X-Gm-Message-State: AOJu0YyDvEWD0fEBhey5LaYMBeBDszW9/XCOIEycEhlKyJEcdGRResEh
	AEwgDoh1cD8SEgXoyNyiEuXvS3A5xDy8XQIPDJ/1zf2G8qzdz/aj
X-Google-Smtp-Source: AGHT+IGU0t0ARiOzT7OJOHXc5Ylc/q1kHwDg3hNN6agkzOIT3Ejo0fBmyodYRSJsydG4NshZ2DGMSg==
X-Received: by 2002:a92:d5d2:0:b0:375:a48d:fdad with SMTP id e9e14a558f8ab-3761d70ecc1mr13647555ab.3.1718769832276;
        Tue, 18 Jun 2024 21:03:52 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-70a88cef31bsm3636762a12.56.2024.06.18.21.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 21:03:52 -0700 (PDT)
Date: Wed, 19 Jun 2024 13:03:37 +0900 (JST)
Message-Id: <20240619.130337.398996009719520372.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, hfdevel@gmx.net, naveenm@marvell.com,
 jdamato@fastly.com
Subject: Re: [PATCH net-next v11 5/7] net: tn40xx: add basic Rx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240618185210.3a7a5715@kernel.org>
References: <20240618051608.95208-1-fujita.tomonori@gmail.com>
	<20240618051608.95208-6-fujita.tomonori@gmail.com>
	<20240618185210.3a7a5715@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 18:52:10 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 18 Jun 2024 14:16:06 +0900 FUJITA Tomonori wrote:
>> +		skb = napi_build_skb(page_address(dm->page), PAGE_SIZE);
>> +		if (!skb) {
>> +			netdev_err(priv->ndev, "napi_build_skb() failed\n");
> 
> memory pressure happens a lot in real world scenarios,
> allocations will fail, and you don't want to spam the logs
> in such cases.
>
> In general prints on the datapath can easily turn into a DoS vector.
> You're better off using appropriate statistics (here struct
> netdev_queue_stats_rx :: alloc_fail)

Removed prints on the datapath.

I'll add supporting get_queue_stats_tx/rx to the to-do list after
merged.

